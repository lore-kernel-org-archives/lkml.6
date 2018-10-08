Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C981EC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E5920858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzZ00aAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E5920858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeJHVSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:18:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbeJHVSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:18:04 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A75322087C;
        Mon,  8 Oct 2018 14:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539007570;
        bh=qGvtHr+CMDmWHX/83L83F2IdY3owtawwH/qDYioZ4r0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RzZ00aAzIvkDelqTH9UDyDdngojHbeCEZUwp+PJJ5ulS2sWJ7+nhu9RuNvsoq3AU+
         TK+dQjy/WxjK4dmjjKrn2fK0SnKMnj9HIuZ0b5u4sBYk1P2fZWiQRFjoPSyFdAGDfG
         8pWq/TJc13hnZdnmnBci6SWPk0hDTuHt0LULZbQQ=
Received: by mail-qt1-f177.google.com with SMTP id q41-v6so20994480qtq.10;
        Mon, 08 Oct 2018 07:06:10 -0700 (PDT)
X-Gm-Message-State: ABuFfohd9nZ5NZb6hN0cVJ7JTsBH12cIEbtrQBWjS8L/B902/nJOP7le
        rpm5LnI8zuJKR6aMFy6LJyH7f49lcjLww4KSCg==
X-Google-Smtp-Source: ACcGV62KsUUpKLXT6piTWeTHL1QHKqJZ3HIWz14HO1selX1eMzsXiqgETACADOTZicacT/pVeWAgcOMP379shaQTGjI=
X-Received: by 2002:a0c:b5d3:: with SMTP id o19-v6mr19705377qvf.218.1539007569885;
 Mon, 08 Oct 2018 07:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org> <20181005165848.3474-30-robh@kernel.org>
 <20181008080220.rmxk57ckdfmwuk62@verge.net.au>
In-Reply-To: <20181008080220.rmxk57ckdfmwuk62@verge.net.au>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 8 Oct 2018 09:05:58 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+8EwYzBmzSWL0q0YB3rP-xdrZreRnt1Rj-h=D8OTNVwA@mail.gmail.com>
Message-ID: <CAL_Jsq+8EwYzBmzSWL0q0YB3rP-xdrZreRnt1Rj-h=D8OTNVwA@mail.gmail.com>
Subject: Re: [PATCH 29/36] dt-bindings: arm: Convert Renesas board/soc
 bindings to json-schema
To:     Simon Horman <horms@verge.net.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Grant Likely <glikely@secretlab.ca>,
        Kumar Gala <kumar.gala@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>, Tom Rini <trini@konsulko.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 3:02 AM Simon Horman <horms@verge.net.au> wrote:
>
> On Fri, Oct 05, 2018 at 11:58:41AM -0500, Rob Herring wrote:
> > Convert Renesas SoC bindings to DT schema format using json-schema.
> >
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-renesas-soc@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> This seems fine to me other than that it does not seem
> to apply cleanly to next.
>
> shmobile.txt sees a couple of updates per release cycle so from my point of
> view it would ideal if this change could hit -rc1 to allow patches for
> v4.21 to be accepted smoothly (already one from Sergei will need rebasing).

When we get to the point of merging (which isn't going to be 4.20),
you and other maintainers can probably take all these patches. Other
than the few restructuring patches, the only dependency is the build
support which isn't a dependency to apply it, but build it. I plan to
build any patches as part of reviewing at least early on. OTOH, the
build support is small enough and self contained that maybe it can
just be applied for 4.20.

Rob
