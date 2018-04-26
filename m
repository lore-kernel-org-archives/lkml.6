Return-Path: <yangbo.lu@nxp.com>
X-Google-Smtp-Source: AIpwx4+kWk65xoS5/HUy7T06S/aY7wKqQU8hr2UcqYq1+Sq7X3iwAjGA1ocsFtzvPaady7T5Ziq/
ARC-Seal: i=1; a=rsa-sha256; t=1524738281; cv=none;
        d=google.com; s=arc-20160816;
        b=HzqKiuofmYWv+Ub8TRAd9K0Ho+PW2SwYa24htctci/skK+nMwlZL+05qRB/PYH1mnU
         yfMQE+ntL2EDQ0+DEKJ1u7XhatKLL9Wr8wyizzw85SzieX2RMXn5C0d/QIJgxJZDRSFT
         DNy3/9KExtQgcAbQQxzolUqTtOedJOEMZHXOwIc0HueYWkRiiKIRkd09XXh8vVbFLUGO
         YFsb4ATndmNo8NDEjmL4Y5NffMcQ/u9KT/1kztwX4zcRyN0zPzslIkRL+HGlYW+AO7dE
         FBYpvWkHYfkAqyDBJk+XDdAIx5SVCUjTaUYPdh3um2Cftd1lSgx6tOEbKu7aU8se/ocm
         X3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=czQPK2X5yvCjag8Wxt4mcMe0OZIvFdsNAMJ0XBMW6e4=;
        b=o2TbYL1i1hHG9S3c52LVHn5e39i8/x8Klvz1fQ/bmvG4vnztye+esAQCxX58Y6ZxDL
         7PqEZwgesWpYBnqwrinp7HRNXSfixbR+jxjBSqRnsmLjDF4nDrHwei2NnZhVyQZKEsqY
         0TmuRQoLx0Oq+alewElTgpFrQU0rPMJc87N6AyCWgVvoBlCKBynaI5Jm0zqPlecvKbeK
         uClvt/HLJzEzuc2EDj2EMzovNPdSTLcvfXj/hneAmXMmG/1kf8UPvJncQ8l1qyI2TVor
         e/g2Vs2sDeAVOGb3hqjTtGTI94dNxB3hdVK+AZfyW4uy8SJ6Ys5tph7PLHxSbBkgQ7JO
         vjXA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@freescale.onmicrosoft.com header.s=selector1-freescale-onmicrosoft-com header.b=RlL2x1DL;
       spf=pass (google.com: domain of yangbo.lu@nxp.com designates 104.47.32.115 as permitted sender) smtp.mailfrom=yangbo.lu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@freescale.onmicrosoft.com header.s=selector1-freescale-onmicrosoft-com header.b=RlL2x1DL;
       spf=pass (google.com: domain of yangbo.lu@nxp.com designates 104.47.32.115 as permitted sender) smtp.mailfrom=yangbo.lu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=fail (sender IP is 64.157.242.222)
 smtp.mailfrom=nxp.com; driverdev.osuosl.org; dkim=none (message not signed)
 header.d=none;driverdev.osuosl.org; dmarc=fail action=none
 header.from=nxp.com;
From: Yangbo Lu <yangbo.lu@nxp.com>
To: <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Cochran
	<richardcochran@gmail.com>, <dan.carpenter@oracle.com>, Ioana Radulescu
	<ruxandra.radulescu@nxp.com>
