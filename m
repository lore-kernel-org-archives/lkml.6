Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EF6C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D9E208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D9E208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeHWUAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:00:16 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33150 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbeHWUAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:00:16 -0400
Received: by mail-qt0-f194.google.com with SMTP id r37-v6so6974418qtc.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 09:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:mime-version
         :content-transfer-encoding;
        bh=vj19Bs5lWs5rBhAgswrt6epOMeKxlV+HXOnzyGfkM24=;
        b=EK4UJj8HIdk+Z13XQailwdj6m+mS6R0TT4PvqhrYgXH6gjIrNznOuI3534ezoP9qpB
         Q9HA7mIEk8J4hEMDXMzJDjkMuyZCY8cFhy/j9IBJAMiT4V1oZu9Gs2Vum/osOAZKncE5
         n7+LgUJFhzAmDER3HTjTGe5TIiAyQqOyV8c51gfIXxOmY89d6vfT65ya9AoiCYfNFi+w
         Eb1G/kU6BMkh4UHcLcN2/lf+NzpV6UMdnLDakyQDAxqMxz8/U7+Uj4xY16BfgKCP7jZ6
         dBvN6E/LgCBc/E2XVXVpTwCvIN2zLC8YZ4OVmvLuW+Mc8k3ifEo0bGMiU7nvYTr+GcvN
         oXkg==
X-Gm-Message-State: AOUpUlEBz3w34+hDBon1/g4TJ5RqU0w4Ja2WsbdXE61/f9x6QYElYUz2
        s02i6BwEV/GKQ380armMKEtZKg==
X-Google-Smtp-Source: ANB0VdaT0sd9K7p2Cl7iF1FxDFzcJR0K81OwINJku5abJEjHrdwyKKpbY5EdLHU5weioLuP6wP83lQ==
X-Received: by 2002:ac8:4152:: with SMTP id e18-v6mr21919087qtm.330.1535041786215;
        Thu, 23 Aug 2018 09:29:46 -0700 (PDT)
Received: from whitewolf.lyude.net (pool-72-74-165-95.bstnma.fios.verizon.net. [72.74.165.95])
        by smtp.gmail.com with ESMTPSA id y142-v6sm2970390qka.5.2018.08.23.09.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 09:29:45 -0700 (PDT)
Message-ID: <6f99abb8f474f064588c64e29058db5c66acae13.camel@redhat.com>
Subject: Re: [PATCH 1/5] drm/nouveau: Check backlight IDs are >= 0, not > 0
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Karol Herbst <kherbst@redhat.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>, stable@vger.kernel.org,
        Jeffery Miller <jmiller@neverware.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 23 Aug 2018 12:29:44 -0400
In-Reply-To: <CACO55tsuJUyQULA3oGm9VxH7ufObvW1bNH_1g7WCwcpJPrVugw@mail.gmail.com>
References: <20180823012151.20099-1-lyude@redhat.com>
         <20180823012151.20099-2-lyude@redhat.com>
         <CACO55tsuJUyQULA3oGm9VxH7ufObvW1bNH_1g7WCwcpJPrVugw@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-23 at 14:00 +0200, Karol Herbst wrote:
> Patches 1-5 are Reviewed-by: Karol Herbst <kherbst@redhat.com>
> 
> I think it might be worth to test those patches on a system without
> any backlight devices just to verify we don't break things, but the
> code looked good already, so maybe we don't really need to test.
Did! The P50 lets you switch between dedicated GPU mode and hybrid GPU mode, and
it switches backlight control between the intel and nvidia GPUs. Seemed to work
just fine for me
> 
> On Thu, Aug 23, 2018 at 3:21 AM, Lyude Paul <lyude@redhat.com> wrote:
> > Remember, ida IDs start at 0, not 1!
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Cc: stable@vger.kernel.org
> > Cc: Jeffery Miller <jmiller@neverware.com>
> > Cc: Karol Herbst <kherbst@redhat.com>
> > ---
> >  drivers/gpu/drm/nouveau/nouveau_backlight.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c
> > b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> > index 408b955e5c39..6dd72bc32897 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> > @@ -116,7 +116,7 @@ nv40_backlight_init(struct drm_connector *connector)
> >                                        &nv40_bl_ops, &props);
> > 
> >         if (IS_ERR(bd)) {
> > -               if (bl_connector.id > 0)
> > +               if (bl_connector.id >= 0)
> >                         ida_simple_remove(&bl_ida, bl_connector.id);
> >                 return PTR_ERR(bd);
> >         }
> > @@ -249,7 +249,7 @@ nv50_backlight_init(struct drm_connector *connector)
> >                                        nv_encoder, ops, &props);
> > 
> >         if (IS_ERR(bd)) {
> > -               if (bl_connector.id > 0)
> > +               if (bl_connector.id >= 0)
> >                         ida_simple_remove(&bl_ida, bl_connector.id);
> >                 return PTR_ERR(bd);
> >         }
> > --
> > 2.17.1
> > 

