Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752787AbeC3MCc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 08:02:32 -0400
Received: from mail-sn1nam02on0075.outbound.protection.outlook.com ([104.47.36.75]:14287
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751431AbeC3MAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 08:00:23 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: sgoutham@cavium.com, sunil.kovvuri@gmail.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net
Cc: dnelson@redhat.com, ynorov@caviumnetworks.com,
        Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: [PATCH v2 1/7] net: thunderx: move filter register related macro into proper place
Date: Fri, 30 Mar 2018 04:59:47 -0700
Message-Id: <20180330115953.17154-2-Vadim.Lomovtsev@caviumnetworks.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180330115953.17154-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180330115953.17154-1-Vadim.Lomovtsev@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:102:1::16) To CY4PR07MB2997.namprd07.prod.outlook.com
 (2603:10b6:903:d0::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3da2e85-6800-44be-b58a-08d59635d023
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB2997;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;3:c2M8P1lhBuPgdTyyNWtqdb3kJqin17bdOjz8Bl1pf0F3SVJa1Q5dqckOFWy4I/p3LNMnQu1R6TTOYODJRu/ZRS2GO533d84O8Ym8IjGSxha3Z8ye+H01ckRzhGkeLKoAbvZyMzTqVzgXOs26MGerz3WPMu0kHr9WtozDrxOMyJeolB07SG68+XbaP8QcnMlvIbXDqw7Yyx93pDLTacO/0oXyNqr7r4kqXiOcPCE7e1bQPfWqqOAs+UdPjxZxXYrt;25:7CopbPjstZeSRgiMRqS4xShZInWW5Zo7uN1RMMB5sj0tE99OgHUMYpgSriVsFKUURxcv4orOgn/rfO2/tpv4/ukWFkZlIWZxfTY4rCZJdMx06IJMXTca0vRbiQkLtlXt9f8ryev2LIOqcwIVzFFo/icVRBzGIWuaXAW+C/k1J9x+MAX277q6fJwGUk+gBXK5kjMyCkpeU2s/0Kr/ZGszdDfe/EXeljHwgOCBFPaj1tR3896jD8Yflbr6N6Jdv2LSFTe7c3uNMmUZ+7IVolxyos/lwl/uF8Y2KO+XLcpSkBpFts21tXk8IEfbTO7mBNyulFF4lRQNWAu+VA5pW2Nu3w==;31:rqEoVOW6gFDicq8Rua3c/SJruGMNzCKRVsN+X+35AAlUy9k3yrlQvarjhIu+oz7XuDcN/pXhvlV9bpS4zeh/PuKrjFz/EEm7p52yCJOGoqMYhk31Gmes6/VLee66sp7dF3skg0KGEGA4TiAgckOP7yVCHUcwQ69IrMeJ1jhVCLxKkUDTMmTMvaZyON/RjIpjBSJEK9hCj1+Optx+Jbab2A+MGJJn0QQ4l78upx350hw=
X-MS-TrafficTypeDiagnostic: CY4PR07MB2997:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;20:MGf3wrDNbN36kT2TPVlBYwdx/o4GUdLYR3Z1d2T49muN95LagaQkNWcDA3LVraGBHa78V0rEnew0LXzxRmSXPSrNKlm1j4WoINvhhmaQm5+1uwhA5PtNNK2dmfe5bH7+Z5DvSZu+tj/vjfzwjtNpfp6HP/yxkj9KYGRHCb+dwuFvAgg1LdPsSu9d7jbTAmRef4BIbtuJUV9xcgsXhFkAZgd08Kxca6ops4Ksjwjc4HKh8phx1lDhybXsnU9LRO+eKYAHhmIp4b5jZavK+UWs/vbMVSSK2MFnNd780I+y/dxIwiafnzn31Hi3NHT/uop10TlbM/6sG55yiMFC4irk/eOY9cUNRZUgo6KHxphr+2RmcW6UGoRFIgRSJXItiLD/uWnQVjvGqgtrxU+tS6zlK4ffXDe0hSkZrkbJqcDIbE9ms3nTXkMOHhvUq2L5faqzVFsuYYz3ntISG0ecJBDPokOyttsO5gT40dN09h/g0Z1KhQCxFV5lOfCeXQXC3eUFZPCORGwIOI/yZ5uq/etyc2I+SWVX34AVUWZ6H403h6Km9Kzm4Y6sSnERNeBlSusyN/ioAVZl5COdx4F3SKBgpaEkax8RSPeLNBxYMe39d8c=;4:A58f9YoH1xRPpEfEls7XfLL71/ioMwfbSYMVZkcUK0LlCyWNAmLyVWymxVDOJ488aKa+TMwpm1AJI4EVJAcAQ5XiLKw22r7k1Dz/6awZSLat0DXTLW+LPiZe/iNwYeYoi1MCFbljz1cB3KkrfspHbCB0L4m7/Ci5Ng9VYw7emPaA/PRqeZaO0VFIodBGjq7JxSCWYhaNvs0Qm+II+fGAVvGwwlIH8i2FOiCbAsQSEFi0gq8xtPWkiM1qEd9KANjRUdqzOTJDrPNHp/tfF8LEMw==
X-Microsoft-Antispam-PRVS: <CY4PR07MB2997E307633A53AFF2CAA2248AA10@CY4PR07MB2997.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR07MB2997;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB2997;
X-Forefront-PRVS: 06274D1C43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(376002)(39380400002)(346002)(366004)(39850400004)(189003)(199004)(3846002)(6116002)(1076002)(105586002)(81156014)(81166006)(8676002)(50466002)(53416004)(5660300001)(52116002)(97736004)(23676004)(6506007)(8936002)(59450400001)(76176011)(386003)(69596002)(2906002)(6486002)(6512007)(72206003)(39060400002)(6666003)(47776003)(316002)(7736002)(106356001)(486005)(486005)(476003)(107886003)(446003)(305945005)(53936002)(11346002)(2616005)(66066001)(16526019)(956004)(478600001)(68736007)(36756003)(50226002)(26005)(4326008)(2870700001)(42882007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB2997;H:localhost.localdomain.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIyOTk3OzIzOjUvUjdVcjF1UnVnRjU0azcyUDZ1VlpOb3R2?=
 =?utf-8?B?ZDdmSWdsUFlHeHcvM2llMEhQS1pvNFRRRHdwQmpoWlBlMU5ibTMrTnJJY2dQ?=
 =?utf-8?B?UmJKSUdjczI3Qm4rbHVUOFpkenpRb3NxZU9Ra0JWMFZCVnRVb1BoSFdYVEpS?=
 =?utf-8?B?RXBuTWt5R2hmLzFoeXN4WGlaZU9DNjljdXFTdmp1NzhJTzJ2R1NVNlNKNWZy?=
 =?utf-8?B?TFYrOURtRmFrT2lsT2RJTEIrZkNpV3dURlpsMVZqMlZxckFaWFRTcXYzM1px?=
 =?utf-8?B?ZkgwYTNmK3l1TmZLa3hnc0RLWjRsc0Z1ZFFlUndWaGc2MzI0SWhYUFFXalhV?=
 =?utf-8?B?Vksra2FLbDV0SWRwWnNuYm43dm5mMnFkaTlFeDBBQWhtMU1ZOHJFcnBhOXFF?=
 =?utf-8?B?djlpWUg5a3ZTRlhHOGV6ejUvdGk1endlWThLaWx1N1JyekZBWE44MnJpem02?=
 =?utf-8?B?UDhlWFBka21hN1JLZmpEWFhyNWRwbnNkVUJGaTZQbGFhZFBNQkhQQmIrSGRG?=
 =?utf-8?B?R2YrSG55bFM3bHA0cE8rR01zcFlOZTJ2M2F2SnVlQm5EUnpnSmJIQlJjRkwx?=
 =?utf-8?B?bXBKRHZPYzdUUC9nOTdybjJzUGROeHkzLzRDaFpDaDdZaTRmRExJdTNmeUdV?=
 =?utf-8?B?ci9mZXRDY3l1OTJmTDdOOVY0MFZCZzB1YW0rT3RFWUxnWVZ2ams3OU9SbWJt?=
 =?utf-8?B?eTFUYnYzUGVCWmNrT0JXTzJubGNzR1hOTWJHQkdYaXlNOS93S3JyeWhLUklK?=
 =?utf-8?B?c0duK0tUaEtkUkp3RW5UeUZQSVlxTDBhTnkvWVRYdmRxNVZjRW9BY2dRenV1?=
 =?utf-8?B?aHBqRFBzQTlGeFFZNi92V3Z6MTJ2SGVybWZTdlB6S2haOThTNFNOUVF1ZkVQ?=
 =?utf-8?B?d1p1Z3pCbkpGNndxcUF0SnJOTTlvOG5mR3lsaVlHWjNBR0V4dmVRSHZocG9y?=
 =?utf-8?B?dGVvUW9wYWNRZ3dwNFl4blc5SkQvVllEd2JPZmM3cGhId3A3MXZWTDNtY2du?=
 =?utf-8?B?d0hYaFBzZ2FLU0YvZEhubnV1RS9UY3ZyYXFEZVVMYmwwc0pxR2dZSlBzKzRS?=
 =?utf-8?B?cHBpTTdwc240RXIxem5LQWI0ek56aEtteklIam04eHpVRjNYY3pCR2trWFBH?=
 =?utf-8?B?emJvcW43aDRtU2JFa01xc0p3aDVEV0N1N0FWK3RaMWpSVzlDN2wwTVhVbUFk?=
 =?utf-8?B?NFlFQXlYUUpiLzdoQVZEWEt2QVdKcGRDR0ZMRUJGTGZ2bDhjZFIxaFdxLzA1?=
 =?utf-8?B?QzhUekdMS3c1dm55QWVKWDZaTHN3NllHcHlXVXVBdzRpMlk4aUtGUjA5S3BJ?=
 =?utf-8?B?VmswZGkrMXJmMENDcXl3WTJ0M2Exd2JVbmEyWkFiVHNxR2pYMFhld01KM3M3?=
 =?utf-8?B?NjVVR3Bha25XR0lNVXl1T096cUIxSlpGS3dDTWVWYWQzWUgxeS9KeWZadVpB?=
 =?utf-8?B?MzM5bXZ1dFdhNWI5SkdQbWNacXVsVDFncUtNUFpsVVhEeERSRnFRbGJheXla?=
 =?utf-8?B?MTVkUmsrM2NkT0pzNVIzOFhiMjd6WFJ3ZGJFQXVOeEhkRjdjNHdMbmhaaEhm?=
 =?utf-8?B?TEppV0hIUHRSSTU1ZnlwS2FPKzd5TTY5ZC9VaXkzdWNHVjd1OXR4SE1PTTl6?=
 =?utf-8?B?WWttd1FNemllZm9Oa2hEU285ZWVhcUwzcStvUUtTdDVMdFpiVEN1L3ZQUC9Z?=
 =?utf-8?B?ZUZTVjd3T3NTVkNlUm1LQ1NaemV6ZVJObHpCTCs5QmV6Q09NcnhGMTlDOU5Z?=
 =?utf-8?Q?PVFK8osuKpYN7bza9v5iHWXhDcagqq/rJwQjc=3D?=
X-Microsoft-Antispam-Message-Info: uGjBkdaoWUzB1UB6DJWGibVjbewACS2uSTS0zgtEoZrcKhGsQhr5sRDfVlLSoEzP00jGUh5qu6/BB9jV4foTvdasDiddCy45ckugAvWLNjpshhAMmi/BDdX0TrXQOQ6+sIEJJHXXdQwgY2phJrJ0+Nv75vhpfy3m2uT0HkO8Uj2NS2rX66Du5Wi0o4REP+Sy
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;6:uoOAT7mNWJ/3mZYFQiFMDWd19Hn9dI2HiNS+PllpzzirEiFrlb3aTsuFBJxGFgG6FDkBSlyvjl9NdCpyXr6TXM6ySyWZuik3MKYSMPztoCJew6f3cg6UWa8dlHLN5Lc/jLtoEQpHJDYdHhJFfwZ0zwghNiXFdC0QjxUzLgp1p7NsA0IQRQbZZ5HXANp4IDGaW5voRRiJzbB6jVWhnKJ/h75Ea86YdEuWPv+SaqUQTUOYDmHjTOx+w5sA8K6cmwIP05biGERClWeUjCZVsJ0wSjptuNt+Fi5jHnSYpmI3Z1tZ/jtFWtDfNp12eV+K87fzNYsp/ASFJFf6EaBcnFb01GCwE0iwSw3Bm8k508Vqo0DHvCX15nioK2ONwySDBxBaKIHTar/LuOwlz4rdHTRuJqmWRTZcSX+ODERe4eCPn3KTmmLdFGLk3Etv2DFzvPXD5sW+g7ZDoDzwgjjDftCHDw==;5:iuWMPmBi9fAYnnAGwbndkfauLgjA2beso5i7uxeKoi3WiKkRqPvBTXG91oTOJa0nZekOJ9jR+9v0tejVKYiAAGh/rUmKSDFTVPttUTw8JVCHK2EWrqv4x8rd2OZXl/J9RtUSGGGVnT+BtG6dmIr7a6FAVFgmtWkeA64lTkFXg4Y=;24:VmSfi56etO8Fh48lzekRV1acznLdouzotIPQ/T2YhYxaRI9QpThLKIL2gzpF/8CWBtFHWqWJXYjZ05qJEh0NzZESDKBW89nec3rVT8MqPQE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;7:x+oDln04wiGZW4Eb7PwaD/XVSLoflX2nZmxqPgEqW28iOy6s/FvmUG5rbsNzEcN1ild3juBdF1fGLDFMvOXMDdxjCm6L5cNAwtvIqyJGAeYHzb/vveVyyj6hpEzzsLSAt8Gaze70B7O9gUVxoDrXq4ft18WRrkYA0QT3PVG8Uyx4r73Mf1yoVaSKTIR50qSxEFKaC9o2KUXjjZAgz44Ovm+881jsoZ101KHG+FNUFrUS5OBGcFJ72cs5LZJeojeY
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 12:00:20.6602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3da2e85-6800-44be-b58a-08d59635d023
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2997
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
