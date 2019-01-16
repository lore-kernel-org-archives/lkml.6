Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363CBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047772082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ar6p7weB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731667AbfAPEA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 23:00:29 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40914 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbfAPEA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 23:00:29 -0500
Received: by mail-ed1-f67.google.com with SMTP id g22so4305361edr.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 20:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WQnr2H9f9doStI1cKUtvCnMkv0ljT07NkyfmA7ZWKe8=;
        b=Ar6p7weB9RZopepSoyo34BOhaBPP8Pot7J0K3KGRj5wTes9uyiG314HfTpGmcIVshV
         yPhWLKrjq5TyxA0D/otTnzcvRl0v0Ak/+FjWmR5K+BSenpvmMsgMFICTYtcrKC2CPsBW
         58W0EQodyhc0OcNTHlB/La+mvGxyRoe8L/8X4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WQnr2H9f9doStI1cKUtvCnMkv0ljT07NkyfmA7ZWKe8=;
        b=Kc6+PAQixnkAbJdHke7aJ00ZMM8tYIu0NS6izCIXzuPAjM+xG10FCkQypn0QhJOcYS
         FPVBll5mjw+oYbhkRjsd1uShIhG/JaZnQVvdoZxkqPMvUNKrPG1/fvNuokt7nAYwEGuc
         yH4sJ8giA50g0zJkRgWjHRG5Ejxa4Mg/+1RCa3tT9U3qSwYzn8zx+tC/PnJHfglJHPm0
         CVxZ5OWpijfU5qLtiftsRjK5kegrmVnd2MEMpCIEbFlAXefg8qnytW7uwM4BXKWehnNu
         IawLtPnC61E9ahSzpe5u6U7icDdOIouQYMfRFZKCRgN6VvCeEC/cw6sAnjBE0E4kQFMu
         rtuQ==
X-Gm-Message-State: AJcUukebQafDOvP8JLeB/06JzV4uuPbCDo4IACWuKAin0FaigwcbzHg/
        sSpBFvXwUcozA+0TTBrojvYqduGGsYlf2/F5eRorpg==
X-Google-Smtp-Source: ALg8bN4mqCVseqlEIClIf6z9udEqVEoRZq363UxSJn4G5jOFP3x8u6D7LCvaXQiwDNa9jLY0sz0xDBh/98LXYmcP9NU=
X-Received: by 2002:a17:906:6298:: with SMTP id t24-v6mr5416344ejk.58.1547611227383;
 Tue, 15 Jan 2019 20:00:27 -0800 (PST)
MIME-Version: 1.0
References: <20190108052606.59426-1-pihsun@chromium.org> <20190108052606.59426-2-pihsun@chromium.org>
 <20190115203448.GA32546@bogus>
In-Reply-To: <20190115203448.GA32546@bogus>
From:   Peter Shih <pihsun@chromium.org>
Date:   Wed, 16 Jan 2019 12:00:16 +0800
Message-ID: <CANdKZ0fbP1Nm3GkO1ujeuaj4zAOQCdJ3MPowDQ-fJCUZ42a3dA@mail.gmail.com>
Subject: Re: [RFC v2 1/6] dt-bindings: Add a binding for Mediatek SCP
To:     Rob Herring <robh@kernel.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Erin Lo <erin.lo@mediatek.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 4:34 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Jan 08, 2019 at 01:26:01PM +0800, Pi-Hsun Shih wrote:
> > From: Erin Lo <erin.lo@mediatek.com>
> >
> > Add a DT binding documentation of SCP for the
> > MT8183 SoC from Mediatek.
> >
> > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > ---
> > Changes from v1:
> >  - no change
>
> No answer to my question on v1?
>

Sorry I missed the last mail.

Yes there would be additional optional properties. For the current patch
series, the "cros-ec-rpmsg" entry would not be listed in the device tree, but
there would be a "mediatek,mt8183-rpmsg" under this node.

Would update this in v3.

> > ---
> >  .../devicetree/bindings/remoteproc/mtk,scp.txt         | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> >
> > diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> > new file mode 100644
> > index 00000000000000..b07e5c4ca9af1d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> > @@ -0,0 +1,10 @@
> > +Mediatek SCP Bindings
> > +----------------------------------------
> > +
> > +This binding provides support for ARM Cortex M4 Co-processor found on some
> > +Mediatek SoCs.
> > +
> > +Required properties:
> > +- compatible         Should be "mediatek,mt8183-scp"
> > +- clocks             Clock for co-processor (See: ../clock/clock-bindings.txt)
> > +
> > --
> > 2.20.1.97.g81188d93c3-goog
> >
