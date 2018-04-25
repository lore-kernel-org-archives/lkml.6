Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-488755-1524652534-2-11633437022949076666
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524652533; b=jCqScA9whwqWxKI04sB26nX6otvYTm7sGHtDjEgzKFDonPPAlA
    ZcvOsvmMifOyGe8xFCFtf2PLfSpB13tiH9aCXZv3bX1lUNpKs8iEmEoV2G19Xage
    +fLGFtrbn2nmWATZ9kG0vRJ938xNeef3Jba7IQxCdj/A/JRZcgTf3rXFSNaJZwgq
    mEgEvukO8aSDn0pfPks/4UiRSi89WpjnSAK2LLj493w6rfATgzcklAka8hHonohv
    P2l60wopIQP+0gmE/FWzZpt20WO64lf26CBG2xWvBNzfq1GAhrULXuInfHqnqQyA
    AeXIB8/mQFlgxlwVlTxXq8L1UJ2VTyekipJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524652533; bh=Ve4gEDozJKyKMdlvWwrTZfN8pUz6t1
    gHJhsk3Jr5Chc=; b=eX2oaRArq43BknsZdr7RmFkrfE9oocK+aUha+IQaPaKPUV
    QlL6iutX58SSXa4lVsfv9BBZCbzoAffGjiKIDudixnnvHrwhBjvQ8tcrmlflWdaX
    WdWLVJB0x9k/Kk9NTFlZwnTwTGfg151YKGaiGduqXK+mPoE50SakM887NjnJDfCj
    8ZROQ5PqK+0IAyddtkDj7QoVsfAyZ9aQ4fMB5hfvgOV9LxXLIODFWLnyjGa+fWQR
    1KFBdkXSt42P5IcIxUjJR+9d7iqyPeWihvWqrgZ74aZ6k0geS3wujNRXu8hEi95q
    uGZj8AQpw1y9CV4SRbf9Qm4ox1aGWuzfm62ei9Rw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfKYkuGVaCO5xsv90w1oDxONuOEzsfHALO3nu/fsA1njH5IorvR3axHzQgayzHcYWDMuSdQ6mK6UFuikNjHdcUCqaUTPA8i0/L1uEU2++M6IWs8Nky4xM
    f/7L7U7jlGlHw3d2x/SazTqeAD4dkFuyVA+Naya9emwESiG92fPWZphy+aoSzxz2PPiSrq5QyxZsi8wBtezv/H5rARPOW+046IrtYTIFM1cibX/kDJRvlyeo
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=t9ty7G3lAAAA:8 a=VwQbUJbxAAAA:8 a=-VAfIpHNAAAA:8 a=e5mUnYsNAAAA:8
    a=ag1SF4gXAAAA:8 a=nGCmr_1PYZBH2UiFEOAA:9 a=QEXdDO2ut3YA:10
    a=CsAS6f0m0zARWR-uHzm3:22 a=AjGcO6oz07-iQ99wixmX:22 a=srlwD-8ojaedGGhPAyx8:22
    a=Vxmtnl_E_bksehYqCbjh:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752993AbeDYKfS (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:35:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50998 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752935AbeDYKfA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:35:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel J Blueman <daniel@quora.org>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 4.16 09/26] drm/vc4: Fix memory leak during BO teardown
Date: Wed, 25 Apr 2018 12:33:18 +0200
Message-Id: <20180425103315.226009669@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103314.842517924@linuxfoundation.org>
References: <20180425103314.842517924@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel J Blueman <daniel@quora.org>

commit c0db1b677e1d584fab5d7ac76a32e1c0157542e0 upstream.

During BO teardown, an indirect list 'uniform_addr_offsets' wasn't being
freed leading to leaking many 128B allocations. Fix the memory leak by
releasing it at teardown time.

Cc: stable@vger.kernel.org
Fixes: 6d45c81d229d ("drm/vc4: Add support for branching in shader validation.")
Signed-off-by: Daniel J Blueman <daniel@quora.org>
Signed-off-by: Eric Anholt <eric@anholt.net>
Reviewed-by: Eric Anholt <eric@anholt.net>
Link: https://patchwork.freedesktop.org/patch/msgid/20180402071035.25356-1-daniel@quora.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vc4/vc4_bo.c               |    2 ++
 drivers/gpu/drm/vc4/vc4_validate_shaders.c |    1 +
 2 files changed, 3 insertions(+)

--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -195,6 +195,7 @@ static void vc4_bo_destroy(struct vc4_bo
 	vc4_bo_set_label(obj, -1);
 
 	if (bo->validated_shader) {
+		kfree(bo->validated_shader->uniform_addr_offsets);
 		kfree(bo->validated_shader->texture_samples);
 		kfree(bo->validated_shader);
 		bo->validated_shader = NULL;
@@ -591,6 +592,7 @@ void vc4_free_object(struct drm_gem_obje
 	}
 
 	if (bo->validated_shader) {
+		kfree(bo->validated_shader->uniform_addr_offsets);
 		kfree(bo->validated_shader->texture_samples);
 		kfree(bo->validated_shader);
 		bo->validated_shader = NULL;
--- a/drivers/gpu/drm/vc4/vc4_validate_shaders.c
+++ b/drivers/gpu/drm/vc4/vc4_validate_shaders.c
@@ -942,6 +942,7 @@ vc4_validate_shader(struct drm_gem_cma_o
 fail:
 	kfree(validation_state.branch_targets);
 	if (validated_shader) {
+		kfree(validated_shader->uniform_addr_offsets);
 		kfree(validated_shader->texture_samples);
 		kfree(validated_shader);
 	}
