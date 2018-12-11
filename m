Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF6DC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6422082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMSjpDpH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6422082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeLKO2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:28:14 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33802 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbeLKO2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:28:13 -0500
Received: by mail-pg1-f194.google.com with SMTP id 17so6721752pgg.1;
        Tue, 11 Dec 2018 06:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BcIZGtaQZW9IuKbvgNg4eIvEBBviqD6wFVvgFlBMLmE=;
        b=ZMSjpDpHYaALtDw2bcsc0WfmrEcNPOufM1us7vuOBUaU+zw/Vu6+WLhz3QRmWpkd8T
         mz92ABpmiand2yOCVHXJbv7+r63JP8eex7M4pggzPiwnEJUjVkWN23PEYWxjop92oGgl
         VHEPZ0RVjU225irBjnaEugKXzZXyNSwpnjc+rzXbXfNYXevlwESRCoMVmHPe1qbsfGRM
         KWR2XRhYrq2s+JW4WVt1pO5XG3iVTc6MakxYkGAvLULD0EusAHwjwa69cpwG67QIzUZK
         ssMtOPqQ9V6QVRD/bpkUTzXBlBGcFSoC+nNGxMF6yFHgH8rTPvQUysI3JAPVrqNFG83t
         A1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BcIZGtaQZW9IuKbvgNg4eIvEBBviqD6wFVvgFlBMLmE=;
        b=VXWlHMgAJo7vEWQMoEQww863gGQI8E4OJkVUg4emcoVkhVid13kRvCupWGI3/Q23mh
         5xHILBfAZn6VWRHdzemnWt7C7OoTESARoUPn9Ih3swmlUIlI5nGRHjoTPuDtwmHizO3I
         xADDHtGqGHWD3efyVzP8YVUQWpnhnW39X3RCBX9dMft8fMiTmaSdOPfPDblenjTnlidB
         srZGM+FtDbrM+6iKmRUEKyyQQzPo4lapdBOSmB/vFtRVfSUfnImVzM3+F6j0MFVtUdR3
         KIu4aFhgtFvN8tjFiNIJuBa2npWIsH53Bv8QTrjXC0S38mek1ucId3vK5/m0RESnzW+b
         sUZA==
X-Gm-Message-State: AA+aEWaHbeQMk1iUpI2LCCGp08NXEDKOzy6jFg0Z2o23RAABDr8UM9Kw
        mVU1l1OKgkBVlTnwpF/oErh+HumD
X-Google-Smtp-Source: AFSGD/VdkC3QTJ+CEvdnStq4Mmecw6Wmx6OkamiTGFWciRLBmWmyFShmMvDUmsQkLpRCJyjNGLGJ9A==
X-Received: by 2002:a63:588:: with SMTP id 130mr14590088pgf.273.1544538492746;
        Tue, 11 Dec 2018 06:28:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h82sm38317002pfa.105.2018.12.11.06.28.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 06:28:11 -0800 (PST)
Subject: Re: [PATCH 21/30] hwmon: (da9052-hwmon) Use permission specific
 SENSOR[_DEVICE]_ATTR variants
To:     Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     Hardware Monitoring <linux-hwmon@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Support Opensource <Support.Opensource@diasemi.com>
References: <1544479728-30077-1-git-send-email-linux@roeck-us.net>
 <1544479728-30077-22-git-send-email-linux@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7021C50E52E@SW-EX-MBX02.diasemi.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ea1a6013-2738-a636-3835-6cc57becd6ec@roeck-us.net>
Date:   Tue, 11 Dec 2018 06:28:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7021C50E52E@SW-EX-MBX02.diasemi.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/18 3:47 AM, Steve Twiss wrote:
> Hi Guenter,
> 
> On 10 December 2018 22:09, Guenter Roeck wrote:
> 
>> Subject: [PATCH 21/30] hwmon: (da9052-hwmon) Use permission specific
>> SENSOR[_DEVICE]_ATTR variants
>>
>> Use SENSOR[_DEVICE]_ATTR[_2]_{RO,RW,WO} to simplify the source code,
>> to improve readbility, and to reduce the chance of inconsistencies.
>>
>> Also replace any remaining S_<PERMS> in the driver with octal values.
>>
>> The conversion was done automatically with coccinelle. The semantic patches
>> and the scripts used to generate this commit log are available at
>> https://github.com/groeck/coccinelle-patches/hwmon/.
>>
>> This patch does not introduce functional changes. It was verified by
>> compiling the old and new files and comparing text and data sizes.
>>
>> Cc: Support Opensource <support.opensource@diasemi.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/hwmon/da9052-hwmon.c | 105 ++++++++++++++++------------------------
> 
> Thanks,
> 
> I am assuming this previous patch [01/10] hwmon: Introduce SENSOR_DEVICE_ATTR_{RO,RW,WO} and variants
> from this set, https://patchwork.kernel.org/patch/9489915/ and,
> + #define SENSOR_DEVICE_ATTR_RO(_name, _func, _index)            \
> +        SENSOR_DEVICE_ATTR(_name, 0444, _func##_show, NULL, _index)
> 

Yes, of course. Sorry, I should have mentioned it.

> Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
> 
Thanks!

Guenter
