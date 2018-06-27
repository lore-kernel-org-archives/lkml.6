Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4086CC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4AC225C61
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iuCDudpi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4AC225C61
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966340AbeF0WOg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 18:14:36 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33429 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966278AbeF0WOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 18:14:32 -0400
Received: by mail-it0-f68.google.com with SMTP id k17-v6so19671848ita.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 15:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t48og73NKn5S6WkcprbXY6M/vbxx9+9GCvEp/10uwMk=;
        b=iuCDudpiczVFI+Iv29ghMDABU9t4FDV1YfbP7IUllNGShF3TH+NBvwjQgQ+FNf0Jtj
         Dsy6QUGoTAIr4/bZaQx6OJzoklsUyyZQJNJyDDu5gB7U+aw64vaSOibwQ5rUAjeq8fCE
         Jrb2QjrF7vMyXKm2RvDtazNANH3UzB910rQTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t48og73NKn5S6WkcprbXY6M/vbxx9+9GCvEp/10uwMk=;
        b=H8TzOUF4eAVeEU3SgWld0rs6Bzlg3DX2wK4VHSjudZgS12USXSsRjvEc8lvEesGTJI
         Pvqgk4wqfmZY2ydSPTfS6DHMX8JGKaicB+IDyAj+4DUkSgpaLk0vAK5j7HU8oMPHCqEb
         ZhXZqyuYIwPWI0bokW1I/rky8Q/eVoMTTTmllevQ7zdlItqjPZjSimuU9Zxmc+GTK7gi
         1C92kRLj7I4084d9OXRY/aA5e+6AYxgcupck9tjaVtg2eOBGd0mcqZX0360sAza5EosH
         Z/Dw0uvewLnxmpKC3M7c7dlqo4RjKcMrOIDoKF/nYUcZo9Ah/F3YTW5SfcyQa98XSBRg
         4uHA==
X-Gm-Message-State: APt69E09uYo24XnFPLSy+nxgks9c9od4IUdNY11cg3kzCnil3d5nxLrK
        fEIR2YgCNQqBtYKwsnO1NSvOBtEjBtNxfbhMHlD5Pw==
X-Google-Smtp-Source: AAOMgpd98xuZ4lQN/P+TyQBgU5aNfPVP9bPNawwYEEMXNdlXn8cKwI/jgdUdyr5aA7lb8Jzm1xSl3/sgxFPfIYKIrNU=
X-Received: by 2002:a24:5746:: with SMTP id u67-v6mr6432912ita.38.1530137672129;
 Wed, 27 Jun 2018 15:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180622104930.32050-1-boris.brezillon@bootlin.com> <20180622104930.32050-10-boris.brezillon@bootlin.com>
In-Reply-To: <20180622104930.32050-10-boris.brezillon@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Jun 2018 00:14:20 +0200
Message-ID: <CACRpkdYmR3+urDk6StG7s=W3=oYHB6eqs7ORdMV=-S31QtOAqQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/10] gpio: Add a driver for Cadence I3C GPIO expander
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
        ext Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Nori, Sekhar" <nsekhar@ti.com>, pgaj@cadence.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 12:49 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:

> Add a driver for Cadence I3C GPIO expander.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

If you need to merge this through the subsystem merge.

I see there was some heat in this discussion between you
and Andy, and it seems to be resolved. Which is good
because you are both senior contributors that I value
a lot.

Yours,
Linus Walleij
