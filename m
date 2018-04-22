Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2669103-1524408226-2-11523836534660731748
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524408225; b=wZajn7fm4CBZbJg4C8PEfF4Lei/jEg0UUolO6GOnrqbWH000nT
    loGwj6Vgb8yrdymkabxO8Fgf2uIhNP7CjoE/Ilb70Bg1tHaaSvLrXoXc+mYUqG2N
    mbhR+ReBmzSkNFi+ZUIS3dpDxwZWPJ/jJIBQvjRRsMJMEv/3zmjUinE3Btpz123e
    YkU7bWdXgITCRIpZDMqiDW7SLqJOzaGo7/hegkJPS7EUTWcxjqzQtwLNcvpFJYYb
    iRq9Hx1c4/pDq3MA3lRKBXphk60uH3+Bp1VY+HXELYQ0uiahuQZYNTYzhWXKl1bl
    ckgWvuuokbkcvsrJZgHMufNxaa3w/GkeIXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524408225; bh=sP9WY3k1tMPU4vT74SrqTJs8mryuTe
    Z4JH6e3G3HxT0=; b=GtXxBfsalvQWtoxnwNWI89LHOpx1sp0n7fbQoGmPINW5FD
    mlduPdjNoJHQY6IGOvQcJ7iBG8AkHdTx5kNHW1vDAjelyzI5mPDxw3BakN16Qi/o
    kHLKWbo8jyOmQW+On9IkEhgbkrb8D5BfaelDwmcYG6sPv7R+NBLm8+Z1Pr4rYdi3
    1vHHEwY+Ze5f/WXKChYvAIhG/1FXIoh8JMrVmxAbwY5ErSk1AZHNVefS/Xq4FIfc
    qpfnKVHNtkCzpB310Kk7VUujfBERZgBdDLg6EHOL3VxcfSihK1EdXTz9WcLhkuJq
    5wc+GBEleKPc/mdHsww6krFZSpSJbmlXosj5IsCA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfBfgNXHHpC4OLu5LCQUzR/2DRCb6u8CTqu/CjgzQ+7XYz8s741kB1iv2Z0vTY4ow+oC4AX7JGbVt2FgzMjy4HMaTHiG/EDvlSktK6/8i2XQ8/G2JkzBd
    wzKZU5dQQxhTlL8bKFoI28zMj28sPNRfyZlT4DpGgSEaOg8UqZDcHjZ/aaDCJEbBcbWZR6QVcgf6e3bpyqZq5vnlBBz4dZHoccSbF8WfAsuPrVQPSDbqbtO9
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=Vs2_iBweCjJHQ4vTY8MA:9
    a=ylfJgOWwrFvA9psi:21 a=tB_c9X-3SSGUN93M:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757193AbeDVOno (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:43:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57976 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932397AbeDVORG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:17:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Kelly <jamespeterkelly@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.4 45/97] ASoC: ssm2602: Replace reg_default_raw with reg_default
Date: Sun, 22 Apr 2018 15:53:23 +0200
Message-Id: <20180422135307.825480085@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Kelly <jamespeterkelly@gmail.com>

commit a01df75ce737951ad13a08d101306e88c3f57cb2 upstream.

SSM2602 driver is broken on recent kernels (at least
since 4.9). User space applications such as amixer or
alsamixer get EIO when attempting to access codec
controls via the relevant IOCTLs.

Root cause of these failures is the regcache_hw_init
function in drivers/base/regmap/regcache.c, which
prevents regmap cache initalization from the
reg_defaults_raw element of the regmap_config structure
when registers are write only. It also disables the
regmap cache entirely when all registers are write only
or volatile as is the case for the SSM2602 driver.

Using the reg_defaults element of the regmap_config
structure rather than the reg_defaults_raw element to
initalize the regmap cache avoids the logic in the
regcache_hw_init function entirely. It also makes this
driver consistent with other ASoC codec drivers, as
this driver was the ONLY codec driver that used the
reg_defaults_raw element to initalize the cache.

Tested on Digilent Zybo Z7 development board which has
a SSM2603 codec chip connected to a Xilinx Zynq SoC.

Signed-off-by: James Kelly <jamespeterkelly@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/ssm2602.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -54,10 +54,17 @@ struct ssm2602_priv {
  * using 2 wire for device control, so we cache them instead.
  * There is no point in caching the reset register
  */
-static const u16 ssm2602_reg[SSM2602_CACHEREGNUM] = {
-	0x0097, 0x0097, 0x0079, 0x0079,
-	0x000a, 0x0008, 0x009f, 0x000a,
-	0x0000, 0x0000
+static const struct reg_default ssm2602_reg[SSM2602_CACHEREGNUM] = {
+	{ .reg = 0x00, .def = 0x0097 },
+	{ .reg = 0x01, .def = 0x0097 },
+	{ .reg = 0x02, .def = 0x0079 },
+	{ .reg = 0x03, .def = 0x0079 },
+	{ .reg = 0x04, .def = 0x000a },
+	{ .reg = 0x05, .def = 0x0008 },
+	{ .reg = 0x06, .def = 0x009f },
+	{ .reg = 0x07, .def = 0x000a },
+	{ .reg = 0x08, .def = 0x0000 },
+	{ .reg = 0x09, .def = 0x0000 }
 };
 
 
@@ -618,8 +625,8 @@ const struct regmap_config ssm2602_regma
 	.volatile_reg = ssm2602_register_volatile,
 
 	.cache_type = REGCACHE_RBTREE,
-	.reg_defaults_raw = ssm2602_reg,
-	.num_reg_defaults_raw = ARRAY_SIZE(ssm2602_reg),
+	.reg_defaults = ssm2602_reg,
+	.num_reg_defaults = ARRAY_SIZE(ssm2602_reg),
 };
 EXPORT_SYMBOL_GPL(ssm2602_regmap_config);
 
