Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeEDN6K (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:58:10 -0400
Received: from mail-eopbgr20090.outbound.protection.outlook.com ([40.107.2.90]:48365
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751664AbeEDNxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:53:21 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 15/26] drm/bridge: synopsys: provide an owner .odev device for the bridges
Date: Fri,  4 May 2018 15:52:01 +0200
Message-Id: <20180504135212.26977-16-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180504135212.26977-1-peda@axentia.se>
References: <20180504135212.26977-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR0202CA0039.eurprd02.prod.outlook.com
 (2603:10a6:4:a5::25) To AM4PR0202MB2769.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:6x2MVH8RpvidIrkQc3fVbkT+j3RKlJdTaefs1+l4jK4wMArcttsfVn6SUAl8+cfsrGpfA/zfrB5TlHArAXwipgRWb10ZKmYiFxd3CdCkM+AG8imBX8hcMWk31sTU+jLpz0/iIRczfYOzg9QvWEtpStR7VcOLzFuvnPJ0vQD7tb2BUhm9BfvKq1/bAf868NtzKLZ47Aft9+QLAs2sjGQ8GMmALgg2UMw9tyrNXPFn7QusEPVL1+UiOsJm6bhI8frp;25:8cEtFANXTUgCfYwVK/ujbVAJOPUuEAYQde+JkUnRLZx4tJQuO4v4QvXGhkVrELyk32qQem7PFO1xdbnO5YvsDMCw8sX7wWXYoZzr7KA3tp0wSi8t1cDl6rH9rJ3GaW60h6El/7aJWZFTO/AtCouEbQ+x3G+03pNLAUFLIKoo22FsXdBTQP4wFihM4YIiOvrjNsn/XXjXitxuXSMeYhbfUpJ8LXXjg1HaU0yZuIHjMP4ZXgXP/JoSGdv/aDCxZUuA3SO43C5/W1D9SKDBUvyGn8rJzcixTWpIeudEiJ0sqzbzAgzSO16EekuRJw2x++8iunxKG3TZp/lOkmqeI57HMA==;31:nCv4R1qee/mzp3jmtfMex/vDL/IwpEgh0w8G5b0dEKQqy/f01InMOf57Rgsdyq+G8SCNZ22wLsqHwbCZBrvb/SgW6KRO0PTMRZa5mwzNFVOeJWZ5dG1HNUpVYKYcPFkowiJREmKiV7JZMpYGDO24C+40TB5YrGTk4Ce586mOCFQ746mpGMv+yAEnwCHGL97jZH4GlZafNcAZT0pyEwRWUt64CZF3xrhk9eRKPZF23e4=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2769E5FEA5DB8A1F596E2F52BC860@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:i9z26QX5Rt8krGAr/aLBcYdPQekBk4PKcogZmlrfnLLczig25zYJipF6A5E7CNvt5C4GUl98ae+SkSGXTfORkG4t8q+lYeLe/RMmOtGEsjOncYBvpm+YKWHeByPpmvKuwglafM93PhFDED0HtEUo0LkwwkN05f6Vpwb1SwuTS09EZ6BZHXEggKUBZw5mBfw1B26C/tqS0xalB855zg5nNlZO8KMZYan1PWyJBPEl3NvGfF2u6N9zJftMco2Rb3rHAmJ11xTneVtew6ztMS7Scw==
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(366004)(39840400004)(39380400002)(376002)(346002)(396003)(199004)(189003)(52116002)(386003)(50466002)(305945005)(6506007)(54906003)(74482002)(316002)(68736007)(5660300001)(16586007)(6666003)(50226002)(7736002)(8936002)(81166006)(8676002)(97736004)(6916009)(1076002)(48376002)(2906002)(2351001)(2361001)(16526019)(81156014)(76176011)(4326008)(86362001)(6486002)(6116002)(3846002)(53936002)(106356001)(478600001)(11346002)(486006)(446003)(36756003)(25786009)(51416003)(476003)(956004)(105586002)(2616005)(66066001)(6512007)(186003)(26005)(47776003)(142923001)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:4rOFzS7MShAmiKhgqj05zhqzPdV2FcaU1kUCItz?=
 =?us-ascii?Q?4zJDITlKKE8d11fub9QdSPzmlx8r0uhb8tcF8pwNF2dkpFNvXj4J20K9UGdP?=
 =?us-ascii?Q?AJ3bVESFDk1H0QqINpsgWElEIuAwkPM50hbw49tSLBATV0qhGfy9L8hXZZWu?=
 =?us-ascii?Q?oVDzutwUMwIXoFeRnG6bsSIyPW6PP7S4Hle7Dgj9dMjmHQk02iwFEFotC60B?=
 =?us-ascii?Q?yMQhcdnJHo8IKRUSltuZKSwklORLelhx29E3o7bs1QJtNSGO+EOYPz/diPeu?=
 =?us-ascii?Q?P508qeA7u48nq1NLbqytSmsky63hfwSPmUeRchtYafY2rK5HxjccrqRZjajW?=
 =?us-ascii?Q?kzsRE8C3az/IQdMALWAtG5nWjtXUNWRPMsIjnlU7FfiVWPYEo1Zas8oUpcoN?=
 =?us-ascii?Q?B0YW1ZJuKLKSORKiO7ZY+8QHjvk2Zaq81Wzm7nV/BPAsayq90VtBFubul56g?=
 =?us-ascii?Q?gTh7y+O9gQ/Oy/fYgK3sHY4KW2RLrREiTV6xqmGt9dFS5WmW5RWkMjOz8i/v?=
 =?us-ascii?Q?+HG7KYH2odk7RmWkEqLmYWyaIlVgQQVk1giwEJnYc9vrFmTYhAvW6XWyZSz0?=
 =?us-ascii?Q?8BsVDGJ84Vc/SdPwXcq6RDLZex1hpCjZMjhQ4RW6w6iKbxhYe7DJLwOSOLS/?=
 =?us-ascii?Q?ZIXk3cQOurKkX1edN2GYgvKDoaxZ7e0lc5bkUWK4lDDB4pKN9I0BcJP19GBc?=
 =?us-ascii?Q?XTz4oi6bXBcK/GWbh/dP08mkq6itJTiylYHA8mkl6/RgzW82cbQw7Cs2//B4?=
 =?us-ascii?Q?/fxvpTTfGx5vFx8iblLZlkSUa4evhAD0azy2TEIM76TS6wWjAtmMrbtG5aBH?=
 =?us-ascii?Q?dnCNOm1OgvVaWbztFwnRjA8piRhOHGHbWUvyySUlP7+ztUIHN4wdlz1TWGxs?=
 =?us-ascii?Q?KAoVySGMmhNhKuTd12sHxsgKk3GSGsft1pYtJrWKOKZq0EdOy5fIowN4dCvJ?=
 =?us-ascii?Q?9E+GxuvBkmt3qoZs1UDQ0839BzfY2l8G7679wEuEjOxcexgj2SPb+DqDwXRK?=
 =?us-ascii?Q?j74eIJ9fwjkrOBvQiqYsacGkDxscyLoDjCNPpxjBgUZW4bNH9JlqqVirLmjm?=
 =?us-ascii?Q?PRhhyishMgX2jRHUr5Vy80AGqAoJBtzzhS52I1e4oGosNxClLnZ0bTp32zYZ?=
 =?us-ascii?Q?YvQaUVXO54N4Gh81RBA9UlzOZhqI3zLg63F2IMkGHteNDzE8hZQKF3JACKsy?=
 =?us-ascii?Q?8HzqHalYLJbwNf4IZaHNGC/OK34R3nA+loRhYgeOHu6Efup+SvkDQ0ahkQ+p?=
 =?us-ascii?Q?sauiG2QZ79Cm2bXjUsM6BVJCT8458toQ13mzTtyfPycdq+YQgVWVMhMAUzmv?=
 =?us-ascii?Q?yZdghz9SpYT7ESjog3jNu8TbQXtcht2xp4iLwXWgPW63ESVL2cKezhjJi0iE?=
 =?us-ascii?Q?QDsANU51JTlGDMoDEg0vIKcGxnG8c+fKW9afzELzD+8wdfj5bsZTjbbwFFLj?=
 =?us-ascii?Q?ndT0Iz+81Aw=3D=3D?=
X-Microsoft-Antispam-Message-Info: Ik6tvGE4Uw19la5IOws4JUOZm4+Ew8uCEtTi76YD0EiDzjYcQrDqoOJI7j3A6lI3FZVSVpvKt5bkGrCLOfG1t7Q1iKZ1dP9T06V5a/c2bEb+E3u7hQ3vPZdH7sgjPkNlbMKwvJowcZNlxOD9zbpwVmeEZNyssSjNIBUb4Cz1Rn378KkhCifJLnWdTs46nbZi
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:ikqqN7T9B8uOPPCzth17DyfuHnvxd3uOkieC7DlQqWJOlp0SbBzZxxWR0AqjJQ6hquWEluh/lWL3CeIWeRxYhzd9AI4Gbc3VA66ZeTjo8vYKrYP5yoCRJy4lFmB2pHUJeCEpCR8zVwecPbz2+xhho3Yjw0VgG/9wkrhmuTKmisDk67zTL8CnctoRV+luzryJUIby/LBAIe1l6jTqe7qCf+9x4Sfu08DsC1PJF8RxWUDqn98gO+0ytJinRQn6dSMf57XXsNXf+8EZ3Lk+xwb5D1W/lt3IIRqvbr4Bufcq/RbCE2iS17DMZXhwF56tvKONeoxtDi7tSGdTWCrTVHOExWn83TLMc5/r6dqGgxu7Ion6vbdo3OcXIQriYcBSkBslbrPKYEpS48roSZ57ntEMpommZBNsKRfYmpCCzGnWEzvCQAOBsQ+sB/D2+4bXx7g7QAX29i7vFO0hQ8D0OBTO1g==;5:TUHAke03XSd7rvEvxj8IfABJt79uYP3axZhkPsZXpBlsCylt4Ks7H+BEby8a45rNz03FPkW5Vx7vWfr6H792aAPWLd0TTB9xDQpw9UYk0V1Vff0x7+LI0MjY2QTrzX4G58Kw1u9dkxDx6Au7wrgbtWFIXS1tAJR/WrGfbi2Yqeg=;24:EJRFSsAA75AsQZQJ8f9ShITFPa1jtRjHpx8VzX5zweQFZBr+agszA0U4YiN3OO2XoCyhWnNWDxIYXtrFsqZql8sjQ7axT6n8fYC9ZZTQfCY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:NBdu6vILQV9cqhJYsxfDSwEC9L6VNqKCClKwImvOpH+zrN1uLPCqj3y0cvyoWR59be2bYPU0DY/vm24Xqo7aXiOy1eo5YnCcwkrOWU1GaG3VlRaxewn+Wj2bc8VWFMOGnC1NM6cJfSzsp47euHtmkf1mmH4tCjaKNYwoz5PwAibQMcT8E7eRooEOpR/fgSUZBBM/YGk2oq0Tx2rAwOQeFvEc4RSWcRpmNHFxQT3Z19N1LMdZUthMz3HyNhlYwDjw
X-MS-Office365-Filtering-Correlation-Id: 347cce99-a839-4f35-c4be-08d5b1c664ab
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 13:53:18.6837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 347cce99-a839-4f35-c4be-08d5b1c664ab
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It gets rid of two #ifdefs and the .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     | 4 +---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index ec8d0006ef7c..e3956a7e827c 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2471,11 +2471,9 @@ __dw_hdmi_probe(struct platform_device *pdev,
 			hdmi->ddc = NULL;
 	}
 
+	hdmi->bridge.odev = dev;
 	hdmi->bridge.driver_private = hdmi;
 	hdmi->bridge.funcs = &dw_hdmi_bridge_funcs;
-#ifdef CONFIG_OF
-	hdmi->bridge.of_node = pdev->dev.of_node;
-#endif
 
 	dw_hdmi_setup_i2c(hdmi);
 	if (hdmi->phy.ops->setup_hpd)
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index fd7999642cf8..7c8d05f7cecd 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -930,11 +930,9 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
 		return ERR_PTR(ret);
 	}
 
+	dsi->bridge.odev = dev;
 	dsi->bridge.driver_private = dsi;
 	dsi->bridge.funcs = &dw_mipi_dsi_bridge_funcs;
-#ifdef CONFIG_OF
-	dsi->bridge.of_node = pdev->dev.of_node;
-#endif
 
 	return dsi;
 }
-- 
2.11.0
