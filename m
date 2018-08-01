Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FBBC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B62D208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flowbird.group header.i=@flowbird.group header.b="QFxN/ZR4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B62D208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flowbird.group
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389552AbeHAQK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 12:10:59 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40896 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389503AbeHAQK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 12:10:59 -0400
Received: by mail-wm0-f68.google.com with SMTP id y9-v6so7292849wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 07:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fFW0gMwcHcNIBQl5AwAhZoFPNGdz5M/yanddNQuo05I=;
        b=QFxN/ZR4vVN2/C1oRa85bTwU/eo5q9bUysfYjOO2bl4ElmB/W/95o6bKu+dB1NMIhO
         zU9uHDlBeqb3bGBc+0fkQOxobLGmF4yk8b0uS1EuIihCvZRGlAqC8yym76/882kDtR1z
         bc2p2jrENnxtZ8W0DOaCyqKr/r8vdJqLJhsiIv1igvruyYrmSLR2U0ZeJFHGS+J/rzpS
         HEjByut7ilWvdHEBeaRnP3Fejg3rtavJnJwj9+5DU9HjWe1St01c86m/SMnW8yJNhb3Q
         9YvWOAvX3TKnCW+2sUjPRT3Y83M2AHgAXEa51fExk63SUWsSmKUmDrChROMAQMFAsNpE
         AKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fFW0gMwcHcNIBQl5AwAhZoFPNGdz5M/yanddNQuo05I=;
        b=o3Gv4Y1z+9P2jWabxrUDECsBDi45dajajGb4CLAcv0gMXfesuXfVLdbrvERAUeaxXy
         q/JHKaAx3/KXpTrqc9hKUU776cAgda1Jw1HrjHxpkauqZR3RuCim38nLH18CfmPkbBCz
         EfkFidi3oqj4y1UqzboDe/HYlJHP415Dc9VMKwklsehD2XP60otuZ4iG3VUNCxtm1C1o
         AxYI81n+SwLk16VeT4g89D25w9i8y31421Ba//Fv5C03/+XSFGcO1lM9Y7sZuI8YwoNg
         xwlYnpdqSdc7OwRsbvigbmnYCVbJK4J7/nILyA8tFVEK/bOP/2U+SAHtD2wZuqdKQf2G
         NJDg==
X-Gm-Message-State: AOUpUlHnG+/IfYVPST2D3jOtXcNTwIXVAuWcjj3HTl0QzfTk0o1SAa0M
        s3aMb4DIN8pEudpYkY7O7Bqm+Q==
X-Google-Smtp-Source: AAOMgpfA9DhbcvnnBz1lskCPfpmslRVBVkifISwuRGZ/2khpd63RU0/HM7wi+Ejas2GjmtaNzN1iFw==
X-Received: by 2002:a1c:96c8:: with SMTP id y191-v6mr2832771wmd.37.1533133497276;
        Wed, 01 Aug 2018 07:24:57 -0700 (PDT)
Received: from [10.32.51.159] ([185.149.63.251])
        by smtp.gmail.com with ESMTPSA id w185-v6sm7059700wmw.6.2018.08.01.07.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 07:24:56 -0700 (PDT)
To:     robert.foss@collabora.com
Cc:     airlied@linux.ie, brianp@vmware.com,
        dri-devel@lists.freedesktop.org, emil.l.velikov@gmail.com,
        eric.engestrom@intel.com, gustavo@padovan.org,
        linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        norvez@chromium.org, robh@kernel.org, seanpaul@chromium.org,
        tfiga@chromium.org, tomeu.vizoso@collabora.com
References: <20180724082213.25677-1-robert.foss@collabora.com>
Subject: Re: [RFC] drm: Allow DRM_IOCTL_MODE_MAP_DUMB for render nodes
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
Message-ID: <f718f3ec-3726-3f51-6756-80b357fc23c9@flowbird.group>
Date:   Wed, 1 Aug 2018 16:24:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724082213.25677-1-robert.foss@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am running into the same problem using etnaviv on i.MX6 under Android 8.1

The mesa etnaviv code uses CREATE_DUMB / MAP_DUMB for the scanout buffers
and is called from the surfaceflinger process.

But, under Android 8.1 drm_hwcomposer runs in a seperate process to surfaceflinger.
Since drm_hwcomposer needs to use the KMS API it must be the DRM master,
that means that surface flinger cannot be DRM master too.

