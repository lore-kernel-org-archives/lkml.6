Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2943005-1517591815-2-17093417687096676671
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
    t=1517591814; b=mnTgL9bP/xpHgBHrPftqs3E04GzgOAEe1qlNip5HZfUmqJn
    cFHEvw57YX3gaPdlBIq31ZLIcwG3sojf0yJU1CLMv0tz7mfyp1dcoInu8dmLDcaf
    i481fDSyfLEyFBKahFi5f5jmGGG3QNdHmvcrgOX70523+cBg1YnXcQIBDHxKOq58
    ciegYZAVfoE08Jp7HkPvdSKkXcX6HgCagiciMOmOiZSV2a3/7KLYeN6aKsgc7//h
    0Q1ZOEoMKRkmETh7/6teV3IYKINCLR9mok+DOQLKGbl3dbxnsgWSQCSn9dYaBtDj
    Gu2pkotxczwKC52RIL03bHpulHfHFdylwDjkTLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591814; bh=baCw/f3TKkM7MNaz5NK7UJyUpa
    u309XoWoQwJBWRouw=; b=hmDspJIhn6Y5087NChtKflmzJBh5QD+N265SlDzhvD
    vH1G8oFtnJ1hOB2daqdB91/3B5ID0bUIkvnBvBREFnHtYhhVdT4mCNUoqHAHmKtE
    eZtIWUH5bawOyO9r2BOxafVYShxy5yIQHST0czK2km7ZxlDvtC1W9BR9ww+aIhPV
    6weqsiuBA34IZs5EQ5VHdMzxeS05vtVPugx5S9TJ88Y7nK00vwi5TOZwRYwkFCvN
    FPmrN6v+fzPyhcIZ/Qrrq4Gz68eQhK8KlQ+Wz95K56L8+y75klpFjFNRo0Epvukr
    Egk4lQ1ARwfxS1msCbLRIas4NI7g8UQWxAJilstDGTAg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753857AbeBBRQo (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:16:44 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41056 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753356AbeBBRQk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:16:40 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesse Chan <jc@linux.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 4.15 21/55] mtd: nand: denali_pci: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Fri,  2 Feb 2018 17:58:39 +0100
Message-Id: <20180202140828.375469696@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -125,3 +125,7 @@ static struct pci_driver denali_pci_driv
 	.remove = denali_pci_remove,
 };
 module_pci_driver(denali_pci_driver);
+
+MODULE_DESCRIPTION("PCI driver for Denali NAND controller");
+MODULE_AUTHOR("Intel Corporation and its suppliers");
+MODULE_LICENSE("GPL v2");
