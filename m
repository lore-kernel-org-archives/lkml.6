Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95779C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4667C2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOF/PVOZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4667C2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbeJICWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:22:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38780 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbeJICWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:22:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id b5-v6so10483467plr.5;
        Mon, 08 Oct 2018 12:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gTJFg4ENuqMCtoe06lY3tTT7aq8ayao0EQ4OYA9NmzQ=;
        b=XOF/PVOZRmPxR76dN3ZskG852I24TPvx40a9amdpXRKlw36L+vXUNqBepwq3wRO1Kl
         1z1JLw8sJnGcKn55Ss25rV1G/CCdGCAeLwMhLdZN55JuYVl9ZC6k9FMr/JcVHzAdsXpO
         GZP/ZUNUqImiFVPEGwjh2k4U8y7OJMUB0W5wLXs5R3u0GB7LSZE8DgRJaHqOYvjdWfo/
         UJl7vThS9cnRLHa+SEC42lGZO3k/h2GwuVlcPvJz6/PHsXIxPn0PZ/smhFDdy+tNBBhd
         EyL7+Egjd3oVzrr2QUc2JHwLUaIrMNcjvmzMi11asui3s+M99vdpStqbpi7JCLwl20I2
         QWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gTJFg4ENuqMCtoe06lY3tTT7aq8ayao0EQ4OYA9NmzQ=;
        b=ODJkJhpABPY7omges0y6GoIL1/rD43Eje76zFdrDi1Jl9W77pNV2j/NkfELbLrAsQI
         TbhpBANceHKuMhqN9s6zQJdaZ2GuSz8zcF7abaIiO5pfBiLR5bQni0FwUMkupCQlpDgi
         L/JZmUWsxMFMOoPmUorRSnGR63M/WSYwAwh8yd+cUJCIKoLdfeFhgcsfEEr2ovngwtuU
         eAeoZp5Q6Lctep2xblpsorUzZ+0PxbgzAPsoXMjrK+YnnEtCTPsC93ymuN+9zaKiqF+Q
         GVSttJncuOFG/Eods6kDqMrVHkgFYPyIlGmU8FQsX8GRcQUF+YVZre0oGTjqKGeBrLB3
         Vfog==
X-Gm-Message-State: ABuFfojQ3tKHzM6mNpE42OiVyuz4+hlrVG9MUW0tBfdtEXnSt00L4EVz
        y9fFDUltHmy4mJty9kZdzMo=
X-Google-Smtp-Source: ACcGV63fmPyVVaPNKDb2EBss3jlXIsiv46mEEg+OFu+1bvik0Gon9nZW4xjqqooMchshQXK8sbqIvw==
X-Received: by 2002:a17:902:4503:: with SMTP id m3-v6mr24553019pld.168.1539025780152;
        Mon, 08 Oct 2018 12:09:40 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:d530:cfe2:1970:fdab? ([2001:df0:0:200c:d530:cfe2:1970:fdab])
        by smtp.gmail.com with ESMTPSA id g5-v6sm27241960pfk.160.2018.10.08.12.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 12:09:39 -0700 (PDT)
Subject: Re: [PATCH AUTOSEL 4.18 24/58] Input: atakbd - fix Atari CapsLock
 behaviour
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>, sashal@kernel.org
Cc:     "3.8+" <stable@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        alexander.levin@microsoft.com
References: <20181008152523.70705-1-sashal@kernel.org>
 <20181008152523.70705-24-sashal@kernel.org>
 <CAKdAkRSoq_U1rkO+6gbautYpS1fFn3icLY3Dtx0geXNC7MwvbA@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <bec357b5-09d0-5014-d2a3-0ade83499d15@gmail.com>
Date:   Tue, 9 Oct 2018 08:09:34 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKdAkRSoq_U1rkO+6gbautYpS1fFn3icLY3Dtx0geXNC7MwvbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry,

someone on debian-68k reported the bug, which (to me) indicates that the 
code is not just used by me.

Whether or not a functioning Capslock is essential to have? You be the 
judge of that. If you are OK with applying the keymap patch, why not 
this one?

Debian will carry stable patches without explicit action on behalf of 
the maintainer. Unstable patches are a little harder to get accepted.

Cheers,

     Michael



On 09/10/18 06:11, Dmitry Torokhov wrote:
> On Mon, Oct 8, 2018 at 8:25 AM Sasha Levin <sashal@kernel.org> wrote:
>> From: Michael Schmitz <schmitzmic@gmail.com>
>>
>> [ Upstream commit 52d2c7bf7c90217fbe875d2d76f310979c48eb83 ]
>>
>> The CapsLock key on Atari keyboards is not a toggle, it does send the
>> normal make and break scancodes.
>>
>> Drop the CapsLock toggle handling code, which did cause the CapsLock
>> key to merely act as a Shift key.
> This has been broken for 10+ years. Does it really make sense to
> promote it to stable?
>
>> Tested-by: Michael Schmitz <schmitzmic@gmail.com>
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>> ---
>>   drivers/input/keyboard/atakbd.c | 10 ++--------
>>   1 file changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/input/keyboard/atakbd.c b/drivers/input/keyboard/atakbd.c
>> index 524a72bee55a..fdeda0b0fbd6 100644
>> --- a/drivers/input/keyboard/atakbd.c
>> +++ b/drivers/input/keyboard/atakbd.c
>> @@ -189,14 +189,8 @@ static void atakbd_interrupt(unsigned char scancode, char down)
>>
>>                  scancode = atakbd_keycode[scancode];
>>
>> -               if (scancode == KEY_CAPSLOCK) { /* CapsLock is a toggle switch key on Amiga */
>> -                       input_report_key(atakbd_dev, scancode, 1);
>> -                       input_report_key(atakbd_dev, scancode, 0);
>> -                       input_sync(atakbd_dev);
>> -               } else {
>> -                       input_report_key(atakbd_dev, scancode, down);
>> -                       input_sync(atakbd_dev);
>> -               }
>> +               input_report_key(atakbd_dev, scancode, down);
>> +               input_sync(atakbd_dev);
>>          } else                          /* scancodes >= 0xf3 are mouse data, most likely */
>>                  printk(KERN_INFO "atakbd: unhandled scancode %x\n", scancode);
>>
>> --
>> 2.17.1
>>
>

