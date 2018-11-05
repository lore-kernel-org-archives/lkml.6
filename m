Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CFCC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91D120825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ki6Wgy5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91D120825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbeKFIaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:30:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52108 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725733AbeKFIaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:30:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id w7-v6so9952986wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 15:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NR7/4GP7YK0tr2b/JpXE+NH3LWhxmoZ3idljVVirVVg=;
        b=Ki6Wgy5MUsJFbW+bD7IDqrlaR9LGixvoAG1FKXqxaTf5VL0Tb8aIqKvH48GEm22RWH
         6kWqnt176VESod/Np250VO6FqAMEXRs+rW6qcGaUTlQQgqInvA7KqsvFun98m44e4mT/
         E8LpjE50rfLFABBpbtmaT7Gl0h3W8up/cjwd6mPFGV7/ACFJRoESKGKotPFSXufYpa2J
         QpA2v7fsy14AishKPgqa5KcrsHg6OFUp+9iK3/81ZDI8PVCnoOe5bMXTX/1K63jp9NKq
         y3TqpRo1KXmPcte7TtGX2pp8TTCGUaG9dFV6IouBNqLmHyiuXGFoKRQsv6xZD4rf9zJ2
         FIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NR7/4GP7YK0tr2b/JpXE+NH3LWhxmoZ3idljVVirVVg=;
        b=o4A1O6DkhC8Gmkmb1fZDytjQ2Cz9yiaaFHinThgTRbIvjDvf9NrGtAxRBRI+Bx+moO
         KRamnGqPu/po7gyM2g6eGsKTwVv8GZ2iRa80l3sU82LTxwuQlZHBd7FBXFkkvkPss/rD
         upyGUja/4IGm2KBTPYPyPfocgGyZRRaERc/cZ3LxXTcKhhp0/l06Gw2dtScGWWjP2Nqs
         ruJBr7uGnCOKQZXtTrZfKSdvEgyzeYdkQbCoZTuN2XfBU3cYRfbB+TubeWUQ6A8SuQYO
         KGb/9oZkfzHOLFpnSNPHju4PbnbH7MLgva2og22my4WajlhhfVh1deGOOM9vKlIcjCgv
         3QQQ==
X-Gm-Message-State: AGRZ1gKiSgMfCxEOB1D/I9YBhdomIhUotJQ4itiSCXk1k++49BgkikW2
        t8gW8KqqzxOBggkXk9oPv3Zzng==
X-Google-Smtp-Source: AJdET5dmOkm+gjnM53TtOi7MXJqaCDRSXs9rZeFKoLBDE+EeRxqqNesLwCsXkzjtIZ8JIfIcTmUSAQ==
X-Received: by 2002:a1c:bce:: with SMTP id 197-v6mr75878wml.15.1541459313122;
        Mon, 05 Nov 2018 15:08:33 -0800 (PST)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id k73-v6sm95717wmd.33.2018.11.05.15.08.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 15:08:32 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2] clk: meson-gxbb: set fclk_div3 as CLK_IS_CRITICAL
Date:   Tue,  6 Nov 2018 00:08:20 +0100
Message-Id: <20181105230820.3562-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Hewitt <christianshewitt@gmail.com>

On the Khadas VIM2 (GXM) and LePotato (GXL) board there are problems
with reboot; e.g. a ~60 second delay between issuing reboot and the
board power cycling (and in some OS configurations reboot will fail
and require manual power cycling).

Similar to 'commit c987ac6f1f088663b6dad39281071aeb31d450a8 ("clk:
meson-gxbb: set fclk_div2 as CLK_IS_CRITICAL")' the SCPI Cortex-M4
Co-Processor seems to depend on FCLK_DIV3 being operational.

Until commit 05f814402d6174369b3b29832cbb5eb5ed287059 ("clk:
meson: add fdiv clock gates"), this clock was modeled and left on by
the bootloader.

We don't have precise documentation about the SCPI Co-Processor and
its clock requirement so we are learning things the hard way.

Marking this clock as critical solves the problem but it should not
be viewed as final solution. Ideally, the SCPI driver should claim
these clocks. We also depends on some clock hand-off mechanism
making its way to CCF, to make sure the clock stays on between its
registration and the SCPI driver probe.

Fixes: 05f814402d61 ("clk: meson: add fdiv clock gates")
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/gxbb.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 9309cfaaa464..4ada9668fd49 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -506,6 +506,18 @@ static struct clk_regmap gxbb_fclk_div3 = {
 		.ops = &clk_regmap_gate_ops,
 		.parent_names = (const char *[]){ "fclk_div3_div" },
 		.num_parents = 1,
+		/*
+		 * FIXME:
+		 * This clock, as fdiv2, is used by the SCPI FW and is required
+		 * by the platform to operate correctly.
+		 * Until the following condition are met, we need this clock to
+		 * be marked as critical:
+		 * a) The SCPI generic driver claims and enable all the clocks
+		 *    it needs
+		 * b) CCF has a clock hand-off mechanism to make the sure the
+		 *    clock stays on until the proper driver comes along
+		 */
+		.flags = CLK_IS_CRITICAL,
 	},
 };
 
-- 
2.19.1

