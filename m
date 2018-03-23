Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521804332-2-10190202683622396057
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
    t=1521804331; b=pxLh+I8+3NzwgYC5Z2esaoIG/aKlRwFxbd8aVKiXlpbdaU5
    3eZkTteVVUf6wVHOqE5bATeJG1zXgxE+A7UB070C+WJqh8f124EnfNWqfwf6xiKG
    5Wt8RGDXVRocS1+0q3T5u/Lj0V5/d5mNdpX0ahMo5bKCUILDjsmUX/crEoWsb1We
    NdNoMIsGB9B1qx7kYohl+bU2p1MazZR2q0JNgy6i2OzRutAGaRpxRRgERY8NlvF8
    X8FYwsPRh9wcuCZG9n6BA/5Nq0sSSLdN7+6ta4i1sLrz3Y3zSXJgi0rvp5Jj9YY0
    k4f9LCTf77berrrA3C2WC39p2plYo08ebnvrvsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804331; bh=4co8Gbx4IR5XuB+JyupASvU8ou
    LjDE2J21h8SjV9uzI=; b=sdaUtUlJIhQ8oaFHXHIYGhhpQ+vhhgjePRLGHySNpC
    W/enl4zCOVVTXKkSbxt275W4bEKYj+T+nrenT4CWUxMT3k1Ngd0yg3VFiCMjnkcV
    xrQdKAd0YF77V4nBg64dMmx6vZltZhpAaEpm5ZDTP+IjeP6ZATFGTBqDv2YnqRqR
    +fAUvAxfh8IIhxQTgTArVaYNuPCnSBc8fggXUetfpO3M7aF0Yg9acra9sFJStqxv
    VmznsKVy1kMO0VTXz4baOnzLJsKa4anvT4hPM+ShzhZ+DrlOyI4PIywexLivSDUM
    ggRzWV6Zh2GoWkf/kwZBuX8vgkKwTQU3jLoGqu0AWpoQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
        id S1752173AbeCWLZI (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:25:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41294 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755317AbeCWKHc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:07:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 063/177] wan: pc300too: abort path on failure
Date: Fri, 23 Mar 2018 10:53:11 +0100
Message-Id: <20180323094208.115951318@linuxfoundation.org>
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

From: Pan Bian <bianpan2016@163.com>


[ Upstream commit 2a39e7aa8a98f777f0732ca7125b6c9668791760 ]

In function pc300_pci_init_one(), on the ioremap error path, function
pc300_pci_remove_one() is called to free the allocated memory. However,
the path is not terminated, and the freed memory will be used later,
resulting in use-after-free bugs. This path fixes the bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wan/pc300too.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/wan/pc300too.c
+++ b/drivers/net/wan/pc300too.c
@@ -347,6 +347,7 @@ static int pc300_pci_init_one(struct pci
 	    card->rambase == NULL) {
 		pr_err("ioremap() failed\n");
 		pc300_pci_remove_one(pdev);
+		return -ENOMEM;
 	}
 
 	/* PLX PCI 9050 workaround for local configuration register read bug */
