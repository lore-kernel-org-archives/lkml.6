Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00388ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B796620685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNwuFqFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B796620685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbeJaSiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:38:22 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39430 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbeJaSiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:38:22 -0400
Received: by mail-vs1-f67.google.com with SMTP id h78so8518428vsi.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 02:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JLOKyuWil2lM3xvfP/yKsooV2WYTKZyvcGWCA2Xb5Fw=;
        b=DNwuFqFYheSjfSg+QiShokQL9apycGSzcRanCJ9Ei6go04JjBPexQUIPpW4XN1Skeb
         HswJ3QYfOngd6BluFvuav9ct2ELRvj/HSHJnwaWel2F4djkB/qXoIRycixupBmuDe/z/
         3ZINPrdXHGZEF1yhW1gIYokdY5VpwcnhK3k9Kv6Gy2ktacK/VVrWnQs+xO31GFn2jruO
         tFGegGyNmFvaFrm6E5muiTif+IncVh4R1uNlshoj6ghuxBovidpcONUATPqVviH3i3lR
         D5a2b+5SK3o5Vueolar+jVwmpc2+jqjA86zYO2x0V6JsIbh5j2FkBIx8VTeZmQphNrvD
         WHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JLOKyuWil2lM3xvfP/yKsooV2WYTKZyvcGWCA2Xb5Fw=;
        b=TAzxEI33r7tYKui73UhswolDourZ83gAQ4qKymc9Oi+G5wRQkmoy5M8Pgu8BXUfDMq
         EyFuD8ipXJn39Psah+w/cmNv9hC39zEjfb6ZSAd34hAgEBp/rXCYojO/QoZRZij+mhor
         k72RpN9AQFfEhw9obO8BN69Pb+z4IRn9PBa74incDpJT80kivbAxmFzCakQlyHBYHCGW
         EfjRqZktmbryTl9+8BT5OucZ5/TshkJdgTjbtpae0R5PkuxGcHRQ6qrqJLE8Im8pq5VB
         eEeTvZBX58jEqoQkk6nd0p8CxDS5cyKC4VBhvfoXpc52rKMRxRBWS+Lki9lhmUMnrds9
         lp2Q==
X-Gm-Message-State: AGRZ1gIS7AvMIeS+8uDTGVCwUQkXRaoHr5FnvhPn59jQEpmU9sF4Dous
        oG65ZL1XvQnyrbxIb81yfAEu9etCeGAjAqECj8I=
X-Google-Smtp-Source: AJdET5c1pz+0IrObyNh3fKcr5fdlVIYOOeF6TDAcihjiwAfLwlBGDqut8cEqEtW5mXI+/R8ozE5f3y9CuQXR0Sn++g4=
X-Received: by 2002:a67:3f0f:: with SMTP id m15mr911067vsa.37.1540978859882;
 Wed, 31 Oct 2018 02:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181025183739.9375-1-robert.foss@collabora.com> <20181025183739.9375-6-robert.foss@collabora.com>
In-Reply-To: <20181025183739.9375-6-robert.foss@collabora.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Wed, 31 Oct 2018 09:39:41 +0000
Message-ID: <CACvgo50szhS2+TMWWYwU2ctKeE6qddx2+AAuKWiL1SYp=XEjKg@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/virtio: bump driver version after explicit
 synchronization addition
To:     Robert Foss <robert.foss@collabora.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.co>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2018 at 19:38, Robert Foss <robert.foss@collabora.com> wrote:
>
> From: Gustavo Padovan <gustavo.padovan@collabora.com>
>
> To reflect the (backward compatible) changes in the uabi we are bumping
> the driver's version.
>
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co>
> Signed-off-by: Robert Foss <robert.foss@collabora.com>

Not strictly required, but doesn't hurt either.
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

-Emil
