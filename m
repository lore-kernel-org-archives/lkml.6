Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610E6C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2654020672
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tI1k10BF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2654020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbeLMFKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 00:10:01 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41369 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbeLMFKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 00:10:00 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so474049pfi.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 21:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dl+Zhy2nfd2MF4hx9rzx+qSGgRqNLh7S8WVfRwCl6HE=;
        b=tI1k10BFyLJifYj3NX94CaqBqkT7IGjUPnMV0bDbiSyXWl/nMxlGjGlz4Ij0zOQgA6
         iO5jL/LfUF1l8EtgBWK0Yqsazij3Mq6+LGbGcfsGeaVxMV7rTFE1CIzqPZ3+isup05Wd
         X3EjiAZzUHTYZQMUqWmqFoojpbzoi/xnkjRqiFVzfmtvS5nfRi/JmKgxj4DPqNqWBPL9
         WU+XgcdHiho6oSSpN9gh81oA6qrdu3Irz8zq0MjngscD06sOX7m6gY0fNlmgU1Ss3ufU
         3gtgHlWdIkzK+cXBV+1IKH1hN66PwMptdB6Odv2a6ffP/u6kjlQilE7AiB7BuOD75sT4
         TnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dl+Zhy2nfd2MF4hx9rzx+qSGgRqNLh7S8WVfRwCl6HE=;
        b=e2V35goSBvXw1ouCPOoOJ1Xzs6MeHWSalCC8CAUiNgmoGYDHfKX5Nq2eYOT6Ak37QO
         WQ1Dw/EivNjiBx5s7/XvFjVIRnZQSnMMvcGvVjgM9QDTQcUyUPIvxVVNdITV/I1FxyBk
         MTrKHELWQRoqWc0cF0h5cnMwnACwuD2CawDuT24nydPXslPVKlZd/oiWBx//ZxFNpYe9
         7w1yFZZNVYc9k8kjy8Afp/C6TGlPRDtd0+8sfpJPLxJjURRZ+cYtYzwMikfufKslvDKA
         UXjnMuRW0j3tb4sSMlwX+FsZygBobafstC1dpyGtCfhm8ZqWnkpClwneGFQNjPEHWKli
         j3QQ==
X-Gm-Message-State: AA+aEWYeQ8pNRThzae25VprIH2Hwm8m5dlnwCD46iynI0rxf5WIuW7SQ
        +xEEA91J4f+NZ4ienu446LEa17X+
X-Google-Smtp-Source: AFSGD/WXvltMcLRRO80eg8YRrQwn9BQ+QGmW6owNDmnGo9gJynr/9UZ0ZtdzO0oUO+MbqxFmtsyvdw==
X-Received: by 2002:a62:5dd1:: with SMTP id n78mr22421956pfj.58.1544677799589;
        Wed, 12 Dec 2018 21:09:59 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o13sm884251pfk.57.2018.12.12.21.09.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 21:09:58 -0800 (PST)
Subject: Re: working toolchain for c-sky
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20181211195715.GA32516@roeck-us.net>
 <20181212073356.GA6864@guoren-Inspiron-7460>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8173660b-2e7c-03b1-c568-be40461799f9@roeck-us.net>
Date:   Wed, 12 Dec 2018 21:09:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181212073356.GA6864@guoren-Inspiron-7460>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/18 11:33 PM, Guo Ren wrote:
> On Tue, Dec 11, 2018 at 11:57:15AM -0800, Guenter Roeck wrote:
>> Hi,
>>
>> can someone point me to a working c-sky toolchain ?
>>
>> I tried several from https://github.com/c-sky/tools/, but they all fail
>> to build csky:defconfig with various error messages.
> 
> Try this:
> https://gitlab.com/c-sky/buildroot/-/jobs/131973812/artifacts/browse/output/images/
> 
> See readme.txt for run.
> 

Thanks, that helped.

It would really be useful if you could consider upstreaming the toolchain
code as fast as possible to enable third party toolchain builds (and tests).
Bitrot happens fast. csky images already fail to build in linux-next.

Guenter
