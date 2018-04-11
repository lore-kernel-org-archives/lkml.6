Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbeDKG5J (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 02:57:09 -0400
Received: from mail-bn3nam01on0118.outbound.protection.outlook.com ([104.47.33.118]:48864
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752491AbeDKG5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 02:57:06 -0400
Authentication-Results: spf=fail (sender IP is 192.88.158.2)
 smtp.mailfrom=nxp.com; nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=fail action=none header.from=nxp.com;
From: Ran Wang <ran.wang_1@nxp.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>,
        Li Yang <leoyang.li@nxp.com>
CC: Zhao Chenhui <chenhui.zhao@freescale.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v2 1/6] powerpc/pm: Fix suspend=n in menuconfig for e500mc platforms.
Date: Wed, 11 Apr 2018 14:35:46 +0800
Message-ID: <20180411063551.30368-1-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.14.1
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:192.88.158.2;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(346002)(396003)(2980300002)(1109001)(1110001)(339900001)(189003)(199004)(85426001)(316002)(16586007)(356003)(50226002)(26005)(97736004)(2906002)(5660300001)(305945005)(2616005)(498600001)(8656006)(77096007)(1076002)(476003)(59450400001)(51416003)(486006)(8936002)(6666003)(47776003)(106466001)(69596002)(68736007)(110136005)(126002)(105606002)(8676002)(54906003)(53936002)(36756003)(86362001)(104016004)(81166006)(81156014)(15650500001)(48376002)(6636002)(50466002)(336012)(7416002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR03MB2182;H:az84smr01.freescale.net;FPR:;SPF:Fail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD025;1:u052xFjSpkTJoRrcE3j4lfBRhBKgHqgSPXFexyKzJUpf8jGYV1UyF4nAPE3/ZNWAQKPok1durpZd+kE/2l9aogSqusUIC9eNlbI9UAbW007vdNciQlP1PBe/zkeL+xTi
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(2017052603328)(7153060);SRVR:CO2PR03MB2182;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2182;3:Lw98qwbKlzqDxY0z+lwpNwmGbTtXKaRnrCloYNiuuW9aPDb4A3kna4kuClD4D83mp8JvWzB3sh8sFpaMVJ+LqxIz8iE/hgUBCxDoxls5WNAOIlRCUcQLywiKwjeKGmGaeXNRJivljw8XWjOsvSLaixyRIvuA1PDiXocPr0q8F5Bq9xdqo5VbDinXFwt9mL7MRiPhNjeHV2w3yQ5OM7pHCSXvTW+lO5tUDICv43/VElG3VC4RCWoqWrymaj8kI65XQVw2Y0iLYbQ8OYEEjaK/0Nkk44Qyvys4mrjqXs//wFzVC88Uw+G6hJVesCd44fwQdVZZsbtPzEmfkjMTpogEXmUPrEYd2A72+M5h0e8TTtg=;25:SXEIpyxtdAM4LHzaRM8Jtnj4ubPFipTk2ApRRndiVQd/HltBbLn94y924T+zXyqLyy8cN3pYvYb6WKGeStwgAWBM5K5zx5duAlKcnHm/fQFyg84yLiobW/wK6lPTbzWEeaQf2IdWthS62YOtOI3v0cE/bOYx06TV4/20zSOYzkF+B5dZtqusiJo4ytgP7XlzuLDA1xXVd8chetrMnBZ7pUhXcIL+DR9LKKuM1+LhheLBPd9E2xgG0LeDnzzEXe9noG/afeykmnR6Ma+kUtEHIZhTwfj9uPmd33OFVIlseQkUTJyULfkw6wX/DkIxbeEZhi1eo4jrUmf6qL1GvQbezQ==
X-MS-TrafficTypeDiagnostic: CO2PR03MB2182:
X-LD-Processed: 710a03f5-10f6-4d38-9ff4-a80b81da590d,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2182;31:+RzKGW++XPmtxy5ePflSdc4eIngPnvlfFJkDrM2a+Evjn9gBUWiqXgvyXkOeq+JD2d5mRPHIZFdAmNAZNx1J/hanXlARQbw6CqfvTPZNbNSj/EEHDF64sH7ldTr6cUYgR4Lhqgisea+jd6uNwiDwLuIWCe20qUkWVmiqZYdyRwU52vkiPao3q2eMbagBCWhHbCVGkzLtgRjbuJveVaBlzLuK+42OPJDjWy5xKs7lpeY=;20:8g8HLYJkBiFHvsbPTcgP4QPPJJcy2zUku4eoM4bBm4qQzV9eOSi4MG/wfUpKxWGGnIGChJq26waJ9RQaF1Qli62IlyMknHGSfHokjIzZaJC3olspp/t8sOHiXptrnOHqi75RxBqPgRzjJy/BUPUvjUHLdkndVBwLfu/HiAofxEsV97LZJ3MqRD49cAccOedx2nJkixqn7zoxaWc6ZFhc6KoWXL39B4ETVWwzHmsViW2CS3wOTeEm0EHctaIEfvezjlSLysnKslRgbc74i2swfoedoqEj3npwpJotrFo/Hq2V0ROJYjhZd0o5rFqkUMHPNh+DX/7ngW++BEIsmsDDIB2dWY2h3kKOVJwcR1QmDhY31p+FaNZNtar9l/1kPgE1RleEwESgL1QdY+xIxs2R19vCaNOAj4vpsuaHfw3dlpvdLz17A8MmNgkl6uSU5V3qJdKIA1ZSLeSdPE+qgFFrnIGQMv7LQw2efvoSGlLApmprD76Am866QIChFzewUTAhkEiIc59iZBT8psU4U1OnSg14FeXSgCIFZNlngK8jCeZ0jUEjzw/DTLf4nNyPfRS0IiQSL2f536hyVVv42aInTEzJjovGUE23eN9ZxgXOhO8=
X-Microsoft-Antispam-PRVS: <CO2PR03MB21825D722DB28CD891CF3C88F1BD0@CO2PR03MB2182.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93003095)(6055026)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123558120)(6072148)(201708071742011);SRVR:CO2PR03MB2182;BCL:0;PCL:0;RULEID:;SRVR:CO2PR03MB2182;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2182;4:rKRR3DxaqcKoUAUs7efXMjFL2bY6bri64Y8EZ66v43TY7pPS+pqevdI4l2fH+bmPtDvSeeLlPDPFmnU3studMMQyBPqm6/Ad5sXaUAVwUAz2W1bl6zgP4vYLkq3dYC9y+kQC02OjLZ6xfeVpXhcT3y6q5/ZWO/M9eBFhlYXWKugRFdF+L7fuDas/lBfst+6AQp1NIkYexsbWccJIUfJZUL5TLV/TF5yFwIlyv9cYflN0h+iBti0pBMj33R/Ir7adyDji3Ow5RzPVm+K+ac0W5b2ryaCwQv6Z+MLJ0K4s1NWv1ROLVyWl//VND+1hL+9W
X-Forefront-PRVS: 0639027A9E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR03MB2182;23:OX2CYmw9Ds1/i71e1bT97N3C9A11H9Sh/S09RJv72?=
 =?us-ascii?Q?9JyIfk7gR+0Unghj02s6PswEvXNT2uKv+nYoFxmFqHixp6A7nxEDyVFI9AF7?=
 =?us-ascii?Q?y6ro6mCOP9o8D/heEfosdRlbsOSVdlLenGiuBWkGMs7z41JW8Zs6vVbRmJh9?=
 =?us-ascii?Q?/myubg/F8Xd/11kX89iVvPcCEmPSY4RLZyUNe43J73r4n9aIXoTGvWlYohnK?=
 =?us-ascii?Q?eWzO9qQ2+ue0Mio3pyMX/KQ245QimAo+kdzcJaTgaNtMUxeXkYdrDA1JTZWR?=
 =?us-ascii?Q?oUwMRQpKobyto6hSOjiA6dzaOY6p3mJVxDKDPafi6WZfL4qAMI9NvIMNvxvv?=
 =?us-ascii?Q?MJ3Ou0irag6RWlDdrpgNtJjUESbIEZooepV67PRxbhwIU6hlP180lduNJiDs?=
 =?us-ascii?Q?CS+Ad3982L2/aY1EYmGWjWI85Gm/JUAw5752ySwOe0Cky8UIhij6FZzZROA6?=
 =?us-ascii?Q?0hADHUWBMCBMehIsi215WH37zmnf/neIWOJuXpQW1uJbhFlqWUbSJixzBboa?=
 =?us-ascii?Q?P1SmlaBJp7/PGgxJaVelbgoNtiWsmSfOE7rHROuCmAxhnGa0jS3D1nX2/UVY?=
 =?us-ascii?Q?UhbuB3yUB43UddFKgJVcr9gpxi2PYqwLbKw8Hso14nCaDrClvKvxDiZNfGrc?=
 =?us-ascii?Q?sCV/iS0QfyJdTHlZD4XmJGwnjGjpKgOtRbp1Ox2OuYpAzScgjZW1uy4+Db6w?=
 =?us-ascii?Q?kQVt5pbaoJiI6nzNClHTzX3WH7KUJpnhjbn2jyrH4iyL6+oJfxPNGRuXemew?=
 =?us-ascii?Q?yeqgXPPDlBlOcXvjXAUSSct66ABtX1ge88AYodAZbSZFZ9hLjcgK6rp0IJ/g?=
 =?us-ascii?Q?u4K/QPvXrHLeS7oEhJjWA/M9G1VOHJAOOBuifrxpDJIPBY24eGmCFA61jr7Y?=
 =?us-ascii?Q?VMYrXbcG983/4eja1ac61VOsMCOj8HOVlt3X+NrrzUd0KAcBJwCO01EdnIuL?=
 =?us-ascii?Q?ARwBbWWG3AmYBqUmru/eAkvvp+Xs4S38sVY9Fe147IL/pMpiSV9vLk/VbDOH?=
 =?us-ascii?Q?1W5nC2MCjbdO2EFU4V6v9Kdokf2xiKJxWv6ILz7+NXdgF7mMQJFemjdGz4tH?=
 =?us-ascii?Q?UJGHTSlm5zYl1xkVLtJaVkgH4x3UOZdYevjAnWvvalW261bEC8KcFrfHAfLR?=
 =?us-ascii?Q?E5d4b+3tcqs9fvD7oQGRIE27BLjJ6Ufs8QJ9NNNjeI81k703XuTTaHuIi0tB?=
 =?us-ascii?Q?6sd9xmubPISbmN0VYDVdEDAhisOaLQIBRZsGEsIGn1Uft1QU+g9uIYRZA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: e8/WrNObs3x7eYv0zTwoG6UTfZk1HXo/KVPTcSOF1YY1jyNpTYyBqFvfN5IvVYUq8K0ZfGCVnyn4rrpPpcrIkdqTRIQ0QoIif3819ZZq0Ha9RYweQ0Ha4jtyWv2BGB01MlAZ0ac6ur/BQEgTcUaU/rsao+tH+tyVC6R16wrCSYFS4ehsiJkQhrbH48hPocU1
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2182;6:1n1iQm6dIPuAawvzbrfp6QDKvI3kdlCU0KETLOoIA6lTjbRJ84vWbKMOhMEMuRXrblPpud6NowV1wWcORISltpVlCfbPSZZuFDLs6WGJePHjd2VR+doP/Uc4/g6BG2puOxLe7HpGrRCbPGwbVpKRml7P6xGiv77PigmskqKP2VqwWjRROR8fQsugLWQ+FRmNVni0H9mkIhlYrV9qoVqheyKL4oi0KbWQnv2D+qwSp5uRWmwmF5I3hKrEtcB/TksoFQ4+MlvsMyZr0RJD2nP+tmdYfE+bi2U3mhhwAauNZ6LDSzuZSsl+oxp2ooCUG6zwG+qYx7OHnEru7SN3++NAs9bVlc3LjtIonjDEbdcHMmB9H3x65wItqSN/dI5vD3znT5/t6u6da6ixWSdQIihNfhGsc1z4xLbGZ+nwc1Scib7DtXYJDu4yKFhV5q5R650SY+hjR5+ekw0dSTYQ98JGtg==;5:qLePUBIqWNMijSKe4WWwhyE8CpF/YVQKJTKh3I4yb8NiAGJiER9BfWRpp02FXWnNiTD4VZsD6c18yEzmnK+pNvtGm2USvTGg0XEsNw15RZJt2OnynsJqLx3tuyQV/DY3aVDXfiEE0CqkRwFIPlcXc0ds9n3RVX93MrWDWjRGmmI=;24:td9ZNjSPTvCxprsPQcAuehSloVfqx6XCrAUdiensrqH2uLvGW7fvvRVvGZ+H/GrY8e1afTalXcEhR4rC6CEjWR7ujXVw681CWPLfieL706Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2182;7:pc8jHv5YprgcgEXrK1pNSb+1ccteAH+/Fe8XIQLfufoeSYgnoVTMEWo24VTmay+opsuQTaXKzAvEIsXGDPws5v8ghlCES8UbMrrhNuq1LOTP1OrXLhGnbIy7cEyy0hAWt8ybqnVfQTeuKAIrMzTFABJ925z1SlCPesApu2sZRKZuxnqR3oFxdS3gKWoQwfzJRfpEMdSFEbcs7HRjb+usFZkDp38YfNxkF8zOxZmIz8d3Y5DAsh+QW75mOizD00iw
X-MS-Office365-Filtering-Correlation-Id: b5c522bb-4244-4200-b9cf-08d59f796dff
X-OriginatorOrg: freescale.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 06:57:02.5164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c522bb-4244-4200-b9cf-08d59f796dff
X-MS-Exchange-CrossTenant-Id: 710a03f5-10f6-4d38-9ff4-a80b81da590d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=710a03f5-10f6-4d38-9ff4-a80b81da590d;Ip=[192.88.158.2];Helo=[az84smr01.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2182
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also, unselect FSL_PMC which is for older platfroms instead.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Changes in v2:
  - no change

 arch/powerpc/Kconfig |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 73ce5dd..ed60c83 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -316,7 +316,7 @@ config ARCH_HIBERNATION_POSSIBLE
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_83xx || \
-		   (PPC_85xx && !PPC_E500MC) || PPC_86xx || PPC_PSERIES \
+		   FSL_SOC_BOOKE || PPC_86xx || PPC_PSERIES \
 		   || 44x || 40x
 
 config PPC_DCR_NATIVE
@@ -940,8 +940,6 @@ config FSL_PCI
 
 config FSL_PMC
 	bool
-	default y
-	depends on SUSPEND && (PPC_85xx || PPC_86xx)
 	help
 	  Freescale MPC85xx/MPC86xx power management controller support
 	  (suspend/resume). For MPC83xx see platforms/83xx/suspend.c
-- 
1.7.1
