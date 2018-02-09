Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1420212-1518184010-2-13167895977087880011
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
    t=1518184009; b=QWZjtUsBIn5ZRs/kP296ldMDYQAwN13ZxQpqHG+Pmp6+zG2
    /k+frI6ld+KG95ZDnipQfxYyi8Y+f0Jb0UBJCc3zet4l/EMxUFTA/oQWd7pxPYz/
    gplzJ/TO4exhcNJ27eB+mtbPsAT8pSf1PmXxDta+OWCGllLvmXuRL7XcgvxU8hLb
    zDHvqMktt27ES4ctXAC8kxsus6NoFuQQq4ux/iMvX4clwMoeN/g72v9L+PoLPK0a
    7rMJgl43ftAK5eSeQzsuI3IKoz2En5MtCoUOiddP+c2fYUZLCD9CG1Haye8LQESG
    FoJ4nslNiWpsTSUn/J1BV34W/86vy9zv0jxR5xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184009; bh=hG0QTpY6R5UGOzNDKlBX23jVuT
    wbqE/ScgVfb8LEI/g=; b=VzFVYLk/QnxG7whHwIdVbSF2kh7C7bXyrDcLkm1eCd
    l6TUH+rNwUjtBDF2/wApz5ZzxE0xAFCIXtqo1Jm74rp9WwkUqXWgyGCSJY4tScxA
    5DeXsYnFmn9IlW+QOUfqTbDuvJ9wSKLEzDycR31PKNP6hWviLlPLTxrON4dX5dLT
    VIwYlEGnc6rZwUK+tQ+Wq+cvvifYfcBSR6maugBEVTQnZtNtlC+2pQEMFY9Rljm2
    ZIQg+fuHn+tAJkBgynjbjEnQ4RF7Yoxvp3ighBIlQhC74N9xP2P2VOaQ+VxnPbiJ
    g/95hzFcZJEw3beGLz1QmlxwcmggRSB/dK50IuMRpduw==
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
        id S1753869AbeBINqr (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:46:47 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:53432 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753868AbeBINqr (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:46:47 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesse Chan <jc@linux.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.15 21/23] media: tegra-cec: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Fri,  9 Feb 2018 14:40:19 +0100
Message-Id: <20180209133939.352275273@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133938.366024920@linuxfoundation.org>
References: <20180209133938.366024920@linuxfoundation.org>
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

commit 20772c1a6f0e03d4231e2b539863987fa0c94e89 upstream.

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/media/platform/tegra-cec/tegra_cec.o
see include/linux/module.h for more information

This adds the license as "GPL v2", which matches the header of the file.

MODULE_DESCRIPTION and MODULE_AUTHOR are also added.

Signed-off-by: Jesse Chan <jc@linux.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/tegra-cec/tegra_cec.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/media/platform/tegra-cec/tegra_cec.c
+++ b/drivers/media/platform/tegra-cec/tegra_cec.c
@@ -493,3 +493,8 @@ static struct platform_driver tegra_cec_
 };
 
 module_platform_driver(tegra_cec_driver);
+
+MODULE_DESCRIPTION("Tegra HDMI CEC driver");
+MODULE_AUTHOR("NVIDIA CORPORATION");
+MODULE_AUTHOR("Cisco Systems, Inc. and/or its affiliates");
+MODULE_LICENSE("GPL v2");
