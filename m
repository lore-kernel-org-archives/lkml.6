Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-727090-1517912150-2-4402531646662612181
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517912149; b=qNM4ao1O2yz07HUIPC20YAmUEWQlF6yS6618gzcRHSI+XXJ
    znprVP6tR4VoeT69Z9QXUwSSoZPkmMoVAgQqkQwV4eNqLNRoo/C0J3Z4IaxRgafk
    gqrTYb1Ghkm4QZoA7RbgQXFu98HnLXHJJyUfNeAKxtpVWmUOIESeRiaKQo7ELlso
    tkuvqhEzWxi9DojZ0efJJqb6qWtfqpvsn3lFklRUz06z+M8xt1rfgO7tIQUwnjpw
    J4GH6WV1RhwSyulHGLicoqRUZEyJbyenXQebkELUxC+6RZGaezSX8i1bsqKGgXH9
    HUO/uV3qyujTMHfWY/rfxjw/L7j2ZyAjK2N11qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1517912149;
    bh=V1P0Omkrdl0DiHGo6GIfv1cEXSyV0megSw1O1xkm8Vk=; b=OlxaFQ3FQzzn
    xKZ3lF7yV6QInp4sIrjbhgjuLzM6Z06HHTeT0WYr2MOYvJEtC1tZBiBsPlHrw8t7
    HPIfenR327DMYPSNYkqTUF7BQpfms4fcxpZBvetPSqmTrCSjsgGt3xBhkvFER0cY
    rve1PfZAh+xJ1nBMNqazendYmRlkekRhyrl/B8gshiFOkWx87iwnbE6NEWlhxDkL
    +bNKuqPcSVq9Cv3spAZk6sIWazO1wJHMTqkyFNj67ybkB3V4oZNsw77AM5BptzGH
    BNk/hKMtUvmabkM8DaWFjNuasf7p5Uv8h2AV+JHZJTdxMOZ6kS4sGQ5s88lkvg7b
    wzFrp/PfpA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752790AbeBFKPn (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 05:15:43 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:46888 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752583AbeBFKPD (ORCPT
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
Subject: [PATCH/RFC 5/6] scsi: Add NO_DMA dummies for SCSI DMA mapping API
Date: Tue,  6 Feb 2018 11:14:51 +0100
Message-Id: <1517912092-15470-6-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517912092-15470-1-git-send-email-geert@linux-m68k.org>
References: <1517912092-15470-1-git-send-email-geert@linux-m68k.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add dummies for scsi_dma_{,un}map(), to allow compile-testing if
NO_DMA=y.

This prevents the following from showing up later:

    ERROR: "scsi_dma_unmap" [drivers/firewire/firewire-sbp2.ko] undefined!
    ERROR: "scsi_dma_map" [drivers/firewire/firewire-sbp2.ko] undefined!

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 include/scsi/scsi_cmnd.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index d8d4a902a88dedbc..6a123d1dd2f80624 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -171,8 +171,13 @@ extern void scsi_kunmap_atomic_sg(void *virt);
 
 extern int scsi_init_io(struct scsi_cmnd *cmd);
 
+#ifdef CONFIG_SCSI_DMA
 extern int scsi_dma_map(struct scsi_cmnd *cmd);
 extern void scsi_dma_unmap(struct scsi_cmnd *cmd);
+#else /* !CONFIG_SCSI_DMA */
+static inline int scsi_dma_map(struct scsi_cmnd *cmd) { return -ENOSYS; }
+static inline void scsi_dma_unmap(struct scsi_cmnd *cmd) { }
+#endif /* !CONFIG_SCSI_DMA */
 
 static inline unsigned scsi_sg_count(struct scsi_cmnd *cmd)
 {
-- 
2.7.4

