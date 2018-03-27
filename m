Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbeC0PH5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:07:57 -0400
Received: from mail-dm3nam03on0055.outbound.protection.outlook.com ([104.47.41.55]:5369
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752490AbeC0PHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:07:51 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: sgoutham@cavium.com, sunil.kovvuri@gmail.com,
        robert.richter@kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dnelson@redhat.com, Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: [PATCH 1/7] net: thunderx: move filter register related macro into proper place
Date: Tue, 27 Mar 2018 08:07:30 -0700
Message-Id: <20180327150736.10718-2-Vadim.Lomovtsev@caviumnetworks.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR20CA0003.namprd20.prod.outlook.com
 (2603:10b6:3:93::13) To CY4PR07MB2998.namprd07.prod.outlook.com
 (2603:10b6:903:d0::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fde7692e-b7ce-491c-4e21-08d593f48074
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB2998;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;3:sq/dx8ovucY6nl8s5Fcwhqu3nLQUywIClssL0v5fc9QM6YWK+LYQnTieSC86c4At6kFCLasjwlaF7qkVALyQ+kKw7frqVIL8skEOSHzYsHTq66URaIZOIiriI1iekwCyxBlgS2Iau98Chp1z9hVZAHAqHYVbD5Xdv4+qnqrqqo/HnPo9meI2mwbxvPCVDZXBiyKaswTtnftMuGI6LKbb2RSO19SCGfmS0VCewCETRvCUWswcLG6IYA8huAWyWBLW;25:6wuFrhVkvqfcXAAqznD528wkHVoHpeB/Wg4TUTWu6n7ug5Cnxe6OuagIzCLBZIsJO2uh+h8o/87jIrnr96O7Vx2CfkeXawTG8B8ydt3Ato0MY0ypLDLJ402fXLgHBdsMbGO5T432cAo8gJhgcLe2gftleVNJN3+Yl2wak8wPb2xTZKI7Xnp5wODtNFcfUbmK2EeYsve7P3zkZc4k1yL3CizNSMI8gFfPiqgUTpLz7/KUxkBYY9oxqa9IwAD7Ikw/bR4q1a7avRSFBzwHH2oSjXF/2OyJpkGezV1Loaj/tzHxTuzaMXROkEv0k2TTjd70zXV0dDz2rRVSQW9wDT2GgQ==;31:IpsZEYyYtI1I3Vc8YjPbnv2d5pD1QAUmpiGg91DACBj1LtXb3Hfhd2k7sU+39Cscw3KcY7wFru2z51/qu0ulQrnCtyI0oQDOUUZ46t0SItf0uAzCa+absvu2hp4XreSw1EJRkuZJOJOeXSk6Cgu8E3YRurJmcE7YzHK+G/xcS0/ChXQ2F8k1dPt1fwWZaiF5RiXlLlGrGw1Zl46aoVIO4oycl2ewirwKcbDjpjspJeM=
X-MS-TrafficTypeDiagnostic: CY4PR07MB2998:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;20:IVbSXQXHTN0DZu+CeIKvBlaBNc2hz7XRDReYFSx0Snq9Vy5ub5M4a/hGq5MVuMJH3+2V6XETbPXxAsCz19RZxnJRShGptoDsOcq/MjbXJ38Y1y3UoTsgFO1gFW6dnycXh3ruYHOvXHmA3/ByMbDGpShsSWYjbN22/SwTnPn17OnV6H0AdG0i7fIVxpsQZ9SwJHEeV+O7RjdMTZx2WKgnhU8xXSUiKY4OdTFoGQf2DQPbBox68Vc6R/xeYosIdIej6qd0Qw3XXMnzEXMWXY4sp0ib4Zd1ZY9DB5jvD/rRZmX/7WYb0PzxHH5ubIjw6M2lL1Jjkx/BkGXfTsLrwrzshIuKllb84Q9A5+fbkcDHIBgWQIEqcEvHxEVwDr/xgImkDzgH4vFC/HaFO+PaoNUYDXoT97K9HvA2mOZQ/YVoJz7jMg1GnaRgE6KXorksHmEdH6ApKfKDgahnjLLrlWhVDwDksV6v9YEqfSGxlNz7KvYUghkXVF9vYhB45VutAKym6A71W7DJhkrTyURk8j+aNgR6dJrG8qAIchS5xGBLocknxrPhnATYJGE7F9AlTjjX3UFFgbJAFshUqSS1wfzbqYkru6gk9G/De7JWvTOxGGU=;4:hml9eA/9d2ZBEhkC9MhDuAJT63B4B4RWTOEA9tX/MhF5mQDS0SmkT33n4qqtwsMOnPqaYqS018iWx4viveXQthnyC9i8M8uwS48kYpvNByY39UJYXeXwwY4gBInd19P9eUeFDHC6mQtGiABhseQomVzz2TSyxx523VJ86TOf48Nh6/J/aBuZBoGcBBY01alNi2OPcEJwGS4wfvI+HwWL8V8OyR7LWP4xPCFvczUQGUzULbuS8dQhRVXdeAVotMa/ePjb4gkhmR3aiGm7zPcnrw==
X-Microsoft-Antispam-PRVS: <CY4PR07MB299800602AE83C31A72FF1258AAC0@CY4PR07MB2998.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR07MB2998;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB2998;
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(346002)(366004)(39860400002)(396003)(39380400002)(376002)(189003)(199004)(446003)(2616005)(6116002)(478600001)(1076002)(107886003)(3846002)(6666003)(956004)(97736004)(39060400002)(50466002)(7736002)(53936002)(16526019)(66066001)(47776003)(26005)(486005)(486005)(6486002)(6512007)(316002)(305945005)(11346002)(105586002)(42882007)(6506007)(386003)(68736007)(59450400001)(69596002)(106356001)(72206003)(25786009)(2906002)(52116002)(53416004)(76176011)(81166006)(8676002)(36756003)(476003)(2870700001)(50226002)(4326008)(5660300001)(81156014)(23676004)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB2998;H:localhost.localdomain.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIyOTk4OzIzOmtDYlZQU2J3K2FsWkhrd3FNUTczdUNiUTIr?=
 =?utf-8?B?aWNwSGlLNzRESlNIeWowcExCdDNsTVM0WFRaZEE2Y09iQXNrbVdmb0t2cXhK?=
 =?utf-8?B?ZGtjRlkzYUJCbTkrbjk3RTRxbml5SlVNSEUrcFREOTI1S0NNbkpOQVUrbnBS?=
 =?utf-8?B?Z0lzSWZVTExDVVZwNFFscTVGeXNlSCtOODY3MTc5OVREc2FuVGQzNnBaZXU3?=
 =?utf-8?B?UGQyOUNHM3FPMG5tdU1Yczk1bUxqSkhoMEtsUUsxU0QzczFUNlFsdjZ5bjdF?=
 =?utf-8?B?MWN2NWRvTEFSbS9VemhIaERFK3BiTngzS3ZNZjJiN2ZuVVNZRGtvaEtHdFlp?=
 =?utf-8?B?S2RWcUoyRE1mTmt0UUxyU0VHZ2pJUExocGVuSUJGcjBiZEdweERoMGMveTBi?=
 =?utf-8?B?ZDlBNnJnOTAxaUZRR2NZNDVtendJNEtCTjZZVzkwL1Y3NUlnSDVDUmZSaS9S?=
 =?utf-8?B?dGdDREJxTUt2RTExZ0tlQW1LcURFK2VDaitGVUFHeU1OUmdFZWYzSGFvSEdp?=
 =?utf-8?B?NEZ6Q0lLT1BYc2ZmaEtrV0N4NFQzb0JqbXhOOTlyYjg4SnRXUzVCMWZZQ2Nv?=
 =?utf-8?B?czJQS0dFZ1BZdXl5eTZYVDdabW94bk9oemdoRzhzNkM0cWthM1pZRUFpcTVa?=
 =?utf-8?B?c2NWaDZiVmw1aVYvcmZwUDNLR1FRQ0phNVlTQ1NoZVlOMTRncDk2dU1GZ2tB?=
 =?utf-8?B?UGl2UFhQQjNxOW1pbDdhcWNiK08wcTVzWktyQ3p6U1hWY2p3TFdTMS92V2tJ?=
 =?utf-8?B?Wm9Sc2hxeWtRS2hKVjVZVGNqZkRSTGRkdDZDRjNHNk4vb3BheS9FYXpweEVy?=
 =?utf-8?B?aUZDeGJoS0E2aVYxMWlnS2xqYWdBbm5xaTBNcTV5UkwwS2RXcXRSdzl2N25B?=
 =?utf-8?B?anBMY3hnSUJwbVdDZlY4Qk9NNWhhTkFWWkwrRGlyQUdMS2ovU0J0UUU3OFpT?=
 =?utf-8?B?TGpiWVNxcVNjdThNSFh6TW41bktOQ1l3cWVOVmduKzdqbTRUbG43OHRXRTVR?=
 =?utf-8?B?MWRXbXJ1TWRaMkhNcW1oVTBTQzBSLzQyWC9vZXJSRG9FNWlzUDdjU3RWMTMy?=
 =?utf-8?B?ZStDQm9LZnExd2N2azBBVGhkRVo4ZjNMYjVBWVprY0ZwQXRJMjRlQU5hWnF5?=
 =?utf-8?B?Mzh6UmZ4bVdZcXRWNU1FTUJBSi9PZ3FiNWR6U3Q3TFR1RmhpUXgydldiQ0Vu?=
 =?utf-8?B?UGhRdUVHSDg4Wis2VUNhTTNWcmZHbHVLcXcyL0l0S1BkY01wNkJETUUyTmFn?=
 =?utf-8?B?aWZzeW5DbFNDbmVLZXFLSlp3UEMwL2pONjVpUnZtTjBhZEtuNmRaQWdpYm9G?=
 =?utf-8?B?clR0dnF0MFhVeUdVaGVsTm5xS2VmbXJXSTJjRGxCNE5waEwzVnZKUEdibkor?=
 =?utf-8?B?QXpIZWZJcDZkejBNemFLcTNxN3hRRlQ5cExRbVg4Z3RqeDRvT3BZUlVJMG9I?=
 =?utf-8?B?VjdTNjJBaWtFQTk4OUh3L2dSdXcxV1M3VXJZZmR2QmE3ZXMyb1FrRTVsU1VS?=
 =?utf-8?B?aXZ5UXBGMnA0Y1g2TVoxMnBHY3VUYS8vdE9nTFhXMjJ4K3VaNWdQbWorTXBT?=
 =?utf-8?B?QS9ieFNLRkxXd3pmT20zeVdZSEdQcktMWmZpMktkRTJqOVhnYVhRdGJrZzRt?=
 =?utf-8?B?dUFoc1B6bWg3Y091TTF4YktOSXp6WWV0dTFnaWZNQkY4Vi9ZaGtTWm4ra3d1?=
 =?utf-8?B?Y2VmM3IzcjIzTmdnVzhrbXpQdEpRaCtSUmZzR0VtU1Z6RFlKYUJNd2ZQWW9G?=
 =?utf-8?Q?TeClFDOe8wIHO5yuM1i2kkeHC1zTz3YKyxc40=3D?=
X-Microsoft-Antispam-Message-Info: flw9wQO39G8CImUpPbfozVNzizUH56GmwjPWc1pfa1jWX5xMFKu2/w5OJhqtTuLignNwKQbHp2wbQbzBXsDf8fNxXBcpMQ6uYF9BV1XgvOc3GwhxSH4vjEFG3w00TWWxfAF9kHRAXeAinrNfGxWH7JvWjOxOcPpLwlNds7sup7goLYTq9jg+rdUc9cbV5+14
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;6:oOrSZGoIlNEEuuXoNQuOO+qjmJw/ygxK6VEYA6aYs3BkMnHtV8epbultLhdXiIhf4ZJ4ZlBecVTr5IDwgJ9wwpDWbrq/ikx4kMPEj0/H08g/9yZQY8uAucNxZfuVD/MQhPjCLJQ1wf+NpxMFECeAfiS8k4qRoU4Y2uKF085oDz6/8PzuYFJ6gWkljVRIe1/PLhD662qyd8Y/lA9NF587cisWDAOZMhH4LWlrbBV7a0Vyopac1au85SPQ8358vpu3JvqyjEn7zO23dTaEVZK3KXoJGQ0pYPzjzZf4pmRKK7qX9RZC0HYG6P+0jY7ffMF2LkiuzVm1zuDkvWDnHCWSTiw01bYTimm8APih/cXA2Qs1DKaXNRNO9Q3/Vs4dx+ZVBpZqVYB7crIc45mjtHSl9ne9aP1pIg7Mb3K7tZiKG02dgD05YQSaM2LdKghPGewl6p28OWM+PKYdp210XWRBzA==;5:0LFy0xKafEEPH+ayMSmEup2YcAasEbAvc5u3c/akuXxePl4/sv4PkraPwHxxYDr7znu6kbuzuAS8hNqlU2UtARHYRaO1lqPUyXRokxMY3+IbB2pdzgnkNlKDao9TwgR3qp8G6Z3sFlkEPa2VqGCfujWpweR7j+LQvEzFj6r+kHk=;24:dzaSuErekMjYUWNBXVWZJvWSucsnx8khAt1W50MZDoeJ0Y4T8sf9k9HbIOCHJt465FqWdiAQwqa5btsFLYSWn6IdOucCENKmIIl8ej2NhTc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;7:2xPGzLiCReqvOMCPef3yEDO7GGQ0zIuR1+XtCYN12+/tx5c0NEKGzeHm0TU6T2gjHtw97i2T4eEQDdWO8nOhiPcR31KsWl/gHzjjA27FpafBKt0Fp3OJ43oo6rJsNPF9uat15HslWIMocDLM8Rb8YBQTQVkPXbY422kfymRYp8KHXKXHaeEtvHAKBQHcBWE1MietcfJYBryw3i21XtPFPLSOCgnHBrS/gZW844FC0SJXZ+CDPRO5Somls040y4j8
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 15:07:47.2952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fde7692e-b7ce-491c-4e21-08d593f48074
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2998
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>

The ThunderX NIC has set of registers which allows to configure
filter policy for ingress packets. There are three possible regimes
of filtering multicasts, broadcasts and unicasts: accept all, reject all
and accept filter allowed only.

Current implementation has enum with all of them and two generic macro
for enabling filtering et all (CAM_ACCEPT) and enabling/disabling
broadcast packets, which also should be corrected in order to represent
register bits properly. All these values are private for driver and
there is no need to ‘publish’ them via header file.

This commit is to move filtering register manipulation values from
header file into source with explicit assignment of exact register
values to them to be used while register configuring.

Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 13 +++++++++++++
 drivers/net/ethernet/cavium/thunder/thunder_bgx.h | 11 -----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 91d34ea40e2c..0dd211605eb1 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -24,6 +24,19 @@
 #define DRV_NAME	"thunder_bgx"
 #define DRV_VERSION	"1.0"
 
+/* RX_DMAC_CTL configuration */
+enum MCAST_MODE {
+		MCAST_MODE_REJECT = 0x0,
+		MCAST_MODE_ACCEPT = 0x1,
+		MCAST_MODE_CAM_FILTER = 0x2,
+		RSVD = 0x3
+};
+
+#define BCAST_ACCEPT      BIT(0)
+#define CAM_ACCEPT        BIT(3)
+#define MCAST_MODE_MASK   0x3
+#define BGX_MCAST_MODE(x) (x << 1)
+
 struct lmac {
 	struct bgx		*bgx;
 	int			dmac;
diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.h b/drivers/net/ethernet/cavium/thunder/thunder_bgx.h
index 5a7567d31138..52439da62c97 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.h
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.h
@@ -205,17 +205,6 @@
 #define LMAC_INTR_LINK_UP	BIT(0)
 #define LMAC_INTR_LINK_DOWN	BIT(1)
 
-/*  RX_DMAC_CTL configuration*/
-enum MCAST_MODE {
-		MCAST_MODE_REJECT,
-		MCAST_MODE_ACCEPT,
-		MCAST_MODE_CAM_FILTER,
-		RSVD
-};
-
-#define BCAST_ACCEPT	1
-#define CAM_ACCEPT	1
-
 void octeon_mdiobus_force_mod_depencency(void);
 void bgx_lmac_rx_tx_enable(int node, int bgx_idx, int lmacid, bool enable);
 void bgx_add_dmac_addr(u64 dmac, int node, int bgx_idx, int lmac);
-- 
2.14.3
