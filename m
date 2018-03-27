Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-22565-1522168861-2-2282342126480801582
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522168860; b=FuSV2FKflumArd61pTll9cZ1aQ6JZKUQeMnwt1XG+9ZWrRs
    aKX+pORH7qKed0mi0SmL7UWBROQzxSmBZEzBoJjp7Zxe8b83lDFtLzgdmPqLnFM5
    KIOItybKHAcSxpRGurJAlAzj0z69M1ZLbvMVNbUT70MX0BYYWXP0GQKvZn4dOLo8
    pBvuF62G810k0Mgzl6Zk0PXmz5/+1reWbhm9CnB4LTH0GR7c0GzcZfj/85yzbngA
    0fQftBhU7+v6QHUd4HoNGopONLotg0LjN9wXR2a05+ydk2DP7WgdeROZ9XycQK4S
    YQTdjZuFKq3Aljpll5kC3cDyYFY7tH4y6iKMsWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522168860; bh=eeWm2Y6zv+bZYy2PLRwy/LOUok
    9GYPkXFc6OlgwaHYg=; b=iZFStoEXcGFldpe5Zl69SgOuy4Mh7QAbP+O0St/eZK
    o3l874V3nrfHgsHeiZR1cYJljsltE6vxp5LUUQEd4HA0BqlZb7dLDfLzvfayjTq6
    LScn56Z+VhwBPHwqJuk/8qF1/JSFTT9KQ2DMloinSN7t4f8Fe2e2u9SAST/D1ilK
    uBLIauv7u+uT16eZpJRDfsDiXkwgc7wqPwf36l637QVB6PGm4jXxZ8VK6qF3CFo2
    mst/yA+zUGw7vEtYegUG1roo0gYGp6m044vos12mbOF92HKPhdLeScC6hbtJFwt5
    1jt62Xe6zclrt1VW094TeH9kQcVBei7DBp4DcYwu9INw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFmytrN8XX2KB8GLl0SQ6AdndYtJBCDBf2s2KCJZwanIDWmk+3Tv+2/V9na69mFkZcxa2oq7X7gWa7DqcTPjnrNV/eFopLOATlvr/KJKRu5NUiZEs/xN
    rI8jlqdBdDGY3wHy7QrIJuTbMJOzszLbiYDTx/YDeXZatMJxrBL4WHvpMI+DvIWE1YR6Wvqxf/FhtWQsWJY38h+/lrfNyMoUHOGY635LPpJgGe6MIfh4RtCy
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=eh1Yez-EAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=MCgrjztaFs7i6r3_FckA:9
    a=WsVSrwegqUGLceBU:21 a=wW4xOEmV54tTlwTx:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932460AbeC0Qk6 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:40:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48530 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932459AbeC0Qk4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:40:56 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Hellstrom <thellstrom@vmware.com>,
        Brian Paul <brianp@vmware.com>, Sinclair Yeh <syeh@vmware.com>
Subject: [PATCH 4.15 056/105] drm/vmwgfx: Fix a destoy-while-held mutex problem.
Date: Tue, 27 Mar 2018 18:27:36 +0200
Message-Id: <20180327162800.857416539@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Hellstrom <thellstrom@vmware.com>

commit 73a88250b70954a8f27c2444e1c2411bba3c29d9 upstream.

When validating legacy surfaces, the backup bo might be destroyed at
surface validate time. However, the kms resource validation code may have
the bo reserved, so we will destroy a locked mutex. While there shouldn't
be any other users of that mutex when it is destroyed, it causes a lock
leak and thus throws a lockdep error.

Fix this by having the kms resource validation code hold a reference to
the bo while we have it reserved. We do this by introducing a validation
context which might come in handy when the kms code is extended to validate
multiple resources or buffers.

Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Brian Paul <brianp@vmware.com>
Reviewed-by: Sinclair Yeh <syeh@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c  |   28 +++++++++++++++++++---------
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h  |   12 +++++++++---
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c |    5 +++--
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c |    5 +++--
 4 files changed, 34 insertions(+), 16 deletions(-)

--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -31,7 +31,6 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_rect.h>
 
-
 /* Might need a hrtimer here? */
 #define VMWGFX_PRESENT_RATE ((HZ / 60 > 0) ? HZ / 60 : 1)
 
