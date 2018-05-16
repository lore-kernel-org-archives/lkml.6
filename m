Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753299AbeEPKQG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:16:06 -0400
Received: from mail-he1eur01on0104.outbound.protection.outlook.com ([104.47.0.104]:43541
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752820AbeEPKP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:15:59 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 09/26] drm/bridge: nxp-ptn3460: provide an owner .odev device
Date: Wed, 16 May 2018 12:14:53 +0200
Message-Id: <20180516101510.13215-10-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180516101510.13215-1-peda@axentia.se>
References: <20180516101510.13215-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::26) To AM4PR0202MB2772.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:L1bJY0LwTv2Rm+CovACDb8uCidCfLlKJcQnf+/R5kWgri+qIK3tJQjbzzaLvgh5wl52vq88xd7v4shiHYXXBe6QRtSBW1MyaypUI2HmoY4OV39+nH+AHYbWpnbicNkJrIVgS6lhuyUgf7+XLh9MA1pVA/fDfS1PCuLm2DSgiG51i/R+iQa4lMH+TaT3BDOwj7Eif83HwRzQKiJU7K/m6cSu52Sx39eOfcTuluXyQ0oX9OzAjmy4v4UC62uNkcqP7;25:swrSxtuHVBRB3O01BUb4ZPringV6TfEZ51bpbRdtX8uckCvC08EAmFJFQvDgMucvfoE7rXrh8H0vSMv5KgP5YDDhi7ngQsjqwv0i6OcfJxZ0mfvizhFkYF861AfcCyA7p+XyYl5cjMS8lnm1tKnQmUjWCnk6I5W2GLrE6XOmaRoA74v1RfRkJhLVNLYcTW4/XsCaXJXHAY6nimbd8XGv2qI7DEB96p1JlNnbQIQiLDc9xI0C9yobiqE/9S/1uKMagQ3KSgWADbCMHE+QRDLr52jf54dKjvC+EYyt6FTd/WChLUhYT243akc26Iz3/mOCwHY7Gvjev1L/HvDSJbMf+g==;31:e9h6v2QeWp9zAM1UcZbsaVtnRoY6m3LJVc5M75hLe6BUiOoZCdaOqSnkvHPwIsNHcURe2rx77pgeEj6hwhKsliZ/VmOuZRDV1txvT8iiFSHMzZgi3LbXwr4wxhVY2axLib2QOcIZj1XGN4l61SDfh3mgS26bjIZCFMvLMuM21FldC1jKltkcZIVcNAMN363z2D2dUGGkO/wVjZ6KA7DBFA7FeHIl1UfbZ7Ft04HTBg4=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB277280FE494C2EE09A926BC5BC920@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:zlQgHRHE+GtKgDaQpJvyNj2KTVatS/zJE/qtQ3Sn/8aKjPGZ6Wvphym7SvZpkGlr6aVGWSm3g+/Klz9neP7ldyvdivB5D2TAJM0K1/HgiI4sLbCSKtByUFRB79r9PsDtSiLursBhUuo1o/vgva61k4dx3Lf7+RG2k1gFzb+Qjgr1OiLZ2Yuk5aOMT65ONQRxVvr5SlOOA5rNQ1AgPzeFf8GE7WKUk0QNTNY/QfvH7GxeJAgwS933C66guCiLqb69xmBrx62JCYiH/Fj9eqHeAQ==
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(376002)(39840400004)(366004)(189003)(199004)(86362001)(25786009)(48376002)(50466002)(68736007)(36756003)(2906002)(105586002)(97736004)(6666003)(6916009)(74482002)(2351001)(3846002)(6116002)(1076002)(478600001)(106356001)(316002)(16586007)(2361001)(7736002)(50226002)(53936002)(6512007)(305945005)(51416003)(8936002)(52116002)(8676002)(16526019)(76176011)(446003)(66066001)(5660300001)(54906003)(47776003)(81156014)(476003)(2616005)(956004)(81166006)(186003)(386003)(6506007)(26005)(59450400001)(4326008)(11346002)(486006)(6486002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:bp4Idin93MeBnK76pkCPGNN4UQeGX23w5DvbCHN?=
 =?us-ascii?Q?/jaIEhJOGdeg5nLGNx6ecLq2bwT/xZjGUYTH1Hruqlv/XSvb2BtiKfji2cOV?=
 =?us-ascii?Q?gwBC11i+UKhLnd21XRrdRTtTzrVS7oJaQZ+rbkdPMWWSsmQXERN+NjEyaRKV?=
 =?us-ascii?Q?vPohTV8WKaTiBAndvw8BnTqWd1aQf7BRu7BZIbZk0FtgA0dheN1jz4Uijzx9?=
 =?us-ascii?Q?btsqXJEYoYF+tY+90MKKXHJXJ4S/jKMB90uqBq94gly2H5VLtorbSkYVqVhx?=
 =?us-ascii?Q?pq6R/4bcjbP9gF8amZx5FNGuCxIO+KjgEdkQjwoHRAme8nmTMklieYLH9+KQ?=
 =?us-ascii?Q?GjqgCeJDq5FuhIcdfZrdBWo90L+regdhK8T3B8v3AxHPpQxYBMcF+PrHvOlt?=
 =?us-ascii?Q?Y0Izu52wWSYoELlH6YDBZonwyz/xfHjnMt9bl/Ksk0lJOR8vCLCSfa2bPHn7?=
 =?us-ascii?Q?fqNdawOreVqyhpijFwTrY4QK54uoybUBFkU/66otmhDRIkDlOTm+2uXfXwhM?=
 =?us-ascii?Q?nvhOY3XtrgTntB21QLIABq1cjpKuxAlYQShj1WhzVkADAh7yAyCxyWm3QS4i?=
 =?us-ascii?Q?nfbUNqcLB051wkIdjN87vHkz+AoSDqZM5ExbkJnaeetljuCtnqBQv+0Rc+84?=
 =?us-ascii?Q?qeMEZWraY6cwjDQ7Qx8/aV4gWx+5O4MOF2lQb4ghkSjpn6TT4H/b0ZGw0SZ4?=
 =?us-ascii?Q?goTo+uoypkm4L44GGchJAav05vkSK5sdcbTS1VqGrOawGX5jikA9NmLc6pn9?=
 =?us-ascii?Q?gPriIBXFBOJdeJCNe03irrRumL1wK7Oh+0JJzyg1Q2FNAjYTWdCM01/c91UG?=
 =?us-ascii?Q?41VDbRRn0RGv96hn+KBgu3YzBjeN45xO83pGazUhJXiw5iQbOVzoUybLHugA?=
 =?us-ascii?Q?867jLKkwyKpV3Q925DFnCvMNekLmxPnmqKJPmx4cepI6jjANWbHa0G3aQ2qL?=
 =?us-ascii?Q?wKJ2hDeKtaqOUWyjpYof8ecSBRz1GtdTo29fYShVSvQjxCdRH1YSgHNJxVRq?=
 =?us-ascii?Q?HsTPYCsz/Fi6B6lx+PLJUKUA/orEZ7MfsVVMz0/SQrzCGKNdGQ/dDKU+Mur2?=
 =?us-ascii?Q?UN6O/st5REKMx6QAhsoE/Nrs0Gvz3LyqetSN2ALJ3tUY/08+KESoglZ3XasJ?=
 =?us-ascii?Q?GRb/zmff1Vs1uOUuEHzY5CIU6W3NYrgnwKC7e/6EzX8tLkPKpzEJWPsTvTp0?=
 =?us-ascii?Q?B3kiRtJR68tF93YdPqoYCX2dI242ySCpDFlXfHYzwO/haiBlr3WlS5z+lfrh?=
 =?us-ascii?Q?2sbUH4gVjunisRrgBCjk1jw+n1bSLuqYDqUh2o2SYzoOBVpx3B+aWkHh6RkP?=
 =?us-ascii?Q?rLYB01nUu0zaYDEiT+rgv2w1blqt0bpGVgxVGMDluN3WnWdNqrl6mRG1GKN4?=
 =?us-ascii?Q?2sN9zVA=3D=3D?=
X-Microsoft-Antispam-Message-Info: rMUAllXV/yJ0XCAy0zah5flQGmcIZ9gv8WLc5G8sppq0xseuATu5KSP2PX2nG9TTqhAxL9SeFlTp5LyvEtZ21trgv8utL3jQcT2Z9bGWx3TAdAWHFT4goBi8KOmx1uMbEna32Vz/kDJW43zwBzEe/y9BHgdtP4aDoNMM3HXmTzbIaRT4u5X1FNjHyMUh5V6g
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:cseOb/3t+WKT/2eqOJTOTJsxkkBcQfklx34//VAk8EA0xh852atvafQzG7w+uBl3cDVVxXAXBSc72IavCtdrkUpzX7q94qIfhjyq57bMU+UZql0h1MokvZGZ0K5dxNmuIDW8dmbhpd8f4cFjtx7EWOeA/JNaaepNHpGtwC+jO/HTgoLpg4NVOluzdlAm4XCttLsU/wNGNOZjxTyTbPspreIhEiX7vU63j/WadoGQ8y5DaHkKXCPTQTMhHAOgj5cfYajglwagTR8UWOoek4XuT939lihieI6zwOueS4zagfPrYlvbOapG8kwiFsVW12zuEusyLJQOeKQC6D+lE5Ew1a70UxAwH90bFNev9FeQWtNDEQEVQrrn1/8HcZMbBgj73fZLvHDQGGKX2fShWB6X4uWIpTMk3dKMJI6GJ7VWYCeyk5jdJtiaggEmYV97PnrCBinJXTXZtqdt7NK+4rv/5g==;5:bcHM8Vo3Zw9ud/W2NUzGfyCVQCvGsk+2RuC5FrLeAdDTjSycY9ClXh77OIcQkUAWY5zDdBBovHaWrfbqs8INZAUL1TGskJdglzGCPmpAFhqYE+5YrjOloGYpbwqMsWam4NAwb5sRx+tZXQjLyiRx6Pry/Rz8RxxCI4DdMV4PHv0=;24:IABUo9S5ahz9+C1X5dvHErKvnzCuXu4t0HVFeo5zJxSPA35qSHycCNGpswaX6+kcIWMfvhklWex4uo0mhuW/K/ZfSghsUYAK/eRirAqOWKQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:HrLupsSXo/cFZIOkHU1JHZUuQThulyEeeYk+GxI5D88vBydc3jIOo5z7ANEeMkZM3wSoRlKoBPdUnuYx7lMJshHgHc7sX0qXSxiXu8KoRiLQ9+nxKzXv/hdicnspmMenHwGbLSBFQrBYLXR1AHgW5EWLV0HVGUkql/Mn9q+YwtbQbQcnyfCpnuIy/3PUGTOVkNPoUZIueSGbZ/3uth8GPg5FechFDqVcUaIdqkqfGLp5pxNZCYO0wgzXxOAb4YHb
X-MS-Office365-Filtering-Correlation-Id: 30f888ed-b46e-4251-796b-08d5bb1603e6
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 10:15:56.5728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f888ed-b46e-4251-796b-08d5bb1603e6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/nxp-ptn3460.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridge/nxp-ptn3460.c
index d64a3283822a..fa832f32b518 100644
--- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
+++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
@@ -329,8 +329,8 @@ static int ptn3460_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	ptn_bridge->bridge.odev = dev;
 	ptn_bridge->bridge.funcs = &ptn3460_bridge_funcs;
-	ptn_bridge->bridge.of_node = dev->of_node;
 	drm_bridge_add(&ptn_bridge->bridge);
 
 	i2c_set_clientdata(client, ptn_bridge);
-- 
2.11.0
