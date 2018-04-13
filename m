Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-493782-1523655118-3-4608389308332806489
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523655117; b=NlwvICo5CIInhjzOiSZ039tCIfpPe5G8ztlF+hYS6yU+0v50Ge
    ju3nxtRJ/PLThPDYo9TREv8kxfvMdWRv9wg50V087QV+Y2onkudJUFXOwOqc5yA+
    8BjWUZfNXEPTMIB6dCS53gGVaJgigrqu6qnyQgFcr82vbJdjpgyNDUaiOYQS/gRX
    6qgj+/Y0zdOTzVMGruokkIG84hgmWL32PvoNjFb+nDgSk0KTOFg8YQPf/7tw6j6Z
    9XPaJ9ohEo1bASJspSlW140L3lne/gClp2wx7TmuX8ofVwSZjfqeKkq3jPQfX6GJ
    QrR3MLUM8hvZ0+dWXYBiTdTReSYzeiBg568Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523655117; bh=Zv5aNAH0PRA1fFlzI8V6dBk9X8VTnP
    MWezbQND6J+N8=; b=d0zGYkHkWvRPKfUiGruA/gNbTG87NxjYKU392shIsmM6ab
    YDm9n1kFEMzwlnUFSF6GxcmwDbDALQ2k8jDpobnp5HS3PPlx85z98rqaimxTCduN
    VfyvGtSs/tMxW4+ANBuWRStjL4YR+sVT6/hbQXJiNY+9isdLb30uin7mBIspng2T
    zf8SBzD0TiXIBgyXRohxmWTRcitUNPECSZ34eQaxzFSW6Pc2Fn9XZZN8eMM4rXtW
    slNepsfN4l337To0h8+Jcvbu4qV9r8IBxG1V+5Z9/up3WGwRvB1kJK5kCYMQzvxE
    FJWqP6CS58Vqd8JLiNTpL5EDzCGi4spCaXQ5chTQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDqfkaTOvnuAyu1Sg1y8EKYLKqXof/6jSuybexXec5l7L9QdBNLq0muPoA/gNm+r25VtgPypQGJetXm4uXp7Bq9njeLUAbFeT5YnIf6xFz5bacqjMSJa
    jWsEa0KydSQuOczajiCkuoa9WzLZ5qYWvs+FA8cupBAA3GlJC70mFwVW1JKEOlq9S4LqWDDehdiOLQJzgxiZuktIbSH4iWqW2SSRJVHXrb/lEF0y/ND7RRKq
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8
    a=VwQbUJbxAAAA:8 a=KT1hoV9y9HW_dW_ZMBUA:9 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751111AbeDMVby (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 17:31:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750973AbeDMVby (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 13 Apr 2018 17:31:54 -0400
From: Lyude Paul <lyude@redhat.com>
To: nouveau@lists.freedesktop.org
Cc: stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Martin Peres <martin.peres@free.fr>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: Add missing fb SLCG registers for kepler2
Date: Fri, 13 Apr 2018 17:31:28 -0400
Message-Id: <20180413213131.9430-1-lyude@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Somehow I didn't manage to notice this the last time I looked at my
mmiotraces, these seem to be all valid registers.

Forwarding this to stable, as there's a small chance that not having
these could cause clockgating to be unstable.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: a0f79082bd174 ("drm/nouveau: Add support for SLCG for Kepler2")
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c
index 0695e5dd360e..0d9ad9fa7774 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c
@@ -32,6 +32,18 @@
  * PGRAPH registers for clockgating
  *******************************************************************************
  */
+static const struct nvkm_therm_clkgate_init
+gk110_fb_clkgate_slcg_init_bcast_0[] = {
+	{ 0x10f280, 1, 0x00000000 },
+	{}
+};
+
+static const struct nvkm_therm_clkgate_init
+gk110_fb_clkgate_slcg_init_pxbar_0[] = {
+	{ 0x13cafc, 1, 0x0000007e },
+	{ 0x13cbe4, 1, 0x1ffffffe },
+	{}
+};
 
 static const struct nvkm_therm_clkgate_init
 gk110_fb_clkgate_blcg_init_unk_0[] = {
@@ -45,6 +57,8 @@ gk110_fb_clkgate_blcg_init_unk_0[] = {
 
 static const struct nvkm_therm_clkgate_pack
 gk110_fb_clkgate_pack[] = {
+	{ gk110_fb_clkgate_slcg_init_bcast_0 },
+	{ gk110_fb_clkgate_slcg_init_pxbar_0 },
 	{ gk110_fb_clkgate_blcg_init_unk_0 },
 	{ gk104_fb_clkgate_blcg_init_vm_0 },
 	{ gk104_fb_clkgate_blcg_init_main_0 },
-- 
2.14.3
