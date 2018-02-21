Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1546708-1519218945-2-12815822149303557481
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519218944; b=FdUqAI5FTaDRKq2BYkPIryAMTeBhFH37nJCuWpo4uaDQm5H
    Qhs8KMPyGvVaijTWgkpo/ZWxoAS6JVVF/Oj79bbpulKFXThh1CRXv0tBIIVmurrh
    vN81fMiLHmuY/JqrNTCHFCqXxoAlNljq6JRree/lgR5pvg23LCqURDb5ScJmtCSi
    VeqGgXxxffpgqKROOUNFQEXciZnpEMFVhlo+XlTp1xp5AV6QmGUCS8O/Eqf07g5I
    rwGGXPqBdJLKTzszur/STolvOrYVnmTuhSvNgz8jy9XGlvK55nSNBXY21XhZjjhF
    J8654G7sJiH7PlypPFjIcsJTVzKTkT7enddrLyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519218944; bh=1tM63cIlhnrPG1+r8Q9DMmOd5/
    KZKehmOodDv80CQxk=; b=NDrFjdQEt6wmBoTONy+Lew8OIuFfUEsp1JAxohblG6
    X1uHSN7dDqfJllv1J4i+9ijK54ngkdAo+pxdBSTVrBB5Y+xVjZdUQyc5OVkup7uY
    wSpCKMETltkfUantbQovGVlrJmvOCImMzwoQL0kncbVxyhv+PFk2TIDA24VY1BSM
    D4OuwCOesHxjqRmMYebR1wtECa0uBOwxnGWOrXoV9asu0kCk8GgZR+IMkloMEZYC
    ZIcz8o04BOA7kx77OGR+bPNYw2OCDDi0z5vQWZo1v8iohE2N8Yj/y1NgZtE6yrMu
    DxM6bhrKHT7b0v34Cj0Y7hT6S3mzpw/czDiKjS/dssXA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932123AbeBUNP1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:15:27 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45958 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965693AbeBUNNL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:13:11 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "yinbo.zhu" <yinbo.zhu@nxp.com>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 4.15 163/163] mmc: sdhci-of-esdhc: fix the mmc error after sleep on ls1046ardb
Date: Wed, 21 Feb 2018 13:49:52 +0100
Message-Id: <20180221124538.908072794@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: yinbo.zhu <yinbo.zhu@nxp.com>

commit f2bc600008bd6f7f5d0b6b56238d14f95cd454d2 upstream.

When system wakes up from sleep on ls1046ardb, the SD operation fails
with mmc error messages since ESDHC_TB_EN bit couldn't be cleaned by
eSDHC_SYSCTL[RSTA]. It's proper to clean this bit in esdhc_reset()
rather than in probe.

Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
Acked-by: Yangbo Lu <yangbo.lu@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-of-esdhc.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -589,10 +589,18 @@ static void esdhc_pltfm_set_bus_width(st
 
 static void esdhc_reset(struct sdhci_host *host, u8 mask)
 {
+	u32 val;
+
 	sdhci_reset(host, mask);
 
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+
+	if (mask & SDHCI_RESET_ALL) {
+		val = sdhci_readl(host, ESDHC_TBCTL);
+		val &= ~ESDHC_TB_EN;
+		sdhci_writel(host, val, ESDHC_TBCTL);
+	}
 }
 
 /* The SCFG, Supplemental Configuration Unit, provides SoC specific
@@ -785,10 +793,6 @@ static void esdhc_init(struct platform_d
 	pltfm_host = sdhci_priv(host);
 	esdhc = sdhci_pltfm_priv(pltfm_host);
 
-	val = sdhci_readl(host, ESDHC_TBCTL);
-	val &= ~ESDHC_TB_EN;
-	sdhci_writel(host, val, ESDHC_TBCTL);
-
 	host_ver = sdhci_readw(host, SDHCI_HOST_VERSION);
 	esdhc->vendor_ver = (host_ver & SDHCI_VENDOR_VER_MASK) >>
 			     SDHCI_VENDOR_VER_SHIFT;
