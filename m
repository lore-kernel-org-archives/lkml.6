Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FDCC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904EA20894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGDxqoqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904EA20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732036AbeG3VUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:20:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728746AbeG3VUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:20:06 -0400
Received: from [10.82.11.247] (unknown [131.107.174.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27A0420890;
        Mon, 30 Jul 2018 19:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532979815;
        bh=jbvr/MXfLHW76Nca010BSz2W7lRjiIoMahzDfabtTrw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oGDxqoqYJeLGxHp9cCP943oCVddyB7VtHE5blpkrB5s9u2SRHxap6p0R1qB7JdyP7
         BUPVfGRYzIcrn52EFfK4c2GbwQU59tZoW7SItmFkVe2OJsBxvzJ4S+tnIshBnZAm0t
         RlVVTpjnhNVne9wJzRDZSES+NsdrYIO7dMiPyj0s=
Subject: Re: [PATCH] watchdog: Reduce message verbosity
To:     Don Zickus <dzickus@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20180730190949.141996-1-okaya@kernel.org>
 <20180730192800.nqdhugzbxmin6e25@redhat.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <4e5def8b-df29-0efb-7e35-e71070e94d91@kernel.org>
Date:   Mon, 30 Jul 2018 12:43:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730192800.nqdhugzbxmin6e25@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Don,

On 7/30/2018 12:28 PM, Don Zickus wrote:
>> [    0.152492] NMI watchdog: Perf event create on CPU 0 failed with -2
>> [    0.156002] NMI watchdog: Perf NMI watchdog permanently disabled
> Hi Sinan,
> 
> Any reason why?  Usually when the 'perf event' fails, that indicates a
> system problem.  And most folks don't boot with the 'debug' option.  This
> means these unusual failures are hidden and become difficult to debug later
> when it propagates.

Sorry, I should have been more clear. I'm only suppressing the first
error message.

[    0.152492] NMI watchdog: Perf event create on CPU 0 failed with -2

Second message is still visible during boot. User knows that NMI 
watchdog is disabled.

[    0.156002] NMI watchdog: Perf NMI watchdog permanently disabled

Code is trying to probe the platform capabilities and is failing
because of missing PMU in the system. If someone is interested in
finding out why watchdog was disabled, they can turn on the debug
message level.

> 
> Or are you running the watchdog in a different configuration such that this
> is a common nuisance that you are trying to suppress?

Yup, system doesn't support PMU.

> 
> Cheers,
> Don
> 

Sinan
