Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F263CC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C3520854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oIPqJftE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C3520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbeIMO0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:26:43 -0400
Received: from mail-eopbgr70074.outbound.protection.outlook.com ([40.107.7.74]:31552
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727009AbeIMO0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TkXQqCl9I/ZIB1IPB06ZODzOBj5IFZ3ERn5Mtyoeok=;
 b=oIPqJftEU3zn07IdBvEOlkc3RGan8BVXnQx58pDcKR+CJEAD04KdP1I9AqG3cA/c/JPS3X8HHMYoaR2QT3yKBXev9IYv0VyMKUGgswIFap7MhCj8r801kUpVGR3XNbPIP+h9Pa4Th0V26U/HZQCi9dGy6EBJLbWS/duzLH6EgwU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM0PR0402MB3906.eurprd04.prod.outlook.com (2603:10a6:208:f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.16; Thu, 13 Sep
 2018 09:17:47 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] thermal: imx: improve error message
Date:   Thu, 13 Sep 2018 17:13:05 +0800
Message-Id: <1536829986-23702-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:203:72::30) To AM0PR0402MB3906.eurprd04.prod.outlook.com
 (2603:10a6:208:f::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2268787-86d1-42e0-cd36-08d61959c679
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3906;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3906;3:hvaBRuJCiyMjfjjBjVQnz2cBnhFEGyR8tKo5eFbu2Q4l73WGoechzlNuDnimA2iM6iZ3XXHg5J3QUz9IXDZbu/b88LRihlzbvqQSVLDStRUJjDOzosD1DwrexF63TmML/fC1UDOiz4PWnytFQoDi5WOMRGi+zAE7QidG+Febmfqmw9Q7JXZ7rv0HWKN9bj9xm104AVcWDfLEyeR78uDbL2KiCB31UzWgIRF1jahCSGf5DuIPtqfY3QJUVdsXJNtx;25:uAPA8PCPxPumAis2QZTZc8cgs4KfQYqOCwdt/3hVpkOKm0GXdlIuId+/sjo3GxczwpJRPrvy07I/jnVEmh/3JHo1giDGSvmTOk3lUpiuuNYtz+NEpZRtwN2z5BpOAI7q9aw6lV97eDYU8kd6xGeCvq80crjXja0nv9DQnX+dpOA5lAXEYXtlUEgJxA/OQQy6Ac+PWgM1SwrVDS9ms8stbIML++8MKmJcc+jHcQAm2pAtJwYkH0HcwIuuMNbswrYcXwVCCUoVIqILxvYtBWAlXweF9E/VC0hzZWgaLWcBTp6RFj3Sc8QBmgHA8ytO+pTdz19MnzJSV96qublpPb/VXg==;31:4X4WBtrixUyNYRhsegF8r7J/YUTE4QIS88vGMZlOO+rwTeDrVgjezn7PNCmJLbTopUVe+OJhgdBLSrWsaEQwuTOLZM+DhbddxcO5rLCBuErfqY8IqE2JHpT8SdP5rWZuJAqAbxaa7n77tMJSX2AaN3sM4HiQLxgz7QX/kvCec3irQDTkqIhyoZbmZi4dymb+Wn0GTi228niHxOk7rT4jk8B6ONRUzhHz8yCkjJPh5Lc=
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3906:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3906;20:KKe66x8/rVRbsSmK4Q+VQXhQczz4XoZLK5WZmbRwtnsroebLzoHJSfFXqAm6QYN2Q0tDGYQiFRke0+PzBq9x3+PaUTv25+LNtWHA/LJITrVDFuYeVqV9kqW6FuN7F/dkoZuX4rOhv+GcegzGmbg6l3iULP1YLd6NbEbXZhIrPmXjLpW3efP0T5TUqgNpxJsF2g64aucVQClt0trFjZXz11LwhVz4W2+eDgEnyYuSb4Id3/+sOV3N1on12Zk7hT4W5Gudh4cJyPtfyOGqLg077TnRdv/Nj9z587MsPaimilDL/+3ikas7vvkn/ssRnIs5htRBxezW5YzejwMHdC84VD1YgGipfoBbQPxQp/mdXJ50rInhjooihvK3NwVzFpOm9EN1c87l3c9NMr40eSQ8zbYFUABo1lvyiloQ145tW67wZVjYfvAiLl39S1N+b8Fsr6i/xPZ7aVcqfAI2qt27vogzmeqbLMbjDfZgmRB1WYHT6z0/3GrCsS3ijUdDZMpK;4:Yqf9A8Olqj8OqtaRUQTVr5Ou8WAl0tRcrGuD5QrLGMBbY2ql/v1cHX5rz6WXd/XVHvpYIu8YDgEFz/R3Aiy+ES101mMV0YcuZlFg1M2m0sBPB5Y+b6XOR8vSK6rektt4kq+Lhl69vNFJtRVUdoK7WsmkQYLvwE5obE7ApQIWdeXpnnrmKKJEg/3DV5V8z/AwdEZfDUMBjwYW4/cz4kQGQksg5ZdQa6JPhIey31mW8qZHsCRTSgxAnDI0tiSE6SRQBcGyhTgsHL3xQe1zYYhs9SjDjYueWpo5W310v4PDCeDHaEaLK+qP3Uj+eA/xfnaG
X-Microsoft-Antispam-PRVS: <AM0PR0402MB39069FF4D00CD235A12BA7F4F51A0@AM0PR0402MB3906.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:AM0PR0402MB3906;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3906;
X-Forefront-PRVS: 07943272E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(376002)(346002)(199004)(189003)(16586007)(2616005)(5660300001)(305945005)(316002)(7736002)(52116002)(106356001)(97736004)(6666003)(2906002)(105586002)(51416003)(6512007)(8676002)(8936002)(50226002)(39060400002)(66066001)(186003)(36756003)(53936002)(81166006)(3846002)(478600001)(6116002)(15650500001)(47776003)(486006)(25786009)(14444005)(81156014)(386003)(6506007)(26005)(16526019)(68736007)(48376002)(6486002)(476003)(956004)(50466002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3906;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR0402MB3906;23:xiQGdoXrZsWAM6WnYp8mYEGJyLeJpfO9APLBo8B?=
 =?us-ascii?Q?Q3hZ+sZDy4TBgUIohcHXFuDUHPvdsfZ7YAqdZtPG5mPxHnxWrj2e5NDHN6Fg?=
 =?us-ascii?Q?9W2ouN1nBDpJmTMgbsIZs28HD7/NBHj7CIeVtg/fQzmtAVTB/rVquncuG3B1?=
 =?us-ascii?Q?ujCjVyi9l9ool/lT1aDGIAJ/rbK9qqgEvYKFGiFNPZHqWWuC2+8glx1YPxlk?=
 =?us-ascii?Q?s4HAZJhgdFNkjB2Akoa42bj1YUvlH+DIa6tjLFQGUvyJGOLAVxIuXyTFXP5p?=
 =?us-ascii?Q?XG66jzySXsxWJ38FYrJvWjdWEmv6VgjHXMWN8DKmjuyHdNDSQ8Exm+kLFh7p?=
 =?us-ascii?Q?GkQpqzRFU8/4g4tSejQZjlo13b4W0Te/94lQbOt2ekObpde88qf7alDTWTTp?=
 =?us-ascii?Q?JY/x4W9+peRko0frkyh6gCmYeqy5EWsU8XGZqD/4oyhoAofVctN0twPtGVtR?=
 =?us-ascii?Q?B8hwa1ndWRibomNmLbSI3qCGaW6uf0qdQ3Qm77JL2MukbD/f5F/vxSbKv4Ii?=
 =?us-ascii?Q?GgVf9/roaRPWp7NC+JehRY8pQjO5Gj4JWuqd5oB5REoPtgYABT8zFAHPi7k3?=
 =?us-ascii?Q?Yj+2g0IMrIRDfCS7LCN6/9Zt4h26iOGPeRca67z56bFBAkNcKXY5L/osw6cn?=
 =?us-ascii?Q?yusdbaZW5FgBPMoai0DZOb8t1bhm/88DLdnSbgEi0l9oPw0cKb0EC6G3Flq8?=
 =?us-ascii?Q?/adnvXF2R308jnycpwffsEoAUuAvN3Tv/VcDFK+kx1Q0JYz0vQ2BS+p2kQqy?=
 =?us-ascii?Q?6E6bHpmHeCgp6kzyc1mRvx2nYddRjPUXP0C/n6ROKlnhkd9lSpdEaSSx7SdE?=
 =?us-ascii?Q?MHTT4hFJRU4fUaSavMgmeaWnoMpQhBtPUjsBQRqDm9bFvGaBN4vy40/sBs5Z?=
 =?us-ascii?Q?jFYqNrZKPSMbjpOb/TD+QJ+B+FKf7PicuH2CXD6wl0UeQWFxA39QCNRfB4dK?=
 =?us-ascii?Q?r66U/OGZP46zAk/NsCI+tUtx5ZEedONbzD20Eynte0VidprWjVOHMBA5oKr+?=
 =?us-ascii?Q?5IDV6BjP5YthRBBiRb+122la+YUe3QRCj7ZZHIcjHdbHgMS1OCnZruL8mEgi?=
 =?us-ascii?Q?6gr9cK4GfLAYgnVpuddiogi7nRCYsmM152F2mG9T38SQzQaqYu2A9cwbdzaf?=
 =?us-ascii?Q?iMbnk6pUhUKQFLjBQ/75g2/oWV2nqVDif?=
X-Microsoft-Antispam-Message-Info: blwfptA9ZquS6vjlW6NHqwvKOTJpyEWrfHv8nZfgntSqfUeCGYpJUf+V6aK3ADfn6rmg9U+v+Kf264dDPg97qOu3hLY40NBRD+SFn4crTJtubJClXPZ1gV0ijf5BfMuq25EiBJ/TwJx7i5qQnhhcqoD3UHULbC4NSLNJN6faENkfC35pg7SaX6Z2W5eYmzTk8B6w8FIK8ZMaeMVr/CGgsOYgtTjnxMbx8X6dWnyTiMfN8u+jI+btSd+8TDYCp2zLn01rFchbMmoWBpoU4MUOjRkgRchheOtKzd+hpYDFPtcFp2p0K2ks7GcgseZxn4i2CtxSme5yMHvt56c2JHgQD6FhGO7zChCJXknLNtKcf5Y=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3906;6:sDvR4H16lNLj3xIn/WIz+O1WcnMOkZilAlxzpPZ85s1kKZkM207WSlFcTZ/ocMFUkKy+8FAIkOpUZXHvoiPw8RQD3muZAIwJX0gPJTzwZxf0sBLrPTR+0gDQWS9SO4uc+icAzWDfsxHQeQ4dD19bO3mKzDhWt7vq5s0grMgf4O2JkBxhgb8dd0J5q6PvZ2UIG2v63kqIlZM4ps7u0OzrJlfLLJ9GNzrBcp84Nu91goEb+WwvX6d9ERdA5lIfaCdUPyfVYXKqkKlZ2btR8GP8102ugHxQvIauBc+qejqri9vxpiPZyEAET29HMFz1na/uMzxWSnhzpFjZjYsg7iyjMZFsqdQbZvpPBftd92gfHKzMmVLtEVxVo3GF/eEMemUoPNIpvoBu6uBes6ElMX3eJd3E/KBeFxaW/d+ytk6DlPKPWhQbzEufGLPaF9hjFLWARhHs85Kwe/cWIDUdo9QAwQ==;5:v5Y7gZukmREjB5tsVuVvAbTiFXRxKUo9XzAcLCCbdZY/4+X7yNTQnssv23Piv+tLhCF+yz0imi1h7xIn/wa89jmlrhmQIno4/m+lyxABnS6gvWseiVobW1GZAKGnZZ5UgYvM7OgEMTf9iqFdpmkNaIXtJjgDQs7/3HaOgdrz04Y=;7:ZXHZVDye+GaB2XMa5IeAqK5ICrQywkP7PqQvXHEh6y6TXffrg4igrxrFcGQT/xF1mjIvH1TLeDSK0CAIIyYOeNwUu+1Z5GUfCxwF8Ifhz5yjIkSRPongqPQKwkjVtTnkZbUeqjxH1UnZZHsP0NXXGazxKecgfGk1LZsfzp6VfuxDHvLfYA6YZKSI9iTzJkL/b8wh/h0YK3CY+BCzGmbHypIwz1s70jkVG1DmobnwwY1qxCKQ1SMXQQvACqea5wei
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2018 09:17:47.0243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2268787-86d1-42e0-cd36-08d61959c679
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3906
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the duplicated "from" to improve the error message.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/thermal/imx_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index aa452ac..6cfa2a8 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -725,7 +725,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	} else {
 		ret = imx_init_from_tempmon_data(pdev);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to init from from fsl,tempmon-data\n");
+			dev_err(&pdev->dev, "failed to init from fsl,tempmon-data\n");
 			return ret;
 		}
 	}
-- 
2.7.4

