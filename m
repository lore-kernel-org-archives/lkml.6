Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1900785-1527163857-2-10915968703912137236
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527163857; b=YZ00gxc2k/dzw6tbQzPIb3xVQBIg+xGvrTtVUyERdxDNli/F1s
    Lvleo7Fl+J/KRmZUCvlRYqwU3lGJoSpKop6MM/pDb/amvimcs0hQayM7Ft/wMXpI
    23qRqaGfysum/O/4LmOHGCwPsqksOEzr/aaZJYjYFeLte5yO7PxAd0mstd3D4jKZ
    EzoKdE0EGIwCa3LnNtLpLGIzIonvkJSE6VqCCMNqL4EzA3Uo/7bwN7f8aanjMRfa
    RVAKYNdfg+lIw+zkVXfHh6M2H0dQ1sXH9YnKaAcNqaWUwLQb7cTsneiYvPD5pRxL
    htHDuYhnNd8E4r0Jh1orB1t6M7SkT3+0Ip0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163857; bh=WHdd52TkqWR4ikojmKyAm3Wr5bHImY
    i0nCrEt+ZWHg0=; b=eaNgAGUHtsfnTjSKrHltRwGs2opX3+lX1SQnwBSIbZ4sYK
    w/0bc6iu8WaXaxZPE1OjHCmwgMwdMket7nnVbOdYGTl3oCP06Dtrk7YtQbFFGp0+
    VGmodzkOEQaaBFodRgPUi+glVw5/2nNvxgPkdLc164voCXb/w+l9nZl+i+74cYAp
    g55Qq9S8mb5dp7AmlB/V65+lRl0Fk8ZE7+N144yIB27QY4pLSFeBZ6NvxbUu5X3k
    DfmHgeZmZN6VTMxfwhSO0Y+iHKraA+QDXpWF2T/yBaLs+p1xU8jxlA+1EUX23dLq
    KYEtHQp5Gw4YYasjb2OQ4wdFAtqa1/TWP1fg9Lrg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=gfU0j+uN x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=gfU0j+uN x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfJaW0hGAKx+INFLBOoH1u4LOpRlfzSjrZ54Dx4NZVnOmmwtWTxgJlpdLbKv7hXvSwVOu+TkQ2zealAf9Hbx1Ki3SSbPXFQ4BmRNCwVwap4PyX1wzGHnH
    ZC9NV83Y1dxEkL6c7ZTqlXqPOZYRIyN5ODIbWuMTJ18gAx9707NSxIdzte9SmXtzQWe+UsGpmioZFW+ggkyOZeuztEI+rn6e4JE0Ezx3GPf6RO7gK62IT668
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=Q-fNiiVtAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=JRk18abXo-UP5clGnZsA:9 a=QEXdDO2ut3YA:10 a=Fp8MccfUoT0GBdDC_Lng:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966445AbeEXJnP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:43:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966180AbeEXJnJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:43:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zumeng Chen <zumeng.chen@gmail.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 15/92] tg3: Fix vunmap() BUG_ON() triggered from tg3_free_consistent().
Date: Thu, 24 May 2018 11:37:52 +0200
Message-Id: <20180524093200.638969190@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
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

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit d89a2adb8bfe6f8949ff389acdb9fa298b6e8e12 ]

tg3_free_consistent() calls dma_free_coherent() to free tp->hw_stats
under spinlock and can trigger BUG_ON() in vunmap() because vunmap()
may sleep.  Fix it by removing the spinlock and relying on the
TG3_FLAG_INIT_COMPLETE flag to prevent race conditions between
tg3_get_stats64() and tg3_free_consistent().  TG3_FLAG_INIT_COMPLETE
is always cleared under tp->lock before tg3_free_consistent()
and therefore tg3_get_stats64() can safely access tp->hw_stats
under tp->lock if TG3_FLAG_INIT_COMPLETE is set.

Fixes: f5992b72ebe0 ("tg3: Fix race condition in tg3_get_stats64().")
Reported-by: Zumeng Chen <zumeng.chen@gmail.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/tg3.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -8722,14 +8722,15 @@ static void tg3_free_consistent(struct t
 	tg3_mem_rx_release(tp);
 	tg3_mem_tx_release(tp);
 
-	/* Protect tg3_get_stats64() from reading freed tp->hw_stats. */
-	tg3_full_lock(tp, 0);
+	/* tp->hw_stats can be referenced safely:
+	 *     1. under rtnl_lock
+	 *     2. or under tp->lock if TG3_FLAG_INIT_COMPLETE is set.
+	 */
 	if (tp->hw_stats) {
 		dma_free_coherent(&tp->pdev->dev, sizeof(struct tg3_hw_stats),
 				  tp->hw_stats, tp->stats_mapping);
 		tp->hw_stats = NULL;
 	}
-	tg3_full_unlock(tp);
 }
 
 /*
@@ -14163,7 +14164,7 @@ static struct rtnl_link_stats64 *tg3_get
 	struct tg3 *tp = netdev_priv(dev);
 
 	spin_lock_bh(&tp->lock);
-	if (!tp->hw_stats) {
+	if (!tp->hw_stats || !tg3_flag(tp, INIT_COMPLETE)) {
 		*stats = tp->net_stats_prev;
 		spin_unlock_bh(&tp->lock);
 		return stats;
