Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF43C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AEF20861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfmgFK72"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfAWLdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:33:35 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34190 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfAWLde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 06:33:34 -0500
Received: by mail-qt1-f194.google.com with SMTP id r14so1940441qtp.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 03:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k1Zm147s4IZcasNSXo+g4lT2lHkkUDDxoZjnYdga7w8=;
        b=WfmgFK721lJZJZlR+JlpNySdfpy6ozb7W+o0lCK3CIl3fnUDvq5ed16ohRwZ5oONvf
         yfDNd/ricyvgBI4P3kqPgWjbjmK+LbIlA+uqf+TH4be4wyreVkeRqMXYLYpFP4hJ1RfA
         myYgjFHYaJh6kKF0pJz4ovg0rXqG1C7TuPY0TTlBumAPeqv8rQ2TJE3AONzn6aiNbFrX
         PGz3BI/1GDBSZCnUZl1pGziLj04MkTFpyKWnaAxSmAeGeQQzAAtlhlcAe894p7LY414i
         6pYBcpOIcjB/ycM8oH6RFDVLrMUlRuPG8vSsftrKzRmjTRoH9DT14r2Xq4MgO5aMdf+y
         okRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k1Zm147s4IZcasNSXo+g4lT2lHkkUDDxoZjnYdga7w8=;
        b=qRKWoZ+GawVcYOi9ehWnHBXxaqq4pLxz/AEgwodqsk1Z0HNfyIsITUuJ9niBO6/m2h
         Fq9RX4o5KhE8Q8hMfy3Vi9lJ6UfXvzZuATCKEC/XkiBJdn6ilAQ2LZIyNRWYSHnV//1v
         GYh8drTwjxtaLWaOtWKQhu32nEivjlQf/6+Whjunm88ymQeWAoPmFUm6ikUWS5ke9Qd/
         m1gbXMtRsrKccYqBoELY4qHdU+YDn/n2VpTnpLBQczhcxB8iYzxSTyGh48kLgxs0dWgS
         YBmAh33mgjm1o6dH2qVnnyUgcbbKbv/W3kDUU3F7vIWOTH7j4aYd/kbK60nPiyLm4iWl
         f9Yw==
X-Gm-Message-State: AJcUukdIf6UxBLABZPd+mfo7DcVW5WqGaeH0tvrEoBerCCMEafIejVxV
        RauhDu+lPqlhEHqpFLcQ14Ws6cv/4fWRK9kWbcE=
X-Google-Smtp-Source: ALg8bN7Uzg7HsAfMuKk/L1BxdB3wBuIL7jhbPb8V4uZlYjZ3sGiRMSQZsGoUEnZFQhxl1vOJOtzY3IzlXEjwXQL7YOA=
X-Received: by 2002:a0c:a8e3:: with SMTP id h35mr1538693qvc.92.1548243213335;
 Wed, 23 Jan 2019 03:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20190110043653.25901-1-mdf@kernel.org> <CAFqH_53Mdh6chEDTkNH_ZGC6scHhXXgp7zdDaSS2Xfd--dfrNQ@mail.gmail.com>
 <20190121184017.GA5761@archbook> <CAFqH_50fsPx1raFReNt719fT2DmgAb0YHwzzbmfdAy9gYigLiA@mail.gmail.com>
 <20190122210912.GA8081@archbook>
In-Reply-To: <20190122210912.GA8081@archbook>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Wed, 23 Jan 2019 12:33:22 +0100
Message-ID: <CAFqH_53UadupCtjFe-9h4Qr=JQuzM1Wa=octA0=ap8RBbS6zPQ@mail.gmail.com>
Subject: Re: [PATCH v3] platform/chrome: Add cros_ec_readmem() helpers for
 I2C/SPI based ECs
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Moritz Fischer <moritz@ettus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missatge de Moritz Fischer <mdf@kernel.org> del dia dt., 22 de gen.
2019 a les 22:09:
>
> Hi Enrico,
>
> On Mon, Jan 21, 2019 at 11:19:34PM +0100, Enric Balletbo Serra wrote:
> > I tried with a Samsung Chromebook Plus (arm64 Chromebook)
> >
> > > What was the ioctl you ran?
> > >
> >
> > The code that I ran is this: https://hastebin.com/cupecuvowi.py
> > No guarantee :) I'll try to look deeper tomorrow.
>
> I fixed it up to run with python3, but on my device I got either a
> protocol error if len is > 120:
>
> root@ni-n3xx-313ABDC:~# python3 foo
> Testing EC_DEV_IOCRDMEM cmd
> I/O error(71): Protocol error
>
> or it worked for lengths <=3D 120:
>
> root@ni-n3xx-313ABDC:~# python3 foo
> Testing EC_DEV_IOCRDMEM cmd
> 6b 6f ff ff ff ff ff ff ff ff ff ff ff ff ff ff f0 0f f0 0f ff ff ff ff
> ff ff ff ff ff ff ff ff 45 43 01 02 00 01 01 00 00 00 00 00 00 00 00 00
> 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [...]
>
> Did you try smaller reads? If that works maybe we'll have to filter in
> the kernel to prevent large reads from crashing the EC?
>

