Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751838AbeB1AlT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 19:41:19 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52248 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751521AbeB1AlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 19:41:17 -0500
From: Howard McLauchlan <hmclauchlan@fb.com>
To: <linux-kernel@vger.kernel.org>
CC: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        Josef Bacik <jbacik@fb.com>, Omar Sandoval <osandov@osandov.com>,
        Howard McLauchlan <hmclauchlan@fb.com>
Subject: [PATCH] uprobe: add support for overlayfs
Date: Tue, 27 Feb 2018 16:40:14 -0800
Message-ID: <20180228004014.445-1-hmclauchlan@fb.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::5:5758]
X-ClientProxiedBy: SN4PR0201CA0055.namprd02.prod.outlook.com
 (2603:10b6:803:20::17) To DM3PR15MB0540.namprd15.prod.outlook.com
 (2a01:111:e400:c477::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebc9a04a-1a08-4e40-e7e1-08d57e43f485
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM3PR15MB0540;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB0540;3:uSUVYvqrplkOiEZ6oFXUuQPcOf+0VDZ+Id8O62G+SkrITM1ymDtcgtiB5+zhITkrkT4zs9sIbmdq/kdLr8QUNcKHYHrPWEFWt//lRunAt6R+PqL7mAhhZTW9WZv++X2mbp+rvNwb0Lo2rKiaWMj2frrARXILdVAHcMuX63B7q6whvMmrpqVqxP66MDtTNnIaOAukST8LK0YfZJYMXSmFUgIL6Ik4+28aNKssQMDL8Z6WMsuV42JLFK6CJrAfMylI;25:SFN11rwLUzuIRGDaajHeDSedjCT4tNAfGyQK0gKMxBhcqWAh06TL0j3ACpNlNl5GDfb9UDrM7DtqcxczG/PFcjnFwVf7cNA6s91cL4z8cDX35hYjfp5f3HLSLii874l7MJ4o2KF0HGlv2qN+o4uFk87SD69uAvEFunaSSjP5zdDDC1LCtNrO1MvLsi41R5Wwvs+fu8Ts8tBodb8Y+5FByebkVRM7VyeBI4feMEeQmMv+5ZwdJl9AWiFszHa5bXKazRqBR0g6yNd1wxgGvbEwWUlad38djeFel35Neq6HJ1VwjCmFEctVKC0P5cOFz/meRn5a7O0VotwMBQTz8EPm2iu5a6krq1ukjTXB26ROHOU=;31:FCNcTN2y6YIvyiYpqRLlmoM1NQY11kpx6ibG7o3G9TAfT3xshGJdOSHifbwUZF6cOXFStbgEdTdlCqrXcZoLY0LEUniuE+rm6DLnkTccsMiaEvB8u87g18DwHH54SjqlUGLc4oKxkoUUKYHM59e504oZor1oJ9avWyr3nrlz6p3hdRgdguuFqqnB9NWnJ6FZ1xLqhWVa/ovaA3ak3u9VRrq7h0J5C9debu5VzCVb9hs=
X-MS-TrafficTypeDiagnostic: DM3PR15MB0540:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB0540;20:yjtoBr37ZgMFHktf8Gb3NCQ2dmCfLTxeBGSlPXoKm02aMD396PfO3O9qJchipnzGCo6CuJTkqyiMqgXlSRfGEGxl0/q/r+iTWahv519/SPbA4TWe/PjpPwOlpsLo6UzqqfNP9Xr+kheAfbPplBvJBZ8wXakRq5Cp5cY8ZasNrG/2JclbJWVK8C/Y/d/HsT75bS1eH/CXwQ6sNs7OiX2++oUC+zQOg34cp0p1xpbSEQQA0qaoxNP6BPDgOApUrRMedSWiYrDQi3W9EG3R8/VJR+SjXy6Sn5gQqFBXQlhyhfDUwAP/0A8SzLWBQz+IFo4k9pYIxaR0LOpjGRpmBrqS02H4vRYS0VN1BtVAjyytWxvbh/MXY0sWaHmJtp2ISAk7A8wbnEtcSoPxHMhYyYzSZuywerBDjidPtyL0nwVsrpnVP1W4k6j7sPPT1BSnCeRpS2kjRAD5SEDE25ZXM+Naxs4vGDkCTNP3GEU8tJDZnH19/LBdFOiiYtcy1D6fVBpM;4:pP0rHTb1GeWd6R30ckmKDFkQQCa/ksD/nvYhjVIrS0TB/3EwqZd4CmIfKg4d/uz5rc6Xqgtb8JzjJpjMtKtd4FTcVwW0A92espdkcP0mLjrX1Emk8wOo1k5oRABpX64Tx9aiuAjCTq/8nQN3J3rElclEGkyzLEmX96fjtdSY+NeEs1h27bcy9oPvdgi48RVX7erWlmS88S80OI1AriJBPzAZRUDBTiCX+LfYb7PnFk845JYj+fG3EA5ny0iXx3nUhcelkZPnxQjHIN7jqAqPXS/I/6u6Yl6jxKNKEk6fxUDoCLwr2H/nQlkIPUGvltJU
X-Microsoft-Antispam-PRVS: <DM3PR15MB05403E0B204906747DDC91C5C7C70@DM3PR15MB0540.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(3231220)(11241501184)(944501209)(52105095)(93006095)(93001095)(10201501046)(6041288)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM3PR15MB0540;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB0540;
X-Forefront-PRVS: 0597911EE1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(39860400002)(396003)(376002)(189003)(199004)(8676002)(25786009)(81166006)(53416004)(6116002)(6486002)(2906002)(50226002)(8936002)(86362001)(1076002)(105586002)(48376002)(305945005)(53936002)(81156014)(36756003)(6512007)(68736007)(50466002)(106356001)(69596002)(7736002)(478600001)(6916009)(6666003)(2351001)(52396003)(54906003)(16526019)(51416003)(316002)(5890100001)(47776003)(2361001)(1857600001)(6506007)(16586007)(386003)(186003)(59450400001)(52116002)(5660300001)(4326008)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB0540;H:hmclauchlan-ubu470.thefacebook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB0540;23:UMJSbT75Z0RwNDUzyvSHGjZI5Zw2P/RfnQudDD4vo?=
 =?us-ascii?Q?6LCXBf1lUQQAOch9ybg6x0MnGlsrR7j/48GRRusG92jftStkAznsH8pg2Mqx?=
 =?us-ascii?Q?T3B0TQwb+HFKJyJ9TlA8bjOA5pWkE8YfOPyZ3C7pb5k54go/xZ1xhi3DMooI?=
 =?us-ascii?Q?2hopIRs4mhwKqs7I33m5NJYpJkl9HeQxzFowKtL6h1JiDV20qj6WFlzRHVXr?=
 =?us-ascii?Q?GX0igAMu0qaY37ncKMiTSveS6ArHUtdm3vuDL5YfGXPvkDzg2REX57LfjEeW?=
 =?us-ascii?Q?Ms42IkaVpG2yHKB3bRTxgvGt/8W/Jgt2yMShuLhPFVy1HzQNc0t8BQUUAGMW?=
 =?us-ascii?Q?Sl0GEeuzIPXMsGgjhGN5a7NQq2+0cs4PCQbvxDtU5an1r4u7SA4xPp1+cIJU?=
 =?us-ascii?Q?dRQ6B4/eyk1KzJ8NgnofmLIIqn3weTw/AgqRVsHheYaTyOsfm5KBrRGt3Qdy?=
 =?us-ascii?Q?NQ1LQR2BkZifFJ8PXKyfBp6BKkJPB4GWjUXXKbxAexCzNPT7ASXFiWMeA98i?=
 =?us-ascii?Q?8HP3tLmTi/Jdr0DDK4t3Cf2M2o0ZMZfHZjBhbbFMc0oKJfT8pgbGFjLbCqjw?=
 =?us-ascii?Q?Vx1Ey+wFfVWspoBeL6SwzCt/BNaqbNXS4iqhJmCVjFbG4FNdkqTZAYMcd/3y?=
 =?us-ascii?Q?G7jLorOEqLG31gELPmpCI4YiwyZv9wqbn3/QkdOwcWXFcJFSojmEB5w7LuLh?=
 =?us-ascii?Q?UgJ8kzHl+R6m7WKqxw/75awFkbmWjXnPtXOlEA2mDFUTc9O1wi5rXDusFsye?=
 =?us-ascii?Q?3E6Dc6ORmjeRbEf+TC1ZmybISjf+el2I6FRXnuIcT6MDxYBJOiA5tMFEXNpx?=
 =?us-ascii?Q?CojajToQfFvX82WuljwFsiPcBUTuucHgLgh5xFzGwBHxX48iJmTufkZF+OYI?=
 =?us-ascii?Q?l1109fMnF7wbSpOsorFNNw6R2VldoB4TV4ln5edXJ5NxyfqJ7lBk3HOktbKJ?=
 =?us-ascii?Q?SRPVqpaSG5XzyXYUKVUnCmN6ojGcv2M2afwJEPDsPetq5jbwqyXNRIe8NX/u?=
 =?us-ascii?Q?9E09CLKYUmoEsalKHcR7kQaQJqH1RQsQY0Xc634dAh1jP3kGhuvK9fJ19h0F?=
 =?us-ascii?Q?vI7eNOTWYcuJs4VmFUIkt45WWPTey8ym71X58w8NROobN2GnHLlsdPrVUVzz?=
 =?us-ascii?Q?jvTModYTfTzOqqFcNRrcPvZZMPvvXUerdDo0IaroYM/VI5yjarR792OuTVKV?=
 =?us-ascii?Q?ydz6vpC3rn0gKughr+GiVxq9TbewN6Ck1UVeeJl0CTsIOXR4f/Fshj0Pg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB0540;6:Ndtg9Z+TUHvn/IohdBljARMI9fQ/t8m0m+trZWVLH7Z8j6Mch+/IF4Uk7PFWsr9yr1OVUttJn0qzPuGiW8oBDQbM0YRxjHwl1JygKmZdQBlC2mZajWbcPPLxDtC3wKMbE+2JHTXUWQnRWCYYCamaIDfiBGClCL1j7P2fiQkKccgozzUe5ni/m7X6wxnb/67b5tfv6TvZ+8AHyxF9FEslu5omFAN3SKGcS9Ymz4mX0RskprEKQFFQv0anH29i/GxPjyRaJRBIAAWOD4v39B3tmXqRq1duHFV3LFbgay+RMc0A0s9pOKm5VVwVTLPVCH1+NNRun/nNOEbuDd4zinsBt5NoasYzxFGCl0vR7VmD+W0=;5:sOk2HGqUzc20we8oVd43kPqzUFhyoLjxwAYw7q6uKeD2AlKmxxFYfua8CiT5z429x1c9iVVXpDyWYqAS85ZFM6a/g5lmx6p9m2CMbYMvz7HpnKs+0S6U4DlG7sxi0tzPNzGbql6ajrJbwsT6oaykgIoBmtXqi8u3tnPrqOTqeYE=;24:H4w6w8sEA+KNk1oSfU+u4qMEimyo96vzSUyLusYNkpeakettX14oqKFFrxlNMzHVh1bzz01KljAce/ZNCq806V6DkKIYYps5CXzIfV680/E=;7:P62eYXWORNWiYgtKO65waS8O1hBF0k3fiwmeTbAyguJ1UOTzMOWIHRFsoe77K2kS0ZUJunBnR93j7AhT/4zE0zjgD9zZ+aNkeMBz1DR/8+qRH30/Js3nS8z5D6DHbTtT/0hpWjVjXm7qI5Cyv5S2IvFeRt6QYN1qOHsy7npcMdoVe2MvhwqGB/50qMTHwC/giKx1sYSLIaBQNkEI/FDNrqHZZsJhfjAAZhgHN5eyNvQ5nw8bf651aaB/rmGzJOHe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB0540;20:LwAHN22bGTCpCCyPUYG5H7jTwhFsMGuzxJpqBlUvrFUrzEei3OUVIZZ63yEpsnXdFQPTbz6lcITHu8bOHdP4FFPxbCCbjaVXgbLsoU1n24iOZ5ohlHJZuOhzO3WMLbCFA8TY8Pf424kBJCXoOYMvHzJfwNSer7SDKBi6natLDr8=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2018 00:41:06.3586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc9a04a-1a08-4e40-e7e1-08d57e43f485
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB0540
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-27_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uprobes cannot successfully attach to binaries located in a directory
mounted with overlayfs.

To verify, create directories for mounting overlayfs
(upper,lower,work,merge), move some binary into merge/ and use readelf
to obtain some known instruction of the binary. I used /bin/true and the
entry instruction(0x13b0):

	$ mount -t overlay overlay -o lowerdir=lower,upperdir=upper,workdir=work merge
	$ cd /sys/kernel/debug/tracing
	$ echo 'p:true_entry PATH_TO_MERGE/merge/true:0x13b0' > uprobe_events
	$ echo 1 > events/uprobes/true_entry/enable

This returns 'bash: echo: write error: Input/output error' and dmesg
tells us 'event trace: Could not enable event true_entry'

This change makes create_trace_uprobe() look for the real inode of a
dentry. In the case of normal filesystems, this simplifies to just
returning the inode. In the case of overlayfs(and similar fs) we will
obtain the underlying dentry and corresponding inode, upon which uprobes
can successfully register.

Running the example above with the patch applied, we can see that the
uprobe is enabled and will output to trace as expected.

Signed-off-by: Howard McLauchlan <hmclauchlan@fb.com>
---
 kernel/trace/trace_uprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 268029ae1be6..8b86d76c55ee 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -446,7 +446,7 @@ static int create_trace_uprobe(int argc, char **argv)
 	if (ret)
 		goto fail_address_parse;
 
-	inode = igrab(d_inode(path.dentry));
+	inode = igrab(d_real_inode(path.dentry));
 	path_put(&path);
 
 	if (!inode || !S_ISREG(inode->i_mode)) {
-- 
2.14.1
