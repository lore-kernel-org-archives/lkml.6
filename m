Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71541C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3698F2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="TWEuDdMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbfBLNcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:32:05 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:34728 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729731AbfBLNcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:32:04 -0500
Received: by mail-it1-f194.google.com with SMTP id x124so1790828itd.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 05:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3lwzuUsogwJbdneVnEnF2wqzl14Y/WuNtbxhwJA3qR8=;
        b=TWEuDdMQ9NFrrGXOdEq2BCM9JZ8DpRB83Qy2HOvfRbVO5yczM+NHvLxNwfwjxuqpLY
         vbinVYsGSgWDjXp4eXkhy9BIvJWSFaWAnqdMB9qLPiczr4A1Ru8MkabTXmSRTP1hmp5I
         QT/uYj7vie7DmVLsRcd1Dt5ReEfoZ3SGqBwKWE6pM8zusky7TBDBg9H9K0Pd9LeixsJE
         A1VJji5WBNAyIaWJ9zrZ9eO1hF8QdTO1gg3KtOBpJeFZlprM3wxciwEThMgsGwblX/b3
         +yhblKQ3rh+2/GZdSqyipzifdeDVmNI95uhR6KzpREsg0uj+vlT9knz5cCSxH5zzpC0D
         nnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3lwzuUsogwJbdneVnEnF2wqzl14Y/WuNtbxhwJA3qR8=;
        b=kvgyfaAEHrTje2yGmlTrlzgC/va7+LvufqNVzBmtfWOOt2MgtRFeXiHBSBvGNpk60n
         ccKB7z001mbV6NoHZojmJJUboBTUQfDP8f5taruNXhtXl1bS2IAPPb+TOK5WWZ2/EiPd
         nGv2UrttaLFOWcv66MORt8Pp1cfUQxbtlzkmmrGm/pZlU+v7Hh+brHza2yJGs33SjTY2
         CW1iXMLSsgB7vJ0DVCqsBVSajTMwlZVRiA0zzpDpr4A1u64IKT20sO9uTInBL4fkmnFI
         TUz0+diWPueFArpOwGQ1HY+w/1AgsannsoVGNQ5vql1oOF4ySE56SjklSGykqV4bRyoV
         fv2w==
X-Gm-Message-State: AHQUAubDxjLc2gSblwv2gQXqRDTmQSadobjPmXRN9D4sB9WwD0XLD1fM
        2CO6epgWAZBUuxlAgCmzbg8Qr39vhU+8Aui6Kkehjw==
X-Google-Smtp-Source: AHgI3IZ0sSAw7GPtfw2qm6Db5icLcvug1j7/4Rx+/wrCiIs0y/93iQNRnBJ6LvzpLPukLfzO4xStA94omgHdGGaUlfM=
X-Received: by 2002:a5d:91d3:: with SMTP id k19mr1979681ior.258.1549978323056;
 Tue, 12 Feb 2019 05:32:03 -0800 (PST)
MIME-Version: 1.0
References: <20190201094736.32057-1-brgl@bgdev.pl> <20190201094736.32057-8-brgl@bgdev.pl>
 <20190212120742.GA25613@amd>
In-Reply-To: <20190212120742.GA25613@amd>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 Feb 2019 14:31:52 +0100
Message-ID: <CAMRc=Mf4Mx2ojbpxvF+Qej3oMHdB8hBwtZ85A5+pTj_ZhBij3A@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] power: supply: max77650: add support for battery charger
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 12 lut 2019 o 13:07 Pavel Machek <pavel@ucw.cz> napisa=C5=82(a):
>
> Hi!
>
> > +#define MAX77650_CHARGER_ENABLED             BIT(0)
> > +#define MAX77650_CHARGER_DISABLED            0x00
> > +#define MAX77650_CHARGER_CHG_EN_MASK         BIT(0)
> > +
> > +#define MAX77650_CHARGER_CHG_DTLS_MASK               GENMASK(7, 4)
> > +#define MAX77650_CHARGER_CHG_DTLS_BITS(_reg) \
> > +             (((_reg) & MAX77650_CHARGER_CHG_DTLS_MASK) >> 4)
> > +
> > +#define MAX77650_CHARGER_CHG_OFF             0x00
> > +#define MAX77650_CHARGER_CHG_PREQ            0x01
> > +#define MAX77650_CHARGER_CHG_ON_CURR         0x02
> > +#define MAX77650_CHARGER_CHG_ON_JCURR                0x03
> > +#define MAX77650_CHARGER_CHG_ON_VOLT         0x04
> > +#define MAX77650_CHARGER_CHG_ON_JVOLT                0x05
> > +#define MAX77650_CHARGER_CHG_ON_TOPOFF               0x06
> > +#define MAX77650_CHARGER_CHG_ON_JTOPOFF              0x07
> > +#define MAX77650_CHARGER_CHG_DONE            0x08
> > +#define MAX77650_CHARGER_CHG_JDONE           0x09
> > +#define MAX77650_CHARGER_CHG_SUSP_PF         0x0a
> > +#define MAX77650_CHARGER_CHG_SUSP_FCF                0x0b
> > +#define MAX77650_CHARGER_CHG_SUSP_BTF                0x0c
>
> These are really bad define names. We are in charger driver, so
> MAX77650_CHARGER_ really should be shortened/ommited. OTOH
> more space should be given to "CHG_SUSP_BTF" as it is impossible to decip=
her.
>

I disagree about the prefix bit. I prefer to use common prefixes for
all symbols in a driver. I would rather add comments to every
definition here.

Bart

> > +#define MAX77650_CHARGER_CHGIN_DTLS_MASK     GENMASK(3, 2)
> > +#define MAX77650_CHARGER_CHGIN_DTLS_BITS(_reg) \
> > +             (((_reg) & MAX77650_CHARGER_CHGIN_DTLS_MASK) >> 2)
> > +
> > +#define MAX77650_CHARGER_CHGIN_UVL           0x00
> > +#define MAX77650_CHARGER_CHGIN_OVL           0x01
> > +#define MAX77650_CHARGER_CHGIN_OKAY          0x11
>
> UVL -> UNDERVOLTAGE, OVL -> OVERVOLTAGE?
>
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
