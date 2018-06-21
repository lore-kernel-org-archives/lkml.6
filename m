Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792C9C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD1F20846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="E2NctQWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD1F20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932459AbeFUGyF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 02:54:05 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50988 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932430AbeFUGyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 02:54:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id e16-v6so3232460wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 23:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5ycLaSUyNMgs92iZadFULkXZwJ4O1+yQxtTh8vI25Mw=;
        b=E2NctQWA67MlWMMZ20O8B9qVT2cn1zuLhxRTukWzHMq0J5JMEaZq/IvNsP/UwB00+p
         3bVzZz8z3uLgqySoI2gK0Qox6g7jkZRZ//Zy1p2BJk+J4zNl1lbNLDHMbodirut3jUHj
         0eZh/hbk2YayL8zkvfqgv8aouVqEZEhtsv5P4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=5ycLaSUyNMgs92iZadFULkXZwJ4O1+yQxtTh8vI25Mw=;
        b=PsUZLSK8h8dxFvmFgCKYrquF1To8wt0tnqahI0a/bcRK7rFLJV3xgz7iYHxwfCJg78
         f6dC+NGROl2GomQg9sadBrtGW4jGCH5jCfe70J9o/vkL6H4YlPP18UiFahrEerNeKRy3
         /LMPwD29N4qcpJwPX0/g+OrJ/0E2WIskcMzlu1QUkLgWJUyyY5PnREImVNkryiAF0O2j
         +0BcnH86xAyMHnmEEEagxUEuURNk+/nuMYyirMlUi3XwuwqZ5rZF6hE5tut+7++Y8SVH
         MkLN57iX1jXVBp5tz/DiYrhXNNIE2B0FFpGSaeOO6AKblgQ6TUG15shPFN/12785xAVO
         eUNw==
X-Gm-Message-State: APt69E0jjpYsNvg3ysv5XeanR1RVAT48/7hrmiHdkiUynhdI8+R5PWwe
        w+NdHjn3xpHnqf4uEcr+z9iM9Q==
X-Google-Smtp-Source: ADUXVKKNK6v8n8+JqX+kBjnw2Oc8BDbWLzhxX7k8CuGfRRc0zu1HG2uNCqwN/ydZGpo6K+J6qvANNg==
X-Received: by 2002:a50:aada:: with SMTP id r26-v6mr20930601edc.124.1529564042506;
        Wed, 20 Jun 2018 23:54:02 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:9802:bb08:74d1:12e1])
        by smtp.gmail.com with ESMTPSA id d7-v6sm1590852edi.79.2018.06.20.23.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 23:54:01 -0700 (PDT)
Date:   Thu, 21 Jun 2018 08:54:00 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/v3d: Define the fourcc modifier for the Broadcom UIF
 format.
Message-ID: <20180621065359.GE19791@phenom.ffwll.local>
Mail-Followup-To: Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180621001703.13522-1-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621001703.13522-1-eric@anholt.net>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 05:17:03PM -0700, Eric Anholt wrote:
> This will be used by Mesa, and potentially other drivers in the
> future, to describe tiled buffers.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  include/uapi/drm/drm_fourcc.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index 64bf67abff7e..d5e52350a3aa 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -464,6 +464,27 @@ extern "C" {
>  #define DRM_FORMAT_MOD_BROADCOM_SAND256 \
>  	DRM_FORMAT_MOD_BROADCOM_SAND256_COL_HEIGHT(0)
>  
> +/* Broadcom UIF format
> + *
> + * This is the common format for the current Broadcom multimedia
> + * blocks, including V3D 3.x and newer, newer video codecs, and
> + * displays.
> + *
> + * The image consists of utiles (64b blocks), UIF blocks (2x2 utiles),
> + * and macroblocks (4x4 UIF blocks).  Those 4x4 UIF block groups are
> + * stored in columns, with padding between the columns to ensure that
> + * moving from one column to the next doesn't hit the same SDRAM page
> + * bank.
> + *
> + * To calculate the padding, it is assumed that each hardware block
> + * and the software driving it knows the platform's SDRAM page size,
> + * number of banks, and XOR address, and that it's identical between
> + * all blocks using the format.  This tiling modifier will use XOR as
> + * necessary to reduce the padding.  If a hardware block can't do XOR,
> + * the assumption is that a no-XOR tiling modifier will be created.
> + */

I think for as long as a modifier is only for a specific SoC, and not e.g.
also meant for pci devices, it's perfectly fine to heavily rely on
platform specific "every block agrees" language like here. We do the same
for intel's X/Y tiling on older chips (latest gens stopped doing funky
swizzling because the memory controllers seem to be better).

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> +#define DRM_FORMAT_MOD_BROADCOM_UIF fourcc_mod_code(BROADCOM, 6)
> +
>  #if defined(__cplusplus)
>  }
>  #endif
> -- 
> 2.17.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
