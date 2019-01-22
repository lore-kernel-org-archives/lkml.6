Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC8EC282C8
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69CC920855
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IRjXiJpl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfAVEWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 23:22:16 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43093 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfAVEWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 23:22:15 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so10795262plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 20:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cmQKGebSmYlEhX3wS0v8qxCgnG+jTMlO7/QfZGmiwZM=;
        b=IRjXiJpl4uBg12TBCSEcYEEe8zNLgJE7fL2fTd/uxbKTOWP2JeA9xsggqOOMpnaSbm
         i5Iaht0A8rjCxY9mCqU53OPKa35u7R7/Y7JD/bQg1B3qOEQtVrNXoq5qppmt8kGNTIlj
         Lz4UTlNSxfktgxkUmSnSBgedauyisvGRhYvqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cmQKGebSmYlEhX3wS0v8qxCgnG+jTMlO7/QfZGmiwZM=;
        b=K5T1ULKOkrlxR1oChB0EDwQMFVEInWNxio34e/t+fgmbcd4pCF39PgWp5+ltx/2JBs
         5IdHZK5MwAPAOBa8+BlIF9jdUP7yXEC1koTT7Fl1j85Me9CCaBreQ9VOp6f6EvN5OARr
         mYeimCI8OzgyZOdw5rJMpZs0amSloz6dI2d7aGc7ahBsXEpGUziPjXOwtUWd95whyMv6
         pW7hudVioWU/bconLplN+KkWezoStAzJwnRh0ERQQpRoRE1ItTs+IDeUgZb5y8y+gYJi
         F0xHWFG9PuLy//CkZOiQKyrl6rZn4TSa+JI2eWejh+qAagLLrYGiCdCKIaujd0MFDAyl
         uW1Q==
X-Gm-Message-State: AJcUukcmKn1zHkbawxgPZfL+sQfmw4yeUEPQzIMFCZyqdglDoiFo/10x
        ByYGJFvgUkWQ8eyHwiRuqxPx
X-Google-Smtp-Source: ALg8bN4ONaQX3pyCELUDzLLOvIJwuPAy54B+U+smYGOPAQYfDoCNM74kuGFJ+AdrzqSAbmtOV5Mwaw==
X-Received: by 2002:a17:902:30a3:: with SMTP id v32mr32996277plb.26.1548130934796;
        Mon, 21 Jan 2019 20:22:14 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7344:8fd1:3551:e475:9265:ab6d])
        by smtp.gmail.com with ESMTPSA id q199sm25083953pfc.97.2019.01.21.20.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 20:22:14 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.tropschug@ebs-systart.com,
        m.bittner@ebs-systart.com, amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 3/5] dt-bindings: vendor-prefixes: Add EBS-SYSTART GmbH Vendor Prefix
Date:   Tue, 22 Jan 2019 09:51:45 +0530
Message-Id: <20190122042147.5424-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
References: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for EBS-SYSTART GmbH.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 389508584f48..38693105b5c6 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -108,6 +108,7 @@ dongwoon	Dongwoon Anatech
 dptechnics	DPTechnics
 dragino	Dragino Technology Co., Limited
 ea	Embedded Artists AB
+ebs-systart EBS-SYSTART GmbH
 ebv	EBV Elektronik
 eckelmann	Eckelmann AG
 edt	Emerging Display Technologies
-- 
2.17.1

