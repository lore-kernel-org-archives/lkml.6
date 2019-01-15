Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75CDC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8940720656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UOeAT49E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfAODeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 22:34:36 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36830 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbfAODee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 22:34:34 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so624530plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 19:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EmFI5a8lPjCMuBHux9Ylzns+RwprhO23lrIeWOAs4Cw=;
        b=UOeAT49EfP+Rsq2Ml3mAp3EkU3As23NLr50Mv1XxBlBhjOFda++dKfj+X6XIVABHWj
         lLBLF0nvAkDxOLpI5/Mo7wrfUtZKdxBDeZJy1gYseZ0sxsVbI5LQ/zjjKFP+ax/oV7+8
         XOnbUB1TaXdST+UPukWwWxdS9Qen/pI+/WUjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EmFI5a8lPjCMuBHux9Ylzns+RwprhO23lrIeWOAs4Cw=;
        b=OLOIr+bU27tSoTr0nRErZlCkUUrMsF3dydv7Ofuk6y1vl9ucrHrPBLTg+PLkAPBFA3
         wWbThMpM3tRnp8Ks7eQ2C+OonY+G+ISmp3rS01zwX6gA2/oApGK8LuEREyO57cyWQ4W6
         hE+vT6e9KwwOXECEInTWXH6oVIOhGzqGfJqptBHZZZ5B1Tpt12bulmU4Hrp6Vl8w/tru
         tK3nVZb/RAeltYAddtL3AX/wLiQmcvgOr/wEtxspetIQZKQ7KvoioiVD0VrtlnNXhvZu
         noR3iE9R/OVDysg2JBnmvKrTrncQoK4FUXbEC2BzhGpHBiTT9piWBXNyjekhtUVrPSaT
         +CJA==
X-Gm-Message-State: AJcUukcsqOJgcpVSq4zzWqBb5fAltuaM1t5+wK9JyEkUMoI0ee3NCHv9
        YlKlc8izCLWK3qfVIn1vZBhd
X-Google-Smtp-Source: ALg8bN4ZLK6UxLmvpUeFAZdUFyqbktfD1GNFKeDN9LOXQgJVnpUTwZ/PHbF/nNpnEFRcZuPAp+TKaQ==
X-Received: by 2002:a17:902:3143:: with SMTP id w61mr1927388plb.253.1547523273698;
        Mon, 14 Jan 2019 19:34:33 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6084:4813:7cd6:42d1:f14c:3e90])
        by smtp.gmail.com with ESMTPSA id s9sm2137023pgl.88.2019.01.14.19.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 19:34:33 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, afaerber@suse.de,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 6/6] MAINTAINERS: Add linux-actions mailing list for Actions Semi
Date:   Tue, 15 Jan 2019 09:03:40 +0530
Message-Id: <20190115033340.25016-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115033340.25016-1-manivannan.sadhasivam@linaro.org>
References: <20190115033340.25016-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the linux-actions mailing list for Actions Semi SoC architecture.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d37f8a4743c..f30e25c8e4a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1240,6 +1240,7 @@ ARM/ACTIONS SEMI ARCHITECTURE
 M:	Andreas Färber <afaerber@suse.de>
 R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-actions@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 N:	owl
 F:	arch/arm/mach-actions/
-- 
2.17.1

