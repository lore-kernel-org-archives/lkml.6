Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3586829-1519411647-5-16170769982522477471
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519411647; b=TLzB3ZyNV6l+diJUh7WO4eTn1mhXEmROMSIUeSshW8mtoRm
    35JmgeLSweo392EjIzZo6nJFPPV53ho99+NFtz4xsKRfX16OIIOOiqON4/g+phJf
    0Orn37zvgJuduBsBDeutbseLNtTr5KjIfl7JJqp9VLcqVXqrb5NCpaWD9jYvtFSO
    LVHUELHW6YWBTIwcf/HbSDRC63ICkG62wTZQm2i+k9lQF98uQNbYziAksiGemUHm
    IcurHorFwkOnGZ3rA36OMCivnxhl/8lpGb0XEaqhliuc+YIzqRt3vFibMv1zjNHR
    3BSuuX3MVZefLgZjCKI4KPKP42phj9Tou9GCncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519411647; bh=BYVuqorQojWdpL1t6rgJ8V0ZLP
    9gGx4Uq9xCbJtF92w=; b=HXeQQZwemjQLFiF0am554HEJ2OAQevlTE2big0Sr5Q
    JcoGFPvPNBsfdOfoCTSaheaBzQl4zxXhtkNNhjcSp/d2F2mL4WBquHQSH7YX1yLW
    HMMdj4sYrW2FFVdYYCHIVMWztzxCZGj5zLMAABBDqm+ukYeiPM/PJW7MIjlZ3zu9
    NJQkbMtnZbn5D6ZrElhgPSHy83iXqOvA4BADz5QatdyWD9lx87OB8HdxI3+3PZdP
    uavE6BYl0YeB5N9DTxzj794LmiaxMcP5ppe2my0GGGj8wx25Jp0asRtuD0JxZA8s
    OrQO0l/Bumc5tnx7SERI1eGh9iOiUtviz5Ypk/KeNRrw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933842AbeBWSrY (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:47:24 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44534 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933698AbeBWSrX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:47:23 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jun Nie <jun.nie@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4.9 112/145] dmaengine: zx: fix build warning
Date: Fri, 23 Feb 2018 19:26:58 +0100
Message-Id: <20180223170739.313405193@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jun Nie <jun.nie@linaro.org>

commit 067fdeb2f391bfa071f741a2b3eb74b8ff3785cd upstream.

Fix build warning that related to PAGE_SIZE. The maximum DMA
length has nothing to do with PAGE_SIZE, just use a fix number
for the definition.

drivers/dma/zx_dma.c: In function 'zx_dma_prep_memcpy':
drivers/dma/zx_dma.c:523:8: warning: division by zero [-Wdiv-by-zero]
drivers/dma/zx_dma.c: In function 'zx_dma_prep_slave_sg':
drivers/dma/zx_dma.c:567:11: warning: division by zero [-Wdiv-by-zero]

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Tested-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/zx296702_dma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/dma/zx296702_dma.c
+++ b/drivers/dma/zx296702_dma.c
@@ -26,7 +26,7 @@
 
 #define DRIVER_NAME		"zx-dma"
 #define DMA_ALIGN		4
-#define DMA_MAX_SIZE		(0x10000 - PAGE_SIZE)
+#define DMA_MAX_SIZE		(0x10000 - 512)
 #define LLI_BLOCK_SIZE		(4 * PAGE_SIZE)
 
 #define REG_ZX_SRC_ADDR			0x00
