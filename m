Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16040C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D287920864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UctLZlsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D287920864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbeLCXGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:06:22 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36556 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeLCXGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:06:21 -0500
Received: by mail-ot1-f67.google.com with SMTP id k98so13371580otk.3;
        Mon, 03 Dec 2018 15:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sLK/cE7G66zM1vPuYLGYNcSa0cxIKTFUPJVLQ3Rmm4s=;
        b=UctLZlsCFYUqk07WxIFHUa7RWheo3GvCtCq1FGsV5nMCyT3+CzoiiLYIHcY4eBR61r
         KFEeh1q3kAAgZCtmZPXsaFVt0VZ6KjHN3OYYeP2wg7Ful7jkjcsHNtjsCeoZLPlr5Rr8
         uDbi5iOIoIjieStIfA2XTO6BZtYAiHC4fY7cROf8Dnyf9FgX2Uynpq199nY30D6bmf2x
         u7SYVyq1PBqLwv9xNNKEjtD4Eo8JdKXyJekGSpY3bK6+Y8U6L18FjMU6aRNw9H9r2rjF
         MrYJmqGsUBBziY4lZSvXGJKJrq5njxXzJeJiwGd0JCYm7ly9VDpZOJrwIqZFOxDUHRKy
         EBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sLK/cE7G66zM1vPuYLGYNcSa0cxIKTFUPJVLQ3Rmm4s=;
        b=Y6Sfmf2kTK7GrH2PaOF5lRu9/b50bqDgefaPWd/CEr831qlJrsaRK5o1oop2V09VCc
         dzeorHCR4VnVsxr6NiDrH00jzZ+cFPIztoNb6Uw/1XuSCQMYL1z5PAG7mBeXAk+dZ1No
         g5XJQWsxHxmmmNj9LSMVGXj4ID5QDtck1Yy1S0z+1Tkes4+uLO6qln8JjKIsMy3t2t/h
         G0uTzn2UCBbU24/uoEhW9HpoWSMDnVBO16p+cT/hHh+kTTeJlIL716fjzgw3vOeCUS+i
         Mbe14y2M5HDBecPRpNGF/1M/RNqKU8H+mtXo8cxLAexRaruMVgfki5EVrlUr7zGXVe9X
         TyCA==
X-Gm-Message-State: AA+aEWZfpvakmXGIeMbS0lcVnpLZIhXePshO0Qxd1E+0ebKAq+X6tbFq
        JAbmr2HwWi1pDIGsVEK6BKiY7R1vS1LpPbNrC4Q=
X-Google-Smtp-Source: AFSGD/WeDmh7oDdzD+hm52jNYCNad+kPyeCuFXj1dDIkGp3t18/9mpbsjMEIZvWLibfBoPk/xfwe3ipkcjmqGNnmEys=
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr12365206otp.225.1543878380553;
 Mon, 03 Dec 2018 15:06:20 -0800 (PST)
MIME-Version: 1.0
References: <20181203211816.5129-1-jonathan@marek.ca> <20181203211816.5129-4-jonathan@marek.ca>
 <CAOMZO5B18DyZ0zvit6AgaueMifnMf2ctSo7pE_XndRpt7+bnLw@mail.gmail.com> <3e8d1f9e-ffb4-dd6a-0a68-f59b4c1134a0@marek.ca>
In-Reply-To: <3e8d1f9e-ffb4-dd6a-0a68-f59b4c1134a0@marek.ca>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 3 Dec 2018 21:06:22 -0200
Message-ID: <CAOMZO5BAPATbQGpdnjud29gVA2uDH8xJp0UVK+P88DF4PFJi6Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] ARM: dts: imx5: add gpu nodes
To:     jonathan@marek.ca
Cc:     freedreno@lists.freedesktop.org,
        Chris Healy <Chris.Healy@zii.aero>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 8:24 PM Jonathan marek <jonathan@marek.ca> wrote:

> > I can't find the dt-bindings for these compatible entries. Have you
> > documented them?
> >
>
> It is the same as qcom,adreno which is documented here:
>
> Documentation/devicetree/bindings/display/msm/gpu.txt
>
> I guess I should add amd,imageon there.

Yes, please.
