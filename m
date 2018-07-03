Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B808AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7CB2251D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYO8ujmy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7CB2251D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934073AbeGCKGb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:06:31 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36681 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933995AbeGCKGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:06:15 -0400
Received: by mail-lf0-f65.google.com with SMTP id n24-v6so1133075lfh.3;
        Tue, 03 Jul 2018 03:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=JRbcH2OYu2NNHS+lYmbpnKuyCQmmqjsopCKWTT4fY6w=;
        b=lYO8ujmynFAbIumTjeVBtrzuqUhTmQD1pgwE4CziKiFnABkgZ6pUxd8nrk9Brr6RLG
         eVqoH9PEkETjx+rnlcUpVJfgGe1wn6g24LCNbD/gLSx0AaYHZsEbGWCsXLMXkD5jNwlv
         l4ZTZj6JFTqZ7Si3YE9MYdLv7fwO+BTWHDRbyRQhyfVHVv1SfW2aVkdmEv4w7KYA542a
         DfAgM+d+hngv3EoBHQhDkY4RYSgXWd7sD/QtB95uy28ikfKCdSVvxfrCsdbbihK1zsjo
         EbzbzHj8OWrxo6FUFLvrAnzf30NeJ7CDzg/4PGXw7ss1BSZfQuXTDUyhRH7znUS518pV
         aSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=JRbcH2OYu2NNHS+lYmbpnKuyCQmmqjsopCKWTT4fY6w=;
        b=KJ7AA3ORGiKs2ZvXBO2zrMNHO9LPmovMbgHOLHdMWiQoun15gi7mx6WFc/Sjy+W7H8
         mCF4/zBmYHgeUJiPoLZRRMpf6diW+A3n6vtHcaICHHMRh16HzKqqftdJE8ZwSuRjp96T
         NHD7VgsdCJsx8bjuveEVi0OACwqtoUDy0jTGXYtC2wjRe+jW3RMMWoK6ooCDuOVkUgBs
         Svf8rvS4/MjgPoKn4bOOhOXAsX8cCl7l0+H4PeqNNuPt5KIFACnIWG5juRb+joOBSIpA
         yNl397QpvhsoJ69IIIBDXBifKp9LP0RdJUFpiOAp7EcQhnMef+/cZjZCFpzTq1w+hGqB
         /Obw==
X-Gm-Message-State: APt69E3keyZQhz2ZPGDsAxnCDMlj5sSLVI2WK7cHBxzdlZWFfkgvMXhp
        A2z/vaqILVV83KbvsjLF8IM=
X-Google-Smtp-Source: AAOMgpdUKgq9D88rpcYmOMYDXkz+BhcCs+F9rjAJfS5tG9yp6Ld9gYiav+lSEysVj+7AgaEXxavTMQ==
X-Received: by 2002:a19:6902:: with SMTP id e2-v6mr6343066lfc.70.1530612373528;
        Tue, 03 Jul 2018 03:06:13 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id m72-v6sm178818lfm.49.2018.07.03.03.06.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 03:06:12 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1faICD-0007s6-EX; Tue, 03 Jul 2018 12:06:05 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>
Subject: [PATCH 1/2] misc: sram: fix resource leaks in probe error path
Date:   Tue,  3 Jul 2018 12:05:47 +0200
Message-Id: <20180703100548.30214-1-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to disable clocks and deregister any exported partitions
before returning on late probe errors.

Note that since commit ee895ccdf776 ("misc: sram: fix enabled clock leak
on error path"), partitions are deliberately exported before enabling
the clock so we stick to that logic here. A follow up patch will address
this.

Fixes: 2ae2e28852f2 ("misc: sram: add Atmel securam support")
Cc: stable <stable@vger.kernel.org>     # 4.9
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/misc/sram.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index c5dc6095686a..679647713e36 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -407,13 +407,20 @@ static int sram_probe(struct platform_device *pdev)
 	if (init_func) {
 		ret = init_func();
 		if (ret)
-			return ret;
+			goto err_disable_clk;
 	}
 
 	dev_dbg(sram->dev, "SRAM pool: %zu KiB @ 0x%p\n",
 		gen_pool_size(sram->pool) / 1024, sram->virt_base);
 
 	return 0;
+
+err_disable_clk:
+	if (sram->clk)
+		clk_disable_unprepare(sram->clk);
+	sram_free_partitions(sram);
+
+	return ret;
 }
 
 static int sram_remove(struct platform_device *pdev)
-- 
2.18.0

