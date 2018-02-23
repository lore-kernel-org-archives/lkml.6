Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3586829-1519411607-2-7005557451323181084
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
    t=1519411606; b=O3o0yvJP6OwX22fOBQnqNrINH1M+W+sfIs09JBaBMacSwnH
    GlqzHMBePQIU4udbCfH1zFUFUAr/x8us3K7q4bvjAWyDxkg//R/+ftK5eBqX7t36
    IRDLa/y8IdKG2wp6MFYf0Lfib+wQYfOw3iTDnWnaTwSimfRsrRIkkx9gZlb918lb
    UE5+IIPNH8Ft4YXWihAFJfxGCw4tTmrE7WTBtEEDBmYBfRYgkc9aB7zmOYn/rbys
    tbyiXabyNOpNB3/DRox8YxRBBHBpcS0lRAJXN7kM7ue2oiGAcHoADnZ2hQOkPLaB
    eGaMuuiaNELWky7HUYlya/xECrzp4SkjQgTpQSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519411606; bh=/La91aprGjcgWOrsMr1a6WtAxG
    Lua0Zq6lR6xrX6IaE=; b=oIpJNGqwxbe56W7c8XuEOruYcSQgYks8yPInZafeX4
    5632pKhLhzzSR7lmp3P3CjxwFDEa8u0Yi/EdNlNoe12jliXE1fuFuiftALO/4lJg
    H99N5vkKacADS3HL6A1qLJxAb2zZRN3HCtRb1ylxfAdr3fYq0IYI1UUGBMSfeYt7
    wvhia7D0QI6IuGz7Rd8FQTtlfwgT4ZD2BH3KAKQQTxRzmctUCMDu7Id1bg5OcssV
    VV/4dvC+lX1xRNtkZi8Ag/Wadc9TdsNMtNo6SCB04R8/DJH09RvX1O8CWGLEpGy4
    fZ4r6R7YKNYgXrCUm3TzFMtxcRiS5C8TCa3bkiU3CZiA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933989AbeBWSqn (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:46:43 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43828 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933380AbeBWSqm (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:46:42 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4.9 100/145] PCI: Change pci_host_common_probe() visibility
Date: Fri, 23 Feb 2018 19:26:46 +0100
Message-Id: <20180223170737.733869557@linuxfoundation.org>
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

From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

commit de5bbdd01cf9ee3cd4586b5a970d3ea015c6d7e3 upstream.

pci_host_common_probe() is defined when CONFIG_PCI_HOST_COMMON=y;
therefore the function declaration should match that.

  drivers/pci/host/pcie-tango.c:300:9: error:
	implicit declaration of function 'pci_host_common_probe'

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/pci-ecam.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -59,7 +59,7 @@ void __iomem *pci_ecam_map_bus(struct pc
 /* default ECAM ops */
 extern struct pci_ecam_ops pci_generic_ecam_ops;
 
-#ifdef CONFIG_PCI_HOST_GENERIC
+#ifdef CONFIG_PCI_HOST_COMMON
 /* for DT-based PCI controllers that support ECAM */
 int pci_host_common_probe(struct platform_device *pdev,
 			  struct pci_ecam_ops *ops);
