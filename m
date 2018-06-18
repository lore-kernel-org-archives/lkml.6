Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5935C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7711320836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rs9l0F20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7711320836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935445AbeFRRjN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:39:13 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39719 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935230AbeFRRjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:39:11 -0400
Received: by mail-pg0-f67.google.com with SMTP id w12-v6so7855099pgc.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 10:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=k2s+Fhu1TE8dZhPc6ZjDSqP5rpq5CNAh5CTwScldGBQ=;
        b=rs9l0F20zXrCcMBEcCwEp/e9PVzkLd7pOfOjCa6kTaF9fkgZI/Of7aOdSxTKZrMvfU
         YQNDpvZU0AsURtxPyU5vPu8qpSs+8YsaD3mxaaRivHRYbx6lNcHTNrJSKoa9PANL1Kq1
         NdZLusF3axSEZVcnZKSKz9lGXL1ykiXqYG8SAMc4A3uaXsRC/Bp6YCS3FMHdNRD19VPn
         lQCw5aC298fdDCug85hLM8DSTFrILh+rI4wF+qc7Y/wgnzfuDTqgdG0YoE7Jm7y48T3E
         CWqGPplgROcaE6Q3u2vDwoaK3QFyCAtQ4MPZvLpWZThQ0lD2kRKqy6xhgbzYF10AMHev
         W/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=k2s+Fhu1TE8dZhPc6ZjDSqP5rpq5CNAh5CTwScldGBQ=;
        b=JDlnakeM5bPqVzJEVar0KNZ7+DsKZlapbLUZ8as0y3gCHX9fnUn1MdVzhA7FztRygK
         swEDt5VttV0CyMO6nRPkicwYkR6hhOWAehoktXphsSX5wGzvFSirYB6aaIxK2db9063A
         +R/Y9zvU8I/+W+IALmEti05Zspeg0mh1BzumTObTATETrDih4P07Vg16l9ViWF94cIJV
         7cb6uwkxPtfG55jGuQxE3KkHU667H3X+kPQj4OoyCYV2DccgwyBT25M/rD7szGSaXwuO
         e2+sD23qDNju8SJSSkjDEekdSc67KmyF+xMYRf0UnxsWNADF4tFtnjN9gJYRe06qHjK+
         x1Wg==
X-Gm-Message-State: APt69E3HH7BlejbCVQooFu4txZmNqcPcLV8HS390AYL4w7s1js1WjDMH
        +Sx0iw2k5M2C1+gajpMfm0W/bug=
X-Google-Smtp-Source: ADUXVKJFa4MJjbzhgGPnMVNBr5bs1qC5Q3X+VLKPQXDZleMpxKAdri2ndXz5wMc9RlGjdleYZCnsfg==
X-Received: by 2002:a62:c809:: with SMTP id z9-v6mr14358363pff.5.1529343550742;
        Mon, 18 Jun 2018 10:39:10 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.59])
        by smtp.gmail.com with ESMTPSA id n68-v6sm28662249pfk.145.2018.06.18.10.39.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 10:39:09 -0700 (PDT)
Received: from [192.168.27.3] (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPSA id 06FB98AE;
        Mon, 18 Jun 2018 12:39:08 -0500 (CDT)
Reply-To: minyard@acm.org
Subject: Re: [PATCH] ipmi: Change to ktime_get_ts64()
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20180618142717.3683096-1-arnd@arndb.de>
From:   Corey Minyard <minyard@acm.org>
Message-ID: <59c7f897-4280-5f45-81a1-45b070377c22@acm.org>
Date:   Mon, 18 Jun 2018 12:39:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618142717.3683096-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/18/2018 09:27 AM, Arnd Bergmann wrote:
> getnstimeofday64() is deprecated because of the inconsistent naming,
> it is only a wrapper around ktime_get_real_ts64() now, which could be
> used as a direct replacement.
>
> However, it is generally better to use CLOCK_MONOTONIC timestamps
> where possible, to avoid glitches with a concurrent settimeofday()
> or leap second.
>
> The uses in ipmi are either for debugging prints or for comparing against
> a prior timestamp, so using a monotonic ktime_get_ts64() is probably
> best here.

This is definitely better.  Queued for 4.19 (or whatever it will be called).

Thanks,

-corey

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/char/ipmi/ipmi_si_intf.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index ad353be871bf..fb19c796f0fa 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -269,7 +269,7 @@ void debug_timestamp(char *msg)
>   {
>   	struct timespec64 t;
>   
> -	getnstimeofday64(&t);
> +	ktime_get_ts64(&t);
>   	pr_debug("**%s: %lld.%9.9ld\n", msg, (long long) t.tv_sec, t.tv_nsec);
>   }
>   #else
> @@ -961,12 +961,12 @@ static inline int ipmi_thread_busy_wait(enum si_sm_result smi_result,
>   	if (max_busy_us == 0 || smi_result != SI_SM_CALL_WITH_DELAY)
>   		ipmi_si_set_not_busy(busy_until);
>   	else if (!ipmi_si_is_busy(busy_until)) {
> -		getnstimeofday64(busy_until);
> +		ktime_get_ts64(busy_until);
>   		timespec64_add_ns(busy_until, max_busy_us*NSEC_PER_USEC);
>   	} else {
>   		struct timespec64 now;
>   
> -		getnstimeofday64(&now);
> +		ktime_get_ts64(&now);
>   		if (unlikely(timespec64_compare(&now, busy_until) > 0)) {
>   			ipmi_si_set_not_busy(busy_until);
>   			return 0;


