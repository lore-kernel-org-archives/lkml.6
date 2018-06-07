Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /p8mJetkGVsbfwAAmS7hNA
	; Thu, 07 Jun 2018 17:01:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A29BC6089E; Thu,  7 Jun 2018 17:01:33 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gam/IQSb"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7AD7D608CA;
	Thu,  7 Jun 2018 17:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7AD7D608CA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934524AbeFGRBa (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:01:30 -0400
Received: from mail-he1eur01on0075.outbound.protection.outlook.com ([104.47.0.75]:64255
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932989AbeFGRBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rBcArwAb3ZbAHSPRnSh2bkIyF1vkxzPPdI7qzJUyxs=;
 b=gam/IQSbxv5h6OP1ohddcqfwsq44UMv4TMZLdXgERPFHwFxE9ywKYqKZouChIAmFYUF5EhQ4plF/17f3kAvWhBqBaLLuz4grFg3/BG5BVWqkM7guxL0QmSjnvwyRMyW9uJxz1xj/JOu+JCnhOBEFsIhckrBY2kk/oR+JcXfUzeY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com;
Received: from localhost.localdomain (95.76.156.53) by
 AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:67::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.11; Thu, 7 Jun 2018 17:01:08 +0000
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
        Steve Longerbeam <slongerbeam@gmail.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] imx_v6_v7_defconfig: Enable imx6qdl-sabreauto sensors
Date: Thu,  7 Jun 2018 20:00:56 +0300
Message-Id: <70b90919f98a6941425b39065dc8d37c95f0fd9f.1528390418.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <b31ca3ff50566c193003614d0bbf5e0a0e95901c.1528390418.git.leonard.crestez@nxp.com>
References: <b31ca3ff50566c193003614d0bbf5e0a0e95901c.1528390418.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM6PR0202CA0017.eurprd02.prod.outlook.com
 (2603:10a6:209:15::30) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4290;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;3:sjSjF4TnfLqkawlMpcXAE9YkvbauuH9FQFhUti9nyCORYOymWQpaIqFxggV97Yi6n06vfw+8qODOiDRkiNnNXEqY1eUZ1C7zd0dSYHbEXjmxO2ISf+HZX3OPPtPTDH2a8v37R0+Wl80VsauYLdw6HRnpbo4c9qRL8kL62Vvk64W3QR6Go+tP5AtJKwE1+XmNRz7SpfEQBTCQeSuuI//3CDKbOe+8FpiAQdHa5nhbvA0KTOGhJnbLoRWPTcCHnSWx;25:ytKBd67qTTOodceFBYRY4Cyht88+mTTZ+jzQgRDO0SFGp2pPkiFj8Hq6lTK0e5t7xO+W7xwTXTipj2rS3v3aT9FaiRkuwQMwfV/QPpC7SrMvVEA7felwys5yyQfwI7IC2BleZwL+e+vu5N4TLRix16D2B4Yx26X9uL4kOX/69SqlMcRRtZxiC7/7r1RWiwNed7ziBLLQFB2ERnr/58nThm9XAhp4lEm3EOwUdcWrHB3UKUHIyH5W05MzX4XnAlFFbEXbSzoj4732aHTHmIlCjxNzaFdnn5+vCq/i+wrvfJuU4hFqqjtQleYA49rcW2IDl7nGUDNsTPfQuE4dt2rRpw==;31:DafpulmmmUeqHwJunFKSS0l/+8bdDIcioIlDxzP2HirGHExMk16/EyDkLultUUVKEPwCXjPc7PRneC3EFG5SioEmXxIi7NjQeYpAd0w5cSfhz7GwUHdEViTt97HYpdt6IhkrgkJMPC6YXgp0KjGpEXyogfLJFQeGpeeLkdMOQNxZhPmj1GvDS1S2dN/xe1HljA4NlWreGp8Ac5DQM1AGn7fnKZWvhGUNaJ8iihiSoQE=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4290:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;20:1tItxCroDRxa65cXSXs/gYQ/ZrgFA9qVNNXno87eYfM2wMuotBu94DjhbvfH4gHbc3XZuFE5l2L4QGbEcrFtCPcBCWpouBLugnwgJCFnXsycbTrad3j90dTyyHnNeB32IscIXmSKxZd9UL2eR0bgEH4u6slW1wPpj3DtCjG/vm1OiB74zmnSxFVV9KhiH0H62j4mIZXTzBqrJ7p9JIvZxup296o+SBIXvOGpyZVRV5rxRAdVXDSNT1DH+tSepTkGHQAFhHxLuvxOVIvLOV0RBa34cv1QV+SdONbI3oAKpaLC11xrRSOgvdflrNo5tcP1UCig5JmhO1Wdq+xf2/x0FHBuTMjNzEEdw9wICC9+Y+QFWM4a5ycrx3qpXWfkaZEC8BIzvNxkJDDXfEajZ1SFWNFEu9axTFo6ONhX2S/XQJVYKcfzO8roZhYrgB6XKO/rKjbzQbPbJSiRMxBDxPsT+Ie5l0kB0uUdGlNbE0dsI7H50V2P1TI3VoV6JQCEJLPv;4:KAjOB42okAVHAohnmFDDg9erQPEEecOsyEpRfpdLb7ViVrM6VnoTt0e+Vz2VnCrd0ey/R5OX84IcWDwdp9PDDiOfNy6Bc/LCRcVAHJwIZI7bJf1Lytt1Hl/dldYeuAcFTplCf/sgzVxqcNV3qHABGJqk+B+DSYsRuiO8UBeF3cYovCPnys8lMl8SdxbVSud/cfpPtFb49C/wmpg0vrwISXCn5+favTjPpcYYRDYUUcH40yeNrVyvpYlj7mnotTqQik17WZJsCcpYF83ayqHyr6WFHKSzBKqCcITGwchDKIlT1xenyRMPa+a1cGFbOKkR
X-Microsoft-Antispam-PRVS: <AM0PR04MB4290026254F6931B4C9B4D10EE640@AM0PR04MB4290.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4290;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4290;
X-Forefront-PRVS: 06968FD8C4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(376002)(346002)(366004)(39380400002)(39860400002)(189003)(199004)(48376002)(2906002)(105586002)(5660300001)(81156014)(6636002)(106356001)(305945005)(97736004)(76176011)(11346002)(6512007)(118296001)(956004)(36756003)(3846002)(8676002)(54906003)(86362001)(50226002)(6666003)(110136005)(39060400002)(16586007)(7736002)(66066001)(44832011)(68736007)(15760500003)(52116002)(25786009)(186003)(16526019)(51416003)(6486002)(53936002)(50466002)(47776003)(486006)(8936002)(6116002)(26005)(478600001)(446003)(6506007)(4326008)(476003)(316002)(2616005)(386003)(81166006)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4290;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4290;23:FKQ5fs2nMrGUHsnc5gfx8jF+jh8+l+rfF7BorvaoO?=
 =?us-ascii?Q?vz5/eucoCPUKCNQtXG57doTe9wbhAtmDObpGfVKzkHWgy0WawTryTO2c0A2r?=
 =?us-ascii?Q?a3ytUKmd7U8lwyTOdj4ysrpxuBsZJpfkoVCi89wsVnuREas04YxaRfDxmQW+?=
 =?us-ascii?Q?17RihmoDEs+qoMjrzlqvtOgqRUL/323eJeK7OgmktJdG1vFQ3wPQynHmBbIB?=
 =?us-ascii?Q?i9jMcvB4EZdlQ4fMnfFZuwSNC+doB5RgJPy5mK/svSItwKS4xCzw8vbZLimY?=
 =?us-ascii?Q?p+YKPHg6JnOqxLbo03ylY1+MrxKzjR529unpZzLMLPMxW8B/lj/eaiF4plu6?=
 =?us-ascii?Q?2aZwsidjbtNUJblwRUOsabnv0biC4o3MHNaeqcbFPRzOP5ed4NNWCHWAHJV6?=
 =?us-ascii?Q?Q7Jy6k7f5IbnkcC0sqsZL2rcTXupxkmzkceCvZ/pmJ7jKzWGoatA6BWNx/88?=
 =?us-ascii?Q?4KDCyinNJfxE2sw4Upij35LHOywVxK1tKCgu/v1yut53cTdlZcx7Wuk7iggp?=
 =?us-ascii?Q?nSoE506ZcZIcovgfJ2xTcNp1pFRbtLObv8DUPguC/Cp+wPtgU9SwS52AYTyJ?=
 =?us-ascii?Q?Z2yiY4g//KD+LjAIVrFzlu12B+tQk1HgAN0qAi9PWDj83YEGItxhmxWDNYce?=
 =?us-ascii?Q?ruj6Iq0mUgEVbs3CSUAR/YecOupqQNjkF3I2BAtXANMxpPmnACWG7Gt/EExR?=
 =?us-ascii?Q?3uUYxGlbX1YmIS0MsVHd995TXoTUYD0ECpibVkmq9DIm1upPfMY54ThjuzzU?=
 =?us-ascii?Q?zyxDsrxRSD3jQ3hympyp0DznrHlNYKCX5FTUrBzt1K7us5zfd34uzRIzGT/c?=
 =?us-ascii?Q?aB22HXlFXfzsRiH0gSva56xT8poKTZ4jijmEtU3PcnDK2nIu4aH+85gowD1c?=
 =?us-ascii?Q?GCapFLZqxHYZepVUo3dEckfY0rYGHr3UIpxkcX8Z2rNWLJme2ERnRbaKnazA?=
 =?us-ascii?Q?ETOpSb4WpNhqiAfhgidxFcybh3BhUpWWtQfeSU0kIf8GewF3xSUFjBXYdMiR?=
 =?us-ascii?Q?Y4DEgaFk4B8m/obACbOo71LaO1bQQnnjzWEridUOQx9L48OOtvATiE18ry9t?=
 =?us-ascii?Q?M7acx/DV85QC7lDofa5ZYF7QrumP2p12mJUc7llzfEwMZ2NqXIAJnz++vSqp?=
 =?us-ascii?Q?4hltsCslzwdLZngasijGZJLeUFMNyVFDdsux0+E4wkDZ1f3Nsd3Xxq5MFN2K?=
 =?us-ascii?Q?/964eJRyBz+XS6kPg6LWMqp7fpTHTqR1QGoJsIbS9ghmtrb6ZOHIJuKLxjCA?=
 =?us-ascii?Q?8FxbBVyXQzEu34Vys0QSFk1j0Uq8vnJ6Bv0TJD3y6obB3ffB+eaqjzKnS4jo?=
 =?us-ascii?Q?YDmOi4L9LVuVbP6UnuvjmXq2ukVw8xUrrSvCf5RfUBDnJgcLHFc5CSY48A5G?=
 =?us-ascii?Q?KTnaQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: FRC/+9Oe50spkOLQgL7I5dOMlhpJizKmP0KL7lDQg3yICBlRJEihH/lQozCDFx0zH+GHYDJRUig6nSxexFjNH/8nEYB2sWuTl71oKi40oDxEHlc6ZDnn8nHpqJfWKiHnYc7MFEmoYIno9nKaC+BSl2oncppsaEGDjsVHIvoJKqn8unAN/uQIzTxr6BOOD7DO
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;6:YQ/mO6MX0m2EEzhjJoLisfnMHLoX8wzkXG7pn382F3Xe0g+nU9wlJd6WdYiTV4xPtmbYyRoZ/xYUwJdG9NeIfeI9ggVA9fLXUHKCyB2RQau3QVjDPSYM2coyp7EYRvI7d7O3Uuqjxh5Ip+cMVf/334s6k97Y3S24MhzWrl12/g+jpc2BWTOZe4bIIfn6WrjY+A+3oZRi6mpHBT6L0Fe1rDQIKpHtyxwcmkjPPtVgSjImxCjAWL8U+9MlimRoVVgEMx50MkBu3mIBZ48ye1f9AxhzsBe9uDk9l62q0veIVg0riYIxgaBODEqKhL/xxRu56LP3bElhTVA1zcF800M0LlHdhJNuUpQx4QlWcdsQoh3vKDwWpKlESJdq1rsH8YQyTLPqrsbNQa6ecRTFa7jns2rxBXWiIy8k1TWJt+uAzJWQrgEr8377Frz3SzmrJh/rrcwtxI7sB7rQJErFE5zoDw==;5:X9N/ZZD1lu2mDQZZ55eEbTlMyX+p11jrTY49XgF3DGKmoyv1yrpdRWQy0r/nDVKHbfeJU7toknEp8EtEhKgmLDurStQIyvWR8Z7sEmFePe2kYYt1mxFOSDSxQfCdmOUhNNXMvzZZrhf8hmXH1z7wvFqTkjhWOLRmKM+y5Fs9Fpw=;24:+KniQ+W3KSyC7sCz+KcZG6uj2DAhROe6J3VLVVedEU+wUPDTvnKjdJp+OW70otsJwprzBNNEwoZZrfvVTISG/Eclurc99Vy5XH3euCLJOho=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;7:57ACEdhGT0vMNjnNFP8MMsHeIWffbIwWZNOniYs4vVIlpTWFFeSIksmWIuDnpzMaBw3mRNW31gsbUGravT5SBqI0HWYvGPppbjJRYSZPweNbeKoB74RZUQ8/MC9Z2UFTANhxL1zizQpPbsdHpT0267lpK51/mGIV/9f+gidIMmIF4o81F6jud97+ls0Q9t0+ZWJebKY0EUiojbE5UsXAMwFGuzswChLMRZIIPjdGOGqLlqvLl9Ay0f8fVC40Hd1J
X-MS-Office365-Filtering-Correlation-Id: 1be8585d-0fcb-4d5a-065e-08d5cc984411
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2018 17:01:08.6831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be8585d-0fcb-4d5a-065e-08d5cc984411
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4290
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_SENSORS_ISL29018 supports isil,il29023 light sensor
CONFIG_MMA8452 supports fsl,mma8451 accelerometer

CONFIG_MAG3110 for fsl,mag3110 is already enabled

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 3a308437b088..7efcce8083d2 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -364,12 +364,14 @@ CONFIG_MXS_DMA=y
 CONFIG_STAGING=y
 CONFIG_STAGING_MEDIA=y
 CONFIG_VIDEO_IMX_MEDIA=y
 CONFIG_COMMON_CLK_PWM=y
 CONFIG_IIO=y
+CONFIG_MMA8452=y
 CONFIG_IMX7D_ADC=y
 CONFIG_VF610_ADC=y
+CONFIG_SENSORS_ISL29018=y
 CONFIG_MAG3110=y
 CONFIG_MPL3115=y
 CONFIG_PWM=y
 CONFIG_PWM_FSL_FTM=y
 CONFIG_PWM_IMX=y
-- 
2.17.1
