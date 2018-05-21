Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526937830-2-2940841474728789170
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937830; b=SgQGVUr/laG6/zYTTvDueS4YID5oPwd9KK+jrEsn7eWUFiTjG9
    ZNwVkgm/j/V1FdNQJrUFFygQ8m5kDYBFVZ+GUSCgjUAAWmiBPuE18UTn7nFWlkqh
    s8G7qTs/1gxMrp6/Lh+qYgJXm49MI1V1GRrkynu4Mi+16AfaossD8FO4BtlYujzh
    KpsSNvnt9jH2YB05r5XOafg3qhjjXrAe6L+x34ONyz7kjZifrGpZLv6YzxmO6WIm
    V+676w+5u8PyXp52SvFQwd8ez8eF97jvH3vDOfRQ1d/homY5TSuHpL/35IIkPyPA
    zmkKwUiAGE++top5irze//fEnMOePr1gmKZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937830; bh=WOAG0T5sbuNbMvcvSxCT+hCF7PGmEm
    bhMc2RUvoXfK4=; b=TSteMkAhw8/pEOYY5cUBcLZLiv+yUa6d1bJrzaJU9ZHMCe
    nIPz46VHr+X5aCEEyuExP1mX4UsTiR2JBayjmxjJgut9cB9exbpwfwq7iysB7ez7
    UuiHVBREGuxyUBiU4zI6ma1zp2j91yFK8vFv18JCDjsgXDfFIJuzxOhPBYhv0MPm
    CqVZryXAGE8X6rrphzIg0Krtnq+JP9d6xzVrS2vw9lNm1STE2lzjXcQuMBpb0hSm
    gZuADfW8hTrwEELNF9XBjEemurEjIMbwOM1MSQs0AgIMCeXIarydQQw7eLCuMhEW
    KaTijhJJJIFq43w+46L1W81Sy4fTgAqCDmKL7YGg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=0k5T+oo+ x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=0k5T+oo+ x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO9Fzk1OZthJxC52/SokeYWXlKvLSeaghkBph+keMajHZZ8XjF58983ecg5PkzuaES649vt2QETmqkeyTYdpkGuLcMjiGBROLDdv+a7sUD3bHaJ0Z6hQ
    govH0ICRqIve9MnBpAsA7OS39qLyjk8P6g9w2EfeGQPxJJzrKtUVH6LeVdTvcrUHOz0/GjDiciwlTIaK2OfxMABLbq+S9T7GXYDSU74szLZs2jqM3i0fNxfa
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=e5mUnYsNAAAA:8 a=taGs_qngAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=p1pPSqwCws9YOeRjgkEA:9 a=QEXdDO2ut3YA:10
    a=Vxmtnl_E_bksehYqCbjh:22 a=DM_PlaNYpjARcMQr2apF:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754345AbeEUVXq (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:23:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:38574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754343AbeEUVXn (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:23:43 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michel Thierry <michel.thierry@intel.com>,
        mesa-dev@lists.freedesktop.org,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Oscar Mateo <oscar.mateo@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.16 039/110] drm/i915/gen9: Add WaClearHIZ_WM_CHICKEN3 for bxt and glk
Date: Mon, 21 May 2018 23:11:36 +0200
Message-Id: <20180521210507.389445775@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
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

From: Michel Thierry <michel.thierry@intel.com>

commit b579f924a90f42fa561afd8201514fc216b71949 upstream.

Factor in clear values wherever required while updating destination
min/max.

References: HSDES#1604444184
Signed-off-by: Michel Thierry <michel.thierry@intel.com>
Cc: mesa-dev@lists.freedesktop.org
Cc: Mika Kuoppala <mika.kuoppala@linux.intel.com>
Cc: Oscar Mateo <oscar.mateo@intel.com>
Reviewed-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Link: https://patchwork.freedesktop.org/patch/msgid/20180510200708.18097-1-michel.thierry@intel.com
Cc: stable@vger.kernel.org
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180514165445.9198-1-michel.thierry@intel.com
(backported from commit 0c79f9cb77eae28d48a4f9fc1b3341aacbbd260c)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_reg.h        |    3 +++
 drivers/gpu/drm/i915/intel_engine_cs.c |    4 ++++
 2 files changed, 7 insertions(+)

--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -7139,6 +7139,9 @@ enum {
 #define SLICE_ECO_CHICKEN0			_MMIO(0x7308)
 #define   PIXEL_MASK_CAMMING_DISABLE		(1 << 14)
 
+#define GEN9_WM_CHICKEN3			_MMIO(0x5588)
+#define   GEN9_FACTOR_IN_CLR_VAL_HIZ		(1 << 9)
+
 /* WaCatErrorRejectionIssue */
 #define GEN7_SQ_CHICKEN_MBCUNIT_CONFIG		_MMIO(0x9030)
 #define  GEN7_SQ_CHICKEN_MBCUNIT_SQINTMOB	(1<<11)
--- a/drivers/gpu/drm/i915/intel_engine_cs.c
+++ b/drivers/gpu/drm/i915/intel_engine_cs.c
@@ -1098,6 +1098,10 @@ static int gen9_init_workarounds(struct
 	WA_SET_FIELD_MASKED(GEN8_CS_CHICKEN1, GEN9_PREEMPT_GPGPU_LEVEL_MASK,
 			    GEN9_PREEMPT_GPGPU_COMMAND_LEVEL);
 
+	/* WaClearHIZ_WM_CHICKEN3:bxt,glk */
+	if (IS_GEN9_LP(dev_priv))
+		WA_SET_BIT_MASKED(GEN9_WM_CHICKEN3, GEN9_FACTOR_IN_CLR_VAL_HIZ);
+
 	/* WaVFEStateAfterPipeControlwithMediaStateClear:skl,bxt,glk,cfl */
 	ret = wa_ring_whitelist_reg(engine, GEN9_CTX_PREEMPT_REG);
 	if (ret)