CC: Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v2, 1/3] staging: fsl-dpaa2/eth: Add support for hardware timestamping
Date: Thu, 26 Apr 2018 18:23:47 +0800
Message-ID: <20180426102349.45222-1-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:64.157.242.222;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(346002)(396003)(2980300002)(1109001)(1110001)(339900001)(199004)(189003)(486006)(86362001)(26005)(85426001)(77096007)(81156014)(498600001)(81166006)(53936002)(8936002)(39060400002)(2616005)(476003)(126002)(44832011)(106466001)(47776003)(97736004)(2906002)(305945005)(336012)(59450400001)(36756003)(8656006)(51416003)(356003)(8676002)(5660300001)(1076002)(4326008)(316002)(16586007)(6666003)(50466002)(6636002)(48376002)(105606002)(110136005)(50226002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR03MB2189;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD014;1:FFVuyaWk9c3Eoyxgw2NgCpNXG3IdO8li05IkaNURl3+prPSiI6Hyt5CWVLjEphxYDlsD2pdnY0Nsb/P8dls0Mfa5XGo7hItBOd+OyRtAy7lKfSFQVo+NiZIg9LVa57Jl
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(2017052603328);SRVR:SN2PR03MB2189;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2189;3:ImJoj3vQ7PgUZYxbDRcHCekdCBO13087x8GYXTrJr8yowFaicfpxcAkWz8a0PG1iWY+WS+V+xCBEapUNPfq/rtqvUOVN4SDTUxbK/QJ48cwoKz6TPcvbKAs3MtJoTt4HSfgnD5V8Vnmg1Mg1AekJc678LJy2Ee87ATiOxpp5jBkN6pdgKy4n0EEDm9zh/X9GFCvGTAFOPZiMXGno3eUhqAyi9GPikUQ7mIbVGTyfnyyNPAEj/KH6zx4z2own+Vcd90RPNOYkW1JVlFW9D95byvVMMjIt0jys3d4UHkc1TIZ+yMh3VGisHHM/pcfSDRxePCmDuze2KNvFRgdYHggc9x5flaeN/MHwI7xfxJDUPwI=;25:/iJr6gupE5Se2k84fV/JMzH8osi13lIOXd6Uh1tUJ4XQJ04a8sDX0cYeqlULuYDAoeGyG96O/uBEPoDn+SDtKcBM1dY6J/l/SEafrK2Q7o/20zhyb6BIyKlo2OiGHEezCmrrDuH93AkOvSRyEPHFI09z9Q0yWO2zpRlyfBB4ki7faK1EwYdCMoRUMh1BqGQmmlPhVWFdJBU7YO1+xUhr6QU/GtmQcesYcm2znSD0aE1L+xD+403JqkiKHlNlwPT357pNp4Oorprgq78FqXEtM7UTTfNavCTIwPs+LyqKq4KjbrbOJJPQn8pRzfNED49aUWsruGDGW8ShcLluyJQ49A==
X-MS-TrafficTypeDiagnostic: SN2PR03MB2189:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2189;31:ij488BRpj5jnHsBLeZmQP9/moi5Dn5nG4GXvrYvGQTmHKppQx78T5nJyhBIXfyZfcY02SSjDNyHFL9xHESsfi8zLdmpGXFHzpTnrYQGjPQNdT7efVwk0laRrdXrwEOJVT9v/gonUMMFZ2XSoAw7PlPF6me/wk0XbDqIVzY3wXiPdOL/aIQ5WCaEW70MnWfA2j7XNSRciBHLrA3z9cxTcLiFCdOc9SDdDf0MaIzxz+2c=;20:nS9MFpH0xHWTcBh+/ZNHwzb86R5YlFcjAld2ed/E5qwpcpvs/6JNd94yXNeDUJiRzcUrVQBi1fi7ClKzEw392tPT841CfQ9NL3aJCPoZXsXRfYnxNAj79iEyynG1cYVlxT49qcAToZi2xK6k2kDyu6HeLM9Eryc7gHP3z70cxKCFG6RNZjvArKkba6aTGPcahs3TFrfjKejWCVPEDJcyubUruEYBHiw+szPOmMV9jkdkMRPXZkV5orSJGkTNFQd9hD9DjI7POt2HlWLI0OqUdEUEssdfgUxtm8IXKqMJdO8GI1XEi1IB7dMBvW+3QMYWFt7HlmRJePGwhr42osATDWDU5PIonAfImSHdJw1g+K/hNj8U+po5dHCjHnFZu2GcCBbce+Z80Z4+EgVIUsEjEz6r0LG0EP7IdmZDjDFA5reunA40Eb6xtju67j89WImB/sYCRDhWGTmGHiBbq9imH4XOux/2hgrEjcgZTqdcYqUs6ceRUC+VBIeDRmlaZwN4ScrFBYAMOHybgFX/aj8nF1j6wq3KRfLHv0pnlloNrzqSAEgh4v+s+Wr12szhANQDPGlCQ1wNGum3K6xkRMiD/6bzyek/lGqtfBPBoBBmp+E=
X-Microsoft-Antispam-PRVS: <SN2PR03MB2189760065C8B860E391517EF88E0@SN2PR03MB2189.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231232)(944501410)(52105095)(93006095)(93003095)(6055026)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(6072148)(201708071742011);SRVR:SN2PR03MB2189;BCL:0;PCL:0;RULEID:;SRVR:SN2PR03MB2189;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2189;4:b4PLSlAVY2DNutded7C3LbyyUTCHTkux3tJTHXAbwI13HlAEcrvsedQBEQgR9QrBOazX23G02s0+kORBQfoa1cD6+IAxVK7H6GWQONnb0en9rnQ/dMPDNJAdo6rLnY+fEhAeOwqBFft6RdEPvBTrJcgijs813IrDZHiZUYmLZVPwUYU/0Mioeh1GkBTQT3CkDOdZSs3NlFmTyMZW/z6tEZ7101H/aWPHj4QKJ4+bI1Fo5YcIE8ulLEKf1kFS1OoLYhiHyZ/+m4Nsz3vNyHEF4kOGDRWbvFRlD444iBQnQLioEsf+OE68t6Yu04X8hAWK
X-Forefront-PRVS: 0654257CF5
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR03MB2189;23:AIc9eVf/EFF6bWAZ968l5Uu/hhHb+JL2MJLqb5bys?=
 =?us-ascii?Q?Z0P0oItEUe/CwoNzjG/beXcbZo5vSZgxLDJJOxwnAZNecx8SCWukkE0zeIuh?=
 =?us-ascii?Q?nFyio/Q5OtjQGDrmX56HD5QM444PwRbyPCOaW9XYAWpAg8hJwynxRHLNBYTs?=
 =?us-ascii?Q?Rvwdp7bfKaEm+qaLydGsSTP4gT8z8iQLGQsN4w2TDcroqO0LEx+4vMSkwxCX?=
 =?us-ascii?Q?pO+yspRyciYE/PkneKVPklEJ0SWwfmNI99s5LTVJyzlMtglplsztsDPcV8rT?=
 =?us-ascii?Q?Fqbm6VvuK3142OhByVcdAlv+q6zvQh3BhSxh5o+zggJTeuDPPqOOzD1b7TIg?=
 =?us-ascii?Q?VUqs4DTgW1oiHZ/ZcdhIfUyoFrIVTkltyb0MP0Kf6WywLTMGdco2pgLavxSk?=
 =?us-ascii?Q?iY735HHznSeziVk2Xh22viFevqeRi2waalFuhFYzuSMirEk1TQM+NTzdbf82?=
 =?us-ascii?Q?3JXU9lJPbO3uMn+E6He3T2QGBEpv8249B7sgoY2R6D8kV0RrUkc11oZXGkRO?=
 =?us-ascii?Q?8yP1x8vr3O3KSkWfXEY9ScKoWn+T7XZwAWEj1skAkhokw+m3Axausi3fNRm4?=
 =?us-ascii?Q?dwS4DDxwUAIpB/H+w2FZ/K4jXttHgpjJfwRRmWo7iVRUnV3LqRvlHyaMFrJh?=
 =?us-ascii?Q?rVytKg4RD8FocoV3z+/iyRTN2B/6mSsJDue35eX8jp1eV4q87w0qHm3PM88x?=
 =?us-ascii?Q?4lywuVD5CX9x3AuxDv2xzv8Qx5iM7xqUq+T2O15zNRwErztLFIRmazeQVoSa?=
 =?us-ascii?Q?xhnjJhkyaGFmZQbikxkBbDQ8W6ZVJ2EDUwfA+UWjAjfemr1VPc8TiS+GFLx8?=
 =?us-ascii?Q?/U7SHq+ZqT6uJrr1DUIEc/g4Q/aX0S56ynHk9Kqvr8ZMqaX2lwrw0wK7mL6O?=
 =?us-ascii?Q?ifgCKc+HUej4f61eXyj13g+cYgxP+6j09hE09TsMZOzxHyK0i4snGY9K0lrn?=
 =?us-ascii?Q?LduL6WIpZQwjZvpEBTOUzgbNJoYMio0CxuoqVzrickBgEZrsDk6OeziBvdB9?=
 =?us-ascii?Q?mhH5Pu3ZZFwqZUVFdpK8HcFxUpVRfuekJ/lg49qEGhf3aocrsZqewYmKIxQv?=
 =?us-ascii?Q?EpuxPsvGSVOOyZmMu1X99kgNmIfxSwPZELOoaFlcY2M85tsTGbwOaBOhsxsT?=
 =?us-ascii?Q?oq+dYd2VN8fQxwD+WI4WwzGQaCUEO2j?=