So looks like I can read up to 161 bytes, if I read 162 to 169 bytes
the EC fails to respond and if I read more than 169 bytes it simply
resets the machine. I didn't look the code yet.

root@debian:~# python
/home/debian/Tests/cros_ec/scripts/cros-ec-readmem.py 160
Testing EC_DEV_IOCRDMEM cmd (size 160)
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 45 43 01 00 01 01 01 00 00 00 00 00 00 00
00 00
01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 9f 21 00 00 0e 01 00
00 59 13 00 00 0b 00 00 00 14 14 00 00 b0 1d 00 00 9a 13 00 00 35 01
00 00
53 44 49 00 00 00 00 00 34 33 35 32 44 35 31 00 30 46 38 32 00 00 00
00 4c 49 4f 4e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

root@debian:~# python
/home/debian/Tests/cros_ec/scripts/cros-ec-readmem.py 161
Testing EC_DEV_IOCRDMEM cmd (size 161)
[  425.053205] cros-ec-spi spi2.0: cannot read mapped reg: -71/14
I/O error(71): Protocol error
root@debian:~# python
/home/debian/Tests/cros_ec/scripts/cros-ec-readmem.py 162
Testing EC_DEV_IOCRDMEM cmd (size 162)
[  427.208065] cros-ec-spi spi2.0: cannot read mapped reg: -71/14
I/O error(71): Protocol error

root@debian:~# python
/home/debian/Tests/cros_ec/scripts/cros-ec-readmem.py 163
Testing EC_DEV_IOCRDMEM cmd (size 163)
[  429.845069] cros-ec-spi spi2.0: cannot read mapped reg: -71/14
I/O error(71): Protocol error
root@debian:~# python
/home/debian/Tests/cros_ec/scripts/cros-ec-readmem.py 164
Testing EC_DEV_IOCRDMEM cmd (size 164)[  431.968014] cros-ec-spi
spi2.0: cannot read mapped reg: -71/14

I/O error(71): Protocol error

root@debian:~# python
/home/debian/Tests/cros_ec/scripts/cros-ec-readmem.py 165
Testing EC_DEV_IOCRDMEM cmd (size 165)
[  440.289340] cros-ec-spi spi2.0: EC failed to respond in time
[  440.296271] cros-ec-spi spi2.0: Command xfer error (err:-110)
[  440.302732] cros-ec-spi spi2.0: cannot read mapped reg: -110/0
I/O error(110): Connection timed out

root@debian:~# python
/home/debian/Tests/cros_ec/scripts/cros-ec-readmem.py 166
Testing EC_DEV_IOCRDMEM cmd (size 166)
[  443.953212] cros-ec-spi spi2.0: EC failed to respond in time
[  443.960095] cros-ec-spi spi2.0: Command xfer error (err:-110)
[  443.966554] cros-ec-spi spi2.0: cannot read mapped reg: -110/0
I/O error(110): Connection timed out

root@debian:~# python
/home/debian/Tests/cros_ec/scripts/cros-ec-readmem.py 167
Testing EC_DEV_IOCRDMEM cmd (size 167)
[  446.585416] cros-ec-spi spi2.0: EC failed to respond in time
[  446.592335] cros-ec-spi spi2.0: Command xfer error (err:-110)
[  446.598798] cros-ec-spi spi2.0: cannot read mapped reg: -110/0
I/O error(110): Connection timed out

root@debian:~# python /home/debian/Tests/cros_ec/scripts/cros-ec-readmem.py=
 168
Testing EC_DEV_IOCRDMEM cmd (size 168)
[  449.337255] cros-ec-spi spi2.0: EC failed to respond in time
[  449.344140] cros-ec-spi spi2.0: Command xfer error (err:-110)
[  449.350588] cros-ec-spi spi2.0: cannot read mapped reg: -110/0
I/O error(110): Connection timed out

root@debian:~# python /home/debian/Tests/cros_ec/scripts/cros-ec-readmem.py=
 169
Testing EC_DEV_IOCRDMEM cmd (size 169)
l%(NAPEK@       @%vZ__|+~/g?s=DA=AC}mj}u??UwWo;_=DB=BBI6go{]uw]{m}w.=CD=BC=
=EF=BF=BD=DF=B5

And the machine reboots ...


> Thanks,
>
> Moritz
