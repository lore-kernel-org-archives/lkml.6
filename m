Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519415651-2-2484323343961634084
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
    t=1519415651; b=F3vkQ5fjQme9mzsKxOewbQOkswCYcjgu7ijruYxqhvWaZsu
    fah/VGBO9C5OzQvETWOJasIHNElJ/v962HX4J9fFuOAheSXJBSW8cSsVE0vN2On3
    MiCIsxEpAzq7vxLyMTrV1p91TnqUN1l3VI9kz2TSpp312PdIMqDx23i3KP4AO9GN
    ko0XvvgUfLzXSPr2w/wyXPcgSFqbq4znWirR/nWspnDfwZ0FW1IU/oaaaxQQddJg
    V4Emros6DJjTcaN0LG+JI/CJhtwXpnKU9a66mv8Vi5A/2lm86ko7XBAVUG+H9HP9
    CsVBIA6f0+FkpwmgAkOYLF1/2+yfXG6LjZYledQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415651; bh=ei+p5PxDoaruILNLqg0UPqfHB0
    fdu6aHAcOrz8doxS8=; b=jAwAZN6f3jsurXTbDzPgXuaSMkEb5tbPmEArrHTxNr
    tKkVLoZynJ3S9bVf3yLLlRfd4jbv4Aeto23LiXy6r8BqKJJLjVyOFHVhKFU2ppSe
    LKTqjAh4ciVLffyJ6ddeF1dLdBBDv0Wqutc57R2pSaN4sbBYAsLJ1eeXF1sdNobl
    9hwXxjeGELvf5ibIigvG86KaHNm/ADc4Q2RlDxmV+0TjaYVWBlDpfDFPF8koKPxl
    iGabznqKWc900x1F4qcBRqSridjxiSPRdl7E7sxlva+e+Eyp65OxburqV55zVcvS
    8fqLvnSvjtstmPMDJwxVmo79vc40z+jIXbplRRY82AjA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754909AbeBWTxy (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:53:54 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43292 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933474AbeBWSpW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:45:22 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keerthy <j-keerthy@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 044/145] ARM: AM33xx: PRM: Remove am33xx_pwrdm_read_prev_pwrst function
Date: Fri, 23 Feb 2018 19:25:50 +0100
Message-Id: <20180223170730.619713900@linuxfoundation.org>
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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
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
