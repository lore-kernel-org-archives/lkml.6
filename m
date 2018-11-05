Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB48C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DCC2084F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtJx1zLI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DCC2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387916AbeKFHMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:12:37 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34661 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387672AbeKFHMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:12:37 -0500
Received: by mail-oi1-f193.google.com with SMTP id i138-v6so5930632oib.1;
        Mon, 05 Nov 2018 13:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/lN2GsyAQNM8x2pLOTo7dTfaaAQAsVSc+LDp1na5p4Y=;
        b=KtJx1zLIfKlC/NgubJp7Nw9yWOx7eZc6+RUT1zbxlq3E1k4XZ11Y939VGfcppXcPvs
         c1KeKy+iWgHImESmpOi0TNJry7Qs8iHiuAVt8zl8QKoo13Lu7AiYoLD9iLWYLfrhfRVS
         5fWTAy4OCCuThyMWUVFFru5BbnisinNKYeKUR6GwyudZhM0x2XnU34sbF9AOoHemRrIO
         bROqy0BnoyLhbKLLMu/cRCm4xXou1NAznDC1pbdU+dK4kFuFtsrD+IN+4a46UUa5Fvv6
         jJEmzSadFsSsJMJvYTSClcFyONEF8NSpLFTvn1K2qvjALImbDDlZrgRdNfPDdogg5N4d
         rQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/lN2GsyAQNM8x2pLOTo7dTfaaAQAsVSc+LDp1na5p4Y=;
        b=iZfPQCtK0DHPuoAZXRMccClgLNsUNlQJlMEBIEVznCDNyC1PuGPeaEeptFmeRfir9L
         d3cq/9SC3aNvRVblNim/l7Kpbyaz8rzb+H0kP6JpY02zfZJqvJR8z3EDnO+0VTOkptKk
         nEiHeHxdlAVPjB/suG98wFDIaAor62ylTSrBOML457DAYpdYfHa0Cnd1OTM4g9dBPvpa
         5i8dT6zJf/YTY2oK6IIznO7ZJ9vXo3BoAMvM27b5U/o0gp7/LbbBgJ2MqgW8Xtry1Obr
         SUtZc71HZGB8V0xzGOAxdqWNhvzE6c9b4fDFTiLdKVaJTcnCWjnhzcs+bdRbQY1A8z2E
         OaVA==
X-Gm-Message-State: AGRZ1gLw4lrpkiO53P3YGRbLls9OU6KSIYBm5t4zmHgvAZMXDTe+gyyN
        A3CSaIRruiBs3NQrdta2R4iacPLvLq3H48n1CnM=
X-Google-Smtp-Source: AJdET5fKQdYVN1S6SsC6VWiFRYFaY416JMXJXHbPaC4vZpi0Di2UwXTjFQcaOo5tJJgWndnDreqy+0Ih8WLsLX3mVWQ=
X-Received: by 2002:aca:b357:: with SMTP id c84-v6mr14743847oif.266.1541454651435;
 Mon, 05 Nov 2018 13:50:51 -0800 (PST)
MIME-Version: 1.0
References: <20181104155501.14767-1-TheSven73@googlemail.com>
 <20181104155501.14767-2-TheSven73@googlemail.com> <20181105212049.GA320@bogus>
In-Reply-To: <20181105212049.GA320@bogus>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 5 Nov 2018 16:50:40 -0500
Message-ID: <CAGngYiUZTm-r0KJ07tKsPmgKCUWcqAOx2S82iLPRjkcDiw0R3g@mail.gmail.com>
Subject: Re: [PATCH anybus v3 1/6] misc: support the Arcx anybus bridge
To:     Rob Herring <robh@kernel.org>
Cc:     Sven Van Asbroeck <svendev@arcx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
        john.garry@huawei.com, geert+renesas@glider.be,
        robin.murphy@arm.com, paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 4:20 PM Rob Herring <robh@kernel.org> wrote:
>
> bridge vs. host are confusing me as those are often the same thing. But
> here bridge is just some auxilliary controls for the bus and the host is
> the actual bus with devices? I'm not sure why you split this into 2 DT
> nodes? How many devices are connected to the host processor (i.MX) bus?
>

The anybus can only have a single client card (device) on the bus. I
know, we can criticise the name, but that's how HMS Industrial
Networks designed it.

The anybus-bridge is how we (at arcx / Archronix) physically connect
anybus slots to the iMX. It is a CPLD chip connected to the i.MX WEIM
bus on the SoC side. On the other side of the CPLD, there are two
anybus slots. Each slot may hold an anybus card (profinet, flnet,
cc-link, ...)

The anybuss-host implements the anybus specification in a
platform-independent way. Some other company could attach anybus slots
to their CPU through a completely different bus, or spi, and they
could still attach the anybuss-host driver onto it. All the driver
needs is a regmap providing access to the anybus slot memory, an
interrupt, and a reset controller.

Sven
