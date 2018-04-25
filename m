Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-585385-1524656146-2-7950619186509391072
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524656145; b=QRcrrHMWd38yeLa6CQsV/ci6yS6c4W5Ucl/USq1q98+umiQueU
    5A7CFIuVjZhpYmmasxp15nJSx4eUshwtNjFsoeU3QpzgMY5gJGRm2ZfxZ+w3+RKX
    juFqrmwTQXChIDPe2n7vfAlc+Z6kvH0rb6NAFyFEqFKyE3iJtO1rFmdCILxDRoWV
    tlK/fjALjpFlbm2i9PFKpx+pvI2pzT5QypqNZ69j6zRpa4IgMM1Z7Kc0h9bCNOI+
    vGnBUBChMkkATOVeKKSQdQPeDNpkmTKKMfrMHhQLTtOmGZVgrOSRBjnbvIul+JOB
    mc4Jr5PVv8LIk1j89Hd0e/qMEtApoSiUWlxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524656145; bh=wAw42egVp/HSR1SPVc7e3SxauP9bNJ
    C4cK2OCdL+0rE=; b=Ux0ew9bKUefq9+O4HS0SlUXUYhjjMTxzWmpwVI1ofS0i9p
    pwNVo5YfQsJiPJxSj3X+yu7VnSthiCyKfZyt11kYqbrBW5UmsC79Ho3oSobhm1hT
    dI+ogt70ZDTdGoFJq6Y43kJnpMhfci0gzunSZ0Yl7+9RPmFOVjcHYb6I2JRig+rP
    VIr+zJpDZvCy0JrpMLEYnuwLJCPpAyLAw1xmgWCVPefRZapA43aOHkgLh9HFZ4Bo
    jOAg/WT6QOy/PXsSVlsGJqAkf4W3l+S280V8NXtRJl7cpNmlTygrc5e2U7hzBVaI
    eBzZ8djd3pq/7PjUSQVIjqROyETu2ntOcjT0JESg==
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
X-CM-Envelope: MS4wfB0H5LmYHjHaXBZp5NBQugWivMKzS8wkGkMGgiHi+Erdh0/IxobdUFfVj3nmBHwoemo5uNZY7s2xyPyFWnsrenIBsG+IPENhZ6pjxmOsp5tMyFUx33oI
    ebq3vMS0qy7+7cHzSwkOnb03uOF/E3hEcajagTd5Dkg74HZkGGzwFKSSG/vteMc1LBDip0KpNzhaT5n8g5VdeoCpu5rjvwWMo2eVEk9b0yy3n0XBLc6ru4xq
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Byx-y9mGAAAA:8 a=taGs_qngAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
    a=e5mUnYsNAAAA:8 a=ag1SF4gXAAAA:8 a=k-tgYaMEUKiGyG8TMNMA:9
    a=9FyHLl404H15vHn8:21 a=ZWsosAU4TlobxI6y:21 a=QEXdDO2ut3YA:10
    a=DM_PlaNYpjARcMQr2apF:22 a=AjGcO6oz07-iQ99wixmX:22 a=Vxmtnl_E_bksehYqCbjh:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751487AbeDYLfm (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 07:35:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50770 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752315AbeDYKeF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:34:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xidong Wang <wangxidong_97@163.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.16 14/26] drm/i915: Do no use kfree() to free a kmem_cache_alloc() return value
Date: Wed, 25 Apr 2018 12:33:23 +0200
Message-Id: <20180425103315.415541155@linuxfoundation.org>
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

From: Xidong Wang <wangxidong_97@163.com>

commit fcf1fadf4c65eea6c519c773d2d9901e8ad94f5f upstream.

Along the eb_lookup_vmas() error path, the return value from
kmem_cache_alloc() was freed using kfree(). Fix it to use the proper
kmem_cache_free() instead.

Fixes: d1b48c1e7184 ("drm/i915: Replace execbuf vma ht with an idr")
Signed-off-by: Xidong Wang <wangxidong_97@163.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: <stable@vger.kernel.org> # v4.14+
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Link: https://patchwork.freedesktop.org/patch/msgid/20180404093824.9313-1-chris@chris-wilson.co.uk
(cherry picked from commit 6be1187dbffa0027ea379c53f7ca0c782515c610)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_gem_execbuffer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/i915_gem_execbuffer.c
@@ -728,7 +728,7 @@ static int eb_lookup_vmas(struct i915_ex
 
 		err = radix_tree_insert(handles_vma, handle, vma);
 		if (unlikely(err)) {
-			kfree(lut);
+			kmem_cache_free(eb->i915->luts, lut);
 			goto err_obj;
 		}
 
