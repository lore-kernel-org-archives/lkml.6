Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753385AbeDZGg7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 02:36:59 -0400
Received: from mail-sn1nam01on0114.outbound.protection.outlook.com ([104.47.32.114]:20288
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751508AbeDZGgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 02:36:55 -0400
From: <Yasunari.Takiguchi@sony.com>
To: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tbird20d@gmail.com>, <frowand.list@gmail.com>,
        <Yasunari.Takiguchi@sony.com>, <Masayuki.Yamamoto@sony.com>,
        <Hideki.Nozawa@sony.com>, <Kota.Yonezawa@sony.com>,
        <Toshihiko.Matsumoto@sony.com>, <Satoshi.C.Watanabe@sony.com>
Subject: [PATCH 2/3] [media] cxd2880:Optimized spi drive current and BER/PER set/get condition
Date: Thu, 26 Apr 2018 15:41:29 +0900
Message-ID: <20180426064129.32161-1-Yasunari.Takiguchi@sony.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180426063635.31923-1-Yasunari.Takiguchi@sony.com>
References: <20180426063635.31923-1-Yasunari.Takiguchi@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [43.25.41.244]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:117.103.190.44;IPV:NLI;CTRY:JP;EFV:NLI;SFV:NSPM;SFS:(10019020)(39860400002)(346002)(39380400002)(396003)(376002)(2980300002)(438002)(199004)(189003)(305945005)(72206003)(356003)(1076002)(7736002)(956004)(7636002)(2876002)(246002)(51416003)(26005)(16526019)(186003)(336012)(126002)(59450400001)(49486002)(486006)(2616005)(76176011)(476003)(86362001)(50226002)(2906002)(6666003)(5660300001)(11346002)(3846002)(66066001)(47776003)(106466001)(478600001)(446003)(4326008)(426003)(8676002)(8936002)(106002)(36756003)(48376002)(39060400002)(50466002)(6116002)(110136005)(6346003)(16586007)(54906003)(316002)(107886003)(86152003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR13MB1424;H:jp.sony.com;FPR:;SPF:Pass;LANG:en;PTR:jpyokxeg104.jp.sony.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT045;1:O8rTbMg1ujG6no272gojsiXx1gEEAlEUTkXcnt/as8e5hqkySUQJVt+wwpBTv1NOx4M2V2xW/Zs8ibLwEvcu+Hqa9CR/mUy1NsrKY+awZ9DBU/ufb2h0t2tfTra14crl
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MWHPR13MB1424;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR13MB1424;3:yK0dka+tEUAW5Np/slsn2aq+aBcfBmEcXUKrzsVnLixFrDvha7OdMejyxIH5GbIEyvRI4P6ogyR7geoylDZ0D7xj6VQCNT/GarxZWVTUwB7wA65cbZDXe0vG1jPLJmoGW31Jfe6CyhrH63AwNju1qN8mYkVBPmaVI3/jN+nBS5olF6b5P3igSFKSTUd1022Peh5h8uBsfSp7rSW+n0Z46sqMoRobrl5cqFEeqfL/zdJgbROMvqJQdN1xJ+YgVsy1Ecy/M9/8IbAWWIIw8B5DnsXETYKKgjQWaXHcHiO0Tbjpr9M+Ogh9+BGWWep/CiUnZfsqv7bXwrZwsBllJ4mnDIEthz0nqdq1MShlUiDpaVA=;25:Di4JiUqHIbopHx+G/j1Z8cgX0CZ7ytDIr9jmHtT2rBwiIF+lrWFLcJ9s2IWcPCLOKoD+uaehgUd7hCZTqpMYNty0+trXBH1uz8rHcmiTb7v+6XsdH9eVkykk3AGnxyJ/BtsybZqiDcKq6c1SKg1E5ulhkkXk9qmISw8zmLstHei94kDW8uG6NkB6WoKyH60RN830lgunhuf0m+pq/blL0QzjFo3+LrLVYsElWeDIm+CD9x2M1q7VNMjJWgcMpUeP8ha/o9RLZz8UO0vbbuMOSHHbOC8XgcIJiiRxmDRJ+UV5X+KqBjF5sY93Sq4/OWQtuz2Z1f1I9H5jYJ5aF7aveg==
X-MS-TrafficTypeDiagnostic: MWHPR13MB1424:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR13MB1424;31:7yMHNY7q8MG3M7a5tb12r7NALNw39zSEZiRfXYmMnTtkUDg8YdRv4dC2ULD2tOtcy+bj30+nxL2uoLuh846psPiF6ZDiLtaCJXaOMUZWOCXI6qoRjW6i8sMTnXXQDiH3dYz2Z7sUITDp1UB4DsFFV6G3oo7faBTMmX3G8GrvTFvkqihXYeV2Q9ip2mZE5F2mDORt+dZHHqo1lyXKIGOROxn5EztHCiP8ImPLCIYQAHk=;20:VhFyYBRmRjgb/IjEHNw8oUCoA7pTct/d2izb08wxy1L29napLz9b+jZ5lDiaun2ylNxejZH4MUqisdv/+UWVfp9yS28oA8YzUnjD+VRxcKuufwfE7MOAjbq8nWyIFSH1BEyA2iEsoSt5/iELFUFUjI1GAPd9+IhKYDFDe+IGUwtr5bt0HYqJMJ+fenEbzNgz5HthZsf/zxPnq7A0QWeEG7NtqkW/ucvF3tWUuEzotcxlpRSOysrrd6KyTgxkqmG203yoBXm+Sf/qBoSChdMgdmr3Naxxey1s8pX2EimQLMJVKeUCDYwzGu800HDT8SVyzCLekCcxJMfT8O+rPILy74iISQ3Bx+/z1eTOznWm0FjotqSNywep1NBAMN3nGPwFL8eh8Vo6WUOk3oYU7pwmU61RvbNZOVDT8yhomA74bcxpT7G3Sj0qTt5M1MtlIazLImCOKemZb17WQL0xrjsldKWRGElYB8lUaSbJ82qk4gxOsrdH5IOrehLhmCQmKwvM
X-Microsoft-Antispam-PRVS: <MWHPR13MB14240517E75C4AFB1A2999B2FD8E0@MWHPR13MB1424.namprd13.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(182409339516656);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(11241501184)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR13MB1424;BCL:0;PCL:0;RULEID:;SRVR:MWHPR13MB1424;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR13MB1424;4:zr2HOd9oMt7FRco4rhlYk31rrpxCJ36MPCpvWXiheAhARjf2jhjWuRt/GjjtKwdjrO2TFazgbaiqUCPVZ6TA0Hkn2G+pNZL5xHzUprceYbk78pRTuvnD8eYhPr6XQSHRyWX5+OJMe4R6O/TJSGwn7M3xuFjI+FCaBLXnL8on4HwVr2s3pbw/V/r6kfN9p+aEX3ixHAZv7lSKpmfY0b2Si4dkF5sIqFIH8qCAwuGdbkX6rFlBhczV/OzP0AlOkqypjQ+wUc3eSTYEU/wZaPiAr2HRScilCi3Avzkmo+ykH8QVFpaykgtp3q9XRSNVMcXi
X-Forefront-PRVS: 0654257CF5
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR13MB1424;23:MN7mkUL3gu5uif+i/wJ3pG5Kmpe9G8Ia0DaNgjBsX?=
 =?us-ascii?Q?yWuL5PEEVdF2Elvdg8XWrKWUZyHfdZYDsaTyclSiyyXFeZv45zcjKfWaSXCK?=
 =?us-ascii?Q?nIGASRkVSmEGRzLVZ+2XERdiuPdqul2L4w2tOkrJ+xy1fidInCuAvkTiwjsA?=
 =?us-ascii?Q?3VydK+hGKx4zrmC7M+jSWN6/m3RUNYkKMLfPD3qzH4LzklFIRdUPUAHH77kf?=
 =?us-ascii?Q?IlE8nrWPIb3rZl8w2LUB6g7QM+Bmh7Q1Fgtk3ESirPUyhQ37gxcLzZu7L+Nv?=
 =?us-ascii?Q?R8Z6RStuL3hN6hfYkw/YxYvtx1XL4+QddpeC2Jko64+WNtsSJnkg+Sb6QmEO?=
 =?us-ascii?Q?VrR/qqxbV5ABfaLJYXmp9Cxyq9bn6odxCBPBhGNhOxBdr4gA0JeO/ZEIC0DF?=
 =?us-ascii?Q?EoVHwtRAMAGhD5jyr/zryLr40uuaZat2NthH25xNZZO3W7ZYF/UqS2TDA5m8?=
 =?us-ascii?Q?yHFdELLAKX/oIWILxBc20ns7kJ+oh+bp0Olql1K9WOCgZl+kCVT3xwQDrCJ7?=
 =?us-ascii?Q?BC49NWk/68TK744TJU+3yTP187Ive6WE5cCg2anqKV5UAYbw4z+pJRiqyqHR?=
 =?us-ascii?Q?gcxY8FxbasGnz2qTkXrZlaTVEN9SytouOXmbgH7y4IEzcaNjPho3j5mtXGv9?=
 =?us-ascii?Q?RYG/WWM10k+e1tO1tuZLgIjNGbOweXWupp796PtrP+kczNELWBBO/nyYOjKs?=
 =?us-ascii?Q?5iYfRWWXRIAiVMAAGSrKlhorasgFYrg4NmUtu3VLtWK2sdk3yN3VGHIiyjAN?=
 =?us-ascii?Q?PZGF7MgKs73ANRZn/RYklFOXyig5g+tty9TPRWtnIfO2U1So9SHiR/+RED+9?=
 =?us-ascii?Q?Dcw3TVsXfk7OBl/0y6SSs0qDytHIdmVUpxpRRZsda6hJ3Mlwn7kW2mCFJHv5?=
 =?us-ascii?Q?7ZHbEz6JZcDHef9SsOk74PFQ8YbK8ABhF1qzR5yLGE08VqA1cbjfBO2yRZqd?=
 =?us-ascii?Q?oMT17gc1Sn19jUCHjv62h1tP6a5WGL+5xKPwLf9dnCyx65dS42H3sJTzlMKI?=
 =?us-ascii?Q?hCxKqjaTE+d60UOKd7yvsjvaOqvuBK9NcwiFnfVMc+3bY93pldTMJUMR0DeA?=
 =?us-ascii?Q?dsfi1p1uYXq/3jFjVx8RGAa/GZ5LIicOK671o0xUSFmEe0t6J8WJRpKRsBgS?=
 =?us-ascii?Q?gmbEl+DksjybFv1nLqHc1zhF6+C/JoFbGOlcneakqoj66KtO4xHCgc7QLhI5?=
 =?us-ascii?Q?lH7/wa1RuWLGcVGIuxDPWnpm2WNDTJzDTKbU+An14NVyP/POHPyb/fzulOHe?=
 =?us-ascii?Q?mp1JqH86vA/AQxQCK/uyizNSMK4TSuWLV3tfWeW/Avu22+tOL9AtIs+NdsYw?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: TJjrCAgy/6MsBFgorAIwu/2b7fCVBN4TE+qepkL12Qxdh/6aHSfkVUsAx8virzGKMw85NSbAo7+C+4is/FYW6noNNBPorgqphF+6NWE3DJZIm4Kpn78JPglN8M3ijsZuRos+uq8J+RM1imE8pgW0a3jHEvBQddAgqkqgJ+vVNG55p1v4N2O4KPwHeRqDZ807
X-Microsoft-Exchange-Diagnostics: 1;MWHPR13MB1424;6:b7RucoJClFrHGFVWgmhYQEUvMrF7hcn+oZsMQov7o/JKMe9lcHqlBSy7EX+mDQF6+YdH13kH0isZN5uky8ndif24SF5Qe/HU6lbWS/9YDINEekGOYpPlTen++BHiDEN/w6PgM+Q4l4PzU6N8UN1m2Uiltm8PL5D4pxmCsH9I0jXjcg09jwx3KhIFyGPdXCHwuIsfUB4HLD19Rx28EAQ2C6lPeFDvMbhXVVV/XuyhvKPkWUyo2PcV5jod2YO6RnI3ZUzMV3HVvhOWuytAAKHSlCk2GO4ckmT1TF6882LADeMUYHKlfjvI4TEql2KzkeybIc6CdTk/F2j9un0N7gTBPfzgh0mad7q/v/WODayttwcILParbnxyMysnIhi26N2kHDxTVzweZnzUs/1Ffy4EqwIELsc/8BsJ+uu8iHrXXtKWJMeBXsGOZZ32UDnIE9S94ZdjhSGzy3uptZXtT1U/mA==;5:fMl8irRCeTFT/Fz/YPfRwEIgq1OZnv9EWosQEsUYRKOhtAMKb4bbeViqUDjdFOrFzb/s+fBU9Wl60GFRCXsbzdoP6zh63WVrip0634IDqVcgasysVubjfrM2WnLWIpngpHUEJZNkLSBRx4mYWGJ0P8yr2hk3ZTbAtIUNR4Ys8aM=;24:caWhtcg2RyO+FEF55eDCNtaBfkgWPiY+lf6+jBwwEmfdDWOYrAT+K49MSQUTarjniDFiOyeGf1CqoaJTAp3a08GXo38SdaQVdvszAOIgMks=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR13MB1424;7:PlSuMD9c+/ZuD8FZbxIPC4kgEynKzRuBgkeChmpyeWfqJSArM19UnVWOPujUSvh1wncZ7aPugEIIClRzU2a9jrMVmX0qPkF07KwPxlEY4eVH4J9e6WDAii/vG5HfCUTN1mSLVqxHqD5qx1n5ZXhJq9n2jnetfGzS8FC5D1fKIT1PReYxOPU6ccp4j7M1iUbBicaSphoFNXqhkkw9yy6hWVFU5Zp1iIunBwFsv+wMrHqTLVb3kMCe0bWcn1TdLsNR
X-MS-Office365-Filtering-Correlation-Id: 0e546e13-7458-4c48-ec62-08d5ab401894
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 06:36:51.6619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e546e13-7458-4c48-ec62-08d5ab401894
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[117.103.190.44];Helo=[jp.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB1424
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>

This is the optimization for SPI drive current and 
signal lock condition check part for BER/PER measure
to ensure BER/PER are stable

Signed-off-by: Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>
Signed-off-by: Masayuki Yamamoto <Masayuki.Yamamoto@sony.com>
Signed-off-by: Hideki Nozawa <Hideki.Nozawa@sony.com>
Signed-off-by: Kota Yonezawa <Kota.Yonezawa@sony.com>
Signed-off-by: Toshihiko Matsumoto <Toshihiko.Matsumoto@sony.com>
Signed-off-by: Satoshi Watanabe <Satoshi.C.Watanabe@sony.com>
---

[Change list]
   drivers/media/dvb-frontends/cxd2880/cxd2880_top.c
      -reduced the SPI output drive current
      -optimized signal lock condition check part for BER/PER measure
       to ensure BER/PER are stable

 drivers/media/dvb-frontends/cxd2880/cxd2880_top.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/cxd2880/cxd2880_top.c b/drivers/media/dvb-frontends/cxd2880/cxd2880_top.c
index d474dc1b05da..bd9101e246d5 100644
--- a/drivers/media/dvb-frontends/cxd2880/cxd2880_top.c
+++ b/drivers/media/dvb-frontends/cxd2880/cxd2880_top.c
@@ -520,6 +520,15 @@ static int cxd2880_init(struct dvb_frontend *fe)
 		pr_err("cxd2880 integ init failed %d\n", ret);
 		return ret;
 	}
+
+	ret = cxd2880_tnrdmd_set_cfg(&priv->tnrdmd,
+				     CXD2880_TNRDMD_CFG_TSPIN_CURRENT,
+				     0x00);
+	if (ret) {
+		mutex_unlock(priv->spi_mutex);
+		pr_err("cxd2880 set config failed %d\n", ret);
+		return ret;
+	}
 	mutex_unlock(priv->spi_mutex);
 
 	pr_debug("OK.\n");
@@ -1126,7 +1135,7 @@ static int cxd2880_get_stats(struct dvb_frontend *fe,
 	priv = fe->demodulator_priv;
 	c = &fe->dtv_property_cache;
 
-	if (!(status & FE_HAS_LOCK)) {
+	if (!(status & FE_HAS_LOCK) || !(status & FE_HAS_CARRIER)) {
 		c->pre_bit_error.len = 1;
 		c->pre_bit_error.stat[0].scale = FE_SCALE_NOT_AVAILABLE;
 		c->pre_bit_count.len = 1;
@@ -1345,7 +1354,8 @@ static int cxd2880_read_status(struct dvb_frontend *fe,
 
 	pr_debug("status %d\n", *status);
 
-	if (priv->s == 0 && (*status & FE_HAS_LOCK)) {
+	if (priv->s == 0 && (*status & FE_HAS_LOCK) &&
+	    (*status & FE_HAS_CARRIER)) {
 		mutex_lock(priv->spi_mutex);
 		if (c->delivery_system == SYS_DVBT) {
 			ret = cxd2880_set_ber_per_period_t(fe);
-- 
2.15.1
