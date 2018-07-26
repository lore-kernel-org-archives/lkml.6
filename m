Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6595C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5392220685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="U45Nbhja";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dAwP2nwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5392220685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbeGZNJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:09:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48196 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729216AbeGZNJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:09:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2840E60C4B; Thu, 26 Jul 2018 11:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532605985;
        bh=i/nA0cxHxYXlv6y5958riC55Pg7RnP9SAtvAQnXEDwM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=U45NbhjaTjWvROCKpsag4NkCpIMST7oTQjhraNKnVa4XSifXdf+8uuHSeFZ1u+dl1
         AFmxH99B3srs2gzDZ5d1UaZvNg2yEZNiGnksI+Bw2pR/tHQmeMGPY/1leG9x+J0S0V
         0qTMviPAwSg5CRRvro/Z4e3oKo83bW0bS8iqngWY=
Received: from [10.204.79.100] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4120960BEE;
        Thu, 26 Jul 2018 11:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532605983;
        bh=i/nA0cxHxYXlv6y5958riC55Pg7RnP9SAtvAQnXEDwM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dAwP2nwXvnAtJwa6229tZLbokPiUaRZhi26c4neMncxBoz8CUD12C7VQCaVjckGs6
         ejRMtBhhda9EmfiA+0gYn+p0/g8v+sGnbLDw1ehF/guBVxlEkXtCV56Ro5D67OSUHL
         Oz6gkM5g/Bjs5L5HlJ4Qk7oPLoEKL5M8uMb1dQSw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4120960BEE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v2] cpu/hotplug: Fix cpuhp_step name for timers
To:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Mathieu Malaterre <malat@debian.org>
Cc:     gkohli@codeaurora.org, neeraju@codeaurora.org
References: <1532443668-26810-1-git-send-email-mojha@codeaurora.org>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <1cf38a28-e95e-a8e4-9e1f-a83a6973436a@codeaurora.org>
Date:   Thu, 26 Jul 2018 17:22:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532443668-26810-1-git-send-email-mojha@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Can i get input on this ?

Thanks,
Mukesh
On 7/24/2018 8:17 PM, Mukesh Ojha wrote:
> After commit 249d4a9b3246 ("timers: Reinitialize per cpu bases
> on hotplug") i.e introduction of state CPUHP_TIMERS_PREPARE
> instead of CPUHP_TIMERS_DEAD the cpuhp_step name "timers:dead"
> for timer looks to be invalid. So, better to name it as
> "timers:prepare".
>
> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Brendan Jackman <brendan.jackman@arm.com>
> Cc: Mathieu Malaterre <malat@debian.org>
> ---
> Changes in v2:
>   - Updated commit text.
>
>   kernel/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 0db8938..8e6606a 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1274,7 +1274,7 @@ static int __init cpu_hotplug_pm_sync_init(void)
>   	 * otherwise a RCU stall occurs.
>   	 */
>   	[CPUHP_TIMERS_PREPARE] = {
> -		.name			= "timers:dead",
> +		.name			= "timers:prepare",
>   		.startup.single		= timers_prepare_cpu,
>   		.teardown.single	= timers_dead_cpu,
>   	},

