Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B378C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C8E21726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SP66GkH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbfBAQru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:47:50 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42671 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730937AbfBAQrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:47:24 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190201164722euoutp013181e21326f4de57b7f8a22048fc9feb~-S1kbQi_C1970719707euoutp010
        for <linux-kernel@vger.kernel.org>; Fri,  1 Feb 2019 16:47:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190201164722euoutp013181e21326f4de57b7f8a22048fc9feb~-S1kbQi_C1970719707euoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549039642;
        bh=6WaOsRvIk1Hi6aIutH0Yv8k8wf67MlZU0e+KRhyh7zM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SP66GkH9xor8Pj+nJ6TqykSSO/C0o7dCTg9OynebWlhYQIfT5S4GYn1k/BkdaCFrn
         ACJBwwpGtEfbBiYCuPGcAKLmU8VN2uwsqWHP4HR06eeoBJRauA3eSr2/ziwpnIvWcp
         2yudxv5WyuiRrDQFqR+1L++A5zrp/HF7oVjolBaE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190201164721eucas1p2103f4f3e939fdc445d44839b382bd3ec~-S1jWxWAq1212212122eucas1p2Y;
        Fri,  1 Feb 2019 16:47:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6D.EE.04806.918745C5; Fri,  1
        Feb 2019 16:47:21 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190201164720eucas1p1ae770f7981fa09016b69ca7265e820c7~-S1inpln50426104261eucas1p1S;
        Fri,  1 Feb 2019 16:47:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190201164720eusmtrp19690d34853c033cd842a3d6dd1246db4~-S1iYyjmd3167231672eusmtrp1X;
        Fri,  1 Feb 2019 16:47:20 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-1c-5c547819d4a3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F2.30.04128.818745C5; Fri,  1
        Feb 2019 16:47:20 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190201164719eusmtip273cd91a702807d148bbcfd8976280810~-S1hsDITG0105401054eusmtip2c;
        Fri,  1 Feb 2019 16:47:19 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 5/8] dt-bindings: devfreq: add Exynos5422 DMC device
 description
Date:   Fri,  1 Feb 2019 17:46:49 +0100
Message-Id: <1549039612-28905-6-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djPc7qSFSExBrMny1psnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLHY9Pgaq8XlXXPYLD73HmG0mHF+H5PF2iN32S2W
        Xr/IZHG7cQWbReveI+wWh9+0szoIeKyZt4bRY9OqTjaPzUvqPQ6+28Pk0bdlFaPH501yAWxR
        XDYpqTmZZalF+nYJXBnP7xxhLdimVHGj6zhjA+MD6S5GTg4JAROJnh0X2LsYuTiEBFYwSmz+
        MgPK+cIo8efudTYI5zOjxITDZ5hhWk5P2MYMkVjOKHGz+xELXMvNE8cYuxg5ONgE9CR2rCoE
        aRARqJa4c30/WAOzwB0mib0zl7KAJIQFQiUebO8Gs1kEVCXa30xkB+nlFfCSeHdeFmKZnMTN
        c51gizkFvCU6Hm9nBJkjIbCNXeLjrT9MEEUuEi+mfIC6Tlji1fEt7BC2jMTpyT0sEHaxxNmO
        VWwQdo1E+8kdUDXWEoePX2QF2cssoCmxfpc+RNhRYtezTrBXJAT4JG68FQQJMwOZk7ZNZ4YI
        80p0tAlBVGtIbOm5AHWMmMTyNdOghntIdF/sZYWEzjxGiYlPnzJPYJSfhbBsASPjKkbx1NLi
        3PTUYuO81HK94sTc4tK8dL3k/NxNjMAUdPrf8a87GPf9STrEKMDBqMTDu+FXUIwQa2JZcWXu
        IUYJDmYlEV6nrJAYId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzVDA+ihQTSE0tSs1NTC1KLYLJM
        HJxSDYwF27/NPrvt1JMbVzWNrhZnNB2Lmnp3qZttmvayb4m2rdL1OfNXq7QtCd100sbR219a
        yLyrVThTVeNBa/8RvXUs9m+iO3YWSTivjj7KmfMvroOZ78uWxb9LLgolNku9W8S9vuq2e8ay
        n+1r2fPvb5DZpJvq+bjwyGKhu/mXWu6ZJZvMX7bLa7MSS3FGoqEWc1FxIgCATCaiPQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42I5/e/4PV2JipAYg4PftCw2zljPanH9y3NW
        i/lHzrFa9D9+zWxx/vwGdouzTW/YLW41yFhsenyN1eLyrjlsFp97jzBazDi/j8li7ZG77BZL
        r19ksrjduILNonXvEXaLw2/aWR0EPNbMW8PosWlVJ5vH5iX1Hgff7WHy6NuyitHj8ya5ALYo
        PZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYznd46w
        FmxTqrjRdZyxgfGBdBcjJ4eEgInE6QnbmLsYuTiEBJYySixe/5odIiEmMWnfdihbWOLPtS42
        iKJPjBKP+6cDdXBwsAnoSexYVQhSIyJQL9H/5hIbiM0s8IpJouG9BogtLBAs8fPzBlYQm0VA
        VaL9zUR2kFZeAS+Jd+dlIcbLSdw818kMYnMKeEt0PN7OCGILAZWs+neAeQIj3wJGhlWMIqml
        xbnpucVGesWJucWleel6yfm5mxiBEbHt2M8tOxi73gUfYhTgYFTi4d3wKyhGiDWxrLgy9xCj
        BAezkgivU1ZIjBBvSmJlVWpRfnxRaU5q8SFGU6CbJjJLiSbnA6M1ryTe0NTQ3MLS0NzY3NjM
        Qkmc97xBZZSQQHpiSWp2ampBahFMHxMHp1QDo9HaxrvH7SWZXoVt1dfelpSTHmw4wfmVfIni
        3fSCXuuuoilBru9vX2qe/oO9kfPe17+yBQ5xJj1Xc5Iz/1hwp7AfnLhT9cu0/n0sny4cn5jj
        Ynfj+QnvkkeiqfOK76Z9ZNg0T1m5fDO3nEix6ZuvDZ1Ti6WnyliJhxcECQhrXb60Zrlp0cYJ
        SizFGYmGWsxFxYkAdUUcK54CAAA=
