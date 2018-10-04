Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8472FC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DE820877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55DE820877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbeJDV6T convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:58:19 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38452 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeJDV6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:58:19 -0400
Received: by mail-qk1-f194.google.com with SMTP id 204-v6so5930129qkd.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 08:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DnD8cttT5zIM/FpVR2gKnX4yxDJPS1ytyJ9JkzDajHM=;
        b=cW+vDjHEmFuTN//hKnttnPmb3hsoK2sYA1Hkk4mDhFG49xE6zk2OfVDcbvNYSf44+5
         BSB0165rDLus7nGI2TBoSfFoXha1oqLFXZz9HdUR3h+UU+5884GHe71csHxAREEIxLnM
         04BcMGZ3Xw66Wl9fzqIg7/K3htr87AJji1InvDYLLZB4nRXj2giXgZ2sWOeIWAKnHQqt
         k+bH616g86nLABzMp6afO78SmbNWDSUxJeO4Xh+b5H7xIvA98TveXy3MqsGaR4Vp9cnU
         lJX3+P9JftxiCK88xblfgU1p3l3JigcF5+NrMeSERbluaX33G5R2REH18qwZ5foln6s9
         m5LQ==
X-Gm-Message-State: ABuFfoiqE8dsxxsj2ZCBbHPWXVuQtWPMRhvgIM/a3hn7q/fBO5KpGOAD
        iPBkTNRGtEr0S8GYlJ1+WyAxx6OP41KFipdu4SxsnQ==
X-Google-Smtp-Source: ACcGV61DQVfNyPagcuG31vCvbruAYPXNer01Jrfkm3P1PqLQEo+AMmIRF/G7qguuXqaxn1cLs3QTqTnbaXFSwvTWMbY=
X-Received: by 2002:a37:7347:: with SMTP id o68-v6mr5575762qkc.291.1538665477827;
 Thu, 04 Oct 2018 08:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20181002205836.2323084-1-arnd@arndb.de> <123f7e1c-8f2b-5797-de16-650ec01d0b24@tronnes.org>
 <20181003161326.GD31561@phenom.ffwll.local> <CAK8P3a1gKxXEthLvUxSxOrt6+1qzZE9Jba+vH_qFepv3KXba9g@mail.gmail.com>
 <CAKMK7uFn=u+04=HQvzkSNdE8_9p=3eX14-h=0nOJ7QKPJSrdmw@mail.gmail.com> <af5994a3-5739-ed7f-4374-85e9d19d2408@tronnes.org>
In-Reply-To: <af5994a3-5739-ed7f-4374-85e9d19d2408@tronnes.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Oct 2018 17:04:21 +0200
Message-ID: <CAK8P3a1fzr9kX4kNcAnM4ZPh_-Kp61326zrbhDjHyPJJrJq=OQ@mail.gmail.com>
Subject: Re: [PATCH] drm/imx: move 'legacyfb_depth' definition out of #ifdef
To:     noralf@tronnes.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>, tzimmermann@suse.de,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 4:43 PM Noralf Trønnes <noralf@tronnes.org> wrote:
> Den 04.10.2018 09.48, skrev Daniel Vetter:
> > On Wed, Oct 3, 2018 at 9:51 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >> On Wed, Oct 3, 2018 at 6:13 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> >>> On Wed, Oct 03, 2018 at 05:49:32PM +0200, Noralf Trønnes wrote:
> >>>>
> >>>> Den 02.10.2018 22.58, skrev Arnd Bergmann:
> >>>>> The variable is now referenced unconditionally, but still
> >>>>> declared in an #ifdef:
> >>>>>
> >>>>> drivers/gpu/drm/imx/imx-drm-core.c: In function 'imx_drm_bind':
> >>>>> drivers/gpu/drm/imx/imx-drm-core.c:264:6: error: 'legacyfb_depth' undeclared (first use in this function); did you mean 'lockdep_depth'?
> >>>>>
> >>>>> Remove the #ifdef so it can always be accessed.
> >>>>>
> >>>>> Fixes: f53705fd9803 ("drm/imx: Use drm_fbdev_generic_setup()")
> >>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >>>>> ---
> >>>> I've already applied the previous one you sent:
> >>>> https://cgit.freedesktop.org/drm/drm-misc/commit/?id=064b06bbf117f8b5e64a5143e970d5a1cf602fd6
> >>>>
> >>>> Not sure when it reaches linux-next now that we are past rc6.
> >>> Only once we're past -rc1.
> >> Can we revert f53705fd9803 in linux-next then to prevent the regression from
> >> making it into 4.20?
> > Probably simpler to cherry pick the fix from drm-misc-next to
> > drm-misc-next-fixes. Noralf, can you pls do that?
>
> Would this be the correct procudure:
>
>      dim update-branches
>      dim create-workdir drm-misc-next-fixes
>      <build>
>      CONFIG_DRM_FBDEV_EMULATION=n
>      <build will break>
>      git cherry-pick 064b06bbf117f8b5e64a5143e970d5a1cf602fd6
>      <build passes>
>      dim push-branch drm-misc-next-fixes
>
> I read that cherry picking creates a new commit with a new hash.
> But since you ask me to do this, I assume git will handle this when
> branches are merged?

The git history will show both commit IDs, which is a bit ugly but
ok if it's rare enough. There is a chance for creating a conflict if the
backport changes context, or one branch contains extra changes
that touch the same lines, but usually this is not a problem.

      Arnd
