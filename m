Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753074AbeDKLxE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 07:53:04 -0400
Received: from mail-cys01nam02on0089.outbound.protection.outlook.com ([104.47.37.89]:41024
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753049AbeDKLw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 07:52:59 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; pmeerw.net; dkim=none (message not signed)
 header.d=none;pmeerw.net; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <lars@metafoo.de>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v3 4/7] iio:dac:ad5686: Add support for AD5685R
Date: Wed, 11 Apr 2018 14:52:48 +0300
Message-ID: <1523447568-13386-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523375849-29508-1-git-send-email-stefan.popa@analog.com>
References: <1523375849-29508-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(376002)(396003)(346002)(2980300002)(438002)(189003)(199004)(4326008)(486006)(106002)(106466001)(966005)(36756003)(5660300001)(110136005)(126002)(49486002)(77096007)(186003)(26005)(50226002)(54906003)(356003)(16586007)(6666003)(7636002)(305945005)(476003)(316002)(2906002)(446003)(8936002)(2616005)(336012)(107886003)(8676002)(11346002)(8666007)(50466002)(51416003)(6306002)(76176011)(2201001)(426003)(48376002)(72206003)(478600001)(47776003)(7696005)(246002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3044;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD003;1:BJBaZIjB/reXOrkb1nSap5J8fEjpQKHbc1MDwQnEn7TDHE2Afx9Tp2qVuuyzpUqvrVSB6lnbEBTopH7cm+XsKks5oehKwfWufTxziri3SMFp2tl1EocQ+rl0RbdWVc2x
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN6PR03MB3044;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3044;3:oL74jz0F3fbTWcADhZCD1gRPwewiCsMC6OBjdKlmBCmHWoGrdKvou58MxE/RnFbmGcgTH70RHkcREAQqcj0Q/GOHmjJ0xh2ub4K5zLPgEE0/9WKk+NM3kEMefut7AA5TUcU6XpaNwm+qBUl9SyRIHyG1se938jacHhOhdtIibLnbBAZVs67cvSMpk7lDa98V6/7sakG5N/4gt0c5dO7OpuUZxE+tbmXD4tVDtG7k6CtR+R7n1xFxviOJRfCFzVMTNdqdf8DG5FnxAYw5j4MxLxOG7Umws2RHbkyUvZXVYmZxBdZ0I2hymEH0lHMIe3BGBDYavLQHj6kmeBJAzJgB5A==;25:37qTffhCewwkZSzRs+D+XA4wro5cWi088BfxJjuIXvnc9B/0JaDsi985qgxa3e2DPTpEUx1t2V197qtIq+NZR54hxio+Qzy1g9WJAUyviIkTKkhAkTQVLKl81G68wwkb7McdNjyNEPs/TNJof9xEuorzYvLNnzY3GJu00mTNZ/nONf02ylTk4zyoCfQ8+eemXYfYGsugcufk7Iwj1Myez/886GLSfMIGk5o170SUviTuq05WDE1sjow9msJeRfCybtLaIj51nbDMztCY8SQC+WROt2rrJulva5wf/TZ4xg68RGBAoGiaxJIBJYteOtIkwkenweO6zorvnvTNS7rFbA==;31:nwtz2NgICHITEvqN1LyBgG4gksXXpoV2CSB1M9X+g0edDJ8aHye928K01myqDHTjthmm5ZcTVq1XEkVBSpYFzlPSce4t2Ug8weriAg7VFo4rKc5ahkzyzLg/dZO+yius+8CHeGUbRMOcZs3NiOVwspuu+epVhb2QbvYYvPwEOq8iVMdgLbblYhlpF1BGX4Hxs3s81qSRxzdqu7viQvZFLAY3pK2FdgS5r9CMqn4FQbc=
X-MS-TrafficTypeDiagnostic: BN6PR03MB3044:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3044;20:ypy5qAcJLp3kUnlevu/xjg4UE5ugM3lYWBM1QM1FcY4C1zYZE2ckPl+NsVA0QOryL+hQi+1fPYhEaJsEVM6oHXatsupj74HgnSMl+hFvYXsFyade1N6vl2ZkChO5enR2rVl7x46kjXxOTulPMELvFA/89q/TOBRj0/HysXvUcDHEohSPeOHUMmu30Niwt0JoFTnf6tbC+3nGoxS/gFh8/sk0xrW5ZLSqPFZA5v0uS69naD40aMAKmuFNAV0UExaHEANsPH1n207aqnJ7HG9nTWQVAcLTMKFt5cGH/HTh1chfMcT1UNU6KwlVMWyaQC3EzN5oPjg2ZrStgMKWqqvz7dGdsCPVlcfzpjZmrqIkkmrOcJf/fZ86liHVHG/hYvkdUIOWi3URm0+uORwWuVacpqe1zBYB/rvgsdcFlcKeabAj0NGyT+R85aZaUa0vx2TQZgAdCgmtzStaLyAA6u3CxFH6fTtgOeh5RvY2kEgydvfi5dvSfv3qqnZ5s/eeFPe0;4:F2WS6vDoR93Ck1tZSCIVqrcoFj3PozZAYTubNe1yYHna6EC4hChMy2O5UVw+vqSDSEpq9g8CfaXB3F5wrEhs0Vjcy7qBFocbKZJDZ9wu+KEoIJ3pd+9AtWPJVBbKk6r1TaQvxUpWQItxuXX6VQwCbCwZMNt8ZDl+eyEg8EVFGYe5ZLO+oA2z1TKVyLevFOLqyyTmKhfl8HP1dfiIY4uapV5tY9E4f5DwuQn3jB1bqqfrRgCVQLE+tZPsoB7yQD24liJmTbBo3XeAIl6zCkp1L7browarzbP+jtoJ7lL/j+7J34s7oN8wgYM4DQ5afy9bUybyXavzj9KSF5+CLj0JC2Yk4QvdO9v2nQkrVSdgyi8=
X-Microsoft-Antispam-PRVS: <BN6PR03MB3044604CDED806E1BAB0E72D9DBD0@BN6PR03MB3044.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(232431446821674);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93004095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:BN6PR03MB3044;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB3044;
X-Forefront-PRVS: 0639027A9E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB3044;23:UsUYZKK07z39wI/UCigLAFI8E4GxjlZfT65Visx2O?=
 =?us-ascii?Q?l/WBKAMxUm9liOno0CCgxD+OcueMNwuYl3IXczcSudxwrHGgZgjUyjUrZBqi?=
 =?us-ascii?Q?ZNSlAWADWSVoafYdgN1+okBm0XwJVXZIhC+okH5rAKCOx80Nv8pXMAL5Qra4?=
 =?us-ascii?Q?SQluTWb62KfC28K2rdpUcUK66eDVaFreqRkXjk5J0nXQbwPp3PIMH0yQ4Yn3?=
 =?us-ascii?Q?XQoLZ5NaCpcMQ92picK7BCwnfeCjGYmjkNtXPwvtAUxmcpEujA315PFRWypz?=
 =?us-ascii?Q?9wGX3KiV6jV+BvsWUtrFTL2s6RL/llYWxZcal2A9/W1xdVJZ2Z7Idwfp6QWK?=
 =?us-ascii?Q?GrT1ZHmBFOpLR27XpwnHI/G9vrJTiIYL0+8g3hQi9DaN1xsGL17K4+27RbM+?=
 =?us-ascii?Q?+W1Cx/fclLLE8FZAh1NFfOUe4U9iiz+VogyFXyQ5xM+2ByF2tZGhW1uibrUe?=
 =?us-ascii?Q?rXXtsym6FM2Yhb52E1M6jdmFMI8KjT5ZVxjB+9Jrc85Q2MhkHGw60NUPcvpR?=
 =?us-ascii?Q?QS/uNLiC8C+pQLaFEFIgDyfl5tCJ4I+hQJVwxDRleiNBL+Gc5bASeZgjYhr4?=
 =?us-ascii?Q?y06+MdROQJNsV4AwsIFrS7V/br8DQ1dV2rOd6bkz711PSfFEwIybPsPlmNcu?=
 =?us-ascii?Q?vdc+5QomXyOfCIYXKgh/suxdLVV79XiOyQmiqOHwJkz6D0ReIWHcwWL3axgT?=
 =?us-ascii?Q?azFoAECq/23sAHyOiRJT8Oy9dI4cL/YDbfoWXIGwx2xMuLwqaRFk/mDDmaDR?=
 =?us-ascii?Q?gwl5mHDPH7zSQ/A5g6bSNJ+KOezzzfXSX6gna7NJncdhHCcJosOO1CPLBvts?=
 =?us-ascii?Q?ebSTZvMqjxyqfdXJ+qK3fZcFvXgIE6v6wlGzah6D2ENYHGpOLGG385ALddev?=
 =?us-ascii?Q?Dd+R+vXtgwrC1xqlu0QhxWvhKjdgc3P/at1Mqvhuh0LrREMOqS2LuO8JlZld?=
 =?us-ascii?Q?MxG3AOZhP3XAgD791V3IM26U1+1bXKMkD3Yy3gmLLgYZNW7yikKdC9u4vw+/?=
 =?us-ascii?Q?fKDitPnZtFlsAvz4YLrc8bHvILpdKjF8Quul/G6EZue8RMTTJMfUvXeIZ8NB?=
 =?us-ascii?Q?VIjY3Y06VIGrse93EM6zgMDuGjv0RPBi2Kb843ooSeH75mfCQnePCNRTmGSI?=
 =?us-ascii?Q?6dOUk7chtO2TM/hnBWoLtFscIh6Q5ZB?=
X-Microsoft-Antispam-Message-Info: D6UX389z4KwKHPezaOyCvb4lTuBKuRZqxuVpb3ljPcmGNu3AjFY1zRaEBVj4UsF0ANcb8+iEauRA5OPTeY3TukNDNmsZlYwm2Hga8aKR8OOh/TRVhsocOZeGXoUqaL0Lg1O42ex6DwnV3+9AhlfLVdUAhikMtbvBZFiZtZAu0T7Hy09n+gN1CX/VbbWlrcp7
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3044;6:rzX0prtnIW1thNOJzMh87s6sVNEcVaYtIfFXKYXysyEivhNzRe8bzWkk0P0kn+DsHkyZkNO6fM8mx9VB/ndaLmVOAcLySloeq8w8Q49bk6w2PNJ5mLszsP63T0cxztiP1/wiAv8vkQATbfFTq5caaFqYw/+A8iHk7VNJUYVkX9MEnfJ2Asb49l2+LcdCfyvdKs98U24dQ4D6QJt+cTSYpYyFX2tb5xGlRDiHGbfk6+unmJoZ3CT6StxsEPS+C7fVuDcJx17NQrI5I3RvUZLgOxjRk9D4wXjsE9gvNUfR0mf8pZ3Hpwq1RadmOBNam3/waYbq4xhIE6uvqHZhkAmLtaD0/AlrJ/luzZvVjeUKukgmcnf/iX6M151z3FtcScZBj7ettR6V6nRHhujqvHwmR4rpChyCRIztr7C23wj12yY3EdRf79b/anZRVa45e+8iLjjhjkP6svdGVikOPjeWIw==;5:BS0dGdgwDdOSlojtCvd2gxqgFxzBa5naRftda6Rf7k7JXeeTCC+2Tn4LGHeZpZbjRavW4JL3xV/huOgXa7j2Hr946Y8/wANNiqvvZSG8P1xscmhl6/2voQjHI4ffyJQfeB9tNVnVBa4B8RiDZTu5qHIob+AwoQSc7F5xtFamQwk=;24:F8MmNjn34mevUAmltrKGfB5XaUqbf/3dKBrn1RdqJhKL7vr3uROxXniun+c86X/crH/WGIczmdZd2tPb+JzM8uMFVcKX7Cd1b2FpwXf9smM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3044;7:g7KCtQNQzZELDj1mezr8wpDV7VRz8Xt6QkWrLKw8DwfDXA+Uj09yy9mHBe2bEkWJ8/VEIqukAV2QIrWf56ka2ZLGsS1ibsvIQX23CN1IPei8uHLAZ9rM7qJq/jcFre2mIgcJZCFgXL7lurGVzOxr0ez0xFM8RWdqvizUMh+PEZLzyvEUNQA4CKOrFpW6UX0SZdBtvpm8OF+wizmFlHNV44rmQRXpu38WAuCT+OHy9NE4sczVgGgBY3YZXBQyZCXO
X-MS-Office365-Filtering-Correlation-Id: 6a2675ab-5d6d-4c58-f86f-08d59fa2c466
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 11:52:57.0146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2675ab-5d6d-4c58-f86f-08d59fa2c466
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3044
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver acctually supports the AD5685R device and NOT the AD5685, which
does not exist.

More information can be found in the datasheet:
http://www.analog.com/media/en/technical-documentation/data-sheets/AD5686_5684.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Refactored the patch to add support for new parts
Changes in v3:
	- Nothing changed, just to follow the patch set version.

 drivers/iio/dac/ad5686.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 87d6e6e..a753ffd 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -88,7 +88,7 @@ struct ad5686_state {
 
 enum ad5686_supported_device_ids {
 	ID_AD5684,
-	ID_AD5685,
+	ID_AD5685R,
 	ID_AD5686,
 };
 static int ad5686_spi_write(struct ad5686_state *st,
@@ -303,7 +303,7 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 		.num_channels = 4,
 		.int_vref_mv = 2500,
 	},
-	[ID_AD5685] = {
+	[ID_AD5685R] = {
 		.channels = ad5685r_channels,
 		.int_vref_mv = 2500,
 		.num_channels = 4,
@@ -392,7 +392,7 @@ static int ad5686_remove(struct spi_device *spi)
 
 static const struct spi_device_id ad5686_id[] = {
 	{"ad5684", ID_AD5684},
-	{"ad5685", ID_AD5685},
+	{"ad5685r", ID_AD5685R},
 	{"ad5686", ID_AD5686},
 	{}
 };
-- 
2.7.4