X-CMS-MailID: 20190201164720eucas1p1ae770f7981fa09016b69ca7265e820c7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190201164720eucas1p1ae770f7981fa09016b69ca7265e820c7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190201164720eucas1p1ae770f7981fa09016b69ca7265e820c7
References: <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190201164720eucas1p1ae770f7981fa09016b69ca7265e820c7@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds description for DT binding for a new Exynos5422 Dynamic
Memory Controller device.
It also contains needed MAINTAINERS file update.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 .../devicetree/bindings/devfreq/exynos5422-dmc.txt | 106 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt

diff --git a/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt b/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
new file mode 100644
index 0000000..229efba
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
@@ -0,0 +1,106 @@
+* Exynos5422 frequency and voltage scaling for Dynamic Memory Controller device
+
+The Samsung Exynos5422 SoC has DMC (Dynamic Memory Controller) to which the DRAM
+memory chips are connected. The driver is to monitor the controller in runtime
+and switch frequency and voltage. To monitor the usage of the controller in
+runtime, the driver uses the PPMU (Platform Performance Monitoring Unit), which
+is able to measure the current load of the memory.
+When 'userspace' governor is used for the driver, an application is able to
+switch the DMC frequency.
+
+Required properties for DMC device for Exynos5422:
+- compatible: Should be "samsung,exynos5422-bus".
+- clock-names : the name of clock used by the bus, "bus".
+- clocks : phandles for clock specified in "clock-names" property.
+- devfreq-events : phandles for PPMU devices connected to this DMC.
+
+The example definition of a DMC and PPMU devices declared in DT is shown below:
+
+	ppmu_dmc0_0: ppmu@10d00000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x10d00000 0x2000>;
+		clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
+		clock-names = "ppmu";
+		status = "okay";
+		events {
+			ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
+				event-name = "ppmu-event3-dmc0_0";
+			};
+		};
+	};
+
+
+	ppmu_dmc0_1: ppmu@10d10000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x10d10000 0x2000>;
+		clocks = <&clock CLK_PCLK_PPMU_DREX0_1>;
+		clock-names = "ppmu";
+		status = "okay";
+		events {
+			ppmu_event_dmc0_1: ppmu-event3-dmc0_1 {
+				event-name = "ppmu-event3-dmc0_1";
+			};
+		};
+	};
+
+	ppmu_dmc1_0: ppmu@10d10000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x10d60000 0x2000>;
+		clocks = <&clock CLK_PCLK_PPMU_DREX1_0>;
+		clock-names = "ppmu";
+		status = "okay";
+		events {
+			ppmu_event_dmc1_0: ppmu-event3-dmc1_0 {
+				event-name = "ppmu-event3-dmc1_0";
+			};
+		};
+	};
+
+	ppmu_dmc1_1: ppmu@10d70000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x10d70000 0x2000>;
+		clocks = <&clock CLK_PCLK_PPMU_DREX1_1>;
+		clock-names = "ppmu";
+		status = "okay";
+		events {
+			ppmu_event_dmc1_1: ppmu-event3-dmc1_1 {
+				event-name = "ppmu-event3-dmc1_1";
+			};
+		};
+	};
+
+	dmc: memory-controller@10c20000 {
+		compatible = "samsung,exynos5422-dmc";
+		reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
+			<0x10030000 0x1000>, <0x10000000 0x1000>;
+		clocks = 	<&clock CLK_FOUT_SPLL>,
+				<&clock CLK_MOUT_SCLK_SPLL>,
+				<&clock CLK_FF_DOUT_SPLL2>,
+				<&clock CLK_FOUT_BPLL>,
+				<&clock CLK_MOUT_BPLL>,
+				<&clock CLK_SCLK_BPLL>,
+				<&clock CLK_MOUT_MX_MSPLL_CCORE>,
+				<&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
+				<&clock CLK_MOUT_MCLK_CDREX>,
+				<&clock CLK_DOUT_CLK2X_PHY0>,
+				<&clock CLK_CLKM_PHY0>,
+				<&clock CLK_CLKM_PHY1>;
+		clock-names =	"fout_spll",
+				"mout_sclk_spll",
+				"ff_dout_spll2",
+				"fout_bpll",
+				"mout_bpll",
+				"sclk_bpll",
+				"mout_mx_mspll_ccore",
+				"mout_mx_mspll_ccore_phy",
+				"mout_mclk_cdrex",
+				"dout_clk2x_phy0",
+				"clkm_phy0",
+				"clkm_phy1";
+
+		status = "okay";
+		devfreq-events = <&ppmu_dmc0_0>, <&ppmu_dmc0_1>,
+				<&ppmu_dmc1_0>, <&ppmu_dmc1_1>;
+	};
+
+
diff --git a/MAINTAINERS b/MAINTAINERS
index e81dfbf..ab0d8a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3316,6 +3316,7 @@ L:	linux-pm@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
 F:	drivers/devfreq/exynos5422-dmc.c
+F:	Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
 
 BUSLOGIC SCSI DRIVER
 M:	Khalid Aziz <khalid@gonehiking.org>
-- 
2.7.4

