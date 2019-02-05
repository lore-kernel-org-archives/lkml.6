Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D2FC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95692175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mRTC3J+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbfBES72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:59:28 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42996 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbfBES71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:59:27 -0500
Received: by mail-pl1-f195.google.com with SMTP id s1so1894190plp.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 10:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T6ZkVEchsabZqxtMQeoE3ctJ4zykBlH7lRtatYFb9wo=;
        b=mRTC3J+jKMLMwOF4TMLfYeTfGl7DlhlggCf4bPCgHrsdtxYV+6fS71EeyaDxdaZVd+
         8xGolxtXoz4+IC00roQHBljzgcbHnWxzW1H0Idr7UdSKk1espV/44Wxt6JBxJHkK4RZn
         t7UAe+3KsAn2eSb5gvpYWMgjKuPPNjJkSRvyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T6ZkVEchsabZqxtMQeoE3ctJ4zykBlH7lRtatYFb9wo=;
        b=nWyiyv1RM8phYaAfnGUbl4t9iqXbWdycvygCL8Do939B7pya4HM912s1V4qy230Fbl
         3dNx9aKsS0DCNDflPY+717RP9bM+MlwP/oE/CGtGYJhjGsGRuEs2WYjzec3/XLFKfBqA
         5pIaQuq27lBxbPaIvFzbrLQXpjXSDBtSPL5bcgOsRnnsMkCG5Juv80HSRwLXHD/xW6rO
         SSaDZkNhO3J9m6PQjqY9ddYLD4FGNHFAK++8k8SIoLx8n8bcEZWXsIYzc+hwurTprcg8
         SG9t/b51ANAfRfv5ItkiDRkytWDKR3a9E6mBzddrMk9RXHda+lDUXb0tjZEt0p+pdM/J
         /hjw==
X-Gm-Message-State: AHQUAuZr6AkhyGaozLA1pr1qPIr/dWtAorLYPr1aiASdeBNHXEUn/B+J
        IEhrOXuuOupMHHrzPBrjiFAm9Q==
X-Google-Smtp-Source: AHgI3IbtY8q+L210PGS9rdsM1l9sI59qwK3s7vtou7MZ2oEsN+ImorRrdRougfy6HVaBU7i71/ea6A==
X-Received: by 2002:a17:902:108a:: with SMTP id c10mr6597175pla.131.1549393166546;
        Tue, 05 Feb 2019 10:59:26 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id m3sm6424435pfi.102.2019.02.05.10.59.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Feb 2019 10:59:25 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        liwei <liwei213@huawei.com>, linux-kernel@vger.kernel.org,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 1/8] dt-bindings: ufs: Add #reset-cells for Qualcomm controllers
Date:   Tue,  5 Feb 2019 10:58:55 -0800
Message-Id: <20190205185902.106085-2-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205185902.106085-1-evgreen@chromium.org>
References: <20190205185902.106085-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Qualcomm UFS controllers to expose the PHY reset via a reset
controller.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>

---
Fixing up this aspect of it made me notice that this patch [1]
hasn't landed yet. It really ought to.

[1] https://lore.kernel.org/lkml/20181012213926.253765-1-dianders@chromium.org/T/#u

Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
index 8cf59452c675..e2460b666ae4 100644
--- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
+++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
@@ -47,6 +47,8 @@ Optional properties:
 -lanes-per-direction	: number of lanes available per direction - either 1 or 2.
 			  Note that it is assume same number of lanes is used both
 			  directions at once. If not specified, default is 2 lanes per direction.
+- #reset-cells		: Must be <1> for Qualcomm UFS controllers that expose
+			  PHY reset from the UFS controller.
 - resets            : reset node register
 - reset-names       : describe reset node register, the "rst" corresponds to reset the whole UFS IP.
 
@@ -76,4 +78,5 @@ Example:
 		reset-names = "rst";
 		phys = <&ufsphy1>;
 		phy-names = "ufsphy";
+		#reset-cells = <1>;
 	};
-- 
2.20.1

