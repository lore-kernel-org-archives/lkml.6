Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3973753-1520972267-2-3796512064803228190
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520972264; b=VqH4bhxMOSkGewcWGtznFFbT+oKTZ6B7L/dxtz6MyCQPPXZ
    Ka3HtBURLA+8YL8pDjqkY4FVcs3/e1Qtjs0VbUhidw+CdwM2cB0lefedBN0p9iJc
    BGRqpmtLKQKUQGQrrIkd0tQC1BObZhyyv4UGpU+3jV/xTc+989tXgHrKR4w/d+fr
    eew5UDnlqatE+vEpghsG2zWHjAYh64Fi07KyTPXT+LMob0qGN19BIlfsnQ8Ow8RO
    ry5Fr8qB0Ny2mWh3CYGr5U+KSJBKyrQFPYLY20h9Thp35kuH6mhx+CTGCq3YLY65
    o0FbdsiAennPX7/IwohT7W1pWxJKvm1MxutyltQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1520972264; bh=OQbzmBMpyapnw/qUsMce0l4y1b77qlQSiPaHd3XnbHc=; b=H
    an6wFIIVciMCtmMYPG+lou95cUSC4LfnXNBtcD+cgd6cqNni8uRVkGsLizEX19DK
    29eRvLNvEzL5kM6ZFTuzXrov9S9ArEuql06hye8iNRE2lykjnptx0I29y6iL+2YO
    bLKV00lJTRbEnYwVh+xDT0zZQikcNHirj+t9tvZx4xvIFO58X2pSZePRc0vIhTht
    f/Vb+St2XA1hkhLm/a55DRv86C2YLPAyBp1/EMY+a3cCmlc32ga1Ci1YVM14OMY+
    1bGv7MJR3WGzjWdrHN5sUvywuRVGddZ/f9AeG/X/NPxlHXfscINRBxpu2/06r0KP
    +t/TDMK6fayy1hb2ldNmQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nxp.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nxp.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752280AbeCMURn (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 16:17:43 -0400
Received: from mail-bl2nam02on0081.outbound.protection.outlook.com ([104.47.38.81]:54208
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751955AbeCMURl (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 13 Mar 2018 16:17:41 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC: Russell King <linux@armlinux.org.uk>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH] crypto: arm,arm64 - Fix random regeneration of S_shipped
Date: Tue, 13 Mar 2018 22:17:23 +0200
Message-ID: <db77e20709db11b951a28c3303feb63990ef82d7.1520972030.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131654458595023922;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(7966004)(39860400002)(39380400002)(396003)(376002)(346002)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(97736004)(110136005)(16586007)(48376002)(50226002)(106466001)(6666003)(54906003)(50466002)(118296001)(105606002)(47776003)(36756003)(53936002)(5660300001)(6306002)(1857600001)(450100002)(85426001)(49486002)(26005)(336012)(81166006)(81156014)(956003)(2906002)(508600001)(104016004)(68736007)(356003)(26826003)(8676002)(966005)(8936002)(51416003)(86362001)(305945005)(316002)(4326008)(142933001)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3362;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD025;1:TVcssv39gwFoWo+vQ49HHuXUuSDsJvp9RAT9rqPtzvcg2Y8VifFdib7vaAfZK5sLbxFEKmp0QGBAxK39Hu6pHRDCCs+6x+PtUoHX4SjiXfLIchx2KO525nLZcVm6iDcf
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd7361ef-c647-452d-112a-08d5891f780b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:BN6PR03MB3362;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3362;3:PRs6XNqoyflrpdnTB0JfoMzwIWjVvRG7Y03/RfeXKZjFoQZ1BV78+k0hq7ftmARoiKtsroKEl+lBbl3ZVu3q95CqzYfHhc9wlm8eYUxusNuao2wlKqcCoELIaVoqcAdouCA+Rdv2jXQEWFDo00KsqPpVBPTl1hqCluyE1+9coANA0TsW2XVrHDROAAiveYbUtgXNXqDyEd733+eyV2zOwGE8EOE4whS4x5kRo8d7NV3zkjsKUYEQdQQ6a4jfTHYKm9hbJ+Vf48cLcy8ZQEqFozCdAHhts8VfFfAkOFpLKFTTt6Wt2GOBaF232QrT1rXF2p84BIe4Lbgk80lCpjaSJStu4AyQeEjx+rFSmqxQt10=;25:RsWpJVDI/EbvDcQYTIzuZi+162HSQP8D0pHOa+H3e1jzk1JLbmVRMyL+8iG2B5/tsgVVp4HTJeLDJGE9E+68O4TR8saP3rtWMvQ2CrU6QWmwrGZTdeOqbN5KLSfzHtkpAU1tLPC3w6TFd/D/ZZeyS6UN1iYzi1Yf9RiI365FTb31jnF7eRjMunI94mcFDtgT7lPvEaShp26ujAlMXa7qb1awU+zweVg/dA13q94XGboMDe6Wu3dBPAH9g4nDasFC/7mPrgIZovK+cPeHzQGWJ3gVdSVM9KoY0nZp+9mXQu9d2ecv6y/9minmugF0ImucB70SnRiPI/NECpYBWKBR6w==
X-MS-TrafficTypeDiagnostic: BN6PR03MB3362:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3362;31:Y+WYFya6NgyceuJkanQ/1D24yaFTIOtdma4cFqiRrD08CLZZPOWAbAzjDg2gSKE7vkpHet4q/7DjWvKl/XJiGUy19wkzjChCSmTl+ZO6REtOnr9MqCUEP1yvxJMY+4NuD5EL44MZql4KDxiAKSAwBfUlWDPrGPp6YQVzhtk/Dp4afPI1Q8flI9MJGu6Av22F14SuDrwN5moxziKBn2BwpSiz0BAHa66vwTCr0QBIjI0=;4:cLD901BOzKKhqqpY063DsXfOUh9w2O5N6HJ/cGSbQg8OIcAV32AlDTxSBM+4S9CHCa0ejSJQyjNbPvyCHXEdxHH+zdHaEMHVnsjGgIkLCjnQpH0qmQtQsSzTb9QE+zJCXaqR+pFrZFT9iBObnjUapjjpQbYZaQzu4+bVAsVEqFQn22m67SgISzN9v7S4zyT/WutsOVWx08S3rol7P2OGm1oInTQ/b3OTodV6j10S3DIKfFflEFXgeuisG0BkxLza2wsxgGKy8ox/DDn0jrb7ARZwQzLdL16Fil0e59wSRw8VRIQteO+EbjB+utpwCqMXjIaZWANqsRkl2SsPLbIrZET5g4fjogftGgLzkeIpb7U=
X-Microsoft-Antispam-PRVS: <BN6PR03MB33628DEDD250B30B6542FED7EED20@BN6PR03MB3362.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501244)(52105095)(6055026)(6096035)(20161123565025)(20161123563025)(20161123556025)(20161123561025)(201703131430075)(201703131441075)(201703131448075)(201703131433075)(20161123559100)(201708071742011);SRVR:BN6PR03MB3362;BCL:0;PCL:0;RULEID:(400006);SRVR:BN6PR03MB3362;
X-Forefront-PRVS: 0610D16BBE
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB3362;23:IFR2dmBtrOUmqkX2mQWoYrrcpmDu0GqhYFu1jGoM8?=
 =?us-ascii?Q?JbmTX+FAdH1n0Jq3H64gZ3vFyoPU+QwFLHh2QE62loV1VVBRUIQCAOGfuSSp?=
 =?us-ascii?Q?39j2nfejick3Dydvcbqq3sv8eqOtvC6DUwMeYWNEP+ZoFl07gDaUkGOo2uVQ?=
 =?us-ascii?Q?HPS+hkEwNzv/RBpBNv24n4CoNK695yPW6VZLF1MdIKOCUUOdYtIF9cBjLcUp?=
 =?us-ascii?Q?qTD2xDOof1MiaqDLk0Ju8CSMpms+0R3i3V035d9RogxW4ZCi1OODIVcraPr+?=
 =?us-ascii?Q?McJMlc7az2G+lSi6/gM4gaCmFDEnaLGog4wufNfIEAOQkX8Iir1ru+2xXQxE?=
 =?us-ascii?Q?vVbYEijxjFImkii+Qwe79eQ+2TxEbdD73eM+NtOYEtStzxHKpXLTjWFhziaN?=
 =?us-ascii?Q?gUOevPm8cUIiGqNRcr5bqCtNHxrfjMdWKbBQzw1Doi66Iv0HeRvfhH7vl3GP?=
 =?us-ascii?Q?DK6+ipaVbdoow1LMuoK001GmeproFFMKSdWOLFxSm7eBC4WThYaRrLWiCIaJ?=
 =?us-ascii?Q?ciBzeO9/kTCuqzXEMsJmXQG3ACvQSmgLD54iSZFwgLC+MJd/lWcTJ+9OClb7?=
 =?us-ascii?Q?0kSxTERjVlzy1MhTAsufJQ6DWvxiOazVd2+2d/iufluq5rIBfNgXFsTBAnBa?=
 =?us-ascii?Q?rLBS0RBjMM07FsMh4FfZ/SSDFGbJWUDD2ak1pn159uyywG63+fLdUGKPbsrw?=
 =?us-ascii?Q?F4+WB1rrleP+DIzB3YYbizzwz+FfamHjZw/ZQBQ7vD+DDM2MjIW0X+IsT3Ll?=
 =?us-ascii?Q?cYLMcAWJHNcy1PTz55C+k9XqDPsATgEsAQsaDdCbWBFQD8Og9IRzgiXRyAxB?=
 =?us-ascii?Q?p1z6t1ke8d8ZMSKAx1w6nh0GS6nKrKI9ZOmArxu9H9Fnu8PmQ0XFoVUiEymg?=
 =?us-ascii?Q?NT0pNPyR29yvBboI4yogxoXYUJ8RUB8PC93XAb1nJ67lDM79xmAgo5RReN4k?=
 =?us-ascii?Q?SbZomoGGRRLIfONfmN+85BMdNZBWL3N1XAc6sezqWIJdfzHflwrFK0C8dh4J?=
 =?us-ascii?Q?BEOaCKy1nJmCzU2GN8nJQfMkQ06+WVUFo8TL9AAaBfwTlJo4sFMzUuro3x3F?=
 =?us-ascii?Q?eRf42JhXw9vwGumzdkC3P0YiiA95vpeQvlrPoqZdx4jNOuTUzhXaTog7Rvl6?=
 =?us-ascii?Q?qftGocKY4NLzkF4HVenJusLgvj6xy9DzL2Ox3h2QQ9KfZAkfEsPbAD7c9j90?=
 =?us-ascii?Q?l+GCTWFSCM0WBq686UA9H4sR5wWINJkhNqWMPjwEHNZWemNkut1OPm/Tg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: ///ONsR9h15791H9dNYkLCHFsQCd31LPwXzofw/3eXxTQfwwAyR+2vMAwwrnO/4WCuUezXWNjFam1KHRFrku1Nb4oCFUIouPdjXE5smhKlmvhg8r77xoHY0R2kRa/Y9oR/K2+mja6XNV0En+i3UyMQcUOL93u1+aUuV64717PCxyiW9TSm/LnYzxmjT+oVr2
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3362;6:F2oO20YWQNPCjB4fsCteG/xSnB8J1S1GZ1lEc5Y9aO5DQWwBRGn51ARGGO1RJNZruNSsFvGbsvtuNsWxMWNd8gD4gc5733egewFDhf0HTRghJv10MrJqh8QLVZnctuiHklKL2G8yEuxDkxszv1IhVjjw8cA3GI7IcfUdHfRQy8G0SIGcYacDD265Aysdjo/Udii2LFtHg0Vviwqw8W6biEwfCS5e/kEI5ddUabT/dDVGNtPCSr53OC9g19UX6Hmb8F8zqzp7tKZjKG4lR+xxD3PtVetlD4ZkA9nyX5iLsbHtizcGZpyjBSO+pybC8pfkOZGbSfT8UhwdSlR3Z/GN813MGZJiQyN8dfTrkqLSjEQ=;5:P43SDrP52eWFwsoR0gNvJwPlTkryUgYrBP0ilffLnCsk8c73oQdtbSV/Q5Wiu8AFQsPiVgm0Okodz/3Lfa16zgpVDxIEM4mlV+etVmaCh2hIlgAdBVsprU+pTV2OOCy57jL0E/dMa3q0xjQKyEuJ/rfvIZ1vm6/rBAK6hpnDRIM=;24:Zeksld2mqs+2tX7qXJL9GrMCSYaPum6EdiIJ3hh0bVx1vII1RxNiqrANBeWEpfDCXSkV2p5G5fnldpzzAZaGeafKoqyIDbmgI9KYzYtk3Ao=;7:rb2n/KT5aK34hzWahtrBSRfgr0J48jDxNK3b7BtY/mGeqw3pp1mBOTOlHtUA+R3DXKVfq5762OoWbnnjRwTWXwOgOE/pMxdFxWQa6XguBfiykbOHNX099gy3/hMZL16jCfg/8tzTAgrB++SULCLOnAquN0/UggWko2snPHP7HrqNSQpVtW6N07cZoLL2x21z3a7XiZF/6japzpbsAtrNDRZhEpL+KvxGDCtdKxI4Fv7P9Wr5A9rOphacIspt0IjD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2018 20:17:39.2059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7361ef-c647-452d-112a-08d5891f780b
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3362
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The decision to rebuild .S_shipped is made based on the relative
timestamps of .S_shipped and .pl files but git makes this essentially
random. This means that the perl script might run anyway (usually at
most once per checkout), defeating the whole purpose of _shipped.

Fix by skipping the rule unless explicit make variables are provided:
REGENERATE_ARM_CRYPTO or REGENERATE_ARM64_CRYPTO.

This can produce nasty occasional build failures downstream, for example
for toolchains with broken perl. The solution is minimally intrusive to
make it easier to push into stable.

Another report on a similar issue here: https://lkml.org/lkml/2018/3/8/1379

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Cc: <stable@vger.kernel.org>
---
 arch/arm/crypto/Makefile   | 2 ++
 arch/arm64/crypto/Makefile | 2 ++
 2 files changed, 4 insertions(+)

Not clear if this needs to go through crypto or arm but all commits in these
directories start with "crypto:".

My problems were only on arm64 because of a yocto toolchain which ships a version
of perl which fails on "use integer;".

CC stable because this can cause trouble for downstream packagers.

diff --git a/arch/arm/crypto/Makefile b/arch/arm/crypto/Makefile
index 30ef8e2..c9919c2 100644
--- a/arch/arm/crypto/Makefile
+++ b/arch/arm/crypto/Makefile
@@ -47,20 +47,22 @@ sha256-arm-y	:= sha256-core.o sha256_glue.o $(sha256-arm-neon-y)
 sha512-arm-neon-$(CONFIG_KERNEL_MODE_NEON) := sha512-neon-glue.o
 sha512-arm-y	:= sha512-core.o sha512-glue.o $(sha512-arm-neon-y)
 sha1-arm-ce-y	:= sha1-ce-core.o sha1-ce-glue.o
 sha2-arm-ce-y	:= sha2-ce-core.o sha2-ce-glue.o
 aes-arm-ce-y	:= aes-ce-core.o aes-ce-glue.o
 ghash-arm-ce-y	:= ghash-ce-core.o ghash-ce-glue.o
 crct10dif-arm-ce-y	:= crct10dif-ce-core.o crct10dif-ce-glue.o
 crc32-arm-ce-y:= crc32-ce-core.o crc32-ce-glue.o
 chacha20-neon-y := chacha20-neon-core.o chacha20-neon-glue.o
 
+ifdef REGENERATE_ARM_CRYPTO
 quiet_cmd_perl = PERL    $@
       cmd_perl = $(PERL) $(<) > $(@)
 
 $(src)/sha256-core.S_shipped: $(src)/sha256-armv4.pl
 	$(call cmd,perl)
 
 $(src)/sha512-core.S_shipped: $(src)/sha512-armv4.pl
 	$(call cmd,perl)
+endif
 
 .PRECIOUS: $(obj)/sha256-core.S $(obj)/sha512-core.S
diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
index cee9b8d9..dfe651b 100644
--- a/arch/arm64/crypto/Makefile
+++ b/arch/arm64/crypto/Makefile
@@ -60,20 +60,22 @@ obj-$(CONFIG_CRYPTO_AES_ARM64_BS) += aes-neon-bs.o
 aes-neon-bs-y := aes-neonbs-core.o aes-neonbs-glue.o
 
 AFLAGS_aes-ce.o		:= -DINTERLEAVE=4
 AFLAGS_aes-neon.o	:= -DINTERLEAVE=4
 
 CFLAGS_aes-glue-ce.o	:= -DUSE_V8_CRYPTO_EXTENSIONS
 
 $(obj)/aes-glue-%.o: $(src)/aes-glue.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
+ifdef REGENERATE_ARM64_CRYPTO
 quiet_cmd_perlasm = PERLASM $@
       cmd_perlasm = $(PERL) $(<) void $(@)
 
 $(src)/sha256-core.S_shipped: $(src)/sha512-armv8.pl
 	$(call cmd,perlasm)
 
 $(src)/sha512-core.S_shipped: $(src)/sha512-armv8.pl
 	$(call cmd,perlasm)
+endif
 
 .PRECIOUS: $(obj)/sha256-core.S $(obj)/sha512-core.S
-- 
2.7.4
