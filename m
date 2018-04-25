Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-497764-1524652763-2-14961397310822613382
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524652763; b=wk0M4V96bfi2pMWQFhTLVR4YwirhvOzqeoWgxoW1lD8xlWN0Ia
    htZ9KJFzryI/e6f6a5z+wSlqwfW9YPb/6BWGJV+iR8827UOxfrprXkSVjjixqd5O
    ba0m2FuYb2VkixuC7YCNtxaPOIo0cNVD9vM4PPRYttACY0y86EQwlCw91vSHtKZg
    8S1iaXCnOn2Ta1U/nP3JUqZxwoXRJQ9Hu1BqMzoix1FVsDerV5oAT2EXuTjbWS7l
    XDUr/LTdcSu6OzhOEOhqUiziHGmiyXGS0TCC9K5dzAYv/Ozk2b8HAueIil6Bavto
    KnTfOWu8tT3GKSLyzxvCr/whh4QotHvqxTuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524652763; bh=pRH76tJwdW9me1kKEzaDIRFh3bWJ1Z
    HHg7XMurlZMpY=; b=AoTALHSFT1W4p0VagXlk/kX2YpqSWz4dj2YROTZ2Zun91C
    9OflgNR6AzJAWsvRCscek9iaWuB1jKUFEjLFMk7XsPPk8YogOgIt08+svi5Fb1NE
    +X5FUen4yl538Edm+xkcty2BRtK60Kcwr9BDZhdoeLDX6TnxNP3BfESv1CaX5Ns8
    9S2JfG0Uy56zlRzbhm8AlyL7WP7cOzGh1B+9SlHeOuLtXFbPHMF5MfEG+uTegMIR
    ZHnkwqFOjIn1N9/gb9crbb3KSA1Xicjt8X/lv0QTMv4jMkkh4X8FfbAd0UMFNFlx
    iCJ+GJSwEv+CWQXcHoGXPE92T7wiX5Gih79J+tjQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIQYHDHRLCg/rcGb/1fdC+aNIO+gznn2S0X8V4GkmgqTqqxXt0ri3e4ATZp69b3SqTUteVFAnxnvUiTE+MGBF+TAPP+yEUbrsPrY0svPWlRg+uLPwzw1
    hbDttE44m7Ry2oNfMEVXs7CVFeQvFwbhDzpiCGOVd8iPWT/g+eK+Ze3YwQuBUs/OvryScpX6h7yb94MyzDR+jTfCr23MfSGlLGqEwrip49zW+g6KQiRDCaOy
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=3-RhneuVAAAA:8 a=1XWaLZrsAAAA:8 a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=XLRw2IhVxHYyqli0-ksA:9 a=QEXdDO2ut3YA:10
    a=VLVLkjT_5ZicWzSuYqSo:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbeDYKjT (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:39:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51808 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753567AbeDYKjP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:39:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Niklas Cassel <niklas.cassel@axis.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 056/183] PCI: Add dummy pci_irqd_intx_xlate() for CONFIG_PCI=n build
Date: Wed, 25 Apr 2018 12:34:36 +0200
Message-Id: <20180425103244.797328728@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <niklas.cassel@axis.com>


[ Upstream commit 80db6f08b7af93eddc9487535e6150b220262637 ]

Some hardware can operate in either "host" or "endpoint" mode, which means
there can be both a host bridge driver and an endpoint driver for the same
device.  Those drivers share a lot of code, so sometimes they live in the
same source file.

The host bridge driver requires CONFIG_PCI=y because it enumerates PCI
devices below the bridge using the PCI core.  The endpoint driver does not
require CONFIG_PCI=y because it runs in an embedded kernel on the other
side of the device, e.g., on an adapter card.

pci-dra7xx.c contains both host and endpoint drivers.  If we select only
the endpoint driver (CONFIG_PCI=n and CONFIG_PCI_DRA7XX_EP=y), the unneeded
host driver is still compiled.  It references pci_irqd_intx_xlate(), which
is not present when CONFIG_PCI=n, which causes this error:

  drivers/pci/dwc/pci-dra7xx.c:229:11: error: 'pci_irqd_intx_xlate' undeclared here (not in a function)

Add a dummy pci_irqd_intx_xlate() for the CONFIG_PCI=n case.

[bhelgaas: changelog]
Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/pci.h |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1688,6 +1688,13 @@ static inline int pci_get_new_domain_nr(
 #define dev_is_pf(d) (false)
 static inline bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
 { return false; }
+static inline int pci_irqd_intx_xlate(struct irq_domain *d,
+				      struct device_node *node,
+				      const u32 *intspec,
+				      unsigned int intsize,
+				      unsigned long *out_hwirq,
+				      unsigned int *out_type)
+{ return -EINVAL; }
 #endif /* CONFIG_PCI */
 
 /* Include architecture-dependent settings and functions */
