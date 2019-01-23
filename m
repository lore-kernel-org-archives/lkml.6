Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C6CC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E24721726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1YXDq03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfAWOcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:32:01 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38539 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfAWOcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:32:00 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so1271770pfi.5;
        Wed, 23 Jan 2019 06:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q6zr4duEuqkHqp/AxXwzIfvCn+2hBll4m8lmlyLiYcA=;
        b=d1YXDq03trpU1Gc53mbDtCXSdqiT25thEg03HzDBoL4dEY233GcfkVFoMPj6NiPadE
         A2bwQTdA15w7R+Wozlx2jxDxxjVHOSknrLu3Tesw4V2o/TAbV5D/fSo98wG/IXiMj/Ir
         My/veSriRP/3p7fXHtDnpuT5WtTJ6pibHb3bL4fp38BX+VpVH7rAI60uANRqQ6mLjC3v
         qOH8AmKZ5KU29dy/hj9xOh7O+3RDbNKPZ9mVZbB0Y/YifyoyaJhT5miOrLS/s4FWmecx
         3Z7vyxXkZCB1lIgTJT9odhOfHTb4mlgj+YZ7XDzHJ1iu9VdiJnY0YHBYhk0J1zpmjwDo
         BGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q6zr4duEuqkHqp/AxXwzIfvCn+2hBll4m8lmlyLiYcA=;
        b=VnL6qQkpRLRf+brBBnTpenKHsRKyXNQ2WK1AdNSpT0Xc0GE84GoBGqGqRt14XnkMVf
         S3F/yVAgJL1liczhNoXoasxk2mizkpF3Zh/kVLZh0f7BdMWTqwLhAwN/BVmD8zUOLJvz
         58UqMyF4YxHW75XeQvudYUQwNZiFfo/iINyCl9mr9Exn9iuK9IQ6i916tmelv99IHrMC
         CB0MzynLedkrqCbcR7Q0G/r6kZuk+b21XfSschSuXzXHYwag4/IAQnzwjLfrsBMm7XTn
         5BI1TZhI2C9bWH2bpE6/T8O4ThrseOYWSuWAn3K6rvy+RH2oJXJVSDYFY4kOhwFUcodt
         RjHQ==
X-Gm-Message-State: AJcUukdHR5xyjDXWaqMVjKtNPvHA8UUAupVqZYm2W5ihf6g0Q0oSJ1NF
        UA1bUFm7wiA8ZKUoDtanhSqVKj0CTCY=
X-Google-Smtp-Source: ALg8bN7tWAzWd9WdstBK53g+Xbj8sxXWFsslmLyqSE3AbFUZsb7/5+DQRrDsORffy03cxkdl02+Gvg==
X-Received: by 2002:a63:9256:: with SMTP id s22mr2085019pgn.224.1548253919646;
        Wed, 23 Jan 2019 06:31:59 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y1sm24595808pfe.9.2019.01.23.06.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:31:58 -0800 (PST)
Subject: Re: [PATCH v8 05/26] clocksource: Add driver for the Ingenic JZ47xx
 OST
To:     Mathieu Malaterre <malat@debian.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-pwm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, od@zcrc.me,
        Maarten ter Huurne <maarten@treewalker.org>
References: <20181212220922.18759-1-paul@crapouillou.net>
 <20181212220922.18759-6-paul@crapouillou.net>
 <CA+7wUsxNN2SL9_7tDh0DiBAgdUwxd_osgmi=09HP7110Tm0DYQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <128675a5-7ede-4114-a649-89a536346dc8@roeck-us.net>
Date:   Wed, 23 Jan 2019 06:31:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CA+7wUsxNN2SL9_7tDh0DiBAgdUwxd_osgmi=09HP7110Tm0DYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/19 4:58 AM, Mathieu Malaterre wrote:
> On Wed, Dec 12, 2018 at 11:09 PM Paul Cercueil <paul@crapouillou.net> wrote:
>>
>> From: Maarten ter Huurne <maarten@treewalker.org>
>>
>> OST is the OS Timer, a 64-bit timer/counter with buffered reading.
>>
>> SoCs before the JZ4770 had (if any) a 32-bit OST; the JZ4770 and
>> JZ4780 have a 64-bit OST.
>>
>> This driver will register both a clocksource and a sched_clock to the
>> system.
>>
>> Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>> ---
>>
>> Notes:
>>       v5: New patch
>>
>>       v6: - Get rid of SoC IDs; pass pointer to ingenic_ost_soc_info as
>>             devicetree match data instead.
>>           - Use device_get_match_data() instead of the of_* variant
>>           - Handle error of dev_get_regmap() properly
>>
>>       v7: Fix section mismatch by using builtin_platform_driver_probe()
>>
>>       v8: builtin_platform_driver_probe() does not work anymore in
>>           4.20-rc6? The probe function won't be called. Work around this
>>           for now by using late_initcall.
>>

Did anyone notice this ? Either something is wrong with the driver, or
with the kernel core. Hacking around it seems like the worst possible
"solution".

Guenter
