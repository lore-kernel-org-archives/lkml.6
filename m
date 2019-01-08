Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC591C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAD6218AE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eqcDhZRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbfAHQr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:47:29 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:45314 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbfAHQr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:47:28 -0500
Received: by mail-oi1-f176.google.com with SMTP id y1so3816377oie.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 08:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5F7KowujNYJoSVlUhp9UqsX5YDaMPUUHUAaZe8ONM5k=;
        b=eqcDhZRbYaeVwlzixdGGfAHbhGbOKHCK+3VHRPwaI6U0bZGMzTElUwAZjp+hQSuJ0Q
         d5r748jpi34H6hp/FSZZZQgMku8WEo7f7lZXbLUN29kXrZ4/MN5yxCD1O5mfojDO7ruJ
         r5/fpXQH2hsc+/kldGiiZ/GN1JwFpp9+9XQHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5F7KowujNYJoSVlUhp9UqsX5YDaMPUUHUAaZe8ONM5k=;
        b=NxxsoeAdrHXCLpKWxwDwDrkHJntUIz7xLacdCVH3CLy5aZmcE8f/pPQ/N8huZkOrWq
         uoCZXuM+YzywHX3oFR+kmbt/ao0rgKYZyonas4L8PgJGSrR6aco3SIjXb0Yli6gGomFO
         v72MNkH+AYUrbWinxSx3vvayM5Z9BemO+lAOK5b/w3r9V9k605UzZC21m1FSxaBCDjMO
         WJe6WphuC/XF9RHxMMqh+MVEF+BySWJSClSpsS9u/QgAnQJEog6mq7qLzLq6EGh16WIB
         MLLuyycFjvSaMYWu4eKRgYJ17MLyppy7TtHKHbLelzna4myEEooPEGcVERfqJXyoAz0a
         0B7w==
X-Gm-Message-State: AJcUukf0h3QvneLGuV/rwU7J/i5b3kL+JhEim0ULiNCIs+Ycd7yuj/nI
        E1iHaSizd9YPAgmb7Mk2JzX8cbJFmVKTUVrchktKRiCY
X-Google-Smtp-Source: ALg8bN4KzUjnINnZZqABPJEyY+FWeKnG0G4FkY40Z3pZZumj5ySAuSVurt4aHFNvfq529lM3BwjzHXHJIe1M1gHVkVU=
X-Received: by 2002:aca:ac56:: with SMTP id v83mr1512859oie.265.1546966047661;
 Tue, 08 Jan 2019 08:47:27 -0800 (PST)
MIME-Version: 1.0
References: <20181230174838.32330-13-sam@ravnborg.org> <ab7424bd-dcaf-3dbd-9ade-9067831550b3@tronnes.org>
In-Reply-To: <ab7424bd-dcaf-3dbd-9ade-9067831550b3@tronnes.org>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Tue, 8 Jan 2019 17:47:16 +0100
Message-ID: <CA+M3ks7_zvDxK8e5M9L24hcw3oyczmLOfH5PZ_RtdxjkGV83gQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/14] drm/stm: do not reply on drmP.h from drm_gem_cma_helper.h
To:     =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Philippe Cornu <philippe.cornu@st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun. 7 janv. 2019 =C3=A0 16:59, Noralf Tr=C3=B8nnes <noralf@tronnes.org>=
 a =C3=A9crit :
>
>
>
> Den 30.12.2018 18.48, skrev Sam Ravnborg:
> > drmP.h was the only header file in the past and a lot
> > of files rely on that drmP.h defines everything.
> > The goal is to one day to delete drmP.h and
> > as a step towards this it will no longer be included in the
> > headers files in include/drm/
> >
> > To prepare stm/ for this add dependencies that
> > othwewise was pulled in by drmP.h from drm_gem_cma_helper.h
> >
> > Sort the include list when we anyway modify it.
> >
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Yannick Fertre <yannick.fertre@st.com>
> > Cc: Philippe Cornu <philippe.cornu@st.com>
> > Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> > Cc: Vincent Abriou <vincent.abriou@st.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > ---
>
> Acked-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>

Acked-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
