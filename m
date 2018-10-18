Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5E8C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD0C20866
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1uOYwXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD0C20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeJSGwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:52:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43768 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbeJSGvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:51:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id p24-v6so15545822pff.10;
        Thu, 18 Oct 2018 15:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zdOcjsQSagxh/0ytfqlFE21zp3hEcz2hdT+yMst4gNc=;
        b=c1uOYwXosBtCvyj575Wmy7ttuIHcMNK9WOp/qfAIhCEVXIWwLVi/nvSSksbKtHFKk6
         vwqJ/TzTagErWp2a6azNCOXFrxllNtmGdHomVGNrcs9LaXZhSjHpgPg0n2juvUueNNOA
         98H4XSt0VABliigRqjNwrv4SlO2eO68UVfqTIu8adDRz8ZSiv4gC2WqnC8U2vWyqTSqy
         zymdMTQ2RTGM2JrvnUcf7hLOPimQR6lqgxbqO3bxwegYcRLhfKZ21hR5xNpp96h4taI9
         7HBHgMMWTmtRsUhbdQNFXV+tZ2Kx27721aXVGRjvmtvpxhqoq+YNH1RjX2gYgbZZY1sC
         hUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zdOcjsQSagxh/0ytfqlFE21zp3hEcz2hdT+yMst4gNc=;
        b=C05ZipSfnes70D1aJnm48lH8DaKQ6idMvvaY8UjHQalQZVSv4lmiY8uMNidHE0gbAS
         WXP+lnc1RLh8kB/onddI88dCpFJbAOBQbb1uC/2pqxSWHNhXq7WRRJ7YoN7Ix/DPZMT2
         maKYd0eUgwiW37KrtoV1Fiwoo2AICoKAouxb2I475LY2DoflbO53cruN882h6kfeNQ3/
         w0kRYQMSDXi+meKJRsY3xScKjK4J0Lc4LbY38Umox4dS2P3DIA9iPHjjbxbmqw2fdJv7
         dTcDYZxqbhV5t+IsuL4DdWcH22WEnggTBYaW1zaywZ/pnOlmogcLpuX/UiqhEnXYP7tb
         6Tfw==
X-Gm-Message-State: ABuFfohe4n+OW7+5m8bZVKlxQiYASInqHOdZidrn0I9guLJUZBq6qV+l
        7VqqNJHoS8Dzx8z26vWiH20=
X-Google-Smtp-Source: ACcGV60ystnSRz3PymYh6lwweFjt6UrpHkGgdyEVaBm+PihEzfeJGpjawOlrkGo5MlBDcSq2mu+lyA==
X-Received: by 2002:a63:f553:: with SMTP id e19-v6mr29964960pgk.417.1539902894348;
        Thu, 18 Oct 2018 15:48:14 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id v81-v6sm38129268pfj.25.2018.10.18.15.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 15:48:13 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v5 08/18] of: overlay: reorder fields in struct fragment
Date:   Thu, 18 Oct 2018 15:46:26 -0700
Message-Id: <1539902796-8382-9-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
References: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Order the fields of struct fragment in the same order as
struct of_overlay_notify_data.  The order in struct fragment is
not significant.  If both structs are ordered the same then when
examining the data in a debugger or dump the human involved does
not have to remember which context they are examining.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 7fcf4a812d06..272a0d1a5e18 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -49,8 +49,8 @@ struct target {
  * @overlay:	pointer to the __overlay__ node
  */
 struct fragment {
-	struct device_node *target;
 	struct device_node *overlay;
+	struct device_node *target;
 };
 
 /**
-- 
Frank Rowand <frank.rowand@sony.com>

