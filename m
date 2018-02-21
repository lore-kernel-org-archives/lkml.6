Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1568560-1519219026-2-1288263501857698536
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
    t=1519219025; b=Akcj3QA6bUrHdA+5rlHCG/f2HdEcYbK86u299n/YSBFbfCl
    vzILbZfaSduWv2m4wfTHndEk8StAG+Qt42ue+07V/TGnNEZ90mjzUhWsQqTKzueP
    UNH2m6p3sukU8mR7epXNDKk8zqfzCs+UdTn006lzNO+Iu/+LkFEyW0C+74T+Sp2K
    Tib05EgRDreYZtcNUWa+D+1kTTwmg7L6/PxqC/ndJJOb8ezPHyBZNQLRDf03oa15
    kLJ6rMmaQftMacVTkLvXuFsngu/U3q+emREiauqHzQkHBIiurd6PyyNG/U/wgJR6
    RweoCwIskjk78IzC97uSqerax4iyTusofI8HtBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519219025; bh=PMKy1pMYIU/mSvbtyzFHNDm4fm
    ZXFjxlUDWbJjTGbXA=; b=uZQFZFpLBLTKZ4bbLn2oPYhXK8azRxDc5J/Kmsldgp
    LzVx2VcXh3JU1EhoY+QNPYs1ufz+mqsJCMEIjzjSgmWgxR+JRIybZlDiH2LMn/qg
    C68pW1/QC3WVmwEoecXyyTOY0r5jvub5JzDJ4tUB9Jt02H9+fYSkQwZh8n7NqCWP
    OfhGWx958UMKgFxp0ITjMpjESebSle2uUcTWf6IEJQGjZwq3YlIAswtY1cQRygit
    LlwftoUUXedK4qpcYZQtYwC3oigLb7HG+WekU9+mSyes1J26xJG/ykRimgdBrrub
    IyYvdxWSkHXzt8einX+7qpR01KJX6QCEqsNC3SxMHjSQ==
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
        id S1753543AbeBUNNC (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:13:02 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45906 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753150AbeBUNNB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:13:01 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH 4.15 160/163] ARM: dts: Delete bogus reference to the charlcd
Date: Wed, 21 Feb 2018 13:49:49 +0100
Message-Id: <20180221124538.756648298@linuxfoundation.org>
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

From: Linus Walleij <linus.walleij@linaro.org>

commit 586b2a4befad88cd87b372a1cea01e58c6811ea9 upstream.

The EB MP board probably has a character LCD but the board manual does
not really state which IRQ it has assigned to this device. The invalid
assignment was a mistake by me during submission of the DTSI where I was
looking for the reference, didn't find it and didn't fill it in.

Delete this for now: it can probably be fixed but that requires access
to the actual board for some trial-and-error experiments.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/arm-realview-eb-mp.dtsi |    5 -----
 1 file changed, 5 deletions(-)

--- a/arch/arm/boot/dts/arm-realview-eb-mp.dtsi
+++ b/arch/arm/boot/dts/arm-realview-eb-mp.dtsi
@@ -150,11 +150,6 @@
 	interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>;
 };
 
-&charlcd {
-	interrupt-parent = <&intc>;
-	interrupts = <0  IRQ_TYPE_LEVEL_HIGH>;
-};
-
 &serial0 {
 	interrupt-parent = <&intc>;
 	interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;