X-Microsoft-Antispam-Message-Info: IpuUxBsg9Ebg3eM9nftWUn0VL9F86093RNXYIkNjb9BFtH5XwtihXv26Y4nascxQL5o0IH2Eb9YUYlDnZ8c3KdVMFnU6A543faYrHefK8jgCzH4GTL8E5zCSSHttucz7AW9SkN1ZXWOix+5PbrTsAxKbR/H0ml0IIMpGEZdU0TsTSjWUGsJS2RntRAdK0c5d
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2189;6:m2cs4eZacZNNUd8twtX74A7PBQ9qRKyPZrhIgGlRTMnveBJnFHW4kXpD0zsQc8qEc5cN5FUrsTNMWNyOPKIhoDGBhD82qhKJkE38hNxM0LJx9ulXyl30P2B0IRxR3UrOOtpbh5axEvWw5Ga1n2RwmVxLaDdOApIZwrK+7HtcOWRQ9yXKs+HGP8sWYxBCbvb4zREFBMqiol9cKlafSssWU/QQ044qE83pU/XYgONBqVPUuzgaXmVxoxoMMG3EXeBFjDcfSWzwtnKeGg6cUMmST4D542NObx0JDL0JQenvvBgjQ6WoJPbI7l5dmFvFu5PzFbCoLkgL/3fMLQnujObJ1MMEjpsfW/htwI1xF80WiDxER0Mnn0Jcf2a+QWLrc3eRnEfC/6rmsnYHhg/6LPpFsQNNuTOLxjd5B5+xhcW+9bOnqHAJ1eLv+jLTyBJ7uQgT4S0J9QJYEK4Yu8X/PtyXhw==;5:GcCd1nls8ee/KG+HaqFbtCNGKqej1s+AFlo03WrJyv9pODXnqvjbULFTEXRmfKLlhn7H/QU7TJvLCf283H57jpJ9LO7DnCHELjX/rfmHjtuFJOoL+6DeJ71szK8MyFh4fD7WfMfZJsC3Z3O5GrOzw7B4uLzT2AkDUT49lX/zKSw=;24:sZum5QspHOKSS6ZjEFYmVt39rzZAo0Hvru0lmD4mwtHjsXEkIMbiIup8FDpRaS/5ysH+ejcAbRDkt6jEcErSoukh+z0plz8IH1krtbtMdrk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2189;7:bZeEV/64UfU+beJWpFBKktYwyaNlGpLeQOLxkiegoGfoBaNoQrJ15UXRcRVQ84LO24BjgNFkZyAmT62vrXN5Ff8BGVflpTnLX2Opvp22Tl5gMr6DE3i0rR7L3xItAkvfS1/drN/agT1oKpMGZ96PVfAT+MbEwgNT7Z720qS53TC1+wnJ05pLJpGX/EyYnW8RTWRS/e3XDghnnQ24gee0uTYPNI1+PZwyPDfyAbS/mIRozVXaH3cdNTAnYUuDdj3c
X-MS-Office365-Filtering-Correlation-Id: 3b6f10cc-3a39-4e12-3b25-08d5ab5fe8f7
X-OriginatorOrg: freescale.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 10:24:35.9680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6f10cc-3a39-4e12-3b25-08d5ab5fe8f7
X-MS-Exchange-CrossTenant-Id: 710a03f5-10f6-4d38-9ff4-a80b81da590d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=710a03f5-10f6-4d38-9ff4-a80b81da590d;Ip=[64.157.242.222];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2189
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598709231870413604?=
X-GMAIL-MSGID: =?utf-8?q?1598803967872510916?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ioana Radulescu <ruxandra.radulescu@nxp.com>

