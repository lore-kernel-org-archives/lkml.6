Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1546708-1519219010-2-16650581084326859966
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
    t=1519219010; b=WEH01i9pqhlPnDzY/eKh8F0G6hECBbwADAdgRT4H1N5ug84
    jlPXvcGmIxjltxIHzUHy8+Nwd3BLARRGfjJOXzPJTtYkHyftudu4zSUS3lchSuex
    AsKdUh4xccLEVAGJ/Hp7kyJ7t8Xa54g/4H3S0jkiZ+MWdBq/gUqBH5zvqECOqrU0
    6rI6kiWPE08FPuBA5fpUWSAHV50HZdyf8Uk0o3EDtavXGPsn1/G7t5FuuWovMtfy
    lfn8n7Ktx1gbtIdAnQawgGOAlVWSNTX/o0Zag+PLZAptvCGLvVPS0k/0QqII/19U
    5WX5708PfYwI+rfZuygBzlFsw9xTMEfAAFm11mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519219010; bh=peqgLBDz5ZZNEHjCiW/oZUGS6V
    hzxFZwFhKHj0iT8mA=; b=R9SN3LCgGQ9UCWr8wBm+VXlae0XWfVJAHl3evaScsd
    dIDmQCIoFY+wV8MQNZC/TRnHyqa2ig2y+xhFls7qRzwcRaDLSkr4y5HV+lHu7Fht
    MvL+wOK44xfKBtMbx2U0iGlAzx5/nT8bZLzaFUkzWAj9VKk1cPlxkMvLVAg7RO4Y
    9TGFgZZKlmHnKmX3ZG+rmS+p/2iDfhMvFWPVhx2UFOP6YC4TwiR9pdbEXrEgP5j+
    GjYSvMhZHl52gsUB2AolN7iTQYw0xD0+U+eJtqcFpvvjkDZmrNX40/qpE7Z39umC
    3u4l33IdwLBe84D8d/QCTgcmyd5O72VDlvNNfhDycCcw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751667AbeBUNQg (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:16:36 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45928 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754533AbeBUNNI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:13:08 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "yinbo.zhu" <yinbo.zhu@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 4.15 162/163] mmc: sdhci-of-esdhc: fix eMMC couldnt work after kexec
Date: Wed, 21 Feb 2018 13:49:51 +0100
Message-Id: <20180221124538.870625428@linuxfoundation.org>
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

commit 97618aca1440b5addc5c3d78659d3e176be23b80 upstream.

The bit eSDHC_TBCTL[TB_EN] couldn't be reset by eSDHC_SYSCTL[RSTA] which is
used to reset for all. The driver should make sure it's cleared before card
initialization, otherwise the initialization would fail.

Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-of-esdhc.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -785,6 +785,10 @@ static void esdhc_init(struct platform_d
 	pltfm_host = sdhci_priv(host);
 	esdhc = sdhci_pltfm_priv(pltfm_host);
 
+	val = sdhci_readl(host, ESDHC_TBCTL);
+	val &= ~ESDHC_TB_EN;
+	sdhci_writel(host, val, ESDHC_TBCTL);
+
 	host_ver = sdhci_readw(host, SDHCI_HOST_VERSION);
 	esdhc->vendor_ver = (host_ver & SDHCI_VENDOR_VER_MASK) >>
 			     SDHCI_VENDOR_VER_SHIFT;
