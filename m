Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D3CC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F9320659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WxwfJl/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfANKVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:21:13 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36214 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfANKVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:21:12 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so9957005plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 02:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4FzCXv3Bf1FI6YrFoBC3pkmqHbI7ffk1SWvM3999Qt4=;
        b=WxwfJl/uccOQmw76DfU1u+w2PDCfxpV7DsL30KnhWR1NMPLXpt951gb8Pm1e96KbaQ
         mI7004CkZIR1B56RoOG16HE5y4R5SbuDN+maYVwyQYKcIlhexp76Wd30ac0kCR/SWHF4
         DpzExwCz2qQCkLIZRV3rwIkWr9Lfe/nJlgSXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4FzCXv3Bf1FI6YrFoBC3pkmqHbI7ffk1SWvM3999Qt4=;
        b=VscAlWHUtoU9yvjJNjJlO8OL6dHHeYSiLVHklklHmG0xzoDvfNBIKdW2MNkBJmcIRF
         5qDB51siZSA2sbVebJRz+AV7MddLW960/fE1w5xQIxhHsh9YE6yss7EZGYA4XXXKus3y
         /WAWg7xacY6kWsUUfvUiSVtbdkwh/m/LXmJIaYftTArf9z9VF2PJBpZNg6ZLN0g66OH/
         f+5tp9GFrn0xp0HAzwAsxeLg8fFfvn3z3DIvmLZlOrAagEnONP64olQE0Irg3XpAedRd
         wvM1omChvEaWYgvOnXcG8IHue0latdO/adrpcssWZE5vbGA5Dsv8iVriZU8xb6/W5yBk
         HAHw==
X-Gm-Message-State: AJcUukfMvQbYgIydjuyLB3B7KT1BFpKty/TA3qW62cE/q6e2YGZvaNb/
        0GbAqeT/lXuGaXvfPSj3ykc5
X-Google-Smtp-Source: ALg8bN5QsLN2ROqBaEhHGmTeaV77+ILHwBvaBhpA5EYic0Ywo1PaKzZ/HT6LqjzKyhhXKtm2xr0EJw==
X-Received: by 2002:a17:902:201:: with SMTP id 1mr24475661plc.62.1547461271533;
        Mon, 14 Jan 2019 02:21:11 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6306:f12b:7d9b:d1a4:6536:aa21])
        by smtp.gmail.com with ESMTPSA id 15sm36429pfr.55.2019.01.14.02.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 02:21:10 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.tropschug@ebs-systart.com,
        m.bittner@ebs-systart.com, amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add EBS-SYSTART GmbH Vendor Prefix
Date:   Mon, 14 Jan 2019 15:50:51 +0530
Message-Id: <20190114102053.16013-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114102053.16013-1-manivannan.sadhasivam@linaro.org>
References: <20190114102053.16013-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for EBS-SYSTART GmbH.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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

