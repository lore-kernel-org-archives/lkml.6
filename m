Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE78BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A852086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQbXxP/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfANRUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:20:07 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45673 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfANRUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:20:07 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so19943927ota.12;
        Mon, 14 Jan 2019 09:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qK64DEpMDtPL6DsRftl0nkP0RuweFemsjoRp4cOo2/c=;
        b=QQbXxP/cR5m6Woo2XRdrlrzYxgV1I1QcnneJYERs7HuE0uO51Qrgz+pqVnMj1bJ6zY
         +4KDjWFjOzhDBXx9254MlDDRgCZg5cCqcA09wPkdqa3zXiNVw/8hcSFhpJaxka7ayQQp
         /E91TykuUTkFycBS8Mc0ZVENECk6JQxCiA2exphOUJeEQzC8/tZNyCJEZBc2ibF1x00k
         7V9QJQS18iAG/cGY/6ybgrgj7CQD/UCzWS6Pu/c9Jyvrms2EJJckwlErShvku8hGnY9P
         /R3XnWP3srCd2y3uqI8VBqCAKVJbxnIsRdyuV6hoxhUKBRDxHHre9sAvPYrwkmz/B+AO
         LZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qK64DEpMDtPL6DsRftl0nkP0RuweFemsjoRp4cOo2/c=;
        b=jTlffGwlp3dhy3HT/iUQ7pd+GRRMPHgvlXePLwbSEWT4V3QClhdVUOgscReflmNRGx
         da6RBjscA2eRJ4HhBNDKJn/M6hlxa6ElItHDS3x8rO73iNB0h+gg12dsT4CVS3sQ82gM
         3aqANjPNUTdaMQIAvgjK5TyH6Qa2rkEp4sRHqCEtREWD5mk4JYWkgbFNNtRamSY+M6/U
         6j1sznAhEdIkKSapvTlsP9ScXR8EqhGqAm6FC6GEVgHuL5v9nSMl6NAAH2uU/UCqzzyQ
         Jzww2kWznN3dqGfApuDBtrB3vaQuRvQV6yKyZc/wokypqs/iOt62nz7T+1hO4vNwxfBh
         NufA==
X-Gm-Message-State: AJcUukf9c6IYMXiVjo59mTA0L5vGkEJwOplMBnCAM6j0u1moZZcy2Cxx
        bhxCpBNcrANTZINBRrJ74UJ7ROYgtr0lyuLJDzk=
X-Google-Smtp-Source: ALg8bN59ta+yDTeU5iEvt253YnBqjgkeS9x4IGTKB1CGifNHyHb0yIHt/nx0O6RM4nnwbXtZ9a5RPVW4FYfMkYpn2V4=
X-Received: by 2002:a9d:6297:: with SMTP id x23mr16290616otk.63.1547486406357;
 Mon, 14 Jan 2019 09:20:06 -0800 (PST)
MIME-Version: 1.0
References: <20190113153022.5040-1-linux.amoon@gmail.com> <20190113153022.5040-2-linux.amoon@gmail.com>
 <7hy37nky4v.fsf@baylibre.com>
In-Reply-To: <7hy37nky4v.fsf@baylibre.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 14 Jan 2019 22:49:54 +0530
Message-ID: <CANAwSgQS0B4Gbbvgu2N4cawmXMGWG1Sm0TOg0hTBr2nLteKQxQ@mail.gmail.com>
Subject: Re: [PatchV2 2/2] ARM64: dts: meson-gxbb-odroidc2: Fix usb phy reset warning
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin / Neil

On Mon, 14 Jan 2019 at 21:52, Kevin Hilman <khilman@baylibre.com> wrote:
>
> Hi Anand,
>
> Anand Moon <linux.amoon@gmail.com> writes:
>
> > Add missing vin-supply node 5.0V regulator setting to power
> > to usb ports, changes help fix the usb reset warning.
> >
> > [  795.380156] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > [  798.356073] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > [  801.331999] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > [  804.307919] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > [  807.283844] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> >
> > Fixes: 5a0803bd5ae (ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes)
> > Tested-by: Kevin Hilman <khilman@baylibre.com>
> > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > Rebased on Kevin's amlogic/v5.0/fixes branch
> > Changes from patch v1 [0] https://lore.kernel.org/patchwork/patch/1031243/
> > - Split the patch into two part: new patch
> > - Fix the commit message
> > - Added Tested by Kevin Hilman
>
> Queued as fixes for v5.0-rc (branch: v5.0/fixes) with Neil's reviewed-by tags.
>
> Thanks for breaking up into two patches, and as Neil said, please add a
> cover letter to multi-patch series in the future.
>
> Thanks,
>
> Kevin

Ok will follow the protocol next time I send some patches.

Best Regards
-Anand
