Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeEPKW5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:22:57 -0400
Received: from mail-he1eur01on0118.outbound.protection.outlook.com ([104.47.0.118]:60976
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753042AbeEPKPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:15:43 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 04/26] drm/bridge: analogix-anx78xx: provide an owner .odev device
Date: Wed, 16 May 2018 12:14:48 +0200
Message-Id: <20180516101510.13215-5-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:NECieczap/cd6Arexpvkqas8aG1JxCsuBlTh/FJLra0Lan5gwp6Lz7/vFnuF7xna1xwNF3meAJdeRQTMpNwyXV8Ea5pKfz97v/PhXcyCoN8mcV9lluwZt/UEvUuKNjmrym4UH51zF3VYkHu09VL1jtLYpXNCGwkl1JBKocx7kX1hAtQQgFagwIlytcv4ashkNBn2qzDbJ70L5z1zBu60E7FmhfNqwtgnl9jNb82Ch0L41ZHwGD2rn3jjvO82nv5s;25:YSTA7EoVAWVzRQNKbRoGzHHUU2aaoRMnZEmbio31SxqNonW6iI9RnhLFuWaKeyXdueXBGp75+IkaWkrnzx4+T0pgVB1jdPhRAK6gVPcPTSOW9HxF9kLAbldWQvcM2Cg4qjYOzEQUOfMO+wFaoaUiggXTRZIVGHZPfFrrGHXtSewpHofs8eKmDz7WZUz6fxkmfttWoGddU8x+Wvro7NXcw63tkh7nMsuotQJ4OWhUwzZ9eImnNghSkxif+pvACun5Tt1Fsn/Pxnt/DxHq47WCBScXcNHbIE/aNO95I67KR2qPzOMzK6mhuFHAxWhdD7M6a/IbBkcLDEPt8VH0+wwsUA==;31:nEAxud112U2C0Qj2fcFZPYevVjOnwqKmrL5SD2I5aNynLBt9jYtKwex+mOVB7riX1w0HLZRMS/EPP8yxSNeTO3SLdH3YnbvCeQtCR+AqAVOo2Nf5JOlbPbB5AqyXB4ODBFmUeCS6/JH17VpsyaC3NwhOvzW3RRtCOLy6VDcAbZBJo4uj4PkpJn54/AOBqOsT/cwwbf4VIeM89L/aVodSzXN/JwmX+tbDsONzYGsg5GE=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2772439FDC242367CFB07AA9BC920@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:Axbhr2ndEZY65dcnIG1g13gPUFv0KroDB9u4rK6O9AbjqsLXMeFMa1bS3KCqUeqTHGW0TRetX5lsQUtxz/hP4578hCXSvqcRxTEAy3tG2HoAjRaCEQ/yVU6UhpVgK5zhZ6c+6ZoLF/iRN2nxm7deg5AMxiKAggqi3ibBVjhxVfjLzhTZ7FPY6r1gXW2LK7JpbO68Yn+g0W9JXJaTULbOVcRxe7q8pqvz49A3S0Wey2j64bkb1yp6vQn1vEOiAw55St0RknSwNGZ7Kbnr3xRQkA==
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(376002)(39840400004)(366004)(189003)(199004)(86362001)(25786009)(48376002)(50466002)(68736007)(36756003)(2906002)(105586002)(97736004)(6916009)(74482002)(2351001)(3846002)(6116002)(1076002)(478600001)(106356001)(316002)(16586007)(2361001)(7736002)(50226002)(53936002)(6512007)(305945005)(51416003)(8936002)(52116002)(8676002)(16526019)(76176011)(446003)(66066001)(5660300001)(54906003)(47776003)(81156014)(476003)(2616005)(956004)(81166006)(186003)(386003)(6506007)(26005)(59450400001)(4326008)(11346002)(486006)(6486002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:O1tbcks8mjDTU/1am0UY/BDhGwAjsgszp171wg4?=
 =?us-ascii?Q?pKyDRbotFCF8sODUa6DVRhT0RUSLTjkgKtCyAByF21fDXZ3rZ8i0GaWsnj6X?=
 =?us-ascii?Q?g/4lUacq4mGmnESmHAXS76jF7zxne6ZrHsnU4S3DacsyHhsKZ/lNKH1qT5m2?=
 =?us-ascii?Q?LP1hvdGZ968bv3CO9ljBs7nuZBycgrywpjhuYh5cXhjmgKLvEi3iDCBiSVZZ?=
 =?us-ascii?Q?/O0Nv+zX36TpAYlnmeLRf22+ZhQJkYhMdB8hz81XypoD1K1oSAYVQX6OOlIf?=
 =?us-ascii?Q?dvVUJG0SIi+2bDVZSONEQ/v1LTebjIV9+QSf0iTnb5cAu5ldbpmtI64mdvOU?=
 =?us-ascii?Q?ylCYlXaIwqeg4ictsQ6tNTu0MVDRgXc3Mg+AuVUZftTd6h0wWuLLmAQXasml?=
 =?us-ascii?Q?GW/duhExceJkgIaURV3W42dL87bpFBzenYw6HLm00PLTlWd5WBpEBALiYO+w?=
 =?us-ascii?Q?w38F9s3ykeD7z3Kfr22STZXc0vXvatQoT9P2ly6kp1vcG6sPrGusSuPPQ7Ev?=
 =?us-ascii?Q?5nW5mVF7syi/DZASObVRYi4Y8KKkYkD2YTiBD9T6XjT6UMlconwGwOxxJxs/?=
 =?us-ascii?Q?U2WwKxrKUUIfLE5TCSP0Wpzu4IR+VplE5tJoWKuhfAKIeDcpObNtuNJEr/vS?=
 =?us-ascii?Q?qaqI1EqmAFGd6Bhhn14CEmyUtawd12zU1URTXvhXaFedJl7wK+SBmxOg+B1O?=
 =?us-ascii?Q?+3reZC1aEKHq3CLJK9hz6S/vllrC/XX+geFFILp99dVP2C0+8xSGrl9XiR6q?=
 =?us-ascii?Q?2gIJDtSGbOVjQjf77+7SbpEHujDBN98oEH7H0IrCbNJwfIliGMLURXdRTMUI?=
 =?us-ascii?Q?7eaM/FExcVCrjD3L2CtHxsx/Q12srCW0/+0RZBJgSVw/gEQyzMbhhBYNZsly?=
 =?us-ascii?Q?xmJ09FOUe0sRNxW6lmcRJw0aq1CfSYs/Yj0fjeolmO/NQINGTVeD0xpNPx8I?=
 =?us-ascii?Q?Vaa+rde9tFxT1fNUS+HmHdMIh3d2jvXRqnFGLErNWs+8GPq3LFKTxo2nUgZF?=
 =?us-ascii?Q?8tKmZx3bH0ydM+uAdNeySe+LhaGtQkpwa2MPvpZRIA8azh8eynfpveIecMkw?=
 =?us-ascii?Q?Mx0weIXBac5Cm4JUe/6oqzeJuNknHKXjYWLqztJQFjsb/QFio8ThQQB7rxuH?=
 =?us-ascii?Q?fxmdiBTeOAKJQbvCp7N/vFJyVaUexpQ2rv96N+lRpE79KyIzVGPILdUJbjma?=
 =?us-ascii?Q?5hUXg2Zvh2zmLcbQAO678YLdCjq4hCqxUC+n8O8qV2D211E4wfzZ7HU67spk?=
 =?us-ascii?Q?qQtxNpXG/qvrPauJbnlXfP+ioIqB44uskTxHmUsrLNlcqLEQaXpNAKlTCfkA?=
 =?us-ascii?Q?Vc6J4KQ3cOMdSAlRAJaDjEcctd/XZSUHMmQNGmpkykErf?=
X-Microsoft-Antispam-Message-Info: um7Cl2ilGXvIOzrNFDpD6ie290SSulwn6iEUUa9H7wr+KAEMhTkBv0V3spVpXgLspmNcrkuRFN8v/nFj6ATukxLJAn8xqvYuKmVDv2Jr9QYFYQJxMZAf6sShnZJlwjv+zV+P69BFLqgUQ8PA7PKhP1serPYII5edGzIPqOa+lOOqs6ApXEbvdPXSm37VU48U
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:KBfZJyPSzPe8/Z8bOB/+aq2Tt1gyfEv/+yHphvtEMqCXcPYN0x1NQIBXo8r31C4D3LVXhY4s7jhvzzM8yQj8GfNqwpGYL4bHTLeDMYWc2pU8VG+RWfPB2fCYfPTVx+wzzT/e5IWtOrrtdPOGiaA+H8Gk0zpouYnP9V3QSx4MBr8UNsts4isz2yBUOmpGf7CbTiDuKELZYH71tyqGTsr9gdRRG3Hu628CplObc/NFDBfe39wLKHzRgJjBArMfPytilCMM2e3FuRpH65OgsErExnQ4a2pKWaMBqz3y+Ex3aKQhSVwSafuhR0BVg+JR506xm0nUHTlbd4qiNBSW/mY7diqqZXsZ/XiH6rR1+ikynR3Nxftsu1mtiufOB8bdLTZP15idDwMNuAfeXYFR0u/ox6lvuaWJNunx4eQO3N4AwsYZbiUn6s9YABsuDsRigQXZ3Zr/mkSGy44k9NFKjlBn0Q==;5:Q/m8xVOG431w21p+vBeR+5nKwOVkNdDxiJOOTgjvvgobgrasnMd9BrtwnlWtcvxJ5FoIhKXXk7U/iLb+oPR+kFu66YzhuvpwIl2u/CiFp7kBgeF1YpDE39htBA9xdSNBgR9e1ikiAixjqkEA8eLM8tyUYTOcEnVCIIERs+Eq+gg=;24:sLwxj84ensUPs817UUzNaNVwRgkWJW+iH6XukKkmKOEI5lw4/OL/pKAmaR3d9RRGFGQoARi+5bLwT0UtRhEapCY2G42wm2moZJt6P8DyEX4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:MFaFODQL99xChVCb8IAi8b9Wrek6BSCDyyUL4FgLJ0iM6AA1+Xa4w+ezg+9Pu8ehGSlr1JUx72jW7EBXB+QeCvfyWkCr5+TQDT+iRvfGyTfOwHu61eV88KiHKW6Dx1yoddVEfRzknXe2AsQgAP4+/kZX3ZtnTzcy0MjC4gs8llYWdtKsDm0CR+chE1fpzy3SG+BULgMdbN9iPm3w+u0TtR7umFqt2nkeYwFv1tDLieUv67GJIbzSM4EAikYbkowx
X-MS-Office365-Filtering-Correlation-Id: 58abb5ef-b0e8-4f65-2624-08d5bb15fa65
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 10:15:40.6288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58abb5ef-b0e8-4f65-2624-08d5bb15fa65
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It gets rid of an #if and the .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/analogix-anx78xx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix-anx78xx.c
index b49043866be6..1d6620aedbdb 100644
--- a/drivers/gpu/drm/bridge/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix-anx78xx.c
@@ -1332,10 +1332,6 @@ static int anx78xx_i2c_probe(struct i2c_client *client,
 
 	mutex_init(&anx78xx->lock);
 
-#if IS_ENABLED(CONFIG_OF)
-	anx78xx->bridge.of_node = client->dev.of_node;
-#endif
-
 	anx78xx->client = client;
 	i2c_set_clientdata(client, anx78xx);
 
@@ -1433,6 +1429,7 @@ static int anx78xx_i2c_probe(struct i2c_client *client,
 		goto err_poweroff;
 	}
 
+	anx78xx->bridge.odev = &client->dev;
 	anx78xx->bridge.funcs = &anx78xx_bridge_funcs;
 
 	drm_bridge_add(&anx78xx->bridge);
-- 
2.11.0
