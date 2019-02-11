Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395FAC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1390E218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfBKMDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:03:53 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:47711 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfBKMDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:03:49 -0500
Received: from orion.localdomain ([95.117.94.93]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MX00X-1gZ11z40hl-00XL4d; Mon, 11 Feb 2019 13:03:43 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     michal.lkml@markovi.net, yamada.masahiro@socionext.com,
        linux-kbuild@vger.kernel.org
Subject: [PATCH 1/3] Makefile: add kernelarch target for printing arch and localversion
Date:   Mon, 11 Feb 2019 13:03:34 +0100
Message-Id: <1549886616-12609-2-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1549886616-12609-1-git-send-email-info@metux.net>
References: <1549886616-12609-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:/dNOibbpk12LcyHKu7QlgMuXkWu5btEnQkRpmO8IwENpNyh3QYH
 PUbom05VYELEgIfDt/jBtOdhYrJ8AW2JHZh1whYPNeKj91rjmZjTJ8PbnDZ7dcMxTqN6tA5
 IE1aGrPHrlBM0c2t7BNs5BVWb35Q0F0hmzPa7XTb3sJVgGyJ9mYFF6ih/6LpH/A8D6Mo7UO
 O2mYp+n5wq7n9FyCFQgfA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sz7qJMTdRwg=:5whiIjofzdN/UjFAeCivNg
 Kt3BiWbVsSTqCL0Yi00SwQsb1nyWOXzUlVSUIcW3nUy9aYi8gJBTD1f1bEP8P47WpsZeDP7Ln
 8vgAtC1nMh+chJyrGpjdFUPqWHN9HjOsyDjsBfFLqNRWp7fESjQd5WDunk+/YXK7vQzfOo2er
 K43tIQJt1pK+NbioqQhU3g7vhYpz56B2nl64p6u8ME2rXTOdsUZZdkFyJXAd9nVykIkvmRxD0
 Phy+ychMCdLHLrNI5Sf5apwn3ooBr/0jSKNWyvOBFHEafIQABNLMTi1fWZXG33DDqY0Xaioer
 HzlhKWub2jQSZhs7OBlPpV83UrwuSkU5wAgx02/tScc4MWWTVwarESQvBWy3WlRGVf8tgDhjg
 y84FyGbP55hrYquP8qQOL7K7n5hSQkAZTirwiQZfgrEBVYHMB8dx72JWuhEZ14GWFAQGXllT0
 zkkCI1FlAjK/CxAgxRZOuvV2H67ChNdE2MV8CPkt+4OZKcgefJlJrX5/bhopCxaiiNBbC4ZIo
 0AmyVUWm8kI7BaBrXge58ykOWHncp1+VQmLOvALm7GGycloeo3WLu3A3SJn7fB4LoH5UjRwba
 jgqyF6cHf0OnzakCeChWZzQertL98GUxWdi1Pw5bEAwNAW9H3BOF6dpyo2c2v+Ksz0ehMBBh/
 /6M1RUL0cNJwksghuenbpvev5xFlV/7xpMgohmqDuhK/Ps4X/tcVyWaIF3SUS8zFlPn35Ld5/
 +HslsiluYW2b5+/MjmGkAiK7slD53UYTPZ9AoQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trivial rule to print out the kernel arch and localversion, so
external tools, like distro packagers, can easily get it.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Makefile b/Makefile
index 86cf35d..68c3e08 100644
--- a/Makefile
+++ b/Makefile
@@ -1664,6 +1664,12 @@ kernelrelease:
 kernelversion:
 	@echo $(KERNELVERSION)
 
+kernellocalversion:
+	@$(CONFIG_SHELL) $(srctree)/scripts/setlocalversion $(srctree) | sed -e 's~^\-~~'
+
+kernelarch:
+	@echo $(ARCH)
+
 image_name:
 	@echo $(KBUILD_IMAGE)
 
-- 
1.9.1

