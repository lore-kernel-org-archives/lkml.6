Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D54C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7312184E
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uYQ2gZQB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfBQWna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 17:43:30 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:35984 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfBQWna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 17:43:30 -0500
Received: by mail-it1-f195.google.com with SMTP id h6so35655832itl.1;
        Sun, 17 Feb 2019 14:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJbW+V2twaBqwaXD2mdR5DQyidLDIvv8mA94Shf7pmQ=;
        b=uYQ2gZQBr+gn4yVeiy1Xbh7IRihlo10g+4Acx9mViVE6bcyyKp5DqV7QW1h1U+8PlF
         yiZBtyfgeRuxqg53/BNZPXjQCV08WAJHarnWpUg98QfqFtVih0Bv/ksUfXRp3yW8fovE
         ESFzhH9MlQoqNM6E8Qy7IC+gMwM5cRZqlPEUBE2Ec9WIL3wevf5d6XZIvDv6qqYkbkBf
         XIPsBsEH/+PGb41XDdnQPtRQtsL0B5Aq9nigmCbr3tfwhltT2ra7wE4HpVlwpsi7NF53
         GM2EtXwFiFGFRMb4wjr9u3E0p+iw5GWin9aXL0LbuA8x2+utSAYsd1UYJjllU+X5G/mX
         OJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJbW+V2twaBqwaXD2mdR5DQyidLDIvv8mA94Shf7pmQ=;
        b=TSl/9o0cmM1c8GIhYlGs1A7rPQW9Uk4R8+HZG3dfktYpyIQGy6CQjhcUUMPgEvnmtu
         AM5x2lO828PCokHel+L+r+TZs+vRc4YymxSHLZKsuwxjtH8i+kokI+r6AnTU+65aH1oc
         3qYYqrXO8ph+xjoiBvMEmEUmxisTypCPsA4pnT1GfcpAMFu9TH2JH2vqgkKp+Rzqi3RJ
         aAeR5ONE9/Y/wyIXBJKI1cy4vtRGdcfb3usIaIuPOcQ8H6FHor68qx0Vs1KgzmYGfklH
         yBVMEFsjWvbYfEc3KjRzQ3h7wp4UWUVJSepwYG27Ye/L2zHcVvTMoA+AyFt5hC/60UK6
         XnFQ==
X-Gm-Message-State: AHQUAuaDWIOOlEz+TrMUxdD97P+/tl90MlmkX1MuRh15wG/ErvEMEuTZ
        qfXRzN9wbONKfodFuYRYsz20GCGIe+gFwti94Sc=
X-Google-Smtp-Source: AHgI3IZQvLmKzcTXdxOWBRN2ciYZD/JLUiqU6sBi9x9VhUBNBp1OBSke8Z4+y6W3EHC44ias9ZY034YnLgsUGBp3ua0=
X-Received: by 2002:a6b:dd04:: with SMTP id f4mr11542638ioc.248.1550443409348;
 Sun, 17 Feb 2019 14:43:29 -0800 (PST)
MIME-Version: 1.0
References: <1549296944-17285-1-git-send-email-jcrouse@codeaurora.org>
 <1549296944-17285-3-git-send-email-jcrouse@codeaurora.org> <CAL_JsqJ0FX=dbQb34bvZcdbWibjKnS2VXGsApT_Vz+UcjUxCSQ@mail.gmail.com>
In-Reply-To: <CAL_JsqJ0FX=dbQb34bvZcdbWibjKnS2VXGsApT_Vz+UcjUxCSQ@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sun, 17 Feb 2019 17:43:16 -0500
Message-ID: <CAF6AEGuXXqfa7OnfnyHLcyHaGXXGKHwpo4gMBH4gU0keExQcFg@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] dt-bindings: drm/msm/a6xx: Add GX power-domain for
 GMU bindings
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Jordan Crouse <jcrouse@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 4:08 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Feb 4, 2019 at 10:15 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> >
> > The GMU should have two power domains defined: "cx" and "gx". "cx" is the
> > actual power domain for the device and "gx" will be attached at runtime
> > to manage reference counting on the GPU device in case of a GMU crash.
>
> power-domains are supposed to be actual regions on a chip die which
> can be power gated. However, they are often abused by being defined in
> terms of kernel PM domains which are not always the same thing. This
> description sounds like the latter case.
>

iirc (and Jordan can correct me), this arrangement was needed because
normally the GMU does the GPU power control (except for if we manage
to crash it and need to reset the GMU)..

so maybe not 100% about the actual regions on chip die which can be
gated.. but it is a reality of how hw + fw + sw fit together..

BR,
-R
