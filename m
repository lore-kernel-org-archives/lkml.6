Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-420878-1519831400-2-13520258146983062144
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519831399; b=YOqxEtL3DNdmJGjahC/w6QgyWePs9iEGpvfyyQFkHo4DxMK
    Rq0x9dWvkX6w9MRPCmIKqtHI1FOAvxLWwhAiKaE1MQ3ALHn24TRX+JUTDWNKff5/
    9Xeg/6qFLI9Mkz2XjKGSeGrECwKEfdHw1DWtxJXBCHL3WjAXoc8Fc2ImCqYJBCgt
    OVJ1wf1jFd+dDNzoCS8X2FNZLj1MDT3/3qxdCgMChPbB7s1kkAhGlT5VYrcRS8kF
    LlWxUHtVC7tUDycljmFm1wBXe6Wfo1a+WuNGoh1BmAmeJyVvxhe59J7/7c/c54Yz
    WmHTK9e70TsPLY66LIy6hWDeV3as7VcUghaMQtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519831399; bh=Ep/s7aNF+8QhN+yAfeq
    kgXJXwP1ruxV5QtQNlCPHoBw=; b=PXnZgtbDcOae7RFrS01UCWlIhF1PgE7hbqO
    A7IzYkXNXHmmbZziLa2hwEHD+jw5fdJLFA6Idi0hGrY+r58Jv/a1sGsp9Amc2mIJ
    gEQ23SKyqgDC5rJnV2TAXDgTZZQ6WQ7g6wHAYa/Vk40A4LuqM3C3VZ5+0QLbo5rK
    ZFxzPhGgtNv3s5TnXrWQYSQqBvxix9Oux4EqSQ14oBw/whuicDxYmTTzJo3WR71P
    uKyIhzIoD12w9d8EaRrIiI5C4gMnsfmtWFHNC6Wf36E51tU2ZaENptHonBUjAYjc
    4L7rBpwUmIj5Yx3BeE6FmUGrZcM7t3bLk7T88gLT0v4wpcVvsMA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932719AbeB1PWs (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:22:48 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33223 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752683AbeB1PWd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:33 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Johan Hovold" <johan@kernel.org>,
        "Peter Ujfalusi" <peter.ujfalusi@ti.com>,
        "Lee Jones" <lee.jones@linaro.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.742866676@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 038/254] mfd: twl6040: Fix child-node lookup
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 85e9b13cbb130a3209f21bd7933933399c389ffe upstream.

Fix child-node lookup during probe, which ended up searching the whole
device tree depth-first starting at the parent rather than just matching
on its children.

To make things worse, the parent node was prematurely freed, while the
child node was leaked.

Note that the CONFIG_OF compile guard can be removed as
of_get_child_by_name() provides a !CONFIG_OF implementation which always
fails.

Fixes: 37e13cecaa14 ("mfd: Add support for Device Tree to twl6040")
Fixes: ca2cad6ae38e ("mfd: Fix twl6040 build failure")
Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mfd/twl6040.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -97,12 +97,16 @@ static struct reg_default twl6040_patch[
 };
 
 
-static bool twl6040_has_vibra(struct device_node *node)
+static bool twl6040_has_vibra(struct device_node *parent)
 {
-#ifdef CONFIG_OF
-	if (of_find_node_by_name(node, "vibra"))
+	struct device_node *node;
+
+	node = of_get_child_by_name(parent, "vibra");
+	if (node) {
+		of_node_put(node);
 		return true;
-#endif
+	}
+
 	return false;
 }
 
