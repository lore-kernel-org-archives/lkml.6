Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519835516-2-1189093503097178273
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835516; b=tm49poPtlFnCMyJ2JhyefWqVn2S4DH0ltdjMagBuLgA6hBW
    P91cVIEJ5Vb36uSEb3FxB80GcwPJawfGoXPe7bLnw933e7rH/TmD84xn6pwtxnyl
    id3R6GpnunGTS3azydnzMHcfmJjHum9odMck5kzIVkGPg61YCNSkPXhSEn2k/bNQ
    xUaL0Tb+wzgf4yKImMgr8hpYQshCb+bR4+1FrnFPHuUYf+XogvbVR0iZVZHArTl/
    0TpDljg4NGgDkax07w8uSafJRLhm8xZ56wLrWSO328FpfdGHNL24P9j7H7VzkfUF
    YIpf3tzXu5SwapQlUlAl8Ia8j9+5+qzaKn+jfcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835516; bh=QH2wV6/3ACxr+Vwkg9L
    EvyRLiILdpCs+iFwn6Kjm7Jw=; b=oxSaLyfxmGWqPy/AiLejBZtPTZD9Lo/LvOO
    Q1T3wq65THdX4MXSH5IfI9//LFhZgve6dvfRsi/dxEzNXBMhmjLqqOcnSUOGgl6c
    4+zEQGD1jIfHE2WKsoL02xWUWLlk0QTJn1MS8EpVRUMeB2NkeE/3GirdohtgEPKY
    m3ZR8BwlU6Rtew2b5zJSShT8kB1C47tgg2vwzZSLODEap9tmCTLQ8+OjWt4hUsPZ
    yzd4DVUxjq9mXTY3WsfHIHKOqsVad3q2K4gVObjnZKWPyS4ROPlOnIMCakTrxpiY
    FEUa55cX3FXA5LsXMq+Eqcu2ZdWhceIZkI+6Jv2mMFx1CnoS4aA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932370AbeB1QO7 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:14:59 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35135 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934719AbeB1QO5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:14:57 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Petri Gynther" <pgynther@google.com>,
        "David S. Miller" <davem@davemloft.net>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.448969963@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 232/254] net: bcmgenet: fix bcmgenet_open()
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Petri Gynther <pgynther@google.com>

commit fac25940c5e0d6f31d56bb2a704fadad6d5e382a upstream.

If bcmgenet_init_dma() fails, it cleans up after itself. Rx and Tx
DMAs are off, and NAPI instances haven't been netif_napi_add()'ed.
Therefore, we need to skip calling bcmgenet_fini_dma() on the error
handling path. bcmgenet_resume() already does this correctly.

Signed-off-by: Petri Gynther <pgynther@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2058,7 +2058,7 @@ static int bcmgenet_open(struct net_devi
 	ret = bcmgenet_init_dma(priv);
 	if (ret) {
 		netdev_err(dev, "failed to initialize DMA\n");
-		goto err_fini_dma;
+		goto err_clk_disable;
 	}
 
 	/* Always enable ring 16 - descriptor ring */
