Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2943005-1517591467-2-8054957240884995717
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
    t=1517591467; b=l/bBgcq1fez3rJ/ORdun7R4L+UrELes5CnSF1G0wsRmuCYU
    JWI7kFe6WhnBJ3Dn2SSq6KJywQovxT3qVZorOVTbS5e+nVWEp60h5OUYFl/XtumL
    O1YfmiPtdLqmY0hKzT7VrHetuBgoMDLOK6CkldeozXxEbTKDda34k2zuDP34IAvw
    2S1ZcZZSqpCVOvG+jyPMBJWNdOLljXv3BeXbw/AEEf6MLV4behlvaNxftESCajdt
    hNbRmH5hDpyMeWBmiH+/AskAXLd3IJMWmcqD6KtY0FYxvTfDnLX0nE8XZ/vo6cUU
    xIrtlnmnqEWiOdsWsOSZbrh7a+ggtvW6lNqXKXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591467; bh=mS2RXh6xdeTrRka2Z0lXPCzCuU
    wVqPopUd2GaoFEue0=; b=U0yIA0BjU73rM0SkGheDPBHe6wgEQdRXnDqfhJcE2q
    bkf4XvrOhUk/draO1UCzDPXzGB1Bq9Cr+xVaSkSjFVuap7tFO/kryXI5uot5t52z
    L2tC+YxDwG8MxRGdW+NF4GRolPpDUkmQ01+eMRTmfjvRnd+mYCMB/rL1/6CfBmAb
    00UpYZRNLyaqb3k7SfGb6r0FFtP/JpepDmAsAEc6tdn6roIGJzsTUZFx3TFXG5Kd
    cpDUZ5oLHSTyVEcJAQw4yqcAbf0jx+CvvTUuoawH9ZOjaZExSvRtPFlAazmGJ8bA
    aLE5CAu5epwoQA18BbgcJZX9TEYluXr9UmeSu2M2CRGw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753350AbeBBRK5 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:10:57 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38436 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753345AbeBBRKr (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:10:47 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Meyer <thomas@m3y3r.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 084/156] auxdisplay: img-ascii-lcd: Only build on archs that have IOMEM
Date: Fri,  2 Feb 2018 17:57:45 +0100
Message-Id: <20180202140844.059801348@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Meyer <thomas@m3y3r.de>


[ Upstream commit 141cbfba1d0502006463aa80f57c64086226af1a ]

This avoids the MODPOST error:

  ERROR: "devm_ioremap_resource" [drivers/auxdisplay/img-ascii-lcd.ko] undefined!

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/auxdisplay/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -136,6 +136,7 @@ config CFAG12864B_RATE
 
 config IMG_ASCII_LCD
 	tristate "Imagination Technologies ASCII LCD Display"
+	depends on HAS_IOMEM
 	default y if MIPS_MALTA || MIPS_SEAD3
 	select SYSCON
 	help
