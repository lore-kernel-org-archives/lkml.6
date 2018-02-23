Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519414131-2-2133653888517513833
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
    t=1519414130; b=wbz+Hf38B3UKrRMwZxhsCPRTaEdgdvy6lOfTjsn1tImh51i
    s6l8l1Joo3kkltzUPg0J5sd9rp7qQDe94aN9/CpE3ZNQOWT9iBh1vWuKNE1lRiac
    r/tnNXWJ/Npqq8q3CSFeZ3tHHLhTHeIJxm89G/xCx527ptojRoSkAy5JunYuQRjt
    OYWNH8yl0FEZriwYpZzItcsV3bO1/LjN5rumn4OXJUAGKbnkrzNKp65+es1qE9Pz
    OGz3HmBtfylyRWWb2C8K0Qm73PPcgq1aYLNquaGlYmMTeM5bp7JaC0BUtymVeHKo
    lwX88KIZMn/kDrTFGBMGqM3qaePPLSpLTcPJh3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414130; bh=GJe064+zYQUlJbW2G6uRgeVfn2
    3wQt2x+eZkOFsTUP4=; b=E+q8YGojTUnTYzyL1ohFJVcrCFHnjfzQHUG+x18OiX
    X9a3/uBm9uizocHlqab8ObDlMp4AQigEdoZLBLqyDS2vneqG0PCCJ/Ru3nl/2CWL
    rz7ow/zjAvIddtA5JYipHRSvaAP5JG5GlfR/AjeEyWVslfJHWT5/28iNGjlCRYmr
    qSnnft88U3PAwueB/MCKBVtdiddJ60aBHejYXn1oWqMFgzfB3fKMKpdx/KGrYfw2
    JWvEp87JT59jw63DgvxWNMqu/t+rBbKsprj335vsHbOtwvHMk6ASUhgLBp/XNv8O
    hNYw3xflPQjzKdIO4hCoaKs2S+OHaQLmRug02q8mxYiQ==
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
        id S935058AbeBWSwE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:52:04 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46528 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935075AbeBWSwE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:52:04 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keerthy <j-keerthy@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 062/159] ARM: AM33xx: PRM: Remove am33xx_pwrdm_read_prev_pwrst function
Date: Fri, 23 Feb 2018 19:26:10 +0100
Message-Id: <20180223170751.089659979@linuxfoundation.org>
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

From: Keerthy <j-keerthy@ti.com>


[ Upstream commit b6d6af7226465b6d11eac09d0be2ab78a4a9eb62 ]

Referring TRM Am335X series:
http://www.ti.com/lit/ug/spruh73p/spruh73p.pdf

The LastPowerStateEntered bitfield is present only for PM_CEFUSE
domain. This is not present in any of the other power domains. Hence
remove the generic am33xx_pwrdm_read_prev_pwrst hook which wrongly
reads the reserved bit fields for all the other power domains.

Reading the reserved bits leads to wrongly interpreting the low
power transitions for various power domains that do not have the
LastPowerStateEntered field. The pm debug counters values are wrong
currently as we are incrementing them based on the reserved bits.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-omap2/prm33xx.c |   12 ------------
 1 file changed, 12 deletions(-)

--- a/arch/arm/mach-omap2/prm33xx.c
+++ b/arch/arm/mach-omap2/prm33xx.c
@@ -176,17 +176,6 @@ static int am33xx_pwrdm_read_pwrst(struc
 	return v;
 }
 
-static int am33xx_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
-{
-	u32 v;
-
-	v = am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstst_offs);
-	v &= AM33XX_LASTPOWERSTATEENTERED_MASK;
-	v >>= AM33XX_LASTPOWERSTATEENTERED_SHIFT;
-
-	return v;
-}
-
 static int am33xx_pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
 {
 	am33xx_prm_rmw_reg_bits(AM33XX_LOWPOWERSTATECHANGE_MASK,
@@ -357,7 +346,6 @@ struct pwrdm_ops am33xx_pwrdm_operations
 	.pwrdm_set_next_pwrst		= am33xx_pwrdm_set_next_pwrst,
 	.pwrdm_read_next_pwrst		= am33xx_pwrdm_read_next_pwrst,
 	.pwrdm_read_pwrst		= am33xx_pwrdm_read_pwrst,
-	.pwrdm_read_prev_pwrst		= am33xx_pwrdm_read_prev_pwrst,
 	.pwrdm_set_logic_retst		= am33xx_pwrdm_set_logic_retst,
 	.pwrdm_read_logic_pwrst		= am33xx_pwrdm_read_logic_pwrst,
 	.pwrdm_read_logic_retst		= am33xx_pwrdm_read_logic_retst,
