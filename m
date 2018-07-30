Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD4813F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3FD20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SQ6KB6o1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oqLnPaqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3FD20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbeG3PIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:08:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42262 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbeG3PIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:08:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5450261D8F; Mon, 30 Jul 2018 13:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532957603;
        bh=uFXRZDBFj+1KQiT8DzU7AxgLtNURM7oNuXS69CTRXiQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SQ6KB6o1I4aFKOsTd7y84wWqDpMFhBa3qoNeBWpVJYuxQ7NW2TDF/pY8NxzzbHJqd
         HKqfOFrTd641CJdcVahnGZRnyW9Kaskh9aXxWcNxmC9zIsQyEWFeM4gMaHeXi+O+JV
         8mA0PeEuGTS7SYQBbGnBpDL3TShsY5q3zPYpKqsY=
Received: from [10.204.79.100] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3722560117;
        Mon, 30 Jul 2018 13:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532957602;
        bh=uFXRZDBFj+1KQiT8DzU7AxgLtNURM7oNuXS69CTRXiQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oqLnPaqNJfCC4vdB6jRefOdmDmxZurik3kRJ1LeDU5lMN4vNWGh7Ei2kqqIqzIonb
         hMpvMvpDcurXDtY70Vvrb8qjWK6980OVg95NPc7CqilbY3kAEGEcAnhi0PhpJm1xJK
         Ich8svwuQ/GQKHW94jc7osWJaQL4q688rrm8aVMg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3722560117
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v2] cpu/hotplug: Fix cpuhp_step name for timers
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Mathieu Malaterre <malat@debian.org>, gkohli@codeaurora.org,
        neeraju@codeaurora.org
References: <1532443668-26810-1-git-send-email-mojha@codeaurora.org>
 <1cf38a28-e95e-a8e4-9e1f-a83a6973436a@codeaurora.org>
 <alpine.DEB.2.21.1807301411010.2518@nanos.tec.linutronix.de>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <08c9986e-f774-332e-9838-462921f5486f@codeaurora.org>
Date:   Mon, 30 Jul 2018 19:03:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1807301411010.2518@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/30/2018 5:49 PM, Thomas Gleixner wrote:
> Mukesh,
>
> On Thu, 26 Jul 2018, Mukesh Ojha wrote:
>
>> Hi All,
>>
>> Can i get input on this ?
> Sure.
>
>> Thanks,
>> Mukesh
>> On 7/24/2018 8:17 PM, Mukesh Ojha wrote:
> The input you get is that it's unprofessional to poke people after TWO days
> about a patch which is purely cosmetic.
>
> It's perfectly fine to send a reminder after a week for important changes
> and after two for trivial cleanups like this. You really cannot expect that
> maintainers and other developers permanentely sit there twiddling thumbs
> and wait for new mail to arrive in order to reply immediately.

Thanks for your patience and time in replying.
Will keep the patience :-)

Regards,
Mukesh

>
> Thanks,
>
> 	tglx
>

