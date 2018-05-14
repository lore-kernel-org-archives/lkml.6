Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752311AbeENO4P (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:56:15 -0400
Received: from mail-eopbgr20092.outbound.protection.outlook.com ([40.107.2.92]:12352
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752320AbeENOy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:54:58 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org
Subject: [PATCH 18/21] i2c: rcar: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:27 +0200
Message-Id: <20180514145330.4857-19-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180514145330.4857-1-peda@axentia.se>
References: <20180514145330.4857-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR08CA0043.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::14) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:DB/G+uU2VJCn9uxV8kYqo58e8JNT19TD/X+6wsKJJjlUrSG5qW7L9Cdmgz3YkNbtBGPkThmBFHvdLuJameFhY7Zs0aP9Opaq7jKlyWVeQ74mcJUU43ZZajlP9ppKKAsG/53920VjFty8IJrOmg5JOPtWNBFGvEZL4FAAsxjCKJJWwCtBpiN40dLY90TPsaho0fKLe9Va5pdSljjQ3yh/ikltOzroE4LDF53tLrSt/PGfA8HLM8D+C8PMigIj/Xx1;25:MTBHwoepkfYvm2cGhUbkmiIZCogosNi+H4O9uFfV2Aydb3wRVdU/1z9yqqxBRObVFv2N2X5GHAVqDBh+xbMaPDurMwy386ByYkLHxiFA+5d6dso0S4polvuS6hn0ZkhDDCuUyOGYLr94TTHbYAewA2EAfoS5PDUuhjAZzwwXfwVNiMYfP7jryHbl0ECat/1+GRimQquw4VlL8hq27zYJR0XKerKA8gsKyLm7dmm9ky/7kJTPF3f70MioLJ7Ipj00o8vyMU2KJGRCzJS6FIotRdXoenmg8To4C6P646JlVyAKSV9e7+oE5RTV6+8rwt58zpTpef0wYVEa2UXbwHkyMA==;31:2EegIgl/HxOl4/4WMKPZIoHbNO44o6Y3yd/rRLS80GZCJI445aA23RMO3WLKLlP91jpWZDwp12KAfrqtuTFaTJY+dwHkiIWieSeUhvlZW2KIptqMkC29e4NPTwLLJACgfijVE/YFnOSL07rYEiVRC0q718zfr8WN1MaCCuyemPwtTMfaikxHiPRGj8N/Go2YKLYkF0Eb8hUyDnLVD9B4wGLZuHKb2UX+/lBGT6y+BZM=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27822B9DC843F256D29B0805BC9C0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:yqqgpnDZpUee17tTxXhsms14f2R9cezvoeVT2BZ8pcZ2OdblL/bmWewLpBvoSUtIkrV/AlFMkrFtvlKZsqDmIlnaZ6BX3PSv6B2lsNbKWTfq/vtMeBqQ4eDWHOzCKSrE/P41OubPRw3FvwXWHc/kKKfb/ccG+P3/oxlU7sdzjrlHj5v20yZNTxuHw634VGThaIXvZTRzrtV2gM3f3NGidYHsjYjEUkcJmRdcQxVyqYTSBS8JvPNU6aE1l9sN3PzCc2J53yPEqB1YOLFJxNDhAg==
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(376002)(39840400004)(346002)(189003)(199004)(48376002)(6116002)(97736004)(68736007)(478600001)(4326008)(5660300001)(1076002)(6666003)(2906002)(53936002)(16586007)(3846002)(66066001)(6916009)(316002)(15760500003)(47776003)(50466002)(54906003)(6486002)(50226002)(186003)(16526019)(476003)(81166006)(25786009)(6512007)(11346002)(446003)(105586002)(7736002)(956004)(106356001)(2616005)(6506007)(36756003)(76176011)(386003)(59450400001)(2351001)(305945005)(486006)(52116002)(51416003)(26005)(8676002)(81156014)(74482002)(86362001)(2361001)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:zwFn3ViAy0ERmsUx5HR8HCOVZZ57X4Uj+LYdOGy?=
 =?us-ascii?Q?DV0Yj0HxX0f1BRQFP5L+jYCJpQ7OzsIL04EAgRylPJvGaiel0c5eUGXmbGQ+?=
 =?us-ascii?Q?HexuWYLJknpvORzpUyVYughbYmAfZCKlQXA7htO/Gfqt50xerfsIY/IaM6Co?=
 =?us-ascii?Q?j+kCWyGN96YHclvgSVlL7NHrlMvkMQuJ/uZlkoJZyC6fIviDpCIWUMxcybHV?=
 =?us-ascii?Q?G01iHupPvyMEiT7QrcB3yCtB/jmT4qqOnhm7MlJNjP0YvcfUhKVJ/Sj9Wbrs?=
 =?us-ascii?Q?cEY7oXK66FVAPKb43gzbc10Eu5G4JBgPV9FMddVlmUEJFOPllpIVlwQ/Eap/?=
 =?us-ascii?Q?9moqRNppnbJa3GIEWml04zMO4nh01bVrTUCSSWOhr3MS6my86uGBa9uh9clq?=
 =?us-ascii?Q?8tkPJgAczxTqSrCf68gJcUrxudNbZJucRSlj/WMfkdlyuGqRIdB/6Wz52sIx?=
 =?us-ascii?Q?jN8ALIFj8NxBiVCSJ4DUaEYz2PsHBN6flORxttJ2u30i2FyaYPjBG3+k728h?=
 =?us-ascii?Q?fv15zMvnIzEGYFqm2Q92Kvy+UykHKPrhlnZuxhgRUfCyknX8O85JB51Rc1sH?=
 =?us-ascii?Q?dLs4e9+Ke1dVXuKdXOy9XkMK13Jk4my6Cc2iaNZEf3q4Q2UtiUqEwrxGCZcl?=
 =?us-ascii?Q?KSVqCDybWVyTq6ZnWPJ5FoAjTmzkzq42TDNKnUq7CybBck/zku1jaiHgo28k?=
 =?us-ascii?Q?zLlIjtI6DeW2LXNntUk6hApVLl3Avp9GS4smJJnyo11ab7XMgdjjMWxoXybB?=
 =?us-ascii?Q?06hnTfJoiZ9cQhasGIGvmnSI837wk8xnnfHAXZscNLPp8cLSUJHTn2dASb2V?=
 =?us-ascii?Q?13aHzjw6SJkncSuZSQ6h0caa36Q3BxblAhls47rwsLHukTUIzYO+SMmUOT2k?=
 =?us-ascii?Q?8aan8jfhqoyXcF10zjx060sRLaEHx9M1XeJl+/kJgXtsUdeQJ1WkB1G1istf?=
 =?us-ascii?Q?OnCxeZnUnYPDWbiEVSGzoIgmslpuvdtW6/rhzw9DDECvAR6lz2pGikV8tSs6?=
 =?us-ascii?Q?0BgJsbM721mKN+EGM8b5ixz0DTFBg5+xEbk6eVBvITPo5kC711VOHULEr2Bh?=
 =?us-ascii?Q?4AImfbVZhWF2gvoE66bSxjNL921+IavglrJc0xD8Uw76t4TntHF5lOP2WkW/?=
 =?us-ascii?Q?Q7hNBZRF+UWVkUMKiSfmp1X/bEpMjw7lVkwxkSUjwRhvYH8hNBa5IwPZ060u?=
 =?us-ascii?Q?X8Bed+UPV121C6AynssR08dD7D6bjaH2ZSgJlXc26lmPU8DLCiryZBAJTrlO?=
 =?us-ascii?Q?za2NvnnLFDIrqYfuHd/HFZJsDogIbAvQ4IyqMsgRh8xN+Z/kUwlAToKiADSG?=
 =?us-ascii?Q?lXcpy0Nlgoos2gbM8t53u/ZGTN9/g1jer3Dkzg4CFGIYkwVihzbihoFVUsfs?=
 =?us-ascii?Q?Votx/6w=3D=3D?=
X-Microsoft-Antispam-Message-Info: jjOKRrI7FFvXas6cuuB2HwfNbmBxoo1C1b40sFuDnv7OFirxiskvEa2ObuEE1Rs1cO8TxXrg1W8bTkXp+T9aZ2a4Bwqgqn68/DAJjOxHi6E+F9cJXiEOZpfdYIzc+iXFEpu5kU0WzCiAwJ6FWc1zW8+LJLBpkDIbA8UlVyJ4B4Z/TIaIF9n9hRL9OSjSFoPx
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:+XtIE928B7gE5kAreJ9jMiFUu3cvZhsKMWD0zNOvsfXh+/YYeyHvJ8qU34EKQG+QzxXJxcIC+xalFTRwJXPjsXl1DsyllcjnzssbuvplZHmAlJJVnWtoCAtKFSwtqv2iVXyMoVvYtXmU063yu7LfwFmVg0DlmupwdWejAXoLKP8ue0wHzfK/43xFv6rrd/j3Y78QxsSf9Tt7lKZQO3N92QQxNcrdcRLVuOJkIza8PpBQzEC86VJs2aRPMAUUulJAYi0kC/WDE3U5kkqLqNV7KaD+JpfLw4BHsRdYJodCizoAxrFA8vpdvhwBTdX58VQzrMyjJc0njWs9cTxH+lVBPM1sCweBbS+daAn9b0y2nOPhPmoRPw1e8e6U0yW1iRY8XCmUaUvs/dtDsE2NdWulVk0cxrSLMBvy/UsLFLq9crZcirTX52QyhamNR7dLjNWdoF8ttGVKaX79GqeHT2vp+A==;5:TLPwIMzb0lgrn9SS5HW89GN0ZFkYZJTWK19iT2VmWeMBdz6A72n+nkC2i0P/Xx2DJvkJeAPhSs8IpAT4RN29IcAzT5Zcckghj1uqgTY4VPvOtjLU1RLlkU4vnZr9dSMtnvK228rG5w1G/Hyd1K2MbB/EMWAMcnZB/9DWNmytmCk=;24:ADDDlAjd/hzUbtfa8CkmEz5wlmxKNME95veIt+gJRjldUON8PtRPVXKrzuvzmmkMWBRIPUEsKW3a+2SCBkPogwzjaxsFnsm7YxFy9LRJGfE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:IfyRsHB4udxGBz3k2OC/70J5NN6jAI+wayNotpqbi/mpNKLi8L+kWEP2yzLnSf+GOzx/3rEOLS6FxlF2Qb3ngIVL2cyl6ROX7GXPN/UWw0n5zybQ93mzhrn+Y6NEoxZ33qUxZQOIAT8UZdWffd3p98v7A684g1TNBZhQvYCsp7H43WA8wrBSq5407T6Ut8FEOi0dmTNnf82vYuPKxLRyDTtWfLDg3KtPHkbcGXzXvam2ULmBprPXdJJM6arVbVbf
X-MS-Office365-Filtering-Correlation-Id: 0827b30f-21ea-4e30-6514-08d5b9aaa8ef
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 14:54:56.8883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0827b30f-21ea-4e30-6514-08d5b9aaa8ef
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because it looks neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index c6915b835396..17b91ddbe013 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -329,7 +329,7 @@ static void rcar_i2c_prepare_msg(struct rcar_i2c_priv *priv)
 	if (priv->msgs_left == 1)
 		priv->flags |= ID_LAST_MSG;
 
-	rcar_i2c_write(priv, ICMAR, (priv->msg->addr << 1) | read);
+	rcar_i2c_write(priv, ICMAR, i2c_8bit_addr_from_msg(priv->msg));
 	/*
 	 * We don't have a test case but the HW engineers say that the write order
 	 * of ICMSR and ICMCR depends on whether we issue START or REP_START. Since
-- 
2.11.0
