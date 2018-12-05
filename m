Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C38C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544FF20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xakBUG63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544FF20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbeLEESc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 23:18:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:52372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbeLEESc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 23:18:32 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71BA620850;
        Wed,  5 Dec 2018 04:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543983511;
        bh=8hFPeaJ4NZs1xCUFjUmp3nPWEvkuJu8DlebMjLI3KWU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xakBUG63thzntpcZPytkaVhU7we1d1JUSKnqxD1p9lC0Ff8HH2UkaX/WEyUUlYbyj
         zwb5QjH7q05xXP0+9YpJIk+9uJkelwdCRddFBLuPIZss5EUlYblDC8+uaqk2bbhmoA
         CXGxRIgvPYkrqelzI23iM7Alxr+RPK2nUOwAN3rw=
Received: by mail-qt1-f177.google.com with SMTP id t13so20872340qtn.3;
        Tue, 04 Dec 2018 20:18:31 -0800 (PST)
X-Gm-Message-State: AA+aEWYPZXO1C7C/FN2fNB2zxrcbE2Y0OxAh/gEdg2FNUSyBXe6l7OJS
        lfB3Ecqjxs2622QBNIPhLDBOiwDdRGDkxkdW6w==
X-Google-Smtp-Source: AFSGD/V01+InEWqTizzIInNBqkSOixfMH8Ewf368Pcckr0vw2Ad0e4cKwmByU2t30xL4CMpc3ghoXkkMCZuA1vWVR8A=
X-Received: by 2002:aed:3ecf:: with SMTP id o15mr22291715qtf.26.1543983510705;
 Tue, 04 Dec 2018 20:18:30 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org> <20181203213223.16986-14-robh@kernel.org>
 <7hr2ewbxd4.fsf@baylibre.com>
In-Reply-To: <7hr2ewbxd4.fsf@baylibre.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 4 Dec 2018 22:18:18 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+hZRJZZ1ZcOxZVXtsUs0013cP0fyf3A=_9J15WbzuUhw@mail.gmail.com>
Message-ID: <CAL_Jsq+hZRJZZ1ZcOxZVXtsUs0013cP0fyf3A=_9J15WbzuUhw@mail.gmail.com>
Subject: Re: [PATCH v2 13/34] dt-bindings: arm: amlogic: Move
 'amlogic,meson-gx-ao-secure' binding to its own file
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>,
        ARM-SoC Maintainers <arm@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 7:01 PM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Rob Herring <robh@kernel.org> writes:
>
> > It is best practice to have 1 binding per file, so board level bindings
> > should be separate for various misc SoC bindings.
> >
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Carlo Caione <carlo@caione.org>
> > Cc: Kevin Hilman <khilman@baylibre.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-amlogic@lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/arm/amlogic.txt       | 29 -------------------
> >  .../amlogic/amlogic,meson-gx-ao-secure.txt    | 28 ++++++++++++++++++
> >  2 files changed, 28 insertions(+), 29 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt
>
> Acked-by: Kevin Hilman <khilman@baylibre.com>
>
> But this isn't really related to the schema series is it?  If you
> prefer, I can just queue this one separately via my tree.

Yes, you can take it.

Rob
