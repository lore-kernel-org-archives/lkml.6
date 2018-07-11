Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDEDC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0962084A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkQUa3jK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C0962084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388405AbeGKOOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:14:46 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46570 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbeGKOOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:14:46 -0400
Received: by mail-lf0-f67.google.com with SMTP id l16-v6so21392574lfc.13;
        Wed, 11 Jul 2018 07:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=IPv3E6Gn5yp3bZSK+NE2mf5GZIiw9vWcMJ+i+NbbVTo=;
        b=XkQUa3jK3fK8hGxaYsZsyHbZeB5wN9epqULq4qJ9K9ntugQ+B6xV/A+79qSELy1YZB
         gFiFfH+NWtIAaZZFJg8FyzKe4/uIyVoX9Shq1kksbO7NnYesvyK85fRKgINQnh6eq12o
         NhLFB82KB0f6zjQQ4gIA91FpTJTLjUtGbVYaNHUuAyi4DwydlfaNu4lXh/fWbaKfzPJm
         FqTSRkoqZSjD6hd0NvdOuUEnZa77UUtsM7KaSt95bWI6qSHvT8CKIuak6S7VfE1IR7CH
         NDNnTvo/TQ8GsyfIEEYwg0NPBtKC2Oe3ZSZieX3SPDw4q0JE6jWY9/579aa8LlbzUNtz
         xNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=IPv3E6Gn5yp3bZSK+NE2mf5GZIiw9vWcMJ+i+NbbVTo=;
        b=kquY22zZVtJbIDVtzOp3LTGcbbSBvnZJ5ygTXXnQG78cvNESidKyIYIO/PZXYpcLa5
         /xIkWGwiMjTWPbDf5IpjoErbOhhaEWwpnUN9i5xCvfRIBjAqt2Woviw3C3QHCZUXY0+A
         BE7+m3xdFssFGSeSWpbpDMjAyeoUpNV7tr0zo2MNo7/w0L1RRK6cI5UcUMW7JejBlg+p
         jO98mzKGJE+VlSyClPc3H92SrNcs5TWHfwQWs3UFWcjRDHbrjM8d7dvf8BwX67kYeYmY
         oRr+NkDwplqolXK3Xt7WIb9uzSfu8GG+36Q0o6DMeB48QKmatq+q7j0heibsrTDIcA74
         qBWw==
X-Gm-Message-State: APt69E393+i2IXV1W4zd9vO4iVcjp3byIEnELKMMpE7mDva3pBj6qL0w
        j30MxBhug+VVK5sEC8IhqtDYKj5Scnbi4Ab9Znc=
X-Google-Smtp-Source: AAOMgpflz8cdxO/VB7hQZaBV0jmpQUyQDQlAidUk0heaSx6cmat9AWo1abBQOjtZeHnPMbaz1qQptXewZSbG0toQnaQ=
X-Received: by 2002:a19:b2c7:: with SMTP id t68-v6mr5891425lfk.132.1531318211355;
 Wed, 11 Jul 2018 07:10:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 07:10:10
 -0700 (PDT)
In-Reply-To: <20180622104930.32050-5-boris.brezillon@bootlin.com>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com> <20180622104930.32050-5-boris.brezillon@bootlin.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 Jul 2018 16:10:10 +0200
X-Google-Sender-Auth: 9LnPWSZt9z69qaNh94h1oU4DHPo
Message-ID: <CAK8P3a1gyvvpKdVV+STOJXd-=BFdiFF638F0agXur0kLYP7ksw@mail.gmail.com>
Subject: Re: [PATCH v5 04/10] dt-bindings: i3c: Document core bindings
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 12:49 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> A new I3C subsystem has been added and a generic description has been
> created to represent the I3C bus and the devices connected on it.
>

> +I2C devices
> +===========
> +
> +Each I2C device connected to the bus should be described in a subnode. All
> +properties described in Documentation/devicetree/bindings/i2c/i2c.txt are
> +valid here, but several new properties have been added.
> +
> +New constraint on existing properties:
> +--------------------------------------
...
> +  + third cell: should be 0

What for? Just to be future-proof, or do you have something specific
in mind here?

      Arnd
