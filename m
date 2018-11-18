Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85706C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC9220815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mnciBlDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC9220815
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbeKSDuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 22:50:23 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38393 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbeKSDuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 22:50:23 -0500
Received: by mail-ot1-f66.google.com with SMTP id u3so20548894ota.5;
        Sun, 18 Nov 2018 09:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4z/Mz4+z2xKNKNkiZCt1GsFhDASZPiBjNI0SYbFDAgg=;
        b=mnciBlDXT79s/iHcgViruvHN5I36g1UdcfMLBmUGhTJ98igKMgr+f3hc+SpwoPZI7n
         ZnXohB2X4gEKfrV2KgWfHpr+H8UPH0GJc1NIBvIGVvOuL9FIzgtlC6pqShT4d4fYPRwI
         a0APGga1fM3CAZiaa0T8g4QSbAboyDootVQvBzuBSP7CaCXHrhb1C+vjlGywry+Cp7ZZ
         TRLC8qXsg01MBQEP5NdSRPZC9p3b3NIvX8AR7cPe3DIvdzWkGNoO7hHHcaQktJwVaQ+G
         LJxcim1qiBaH/usB3Ml+qX5aIgLs40soP9bVpyA3qAnMUq8353pkuk/AKMt8HSh2fTsi
         I6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4z/Mz4+z2xKNKNkiZCt1GsFhDASZPiBjNI0SYbFDAgg=;
        b=mcDRHQS9oR6hs49MHynUuI+EZdd5LI8z8hSfkK0aZKA3ACgCaCMddmJsgPhyPFjWLC
         XcbAiqDbyxFmvbvUOAMdraob4pqHEP8ts3MKSZXGnytuK5N6xdhfxt6MQC1Ql7h4Vlso
         YjeHeUglyyEtVdySvlV64/+pQN0JZs8dsI/1zJ76UHvWQuW1pDTTvepaBtLLkzJsW/fG
         FBB2bvj2UYnyaGTgDkj/OBUhAh9Rf8Z7yGTYdPuk1SG0iaNr8TPdBr5QYSu4OyjNAsxQ
         gRNEs6sKEMia8ND9A5sxIL1aNopDXytB5INsGgi/MwtNebfFjnkq6kIuA5lrj9Mh6BjE
         mBAw==
X-Gm-Message-State: AGRZ1gJh6RlejXh6v2EdABRWGzdtFWMiiwKSFtFsD/RXfntdVZv2/Mql
        2mbrND9VmV8SmbfkWRx/dkrlHzPgU0TJrTzyeJs=
X-Google-Smtp-Source: AJdET5ePVyzzmnM+Yr6Xii1kIwClAKrb+/5uMJeMTkYOD9tQt6M2UZD1gpV1Fn8N8u94Bckt96tofbUCCJIhm0WOSxw=
X-Received: by 2002:a9d:3408:: with SMTP id v8mr11899221otb.237.1542562172298;
 Sun, 18 Nov 2018 09:29:32 -0800 (PST)
MIME-Version: 1.0
References: <20181117182007.14791-1-martin.blumenstingl@googlemail.com>
 <20181117182007.14791-3-martin.blumenstingl@googlemail.com> <20181118170331.GB5591@lunn.ch>
In-Reply-To: <20181118170331.GB5591@lunn.ch>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 18 Nov 2018 18:29:21 +0100
Message-ID: <CAFBinCCHp_gqmh4zXQLb2FDJrgzBEqoFZ+BrcWH0UcoOrwN+3A@mail.gmail.com>
Subject: Re: [PATCH 2/7] dt-bindings: net: phy: add bindings for the IC Plus
 Corp. IP101A/G PHYs
To:     andrew@lunn.ch
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Sun, Nov 18, 2018 at 6:03 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sat, Nov 17, 2018 at 07:20:02PM +0100, Martin Blumenstingl wrote:
> > The IP101A and IP101G series both have various models. Depending on the
> > board implementation we need a special property for the IP101GR (32-pin
> > LQFP package) PHY:
> > pin 21 ("RXER/INTR_32") outputs the "receive error" signal by default
> > (LOW means "normal operation", HIGH means that there's either a decoding
> > error of the received signal or that the PHY is receiving LPI). This pin
> > can also be switched to INTR32 mode, where the interrupt signal is
> > routed to this pin. The other PHYs don't need this special handling
> > because they have more pins available so the interrupt function gets a
> > dedicated pin.
> >
> > This adds two properties to either select the "receive error" or
> > "interrupt" function of pin 21. Not specifying any function means that
> > the default set by the bootloader is used. This is required because the
> > IP101GR cannot be differentiated between other IP101 PHYs as the PHY
> > identification registers on all of these is 0x02430c54.
>
> Hi Martin
>
> Not being able to identify the device is a real problem here.
indeed, even some extra "custom version" register would have helped

> I did wonder about adding a property which tells you if this is the R
> variant, but the binding you suggests seems equally good.
I decided against that because I *believe* (I have no evidence though)
that the IP101G could have the same problem in theory.
according to the datasheet I have the IP101G is a "Dice" (which I'm
interpreting as "raw die, no package")
<some company> could make a multi-chip package with the IP101G and
only route the RXER/INTR_32 to the outside
due to lack of evidence I decided not to document this in the
dt-bindings themselves, but if you want I can add this theory to the
patch description

apart from that: thank you for reviewing this series!


Regards
Martin
