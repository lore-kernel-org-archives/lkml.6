Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6439AC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199D720862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCb3Yrai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199D720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403917AbeHATCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:02:46 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:33442 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403771AbeHATCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:02:46 -0400
Received: by mail-ua0-f194.google.com with SMTP id i4-v6so13191939uak.0;
        Wed, 01 Aug 2018 10:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4YmoZIcd7i6WG/cckD/B7gZ8mHFgZ06AaMDKgyD6ztk=;
        b=TCb3YraiGcn62q4+0uoLKOAwyHiWn/x6qbNAtC7B6AXf+DhezdtbW+WcDhfR4PHbbU
         SE3nzMnCCWWphnGt3hgt7rOhercjIG6i9oLgyMBE39g5NRlzL/DQP9l1H2IF8U2/vKvR
         b5Ym3WMi5DMWgJqG/K3LvOAJ7pmK9yC8IATf9ofX4E/eo5BME8eMHIXGXLE+wy5q/+n6
         p86UEMrWM1jV64VG43TgnKEtGzIPwVkfdrmS1TYQtbLV2wFxqHRmMvAezO+iBNlPZRjb
         0uAFYaUd/vOnpnmyp235VKhn/fABtJT71TeCp0Y0FfnmoDgiAHyJr84IO0JC9rU5xbdA
         Bkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4YmoZIcd7i6WG/cckD/B7gZ8mHFgZ06AaMDKgyD6ztk=;
        b=myx+Us9Jt0mp4dMSpDYv4qiK6f//0/SexbpnJixKuIIuH3fx62cRtQob2qevCqY0nb
         oAWQjAGy1u0xIHbxyT5m7jeIIh0DgKh/uMy+ebIGefpQXe6tsWsgIWPcn2WWWgPZaeVJ
         5aYyHcUamLseFMklkXigL1SX7DNwIPUqg9pDOwXdQ5YDE0gzqHWnX6a2lDFSOiHGf4jK
         FBIfmnN+AjWSblAfn27X9p/S1rWvw5vXNaeTkpPS4RuBKIWHASpEeUn9y24r0kFtgZWV
         LsUOzHu+EcqzQuoQUEzce+KuHeCDOA7r2f4ttXKquMYJ/1HTWHQM5+3mY9TVzMIL1Zxe
         qNcw==
X-Gm-Message-State: AOUpUlE/eRr3wC9bS6ZTuxmq24ShMKP5JnHn7UcE2oWtiE4zCk++SkvS
        7OvQdJ4c70LqHx1hyaN5CoFbPubKrc6fnhtKmsE=
X-Google-Smtp-Source: AAOMgpeNEmfPkI8ttVfdX2AB+cQtS+P4Kf3SpkixRPKo6RyRAE8oG2NvZQNXtOsBOzJkH3P8AiU67g9D/sth5BtXoDE=
X-Received: by 2002:a9f:3f8c:: with SMTP id k12-v6mr19430402uaj.38.1533143766697;
 Wed, 01 Aug 2018 10:16:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9f:26e1:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 10:16:06 -0700 (PDT)
In-Reply-To: <8ab731b4-2929-e92e-6536-35096ee66baa@roeck-us.net>
References: <CABXF_AAVhadw=+rtcD-L06-zBTMb3v7C2QqvN-6vcx5w2T0sYg@mail.gmail.com>
 <8ab731b4-2929-e92e-6536-35096ee66baa@roeck-us.net>
From:   Ivid Suvarna <ivid.suvarna@gmail.com>
Date:   Wed, 1 Aug 2018 22:46:06 +0530
Message-ID: <CABXF_ACKZXe+3J76bfyr4V1qdyhJ--cTekSXSVPksKOTxCBfTQ@mail.gmail.com>
Subject: Re: arm64: pstore: printk causing hang during boot in __memcpy_toio
 with pstore enabled
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Baron <jbaron@redhat.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 6:49 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 08/01/2018 05:35 AM, Ivid Suvarna wrote:
>>
>> Hi,
>>
>> When pstore is enabled and a *pr_info(any printk) in
>> __memcpy_toio(arch/arm64/kernel/io.c)* is added, kernel wont boot and
>> just hangs.
>>
>> The path where __memcpy_toio is called is below:
>>
>> ->persistent_ram_update
>>    -> memcpy_toio
>>      -> __memcpy_toio
>>
>> I tried with trace_printk and kernel boots fine. I understand that
>> printk has overhead, but is this expected when we use some printk
>> statement in __memcpy_toio?
>>
>
> I think the problem may be that the printk() output is copied to pstore.
> Since pstore calls memcpy_toio(), you get a nice recursion if you add a
> printk() call to it.
>

Is there any solution to this other than not adding printk :p
