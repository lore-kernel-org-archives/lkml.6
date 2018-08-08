Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9879C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AD12174A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81AD12174A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeHHQRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:17:40 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:41562 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbeHHQRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:17:40 -0400
Received: by mail-qk0-f180.google.com with SMTP id n85-v6so1533089qke.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 06:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l710NTRBvtUA0YFTjsseS2S06VuPSwZLALeZsB4YOIU=;
        b=OTQgwC5nY7OfgC+h3NH4R9+jPP6b0Vjls1vZmigMPV6UlaHAtQDFmxRV3V37WVUh/u
         uycpsTXklWdZIMldQy3qMMoP8XWH26Fp58QNbEAY8oIKTHTjpco9uB9m7+ZZO+QPkQNU
         ErnCVBbLuFfvibjZiqizPWWI+tFa72aS5ZK5XiOZe9K+ecadekALHnMe9YMOmweJHeb2
         3Kzz4a86GU27nCEtzBBoD457H2AQU5fLwZz25YjP+g/uj1etzlI1wnl/A17vjgt53WSX
         WqzdG8q4ccA7NjBw4KxbXqdzhKf9vqVkM/cGr3hsuHSZE00Az7n9MFiQgj3BT6hg0oPk
         MV+A==
X-Gm-Message-State: AOUpUlHBF0W3MwPrbwQDI/PJ6fYKm003tfZMoNUBeOu4F+EX3hZ4hXB8
        eVe4fCGYyOYDqlz6/v1zYlHyjA==
X-Google-Smtp-Source: AA+uWPxWC3VacPN1r5LvLRDtAo6CONAYMeieLgsFbepEJysEgqaA/Ueui1SXhWd/YD0Vdn+ech7psA==
X-Received: by 2002:a37:6809:: with SMTP id d9-v6mr2436041qkc.444.1533736672451;
        Wed, 08 Aug 2018 06:57:52 -0700 (PDT)
Received: from dhcp-10-20-1-165.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id f184-v6sm2538439qkc.23.2018.08.08.06.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 06:57:51 -0700 (PDT)
Message-ID: <ac4f27f33cbe87bea059145ec669b3c00961d61f.camel@redhat.com>
Subject: Re: [PATCH v3] drm/cirrus: flip default from 24bpp to 16bpp
From:   Adam Jackson <ajax@redhat.com>
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Dave Airlie <airlied@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>
Date:   Wed, 08 Aug 2018 09:57:50 -0400
In-Reply-To: <20180808111311.30311-1-kraxel@redhat.com>
References: <20180808111311.30311-1-kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-08 at 13:13 +0200, Gerd Hoffmann wrote:
> The problem with 24bpp is that it is a rather unusual depth these days,

Nit: s/depth/bpp/ here. Depth 24 is very common, it's packing that into
three bytes per pixel that's unusual.

> cirrus is pretty much the only relevant device still using that, and it
> is a endless source of issues.  Wayland doesn't support it at all.  Bugs
> in Xorg keep showing up.
> 
> Typically either 32bpp or 16bpp are used.  Using 32bpp would limit the
> resolution to 800x600 due to hardware constrains.  So lets go with 16bpp.
> 
> Also use the default depth for the framebuffer console and
> mode_info->preferred_depth.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Adam Jackson <ajax@redhat.com>

- ajax