@@ -2531,9 +2530,12 @@ void vmw_kms_helper_buffer_finish(struct
  * Helper to be used if an error forces the caller to undo the actions of
  * vmw_kms_helper_resource_prepare.
  */
-void vmw_kms_helper_resource_revert(struct vmw_resource *res)
+void vmw_kms_helper_resource_revert(struct vmw_validation_ctx *ctx)
 {
-	vmw_kms_helper_buffer_revert(res->backup);
+	struct vmw_resource *res = ctx->res;
+
+	vmw_kms_helper_buffer_revert(ctx->buf);
+	vmw_dmabuf_unreference(&ctx->buf);
 	vmw_resource_unreserve(res, false, NULL, 0);
 	mutex_unlock(&res->dev_priv->cmdbuf_mutex);
 }
@@ -2550,10 +2552,14 @@ void vmw_kms_helper_resource_revert(stru
  * interrupted by a signal.
  */
 int vmw_kms_helper_resource_prepare(struct vmw_resource *res,
-				    bool interruptible)
+				    bool interruptible,
+				    struct vmw_validation_ctx *ctx)
 {
 	int ret = 0;
 
+	ctx->buf = NULL;
+	ctx->res = res;
+
 	if (interruptible)
 		ret = mutex_lock_interruptible(&res->dev_priv->cmdbuf_mutex);
 	else
@@ -2572,6 +2578,8 @@ int vmw_kms_helper_resource_prepare(stru
 						    res->dev_priv->has_mob);
 		if (ret)
 			goto out_unreserve;
+
+		ctx->buf = vmw_dmabuf_reference(res->backup);
 	}
 	ret = vmw_resource_validate(res);
 	if (ret)
@@ -2579,7 +2587,7 @@ int vmw_kms_helper_resource_prepare(stru
 	return 0;
 
 out_revert:
-	vmw_kms_helper_buffer_revert(res->backup);
+	vmw_kms_helper_buffer_revert(ctx->buf);
 out_unreserve:
 	vmw_resource_unreserve(res, false, NULL, 0);
 out_unlock:
@@ -2595,11 +2603,13 @@ out_unlock:
  * @out_fence: Optional pointer to a fence pointer. If non-NULL, a
  * ref-counted fence pointer is returned here.
  */
-void vmw_kms_helper_resource_finish(struct vmw_resource *res,
-			     struct vmw_fence_obj **out_fence)
+void vmw_kms_helper_resource_finish(struct vmw_validation_ctx *ctx,
+				    struct vmw_fence_obj **out_fence)
 {
-	if (res->backup || out_fence)
-		vmw_kms_helper_buffer_finish(res->dev_priv, NULL, res->backup,
+	struct vmw_resource *res = ctx->res;
+
+	if (ctx->buf || out_fence)
+		vmw_kms_helper_buffer_finish(res->dev_priv, NULL, ctx->buf,
 					     out_fence, NULL);
 
 	vmw_resource_unreserve(res, false, NULL, 0);
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
@@ -240,6 +240,11 @@ struct vmw_display_unit {
 	int set_gui_y;
 };
 
+struct vmw_validation_ctx {
+	struct vmw_resource *res;
+	struct vmw_dma_buffer *buf;
+};
+
 #define vmw_crtc_to_du(x) \
 	container_of(x, struct vmw_display_unit, crtc)
 #define vmw_connector_to_du(x) \
@@ -296,9 +301,10 @@ void vmw_kms_helper_buffer_finish(struct
 				  struct drm_vmw_fence_rep __user *
 				  user_fence_rep);
 int vmw_kms_helper_resource_prepare(struct vmw_resource *res,
-				    bool interruptible);
-void vmw_kms_helper_resource_revert(struct vmw_resource *res);
-void vmw_kms_helper_resource_finish(struct vmw_resource *res,
+				    bool interruptible,
+				    struct vmw_validation_ctx *ctx);
+void vmw_kms_helper_resource_revert(struct vmw_validation_ctx *ctx);
+void vmw_kms_helper_resource_finish(struct vmw_validation_ctx *ctx,
 				    struct vmw_fence_obj **out_fence);
 int vmw_kms_readback(struct vmw_private *dev_priv,
 		     struct drm_file *file_priv,
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
@@ -909,12 +909,13 @@ int vmw_kms_sou_do_surface_dirty(struct
 	struct vmw_framebuffer_surface *vfbs =
 		container_of(framebuffer, typeof(*vfbs), base);
 	struct vmw_kms_sou_surface_dirty sdirty;
+	struct vmw_validation_ctx ctx;
 	int ret;
 
 	if (!srf)
 		srf = &vfbs->surface->res;
 
-	ret = vmw_kms_helper_resource_prepare(srf, true);
+	ret = vmw_kms_helper_resource_prepare(srf, true, &ctx);
 	if (ret)
 		return ret;
 
@@ -933,7 +934,7 @@ int vmw_kms_sou_do_surface_dirty(struct
 	ret = vmw_kms_helper_dirty(dev_priv, framebuffer, clips, vclips,
 				   dest_x, dest_y, num_clips, inc,
 				   &sdirty.base);
-	vmw_kms_helper_resource_finish(srf, out_fence);
+	vmw_kms_helper_resource_finish(&ctx, out_fence);
 
 	return ret;
 }
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -980,12 +980,13 @@ int vmw_kms_stdu_surface_dirty(struct vm
 	struct vmw_framebuffer_surface *vfbs =
 		container_of(framebuffer, typeof(*vfbs), base);
 	struct vmw_stdu_dirty sdirty;
+	struct vmw_validation_ctx ctx;
 	int ret;
 
 	if (!srf)
 		srf = &vfbs->surface->res;
 
-	ret = vmw_kms_helper_resource_prepare(srf, true);
+	ret = vmw_kms_helper_resource_prepare(srf, true, &ctx);
 	if (ret)
 		return ret;
 
@@ -1008,7 +1009,7 @@ int vmw_kms_stdu_surface_dirty(struct vm
 				   dest_x, dest_y, num_clips, inc,
 				   &sdirty.base);
 out_finish:
-	vmw_kms_helper_resource_finish(srf, out_fence);
+	vmw_kms_helper_resource_finish(&ctx, out_fence);
 
 	return ret;
 }
