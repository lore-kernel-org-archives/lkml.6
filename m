Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F07C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4E525DB6
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Di6sjhIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD4E525DB6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755300AbeFYQEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:04:48 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34987 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754012AbeFYQEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:04:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id z137-v6so4921424wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 09:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=wLQxL/zx/Q7mTIfCcZPNsKkINeXIDYAB2hfhFPbxlTQ=;
        b=Di6sjhIbR2leN9OgBAyVM5g6m1qdJazKx0DqcpmVb52EqPJrBtoEhpo5OYz/Uxlv84
         VuvUiAwPLALDkrCd72SfeWCP6i5MbbJieJOIUq/N4HGr/MdjAdz+mFs3gjBEIzLDCIPO
         MLRkDYKOBsbZyP5oK5BRGeiwK6Ln3r/E8IZfLDEpjcfgTxCi0/FywGqStuH4557/qF18
         8tezZ+cvPl5e4vnm5MCKQQ8v/yjsOfBzRqVuTo/WQs9Z3Wbgon/uXeFRDNu0JERvHa4C
         gilsmlgU/ht2tUBZU/C0qB5jdFL1cOkMW5Jcpfvp1mMYVyxynX5FovIiOw82GZYzUrZj
         5WKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wLQxL/zx/Q7mTIfCcZPNsKkINeXIDYAB2hfhFPbxlTQ=;
        b=AP2NUkx+85VSWAO4b++2SMGEshIDS5+lU1+LOdqPGKdtWWncZ/ifU7tCCJC2xAYo6b
         dnwrEsoOWqS8sshVoGBWpT2E2ZIk7rBO2FPq35sYRjoSODk45UU+cygsPv8GO6J8c753
         wwM+xV2kl7W3tYr1knoCxifHA7zM6oRHXhhRsvEsfSLAgBQjkaG4lzhf3oJ3ik+R4NmH
         2/1SC8dlHXuvZENRLjYMWfRK1ZG7pEJ+qEgi0h75vonAcZdQHnx9yCciNrQPnhErw2Uf
         6C/gA6pvSM3xkm09JAU3xh9thsILv5Umd96bRdzmMKTasx74wqjNFK50dlZ9Yn01c8nh
         nxIA==
X-Gm-Message-State: APt69E30yqIbIITVDLj/A51CMFGpfXKc9+pDcl8gtzhcnz3cLmdl8PV9
        iJLJm0k7JLI+ZtZBxx8DGYpILbGyrJY=
X-Google-Smtp-Source: AAOMgpfisUA1AzGZWiCcqOWZXHWDWr8pZB/oxOvPn32OD3YnQ7c0TRaBONLOC0csAkWNlcVmluzWCg==
X-Received: by 2002:a1c:e8c6:: with SMTP id f67-v6mr1433377wmi.25.1529942683741;
        Mon, 25 Jun 2018 09:04:43 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id e63-v6sm14091370wma.46.2018.06.25.09.04.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 09:04:43 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@baylibre.com>,
        David Lechner <david@lechnology.com>
Subject: [RESEND (again) PATCH] clkdev: don't call __of_clk_get_by_name() unnecessarily from clk_get()
Date:   Mon, 25 Jun 2018 18:04:40 +0200
Message-Id: <20180625160440.10537-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The way this function is implemented caused some confusion when
converting the TI DaVinci platform to using the common clock framework.

Current kernel supports booting DaVinci boards both in device tree as
well as legacy, board-file mode. In the latter, we always end up
calling clk_get_sys() as of_node is NULL and __of_clk_get_by_name()
returns -ENOENT.

It was not obvious at first glance how clk_get(dev, NULL) will work in
board-file mode since we always call __of_clk_get_by_name(). Let's make
it clearer by checking if of_node is NULL and skipping right to
clk_get_sys().

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: David Lechner <david@lechnology.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/clk/clkdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 7513411140b6..f394e8964909 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -199,7 +199,7 @@ struct clk *clk_get(struct device *dev, const char *con_id)
 	const char *dev_id = dev ? dev_name(dev) : NULL;
 	struct clk *clk;
 
-	if (dev) {
+	if (dev && dev->of_node) {
 		clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id);
 		if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
 			return clk;
-- 
2.17.1

