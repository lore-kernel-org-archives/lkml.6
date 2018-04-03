Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-598900-1522733669-2-4872630695768604702
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522733668; b=JjpVbInDg+mRRMWu5OeuvUnswSeTIpEzoYryNULqvvnGSy/9ZS
    UJU4y8X2h5/jFdyLLX5cbVjS4NX8uKuQIVdmH0d2ssJDw/PivTMbncsdL1Pj+h8k
    pnOz9o24VU8E8JJHovbFJopA/Uh5N7iLdsIX/nm5OWxMee9EuquFzIzOCICULyMA
    R1seDAe8r3stQ0z1z3+7SUzssZv+wEJ5UpyC8bLSjh8JBwIRvIL+lau02IBvap6m
    X2DVALINQu2Oa/RFy1E+5pRN/yf0GbkgzH7BgS6BXtjraL9Zebk9h5Y+snBYzhvv
    poBZzDpsoMoA5ciOCF25SdVfiot5XukK+Sow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1522733668; bh=aLCHMgxOVzcAwAmBbtuqB7XxxPvXmb
    V0TESDH3ZtYIg=; b=hp9I6IVEHTPgNq0JOmxU69g7mMHe7wkPRW5TtMJM5zM5E2
    /J57JmXzpIcf20RtvXCzimthaqLD8M5PXQ+IEPaPG0EjbwDU45qjcFyHlluZZzob
    NRDrFSE+dvSU+apeSUkOpucL275/yQHbhr8u8/csYA0bIe8nHt+t1JV0FHWAmlYk
    cEW3Tmafi69v/+8f6FHYA1SicJxJhpHRtyVGmSMz4NdNJG93toNI/hW+5i95OSQ9
    zokr7zsFBMs0F2SaFPZ1IfxunzaffQ/l6bXb/ylak4hU09AgtNR3FJb+nU5q6Qlz
    caL9dpZVnB/k1d4KczG1S2iXLa2KoAjFDtqvE/Nw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rG419eeg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=B6xOCXu6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rG419eeg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=B6xOCXu6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIZ6W6tzCkxH5KSKJB8gM7CSLpMks0heIm6oEJzjxaVzrKdQd/n+QEDVaTESzePyonlxbx3NjsyU2FUcaAB4mP3kfUP3zhEBH4mbYYNjtsn+A3sX86Hc
    kz715Fk3POGBjy+vafKDtYUNJw9NPQTiiR/L+klmzjnBJKL7z23JWarS1DFtTyKw5vUudwwvtVI2uGj9WQTyaN75sq40JDgWSSGxaj+vXyUfJmuaM2L43UAE
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=x6VqX4pZDWMA:10
    a=Kd1tUaAdevIA:10 a=i3X5FwGiAAAA:8 a=KKAkSRfTAAAA:8 a=8b9GpE9nAAAA:8
    a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=1_6uJPY1CX6K7SGXSYMA:9
    a=kGx2xdnZ_AYA:10 a=mmqRlSCDY2ywfjPLJ4af:22 a=cvBusfyB2V15izCimMoJ:22
    a=T3LWEMljR5ZiDmsYVIUa:22 a=Vxmtnl_E_bksehYqCbjh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754596AbeDCFeY (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 01:34:24 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41844 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754583AbeDCFeX (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Apr 2018 01:34:23 -0400
X-Google-Smtp-Source: AIpwx4+uV89icGTzWvwm+2iupuFlC7fmdJJwHgKVwRbaHCimYite5bMXYTazGTDV3Xpc7lmW5gwL4A==
From: Oliver O'Halloran <oohall@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Oliver O'Halloran <oohall@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-ia64@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] drm/sti: Depend on OF rather than selecting it
Date: Tue,  3 Apr 2018 15:34:01 +1000
Message-Id: <20180403053401.30045-1-oohall@gmail.com>
X-Mailer: git-send-email 2.9.5
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit cc6b741c6f63 ("drm: sti: remove useless fields from vtg
structure") reworked some code inside of this driver and made it select
CONFIG_OF. This results in the entire OF layer being enabled when
building an allmodconfig on ia64. OF on ia64 is completely unsupported
so this isn't a great state of affairs.

The 0day robot noticed a link-time failure on ia64 caused by
using of_node_to_nid() in an otherwise unrelated driver. The
generic fallback for of_node_to_nid() only exists when:

	defined(CONFIG_OF) && defined(CONFIG_NUMA) == false

Since CONFIG_NUMA is usually selected for IA64 we get the link failure.
Fix this by making the driver depend on OF rather than selecting it,
odds are that was the original intent.

Link: https://lists.01.org/pipermail/kbuild-all/2018-March/045172.html
Fixes: cc6b741c6f63 ("drm: sti: remove useless fields from vtg structure")
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Vincent Abriou <vincent.abriou@st.com>
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-ia64@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
Cc`ed to stable since the ia64 guys might want it backported. I'm not
bothered if it just goes into mainline.
---
 drivers/gpu/drm/sti/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sti/Kconfig b/drivers/gpu/drm/sti/Kconfig
index cca4b3c9aeb5..1963cc1b1cc5 100644
--- a/drivers/gpu/drm/sti/Kconfig
+++ b/drivers/gpu/drm/sti/Kconfig
@@ -1,6 +1,6 @@
 config DRM_STI
 	tristate "DRM Support for STMicroelectronics SoC stiH4xx Series"
-	depends on DRM && (ARCH_STI || ARCH_MULTIPLATFORM)
+	depends on OF && DRM && (ARCH_STI || ARCH_MULTIPLATFORM)
 	select RESET_CONTROLLER
 	select DRM_KMS_HELPER
 	select DRM_GEM_CMA_HELPER
@@ -8,6 +8,5 @@ config DRM_STI
 	select DRM_PANEL
 	select FW_LOADER
 	select SND_SOC_HDMI_CODEC if SND_SOC
-	select OF
 	help
 	  Choose this option to enable DRM on STM stiH4xx chipset
-- 
2.9.5