Hardware timestamping is supported both on Rx and Tx paths.
On Rx, timestamping is enabled for all frames. On Tx, we
only instruct the hardware to timestamp the frames marked
accordingly by the stack.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- Addressed sparse issues.
	- Used tx_tstamp/rx_tstamp instead of ts_tx_en/ts_rx_en.
	- Used DPAA2_PTP_CLK_PERIOD_NS instead.
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c |  111 +++++++++++++++++++++++-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h |   48 ++++++++++-
 2 files changed, 153 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index 553678d..3963717 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -38,8 +38,11 @@
 #include <linux/msi.h>
 #include <linux/kthread.h>
 #include <linux/iommu.h>
-
+#include <linux/net_tstamp.h>
 #include <linux/fsl/mc.h>
+
+#include <net/sock.h>
+
 #include "dpaa2-eth.h"
 
 /* CREATE_TRACE_POINTS only needs to be defined once. Other dpa files
@@ -275,6 +278,18 @@ static void dpaa2_eth_rx(struct dpaa2_eth_priv *priv,
 
 	prefetch(skb->data);
 
+	/* Get the timestamp value */
+	if (priv->rx_tstamp) {
+		struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
+		__le64 *ts = dpaa2_get_ts(vaddr, false);
+		u64 ns;
+
+		memset(shhwtstamps, 0, sizeof(*shhwtstamps));
+
+		ns = DPAA2_PTP_CLK_PERIOD_NS * le64_to_cpup(ts);
+		shhwtstamps->hwtstamp = ns_to_ktime(ns);
+	}
+
 	/* Check if we need to validate the L4 csum */
 	if (likely(dpaa2_fd_get_frc(fd) & DPAA2_FD_FRC_FASV)) {
 		status = le32_to_cpu(fas->status);
@@ -334,6 +349,28 @@ static int consume_frames(struct dpaa2_eth_channel *ch)
 	return cleaned;
 }
 
