Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197D8C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC532148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="fv0JTjNf";
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="Smyta9O7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfA2K1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:27:50 -0500
Received: from mx07-00252a01.pphosted.com ([62.209.51.214]:24359 "EHLO
        mx07-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725927AbfA2K1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:27:49 -0500
Received: from pps.filterd (m0102628.ppops.net [127.0.0.1])
        by mx07-00252a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0T9qxje010673
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 09:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp;
 bh=PpjcOy7UAlkkXMZrtNW6CBgmpe/gdzgxUwvs3wCwuq0=;
 b=fv0JTjNfxyu3lwF7Eb6wGd/0bbu/5430OxLuUlyvmUqvAKSK3kJLVFl0osuJneAQGcB5
 JYuZqyBmLfw+6QSAMgxjMiOgvKisfdgP7T7/kv/XIZT2vQOrFyDZcQO1SkQ5o9bCaGD2
 ht6VFV8edar+/K1FQAiUed318piEjtfVRZX2bU10HMkftuyfURmd8gd6+HclKxlOvhBU
 5Lw8sIZuSTNBCOjLztJm7tZeyVLTTOsH6bLG63rmTnRP/+nRfqs5tyGvFhpaC7RcUhbt
 Ex+1M6kRigTRuyHTy0RxVqXD4OTCxbopmylrd4dk+n5TwUs1IOmeL8I5i3bnHOQVN5Gq xg== 
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        by mx07-00252a01.pphosted.com with ESMTP id 2q8du51e4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 09:54:21 +0000
Received: by mail-wm1-f69.google.com with SMTP id f193so5622682wme.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 01:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=PpjcOy7UAlkkXMZrtNW6CBgmpe/gdzgxUwvs3wCwuq0=;
        b=Smyta9O7W61oETrT9kLRPOqG16GbddwcLMQFZPF6QEhQ2KWH5lKUQjq+r3yP0/tEj0
         noTzPr0QonENY8g0h/Hn6W8VPtrDmSOfbSZQXaIUL07IEVIkk5u55CelVFqtIzCHIS2g
         qQpdIK7ZZBNGxyEiLWHlGwASovC67Eh89oSo499D40eXRB4vONiShP86te2+DZg6n1rg
         5o/MXnr0UViAY2FZoWvRNlVwJmPBbcO1myY4UiDB0/ujfybdxafnCAKmEI89aYrdkxgE
         0l9YL99eUzVpPxeQJgfolpNegPDgOYrXz8yJRBFpqvGYtfGKmLkLCsZp4jOCyK1hAiKR
         /osw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PpjcOy7UAlkkXMZrtNW6CBgmpe/gdzgxUwvs3wCwuq0=;
        b=KeOO2WCwGBKkcIoML2O2mwUhrwR8StB2DIGy5I+w1uXHW3t/kyQQ7A+qd5Z4jMxwtD
         1ksV3LiuVMjG/gAa/GYAiNoiczDwIbEK3XGRYa6xRcWsoAE/rhfI/31A1YGkBISVX7rr
         ho4ZHQP5KjjPsd8tdcW4rBuTRJK0b5IAi7fCstwypTs8hSThUIueTylmO6BiEx9YL6Vu
         6pyruYn0FV4AaWKUSR2QeI0m5tQ+ULqa/gQQrDbkcYBMszmYx699IxwhlMomMOvbnfvG
         muQ3Ybczjksswbe5/fYHNFf1Z/10vOomllDVwpv+VYMz17D4C1NQwZrZh53RqRpku+Ti
         tlcw==
X-Gm-Message-State: AJcUukfDu4YZ0n3D8Yuop5i32DiFFrQngbA++cjsDBHIaIEP6ULBdvSv
        JrB1YP6CGLNkjua58BZTej3GTZBn3Gzz4FT4/cr8KYrSINyqNrgeZ1Axd7Rxrp8H3fxuBTtmxTJ
        H1Kjrr6DRxhDte+9BbWNKTScz
X-Received: by 2002:adf:c108:: with SMTP id r8mr26251053wre.233.1548755660291;
        Tue, 29 Jan 2019 01:54:20 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4YSsAlmzV3Qxnj4OSYt3tCGDXkYOUHWRE5+rsHlL0epo+MsQajVxoncFF06Jt/XjJcMr2LOg==
X-Received: by 2002:adf:c108:: with SMTP id r8mr26251030wre.233.1548755659980;
        Tue, 29 Jan 2019 01:54:19 -0800 (PST)
Received: from [10.3.14.17] (cust51-dsl50.idnet.net. [212.69.50.51])
        by smtp.gmail.com with ESMTPSA id r200sm5420073wmb.36.2019.01.29.01.54.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 01:54:19 -0800 (PST)
Subject: Re: [PATCH] thermal: bcm2835: Fix crash in bcm2835_thermal_debugfs
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1548753048-78735-1-git-send-email-phil@raspberrypi.org>
 <dd7a1467-9252-ac13-204a-b069e5fba13a@i2se.com>
From:   Phil Elwell <phil@raspberrypi.org>
Message-ID: <da514645-51ab-47ac-8377-dfadfd783897@raspberrypi.org>
Date:   Tue, 29 Jan 2019 09:54:18 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <dd7a1467-9252-ac13-204a-b069e5fba13a@i2se.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On 29/01/2019 09:44, Stefan Wahren wrote:
> Hi Phil,
> 
> Am 29.01.2019 um 10:10 schrieb Phil Elwell:
>> "cat /sys/kernel/debug/bcm2835_thermal/regset" causes a NULL pointer
>> dereference in bcm2835_thermal_debugfs. The driver makes use of the
>> implementation details of the thermal framework to retrieve a pointer
>> to its private data from a struct thermal_zone_device, and gets it
>> wrong - leading to the crash. Instead, store its private data as the
>> drvdata and retrieve the thermal_zone_device pointer from it.
>>
>> Fixes: bcb7dd9ef206 ("thermal: bcm2835: add thermal driver for bcm2835 SoC")
>>
>> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
> 
> thanks for this patch.
> 
> Could you please resend this patch to the thermal maintainers Zhang Rui and Eduardo Valentin?||||
> 
> Regards
> Stefan
> 

I blame the get_maintainer script - a "Supporter" sounds less invested and less authoritative
than a "Maintainer".

A resend is imminent.

Phil
