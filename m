Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560FCC46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 14:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06208217D1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 14:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbIy2DLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06208217D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbeHEQOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 12:14:00 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:39163 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbeHEQN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 12:13:59 -0400
Received: by mail-ua0-f194.google.com with SMTP id g18-v6so9371715uam.6;
        Sun, 05 Aug 2018 07:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hpTpsNnGoUYlTv8VydFy68kiK6jQDv4hgRXhnwM4OHU=;
        b=mbIy2DLZlXSicA33ZCuN2AetVqtaFS0yjVF8HWjHrRfl+2MBLjOwijSQR/1AJjjh2N
         KCLUJ22G0Mivp7vLsSpb+0imwhpZKTM5IPbmXav7H9NGwC3oIr96gX4a50NVbWKJZujQ
         Le4ltnNBBcon+J8BI4FbSd/ggUSDACLzYYet7029f75iFEJ0i0GU654hhQzNrP5dTuWl
         +UdkbfsqaB4XCDKka1E7+CGOC3eOJZh5hlKLHCcFr8xTmKp2eFv0poH6eTCEe6eE8ItQ
         ZK/22hw7rXXp5hme96HZdpIIUTWJs0zblJoJJ1RK3QuLCMAmahSlzk95z8E/f5m8XVZ3
         IuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hpTpsNnGoUYlTv8VydFy68kiK6jQDv4hgRXhnwM4OHU=;
        b=ibUHxli7wz+7IIIhu2c1Y+2XnYP1K7BwBauyPbTzMWyd2vrgEqPOWa1/mas2+gb7XH
         OQ/cHsGnyFx4rXxemMnMl+6nEawx4THYtA254avwncXgBvq9ulDyNYstnFjYayPPC2p7
         eanIRBy6ZaCLMyfloo31Y+j336YMuI6/yD7D6QcEGJdSvsqMgRu4ikSxnd1V0qiZ5nLk
         nahztfNNZWG8dbQ0cWI5JrfGAR/CtLmTDa9tIO0mqHE1mGnq6BXOTmHzHZoz6gDwGF45
         2jwXHUPTvh2jtqgAhC2TmWMBEEHNaT9oBK7w6BgTEGd/uWEPb0ssR/Iz2w+tAwStCkxk
         GXaQ==
X-Gm-Message-State: AOUpUlEqvc/N6qxWUgAr7s6+rPGz8WNrl/TD/E11ffK7Hv6tFtVzN49g
        qzIhSTjXYx53oQwADkL106BEA1YVMpNfFaungtw=
X-Google-Smtp-Source: AAOMgpeBrROXPIJKWX2vGUAhE9VGoLdNwZh/r6uYKtNBXplXB2aGkn/9ESB5YqDEVAznjnuttXKxvw7MVk5nXTsupgY=
X-Received: by 2002:a9f:2187:: with SMTP id 7-v6mr8440701uac.49.1533478156301;
 Sun, 05 Aug 2018 07:09:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Sun, 5 Aug 2018 07:09:15 -0700 (PDT)
In-Reply-To: <cd8f37876a2e466ea066bcad10b0b8e4@de.bosch.com>
References: <cd8f37876a2e466ea066bcad10b0b8e4@de.bosch.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 5 Aug 2018 17:09:15 +0300
Message-ID: <CAHp75Ve=WZj6OT7wwQuqmSbZxK7EZr2z=AWJFRA-_aG+4_7MHw@mail.gmail.com>
Subject: Re: [PATCH] eeprom: at24: Fix unexpected timeout under high load
To:     "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "WANG Xin (BT-FIR/ENG1-Zhu)" <Xin.Wang7@cn.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 5, 2018 at 3:26 PM, Jonas Mark (BT-FIR/ENG1)
<Mark.Jonas@de.bosch.com> wrote:
> Hi Andy,
>
> Thank you for your feedback.
>
>> > -#define at24_loop_until_timeout(tout, op_time)                         \
>> > -       for (tout = jiffies + msecs_to_jiffies(at24_write_timeout),     \
>> > -            op_time = 0;                                               \
>> > -            op_time ? time_before(op_time, tout) : true;               \
>> > -            usleep_range(1000, 1500), op_time = jiffies)
>>
>> This one understandble and represents one operation.
>
> It just has the downside that it will not retry if the timeout is
> reached after the usleep_range().
>
> If you have a system which combines high CPU load with repeated EEPROM
> writes you will run into the following scenario:
>
> - System makes a successful regmap_bulk_write() to EEPROM.
> - System wants to perform another write to EEPROM but EEPROM is still
>   busy with the last write.
> - Because of high CPU load the usleep_range() will sleep more than
>   25 ms (at24_write_timeout).
> - Within the over-long sleeping the EEPROM finished the previous write
>   operation and is ready again.
> - at24_loop_until_timeout() will detect timeout and won't try to write.

>
> The scenario above happens very often on our system and we need a fix.

Thanks for explanation why. (it would be good partially move this to
the commit message).


>
>> > +#define at24_loop_until_timeout_begin(tout, op_time)           \
>> > +       tout = jiffies + msecs_to_jiffies(at24_write_timeout);  \
>> > +       while (true) {                                          \
>> > +               op_time = jiffies;
>> > +
>> > +#define at24_loop_until_timeout_end(tout, op_time)             \
>> > +               if (time_before(tout, op_time))                 \
>> > +                       break;                                  \
>> > +               usleep_range(1000, 1500);                       \
>> > +       }
>>
>> Besides `while (true)`, which is a red flag for timeout loops,
>> these are done in an hack way. Just open code them in both cases, or
>> rewrite original one to keel it's semantics.
>
> I have to admit that I am not sure what you mean.
>
> We kept the macro-style of the loop because we assumed it was good
> style in this context.

No way. It's a bad style when you have a macro like you proposing. It
would give you a bottle of sparkling bugs.

> What does "keel it's semantics" mean?

Macro should be standalone piece of code which does something from A
to Z, not from A-K when you need a complementary macro to do L-Z
parts.

> With "open code them in both cases" do you mean to rid of the macro
> and to directly write the loop into the code? Does the following
> match your proposals?
>
> ret = 0;
> tout = jiffies + msecs_to_jiffies(at24_write_timeout);
> do {
>         if (ret)
>                 usleep_range(1000, 1500);
>
>         read_time = jiffies;
>
>         ret = regmap_bulk_read(regmap, offset, buf, count);
>         dev_dbg(&client->dev, "read %zu@%d --> %d (%ld)\n",
>                 count, offset, ret, jiffies);
>         if (!ret)
>                 return count;
> } while (!time_before(tout, read_time))

Yes, though, please, look at the examples in the existing code and
make it slightly better

timeout = ...
do {
ret = ...
if (ret) // or if (!ret)
 ...

usleep_range(...);
} while(time_before(...));

-- 
With Best Regards,
Andy Shevchenko
