Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id M1NUJBX3G1uIeQAAmS7hNA
	; Sat, 09 Jun 2018 15:50:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C6D06608C8; Sat,  9 Jun 2018 15:50:35 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hqj4iGBW"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4ECD4608B8;
	Sat,  9 Jun 2018 15:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4ECD4608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932612AbeFIPud (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:50:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932377AbeFIPcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:32:09 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAADE204EC;
        Sat,  9 Jun 2018 15:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558328;
        bh=W3CPVYfVdbdPa2wEVRKIiPysipnJD+ItdRXe1act7ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hqj4iGBWBOjX6k1+iUrafVA0KfR1TaAEAUwALF5f0P/UmKuHYMsXYcnqbglJUf2hn
         uIJYAvKU/Zf+/sSP9tAsXIGW1zNlXSxTl+J5Minb6fF7AJnjvq/xG5fAxeRc/Ni214
         8UH5AXGLfWldCoowLivUhwqpDWjg94z7S4S2a1Vo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 06/48] bnx2x: use the right constant
Date: Sat,  9 Jun 2018 17:29:18 +0200
Message-Id: <20180609145948.087113680@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609145947.679103414@linuxfoundation.org>
References: <20180609145947.679103414@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julia Lawall <Julia.Lawall@lip6.fr>

[ Upstream commit dd612f18a49b63af8b3a5f572d999bdb197385bc ]

Nearby code that also tests port suggests that the P0 constant should be
used when port is zero.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e,e1;
@@

* e ? e1 : e1
// </smpl>

Fixes: 6c3218c6f7e5 ("bnx2x: Adjust ETS to 578xx")
Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
@@ -588,7 +588,7 @@ static void bnx2x_ets_e3b0_nig_disabled(
 	 * slots for the highest priority.
 	 */
 	REG_WR(bp, (port) ? NIG_REG_P1_TX_ARB_NUM_STRICT_ARB_SLOTS :
-		   NIG_REG_P1_TX_ARB_NUM_STRICT_ARB_SLOTS, 0x100);
+		   NIG_REG_P0_TX_ARB_NUM_STRICT_ARB_SLOTS, 0x100);
 	/* Mapping between the CREDIT_WEIGHT registers and actual client
 	 * numbers
 	 */
