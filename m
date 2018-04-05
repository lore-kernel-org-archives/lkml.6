Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbeDEO6R (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 10:58:17 -0400
Received: from mail-by2nam01on0085.outbound.protection.outlook.com ([104.47.34.85]:57668
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751353AbeDEO6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 10:58:14 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: sgoutham@cavium.com, sunil.kovvuri@gmail.com,
        robert.richter@kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net
Cc: dnelson@redhat.com, gustavo@embeddedor.com,
        Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: [PATCH] net: thunderx: rework mac addresses list to u64 array
Date: Thu,  5 Apr 2018 07:57:56 -0700
Message-Id: <20180405145756.12633-1-Vadim.Lomovtsev@caviumnetworks.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR12CA0069.namprd12.prod.outlook.com
 (2603:10b6:3:103::31) To BN6PR07MB2993.namprd07.prod.outlook.com
 (2603:10b6:404:a7::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c40448b-077e-4195-21f8-08d59b05a71d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:BN6PR07MB2993;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2993;3:QweQbUyK64E2yy2IFjj9VNVcn34ZVHHArrPOcIZ7mEdJ6yInmS1QMJ5njdoQSXYI3LG4vj7vTHsid754PgG0idc3oJ4KuzyzpK/DyjgZS31l0AZ722JgvyNLoYOq5FIHsJsYANPV0mLMMPe6WNHnlhkv7aJoDbKvrGOqwdIKqAoCnK9xykpL/GE9N+ByK7U+aSB66d6jdLGj4GeEwonzPfn9kMyteubpn/XbfTgjYSM8plfgz2UBXhJdwiwWu0lV;25:FuM4Q3SlhSUsqudOKZjpAR3WwveTUbOJMZy7CXS7VgB0eMEF3Y9n8MAY3wLO9+E2+x6No5atxqiBBQl7IUr/WjGyODBp2W8eHeN+4MYUEwpvUtlf24MTNY5TwVhTF22y7XQLPKcThIsjQrGoM4Zx2YKDok5wmqfmLXebkaG6+iOIm9OzTTOuwtlAysbJCvGk38S1JqY9w+QHSnJB7FCFkZ6gJuUDXMu5cuBG5387fe7ix+xe3Httykvfcovld1q6Bf7rLrNbSg2WGmKg4dDRZfGB7nReuQI/BJQWO4G/RlhaCD7Z/Elz0VJzFxL72G46d4Fk3Kwb30HDnhvmomNyaA==;31:oyMnFRnvnOShAXGBBL6eefsgH+4oCvSI0O/zYUkVgBSyZPRGetWKn/mI5STd20I6ocysIFIBGxYYGf3B+8txdhGpcq/Oo1dAaf52DyxvltN9oQwazowcdeb61Jnggst7dtRw9seTfKAA8GPlMsmr/ytri73y6tNXjYeCRvEFUXfM8eQcE1zzgeb/LXcBUPUbGQdDTcsQ8tj7Z0zFop65qRiyCaw/jjPpT9m/1rN23JA=
X-MS-TrafficTypeDiagnostic: BN6PR07MB2993:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2993;20:NZcbIuC0Y3brucbo3kw5/j2eZTNsA3DZ+hNFOLOS1h3CktATZPJ7IQbnYLLiq8m8uWnvesZnXq5qwcLrw1VnZCMWYdy8/riOCrUguj0rDlV8x11pSIw0etjXLwyOGdrkDY23boprrKpSdDHdvnTPM/kOIbUD3qhbJYl2BmLyy01LazZyqMEvJgOBKciYRG1RJIxpHqxexZVeoKuPtXxz5I5LQpENDBkhKLCdRRSsPCWIwitux2h1bgYLTDF4a9NIh8ddeAKSCaa9BbC1+WLpRDzLsO5u/4IC4KiADyNRLMCCDPX0CXK2QGTO/cDC4Z4ovAcBCtvozXTMjhxvZcwJzULDxh52MjJKenz9E20EmKCd76VanrOa9/GWmRX0/Qut4/QOj/23jy85Qs/DqjZboAL52orb5qvt9ztI/tIzZldz4dm3mfqWwGFGwWosPbZDWstVwd+yrqdlpz338Jd+mKcHaBtjG9xNu68LFzl6YGojUlDMxhhmwj9j2VbCpkKGPmnwXh1hi9fdj5lKWg4AO2dbxveKq6cBAk3RL+Ii2wYpLLnsPsgCvpiI8DDlQzQXSZHC4EsYC0LpfdvUXkdDDdmUaKawS3eIIUONVRqtpW8=;4:qyQMgMK42z47P9A/HLWk8o5dBpKkgBHT9HFw39VW3mqGEtAE9FJheUs6hQiQ2er2ntZVpYur3yBvM0I2O7olBTbschomZqyG49LcGnS3xdxbK+n50PV6fH+EGONDz7K4w/mQqbGASuYeDTKy2j/+imLIPkcmjDCbjNxSmImPzRIr35meHoxzMOY+7fVuo2QHQzoJP2L7kvF/UJIvn9CEawgKzEdy0xYmfzbZeXP0htAaJoelweUq1N7AgQR+MtrUEjCkgJAGcWzNNJgM5mwziWri5OaC/717LEVC+w8kT/O/53A5ltCTW9o8geKUJ6du
X-Microsoft-Antispam-PRVS: <BN6PR07MB29939CB3B15FCAC924764B9D8ABB0@BN6PR07MB2993.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(277106579953875);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(10201501046)(3231221)(944501327)(52105095)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR07MB2993;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB2993;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(346002)(39380400002)(376002)(396003)(39860400002)(366004)(199004)(189003)(97736004)(6116002)(36756003)(6486002)(1076002)(16526019)(8936002)(3846002)(26005)(2906002)(66066001)(486006)(16586007)(2616005)(386003)(69596002)(476003)(6506007)(316002)(50226002)(478600001)(81166006)(956004)(81156014)(59450400001)(5660300001)(51416003)(105586002)(42882007)(68736007)(25786009)(48376002)(8676002)(47776003)(106356001)(72206003)(305945005)(53416004)(53936002)(7736002)(6512007)(39060400002)(52116002)(50466002)(4326008)(1857600001)(6666003)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB2993;H:localhost.localdomain.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR07MB2993;23:De8vhtMlcAuXCZn4P/14GUNzBywL9zXLwvP5pS2Kg?=
 =?us-ascii?Q?lDYi1oqfgny+5boRCJy5556N7LrxYFY6qSolv01w8boOU6GdrojEzcMzLsiF?=
 =?us-ascii?Q?iu7bxccHMDvz6Dsw18PGkIczsazh+T0WCQEVVfadZurhO4LWZojDhpkad2ub?=
 =?us-ascii?Q?TN6oIitD89xzFzqgiuE1RG23dWWAbk9pUL8esMI+9Kozjh1aa58KD731dhBF?=
 =?us-ascii?Q?ptRNA0gcWgWFUWY444F/1AVA78YDpUlPfqpmj/6+RokEQkjjOL9zoiluzo+G?=
 =?us-ascii?Q?NC0gfMkiDWIcBWJiPw8GRJEuay3xUZJJl3NuoQM6Cxo46yWOtzKdkS0Co79+?=
 =?us-ascii?Q?fCDF6JYDsdmNy9CTDEdyF0LxAXRKo/BD4hcfkZfnkzP54GHCARxiGHV0OBUW?=
 =?us-ascii?Q?a0rZP/8EXDuRgNQIxdVw7BslxB62sNUhzKFuWQlQcnV0xcr9dvu1HzANfavJ?=
 =?us-ascii?Q?jZ0rP50eAPii9MtpOCe5LD44shJNYVR2fQ4DjSDUMwylZrzUdftNc506/efd?=
 =?us-ascii?Q?hVs+jUjzG3lURMaIUrN4Tkm5/wozhBsMmvvbGaNqsDv1y2EsHQQBbEl1v00W?=
 =?us-ascii?Q?9ktiP+0A2wVcKTxiCHOEQm7kX4yQFeS2Yud49AQKK4n8gaYEvalJseSMGtzN?=
 =?us-ascii?Q?jNt1JLHQv9/wO5/wb2D9L3aNsHVyPmWn/BWpDetgMYzBIA+F3H7BCHl+jSG3?=
 =?us-ascii?Q?N37peVpfQTCCg+C+yBCrndXktsmZtXPuhc0lwNCPERWSQf9vbFIYZp5HyQUM?=
 =?us-ascii?Q?brY/oHWJ6UG2fSW09zedXg00FYsAMnOnwWXdBprtpePjGQArBPGMf41FL+dz?=
 =?us-ascii?Q?RW5nO0NRFi3p6L0wjAkVReq26mcUK4fEbsJSFCsUnxBw3souB+OBDlN3XFj4?=
 =?us-ascii?Q?nh4mU8R2A2YWbJqIlG/MdH/6rKJff/CjHl+YP+2m0Z+pwP5l/h20OC3kyVyA?=
 =?us-ascii?Q?p049SLDbJs7adYyShkURmgLX/HUPRO+AJ0ozAiVfyX9pVKo2Zuay5fsAq4a2?=
 =?us-ascii?Q?Ucf5neW6cA++HyyfUPOrXZla/BcArZjyUpYOXknD2MEw//c5wNYmwnrKHW7H?=
 =?us-ascii?Q?SYvbma8bqGSWb7LQszY9Il4Ua/pz2B177Ie574mi6/Lj2TB2fY0H3C/mfXH1?=
 =?us-ascii?Q?u6DDVw63IuVipHxbqWrkMPmzdpjgPif+DQ6rRkmuTc323rsKoSvTsfgA2kgl?=
 =?us-ascii?Q?KZeb7JXSKCOwC1AY7L7RbPuD/JcF8GYWOp/3GvMFPLawqzaX9EdCtSxNDY7K?=
 =?us-ascii?Q?gpYKUbJ5K7CDeBJvxxPFYd9b3tkKtMLoVoQxhXNO2JcLatVixZeZcslJbxv/?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: ul+3zUISMSCt5WeXm0RHTeudnL1TTVHhaV57IQae8o3e4zQAKqwIyVboQVfk1Jto0I5lVNHK+QZ58ICOU6EvZ88NwIIVr84pJjpwj9TX3m1u/y35GM9nu3nkS0xKolT4F3+8S5pYT+sx6zqdhOLoa/qBTsl+p6MYNa39sF/hxG+o7/gVXJS+S0jSvm8fNduZ
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2993;6:QWxoqhSr/LyZUCOrEXX50eghG8FOfbroeLt0k1cIO8wsHjPOsjLbZ2aBB+4YyI7vYHguPwBneS6oaDGC8ZCbJcNbvFoc/4Ni1OjuyKeromM2OyI4FUEPALlcIVSdPCS1RdM2VB+V7B3Mp0CFfEBNiUzMXueIhZeFXgJonSfHWUIXVMkF6zv5EpQkc3tC7pIpN0Tx8HfpYx3ORWlCJDCBNvc/dmaasKXMV8OeQcpG1HjGsmc/NcgFka1OxlTZQLrPDk2lW8GMbXpoEPs8RNuNxL3IZfg6MvGZqfCkM3UsD48HbSXFsWHnEtGkqndufn+1UFYLf0HIa1bJ2OWdxVCsdnbx3AB9WpSZvlf9qsb8hXveYSnIlxYJcAApgmH8sAtS8XiSiM5s+wxcUYcuXWqMMtZ3BEa5+qrOEyldgwj7vCTRHHBuEUIdJ2BYwnTjqToe3hJ4l8VyD1gf/TSRsKeP6g==;5:nmWRJAvCAwwatnHLUOZso31uV/dqWUUfvOeo60KAcAjrvzMoIJkYRrnBIBw4+3WeABiQBPJmK/nvshuRX7F7EpmbRimcOX0tl8oWjB15+/+uQTG1Gq9enFmD5T3pePqq7J+8Y1+uHwyglHAW1ovsTbsumXR0tS87D6AC3JuWGpw=;24:6ko45ZJepESfe+cZOEd8WX5VmhsPrWrzqqDCsRpYmdi9D5C79WXLSt2L8MNokKs5XA1fHBFNoXbJeazGde9kFAJ4AykP6dKYGt6w0NEDmS0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2993;7:yZ3Rrav+Mi1bKTx5PNeHuKiyceskPBjS6jEKJhfSMCVvNAMZjwW4+TeDuvAJPF/m8MxhiLTjJqk7odFukr9lnAtvfzfKFwS6q39jyRsuPTATA/J5vZFif7aHJ7lJOrjWJ3CmsJej2JqJLbJJnNcKtMAki6P+uh7ZPYI7JpQZ8juB3/8jM1gRwvm/LPtOlqnrlcnJ4b/U1zPC4Fcb2WyZ6ri+9QT0qB/UyDuNINUkmbm32k8aXck+MRovJotduxc6
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 14:58:11.3700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c40448b-077e-4195-21f8-08d59b05a71d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2993
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>

It is too expensive to pass u64 values via linked list, instead
allocate array for them by overall number of mac addresses from netdev.

This eventually removes multiple kmalloc() calls, aviod memory
fragmentation and allow to put single null check on kmalloc
return value in order to prevent a potential null pointer dereference.

Addresses-Coverity-ID: 1467429 ("Dereference null return value")
Fixes: 37c3347eb247 ("net: thunderx: add ndo_set_rx_mode callback implementation for VF")
Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/nic.h        |  7 +-----
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 28 +++++++++---------------
 2 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethernet/cavium/thunder/nic.h
index 5fc46c5a4f36..da052159f014 100644
--- a/drivers/net/ethernet/cavium/thunder/nic.h
+++ b/drivers/net/ethernet/cavium/thunder/nic.h
@@ -265,14 +265,9 @@ struct nicvf_drv_stats {
 
 struct cavium_ptp;
 
-struct xcast_addr {
-	struct list_head list;
-	u64              addr;
-};
-
 struct xcast_addr_list {
-	struct list_head list;
 	int              count;
+	u64              mc[0];
 };
 
 struct nicvf_work {
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index 1e9a31fef729..a26d8bc92e01 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1929,7 +1929,7 @@ static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
 						  work.work);
 	struct nicvf *nic = container_of(vf_work, struct nicvf, rx_mode_work);
 	union nic_mbx mbx = {};
-	struct xcast_addr *xaddr, *next;
+	u8 idx = 0;
 
 	if (!vf_work)
 		return;
@@ -1956,16 +1956,10 @@ static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
 	/* check if we have any specific MACs to be added to PF DMAC filter */
 	if (vf_work->mc) {
 		/* now go through kernel list of MACs and add them one by one */
-		list_for_each_entry_safe(xaddr, next,
-					 &vf_work->mc->list, list) {
+		for (idx = 0; idx < vf_work->mc->count; idx++) {
 			mbx.xcast.msg = NIC_MBOX_MSG_ADD_MCAST;
-			mbx.xcast.data.mac = xaddr->addr;
+			mbx.xcast.data.mac = vf_work->mc->mc[idx];
 			nicvf_send_msg_to_pf(nic, &mbx);
-
-			/* after receiving ACK from PF release memory */
-			list_del(&xaddr->list);
-			kfree(xaddr);
-			vf_work->mc->count--;
 		}
 		kfree(vf_work->mc);
 	}
@@ -1996,17 +1990,15 @@ static void nicvf_set_rx_mode(struct net_device *netdev)
 			mode |= BGX_XCAST_MCAST_FILTER;
 			/* here we need to copy mc addrs */
 			if (netdev_mc_count(netdev)) {
-				struct xcast_addr *xaddr;
-
-				mc_list = kmalloc(sizeof(*mc_list), GFP_ATOMIC);
-				INIT_LIST_HEAD(&mc_list->list);
+				mc_list = kmalloc(sizeof(*mc_list) +
+						  sizeof(u64) * netdev_mc_count(netdev),
+						  GFP_ATOMIC);
+				if (unlikely(!mc_list))
+					return;
+				mc_list->count = 0;
 				netdev_hw_addr_list_for_each(ha, &netdev->mc) {
-					xaddr = kmalloc(sizeof(*xaddr),
-							GFP_ATOMIC);
-					xaddr->addr =
+					mc_list->mc[mc_list->count] =
 						ether_addr_to_u64(ha->addr);
-					list_add_tail(&xaddr->list,
-						      &mc_list->list);
 					mc_list->count++;
 				}
 			}
-- 
2.14.3
