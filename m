Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C02C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5A720823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="PeaFaqEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5A720823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeKSTV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 14:21:57 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53342 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbeKSTV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 14:21:57 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so5463922ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 00:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K7mbb9vOq3HF+6SDr84KxnNywR22jMo9tZhQKTLsLpQ=;
        b=PeaFaqEmbuSYlNv9fUA3cOXbeLIoTuWrauTFXmOuVo1gKe/kFN+2lpVWv7Zm5QjJDe
         1o4VRMctV+LIMc+CksxUHq41KB7/OAwm6dvSpoowgjOkmlJWWK/jvS0p012KRP+i72al
         y2CYFTtZQwhAh6XoljBtQY9fARkuV6vZFMXQ61jRNkB1GCca6Rr9Ip05/1Y3hAuTJKn0
         LjpLFJ1hQkMzfCAthf3MwI1OoFxJ9F60ZTmwUeRAQKEFv6gCU3I7UIfWw2Epdoh43klk
         dtsX2TZe2ntIOVfYPN0iqAT4qzfFfFXVoD9VDDhAvnhXLZMQMFOKCwdyKdPErErveqrt
         cXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K7mbb9vOq3HF+6SDr84KxnNywR22jMo9tZhQKTLsLpQ=;
        b=Ohj/HYOz61zyxvDIFn57WwxwCtaMcYmH4UpV+TixrKHZFnZZ6JPjHkOf5MuQ0/olWG
         e8qKQTKXXDhyhoCiaLs+W0+W85Z4IqmElRoe0PJy+XkBCkduVy6dL4wajHkm0QNgFKHq
         juVDjAriLKz4b0PCb6cnglwryIZEojUNjhmEl9uNhN1fPVlH7w8bD0A3zIx5fLoJIgzT
         Hjpy9INV0rwoj6/CPqST+Q1mytmwavZ2MlkFzeCexWXW0a92h/KVzO7gPnN3+yJ1mlTo
         pzV0ZIRAo7zDfyeWaw8fSJ5NxALheEUD0rOX6IlIdThPOMuxK8Ug3tfkEPw49Io7/FxY
         hGYQ==
X-Gm-Message-State: AA+aEWat0xY32q7J/tUObSU86x9doShrKJAIzPC0StLQLFT/tmcAdRgx
        lt6XkP7EocDPrsfZn25on0XZJgNk+jMTidooLGYJdA==
X-Google-Smtp-Source: AJdET5fMOrKfasmr7MYDerHaY6whDJrun5Hu/zeNWgGsS74ZhGv77/FmbakSR1juzBl09AajA5E1p4IXpAjKQQqw+0U=
X-Received: by 2002:a24:2946:: with SMTP id p67mr6873967itp.53.1542617937493;
 Mon, 19 Nov 2018 00:58:57 -0800 (PST)
MIME-Version: 1.0
References: <20181113140133.17385-1-brgl@bgdev.pl> <20181118170329.788778a8@bbrezillon>
In-Reply-To: <20181118170329.788778a8@bbrezillon>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 19 Nov 2018 09:58:46 +0100
Message-ID: <CAMRc=MfXWW9siNZNkocxmTU7mnoQO0KpeHQ3JmLcEfNscqCbDQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/25] at24: remove
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        devicetree <devicetree@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

niedz., 18 lis 2018 o 17:03 Boris Brezillon
<boris.brezillon@bootlin.com> napisa=C5=82(a):
>
> On Tue, 13 Nov 2018 15:01:08 +0100
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> > As far as merging of this series goes: I'd like to avoid dragging it ov=
er
> > four releases. The series is logically split into five groups:
> >
> > patches 1-2: nvmem and mtd changes
> > patches 3-9: davinci arch-specific changes
> > patches 10-13: networking changes
> > patches 14-24: davinci specific again
> > patch 25: final at24 change
> >
> > With that I believe we can do the following: Greg KH could pick up the
> > first two patches into his char-misc tree.
>
> The char-misc tree? Why not the MTD or NVMEM tree?
>

There is no NVMEM tree - Srinivas sends his patches to Greg to be
applied to char-misc.

The second patch depends on the first one so in order to avoid more
merging problems I suggested that the MTD patch go through char-misc
as well. If you see a better solution, please let me know.

Bart
