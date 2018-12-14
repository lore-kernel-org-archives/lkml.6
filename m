Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7C0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C987206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFOzxJ+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbeLNPx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:53:27 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35755 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729163AbeLNPx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:53:26 -0500
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so5322884ljb.2;
        Fri, 14 Dec 2018 07:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OyJ4RQ0X3eoqBPBE2jbg+TcjQOt/Jyg81FHlkEqZdT4=;
        b=PFOzxJ+eDu9/r65ABdMqU7Q24SxdY4Bwpj7WBNLJtpguxlNhtWtt9osOjv2i1WfEii
         riMgDEvVU4DJbv61iX0REbLxtTtoYHsxHcPVEahmMk06xxT9+bZddaJm257FggIHZkhV
         35TUjA1AflmXvRftJhb6zAEasHT0gTzt7vhHbZ3cCbEpFwJbwO4bfT6sq28cX3nSN5a4
         UZHkx5HrnScNIZJ6fy1DhhYwLajr7I9CV1JIXxzNrwzQ0iQf/lAVm6rVit19NseUSNYa
         IlO6P3RPicI5YBEAkbtRmnJeDGAX8wSA8CZ0o5XmOnVQWPLJNkfkOg83QD/0kWYXuyjg
         TrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OyJ4RQ0X3eoqBPBE2jbg+TcjQOt/Jyg81FHlkEqZdT4=;
        b=i76AMafE/AHsZGNBc6PgzG3TnBvZAjnoD1CSnzhjcblZwLFy5L3/qq67elfCXp/TQ8
         czXK/WENTIZC3Afxj+XiD+XO9J9NcP2Kp3RNK82QiE9nmQOd6B9rsa0VVvHndMj3l0OF
         Vrt0hbKaTnQy46VUlUDCAWqJuOJ/02DgOIYGW14nGjxGdYUiSz0hyzmuSlzLK9rkbDBU
         JUfJ3RXCzk1dq5LgASRr3n2kv7SpAx1VXOgMZx704QHS4v/QzKXrA/QUEWls6sCXHB/h
         1KBlCjiOHF32ybsr3bdMngLXziT0mIEW3RI6rplKq+0cKOJzd8o1BPjTziu6QZAGLtTV
         yC5Q==
X-Gm-Message-State: AA+aEWbXx5jzv6sXiT48Jd7X1jouTTDf5+tIc9C1jm6KGgnrbb/yKlVS
        99j61EX8UHIyuk7Ux0evX008DMagbUQBk4WXSPv+1PFzlEu4eg==
X-Google-Smtp-Source: AFSGD/WtZNno83QXoGAMKjTfjF5oHC3t/d2E2Or+a2gV3u2UDxeOxZ5hkejC5RlZayMBuyl89g2i1ZIhkw1eVOeExFk=
X-Received: by 2002:a2e:3603:: with SMTP id d3-v6mr2173949lja.46.1544802804145;
 Fri, 14 Dec 2018 07:53:24 -0800 (PST)
MIME-Version: 1.0
References: <20181209155602.GA8414@syn-yoga530> <20181211210159.to6okhbaqpymoax5@ninjato>
In-Reply-To: <20181211210159.to6okhbaqpymoax5@ninjato>
From:   Elie Morisse <syniurge@gmail.com>
Date:   Fri, 14 Dec 2018 12:53:12 -0300
Message-ID: <CAC_JBqqo5joUKBz1s7m0ccw0OXxqk57aiY93UEV4inumug6hBg@mail.gmail.com>
Subject: Re: [PATCH v13] i2c: Add drivers for the AMD PCIe MP2 I2C controller
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, helgaas@kernel.org,
        Nehal-bakulchandra.Shah@amd.com, Shyam-sundar.S-k@amd.com,
        sandeep.singh@amd.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Having the patch reviewed by Nehal Shah would be great. While waiting
to hear from him, he voiced some concerns in the v10 thread:
https://lkml.org/lkml/2018/11/27/62
The _DEP hint was removed in v12. Regarding AMD's intention of having
two drivers, there are still two drivers, just within the same module.
And the comment about where the DMA mapping code should be is minor
and it's trivial to move it back if AMD plans to expand the platform
driver.

Noone reported any issue since v11, I'm done improving the drivers
unless it's necessary in order to get it accepted upstream. Please let
me know if I still have to change something to get it merged.

Elie Morisse

Le mar. 11 d=C3=A9c. 2018 =C3=A0 18:02, Wolfram Sang <wsa@the-dreams.de> a =
=C3=A9crit :
>
> On Sun, Dec 09, 2018 at 12:56:02PM -0300, Elie Morisse wrote:
> > MP2 controllers have two separate busses, so may accommodate up to two =
I2C
> > adapters. Those adapters are listed in the ACPI namespace with the
> > "AMDI0011" HID, and probed by a platform driver.
> >
> > Communication with the MP2 takes place through iomapped registers, or
> > through DMA for more than 32 bytes transfers.
> >
> > This is major rework of the patch submitted by Nehal-bakulchandra Shah =
from
> > AMD (https://patchwork.kernel.org/patch/10597369/).
> >
> > Most of the event handling of v3 was rewritten to make it work with mor=
e
> > than one bus (e.g on Ryzen-based Lenovo Yoga 530), and this version
> > contains many other improvements.
> >
> > Signed-off-by: Elie Morisse <syniurge@gmail.com>
>
> Nehal Shah, are you happy with this driver from your side?
>
