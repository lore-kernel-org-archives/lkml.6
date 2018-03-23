Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521803994-2-5553280526366827749
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521803994; b=VkMD7txBz2dOw6m+fmPn3OWV8/Nr+meuY7FgV18WYVZjOaS
    y2LQKV6KA6unEvh27WKCSSLTj8b5AS0KX0clEqraak8jw4V074wAAwf59nP60Q+i
    n3RCcE4GGxAdlI/TXeJo7t8ddbSkVn5twfEMqHieBlexfKPKA8ERY0xmZCVZb/0f
    Zh6AzcCX87XLwtGjmT4tmMwIE16dD7a7oPuPCdrtYltM8SMU7vhOvYjeRyBzpy8C
    2BXP8YZ/0gaYKJHNKQLjW/CdQRLxQEUNaM6xxl5J+eYvrhN5XVeeiKhOh10kNW44
    VD0c6Kzz1T4jm0LYa+1t7cfn1f8Sadrf9dcfJPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803994; bh=/a5DiMhdDZZETjXpHqKfJIs1gq
    zc9LnomlghEllYqNY=; b=ntWOObDpo0NnoBO15c82hHnuJzgbCEvK5/2+o4at2m
    As78JmaNyz3ZF9PlECgndzlr9fr3k6PsgGrGio+j/oesc0fWuo7glLlRF0eBF4wd
    cMJFj2lGAVlBSirpmda7MU8/bQJzcpStAbEEsza0zank0RyIYQ2iqObcy2mgY6yv
    gi+UgqfIkRdeWPlKaKn8tGci1szZEfVWllnRuHQAHFfVCYYOaSOqtFJif95KZjH8
    kEiUBzpV72zO+Yqaq42xoThebfdbQLKPbWuA9QQ7O333GkCH6UyVxCcAPiTCCSrb
    uIQS6pTMDHgU+sDxgqcaOBVvX6auz1UCv/BWu7WLfNdQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755637AbeCWKIs (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:08:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41816 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755625AbeCWKIs (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:08:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Li Yang <pku.leo@gmail.com>, Scott Wood <oss@buserror.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 104/177] net: ethernet: ucc_geth: fix MEM_PART_MURAM mode
Date: Fri, 23 Mar 2018 10:53:52 +0100
Message-Id: <20180323094209.878512935@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: Christophe Leroy <christophe.leroy@c-s.fr>


[ Upstream commit 8b8642af15ed14b9a7a34d3401afbcc274533e13 ]

Since commit 5093bb965a163 ("powerpc/QE: switch to the cpm_muram
implementation"), muram area is not part of immrbar mapping anymore
so immrbar_virt_to_phys() is not usable anymore.

Fixes: 5093bb965a163 ("powerpc/QE: switch to the cpm_muram implementation")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Li Yang <pku.leo@gmail.com>
Signed-off-by: Scott Wood <oss@buserror.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/ucc_geth.c |    8 +++-----
 include/soc/fsl/qe/qe.h                   |    1 +
 2 files changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -2594,11 +2594,10 @@ static int ucc_geth_startup(struct ucc_g
 		} else if (ugeth->ug_info->uf_info.bd_mem_part ==
 			   MEM_PART_MURAM) {
 			out_be32(&ugeth->p_send_q_mem_reg->sqqd[i].bd_ring_base,
-				 (u32) immrbar_virt_to_phys(ugeth->
-							    p_tx_bd_ring[i]));
+				 (u32)qe_muram_dma(ugeth->p_tx_bd_ring[i]));
 			out_be32(&ugeth->p_send_q_mem_reg->sqqd[i].
 				 last_bd_completed_address,
-				 (u32) immrbar_virt_to_phys(endOfRing));
+				 (u32)qe_muram_dma(endOfRing));
 		}
 	}
 
@@ -2844,8 +2843,7 @@ static int ucc_geth_startup(struct ucc_g
 		} else if (ugeth->ug_info->uf_info.bd_mem_part ==
 			   MEM_PART_MURAM) {
 			out_be32(&ugeth->p_rx_bd_qs_tbl[i].externalbdbaseptr,
-				 (u32) immrbar_virt_to_phys(ugeth->
-							    p_rx_bd_ring[i]));
+				 (u32)qe_muram_dma(ugeth->p_rx_bd_ring[i]));
 		}
 		/* rest of fields handled by QE */
 	}
--- a/include/soc/fsl/qe/qe.h
+++ b/include/soc/fsl/qe/qe.h
@@ -243,6 +243,7 @@ static inline int qe_alive_during_sleep(
 #define qe_muram_free cpm_muram_free
 #define qe_muram_addr cpm_muram_addr
 #define qe_muram_offset cpm_muram_offset
+#define qe_muram_dma cpm_muram_dma
 
 #define qe_setbits32(_addr, _v) iowrite32be(ioread32be(_addr) |  (_v), (_addr))
 #define qe_clrbits32(_addr, _v) iowrite32be(ioread32be(_addr) & ~(_v), (_addr))
