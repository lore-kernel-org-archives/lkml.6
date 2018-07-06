Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742F8C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1A523F4C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="am9LN4vZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="am9LN4vZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1A523F4C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754119AbeGFIPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:15:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47094 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753545AbeGFIPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:15:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E330E60B10; Fri,  6 Jul 2018 08:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530864937;
        bh=PGM3zSKH89oW84dcZOlpEKlit4wB5wkGHyA9tVpjuFU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=am9LN4vZ6Q0I3iEzN2Dn/rgvQnQpUVFqYymTT0ZfnZtCRRAKGRcZh0Yg4VqGBZVgQ
         ZiA4SQtqPDt79umoosfXN8hGm/mk32buBqJPbi094eG7jslgfSCo4geLXXbk3M39aB
         4VrTcAxDnpuh32qu9KQHTdQbSCsPOxYhMwVeeF08=
Received: from [10.204.79.100] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B4DEA60B10;
        Fri,  6 Jul 2018 08:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530864937;
        bh=PGM3zSKH89oW84dcZOlpEKlit4wB5wkGHyA9tVpjuFU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=am9LN4vZ6Q0I3iEzN2Dn/rgvQnQpUVFqYymTT0ZfnZtCRRAKGRcZh0Yg4VqGBZVgQ
         ZiA4SQtqPDt79umoosfXN8hGm/mk32buBqJPbi094eG7jslgfSCo4geLXXbk3M39aB
         4VrTcAxDnpuh32qu9KQHTdQbSCsPOxYhMwVeeF08=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B4DEA60B10
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v2] time: Fix sleeptime injection for non-stop clocksource
 & persistent clock
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        neeraju@codeaurora.org, gkohli@codeaurora.org,
        cpandya@codeaurora.org
References: <1527680699-16068-1-git-send-email-mojha@codeaurora.org>
 <alpine.DEB.2.21.1806222312340.1589@nanos.tec.linutronix.de>
 <e869c2ec-90fa-27e2-975c-a92469f56dac@codeaurora.org>
 <alpine.DEB.2.21.1806251701410.1821@nanos.tec.linutronix.de>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <be7701cb-c0f0-a357-ba99-8f86a18060c2@codeaurora.org>
Date:   Fri, 6 Jul 2018 13:45:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1806251701410.1821@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Could you raise a formal patch on this as you are the author now?

Thanks,
Mukesh

On 6/25/2018 8:34 PM, Thomas Gleixner wrote:
> On Mon, 25 Jun 2018, Mukesh Ojha wrote:
>> On 6/23/2018 2:57 AM, Thomas Gleixner wrote:
>>> @@ -1671,7 +1685,6 @@ void timekeeping_resume(void)
>>>    	struct timespec64 ts_new, ts_delta;
>>>    	u64 cycle_now;
>>>    -	sleeptime_injected = false;
>>>    	read_persistent_clock64(&ts_new);
>>>      	clockevents_resume();
>>> @@ -1743,6 +1756,8 @@ int timekeeping_suspend(void)
>>>    	if (timekeeping_suspend_time.tv_sec ||
>>> timekeeping_suspend_time.tv_nsec)
>>>    		persistent_clock_exists = true;
>>>    +	sleeptime_injected = false;
>> I did not get the exact valid point of moving it from `timekeeping_suspend` to
>> `timekeeping_resume`.
> It's the other way round. I move it from resume to suspend. Simply because
> it should only be set to 'false' when suspend is reached. It would work the
> other way round as well, but I felt it's inconsistent.
>
> Thanks,
>
> 	tglx
>
>