+/* Configure the egress frame annotation for timestamp update */
+static void enable_tx_tstamp(struct dpaa2_fd *fd, void *buf_start)
+{
+	struct dpaa2_faead *faead;
+	u32 ctrl, frc;
+
+	/* Mark the egress frame annotation area as valid */
+	frc = dpaa2_fd_get_frc(fd);
+	dpaa2_fd_set_frc(fd, frc | DPAA2_FD_FRC_FAEADV);
+
+	/* Set hardware annotation size */
+	ctrl = dpaa2_fd_get_ctrl(fd);
+	dpaa2_fd_set_ctrl(fd, ctrl | DPAA2_FD_CTRL_ASAL);
+
+	/* enable UPD (update prepanded data) bit in FAEAD field of
+	 * hardware frame annotation area
+	 */
+	ctrl = DPAA2_FAEAD_A2V | DPAA2_FAEAD_UPDV | DPAA2_FAEAD_UPD;
+	faead = dpaa2_get_faead(buf_start, true);
+	faead->ctrl = cpu_to_le32(ctrl);
+}
+
 /* Create a frame descriptor based on a fragmented skb */
 static int build_sg_fd(struct dpaa2_eth_priv *priv,
 		       struct sk_buff *skb,
@@ -420,6 +457,9 @@ static int build_sg_fd(struct dpaa2_eth_priv *priv,
 	dpaa2_fd_set_len(fd, skb->len);
 	dpaa2_fd_set_ctrl(fd, DPAA2_FD_CTRL_PTA | DPAA2_FD_CTRL_PTV1);
 
+	if (priv->tx_tstamp && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
+		enable_tx_tstamp(fd, sgt_buf);
+
 	return 0;
 
 dma_map_single_failed:
@@ -470,6 +510,9 @@ static int build_single_fd(struct dpaa2_eth_priv *priv,
 	dpaa2_fd_set_format(fd, dpaa2_fd_single);
 	dpaa2_fd_set_ctrl(fd, DPAA2_FD_CTRL_PTA | DPAA2_FD_CTRL_PTV1);
 
+	if (priv->tx_tstamp && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
+		enable_tx_tstamp(fd, buffer_start);
+
 	return 0;
 }
 
@@ -520,6 +563,19 @@ static void free_tx_fd(const struct dpaa2_eth_priv *priv,
 		return;
 	}
 
+	/* Get the timestamp value */
+	if (priv->tx_tstamp && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) {
+		struct skb_shared_hwtstamps shhwtstamps;
+		__le64 *ts = dpaa2_get_ts(skbh, true);
+		u64 ns;
+
+		memset(&shhwtstamps, 0, sizeof(shhwtstamps));
+
+		ns = DPAA2_PTP_CLK_PERIOD_NS * le64_to_cpup(ts);
+		shhwtstamps.hwtstamp = ns_to_ktime(ns);
+		skb_tstamp_tx(skb, &shhwtstamps);
+	}
+
 	/* Free SGT buffer allocated on tx */
 	if (fd_format != dpaa2_fd_single)
 		skb_free_frag(skbh);
@@ -552,6 +608,10 @@ static netdev_tx_t dpaa2_eth_tx(struct sk_buff *skb, struct net_device *net_dev)
 			goto err_alloc_headroom;
 		}
 		percpu_extras->tx_reallocs++;
+
+		if (skb->sk)
+			skb_set_owner_w(ns, skb->sk);
+
 		dev_kfree_skb(skb);
 		skb = ns;
 	}
@@ -1365,6 +1425,45 @@ static int dpaa2_eth_set_features(struct net_device *net_dev,
 	return 0;
 }
 
+static int dpaa2_eth_ts_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+{
+	struct dpaa2_eth_priv *priv = netdev_priv(dev);
+	struct hwtstamp_config config;
+
+	if (copy_from_user(&config, rq->ifr_data, sizeof(config)))
+		return -EFAULT;
+
+	switch (config.tx_type) {
+	case HWTSTAMP_TX_OFF:
+		priv->tx_tstamp = false;
+		break;
+	case HWTSTAMP_TX_ON:
+		priv->tx_tstamp = true;
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	if (config.rx_filter == HWTSTAMP_FILTER_NONE) {
+		priv->rx_tstamp = false;
+	} else {
+		priv->rx_tstamp = true;
+		/* TS is set for all frame types, not only those requested */
+		config.rx_filter = HWTSTAMP_FILTER_ALL;
+	}
+
+	return copy_to_user(rq->ifr_data, &config, sizeof(config)) ?
+			-EFAULT : 0;
+}
+
+static int dpaa2_eth_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+{
+	if (cmd == SIOCSHWTSTAMP)
+		return dpaa2_eth_ts_ioctl(dev, rq, cmd);
+
+	return -EINVAL;
+}
+
 static const struct net_device_ops dpaa2_eth_ops = {
 	.ndo_open = dpaa2_eth_open,
 	.ndo_start_xmit = dpaa2_eth_tx,
@@ -1375,6 +1474,7 @@ static int dpaa2_eth_set_features(struct net_device *net_dev,
 	.ndo_change_mtu = dpaa2_eth_change_mtu,
 	.ndo_set_rx_mode = dpaa2_eth_set_rx_mode,
 	.ndo_set_features = dpaa2_eth_set_features,
+	.ndo_do_ioctl = dpaa2_eth_ioctl,
 };
 
 static void cdan_cb(struct dpaa2_io_notification_ctx *ctx)
@@ -1770,7 +1870,9 @@ static int set_buffer_layout(struct dpaa2_eth_priv *priv)
 
 	/* tx buffer */
 	buf_layout.private_data_size = DPAA2_ETH_SWA_SIZE;
-	buf_layout.options = DPNI_BUF_LAYOUT_OPT_PRIVATE_DATA_SIZE;
+	buf_layout.pass_timestamp = true;
+	buf_layout.options = DPNI_BUF_LAYOUT_OPT_PRIVATE_DATA_SIZE |
+			     DPNI_BUF_LAYOUT_OPT_TIMESTAMP;
 	err = dpni_set_buffer_layout(priv->mc_io, 0, priv->mc_token,
 				     DPNI_QUEUE_TX, &buf_layout);
 	if (err) {
@@ -1779,7 +1881,7 @@ static int set_buffer_layout(struct dpaa2_eth_priv *priv)
 	}
 
 	/* tx-confirm buffer */
-	buf_layout.options = 0;
+	buf_layout.options = DPNI_BUF_LAYOUT_OPT_TIMESTAMP;
 	err = dpni_set_buffer_layout(priv->mc_io, 0, priv->mc_token,
 				     DPNI_QUEUE_TX_CONFIRM, &buf_layout);
 	if (err) {
@@ -1810,7 +1912,8 @@ static int set_buffer_layout(struct dpaa2_eth_priv *priv)
 	buf_layout.options = DPNI_BUF_LAYOUT_OPT_PARSER_RESULT |
 			     DPNI_BUF_LAYOUT_OPT_FRAME_STATUS |
 			     DPNI_BUF_LAYOUT_OPT_DATA_ALIGN |
-			     DPNI_BUF_LAYOUT_OPT_DATA_HEAD_ROOM;
+			     DPNI_BUF_LAYOUT_OPT_DATA_HEAD_ROOM |
+			     DPNI_BUF_LAYOUT_OPT_TIMESTAMP;
 	err = dpni_set_buffer_layout(priv->mc_io, 0, priv->mc_token,
 				     DPNI_QUEUE_RX, &buf_layout);
 	if (err) {
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index 54cea2f..ff204c2 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -88,8 +88,12 @@
 #define DPAA2_ETH_SKB_SIZE \
 	(DPAA2_ETH_RX_BUF_SIZE + SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
 
-/* Hardware annotation area in RX  buffers */
+/* Hardware annotation area in RX/TX buffers */
 #define DPAA2_ETH_RX_HWA_SIZE		64
+#define DPAA2_ETH_TX_HWA_SIZE		128
+
+/* PTP nominal frequency 1GHz */
+#define DPAA2_PTP_CLK_PERIOD_NS		1
 
 /* Due to a limitation in WRIOP 1.0.0, the RX buffer data must be aligned
  * to 256B. For newer revisions, the requirement is only for 64B alignment
@@ -135,6 +139,7 @@ struct dpaa2_eth_swa {
 /* Annotation bits in FD CTRL */
 #define DPAA2_FD_CTRL_PTA		0x00800000
 #define DPAA2_FD_CTRL_PTV1		0x00400000
+#define DPAA2_FD_CTRL_ASAL		0x00020000	/* ASAL = 128B */
 
 /* Frame annotation status */
 struct dpaa2_fas {
@@ -150,6 +155,23 @@ struct dpaa2_fas {
 #define DPAA2_FAS_OFFSET		0
 #define DPAA2_FAS_SIZE			(sizeof(struct dpaa2_fas))
 
+/* Timestamp is located in the next 8 bytes of the buffer's
+ * hardware annotation area
+ */
+#define DPAA2_TS_OFFSET			0x8
+
+/* Frame annotation egress action descriptor */
+#define DPAA2_FAEAD_OFFSET		0x58
+
+struct dpaa2_faead {
+	__le32 conf_fqid;
+	__le32 ctrl;
+};
+
+#define DPAA2_FAEAD_A2V			0x20000000
+#define DPAA2_FAEAD_UPDV		0x00001000
+#define DPAA2_FAEAD_UPD			0x00000010
+
 /* Accessors for the hardware annotation fields that we use */
 static inline void *dpaa2_get_hwa(void *buf_addr, bool swa)
 {
@@ -161,6 +183,16 @@ struct dpaa2_fas {
 	return dpaa2_get_hwa(buf_addr, swa) + DPAA2_FAS_OFFSET;
 }
 
+static inline __le64 *dpaa2_get_ts(void *buf_addr, bool swa)
+{
+	return dpaa2_get_hwa(buf_addr, swa) + DPAA2_TS_OFFSET;
+}
+
+static inline struct dpaa2_faead *dpaa2_get_faead(void *buf_addr, bool swa)
+{
+	return dpaa2_get_hwa(buf_addr, swa) + DPAA2_FAEAD_OFFSET;
+}
+
 /* Error and status bits in the frame annotation status word */
 /* Debug frame, otherwise supposed to be discarded */
 #define DPAA2_FAS_DISC			0x80000000
@@ -319,6 +351,9 @@ struct dpaa2_eth_priv {
 	u16 bpid;
 	struct iommu_domain *iommu_domain;
 
+	bool tx_tstamp; /* Tx timestamping enabled */
+	bool rx_tstamp; /* Rx timestamping enabled */
+
 	u16 tx_qdid;
 	u16 rx_buf_align;
 	struct fsl_mc_io *mc_io;
@@ -377,10 +412,19 @@ static inline unsigned int dpaa2_eth_buf_raw_size(struct dpaa2_eth_priv *priv)
 unsigned int dpaa2_eth_needed_headroom(struct dpaa2_eth_priv *priv,
 				       struct sk_buff *skb)
 {
+	unsigned int headroom = DPAA2_ETH_SWA_SIZE;
+
+	/* For non-linear skbs we have no headroom requirement, as we build a
+	 * SG frame with a newly allocated SGT buffer
+	 */
 	if (skb_is_nonlinear(skb))
 		return 0;
 
-	return DPAA2_ETH_SWA_SIZE;
+	/* If we have Tx timestamping, need 128B hardware annotation */
+	if (priv->tx_tstamp && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
+		headroom += DPAA2_ETH_TX_HWA_SIZE;
+
+	return headroom;
 }
 
 /* Extra headroom space requested to hardware, in order to make sure there's
-- 
1.7.1
