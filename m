Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbeC0PIJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:08:09 -0400
Received: from mail-dm3nam03on0071.outbound.protection.outlook.com ([104.47.41.71]:25088
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752664AbeC0PH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:07:56 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: sgoutham@cavium.com, sunil.kovvuri@gmail.com,
        robert.richter@kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dnelson@redhat.com, Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: [PATCH 4/7] net: thunderx: add new messages for handle ndo_set_rx_mode callback
Date: Tue, 27 Mar 2018 08:07:33 -0700
Message-Id: <20180327150736.10718-5-Vadim.Lomovtsev@caviumnetworks.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR20CA0003.namprd20.prod.outlook.com
 (2603:10b6:3:93::13) To CY4PR07MB2998.namprd07.prod.outlook.com
 (2603:10b6:903:d0::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60712497-d9fe-4c24-23dc-08d593f48270
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB2998;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;3:IWajrchsw3SSE5RK3hDgCl7w1hlXGCI0PNlH1fXND2U67vLLcF8YuO8eXOoPNtx6fUxc8scp6fEmoRgCQOL2iKRIwMG+Q1JN7d4TOtspuc2iDThL+tNxNssMASnzfiDhZD4Lvm8MHCVUtSumfPn1ADWTnVZcYaJu4uPOwIzwUeUtpjUEWWzs9dfs2WbgPhtPR5cq/2Sm6SZagOQ8wWHnRJYLqp4WkBfEj9Tl41IDOD2tiR3l0DKXzmws/Z9Yo9Ao;25:uGw2zUA5kFAejFmZVhC9EwoXcyEjvbJvQTZr50Z0ZUycSP4K+WDnlC4BCftQES0UkYqOVGmJ412LV9oGkDxBvvfyTKR2owycD8+qXKnXAszWd7k33Z0/01mIX+Hnl0J6V4B6UP0/6mh0wzTRV7QqNL0FkhLxv9cEoxGpx61I6Zdx/s5GvLS4CX4yUERFZeLLdjCQKV7eJSKdDmq08chU6Qff18TFvl/5m2K7I7GFLQ0CZX9rs1kk1boG/3JeM2QtbhhTSKTfEsLsvgIapVgQJSa9Ku6F6BAUt61JZTO+NYPHd9Rabunbu7pxEgcsg2PbK4uRGe4tGH6zPU4q1WEPuA==;31:Jcs+bZiJAFkB7bcHHl8sXiTOP/XmHedpxeub7CZfjWGfNFkrrG4D7fdPLCW/+RrdUfYk5Yqo2uOBgNCTaj3xGF4zMOWlT9WvHpRZgYwruvSohhNkZCB0FsWR5OA3WjjpKLsp6VNs9qG3SBsWR694YGqUcXXbwhH4EKC7rdCJxBlfzkaNR3aPSc+LnE52ODsmjd3mro4Kr+UM12FvdN6SCbeuSx8SpdrqJgtGeikNj4U=
X-MS-TrafficTypeDiagnostic: CY4PR07MB2998:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;20:gF8FdnIapn3i8xZf5y7SouzsWnsODI/QbkTdub0WIRPHWOC3IrqA5OixzRYgdZQA8VQ7emOQiR52EUVtq5oC4wH+Pcip4agyU2EfTWpJj2N/psjbift52qaCRdjdJpukX89mREuD4jimzhopZazjEkT46LLCUybd4dBJHDgzQQwnV+SIVavILqOA3OA9uINzQzYt378sUmKMf35ppsp04Bsw5IVTtlqBT4FRRRaeGA/yC83lAXyDPy6JX28WWHVaTFgc3FZJWr/H6Af3YT568J2YY0LmninBZ0wzhVy3KypLANN2A7GHEP7VfeHnnpEZM6ybVlHZpoELdAM8G+BQfQQLxojpVi0lD6rjwbryS489+8SjTILJ2LYdBvLBjzmRKEC1oHMlq/I7rkLo4wDvOrUgv2EDFHXOpUsIr5uHDb+kzvr/54GFohpD9Dxhk4vUrlBexOo0G6Vnr7i2BrxIEyFyQDIcFzsh4g6blfEa57A27xuxCuKu7npYpnis6wX/PImGDxM/6HxPdP2eeKKYlHGVva3twnvSeawVAMvcsti5EnF72laf/QGLNyIFCoMF9TOKsKL1xLrxYl5o98KMDWI95jq6UcIwYSNcnhqLJ/4=;4:buRdzQ9P6XNLdt58IBT2wBKi8cv+kUVosJRdUNXB46jmeihfOOpYo7cLPQjXwSqXJmpNODkQuQXWeX6FYs6dI7RcJNl/JZ27N61U10GU10BV149ZjSX/mGxH0ksDorgB4N87s5LitEwam81AaSPXyblwaY6Z1jVEsLYoBwFXBRwwBdXuG0jEroy7Ffv7Rrx36wbNSkjjHSsUizDNy5ncYrnPKeLBNo4yFS0c5qkzh2M3a2+iB4Rkv8akSAx1A+81VuktNY4qoueQfO0mCZCILA==
X-Microsoft-Antispam-PRVS: <CY4PR07MB2998EAFD2B5EFD3A2DA6E8278AAC0@CY4PR07MB2998.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR07MB2998;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB2998;
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(346002)(366004)(39860400002)(396003)(39380400002)(376002)(189003)(199004)(446003)(2616005)(6116002)(478600001)(1076002)(107886003)(3846002)(6666003)(956004)(97736004)(39060400002)(50466002)(7736002)(53936002)(16526019)(66066001)(47776003)(26005)(48376002)(486005)(486005)(6486002)(15650500001)(6512007)(316002)(305945005)(11346002)(16586007)(105586002)(42882007)(6506007)(386003)(68736007)(69596002)(106356001)(72206003)(25786009)(2906002)(52116002)(53416004)(76176011)(81166006)(51416003)(8676002)(36756003)(476003)(50226002)(4326008)(5660300001)(81156014)(8936002)(227083002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB2998;H:localhost.localdomain.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB2998;23:iftj53Vfx2Px2+Gzfcs2VcQf9oZ/lZU49bElGq+Be?=
 =?us-ascii?Q?cpguT7LQ2BwA1I5EXC38RAdPoCGccHXPwwRu5tzyrVHF4JLpyPtynoZ+DKP+?=
 =?us-ascii?Q?qklD7C+DWRS3rbgAkOuTZKCivAuAjpSVj8XNC/3Vw10Obs3hHzewZNnSdGUa?=
 =?us-ascii?Q?eG+U9ak4fKQgTb/LZFDIYmO/unpRT7ppMr+iBJvnoLlh2lphGXnsloJhNq2/?=
 =?us-ascii?Q?JPWSdV47T049VAJXbn7X40TQx+6Bs0O5kAuv8DOALkvDFSbk48og0WuUcAQo?=
 =?us-ascii?Q?GV7UdsAO98CI0sCjk7katlZ8iECOdn9d5JFwAWbcMGpfPC4J6E2vLjt34N5+?=
 =?us-ascii?Q?0DsPG2+t1uTXxftvtWD/GRgxHM2kPeV2QG/lPodJUE1HYUyg/yU6tnRao/+Q?=
 =?us-ascii?Q?wHitm86hug3QffQrD5TytR4/9SHaOzSyKQ0PLak487TC98468Vom40a7p9Bx?=
 =?us-ascii?Q?q++tZLeS3a3B68qM4GKSk8olPAoXoLhggbh8/TgTLEQcWA6Etj54nosorIvs?=
 =?us-ascii?Q?hst2rvEqTaUXhav0RRF8JEpO00LTWGoliXhB+uisdBXPhCfPL2zsNufNJHno?=
 =?us-ascii?Q?MeGiWs9vYLCL6pyDR5GDOR6Y5GnN9HuAO1b2W0eVH4jYZzptKHtrY8B9DJrb?=
 =?us-ascii?Q?JPjEEDjfE+KrmBzEW92o6IZhrEZ7K27UkpCbRNgCqouJ4tkwYuKPJp7lHdfE?=
 =?us-ascii?Q?otGLzdlRQX0poxXX4A8hy1sHo+H2wyAcsY9YwNFqpZaVZM2B2mpJeHk9w4CR?=
 =?us-ascii?Q?+HyHzLIfXON32ayu4AFDQzMJmX+NbMazmMU975vt26hWerzZZZOt7Z+zULT+?=
 =?us-ascii?Q?8zNLJHSE+FNqteV7e3gz3wix/C79aaEmnCQbhr1xUAEa1pjTpYFl6XENP0PQ?=
 =?us-ascii?Q?MHCsxKuuSPrru4B43zjxf2wKnXl4b+AvEcd0KnR2YRMMNljla2uxWW7r4O/l?=
 =?us-ascii?Q?jYdZY8dkT55i1isyHY9hdvVs8dlsiOl1I5xoVporXFu+YUyOeqiwgVtb59cq?=
 =?us-ascii?Q?rnTPrVR/visTQ5zIV/+AF3OA9ChAWnvlYhdShXQaOF9ED9VR8jru87tGsNrW?=
 =?us-ascii?Q?vTcK5VQAIpigJXnorpUJCd1ujJ9Goy0JkFp3uwlKgMIKJRYTi8oQh67Vm1j5?=
 =?us-ascii?Q?PKBJZ0nCxoFfDQXdhtjZgk+PCDXqPOU7F9L8SDqaKTqISWHcg8QY8P2vsG6Y?=
 =?us-ascii?Q?s6tl7VSHpeDImootVabO02ZraeWGi+DBo5o3iwm292i8Xwr31JHXHtOvlHRO?=
 =?us-ascii?Q?LwkyC4cKovMs/pyx0ABlXv8LhuYjlnoqNSRK6q2QEImZ5PrJ2nuVABTy4IHu?=
 =?us-ascii?Q?4lAVYcTBk/fABX4Q/ah++nNvwkZ9K8HZzZL4Z0qLw0pGdY/B3lgDzQWclcL8?=
 =?us-ascii?Q?In/jA=3D=3D?=
X-Microsoft-Antispam-Message-Info: E51OcB7zyceuIJwm/vlx5HSt93syzs9kNMhItbAk2U8gXYclQiTYIDBksCAVbnUYPJSjapHaxJYZBFsaVZqHSJ1SAG4zdVhYtspO1Jj3/IrLsWba8sKF+Yng2q6eKEMk5RCze/oATO3NK8Q1hkTuLfQSVBMoo+InBgYtK1LSEdHsPVYdusRRfjqyX1Sz9BGt
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;6:dUZQ/0fIEZvkguP8OXmNEX9/BhFdr9CflU9+v/VN4wJpGxPS+P4meZu5s8RTPZ+sv0Vx1fs2yb+Cp4VbgIkLZUPSi/YTO7z1WU0k85V66/LD/BdlRMH/PNjQQ4pywJDFfHHShqtaBNRIgTr1xrLuonP10Fl5qEGzvcMJY8zJRquY0MyllCSry2BLzPd3/qaRejdtTmp4LAg8HxnDVL7uMbdvvcOgRbZ1Q8t/bLgRN8KTigDI76tUo10pwVprv+S9gOzyOsuhG+bKImWzATsZ8R1aV2U5luWnnTUOFcSS1+22npkpbLfLApF5QUWCB1e5vfZ3PAw1jJ3k0/PoMXAviqwMagK7cNcFKKpDtstG5ycTxxQAV9wnPuK9mFjcmWhjmJ0eEdio2GUD2STq3NAxLMtno9hrTQOYIc4m2hOldx/843ABbJybuZtaG8JYJk0vtqIgxUfeLLMi5lnrb79MOw==;5:YfV1KZpwjocYcTRmbgA+a9g0iDB2tmq0tskA96MPWA3QJ7Iub80V+WvQwqphg6cTq6jfT4tX6oa7yAOlkl6NaQx1OenBaYBYCH8emz5Eqb7jFEPRTq2sYcIzquarIOAg5SlLHRdEOZQzNmM4Bft0X1vjx1heuC+Cdvv3IBtUDzs=;24:yidTgw9c1b7aF/CEXhyfCYtdEwKgwCpO7KZ+qXT2RLDKSxl9qqmbBgWsTwuLiB9OXnJT1M9FZNbnN144a8htjPUxKGucVTaX2WpmnOInUAc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;7:gou52bsQ7vY15ZBxXCGgTRt7svtek7UOgB9+x8xSiGhvP9gwxNM7C3tsSR2bf5iMPQO7iF/we+CtNQbfYSn0Z1f+cuv7/Uvs9w+k9X3JY/BK/y+xz62Z9Vh7HElpo2PeZaim0wsn0IQvoir6j8R4UIGQ5NRZlu1hvQz1otgz4iOpzarLj0S6Ky2Xsib/8cHsOtHoLphy8cqqjVxGINIXfzj8QSC6meRDyU3WN6rVYtNgo3pn31NS6BJgQ8WyMrp+
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 15:07:50.6233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60712497-d9fe-4c24-23dc-08d593f48270
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2998
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>

The kernel calls ndo_set_rx_mode() callback supplying it will all necessary
info, such as device state flags, multicast mac addresses list and so on.
Since we have only 128 bits to communicate with PF we need to initiate
several requests to PF with small/short operation each based on input data.

So this commit implements following PF messages codes along with new
data structures for them:
NIC_MBOX_MSG_RESET_XCAST to flush all filters configured for this
                          particular network interface (VF)
NIC_MBOX_MSG_ADD_MCAST   to add new MAC address to DMAC filter registers
                          for this particular network interface (VF)
NIC_MBOX_MSG_SET_XCAST   to apply filtering configuration to filter control
                          register

Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/nic.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethernet/cavium/thunder/nic.h
index 4cacce5d2b16..069289b4f968 100644
--- a/drivers/net/ethernet/cavium/thunder/nic.h
+++ b/drivers/net/ethernet/cavium/thunder/nic.h
@@ -403,6 +403,9 @@ struct nicvf {
 #define	NIC_MBOX_MSG_PTP_CFG		0x19	/* HW packet timestamp */
 #define	NIC_MBOX_MSG_CFG_DONE		0xF0	/* VF configuration done */
 #define	NIC_MBOX_MSG_SHUTDOWN		0xF1	/* VF is being shutdown */
+#define	NIC_MBOX_MSG_RESET_XCAST	0xF2    /* Reset DCAM filtering mode */
+#define	NIC_MBOX_MSG_ADD_MCAST		0xF3    /* Add MAC to DCAM filters */
+#define	NIC_MBOX_MSG_SET_XCAST		0xF4    /* Set MCAST/BCAST RX mode */
 
 struct nic_cfg_msg {
 	u8    msg;
@@ -556,6 +559,14 @@ struct set_ptp {
 	bool  enable;
 };
 
+struct xcast {
+	u8    msg;
+	union {
+		u8    mode;
+		u64   mac;
+	} data;
+};
+
 /* 128 bit shared memory between PF and each VF */
 union nic_mbx {
 	struct { u8 msg; }	msg;
@@ -576,6 +587,7 @@ union nic_mbx {
 	struct reset_stat_cfg	reset_stat;
 	struct pfc		pfc;
 	struct set_ptp		ptp;
+	struct xcast            xcast;
 };
 
 #define NIC_NODE_ID_MASK	0x03
-- 
2.14.3
