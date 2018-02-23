Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519415729-2-8158312055854122725
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
    t=1519415728; b=DzxoNAZcHMAU5aWjQTEg9J8drPoFlAK+75H6UmLKCrKxdk3
    ajr0btvyDEumnZX9caEHwtP6K96QWc8zWpZi6cmCYVkZnYxxYdueivfMPmiZXyw6
    RFjVDC2b/0oa5QSinmV2Olf19Y8CPz3CNngZTEJBP12ybrQOWo1uylcyYIw8HuYb
    t5ggxnXIP89hNHDqYAk6d1+Q+pUZZv9QriThbbgEwSBVSZCvUtxyBqymitSFxWxR
    5trUJDH1Y/TBBJBoZgkiiJGkKyenbie8CkIQ9CpP3RhZmtVaUi+Pw8mkqwtjzDGn
    oVBylKqDXxAnWRbxpg5IPSIk4vfnNcO6OsEW5gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415728; bh=i34l95xSJ7MCSqgKkzRCuqHC5s
    fDu5+6BUYc21LJrws=; b=akbVPPPYAkaUh2jsKukQvgZPEgZns1YsF294l+rg+K
    ygXW6kHyhR2iS6hVi69vL1iKocYkCeFf/8A3X8zoaTrHHxp09ZxBaud39i0tmHYn
    xC0tY21bHAhdGr0ZzrEAx5GuYe706KFOhzXICDLey/O+m7YC5JGHMMISmXsbzrrt
    yOyDuIQ61VNyRDNEg5n2zXUFDwWpz95uRIg11MfKoogYkLzufW6hY3ix9QZoP3Aq
    JC7X7kE0rZCd0wN6DzsUmif8st0zTYBo3uXijQjTOZ8L5VrWBv/BjX/E1kCl5Bus
    XEUiJaiglnuWidDfgMS2XY3H2cKKxc0fy4guPFiXrdIQ==
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
        id S933691AbeBWSpA (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:45:00 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43176 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933683AbeBWSo7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:44:59 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 063/145] ARM: dts: Fix elm interrupt compiler warning
Date: Fri, 23 Feb 2018 19:26:09 +0100
Message-Id: <20180223170732.889749918@linuxfoundation.org>
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

From: Tony Lindgren <tony@atomide.com>


[ Upstream commit d364b038bc962f494cffb8f6cb6cddbe41bcb5b6 ]

Looks like the interrupt property is missing the controller and level
information causing:

Warning (interrupts_property): interrupts size is (4), expected multiple
of 12 in /ocp/elm@48078000

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/omap4.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -352,7 +352,7 @@
 		elm: elm@48078000 {
 			compatible = "ti,am3352-elm";
 			reg = <0x48078000 0x2000>;
-			interrupts = <4>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "elm";
 			status = "disabled";
 		};
