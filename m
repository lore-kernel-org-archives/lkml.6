Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58071C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284002184D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kUkIoles"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfA2Rze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:55:34 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48951 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbfA2Rzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:55:31 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190129175529euoutp02b97b8586a503883f655b036659743290~_Y1Ly6gFs2978229782euoutp02q
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 17:55:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190129175529euoutp02b97b8586a503883f655b036659743290~_Y1Ly6gFs2978229782euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548784529;
        bh=4xMoC/JxPClX+CtWb5Gm6QZEQL5oSmpJwmoKVZyNZLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kUkIolesWz0PDxeOACkYM5+/G8xCKbxa1sw5hep+0Zi8+LREdMSRsuXA6QYjo5JwY
         1BYpxQ4aKYXO8VZzBIsvLAufiVIeixe51TPeTdvkf/0PwOktoRbkh4YLtnZcU9M79E
         kkMhunc6yy1AztBGXS+lvqTNORVu7fIJBON6k6lg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190129175529eucas1p18db9536204fb3f4c2f8a734c0e13dfe7~_Y1LQv-l30145001450eucas1p1J;
        Tue, 29 Jan 2019 17:55:29 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 75.D0.04294.093905C5; Tue, 29
        Jan 2019 17:55:28 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190129175528eucas1p2363cdde199774e7180177f1d8bf039bc~_Y1Kie07A1668516685eucas1p2J;
        Tue, 29 Jan 2019 17:55:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190129175528eusmtrp274d14e54c0d90b3e6c740f2e2d7c9b20~_Y1KTmf7r0424104241eusmtrp2f;
        Tue, 29 Jan 2019 17:55:28 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-3b-5c509390640d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4B.09.04284.093905C5; Tue, 29
        Jan 2019 17:55:28 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190129175527eusmtip142fc135520661bce076a8d2a9ef561f4~_Y1Jhwir32139021390eusmtip1I;
        Tue, 29 Jan 2019 17:55:27 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 8/8] ARM: exynos_defconfig: enable DMC driver
Date:   Tue, 29 Jan 2019 18:55:14 +0100
Message-Id: <1548784514-26649-9-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548784514-26649-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsWy7djP87oTJgfEGLxdbG6xccZ6VovpTy6z
        WFz/8pzVYv6Rc6wWp14tY7bof/ya2eL8+Q3sFmeb3rBb3GqQsdj0+BqrxeVdc9gsPvceYbSY
        cX4fk8WhqXsZLdYeuctucbtxBZvF4TftrA6CHpevXWT2mN1wkcVj06pONo/NS+o9Dr7bw+TR
        t2UVo8fnTXIB7FFcNimpOZllqUX6dglcGT8/bWIpOMJR8XLpFqYGxqPsXYycHBICJhIXzq4A
        srk4hARWMEo8e/8CyvnCKPGiewoLhPOZUWLqgYVsMC3dP85DJZYzSvStbWKBa7nU1cHYxcjB
        wSagJ7FjVSFIg4hAtcSd6/uZQWqYBdqYJdZ+O8kEkhAWcJD40tvKClLPIqAqcbeDBSTMK+Al
        cffXVmaIZXISN891gtmcAt4SHY/vMILMkRA4xC7x/+dcqItcJKZ9boB6SFji1fEtULaMxP+d
        85kg7GKJsx2roOprJNpP7oCqsZY4fPwi2A3MApoS63fpQ4QdJfq+vmQGCUsI8EnceCsIEmYG
        Midtmw4V5pXoaBOCqNaQ2NJzAWqRmMTyNdOghntI/FxwkhkSOvMYJQ41TmSfwCg/C2HZAkbG
        VYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIFp6fS/4192MO76k3SIUYCDUYmHlyE4IEaI
        NbGsuDL3EKMEB7OSCK/hb/8YId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzVDA+ihQTSE0tSs1NT
        C1KLYLJMHJxSDYxhk28vvfLJzcm/8rSs8oED9nUbxRqEC1SnBUlUz3HrP+7M239WkPfZ10J5
        9xnt/+XuX3ValCoecSSCx7a79syC/hm/Lf3FBWy/epz4LrLm5N09kRv6VYJPvkpqNDb9+NEs
        09n7VZe7mvXihCcsVX+f7mh2Xs5VyMP4jz8wctuXRolQCeWzl5VYijMSDbWYi4oTAbLS4xhH
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t/xu7oTJgfEGCy8xGKxccZ6VovpTy6z
        WFz/8pzVYv6Rc6wWp14tY7bof/ya2eL8+Q3sFmeb3rBb3GqQsdj0+BqrxeVdc9gsPvceYbSY
        cX4fk8WhqXsZLdYeuctucbtxBZvF4TftrA6CHpevXWT2mN1wkcVj06pONo/NS+o9Dr7bw+TR
        t2UVo8fnTXIB7FF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZll
        qUX6dgl6GT8/bWIpOMJR8XLpFqYGxqPsXYycHBICJhLdP86zdDFycQgJLGWUmLTsFTNEQkxi
        0r7tUEXCEn+udbFBFH1ilGjfcAuog4ODTUBPYseqQpAaEYF6if43l8BqmAWmMEssnn+HFSQh
        LOAg8aW3lRWknkVAVeJuBwtImFfAS+Lur61Qu+Qkbp7rBLM5BbwlOh7fYQSxhYBqvr3+wTaB
        kW8BI8MqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwDjZduzn5h2MlzYGH2IU4GBU4uFlCA6I
        EWJNLCuuzD3EKMHBrCTCa/jbP0aINyWxsiq1KD++qDQntfgQoynQTROZpUST84ExnFcSb2hq
        aG5haWhubG5sZqEkznveoDJKSCA9sSQ1OzW1ILUIpo+Jg1OqgXHh9QPmVUJL1s9geskZ9/za
        gs0XmhoLPT/OjS8UOSimsIn/gHG17eacX0nuS8WELM//lusUnPHEqH9FG4Nkb6V53a+Ksx/e
        BIXl7ovifOGz718s+xtZj79HJTMCSn5xemT+sLS7YmW/RWK39Y516xo+JWaIaGi9e7POlaV7
        sa3/Erb0FJPwECWW4oxEQy3mouJEAM9MQiCpAgAA
X-CMS-MailID: 20190129175528eucas1p2363cdde199774e7180177f1d8bf039bc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190129175528eucas1p2363cdde199774e7180177f1d8bf039bc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190129175528eucas1p2363cdde199774e7180177f1d8bf039bc
References: <1548784514-26649-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190129175528eucas1p2363cdde199774e7180177f1d8bf039bc@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable driver for Dynamic Memory Controller dynamic frequency and
voltage scaling in Exynos5422 SoCs.

CC: Russell King <linux@armlinux.org.uk>
CC: Kukjin Kim <kgene@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>
CC: Marek Szyprowski <m.szyprowski@samsung.com>
CC: Guenter Roeck <groeck@chromium.org>
CC: Benson Leung <bleung@chromium.org>
CC: linux-arm-kernel@lists.infradead.org
CC: linux-samsung-soc@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index d635edf..b5dddcc 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -291,6 +291,7 @@ CONFIG_DEVFREQ_GOV_PERFORMANCE=y
 CONFIG_DEVFREQ_GOV_POWERSAVE=y
 CONFIG_DEVFREQ_GOV_USERSPACE=y
 CONFIG_ARM_EXYNOS_BUS_DEVFREQ=y
+CONFIG_ARM_EXYNOS5422_DMC_DEVFREQ=y
 CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=y
 CONFIG_EXYNOS_IOMMU=y
 CONFIG_EXTCON=y
-- 
2.7.4

