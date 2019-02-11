Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30A6C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5D520863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="BDFOk/N+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfBKIb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:31:58 -0500
Received: from mail-eopbgr30062.outbound.protection.outlook.com ([40.107.3.62]:14976
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727122AbfBKIb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:31:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjQ9QyCeVGip3EFBe+bgRB73v6AVcBnsli83BKrpBVI=;
 b=BDFOk/N+SLkTa1DmihqrvV3a4HAle2shgMq2HH2z/CO/hCTcKj2vBSilizmzUE58rhokNJ1SXXoTwTAZilxM0Qfp90690QYd6wsKwAL/rqYSNqDkdXrgl2ECr/+qpHpxt6DVY7zfrf31L7HAeEjXnDcZXgHCqxcQjpUNYa85rc0=
Received: from VI1PR06CA0128.eurprd06.prod.outlook.com (2603:10a6:803:a0::21)
 by AM4PR0601MB2146.eurprd06.prod.outlook.com (2603:10a6:200:47::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.22; Mon, 11 Feb
 2019 08:31:52 +0000
Received: from AM5EUR02FT051.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e1e::207) by VI1PR06CA0128.outlook.office365.com
 (2603:10a6:803:a0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17 via Frontend
 Transport; Mon, 11 Feb 2019 08:31:52 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 AM5EUR02FT051.mail.protection.outlook.com (10.152.9.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Mon, 11 Feb 2019 08:31:52 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 09:31:40 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 09:31:38 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
CC:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH v4 5/5] i2c:ocores: checkpatch fixes
Date:   Mon, 11 Feb 2019 09:31:22 +0100
Message-ID: <20190211083122.32485-6-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190211083122.32485-1-federico.vaga@cern.ch>
References: <20190211083122.32485-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(376002)(39860400002)(2980300002)(199004)(189003)(4326008)(426003)(486006)(66066001)(8936002)(106002)(126002)(16586007)(476003)(110136005)(11346002)(54906003)(956004)(2616005)(106466001)(336012)(8676002)(51416003)(44832011)(7696005)(47776003)(446003)(246002)(36756003)(6116002)(3846002)(316002)(76176011)(50226002)(7636002)(7736002)(2906002)(305945005)(786003)(74482002)(1076003)(356004)(50466002)(16526019)(86362001)(6666004)(53416004)(14444005)(107886003)(478600001)(26005)(186003)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0601MB2146;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5bbab8b-f647-422a-bf7e-08d68ffb5fa1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM4PR0601MB2146;
X-MS-TrafficTypeDiagnostic: AM4PR0601MB2146:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0601MB2146;20:QaySrzPlhZBe7x3L3WUnD91O2PV1g7IbAqZqpBqDBmIrYL+hIRVrP4ehEAeFzSGi+XeqSQLl3xHUMHbKhMKuC84bK/NUUwS/fX04EtsDqbg7COLKTky35yWu8Ea+k3a1XhgLiAeojLSro/JDjgZyKnLMrnoqC9epF19DteWXjXzXVvzbcnosOwAs3CBAwYZOnxcLY0Y5yxtwcJ/vT3PDYJhd8N03VJMkDBYO2HZPv5GFKB1Z6vDmujgZ0pfxni/0qReT/cgf35MhkoXrwmstQoRB4xM3pdNIPsdg3YXQy3a408qQ2f6AkyO5NbJgsumbC2Gzm2pttCLVT6pto7zsGJoDN/V6Lrf+KboZoOa2ll/pS41X5Zhv7d5yRi41ZJRlMg9hY2r2R28TkfrAOl55L7OGuuxRPv+y+2MSMBvYEBYesVdHA2BC0Z/02/k05zYgRLG2+/8ph+dwt0di35B5ukr5WJoRQrJ4kHVlCokJg4t+QZ2udNDaq5kA0pXe7v+Y;4:XvuabTDfZIaeH6VweHuevAtkcTQYIEKK6dzHu4CtUydn9vJSqCfOSPYacFu2fS6FHwM0fCU2oRfJS0WpGvn0pZ6zAFUkgtAXU8OCDq5HgC3ZmZHaqafZUTEMncaiDASFPyI/Bff9DtDoZ8FqQGzYtHgKmaSp8Fxid3LTWkcK2eRjo/YJpZ15PAzvM6T4Q2GzdcoiYXFsol3v/5rG0mG/nTHXxGVyErcGS34u6zaSeoD2zLS56G+PFp1ILaIlnG9JDijO4/GEbV1Rt1xXupurzxScuTluL3L4KF1eEZ28IYMglbU9HBKERWHyxHIejOIq
X-Microsoft-Antispam-PRVS: <AM4PR0601MB2146E1B74B91A946F08793A3EF640@AM4PR0601MB2146.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0945B0CC72
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0601MB2146;23:Nu3vFwSEd58GMPPWwSMcjCYMBM6/zDkOn6aZvcy?=
 =?us-ascii?Q?cUl4/ocuPQ7x38EGRaY+RWC7zuo/stFQKYflDgjc3Ag/pAyDLG3IU6Yv9Ade?=
 =?us-ascii?Q?7tYdHKsdok7Ax+fOpBLZaUc9+iQmFeTfaNqnrTbP0F4lm2IW7Kt61iebxrro?=
 =?us-ascii?Q?6k+TEyHKyY+0uMnCm6H/dfDrIBJjQKvdiGrEmmecaOdzgHwa/jBSG5CD0LDI?=
 =?us-ascii?Q?CjQbiRElfsrdZ8HpyRkWG8MsVrgmM7SN1ydTOoaUcB4xMGdOhCge/EVV/2eQ?=
 =?us-ascii?Q?8dgyfa5Zb4Kq+5M5dMTKjAMYzlhSs+/uP6xcc897AlDMkQg16RDy4wIbD0g+?=
 =?us-ascii?Q?TMFrbGBLf8Up4AFdx8Is+i3dH2PG9JiRRK+44yv3wnXg2qr7XNFo1S4KFXy3?=
 =?us-ascii?Q?W8QcMEeoZepYVU3kHi2YEpMw6oYwHvm8EHI0ZCfTKiZ6GpoOsYfy8tTu/Jqt?=
 =?us-ascii?Q?1vWX+eHiqV5Un+V6NBtLpqUaE/N2INIhIfve6vnsTcNQX1tzZPLTncdolePG?=
 =?us-ascii?Q?E9ufzhY4NWak8QNaSC1XNm0oudSuXc58m0sXnzoWqoJF1z3cU+mD1Bzli1MV?=
 =?us-ascii?Q?y2VlY6kXsvzX86g0E+rLja6kUFXBRsQFnKKdWJZ97THFEPE+mIec2R7GuEYH?=
 =?us-ascii?Q?ihL2yDx5eozj3rA78yW1Nc76w95l14SF+NXod/3FmZjGvfcbksH7erQkkQii?=
 =?us-ascii?Q?tfSfvdZWdWS42MJNfn4XOk3nNs0XHr9QegogQzcSF/LxbQYF7N3fC/Nw/jw5?=
 =?us-ascii?Q?fez2dzJTSr0lB+i9jxMS0SDa3sJDEi979BpawQdv2u1rzqeSLdmEpfrENDzV?=
 =?us-ascii?Q?h4cbbnH9j8sLFXBRj4tun5Yr8jNILgPwzprS71TqyX85vwXnpZCX+A4b0rFJ?=
 =?us-ascii?Q?ciNZDDe/D5nC5ZQrb/KsarbE781WEBE083k5VGjSXX7N7+q70bG3pGn11uTq?=
 =?us-ascii?Q?YYBTwxZvF8dvFQvK9o7XrwF4EbK3AzwBQUlUc3pwg/Axmla+WEdxFrxIRSGi?=
 =?us-ascii?Q?TElLm49auwDhM4j3jGSnhsc7v+lUPqrokWEJsyoa2s33uv5fa0K9HzdGR4Da?=
 =?us-ascii?Q?kBJLG3KxgMkBUlbrkV7oUVjTnAQpfUZKRAYXkM6ao50cRmjA6d1WhyyvO6Jc?=
 =?us-ascii?Q?WA0FRyacLuMzA1tHU9EzZxrku7x/0lKC9s+TbyNoEe47/F5yELpQh3T7kYff?=
 =?us-ascii?Q?ySKTzRuHwV84RXRRToPmht0G3sX3DkIIZgEv9?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: oGKVJK1u/dzv/x43lGpkGT+SYKZVnm8OLlbjhpGtB9BUmpDIX94Po2VydraGJb3pl9sxu+fyzmeuZsIUm/zQG6ravfv3bw2bFFk4j25cE8xIPZf4ZEC4xI2S9a5rrXnF1Kuzgb25GDKQqRzzjQWUPJ5A80u0+fU/KvIh0rRvn0cfpvQXm9r0nhVLVnkHt2Sz1Ru3Oqs47piTHKHYrbrKBqF3M0v4uqFqQAdIucvnBCTNprZ14U20aSkRFgn+wrBsRzENAXsQHZwt+P4UL9QVnpC5buUteJ8ycGb1/Uxp+XjtNWett0wAz5vlUIf1pGNpf9htAG/1cl2CMiAlyyN71c6Q87SINTWcKRwhUUXc51pF/2PMX5cbV/LdqPikStFTAw0MD4KGZav+FOklLJPrPJvRynSl0C14Ir9BVaW8Cyc=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0601MB2146;6:3F9kjg3CktNY2PeH86bdZuXlPqq24bdBTxcmQbNHILcye1BR+S/dkqX1QKe82ei0nbuFw5qij7yTVeJHaoyf5daB4K/syVy1BJF6k34OZFHMTm7t98KfWldDWPJVFWESuVXxkdTuJdR29e4jZ2LrRN8ZY0agQ0fz3WuBcPaT/cTIgdLdt8M3oH9p8funPrTf0Ltlq7es263beWJDmkrgPISVNTv1JyM6qkJnAdcg23u4Ka/lwZgZ0PPEVEKHfnrEoCn7Txt7CP7RwVoIBmq9Uw3PdtXgnQTiODh/5/WMYpjMFa/1LhUY2YgrAXNxL7QZGUz5pYN8Viv/EEMim6AX84MTT0ziBPf7MBor+gQEl+DH2NnpTl0vwPZCvF15ygoqydENVrrjZIKm9l0FaQWbXlQUvZ9oUA87MTfNhynZyItStFNKDAueSXb9YTFndZPeWp3/rbycO6mmaKK3+6l98g==;5:lBwY/Oy+3il7jD6uR+HKPTJRvVOfaVC+Bvj4GpZvyIV2m5fHr6/xrLHgcaCcfRu0h7UfKbc5ZjqN4UNM7C6963y0wzzhhCbnjR9kc3FgezEVBafFuxYUhUhjsV9DT7fWI0cp8TQNZNNMTuUGP/GtmG3BoufjdjEjEYpsigKSK6avsquTCnkCHGs8Sb5yFJNONgH7jrmHPs0jpl7SQcxwLQ==;7:rePxF7Gj0T8H/jusM0bXugVCbi3/EAZpKuLI8xEnInjKl60SaWePkF3CerfobDVfgG94WWghJMtcfhLcKt9rvwRl6q2pgY/DUSSosvfwMIA1LV5kl6bSpQsWj7t3GjGF/Zffx/9y5q0iBIeHXyxk4w==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2019 08:31:52.0980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5bbab8b-f647-422a-bf7e-08d68ffb5fa1
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0601MB2146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miscellaneous style fixes from checkpatch

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>

---
 drivers/i2c/busses/i2c-ocores.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 5b80190..ba35d2a 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -182,8 +182,9 @@ static void ocores_process(struct ocores_i2c *i2c, u8 stat)
 			oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
 			goto out;
 		}
-	} else
+	} else {
 		msg->buf[i2c->pos++] = oc_getreg(i2c, OCI2C_DATA);
+	}
 
 	/* end of msg? */
 	if (i2c->pos == msg->len) {
@@ -202,9 +203,9 @@ static void ocores_process(struct ocores_i2c *i2c, u8 stat)
 				oc_setreg(i2c, OCI2C_DATA, addr);
 				oc_setreg(i2c, OCI2C_CMD,  OCI2C_CMD_START);
 				goto out;
-			} else
-				i2c->state = (msg->flags & I2C_M_RD)
-					? STATE_READ : STATE_WRITE;
+			}
+			i2c->state = (msg->flags & I2C_M_RD)
+				? STATE_READ : STATE_WRITE;
 		} else {
 			i2c->state = STATE_DONE;
 			oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
@@ -405,7 +406,8 @@ static int ocores_init(struct device *dev, struct ocores_i2c *i2c)
 	u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
 
 	/* make sure the device is disabled */
-	oc_setreg(i2c, OCI2C_CONTROL, ctrl & ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN));
+	ctrl &= ~(OCI2C_CTRL_EN | OCI2C_CTRL_IEN);
+	oc_setreg(i2c, OCI2C_CONTROL, ctrl);
 
 	prescale = (i2c->ip_clock_khz / (5 * i2c->bus_clock_khz)) - 1;
 	prescale = clamp(prescale, 0, 0xffff);
