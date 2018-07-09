Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB266C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679BE20878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkOVNRfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679BE20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933056AbeGIOQ7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:16:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932574AbeGIOQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:16:57 -0400
Received: from mail-io0-f179.google.com (mail-io0-f179.google.com [209.85.223.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 535F42089D;
        Mon,  9 Jul 2018 14:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531145817;
        bh=++Aesxi9iGTjqdSvUU66ecLPc/Kt+d2+86qldACmWE8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NkOVNRfzK9k6ag2o/Pa9+qJBmscxKSisc6VyViEjnnjocbPVtBswwrRABTGEF/2S+
         sQNw5svJ7iZS52/8c6PDe0uCgV3Kq8fCN1YKE4ujDuuX6Hk1iQX0CWr6obrBHte6z+
         E30m1lp7HDqi/hrvc4x4m7vyKKWuerbWQ3OippxI=
Received: by mail-io0-f179.google.com with SMTP id l25-v6so17181002ioh.12;
        Mon, 09 Jul 2018 07:16:57 -0700 (PDT)
X-Gm-Message-State: APt69E3vSqN8Im5FN/V0WmHzleP8xgtmXEMNLhC/o9z04ZH0OwUra6j1
        wCd6i8RcjnHDRn2JVGXUui2ob04iMRUsQEuk9g==
X-Google-Smtp-Source: AAOMgpfkQWfyyYgTH7CTmSSL8cKr3ez0qPlG8Pgw03RFCMLCsVIkkdG20d+0E7aMlTMST7vw5ItF7ruSC/bQYoG5JT0=
X-Received: by 2002:a6b:c693:: with SMTP id w141-v6mr17007718iof.79.1531145816762;
 Mon, 09 Jul 2018 07:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
 <20180706175113.26698-7-jernej.skrabec@siol.net> <20180706204052.GA9680@rob-hp-laptop>
 <8232482.X57NU8v1zb@jernej-laptop>
In-Reply-To: <8232482.X57NU8v1zb@jernej-laptop>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 9 Jul 2018 08:16:45 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+2Cv+cS+c8DuHackVfO3beYHx-p-dXpK2z=vQwHKSD-Q@mail.gmail.com>
Message-ID: <CAL_Jsq+2Cv+cS+c8DuHackVfO3beYHx-p-dXpK2z=vQwHKSD-Q@mail.gmail.com>
Subject: Re: [PATCH 06/17] dt-bindings: display: sun4i-drm: Add R40 TV TCON description
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 2:46 PM Jernej =C5=A0krabec <jernej.skrabec@siol.net=
> wrote:
>
> Dne petek, 06. julij 2018 ob 22:40:52 CEST je Rob Herring napisal(a):
> > On Fri, Jul 06, 2018 at 07:51:02PM +0200, Jernej Skrabec wrote:
> > > TCON description is expanded with R40 TV TCON compatible. It is a bit
> > > special, because it is connected to TCON TOP instead directly to mixe=
r
> > > and it needs special handling.
> > >
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > ---
> > >
> > >  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 3 ++=
-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > Please add acks/reviews when posting new versions.
>
> This is not exactly the same version you give ack for, so I didn't includ=
e it.

Then you need to state what changed (in this patch) and why you didn't
add the ack.

> I'm not sure where the line for that is.
>
> In contrast to previous version, it doesn't introduce additional clock.

Sounds trivial enough to keep the ack.

Rob
