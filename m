Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C353C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 22:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14822534C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 22:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfRuSVII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14822534C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeFXWm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 18:42:58 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44262 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbeFXWm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 18:42:56 -0400
Received: by mail-pf0-f194.google.com with SMTP id x23-v6so1612040pfn.11;
        Sun, 24 Jun 2018 15:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=NPutboYjtowQQoHeP3+FySHvWM/4wSc0drJuKwrN/Ns=;
        b=OfRuSVIILKggptsC7V51Q4ATDC4xNgPocY6T/VZ3wTsg8psRNHbhGsm+yz/mM0qG/d
         Mi/Kjs0yFTzs2afBNsDH7wQ/YbObf4UpvzqQ2xK4fJPz4SzaU3z05YwmBFohasWBjvdm
         mr+mx7LjBvb39oa2BQFS7aPKwm9Qrp5aLeVTUHAn0TpvRdzTirofJYOEhEc0Sm8bUVwr
         KV55zAyjpP2+nYy6LXKborUPFxIxJEuF7RroaEbhDAgxePnMRGXZF0Fqkhppq1gIZHF8
         sfoWXJDDYuWHNdN+5pbGDfxHd3bpgkBvvkayydXkdhaRt62erFYwiIE4mu9VdUnf+Zmk
         WURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NPutboYjtowQQoHeP3+FySHvWM/4wSc0drJuKwrN/Ns=;
        b=khEFhlRuMOC9bu4ZFShpBdyh4XC1V9dtfvyp87b5XuqYmTFUjVI7J7sYuK6QUTDA9O
         i0TzuXXomoeVSvHqmJaMypAf/Rbzj9NlkPEZ3b5RqfMWmLKjU4gdWcutt4xVndrGUfHt
         EjufZUsmpvRGtC1Lth5oDYsgqLJQ5RgqvcFAKg/acDA/frjusMJWivNyrlNNWJxt1495
         AFtdoH5s2rPc+C8K2ZcpjKcuLdLBcp6z7TSAp53MHw1d4G1BT0u2jAZ7C/RVGhR0MtnZ
         ynn+tOcMTV+Et5fSYhfJ3zWMIhY2PYMu6F6BI321HzBnUzhyLrJCJ6+L/95s5gUNqP+B
         0BFQ==
X-Gm-Message-State: APt69E07EAzSXK/Rmuv0g7Sq4X73CZEn/hzU6iHJincof2BpY5A88v+u
        Sg2EZHBLjtgQ3DGMpRcNgsYMVyIM
X-Google-Smtp-Source: ADUXVKLKUa9GlWRcKECwT7Z385/K29oNFXJGGCapJW1vPMeGGlty/ADtMgnX0vh6IuOanhctnXJL/g==
X-Received: by 2002:aa7:864d:: with SMTP id a13-v6mr10413266pfo.247.1529880176052;
        Sun, 24 Jun 2018 15:42:56 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id k10-v6sm34844763pfj.29.2018.06.24.15.42.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Jun 2018 15:42:54 -0700 (PDT)
Date:   Sun, 24 Jun 2018 15:42:52 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Rich Felker <dalias@libc.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] sh: make use of for_each_node_by_type()
Message-ID: <20180624224252.GA220395@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of open-coding the loop, let's use canned macro.

Also make sure we are not leaking "cpus" node reference.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

 arch/sh/boards/of-generic.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index 46b2481eec903..26789ad281936 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -56,15 +56,15 @@ const struct of_cpu_method __cpu_method_of_table_sentinel
 
 static void sh_of_smp_probe(void)
 {
-	struct device_node *np = 0;
-	const char *method = 0;
+	struct device_node *np;
+	const char *method = NULL;
 	const struct of_cpu_method *m = __cpu_method_of_table;
 
 	pr_info("SH generic board support: scanning for cpus\n");
 
 	init_cpu_possible(cpumask_of(0));
 
-	while ((np = of_find_node_by_type(np, "cpu"))) {
+	for_each_node_by_type(np, "cpu") {
 		const __be32 *cell = of_get_property(np, "reg", NULL);
 		u64 id = -1;
 		if (cell) id = of_read_number(cell, of_n_addr_cells(np));
@@ -80,6 +80,7 @@ static void sh_of_smp_probe(void)
 	if (!method) {
 		np = of_find_node_by_name(NULL, "cpus");
 		of_property_read_string(np, "enable-method", &method);
+		of_node_put(np);
 	}
 
 	pr_info("CPU enable method: %s\n", method);
-- 
2.18.0.rc2.346.g013aa6912e-goog


-- 
Dmitry
