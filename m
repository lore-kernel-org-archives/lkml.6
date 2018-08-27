Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD375C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4962320898
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jnE58pGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4962320898
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbeH0QTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 12:19:30 -0400
Received: from mail-ve1eur01on0045.outbound.protection.outlook.com ([104.47.1.45]:32640
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726887AbeH0QTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 12:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pg/38k70IqRSz3/dJ6abmIE51KLROzWljSgrIKtb18M=;
 b=jnE58pGJZA87OP/biUsmBQ96owde6PrskNG5hu/liorX+p3nDXXX5L4BuhBKzC0PDBCboLuXXybsxf3Pa7DLOf72Nm9dxlc2ByrcWAYDNFVAvaZgNQzW386K11m7pdzKlWRKotLVmsMlpFu/rjXJ/ykasGGkqWHdLvHj1YnwLec=
Received: from localhost.localdomain (95.76.156.53) by
 AM0PR04MB4289.eurprd04.prod.outlook.com (2603:10a6:208:67::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Mon, 27 Aug 2018 12:32:56 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc:     Peter Chen <peter.chen@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Make usbnet drivers builtin for boot
Date:   Mon, 27 Aug 2018 15:32:39 +0300
Message-Id: <ab02224d560e09e96af2e41fbfa155e40e8bbb75.1535373073.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM3PR05CA0091.eurprd05.prod.outlook.com
 (2603:10a6:207:1::17) To AM0PR04MB4289.eurprd04.prod.outlook.com
 (2603:10a6:208:67::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0ebf11b-7b78-4e03-333c-08d60c1937b5
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4289;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4289;3:aEZtscp0sMKM8Vnom29yXZqQG2DZd+ztoah/9Ucd8DMKKwgBVBnLPYi5DNElnnx+/HrWJs7zJbWYVI+r09CA8w5OpjzocuAD7ri8sIe3rL9CPa5UfV0Lp889GJCCShSAao+myuVHl8p3nKkaLkmjj3oRgFUQW5XMY3br62A8wbDpcvvXOUvO0bm0S0iZwBn0jdA2NqVUh5IzThdFghdEkE6ZeFm+VyXqkWoMrk1SVQpHJv6K/ipKzTu3VA9jSlrW;25:uikMlROVfg8etHPdP4hhCu9RbcrmV4N4OW/akIi6G2qNSn8es7aBfqoEwUm+n6IDMTXaUKYfPoMq5HHj3GLpkeRgH2W1xxAeSI/r9TcpCXSgZUkO08UVKoQWzYnox2dkqPxJAT2ZJ+Yi0wUhek0RojMlIymQUPQhpWYMKxVPvTTY+HSwi5yBq6+qwVz+fkUbWPPEG0gcyVL0TQSN9CqhkOZwZ+F40MY6mCLVD7Tph7oPEWjnCO7VuNHRAPmY4z+RlhoxUu9xBKQa45hBw/dBmYf9+9EP6R5io7x+8pCPGRfpNTwHaR/UJ/x54k9ckZEy/OcjAyV8DOKo8RliZIXGmA==;31:M4JWQggeCXKi/Uln/oxVgGJ98DMFzVm+TlxgbRfCxIw/7F171B3W0QVeZnKFTZNkNXpdvkL98K0lFZlvZXXC0OGcRQAJCSy5XYqstI5oG1/9amz7QIJd95mGXRWdf9oczLzs7CNqHIfS7dY7DJ3f6J1wePk48H+MOJ5F78m2yxjdrgVvJ/eCiIs5Xpn0fkHyUiS5Pb0F0B//7HNC91ssOKXktEkP1fEBS/8AGAbQb4E=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4289:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4289;20:U7N0UQztEkuxfC0GAjrpU9OHsBdds4CdwONTFI0io4P25rUuo5NWvhRdNAfmvvPi5D8EVLfOZkfbMX+kE6txnNBzFAYicHn2qUrxrzXMLesTcmud5JrRUP7u68d7o7858aj1FoOauoVvoy06L1o14FPS99STtjeTcwL78sE+bopwrEI3GtHfv+mS60V1DqiKMlNpleBb5uPVV05TXL6bTTwM/KIH2UtxYtXWQyH1iMy/gQHlmDoR0hhfNiyXzElWsCnPYKzLI1TD5osimIcXziTPmxhNF4VUsrR+jTVNmYrWuAykYfGtqQ3jZeuWwMfIRMBGR2Pxnz8suSYNRpK3Lk0Pn8FIki60u/qAPheCNZn/cih/seFsrk9xa4c518RJU5g2gVIo0ye1outm7be0pQrtHrkb8r4d0QIX6PUjyfaxnQR5gZZWlHWQI7c+jJnQ8ie8/Vjd1F1tW7BsFKgKOn/fariTLm0IggFecb4KQE6BJEv+gAZ2yOrp4SYkZFvG;4:zZwmk/XVc2OOqoF3kmsSBltEfFL22vMkCfsvwxDHtGhvulGpnfigqWO18FCz/u4hp1BIOjzEs8W7vXr8bC6RADBt3r6bKzErC8OySu/wfFU/GW26AlO7gV7Fpy1rL1qUtxFK3aPs2K6ZYjQmccT+XD9s5OJoQCpx55HKOItWrZRzDJ4yO41kppPRPfIc2UksyL8udR4EhkmzrRDNgKRPoF6Hf8uCrjVbZbNXcvkSsGhLeBnE5NcQtGDka3UMrpxxbukTUc4gFdZdoNAuxeNhPb7AOHOiJtX/mL5/4MjPozADf3MP0Sapaq13QMvBvkxX
X-Microsoft-Antispam-PRVS: <AM0PR04MB4289A3B1C9E80FF8EB87B693EE0B0@AM0PR04MB4289.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:AM0PR04MB4289;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4289;
X-Forefront-PRVS: 07778E4001
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(376002)(346002)(396003)(136003)(39860400002)(199004)(189003)(25786009)(7736002)(97736004)(305945005)(5660300001)(2616005)(6636002)(86362001)(4326008)(6666003)(36756003)(478600001)(6512007)(81166006)(81156014)(8936002)(53936002)(14444005)(68736007)(8676002)(110136005)(6486002)(44832011)(386003)(186003)(16526019)(1857600001)(47776003)(106356001)(54906003)(105586002)(50226002)(51416003)(52116002)(6116002)(3846002)(50466002)(48376002)(6506007)(118296001)(66066001)(16586007)(316002)(26005)(956004)(2906002)(476003)(15760500003)(486006)(69590400005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4289;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4289;23:44xwUbVDTO5+v3p5+W9QAoSm+nJ3zGjNw4tGen2ZU?=
 =?us-ascii?Q?wAlPMR9YK2bt/W6O6pSBWWqgkyPf/GB0J8wj+x4lGPe2WVvA7sqQV2TWoD3d?=
 =?us-ascii?Q?1i4NjT5Zp4c185MH1psecQjdWIS0Qo3MibtHwQcgsokeWcSurXk7EjcB7tP2?=
 =?us-ascii?Q?1jr2hDDPQhfhbAyOUz081OiFsFSEMmWyrT8+bW2YecpX0rECPPGr2KtAyjtQ?=
 =?us-ascii?Q?JnBDz2N6kdFVsIRaMhG1YJm41ntvLKQTZQWQVC2r2HXs9gOvlu5TmxaRgtV5?=
 =?us-ascii?Q?7a7LaGAZwtanEoZNU+BspZuW4eTdb714kNRQUms1TGIvmHJII25sWF6svOp5?=
 =?us-ascii?Q?BLE1b9vqE4K9ESgIv/VxIKQ/LfW6Iswk/nyyHOQ21Ar8D2K8rp80/SVt82WS?=
 =?us-ascii?Q?dUlazkiIdGs9/i1dO68S6Rt9yIgaxc0HbPDI2XitjNEfBrpcrzhRYxUi99pE?=
 =?us-ascii?Q?P8uRixovWuV4TZtBXa3wzoLfQS+vHzWsfQ8DtqMYSC1LxcpNBD/R9iIH+Nb4?=
 =?us-ascii?Q?HSpOdUYJwGD2uxjYJK0v2YEg5lKnGzqsDj4C9C+Ddy8tST3Pg0PHflE2DPA/?=
 =?us-ascii?Q?QqLOdlMMPTDLo9hlGOgiKgw/9/cfcIt0fFfrUCCxZIYlNsdhDBY57jGm/sSe?=
 =?us-ascii?Q?3ypb+D4+ArfQt0L/TL1EfVuVC25brxUgjRhHChkBaQ9IpKoEMLVFhCvIBW2Z?=
 =?us-ascii?Q?o1RES31Bnh0pOT5WtC3CLW9ww74tgdBgauB/7l/RabET8wsQTW7BIgMD/ioL?=
 =?us-ascii?Q?2wLH68rWI7cpHQsv8f+ZeOcxt90RtF7BMhg6lPBw/DvyxViriVCca8bLaAVu?=
 =?us-ascii?Q?EDX9Re3aGMiSbrv5js9j1pdc1bET3SWni8OyCHWzbsTlf0RuLRrpJgAlmVd1?=
 =?us-ascii?Q?22cr9sfo0EFMWKWtUx3sRJVbQ9tsymAKnTVxx5AySEFGkvXmg6YIjalPzOyL?=
 =?us-ascii?Q?Crp1jOmM9Lhn8G96kf84XJZXn53+NSqXApZD7cSTsMCI6XPT6IIw/8aywe4e?=
 =?us-ascii?Q?TdcQ6UjJRnNWODGteM+skKLz8vFn5CNzMMncxFz7E/eFxHVWlZ3+IKlyaPKN?=
 =?us-ascii?Q?zaOZ6fpNo6pL2U34/+6bcDn/AMzFRJRBUTZKjDhqRPkr3LnaGBMZInH9Zx3c?=
 =?us-ascii?Q?D4uVK+4CXvA+885fHvvMhP/Ej/X3BkiPPX8qy241UvikzAllXlqyG2cSbikp?=
 =?us-ascii?Q?8dlGvEII06hmfs22jU2wwMuDaAiHG9gvMqcdgE0K7my0n8+3O4djLgniToEf?=
 =?us-ascii?Q?QnfNSoAjxG8SEr6W1Mu2bRnnnKUowFjlKoNlf8cruiozw/93T7OQ+2tW0HMc?=
 =?us-ascii?Q?A8rOxgyjxZV9bxseMWyVgY=3D?=
X-Microsoft-Antispam-Message-Info: puRwUcKcss61RRPmsGvZd5Ngjwq4QV+1o3a5NAylRY4gampwyEuchytDBdezb0BLpjEpj9hQst1k84Yw5NhFaIeYymjACH5/pCr7B03v6Mr5pBBcbD3nuMWocA5EPG05O4lTuAYKfY+gBK0ZYe2rUiGM8KN6ANqRhxlqK+jFrJqzACe0tgHbpYjbUwbnY8J2UEQlqlUgmhpGvd3nkpyaKhjD3xkA6kGpK4FSdPVBTHs3xen76U+0+cYHHVhSY7Ih6AjR2VHaisXMesrowCtzvKiQMsQ+bfvFozkPdPDsnqN1fJz/8TuL2dKftNf55WIimMVI++IGOaCHRzyuan4PowOcCVeTfHY0hJ7ntKJBEyM=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4289;6:QXoN3PL6LUlQAwBjcvH7y5DjlDzqmr6m41xnoUPfijxWAYUovHYHuEDL6bxwHwQPiGMiWt5SDRtE7alRAmsJjz164DJYu/b6mYIB6NPdq+Ukxz1ssYmP2251sEME/ADmaw+rTN65VqeEeYd7b+yXjxEoSeFpEWTHmHln7b56Qbpqi8b8h+prd92F+mPq1nqou9zA3NJPQLa+6alqCq4C1fPws9KT6YhaeNBOyCaeMLrOBUy6D6UCdcH414XNF9V0e9oX8hNB7AnxLH9N7E22MyzEULGffdwog18AD1MgtVZlngD0blwzhIGcWMpK5zZsnJu6r3+SGTD8aoSzMWRCdDTYQNfdYKfq77WmdNiGKqc7K+xFZJkEZdsxyes/z+nin0VRGdRIPVpdYb02OqlspVB4qViusYpM1lVvE3ui6HbBzJewQ+5TRcMsp6yfpwj/MraZ0lGY6kVfCKGOXx97TA==;5:XW1vsRBheeJHl6YcBg4hJL3u/zL+Ar7PaPHg0gdJv2S2fuVnhBf0Yjhf6sIwmKuYMykefTheXc6B/9CfXG6NOAHxgPg/jGr2EGYSP0jkNiFP37gHAUEPPGtPbklwfIJd9ogMw6y9D1U6G2fVp7kmctJ1+yuGBTQLalnfGtQzfrc=;7:LN3waqqxAiJs715bUy0tcQvxc9yPNSIA5EQBwiy10Xi8kmDEUAXZ7vqkLcpTm9QCFcomZ1HRVaz+AUGJtPLb7VNULs4z37/v0hdU8GXmZ+aUpdVCi/DGkSkGPbGy+lsBt83JYxfe9Ju1zlm0/xFKyPoRABMrw7Z9Nt/TjkeqOIUaW53EsoF7TwqSqIXRWbUZSbeT+3MbPdzF3eBPCorLWHDw1nK93qw+CR+DWTMxp2YapRIi2e8G54/o1rRd2iyl
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2018 12:32:56.3154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ebf11b-7b78-4e03-333c-08d60c1937b5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4289
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chips such as imx6sll and imx7ulp have no ethernet support so the common
development usecase of nfs boot is supported via usb ethernet dongles.

Add drivers for additional usbnet device directly into the kernel image
image produced by the imx defconfig.

This list is based on the usbnet devices supported by uboot.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---
This is not a very pretty solution but very convenient.
---
 arch/arm/configs/imx_v6_v7_defconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index e2c127608bcc..7474bb5b3a6f 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -147,13 +147,16 @@ CONFIG_SMSC911X=y
 CONFIG_AT803X_PHY=y
 CONFIG_MICREL_PHY=y
 CONFIG_SMSC_PHY=y
 CONFIG_USB_PEGASUS=m
 CONFIG_USB_RTL8150=m
-CONFIG_USB_RTL8152=m
+CONFIG_USB_RTL8152=y
+CONFIG_USB_LAN78XX=y
 CONFIG_USB_USBNET=y
 CONFIG_USB_NET_CDC_EEM=m
+CONFIG_USB_NET_SMSC95XX=y
+CONFIG_USB_NET_MCS7830=y
 CONFIG_BRCMFMAC=m
 CONFIG_MWIFIEX=m
 CONFIG_MWIFIEX_SDIO=m
 CONFIG_MWIFIEX_PCIE=m
 CONFIG_WL12XX=m
-- 
2.17.1

