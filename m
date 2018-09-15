Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B59FECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 23:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E982086B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 23:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyl9DRhd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E982086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbeIPE6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 00:58:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33160 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeIPE6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 00:58:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so5912369pfn.0;
        Sat, 15 Sep 2018 16:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s6Sc5z3lE/5CPYpBFUB+5EfBvBOUlrhvGVuINxJ0C24=;
        b=cyl9DRhdFZUjM+OfX4HQJjK92LWX11vWXI3IsCKuEgbmyfC6M8OpV/YODOtAQRW4La
         XqbPr/wjwlXlwILQ1AmVJkegcfBRWQUI0yCTF8mY8fF73EFymxKxItZcFcm0g41lHe+Y
         1sOM+Nv/+chyUvM4aLXx4VZEBry3g4bo4qtQVL21cwdr4HyYTOwJhmAJfhM8Ig0CRGtx
         BK+6aAr1ZBxtnKRz6uGjVsajBNbDhgpGki8Lw/ZNZiI7ErDyJmI7OYOPK9S2PwZGXx5G
         7elaI0AzO2O87gcN1iP1yPSyiq0LTEA+dwkRALKVHdRDyJ8YAOGCv5qjbCg8z97d9ZZp
         8g1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s6Sc5z3lE/5CPYpBFUB+5EfBvBOUlrhvGVuINxJ0C24=;
        b=eMy6cbMsAPdYookRiAWToF0OC8aBo/Oue6OXEEblJshNTjTirix+it4IkdBJ4OU8Sp
         GBDhPXWZW4MPYBtf7t8vtm07+k0oIYYMAh93hmsgkWnJNyTTVCc1dBKuS5rr4Y9nGNvp
         H22XgZD+yudxcQ3zb7J8L0Fi2l1TEIkxL69xj04FGTXk7A5ZOrwBO86OHOZjCjGUDOm+
         yi88Xc1mVbi/3waoUso0Aktj1FoCFTkyk9d+lGtnDV6jYZrzw0dnDNHb28IzC3krq+Zw
         Pp4Fq8ICbv31S1TEdkMh+R2RmpPewm4GOXWKBMsXw1aILRQHYhjgkGE1BjV+4INO3ZXl
         Bm9g==
X-Gm-Message-State: APzg51B7nDv4v4xXejL/que8xWA9IzEovPnd9AKTOe+NzqNoY4rz5OA3
        CdS7enXDwBtLbu6tzQXS6I4=
X-Google-Smtp-Source: ANB0VdbBFDS8en+ek3i099h/T0rLZSjwgBKPw4mMEQzo37CodNU5mTXH32W9Qxg1U3eY8A52fUFTrA==
X-Received: by 2002:a63:ce11:: with SMTP id y17-v6mr17597120pgf.201.1537054642241;
        Sat, 15 Sep 2018 16:37:22 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id j15-v6sm12864156pfn.52.2018.09.15.16.37.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 16:37:21 -0700 (PDT)
Subject: Re: Clang warning in drivers/hwmon/scmi-hwmon.c
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20180915051032.GA23900@flashbox>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <bb1167c5-d0d7-7d14-d2ba-0df3830ab53a@roeck-us.net>
Date:   Sat, 15 Sep 2018 16:37:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180915051032.GA23900@flashbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/14/2018 10:10 PM, Nathan Chancellor wrote:
> Hi Sundeep and others,
> 
> A group of us are trying to clean up all the warnings we see with an
> 'allyesconfig' arm64 build done with Clang and this one came up:
> 
> drivers/hwmon/scmi-hwmon.c:59:24: warning: address of array 'sensor->name' will always evaluate to 'true' [-Wpointer-bool-conversion]
>          if (sensor && sensor->name)
>                     ~~ ~~~~~~~~^~~~
> 1 warning generated.
> 
> Would it be appropriate to just delete that check or does the check
> need to be adjusted in some way (such as checking for the first value
> 'sensor->name[0]')? Either option technically solves the warning but I
> don't have the hardware to check if this breaks the driver.
> 

Presumably the check is supposed to validate the content of the data structure,
so dropping the test doesn't seem to make sense. However, one could argue
that, if the _content_ is to be checked, it should be checked earlier,
before the data pointer is stored (ie in scmi_hwmon_probe()).

Given that, I'll be happy to accept a patch to just drop the check; it
does not change the behavior of the driver, after all. If a real validation
is desirable, it can be added (into the probe function) with a separate patch.

Thanks,
Guenter

