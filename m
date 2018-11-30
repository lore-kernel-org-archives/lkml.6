Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAD4C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0102145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0102145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeLACZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:25:56 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41631 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbeLACZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:25:55 -0500
Received: by mail-ot1-f67.google.com with SMTP id u16so5378214otk.8;
        Fri, 30 Nov 2018 07:16:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YT8bgPYqsHS/K7FSdYvtifRCaWuRFkB2kvyF+ibo+QY=;
        b=NuObYL1fLgMlO0yt80rfEVUkigyFUmcnyjouF6c5E7dFsnoN6c1HoRa2glWshYgo8k
         wdfEol9qceptH/w6Q+hT4G+W5L2c877e1JvTmX9luKuSIOpIHHIpg0GEkONJiY5xRT0J
         fPv2TpbpoxFWWQ9tXHCSN7ZGy/6FBr3mbBtI7UTLEVQS7ImIqBx+yoBfV5U7MuKJsGeG
         hmL/+NSIIzPo4krVUNihyxn2X8vNCO012mnjSqzAKJ7nhgHbbVA9pUOa6YWxLCELn5Y9
         MLt5f4htLziSiP//yuSm9FVXFuMAkCg8PEx60/2+rGq65GxqIyQumwAJ48yQkf0o8CVo
         nfYQ==
X-Gm-Message-State: AA+aEWZtcdAiy0kOiRV31V0A2fBKLdW9oEo8afOCgwHto1yDKYIEycMu
        R/gvw2IsUoSbgErwtNUNWUV3hco=
X-Google-Smtp-Source: AFSGD/VNMcGSCYhSoUFm6NNHlXtEa/NtNe+DN/K5pJb5GUI/8SGQvilqsbtIai3ZVlbXcq0glXFgvQ==
X-Received: by 2002:a9d:5c6:: with SMTP id 64mr3855562otd.274.1543590976003;
        Fri, 30 Nov 2018 07:16:16 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id r7sm2011537oia.28.2018.11.30.07.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 07:16:15 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH 3/3] kbuild: Enable dtc graph_port warning by default
Date:   Fri, 30 Nov 2018 09:16:10 -0600
Message-Id: <20181130151610.30596-3-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181130151610.30596-1-robh@kernel.org>
References: <20181130151610.30596-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the 'graph_port' warnings have been fixed or have pending fixes, so
we can enable it by default now.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 scripts/Makefile.lib | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 46342f0198f6..8e10eb7428ab 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -251,7 +251,6 @@ DTC_FLAGS += -Wno-unit_address_vs_reg \
 	-Wno-avoid_unnecessary_addr_size \
 	-Wno-alias_paths \
 	-Wno-graph_child_address \
-	-Wno-graph_port \
 	-Wno-simple_bus_reg \
 	-Wno-unique_unit_address \
 	-Wno-pci_device_reg
-- 
2.19.1

