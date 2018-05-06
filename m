Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2499662-1525566649-2-13019706616969811400
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525566649; b=PV37+FwbkgvpxFJy4Xo2kE/05kwAIzr5UJfH9XoZT/v5ZlJ3WF
    1tUToxkSkgyw8Z/PJRdxwAja3a+Dz1E6vR3yxAXWmrEWsLuETo2Ohlgtjsbe4/w0
    84gzfGMNm5BjbBWgl0EC/1jYEZrwFF5zREwNW5ck7dfhX5I/Xf7H/6w7S6kNEp8/
    5FIM2TIuS42YwsUzRNcH6LOwIwQpBrV4ziu4U5B8r7Fl25tGuZhoSI/o7xWsoK9v
    pDjd2f93vIRZ72UGRFDBgWYA5vVpi9lNIKWS1c1R6rVUGQjxsjWwF23hYinUVTn2
    5xfjkChjw0try9Og/eJKDlJFR6u4Nrkv4I3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525566649; bh=
    SjDclrEDL9Iu04gmCE30jeY1Qbt9fTR2CstvGaBHBnA=; b=YRqkYXlAjKBmwxeF
    KoNV9gs6p6M1xjL8dhgsDHUml0tm6/5HEkdGBhNC58zkgtzkx/KcCrouP/ju3HjO
    waTOKD2SzFeX9W+D/GZO9mgiNgiQCsYTOjgqz2a3VLqoj+cIjOjY3arLAnmLp32C
    CpSC7HGUgP/WfAH+GYJ9jP2nq4bqs7aO5lwRGSW6HgkpPlFQQlrcEF3cNVnLpHV2
    S/F7v0Hg4OuQPH+ih5wRgt6UFXsBjWDYHOowB1Dzvm2FXNQSU6Q44jxYY4aYNf8C
    h9fldkQ//x5S8Q1oM0Cx4qhiGWUxbN2joNKkhBtESQv9Dp7VCnTY5rk4yA3H1Waa
    +3Y1Vg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJEqN++QagpXxFEq7vc4DG6AJVI+FI5jwkmiuXTF+yGn+ioM44nyVGuLiwdjbOK5M51iwg8YC4ZkWtdU9W7G/Ec4Q+CCFUwBdYv/yzPb6i6SRXqwkSUh
    5FxtgLWDItZmAnwu2GxycwytsRVvArb6hc784K+k5Rn7UHB7u60n8TGsLM9VHvUz5oieLFQA7DvA4qPevyHOjS9tFpLck7/0bz0mpYNHE3MJy8uYroSwcFGK
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=OvG5uloFpF5yMZtpmc0A:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbeEFAap (ORCPT <rfc822;linux@kroah.com>);
        Sat, 5 May 2018 20:30:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:58221 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751952AbeEFAan (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 5 May 2018 20:30:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,367,1520924400";
   d="scan'208";a="226149324"
From: changbin.du@intel.com
To: yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org
Cc: rostedt@goodmis.org, rdunlap@infradead.org, x86@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Changbin Du <changbin.du@intel.com>
Subject: [PATCH v3 2/5] regulator: add dummy function of_find_regulator_by_node
Date: Sun,  6 May 2018 08:20:13 +0800
Message-Id: <1525566016-30172-3-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525566016-30172-1-git-send-email-changbin.du@intel.com>
References: <1525566016-30172-1-git-send-email-changbin.du@intel.com>
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Changbin Du <changbin.du@intel.com>

If device tree is not enabled, of_find_regulator_by_node() should have
a dummy function since the function call is still there.

This is to fix build error after CONFIG_NO_AUTO_INLINE is introduced.
If this option is enabled, GCC will not auto-inline functions that are
not explicitly marked as inline.

In this case (no CONFIG_OF), the copmiler will report error in function
regulator_dev_lookup().

W/O NO_AUTO_INLINE, function of_get_regulator() is auto-inlined and then
the call to of_find_regulator_by_node() is optimized out since
of_get_regulator() always return NULL.

W/ NO_AUTO_INLINE, the return value of of_get_regulator() is a variable
so the call to of_find_regulator_by_node() cannot be optimized out. So
we need a stub of_find_regulator_by_node().

static struct regulator_dev *regulator_dev_lookup(struct device *dev,
						  const char *supply)
{
	struct regulator_dev *r = NULL;
	struct device_node *node;
	struct regulator_map *map;
	const char *devname = NULL;

	regulator_supply_alias(&dev, &supply);

	/* first do a dt based lookup */
	if (dev && dev->of_node) {
		node = of_get_regulator(dev, supply);
		if (node) {
			r = of_find_regulator_by_node(node);
			if (r)
				return r;
	...

Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 drivers/regulator/internal.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/internal.h b/drivers/regulator/internal.h
index abfd56e..24fde1e 100644
--- a/drivers/regulator/internal.h
+++ b/drivers/regulator/internal.h
@@ -56,14 +56,19 @@ static inline struct regulator_dev *dev_to_rdev(struct device *dev)
 	return container_of(dev, struct regulator_dev, dev);
 }
 
-struct regulator_dev *of_find_regulator_by_node(struct device_node *np);
-
 #ifdef CONFIG_OF
+struct regulator_dev *of_find_regulator_by_node(struct device_node *np);
 struct regulator_init_data *regulator_of_get_init_data(struct device *dev,
 			         const struct regulator_desc *desc,
 				 struct regulator_config *config,
 				 struct device_node **node);
 #else
+static inline struct regulator_dev *
+of_find_regulator_by_node(struct device_node *np)
+{
+	return NULL;
+}
+
 static inline struct regulator_init_data *
 regulator_of_get_init_data(struct device *dev,
 			   const struct regulator_desc *desc,
-- 
2.7.4
