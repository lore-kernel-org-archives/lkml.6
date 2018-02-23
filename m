Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684173-1519413621-2-8635300439704270692
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
    t=1519413621; b=kmklv++5ILxAOMGbfrlXy3HZeKLQf1miE4YfAl2a+usqdd9
    AAdZZn+L9/qx3Y8xhk5aSIuJvmYSD43fPGPxyrio5nvaDmCScX77dYm9OOo25c7R
    SIKr0BaPJQOUgnpPeM9kK9BvkVjmcj5OjZwHBbRDCv/RUa7E/J6mgvDf9Lb3aTMN
    d0wIsFbCBGJRqbTaxl2R0meDqtFu1a5s3CbThchAIRU2FL6bmxOjzA1dU4Ier0eS
    mNX7EHKTsuf8tewSQORB3A0hezZyoHjc8vhdN+n3XpvQ6t+UyLyoQG9RT34E+YKi
    4H1ax4XytPnP+gU5R6G2erRBwPyiZzHKRYiChIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413621; bh=iEYjlMXqXDN0GG4WmNF5KHPvd8
    4XehHZ0YiTLppGzmA=; b=uM9xpTQr4gU/84NjENPv3YJjkZmd183AKFsfwv3Gdn
    WXsXoOsEfM29mmlpmO7n+MEIKHESCTdE258qQVEgsRU4WacU0JX6GJ2VVI+6LHw9
    QCP7LSBgY7QNdOHoArLzk6qyLkBhLGAtuvcNeT0GBqQjmwYC5jxFiJ+qKH88b1vZ
    dhZ+g1aH8mUbQo/U69v9fAUzcC1M7qDmRuw+2I8b0Cdp0IIiL8GSWKz8yv6lpL41
    MvKNVG4N172sVL8vhlceLHRg5el91HRB8H/GJG3yFkPeFHqiUMRtsRmcx2zGMW7A
    Cc/kCex/Ckvpb1exTT9a5a/boudhLJkk9xiAikoHB7Tw==
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
        id S1754559AbeBWTUH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:20:07 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47702 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964927AbeBWSyS (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:54:18 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 109/159] ARM: dts: Fix elm interrupt compiler warning
Date: Fri, 23 Feb 2018 19:26:57 +0100
Message-Id: <20180223170756.587859057@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
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

From: Tony Lindgren <tony@atomide.com>


[ Upstream commit d364b038bc962f494cffb8f6cb6cddbe41bcb5b6 ]

Looks like the interrupt property is missing the controller and level
information causing:

Warning (interrupts_property): interrupts size is (4), expected multiple
of 12 in /ocp/elm@48078000

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/omap4.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -354,7 +354,7 @@
 		elm: elm@48078000 {
 			compatible = "ti,am3352-elm";
 			reg = <0x48078000 0x2000>;
-			interrupts = <4>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "elm";
 			status = "disabled";
 		};
