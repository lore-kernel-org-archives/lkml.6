Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-585385-1524656276-2-12768749164232524362
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524656275; b=TdmVyiEy7UKNXVEab4fvLDxfPAFA1ayrMdeKZEPKdOohpTmUKC
    CI5uguvX9blHqQkwRUrlYb7ewSIaPmQi2b3Qley/Q8x39s0xEZXyNlLAIiWINGs5
    bCJ3PjSPG6q0aHx8TkWZOYta/K6sUKMxcdED6jrUuU5rGUoUEVncA5/DN1aP7TBl
    e1Uop0G5HP9rTF3DvsaKoLL0CC9LvrUdP2nPhIB7Un8wpO4qzyL2qIzm1qEAEWfT
    O+iWHUMl/nIVUePujbxHELlztXMpTt0DeTkd3Fau/TQX6aoepk8VJJbSgPRJgIa7
    D4i/JtByw++EsAUe66G/sD+4qLda0cv9Z4OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524656275; bh=rdw3p/017rlzCcGRFDGPKWviFQNzHV
    WF2/+RA/U0PzE=; b=Mi4WYIPewoEHNnI2yXlK4+nuZZ1ZZWFKWRCPH/VdIP22BR
    TsD51JmSNZ3HrC9iToyrwOKI5zvKMU3E+GZtVWssf9UxAX+Lm7ZdOmruVhix8TYZ
    UAgErnldcBQAWoFWiEWnz1OY1KM9xrgr3rgyFj2FrhQlKB/t4mlwj11ns0wOTLv5
    L9t0F7aOo4JCZZSjx5+kpHz5IjpiivljIYmr9bSLXTI8afK3MQ6B4CIhfqxgqAUJ
    1qjJetsT97cXKoxDfYdRDyV/pGZV2s1iBHN9dLbZJEOnraGjlo4s3RBSfI0D5+b7
    cRhq+lGBpM94lQpTL/ypRmC2UwitfUw7XDGg053w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfPuTo/TQCUu+GkSDtYL0nz1bKjhjzBPF2AAsr8YNPzSaUfdbuOaB1hcHExX6hj45Z+ml7+/nUk68iASlPkXKFnpnajrduLxHTmpxWiWcX5kPsawwQSPT
    gBnh+0T9BdJ8H9t5codJ8tvln7GpYUicVw1qbaWCNL4jRzbcNKIGQVkp2XtsdcBx/hDfeF/rWTEcBkBf/f0l3ik9+e0FpBH5H0mlkRYHvMVKh0FdkrPi+ezb
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=B-t7VW0V8DzCvdjSLMcA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752868AbeDYLgc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 07:36:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50740 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbeDYKd5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:33:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tina Zhang <tina.zhang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH 4.16 11/26] drm/i915/gvt: Add drm_format_mod update
Date: Wed, 25 Apr 2018 12:33:20 +0200
Message-Id: <20180425103315.298043392@linuxfoundation.org>
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

From: Tina Zhang <tina.zhang@intel.com>

commit 10996f802109c83421ca30556cfe36ffc3bebae3 upstream.

Add drm_format_mod update, which is omitted.

Fixes: e546e281("drm/i915/gvt: Dmabuf support for GVT-g")
Cc: stable@vger.kernel.org
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/gvt/dmabuf.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/i915/gvt/dmabuf.c
+++ b/drivers/gpu/drm/i915/gvt/dmabuf.c
@@ -323,6 +323,7 @@ static void update_fb_info(struct vfio_d
 		      struct intel_vgpu_fb_info *fb_info)
 {
 	gvt_dmabuf->drm_format = fb_info->drm_format;
+	gvt_dmabuf->drm_format_mod = fb_info->drm_format_mod;
 	gvt_dmabuf->width = fb_info->width;
 	gvt_dmabuf->height = fb_info->height;
 	gvt_dmabuf->stride = fb_info->stride;
