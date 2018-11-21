Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589D8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAD5214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FAD5214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731622AbeKVFcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:32:00 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40485 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731565AbeKVFcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:32:00 -0500
Received: by mail-qt1-f193.google.com with SMTP id k12so4984133qtf.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 10:56:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=rGO7rgJtbLIXb2SiL6JdRjv3nm9lxoiSmDGCFdiXhM8=;
        b=M8CTNuZ56I4VeaAK4F1cfcQEFFW0c0u+pLcJxPS4kTJu9J0v04DqXRS+yRhzfdIkBr
         VbNjmWRlVuHNKAEprscvV0H/XSrO1U+he9BNBqFt/fNH4kxg34tCJOsrtNIGpFCQ8JLJ
         xv9y4s4l1AeGLqQ6JCGyTluJkVeDdVfDqcJyouql9+pwVrDlkfoWdF7BwXrpQAKMVlJw
         GM7XCGj8JW3d9jMDqVdVN/8IT54qyqOUIg2hItJKjtjG4fJHA+EaSXEuu1/hzsuf1aIB
         rBTmJiHXNH1p5lxfDj7Y2wizdpThO/FjpwSC3Po7W9Jj2PZ/0QKhP/YZ9ktSzviBHMCO
         zx+Q==
X-Gm-Message-State: AGRZ1gINQoO174se1BXL/9WZXPUPUPiSISIsjwvekk6Iw1r8Si4G9mLR
        4c3fXjIWBWswnSiotHv4RhNEMw==
X-Google-Smtp-Source: AJdET5e1zmGQAHZaKIaIoyXNl9r4eUa/jceyPmGodrlkZQDQykvnxzbHZw6sPfysRocT4ccE81e6Lg==
X-Received: by 2002:aed:2f82:: with SMTP id m2mr7300202qtd.4.1542826587054;
        Wed, 21 Nov 2018 10:56:27 -0800 (PST)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id z8sm17916795qto.45.2018.11.21.10.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 10:56:26 -0800 (PST)
Message-ID: <db5924d66229bd8b50e44395ace64ae2293fa78d.camel@redhat.com>
Subject: Re: [PATCH 6/9] drm: remove deprecated
 "drm_connector_[un]reference" functions
From:   Lyude Paul <lyude@redhat.com>
To:     Fernando Ramos <greenfoo@gluegarage.com>,
        dri-devel@lists.freedesktop.org
Cc:     Haneen Mohammed <hamohammed.sa@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
        cocci@systeme.lip6.fr, Marek Vasut <marex@denx.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Alexey Brodkin <abrodkin@synopsys.com>,
        David Airlie <airlied@linux.ie>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        etnaviv@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        virtualization@lists.linux-foundation.org,
        Sean Paul <sean@poorly.run>,
        linux-arm-kernel@lists.infradead.org,
        Michal Marek <michal.lkml@markovi.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Shawn Guo <shawnguo@kernel.org>
Date:   Wed, 21 Nov 2018 13:56:24 -0500
In-Reply-To: <20181115221634.22715-7-greenfoo@gluegarage.com>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
         <20181115221634.22715-7-greenfoo@gluegarage.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Thu, 2018-11-15 at 23:16 +0100, Fernando Ramos wrote:
> There are no more places where this (deprecated) function is being
> used from, thus it can now be removed.
> 
> Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>
> ---
>  include/drm/drm_connector.h | 24 ------------------------
>  1 file changed, 24 deletions(-)
> 
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 9ccad6b062f2..b91b206f1665 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1191,30 +1191,6 @@ static inline void drm_connector_put(struct
> drm_connector *connector)
>  	drm_mode_object_put(&connector->base);
>  }
>  
> -/**
> - * drm_connector_reference - acquire a connector reference
> - * @connector: DRM connector
> - *
> - * This is a compatibility alias for drm_connector_get() and should not be
> - * used by new code.
> - */
> -static inline void drm_connector_reference(struct drm_connector *connector)
> -{
> -	drm_connector_get(connector);
> -}
> -
> -/**
> - * drm_connector_unreference - release a connector reference
> - * @connector: DRM connector
> - *
> - * This is a compatibility alias for drm_connector_put() and should not be
> - * used by new code.
> - */
> -static inline void drm_connector_unreference(struct drm_connector
> *connector)
> -{
> -	drm_connector_put(connector);
> -}
> -
>  /**
>   * drm_connector_is_unregistered - has the connector been unregistered from
>   * userspace?
-- 
Cheers,
	Lyude Paul

