Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3118118-1523472876-2-9909014248660827967
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES encada, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523472876; b=s85psr38vjbeHVBvjyY+AMRo+iu0GlKc4s2cIiieOYcJMn0IEA
    GhDYP0lyQv2sDljdQl9W12Tw/z74GD23rlpbnZeAocjcGQnKDvBjnlqxnLHIfOSH
    DahvewBU27Ye/UBrUhQSdchHCzZxbyYNDzCzfTlK9J0oRSPGeHkLb4Kvesk1Z1e1
    GAw0E1SWtPUTcVPvlOhNDgvLfykWK2juY5Jc38t9KkgzTOnaCseOLcubl1dMMFtr
    8E1nGC5DDUVb0Crz3+EcaqFsgNu5TPHF6gd1dT8JjxKgGSK38m2t8E8yiXjvzLkx
    JqaZtVeXch7gCQF49f1Tulfi9t3IK7SSpfZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523472876; bh=tbFYusftbOENpBQhbsk0bXpyveLWbf
    I3Iw7WYj0NI6Q=; b=E1NhPEV9FP/eJLJuSBYmmWEAHqV8jHaVqXdLoc6rZltYzo
    VdMtL4rVzVv+Fh05gyWflP2M3CPuzAbMAXsWRMbBj8RdFelkCAGUbwUrnw7iL6gA
    9Tp2IPBy1kGPlzPZCUsOmRAwj8KKiFHewTusBsJImXy7jD82EXYbgTo14yVAdTiJ
    a2lACMsL5vKkLt6X6oOlCfHe6xiHgWZ07Z+cBKsrpdQoiOSkaVuc2PKa24IBhLhk
    0xkemox6Z1GGweCYpf51anFm/hH7QfGuOYd94OrlVZ7gxejPM1NS/ten5er8WwJt
    rBeV/Cck+u4CXsSWmko9tJQrOWb453pE+3R8pMjw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP7We8i8NzpfNAqL5Y7gWkc1MnSaanHIPNdBXHO1HKRLt4FBydEQ8bB3zMxZ9ONkBsSWxMhI1JUKAB7BLmyI8NN01q5UtWrkLqPjqr1NIHfdjpyO1VOd
    w/bawCBWk9ru1VxsmipwO1ec0/UpNovB3UmqDJ4VmwVmsc/IfeWVmBjFOLfJ4QRN5pmgvTly/F9zrhL/cZeyn10uTtV4GJLt9L1vsSGeGviXACNdwObpeKXp
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=r_fWTGAKDiqRsgqVgI4A:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933512AbeDKSyc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:54:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34484 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932610AbeDKSy2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:54:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 046/310] clk: renesas: rcar-gen2: Fix PLL0 on R-Car V2H and E2
Date: Wed, 11 Apr 2018 20:33:05 +0200
Message-Id: <20180411183624.235222875@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>


[ Upstream commit b7c563c489e94417efbad68d057ea5d2030ae44c ]

R-Car V2H and E2 do not have the PLL0CR register, but use a fixed
multiplier (depending on mode pins) and divider.

This corrects the clock rate of "pll0" (PLL0 VCO after post divider) on
R-Car V2H and E2 from 1.5 GHz to 1 GHz.

Inspired by Sergei Shtylyov's work for the common R-Car Gen2 and RZ/G
Clock Pulse Generator support core.

Fixes: 7c4163aae3d8e5b9 ("ARM: dts: r8a7792: initial SoC device tree")
Fixes: 0dce5454d5c25858 ("ARM: shmobile: Initial r8a7794 SoC device tree")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/renesas/clk-rcar-gen2.c |   23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

--- a/drivers/clk/renesas/clk-rcar-gen2.c
+++ b/drivers/clk/renesas/clk-rcar-gen2.c
@@ -271,11 +271,14 @@ struct cpg_pll_config {
 	unsigned int extal_div;
 	unsigned int pll1_mult;
 	unsigned int pll3_mult;
+	unsigned int pll0_mult;		/* For R-Car V2H and E2 only */
 };
 
 static const struct cpg_pll_config cpg_pll_configs[8] __initconst = {
-	{ 1, 208, 106 }, { 1, 208,  88 }, { 1, 156,  80 }, { 1, 156,  66 },
-	{ 2, 240, 122 }, { 2, 240, 102 }, { 2, 208, 106 }, { 2, 208,  88 },
+	{ 1, 208, 106, 200 }, { 1, 208,  88, 200 },
+	{ 1, 156,  80, 150 }, { 1, 156,  66, 150 },
+	{ 2, 240, 122, 230 }, { 2, 240, 102, 230 },
+	{ 2, 208, 106, 200 }, { 2, 208,  88, 200 },
 };
 
 /* SDHI divisors */
@@ -297,6 +300,12 @@ static const struct clk_div_table cpg_sd
 
 static u32 cpg_mode __initdata;
 
+static const char * const pll0_mult_match[] = {
+	"renesas,r8a7792-cpg-clocks",
+	"renesas,r8a7794-cpg-clocks",
+	NULL
+};
+
 static struct clk * __init
 rcar_gen2_cpg_register_clock(struct device_node *np, struct rcar_gen2_cpg *cpg,
 			     const struct cpg_pll_config *config,
@@ -317,9 +326,15 @@ rcar_gen2_cpg_register_clock(struct devi
 		 * clock implementation and we currently have no need to change
 		 * the multiplier value.
 		 */
-		u32 value = clk_readl(cpg->reg + CPG_PLL0CR);
+		if (of_device_compatible_match(np, pll0_mult_match)) {
+			/* R-Car V2H and E2 do not have PLL0CR */
+			mult = config->pll0_mult;
+			div = 3;
+		} else {
+			u32 value = clk_readl(cpg->reg + CPG_PLL0CR);
+			mult = ((value >> 24) & ((1 << 7) - 1)) + 1;
+		}
 		parent_name = "main";
-		mult = ((value >> 24) & ((1 << 7) - 1)) + 1;
 	} else if (!strcmp(name, "pll1")) {
 		parent_name = "main";
 		mult = config->pll1_mult / 2;
