Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100F9C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDED020874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BunqVYS9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDED020874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753989AbeFTMUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:20:40 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38272 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753594AbeFTMUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:20:34 -0400
Received: by mail-lf0-f67.google.com with SMTP id i83-v6so4637084lfh.5;
        Wed, 20 Jun 2018 05:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NjmDV2MCHDrHnbDODdX3fnqxT0nvuQRKu/jpHHAEUBs=;
        b=BunqVYS9+q27WQ1Ar+ZT/JMekxxM+SmDJ6Av7/lbr3lXkwpndLtx5Hb/Sf0UpYtX01
         6ItHonw2lxBYNNXGB8I3nrOgQzPZvDtPC8wFmPCkxI6mMJqTD2zOhs4reHwccvLcH6Ee
         St2GV746dne8yW/iVqPufaogsgb6gx6CynMaa+0lz1xGVsqpagm/SlVjRjNIcDeYkncH
         HCbW8EeLBXRr5nAyWV9k8P5OIPGQHaAKtHAGZrprtZMBdzjSt/pDIcQcW9jiJ+Sr8G0d
         82O9Ckw8ChpYdJnVeekdFezS2cqXpcOEsNdyNDfKMChOwVgsJjBPoaETZab61gwgEXwH
         AP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NjmDV2MCHDrHnbDODdX3fnqxT0nvuQRKu/jpHHAEUBs=;
        b=jRQEJmeBTVuffdtFPJQULGiSWFGNcuGgSOo9JjAwz0iQWP+HbWvm962Mb9WbnaprAN
         QhEHTAZcyutfbcsEuGpjGAYtxsjodYDiKLK2zl9c3BIaAK1ogGUigLsQxa9UV1UiSCgp
         J54dYE41ofUn0wL39kDTpByXmIksEa1LoHaYw3xDyv/xBgqM7kn1z9tk+wX+H1daUBMs
         g3YAuISAqWRb+ffTrMXU6ts++hgaJ5gki9BQwXqVjp+R1tKXNf0oP0Sh3VszbCAt12Oz
         e6Vrq7shd/x5xZbXi+DZpr4wUXFVLhUobUMvqII8W4hoW1GlaovzL3Oe+2AAcJkemTTa
         fggw==
X-Gm-Message-State: APt69E0LcxTvZUHQoAf5ryOWRy4W6uTbVfnZHwW4xUc5FIZjXQXQPRQR
        hS4K4soR41Du+I7oRO1sN+Y=
X-Google-Smtp-Source: ADUXVKJfrcgEFQq213kd52Iep1Sofvnc55htbHXV+bqDRYabnIrqUlJo/l/WaOyhgCQRuxM9U2VbdQ==
X-Received: by 2002:a2e:980f:: with SMTP id a15-v6mr13923577ljj.143.1529497233048;
        Wed, 20 Jun 2018 05:20:33 -0700 (PDT)
Received: from dimapc.localnet (109-252-91-84.nat.spd-mgts.ru. [109.252.91.84])
        by smtp.gmail.com with ESMTPSA id q73-v6sm382447lje.53.2018.06.20.05.20.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 05:20:32 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alexandru Gheorghe <Alexandru_Gheorghe@mentor.com>,
        "open list:DRM DRIVERS FOR RENESAS" 
        <linux-renesas-soc@vger.kernel.org>, linux-tegra@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/2] drm: Add generic colorkey properties
Date:   Wed, 20 Jun 2018 15:20:31 +0300
Message-ID: <18882685.yDnGXdaDdQ@dimapc>
In-Reply-To: <CAKMK7uGMKs2GgP+nrxDV4LbbmrqcHApLsz9pTc=mQojHtSVaUQ@mail.gmail.com>
References: <20180526155623.12610-1-digetx@gmail.com> <20180620093321.GL17671@n2100.armlinux.org.uk> <CAKMK7uGMKs2GgP+nrxDV4LbbmrqcHApLsz9pTc=mQojHtSVaUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 20 June 2018 13:10:07 MSK Daniel Vetter wrote:
> On Wed, Jun 20, 2018 at 11:33 AM, Russell King - ARM Linux
> 
> <linux@armlinux.org.uk> wrote:
> > On Wed, Jun 20, 2018 at 11:17:50AM +0200, Daniel Vetter wrote:
> >> Yes -modesetting (or whichever other driver) would need to set up the
> >> properties correctly for Xvideo color keying. Since default assumption
> >> for
> >> all other (generic) compositors is that planes won't do any color keying
> >> in the boot-up state.
> > 
> > Thanks, is that documented anywhere?
> 
> With the standardization of properties I'm also trying to get these
> expectations better documented, e.g.
> 
> https://dri.freedesktop.org/docs/drm/gpu/drm-kms.html#plane-composition-prop
> erties
> 
> But I think we're not doing a good job yet documenting default
> expectations. But the above would be a good place to get that fixed -
> this patch here should do that, at least for color keying.
> -Daniel

There is a comment in this patch that says:

+ * colorkey.mode:
+ *     The mode is an enumerated property that controls how color keying
+ *     operates. The "disabled" mode that disables color keying and is
+ *     very likely to exist if color keying is supported, it should be the
+ *     default mode.

So the default-disabled state is kinda documented. Though that comment is 
omitted in the v3, I'll correct that in the next revision.

For now one question that keeps this patchset in RFC state is about how to 
expose the color key value properties to userspace, whether having drivers to 
perform RGB->YUV conversion is a viable way (see the v3 of the patchset).