@@ -462,11 +464,13 @@ MODULE_DEVICE_TABLE(of, ocores_i2c_match);
 #ifdef CONFIG_OF
 /* Read and write functions for the GRLIB port of the controller. Registers are
  * 32-bit big endian and the PRELOW and PREHIGH registers are merged into one
- * register. The subsequent registers has their offset decreased accordingly. */
+ * register. The subsequent registers has their offset decreased accordingly.
+ */
 static u8 oc_getreg_grlib(struct ocores_i2c *i2c, int reg)
 {
 	u32 rd;
 	int rreg = reg;
+
 	if (reg != OCI2C_PRELOW)
 		rreg--;
 	rd = ioread32be(i2c->base + (rreg << i2c->reg_shift));
@@ -480,6 +484,7 @@ static void oc_setreg_grlib(struct ocores_i2c *i2c, int reg, u8 value)
 {
 	u32 curr, wr;
 	int rreg = reg;
+
 	if (reg != OCI2C_PRELOW)
 		rreg--;
 	if (reg == OCI2C_PRELOW || reg == OCI2C_PREHIGH) {
@@ -568,7 +573,7 @@ static int ocores_i2c_of_probe(struct platform_device *pdev,
 	return 0;
 }
 #else
-#define ocores_i2c_of_probe(pdev,i2c) -ENODEV
+#define ocores_i2c_of_probe(pdev, i2c) -ENODEV
 #endif
 
 static int ocores_i2c_probe(struct platform_device *pdev)
-- 
2.15.0

