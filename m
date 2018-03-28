Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752858AbeC1K3x (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 06:29:53 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:39679 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752113AbeC1K3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 06:29:50 -0400
X-Google-Smtp-Source: AIpwx4/2gyvGbcMmIeQou5H+554F4N5H1u3GTFTypF+gFl58IyGXU53D2YjuLQFl7Qx586WXo8xpgw==
Subject: Re: [PATCH v4 2/2] drm/xen-front: Add support for Xen PV display
 frontend
To: daniel.vetter@intel.com
References: <1522219661-26827-1-git-send-email-andr2000@gmail.com>
 <1522219661-26827-3-git-send-email-andr2000@gmail.com>
 <20180328074251.GE14155@phenom.ffwll.local>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        seanpaul@chromium.org, gustavo@padovan.org, jgross@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <32481355-27f6-695b-c6c1-8113ea268a33@gmail.com>
Date: Wed, 28 Mar 2018 13:29:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328074251.GE14155@phenom.ffwll.local>
Content-Type: multipart/mixed;
 boundary="------------6AD22DBA8A9729784F0E8A7D"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6AD22DBA8A9729784F0E8A7D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Daniel!

I just noticed I have missed one change in the patch:
the below must be static.

On 03/28/2018 10:42 AM, Daniel Vetter wrote:
> +enum drm_mode_status display_mode_valid(struct drm_crtc *crtc,
> +		const struct drm_display_mode *mode)
> +{
> +	struct xen_drm_front_drm_pipeline *pipeline =
> +			container_of(crtc,
Could you please amend the patch in attachment
when merging, so I don't resend?

Thank you in advance,
Oleksandr

--------------6AD22DBA8A9729784F0E8A7D
Content-Type: text/x-patch;
 name="0001-drm-xen-front-Make-display_mode_valid-static.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-drm-xen-front-Make-display_mode_valid-static.patch"

>From 3a82d76bd3d954056b760e5d1d09e2f96a2786ef Mon Sep 17 00:00:00 2001
From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Date: Wed, 28 Mar 2018 13:24:04 +0300
Subject: [PATCH] drm/xen-front: Make display_mode_valid static

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/gpu/drm/xen/xen_drm_front_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_kms.c b/drivers/gpu/drm/xen/xen_drm_front_kms.c
index 545049dfaf0a..bd676be5a0db 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_kms.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_kms.c
@@ -273,7 +273,7 @@ static void display_update(struct drm_simple_display_pipe *pipe,
 	drm_dev_exit(idx);
 }
 
-enum drm_mode_status display_mode_valid(struct drm_crtc *crtc,
+static enum drm_mode_status display_mode_valid(struct drm_crtc *crtc,
 		const struct drm_display_mode *mode)
 {
 	struct xen_drm_front_drm_pipeline *pipeline =
-- 
2.7.4


--------------6AD22DBA8A9729784F0E8A7D--
