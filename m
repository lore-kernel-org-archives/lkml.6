Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-195729-1522174144-2-2585148899753330028
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
    t=1522174141; b=cCSTpzygUIm/Pe2X7+79U3IsXbYfylmGJE3oSn4abAmuVnG
    ZMKCjjUI4Ir3yQpNWxEt24y4VpoMvH1pBGfdqakAKSuo+Ump84f8EoVxFwLrj1Jv
    Ps3lUspp4tt/C8DxN97DYyfGRWd0TMmAKUJtXsFiqlG5kzMvyJrcOIK0gDiQUUiG
    MPogW135xAGPk8Vd1/QCmNwr6rP6KAqAt8c3BbHITgbSj35tN+e1lqugYVXIZ0yX
    MnuERfDi1RkjG0+rocSiTj0lqoq3HjCY+Zy5EcZoiLsHLyEbR0f0KKPlCEGbYXrA
    dWNx/6MkXfiQlPwMsEfKSc9VkiDRgcT3DvTM+gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522174141; bh=rx3bmMb9ne8Kzjo1DQxwql5FnG
    PFaBZHQuClX1FMz6w=; b=EPN2nnx/TDsn8eZuZ8gKQmWQtNzKzejWZh1y90+vKa
    8HmsWxBEb8oHGKq67JXs4yPkg2otUmdSaxNldsphTT8UwnCO2e73LKEMFBHMkHEs
    mCAF/Hz94M5h6lHOm9rpSpM+cDWKMBKaurFgjgNZe0HE6S+o6Alfq1q2dbS9vlFo
    HOPjQ6o89mK18Wd8RG5xI/NqbmzrsrSigvYpRnH7CivGVD394JpYtfKE3V9o2DuT
    UY0appAOn3NJj8uGVwhhSJUvRYBh6ZXHpR3uMuNm5ZOmvm2rt4usNzszgJ2rubxv
    01aHvHJ4ulWZa2Mw45th+1pV6AXwkvWj6tufIGe6WuXw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfHSFsyWQEjzsR4eWT4QGHgBQ4GY9k3/qskKHgtVmrL4Ddl0XeHquYIhRDkcX8lZyY1W56krfDEAxTik1fvL0SlY1C34luI9+CF8OF4YSLPSmeyWB4OQl
    BboUzCs24RZgca9gqlO0DwLsOn8D/v09dttN9/yVj/dssUlXJ5BwbFby9v5KIR1V6BZDPJvj9EMRP7JVvk7CWtsbV5ScROoRf2fxZcJYH1hd3mECYIGGqC8e
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=eh1Yez-EAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=MCgrjztaFs7i6r3_FckA:9
    a=YPDh7oJB_nV8BGZe:21 a=paUco9_mNGzJcJAP:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752600AbeC0SIr (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 14:08:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41244 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752561AbeC0Q3O (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:29:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Hellstrom <thellstrom@vmware.com>,
        Brian Paul <brianp@vmware.com>, Sinclair Yeh <syeh@vmware.com>
Subject: [PATCH 4.4 22/43] drm/vmwgfx: Fix a destoy-while-held mutex problem.
Date: Tue, 27 Mar 2018 18:27:26 +0200
Message-Id: <20180327162717.682004343@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -27,7 +27,6 @@
 
 #include "vmwgfx_kms.h"
 
-
 /* Might need a hrtimer here? */
 #define VMWGFX_PRESENT_RATE ((HZ / 60 > 0) ? HZ / 60 : 1)
 
@@ -1910,9 +1909,12 @@ void vmw_kms_helper_buffer_finish(struct
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
@@ -1929,10 +1931,14 @@ void vmw_kms_helper_resource_revert(stru
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
@@ -1951,6 +1957,8 @@ int vmw_kms_helper_resource_prepare(stru
 						    res->dev_priv->has_mob);
 		if (ret)
 			goto out_unreserve;
+
+		ctx->buf = vmw_dmabuf_reference(res->backup);
 	}
 	ret = vmw_resource_validate(res);
 	if (ret)
@@ -1958,7 +1966,7 @@ int vmw_kms_helper_resource_prepare(stru
 	return 0;
 
 out_revert:
-	vmw_kms_helper_buffer_revert(res->backup);
+	vmw_kms_helper_buffer_revert(ctx->buf);
 out_unreserve:
 	vmw_resource_unreserve(res, false, NULL, 0);
 out_unlock:
@@ -1974,11 +1982,13 @@ out_unlock:
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
@@ -180,6 +180,11 @@ struct vmw_display_unit {
 	bool is_implicit;
 };
 
+struct vmw_validation_ctx {
+	struct vmw_resource *res;
+	struct vmw_dma_buffer *buf;
+};
+
 #define vmw_crtc_to_du(x) \
 	container_of(x, struct vmw_display_unit, crtc)
 #define vmw_connector_to_du(x) \
@@ -230,9 +235,10 @@ void vmw_kms_helper_buffer_finish(struct
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
@@ -841,12 +841,13 @@ int vmw_kms_sou_do_surface_dirty(struct
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
 
@@ -865,7 +866,7 @@ int vmw_kms_sou_do_surface_dirty(struct
 	ret = vmw_kms_helper_dirty(dev_priv, framebuffer, clips, vclips,
 				   dest_x, dest_y, num_clips, inc,
 				   &sdirty.base);
-	vmw_kms_helper_resource_finish(srf, out_fence);
+	vmw_kms_helper_resource_finish(&ctx, out_fence);
 
 	return ret;
 }
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -1003,12 +1003,13 @@ int vmw_kms_stdu_surface_dirty(struct vm
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
 
@@ -1031,7 +1032,7 @@ int vmw_kms_stdu_surface_dirty(struct vm
 				   dest_x, dest_y, num_clips, inc,
 				   &sdirty.base);
 out_finish:
-	vmw_kms_helper_resource_finish(srf, out_fence);
+	vmw_kms_helper_resource_finish(&ctx, out_fence);
 
 	return ret;
 }
