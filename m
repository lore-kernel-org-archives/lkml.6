Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852BCC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0763620827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PQ2jBflS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0763620827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387400AbeKEXWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:22:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46411 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387398AbeKEXWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 18:22:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id 74-v6so9630665wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 06:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3u/zlvB+Nf2DKswmoKgqj9x+ZUykOqXoUCZ0KptJ0GU=;
        b=PQ2jBflSTtsdg2gNwiCwhN+HNG7L31NMozCJUHJVcSUZmt9+dj0IDGaa8DM2xIvxvX
         NXmuvZKkC5TjNhFX/htoLHuydC/ApxabGWBqonmGsWROgJiwi2Boc0tATwxNWvoD2tYd
         GJjw1643PMGaEVEGOuMr9LDwd7bBhUIvDYPvMXulKKqKLpH559+gslfd5OJ4/KSEsNMa
         niy/dWSKVkuKciGsag/xyCVwVcwNRrHPY6vzJ+aPCz+3U27lFKrVyVdHq855cbY3+0Ne
         DYCrgaTLxKMK6M68O4EMVo9nI0nMBv6oqwYUIAHT38fmbxAgkfBZEKbO/Sqx+n7ffGKl
         JJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3u/zlvB+Nf2DKswmoKgqj9x+ZUykOqXoUCZ0KptJ0GU=;
        b=Quq3BmEp78VY8hv22RXC1ZP3cPxab1vDN9xYYtMhMdXXsIh+3WpXORqYkiNW2W2Ube
         Nxp6DBB2euxwXt3cgqFbIWKj7c2hJtorYr8EBpkVWprBRo2W6trE7lQSQKocgxJReR9h
         pjBiY8c2NMUi20skJwFR2XpjDBEI3LXfsHXWGe4ILLt4JSboqcTvQBMqQEbb7pmZiU7Z
         TbXHsaCXpuz+wWppHRXd3qDFmifRH8pgxrBAcRIJJbE0RfS1oKhHnTauL29RBFA8i06l
         yH+t3Oy8QTkno8/2d0kTKaTDGQmc+TzYnhzWpC1rY2Ba1zT52j7s2exGPAGnnUpzHjaU
         uBLg==
X-Gm-Message-State: AGRZ1gK1RQ7dPdYtdD26DMK225oLmi6DzQKGLkYGY1jeMXlm12Npb7F2
        5qSGhnXIrIeKtBxZXq839tr3xcB94p+HeiLMUTnB4Q==
X-Google-Smtp-Source: AJdET5cNq1hTPjx+cSvP2PjPZOtXcdE9ps4X7j6FLHnAmH6QIRD2ONRYsI6kbmQT9QFWwEdq/Ui3EBW7/7ZFTjkjxcY=
X-Received: by 2002:a5d:4a11:: with SMTP id m17-v6mr15675708wrq.259.1541426559914;
 Mon, 05 Nov 2018 06:02:39 -0800 (PST)
MIME-Version: 1.0
References: <20181105104508.23090-1-mjourdan@baylibre.com> <1a3d3b7a-5050-7b4c-bda6-8ef532403d01@baylibre.com>
In-Reply-To: <1a3d3b7a-5050-7b4c-bda6-8ef532403d01@baylibre.com>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Mon, 5 Nov 2018 15:02:28 +0100
Message-ID: <CAMO6nax_Q4kbDkeBmYQezo9dpMztD4DMFh+1dewax4p6d_S7mw@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/meson: Allow using optional canvas provider
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, Nov 5, 2018 at 1:51 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi Maxime,
>
> On 05/11/2018 11:45, Maxime Jourdan wrote:
> > The meson DRM driver currently uses constant, static canvas indexes.
> >
> > This is not optimal and could conflict with other drivers also using
> > canvases.
>
> Indeed, it's now time to use the canvas provider merged in 4.20-rc1 !
>
> >
> > This patch series allows the driver to optionnally use a canvas provider
> > module that is able to dispatch canvases, on demand and free of conflict.
> >
> > In the future, the current way of doing things will be deprecated.
>
> Do you confirm you will send a patch to remove the legacy canvas code when
> everything is merged (including DT changes) ?
>
> I'll wait until the bindings are reviewed, then I'll push the serie to drm-misc-next.
>

Yes, ultimately it will be removed.

The plan is:

4.21: allow using both modes, add the "amlogic,canvas" property to the dts files
4.22: remove the old way and change the amlogic,canvas property to mandatory

This should allow for a nice transition.

Maxime

> Thanks,
> Neil
>
> >
> > Maxime Jourdan (2):
> >   dt-bindings: display: amlogic, meson-vpu: Add optional canvas provider
> >     node
> >   drm/meson: Use optional canvas provider
> >
> >  .../bindings/display/amlogic,meson-vpu.txt    |  2 +
> >  drivers/gpu/drm/meson/Kconfig                 |  1 +
> >  drivers/gpu/drm/meson/meson_crtc.c            | 14 ++++--
> >  drivers/gpu/drm/meson/meson_drv.c             | 46 ++++++++++++-------
> >  drivers/gpu/drm/meson/meson_drv.h             |  4 ++
> >  drivers/gpu/drm/meson/meson_plane.c           |  8 +++-
> >  6 files changed, 53 insertions(+), 22 deletions(-)
> >
