Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-977734-1525484675-2-13539652893539576964
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525484675; b=jlhfCIK1E2kYoxTRwgfAtaQsoR3mpoveQA5P4vOMjMyinxl6sn
    Vv0QF/0UCH2YXAYLv1K2uvuAJ5Mz32x/2iQWUUQqfD5hi6wbRn3HWcQwE+LuJ7IR
    u94CcGPzR3JQFxdGXoQAMurQp0tBSQVzxsi+aRwWJUeygBc7PSQl83V661nDJw1z
    iABTScK7xkHszxpgJHwtI0BPBk7Aw1vVIJIfs4dg4wgPnbvJiKbMW3W61AUrHvLB
    8SbsEKFM8NUdoPQvhwSOhoSSC9x4xivXsq8pgtZl6ckW8uSE0i3mr2u3tVZHaQFM
    x7ivrLwcSuvVSwLkVPOJo5FinobEdw0SV+hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:message-id
    :date:sender:list-id; s=fm2; t=1525484675; bh=aMo6Y+PKYkNSQZOAk1
    Ln+xYfxw3zqr9vmzwPzx1X7K8=; b=RgoSfJBsoTtJxC38wPSzgHiRk1lQ5TcoN8
    rYrKO5OscX41tfyT1TFSqqsXQfRgGD7nsui4woAPQlF1RbLjZe0mIkqna+UZylIw
    DySVKyuST8/DGNUzYtLdVkTLrLlqyzovE6mFh+xmI4BShiaAzsa0e02qrVccA/5k
    spS5/jHvjX9nfagWec8ZQ+918p8SS/IXG8iyooDEwDYj4T+1GWTQaTlVqEAzh8AN
    59xCKVZ4oG29xc07LFRjfg5J7EwgIj9awL3FhKA2KrIP9YpKA4n/31Ln/7sppR5O
    knLE40LCZOnYMDo9gB+eJehJUE5KuS5SFO9X8em5E38DiZK/xm1w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=sirena.org.uk header.i=@sirena.org.uk header.b=vlaiZ0Yv
    x-bits=1024 x-keytype=rsa x-algorithm=sha256
    x-selector=20170815-heliosphere;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=sirena.org.uk header.i=@sirena.org.uk header.b=vlaiZ0Yv
      x-bits=1024 x-keytype=rsa x-algorithm=sha256
      x-selector=20170815-heliosphere;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD9Dh85Ri6/iIerYVKcTo+N5YIV4XTY9g+wITMDnFDDYmExfvnA8rPnWWwxaHR7Y58ajwduBtafRj/zS4U3yJWnl9u9Xcj/8fei5JEc59XB7KdUZtQGr
    ZyTc/ZRseoE560GzB2dafC/pjv6z6Nb5AGqkvXZfIr5OLhtLEHtZHuz3D6JOA58vqKdn6xpOwk8HvsTGjY/oayODhPwaElZ8SY24FsnTTX5dYMJDvrvZXWxi
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=QyXUC8HyAAAA:8 a=T4Wh53ZaH-sK705GRnMA:9 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751771AbeEEBoe (ORCPT <rfc822;linux@kroah.com>);
        Fri, 4 May 2018 21:44:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36970 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeEEBod (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 May 2018 21:44:33 -0400
From: Mark Brown <broonie@kernel.org>
To: Changbin Du <changbin.du@intel.com>
Cc: Mark Brown <broonie@kernel.org>, yamada.masahiro@socionext.com,
        michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com,
        akpm@linux-foundation.org, x86@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: add dummy function of_find_regulator_by_node" to the regulator tree
In-Reply-To: <1525179614-14571-3-git-send-email-changbin.du@intel.com>
Message-Id: <20180505014413.ADEDE44007A@finisterre.ee.mobilebroadband>
Date: Sat,  5 May 2018 02:44:13 +0100 (BST)
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   regulator: add dummy function of_find_regulator_by_node

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 08813e0ec1cb48e53c86a24d88d26b26878e7b6e Mon Sep 17 00:00:00 2001
From: Changbin Du <changbin.du@intel.com>
Date: Wed, 2 May 2018 21:44:57 +0800
Subject: [PATCH] regulator: add dummy function of_find_regulator_by_node

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/internal.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/internal.h b/drivers/regulator/internal.h
index abfd56e8c78a..24fde1e08f3a 100644
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
2.17.0
