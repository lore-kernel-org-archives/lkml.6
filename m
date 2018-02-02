Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2879036-1517591104-2-15102711024655434743
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591104; b=Zsw1MvovB8Vw1e/5cTSjpHPz6Gttff5jEjg5uN3FuIJWvzw
    syRoGgUW43YJ2iHiwIQWSnxMRPWYAdZKgoC0xODwYe5h7UYloPr0U8IWR5MBlOEz
    X2MMl91pI7mpi29v6L20uFRwD1rwm9AnrgkWYMIMip6GxPoTbav3AjUneoVGJDNz
    v28UHLWKJiMaiTiGiY2/E5fux5JFzlZxMR7MO4XZx2VnRS0DJcpQ2qPu2LB8OEeB
    Y1jdXye/ZLdtYsqK0wf+jm/DlWiXnc37kHc14z20lbWGvTVqNUaxD+4ZUk963ADZ
    +uW0aXC10FZFD4FKhUuuLTb+efgs536tAGuQyoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591104; bh=L1nuQyyM7o0Zh2B86Vv81RjQIt
    ja4gsMYprwVdjTDP0=; b=u1uL1s+hsNkDeC6BY9TXXj1TucdbdRyCr9wZhqTnUT
    Be487HVS/U51iJ1Hy3vWzeZ21G4ghW9ol4Ha61kE0H5TuEpjtdVJrSaJEVJDIQrc
    knZWQ87UMRRsw2wRM28LcWlOLjwALPnvcWlJbFwOG45Z3Mf4VMRH7lSf9+5dmCxU
    OocKlKdnlAH7n/oatp1+hQDrFbTMiXuk2/A4ktwl/MOOr1HI7R2r828Lh1DdZj2o
    8GMWAEZqryKNH99v2I60B/KQtx+tOVvBEd0QEk8Hj2WXCdQmGgCpEqqDxphsDq53
    EQMei4lX+iaI1hHl6/fyF82lJcmgOitLy7Rj0RM3xZLQ==
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
        id S1752906AbeBBREx (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:04:53 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36312 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752896AbeBBREu (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:04:50 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesse Chan <jc@linux.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 4.9 15/86] mtd: nand: denali_pci: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Fri,  2 Feb 2018 17:57:35 +0100
Message-Id: <20180202140824.274939148@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Chan <jc@linux.com>

commit d822401d1c6898a4a4ee03977b78b8cec402e88a upstream.

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/mtd/nand/denali_pci.o
see include/linux/module.h for more information

This adds the license as "GPL v2", which matches the header of the file.

MODULE_DESCRIPTION and MODULE_AUTHOR are also added.

Signed-off-by: Jesse Chan <jc@linux.com>
Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/denali_pci.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/mtd/nand/denali_pci.c
+++ b/drivers/mtd/nand/denali_pci.c
@@ -119,3 +119,7 @@ static struct pci_driver denali_pci_driv
 };
 
 module_pci_driver(denali_pci_driver);
+
+MODULE_DESCRIPTION("PCI driver for Denali NAND controller");
+MODULE_AUTHOR("Intel Corporation and its suppliers");
+MODULE_LICENSE("GPL v2");
