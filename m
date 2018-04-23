Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754205AbeDWHXi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 03:23:38 -0400
Received: from mail-bn3nam01on0052.outbound.protection.outlook.com ([104.47.33.52]:28989
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751785AbeDWHXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 03:23:18 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Mon, 23 Apr 2018 15:22:49 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bhadram Varka <vbhadram@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingju Hou <Jingju.Hou@synaptics.com>
Subject: [PATCH v2] net: phy: marvell: clear wol event before setting it
Message-ID: <20180423152249.5f1deb65@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: OSAPR01CA0063.jpnprd01.prod.outlook.com
 (2603:1096:604:a::27) To BN6PR03MB2625.namprd03.prod.outlook.com
 (2603:10b6:404:59::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB2625;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;3:Ngsik/gRPp5eK30WMrYtpFVLRNDEpDQi7oWK3iY/qfhOjk3HDd318b5PQiN2ictehN2BVPtnOGVZi8Abx0zyu//ZLIolvrHGMOGooUj4W6Fv+0UYnBn0TTi6MjeFf68bAo3HyqBwm1Fl6CHYOcMO1sSc/cRHnTdgJEFPGiNAU3tQmXOt9Z516AayjdGjtY+7zvEDVuPeXvN56hot+dxeVAMC9d8pbpKgY33d2zLDLvgbz81Gcp3xmEV9DQNyAEkH;25:RgOobK7EPl/s1hWZvi0XxfhBgAUM+a5m2lmJcP1hRVmsgZ+g1EoHnIdL/W36DeUKMbOn3RnrHYD+cRIZYB1edxxaTKPaO+lStpy9DzuEYoi1Wu9mIHIsmCNC/AhBFDUakYiu5ZnSKfqWs2sui4OIv11IwZ2fMgYK/K3Iey5FVl77aG/nRC+vp14JSmHObvFiN+21h2yKiEAtVOpnpUosEBHi9gt/rIbG1mXvpFSb+ueIMxEsyU9VPUazfhiW/CxLf6+NMFh55bI1wS+GBSnhIvhPFrzQocopPsTw8gL6msdZKuG+PUWzaNexGk8q6nF81DaYcFhhtid1wSQAFuq+eA==;31:1m5e+yAPZooEI+JFv1YyW//1gOR8donhQxlnWciejetK+mVm5qb5gsPbAMgeAdSS9Ao2DHVoa2YrK72r8ozzEscTgVIZhuA9GWxhZKXUNSrdTobdxm6pwGTj+YliLMeqhhakL1N36StFHkb4BqnvOVGi21dovUW8NZUIAvzeybofm/ZLruhu2MUwELdOzcU864Kc9Rrh0wwmL4GyPAvqELzP4OOHaA/zBeltsEQhawI=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2625:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;20:tDME5NkkRIKPAIX54VtqP2zyeRkRgsfZTykUl1342x24qD6c9uvn12Nkkaa08TpPN5c379SqRj0TUtD5yqq8htTNFVtaGw1jrb7ijLdcFGteDps8X04/N60jp1Mf/aPYTcoRMrh4wFYYWXt4kzjHCiA6X1kU5444y7OxK2dsDm6yh+01AFNnxdxABzFnKHadGNWgAIWS+PjqjlDrTSw8ugBWvarcHb7p2U6rF+w5mfsTJG2FI4ubSEXkvVNrrfdja5L2JfPbGVuUOBsux16jreofCoy0rq4AVW0hOz3zsi+TQl5Xhwr1ffs9qD8fRoC+niG9gtaUJS4goCBylAjbV7PZOWg/rWeZ/abIAsJX/sQqPX+T3OKsTUgAOQz4pyA2xXz/6HAaBGbTgXqtdgZHUT2Vr4OPdiwy9ON2tzO6L5tlnYbDorKfkU0hVUIuPNBLNCEH3c95wWi/cujXNRu4cSB915Nu5rUdKoVkmVwjQAlcSWlj3Vts5a0g2Lpv3NCh;4:TWMlYdTV/rrgL6aQ2SLFQZScKcg3/K7SYXC+EX/rlFVZtLbrS5v+jS1ECVPjxjDpNe22wwAPiD+PbSNCZ7Q/GJo8lPY9+mw8Oi6rullHaw8qKxq8wyMASWav75yScLKMl5CEva9DpUBIniiMH5pv/ZQhEzKm3xuQcIaXuzp+iruSQqBlvjFcuURDxJhUym4Lt+tfD3m+HwIs7eAo1PJz2FOWV7X0cis1yW3ShmLEYhluaGEi77IEPoVTTkgh1I4vKMWcf1lNz0lTy2OWqY+uyw==
X-Microsoft-Antispam-PRVS: <BN6PR03MB262589DA02821BC32A30DD61ED890@BN6PR03MB2625.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR03MB2625;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2625;
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39850400004)(39380400002)(366004)(346002)(316002)(6666003)(26005)(50466002)(110136005)(50226002)(386003)(6506007)(7696005)(86362001)(52116002)(2906002)(3846002)(66066001)(81166006)(23726003)(1076002)(47776003)(16526019)(55016002)(33896004)(72206003)(8676002)(230700001)(6116002)(8936002)(186003)(7736002)(305945005)(4326008)(39060400002)(9686003)(476003)(5660300001)(25786009)(478600001)(956004)(107886003)(53936002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2625;H:xhacker.debian;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2625;23:eIAr21DSh+Pl2FuwXGWNgtRNCsYLnQWzalLIyUAhg?=
 =?us-ascii?Q?JteREslTWoGbNyl9/pZBfA+LTRrlSRGTy+ZG2VOiu243dQnmrg/zW6biz+il?=
 =?us-ascii?Q?acHllLIHLvaz0NbXH/MZuVEFgnp1CqG5TT3Vo/ilyiTFVTHsaC5O8t3n0flc?=
 =?us-ascii?Q?vejVzZIhdBYW+iJa6pzrW90M/T6Igf2//NjkhDYRkCxRRkQK7V3AAiYiGYsS?=
 =?us-ascii?Q?ckThknq6eBIukL6QN64GoCbEjWf/Th2Ou+iWlz+l56wRvPslDgJW9aCoOfrH?=
 =?us-ascii?Q?f4RA2K0Xv2+YpOmFw7vs8aMPBa6S80Kzmm6NpvigExK3gJv6vqEGD63ivMqB?=
 =?us-ascii?Q?cAs7dWpJP8a4EWFAOmtf40sa3VcoNh+l7mzRn0T99Sd4eIe3dJMav7E45dr6?=
 =?us-ascii?Q?n8906FkW5sqmLaZtDY3hHzMb4sk9lywR/HcwKKfq0CQH2VBbr/Kz0pDpaPds?=
 =?us-ascii?Q?N91IuqbEZxDiFEGWUcp7ComrjlggqjkAONbOkDuSrMkVFpSWcdAQWKJexBwc?=
 =?us-ascii?Q?fwKYzTynDSS23yL/r47RkPn4G4WHHN2gnd02pQ6clwcvJsbLUAl/eyL8rvre?=
 =?us-ascii?Q?Nm0rmR0vYTLFwt037mdl+rzLLjkrk5frZrs7/NGdwbeN3t7w7Ozt5e20E6lh?=
 =?us-ascii?Q?G/OMhWqvuJt2SbG+RkFVsjJgKr/rsBMykahpTR6SuPQnBAqD9fixDA8rZqBF?=
 =?us-ascii?Q?AI/xRcAajPXjlZRfjJ16GF3il6gYfOovhPrBo4/p3ye+TEr7g5f9jFvxjfrc?=
 =?us-ascii?Q?WvTBXPNCdSGXP3SuJ8Ld0IktbeChMW6AC1GzD1WeEt4kDFarHJhCYDQaSws6?=
 =?us-ascii?Q?Wo4R7NjiNwL896VmFJg4Lug6BvpwCcRBzxnFwn6D1dRAyB7qmHX8d/9EvkzP?=
 =?us-ascii?Q?Nrs0SrXKRMcrH9tzOSr4VhRd+ePzNxaoVDg2m/3hOp4LD0NxUgN//3nAobYy?=
 =?us-ascii?Q?1pQJXT39H5s/pGLCah5n8zfINlayzwBPVurYJFwv0Z16lULn0jc39BcA/lHr?=
 =?us-ascii?Q?yOMoftWkvFLQBMPDM7VPVZJlUXoxAmcIHBF2AUh3QF5EaDaA8xg25woamfQB?=
 =?us-ascii?Q?1FPiqOM01qdYT1flLcO1UB7IQUs?=
X-Microsoft-Antispam-Message-Info: d2YjsEuHtPSzp4H01aRVWzfEUxbCoIyGfBhoXdno2ZzfwLQ2Z1Wi8Q6RmKl7edkLGjUSw/g8irxbwnPK5qqJ/4w92x1VCXUFccDz7WHt9IPyNDqlaI1Tcki9/TOwj8YdXhqLx6fEitHyCtNEW57qaZ3NB65GmfIBGzoadLbw88K/gRjCJBfdzkj8p0rjBXx4
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;6:DYaddeDLylZkco8At3zj+0wZSF3rnIVMFSlujd80ZQwK4cW7NqQts1+R9oPXjCQ/IgP80pZFAjOyshDofM2vc5K45aGAJw/0kwLFHjyxe57rOmLfz+slO/ihiiDeDGFOUJqC89rgzpIE5yEBf4uNj/9lSPzvAG64uhNCT79bq5RNEbIfb6sp1wkIxfR+7y8/YO47rj/r8SJZGbngL1780CYO528T+OO0gNcdFJwC5JNYR9LtWMVhpeOAoZFkfKBM4euPULUaOY82CIj+JNC/w9yStXTxVFgRXsprdWe5vB0dOB2BOOyKK/gRnBtlSmP0mLoe6YcD8ZqE1Id6LtDBWx7wSYfXGyIGUv+sQTR/24N7w+cLyIC0l5mh/cMCL1Nbl3AUL30Q41V0M9M7vEgWDN9FQLfbZGe9W72OFpNaHKMISW26AWUXByCBRUKD7HnITXR4Dfh6NtmokXKBci8oRg==;5:Ajqjy6mLkJIEXX218XCidzBKuz5Ex+HaIDsO5VX/uipULUN2cDbPeA8OEFncpNxNlTAWyEHV9ebtEnZ5VpOI5ka8d67ThUbXba/Thv2AXYVgM0ftT48lXSvaKhZMfhLV+ekl8uETvn4r+WcSHHTePAlBg/cNrdfSQnj7BNblV4g=;24:kiYb+F4qr1dL3Ywhy6Ro0sT8z6cw9JrsJOiqEnNbdiH/WsrSLQOfXmpPKJ1hXozrINMmebemD2i/LMdsgttOrYSt4AxkVG6zGSkk1VdQkdY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;7:HDF8PfZIvsxFoC6vmST04GbFy5f/+gd636fFUFSCcXlPqhfEKYlKchv+4rBMRWxP5dX4LcrXUfgBmQ+rze9sifIelRXiEZUOCNVWvIbOBUqai4mzakCq7l/9De+WfaQG5ZXSomB7YyFeSGwO1jNeFjiLespMbfKg5Oudb/9JB2FyZnUNYeiSaM1fVHeWVrdOp1V7yelFl/DoLlNqyT/iBukXu3g4SEwd58fxEVQyAMTdOpKfZY7dxhD7S43/ixoN
X-MS-Office365-Filtering-Correlation-Id: 0849615e-97c6-4a42-0544-08d5a8eb14cc
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 07:23:14.0440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0849615e-97c6-4a42-0544-08d5a8eb14cc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2625
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jingju Hou <Jingju.Hou@synaptics.com>

If WOL event happened once, the LED[2] interrupt pin will not be
cleared unless we read the CSISR register. If interrupts are in use,
the normal interrupt handling will clear the WOL event. Let's clear the
WOL event before enabling it if !phy_interrupt_is_valid().

Signed-off-by: Jingju Hou <Jingju.Hou@synaptics.com>
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
Since v1:
 - reuse MII_M1011_IEVENT, suggested by Bhadram Varka
 - make read conditional on !phy_interrupt_is_valid(), suggested by
   Andrew
 drivers/net/phy/marvell.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index c22e8e383247..25e2a099b71c 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -1393,6 +1393,15 @@ static int m88e1318_set_wol(struct phy_device *phydev,
 		if (err < 0)
 			goto error;
 
+		/* If WOL event happened once, the LED[2] interrupt pin
+		 * will not be cleared unless we reading the interrupt status
+		 * register. If interrupts are in use, the normal interrupt
+		 * handling will clear the WOL event. Clear the WOL event
+		 * before enabling it if !phy_interrupt_is_valid()
+		 */
+		if (!phy_interrupt_is_valid(phydev))
+			phy_read(phydev, MII_M1011_IEVENT);
+
 		/* Enable the WOL interrupt */
 		err = __phy_modify(phydev, MII_88E1318S_PHY_CSIER, 0,
 				   MII_88E1318S_PHY_CSIER_WOL_EIE);
-- 
2.17.0
