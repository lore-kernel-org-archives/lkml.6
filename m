Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-727090-1517912145-2-14404889290006586622
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517912144; b=fAU3ut+xuyDrNTv3qV6u2tGd/OycH+DOJ/v63yFPLYobLl2
    KvhDHBusOE9uDJ00aE5Ue0o8K73aFs8so3JuLh6r/aLbOYP/NqbbrmBF0jApd9XQ
    c3TpYCIsmyhSTGe10ofdUeVaP2I3oi5VzJk0s55fv64L6XfWK2dTc905foHyjeCm
    hhswS2yp68yF5BXzZcEgWkLJH2rsCLjiTSCuI3a/o6TphUmOqD4cdtmvPuv1lKp0
    alrVz4xNqqp7MT0AHFrTwPtYBRnp5dyX68FP7VJDK/rOsmXIPEAy/OeLYYV2KHlI
    /e9NiIIx5s0D9OtLUcFaWoIvj8y4ceI2hcDTOBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1517912144;
    bh=NyNRC1GkHS4xPsn5ep6pnRnXWwP01BDMPScD+6ri3oU=; b=N7aXkaxSj/sh
    oJGlXqFrCF10GRd/ptlWUqHhOI79LW77pb88E1nf9ZN5lJ9UMiSJslHU4AnClw/v
    /PSLmtLZRWtWwaWeq+vgkXtqeo7xMoAz8m+6e//r5HqQgnGPNucPhKHS9CUZq3fL
    lZFZewpRz9VdSxvuGuAfA/LiGRirXRthwZWyOOC1/Yi7v/X4yT/s+oMKI2E7UckB
    HIeSb37E0D4pSAHVKnXAzVHnfsn+v31HN9weW7ic2BYiHHE0GrxXKjfp3+lkhHYf
    tIQuxX0GbKFbesdSOLzna9xuYoCYpCuAhhBOpjyYis82gOMNfDN8a0tfDzQE3yvd
    c9zoWefekA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752766AbeBFKPk (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 05:15:40 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:46860 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752597AbeBFKPD (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 6 Feb 2018 05:15:03 -0500
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Richard Weinberger <richard@nod.at>
Cc: Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH/RFC 1/6] dma-mapping: Convert NO_DMA get_dma_ops() into a real dummy
Date: Tue,  6 Feb 2018 11:14:47 +0100
Message-Id: <1517912092-15470-2-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517912092-15470-1-git-send-email-geert@linux-m68k.org>
References: <1517912092-15470-1-git-send-email-geert@linux-m68k.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If NO_DMA=y, get_dma_ops() returns a reference to the
non-existing symbol bad_dma_ops, thus causing a link failure if it is
ever used.

Make get_dma_ops() return NULL instead, to avoid the link failure.
This allows to improve compile-testing, and limits the need to keep on
sprinkling dependencies on HAS_DMA all over the place.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 include/linux/dma-mapping.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 34fe8463d10ea3be..d78d7541f784875b 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -212,14 +212,14 @@ static inline void set_dma_ops(struct device *dev,
 }
 #else
 /*
- * Define the dma api to allow compilation but not linking of
- * dma dependent code.  Code that depends on the dma-mapping
- * API needs to set 'depends on HAS_DMA' in its Kconfig
+ * Define the dma api to allow compilation of dma dependent code.
+ * Code that depends on the dma-mapping API needs to set 'depends on HAS_DMA'
+ * in its Kconfig, unless it already depends on <something> || COMPILE_TEST,
+ * where <something> guarantuees the availability of the dma-mapping API.
  */
-extern const struct dma_map_ops bad_dma_ops;
 static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
 {
-	return &bad_dma_ops;
+	return NULL;
 }
 #endif
 
-- 
2.7.4

