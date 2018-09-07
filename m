Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132FDC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB712077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxbtAgoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB712077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbeIGTEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:04:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42363 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbeIGTEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:04:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id v17-v6so15146281wrr.9;
        Fri, 07 Sep 2018 07:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6S4+R6t3MHRtpyof6hhlGtGIrBaCv7hp38DLjey31r4=;
        b=UxbtAgoVf880CGO5FXv9dK3mFrkiDPmUQKci3MXiqd5zkGUOY+1fgPcXj45QO3L7Az
         nNKuP/5KuoKB6DSvEiNCJBCSubZwYPftzkxQC5UlintDeqQ7gbtFE2O6mcDBe8n1Ilem
         FEfLk1xcSggwlyrP4OjMUOE+0dfn41aV6ELJVBzQkg5rE8vgy+cX2Rx5e70cwrWH9O+1
         Wt5JU/myq37l+ety4QUJzGoOJ29+gtly4ln3zCtymAxj42pzEVgSAPRfu1x7X7zlcbHD
         x+rr2RpzOkfRyo1zCJP9Bmi7g3l/+E2o8Mnjwe0qgz9l/ximEJGP9XjY068HBi1FFnm9
         7UjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6S4+R6t3MHRtpyof6hhlGtGIrBaCv7hp38DLjey31r4=;
        b=JrXJVcg+7o2zh5evY6arxZW4aSwSoTkewjgOvZV3MZWUUmK/Y35H0vHaEjJNFvlo8y
         kSSgx1IwVnQ1n1NrMjBWe/JUEMdxxlWV0lRprCtDE+nkFvWf5NcFuiwPLIWp1jyLiKtz
         MvIpbVCaIH/6iYkeWaPN//KMinG8e1zhgiex2XKntQhJcSqb4YerOPX6s44+449PqPPe
         sKpM7RFgnHT5BGb8dyGtpahc0h9iGFwwTdeV0wZR4ne2xKX/HdiJbFgI5XaCx+zbPqu/
         QqV2lWqcIIxF3NhrZ5h74xMMqNEWv4EqSK0Ehu00Jwt2MG+iYawHc5XJlXRLzq880PFr
         JEcQ==
X-Gm-Message-State: APzg51DXeOAtv4qBiETuWtT13A52Ej9mRB8qhRKJDQ5H7PfIUbyDPwcB
        lTnkM8PobNlmYelgV6sxeFU=
X-Google-Smtp-Source: ANB0VdakFaPrSeUuNKnCbjtYfGYgJccj5ELSA4fpwg6nYVBQPFp+1HX550EVCiVnyeL7atjbFGYGxg==
X-Received: by 2002:a5d:5344:: with SMTP id t4-v6mr6683644wrv.257.1536330168882;
        Fri, 07 Sep 2018 07:22:48 -0700 (PDT)
Received: from localhost (p2E5BE549.dip0.t-ipconnect.de. [46.91.229.73])
        by smtp.gmail.com with ESMTPSA id g2-v6sm6130195wme.20.2018.09.07.07.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 07:22:47 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] of: Split up name & type in modalias generation
Date:   Fri,  7 Sep 2018 16:22:47 +0200
Message-Id: <20180907142247.2931-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The kernel's vsnprintf() implementation discards all alpha-numeric
characters following a %p conversion specifier. This is done in order to
generically skip any of the various modifiers that the kernel supports.
Unfortunately, the OF modalias is generated with a format string that
violates the assumption made by vsnprintf():

	of:N%pOFnT%s

While processing the above format string, vsnprintf() will eat the 'T'
character, assuming that it belongs to the preceeding %p specifier. This
results in a modalias with an incompatible format, which in turn causes
the automatic loading of drivers based on modalias to no longer work.

To fix this, split up the generation of the name & type fields into two
separate snprintf() calls to avoid confusing the parser.

Fixes: 73813f8483b1 ("of: Convert to using %pOFn instead of device_node.name")
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Note that a more elegant fix would be to make the %p format specifier
parser report back the exact number of characters consumed. I briefly
tried to implement it, but quickly ran into numerous special cases
that make this solution rather involved.

I can spend some more time to improve this in general if that's what we
ultimately want, but I think this patch is a better short-term fix to
workaround the issue.
---
 drivers/of/device.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index daa075d87317..dabef9fc8538 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -218,14 +218,20 @@ static ssize_t of_device_get_modalias(struct device *dev, char *str, ssize_t len
 	if ((!dev) || (!dev->of_node))
 		return -ENODEV;
 
-	/* Name & Type */
-	csize = snprintf(str, len, "of:N%pOFnT%s", dev->of_node,
-			 dev->of_node->type);
+	/* Name */
+	csize = snprintf(str, len, "of:N%pOFn", dev->of_node);
 	tsize = csize;
 	len -= csize;
 	if (str)
 		str += csize;
 
+	/* Type */
+	csize = snprintf(str, len, "T%s", dev->of_node->type);
+	tsize += csize;
+	len -= csize;
+	if (str)
+		str += csize;
+
 	of_property_for_each_string(dev->of_node, "compatible", p, compat) {
 		csize = strlen(compat) + 1;
 		tsize += csize;
-- 
2.18.0