Adding a render node to the imx drm device and configuring mesa to user fixes
the problem but requires the render node to have access rights to use CREATE_DUMB
/ MAP_DUMB.


Here is my full patch:

Make imx-drm export a render node so that mesa can use it to allocate

From: Martin Fuzzey <martin.fuzzey@flowbird.group>
Date: 2018-07-26 15:37:28 +0200

dumb memory rather than requiring the master node.

The problem with using the master node is that, on android 8.1, drm_hwcomposer
is a seperate process and must be the master node (to use the KMS API),
since only a single process may be master surfaceflinger cannot be master too.

With this change surfaceflinger can use just a rendernode.

Note that we also have to modify the permissions table to allow render nodes
to use the dumb allocation functions. This is a hack and unlikely to be accepted
upstream but it's better than the huge security hole of allowing everything we were
using before.

Need to discuss an upstream acceptable way for this...
---
  drivers/gpu/drm/drm_ioctl.c        |    6 +++---
  drivers/gpu/drm/imx/imx-drm-core.c |    2 +-
  2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index a9ae6dd..31c4c86 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -639,9 +639,9 @@ int drm_ioctl_permit(u32 flags, struct drm_file *file_priv)
  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_RMFB, drm_mode_rmfb, DRM_CONTROL_ALLOW|DRM_UNLOCKED),
  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_PAGE_FLIP, drm_mode_page_flip_ioctl, DRM_MASTER|DRM_CONTROL_ALLOW|DRM_UNLOCKED),
  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_DIRTYFB, drm_mode_dirtyfb_ioctl, DRM_MASTER|DRM_CONTROL_ALLOW|DRM_UNLOCKED),
-	DRM_IOCTL_DEF(DRM_IOCTL_MODE_CREATE_DUMB, drm_mode_create_dumb_ioctl, DRM_CONTROL_ALLOW|DRM_UNLOCKED),
-	DRM_IOCTL_DEF(DRM_IOCTL_MODE_MAP_DUMB, drm_mode_mmap_dumb_ioctl, DRM_CONTROL_ALLOW|DRM_UNLOCKED),
-	DRM_IOCTL_DEF(DRM_IOCTL_MODE_DESTROY_DUMB, drm_mode_destroy_dumb_ioctl, DRM_CONTROL_ALLOW|DRM_UNLOCKED),
+	DRM_IOCTL_DEF(DRM_IOCTL_MODE_CREATE_DUMB, drm_mode_create_dumb_ioctl, DRM_CONTROL_ALLOW|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF(DRM_IOCTL_MODE_MAP_DUMB, drm_mode_mmap_dumb_ioctl, DRM_CONTROL_ALLOW|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF(DRM_IOCTL_MODE_DESTROY_DUMB, drm_mode_destroy_dumb_ioctl, DRM_CONTROL_ALLOW|DRM_UNLOCKED|DRM_RENDER_ALLOW),
  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_OBJ_GETPROPERTIES, drm_mode_obj_get_properties_ioctl, DRM_CONTROL_ALLOW|DRM_UNLOCKED),
  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_OBJ_SETPROPERTY, drm_mode_obj_set_property_ioctl, DRM_MASTER|DRM_CONTROL_ALLOW|DRM_UNLOCKED),
  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_CURSOR2, drm_mode_cursor2_ioctl, DRM_MASTER|DRM_CONTROL_ALLOW|DRM_UNLOCKED),
diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
index f91cb72..0c34306 100644
--- a/drivers/gpu/drm/imx/imx-drm-core.c
+++ b/drivers/gpu/drm/imx/imx-drm-core.c
@@ -177,7 +177,7 @@ int imx_drm_encoder_parse_of(struct drm_device *drm,
  
  static struct drm_driver imx_drm_driver = {
  	.driver_features	= DRIVER_MODESET | DRIVER_GEM | DRIVER_PRIME |
-				  DRIVER_ATOMIC,
+				  DRIVER_ATOMIC | DRIVER_RENDER,
  	.lastclose		= imx_drm_driver_lastclose,
  	.gem_free_object_unlocked = drm_gem_cma_free_object,
  	.gem_vm_ops		= &drm_gem_cma_vm_ops,

If it is not acceptable to modify the access rights for the DUMB allocation functions how should this be done?

Best regards,

Martin




