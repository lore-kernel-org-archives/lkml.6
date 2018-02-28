Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519835244-5-15298767427736845025
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835244; b=CJGInMbyHbmEoJDlW7MpQOkLnTOH4sfw606MdlBjvjC3G1/
    jnDa2iQt+rujCrGLbo1Rhi7qD1y2n0lOzxWiLdJGB3W8b1ZYbv5/2rAUe++fRQLm
    ReBn6TCfUKyM6tvOyVG8Mz2blmXXpJI+tFkYibCUVy03VfOP6aMRARynB1AEBMUx
    B6Osy2xKOhM7gyNxFasnYbZZ3yvao39+nsiNvZgSPy/aD33RoX5kl0LK3OjbCojR
    70nngVGifdv+yNio2PNg2oCG/FU1YSFiFrFsYNfvl6LUsp/LXTklkVql1eT96hV7
    gLCsWrH4+HDC4MbJgIQzg7e6Siq/NLOgzlje1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835244; bh=VBusRPZk1amBCD2Wsop
    692Y2eYw5/pyytYFiyxKMhQ4=; b=MBSC6U8FmjOxbWGxh14VmZ/WXikQauIbdDi
    MSkZxA64EdrXbrqdLLdKOj6TKRFK1jCmNnYN3YZag0mvKPAEnEOvz2qgpoOy1SOG
    BPSGEM57SnN7whu7ART8iGiMCHsFXSCfSDEXT/ySXV0ujnmUSM11jrmIRUoRZF4E
    N/ktg4kUAronbwEcQU/92mpPJWkl9LkxMKlJTIzKy0c2qoVvTUwLeNJw0akKVSe3
    NJYkdjn8MECWAr8MYZnZjlnrysucYT7g/17YyZ5X4nNFwAST64nL/O0NDYnkEC7P
    db9c4tcoHwAbsuZT1tAKemgnaleHCTSu18XyhX+hPT+fvzrtxhw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932301AbeB1Q1E (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:27:04 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35205 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933835AbeB1QP6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:15:58 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Vinod Koul" <vinod.koul@intel.com>,
        "Tobias Jordan" <Tobias.Jordan@elektrobit.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.216568476@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 084/254] dmaengine: jz4740: disable/unprepare clk if
 probe fails
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

From: Tobias Jordan <Tobias.Jordan@elektrobit.com>

commit eb9436966fdc84cebdf222952a99898ab46d9bb0 upstream.

in error path of jz4740_dma_probe(), call clk_disable_unprepare() to clean
up.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 25ce6c35fea0 MIPS: jz4740: Remove custom DMA API
Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/dma/dma-jz4740.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/dma/dma-jz4740.c
+++ b/drivers/dma/dma-jz4740.c
@@ -574,7 +574,7 @@ static int jz4740_dma_probe(struct platf
 
 	ret = dma_async_device_register(dd);
 	if (ret)
-		return ret;
+		goto err_clk;
 
 	irq = platform_get_irq(pdev, 0);
 	ret = request_irq(irq, jz4740_dma_irq, 0, dev_name(&pdev->dev), dmadev);
@@ -587,6 +587,8 @@ static int jz4740_dma_probe(struct platf
 
 err_unregister:
 	dma_async_device_unregister(dd);
+err_clk:
+	clk_disable_unprepare(dmadev->clk);
 	return ret;
 }
 
