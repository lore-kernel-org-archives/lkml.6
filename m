Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755424AbeDJXK6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 19:10:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49548 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752735AbeDJXKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 19:10:55 -0400
From: Howard McLauchlan <hmclauchlan@fb.com>
To: <linux-kernel@vger.kernel.org>
CC: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        <kernel-team@fb.com>, Howard McLauchlan <hmclauchlan@fb.com>
Subject: [PATCH] uprobe: add support for overlayfs
Date: Tue, 10 Apr 2018 16:10:30 -0700
Message-ID: <20180410231030.2720-1-hmclauchlan@fb.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::5:53e8]
X-ClientProxiedBy: CO2PR05CA0097.namprd05.prod.outlook.com
 (2603:10b6:104:1::23) To BN4PR15MB0532.namprd15.prod.outlook.com
 (2a01:111:e400:59c3::26)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN4PR15MB0532;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR15MB0532;3:3pglOatTFbaWLaQG6aJhgAxdi7uoUatibmrloU/iAPP2I6yq37I0r8+CcuMtgfBELaNEK8aYbs03hfem1tbuWnp0DtTgOETiIgtqzJ/48Ggz0ImbCBFsBdLL9zwCWmU9MoW0hKNsA6/VVtKmb3I3tA1jgnf2BxiKzyYLfP1urGRJYHV15Qcm3j/7cPAMCxExsipyMHOf5hQ0I/oW37VExscRaFQLemyPfhBQ2nj5YCgy9IzGU9i5Zp9wVVltGkHK;25:vjyXStgvAbm0QX986RMH+bxOFnkmxLfUZ4btsbWSUe6k0NH2oEHUg60IP45hMDadlU+E8vcoqZg1Op8QPxcy/Yrf6wCYCPzsnm8Y+o7Px2EC18HcMBuM8A6fXGexnOYRAkWpr/HV4PVbBDSCKEzWWnEiTQ16uqT5iDERmJ/m7cuSAmen4vcrEZqh4p7DsSK3N5EwiBPP83SVXRMcLkJK7EAdtUJr4PNU2hXA40suLpQd6VDw5C/ofTo44u2Fw08F32XWrPBOOpl/XxNW0cfDNAfzlQlwE/4l14KFbMuZzr0rsy6k4TMy/uPvqTKXNayvo9p472qLcGQXugxgamVnndp4Si6tCyyA7csbsbkNZpA=;31:XkVQ2x/TkV/bfyv/Gwy0TYSEXPW8ySche4chni08oryGvFA6oyH2ZPTE2DtHefNUmIiSOV7LzIO2CeoVFZ8W7SVDRroSep0xricNJHgjB25L5uIZb7E7jO5HXIwhwS3LJkAXnxt0r/hDzvR6FDLe6U6b+oZ4XjDTE+PHWjpPGYI6GmVL6YJUcpHHg9f4LUotnfvwagV3ZH31hpWVJyjZ8ptk0nnJqSO8RlI3AEyKpzs=
X-MS-TrafficTypeDiagnostic: BN4PR15MB0532:
X-Microsoft-Exchange-Diagnostics: 1;BN4PR15MB0532;20:E3+7fg2A7rJGeVKlH7gnNHvsu0VbDN1H1kHWG3b/tTnzz/ffc0CJeQtR2O4hKV50czYpLYRgR86eZ45kPyVadp/iGSnO+4wBkhUQZl1ApRbAluF1WJ2J/PJLlz1bg3lFalqDUpLuV3n2FLrpinwkQHLy8PVXKGNEnOQJgmk/IEXa8vDFd5vRX5JlUL/ZZioHVqJVvcoKZuLRsfLwatDfh8vPyf+JwEz2DG6ybhWEwtcW/Qgy5autSdwIqQmJROr+0A1FlioxKiFKX8I/23QStCUWuRNJBFMaycWb4/bh+GR+9OZymWSqolRYqo6DAmDKqcw0fW/M0fc8ucLcVsBA8dr2E4M5yY5r304tphivNHbv4BY1invtopTM1N124ii2NAIWrMQoKO5kc8ICMgNw2YCi4S0NxaUcNBSGyV8uHtjNLg6dJGgrhMCPN8woGm2MapAyuQsM5piQQ/C7CuvmiSfyaPbnFLKflKls8sXJJectdPRKCZ8UTRBmduIPr2Pm;4:UktQcKctyRWiGLZSQTvSymHLweBZ1Wp9ojC/+PUE7yf+aoFwGXGGQreFDHuiKseXA0Com+pf4bd8R3G8X+1Q+lBw+AxP8NltlpHpDAv3br1dgG7kUl6cFUj+dCjFM+BxHYzSmIGS4JmQW9iPN1QGHYPxRqNLh7LRGAc4RN3y6NRcKgkV71tIRgNPzpBEppdeqc5GQPM+LthjUsa5/ulVu76Eo3XDl9+ddicACss9nwuhv022Ryt2ZJalfGIQ3CthnHWhDVjCMlT5eRDbC++L+YMbDOJ/yDurY5ehEd4Nwg0IsQmkbRGSL3NxJKjDUbYE
X-Microsoft-Antispam-PRVS: <BN4PR15MB0532383360E797C8DDD04CA9C7BE0@BN4PR15MB0532.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231221)(11241501184)(944501327)(52105095)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:BN4PR15MB0532;BCL:0;PCL:0;RULEID:;SRVR:BN4PR15MB0532;
X-Forefront-PRVS: 0638FD5066
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(39380400002)(396003)(376002)(199004)(189003)(46003)(52116002)(53416004)(6512007)(476003)(51416003)(6486002)(36756003)(2351001)(52396003)(6506007)(2361001)(305945005)(6916009)(5890100001)(2616005)(59450400001)(48376002)(50466002)(486006)(16526019)(54906003)(1857600001)(7736002)(97736004)(105586002)(186003)(53936002)(106356001)(4326008)(5660300001)(6666003)(2906002)(86362001)(478600001)(68736007)(386003)(81166006)(47776003)(69596002)(25786009)(8676002)(6116002)(1076002)(316002)(16586007)(50226002)(81156014)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN4PR15MB0532;H:howard.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN4PR15MB0532;23:FWMgWhyeKlv8htd7BoRxuCvj4ts6DrDfR5kx2JFPq?=
 =?us-ascii?Q?MrqYBHdryZ7FtLn9e+Q9v5sADKyp4ae7EWr1qoGJCBVhTOZiHMtIAmNRqml7?=
 =?us-ascii?Q?nco5j0ZcdNQAkh9Y5OuVJJJzt1gaUymlF5snstdwiJWxSNlIgONnpRYXgBkJ?=
 =?us-ascii?Q?7na/z7+sz6oKBgAc8iN90+VR1PSOAh1YdxZZZ+QDY0t9H5YtQPniSfv3wYJF?=
 =?us-ascii?Q?ACztGzvd3oSIx0g5mxgMHgKiGGeofdfVHPohDYCu7XAzLlmUKn7JEQycIPa2?=
 =?us-ascii?Q?44V/td/5o9Zpb/RdFQe1zs4Kjr9TN4PSE5X7Bu83Ga2cyeTm2BP69Pisdd8p?=
 =?us-ascii?Q?OGH7PIzdYMTS+tR4O+i5ndR14vgb+1NsUStRqTdafcjLbc/Pubq5yzzwpuJj?=
 =?us-ascii?Q?NllSLgeW6qhtmh4/NPmORz3Zg5Eo6r6RaRRfmdV0L4DlOt4X4Ienhwd0B1UV?=
 =?us-ascii?Q?cvIAZPNEVVXDFe0D1wCJS3yr2ZDK4moJHF1O6qeGWyPr0vgsOYk6DM03nSuU?=
 =?us-ascii?Q?lnkk5rTwAXMd2/cra8m/asSJlpPOA8lk/jMivU2V4TIvEnonTiNIU+8neyIc?=
 =?us-ascii?Q?hSuX9ZeSFS8nLzuKZojZqtma41ASUJFpe64x+x8yJsQLh2aIifRd3wMjpQUb?=
 =?us-ascii?Q?Vh212Ud2CP1evVoNJQcYIM2m1jzSVq3ceuUlZ3UEN107mzMxOiJcDlitWJzy?=
 =?us-ascii?Q?mB2gRFg0kL+/a0yZgkwJc+Taz02jtE0gEE/X9wi2BZjzPbQlCe7kas2SR0kW?=
 =?us-ascii?Q?ojqVovG3DFDvfz5R7ZhSIaV/1nzLgou60Dk1PVg8EAUgJ/kzE5BQ9K8PfK7x?=
 =?us-ascii?Q?E+y7VEWp0llIcP8jSySH4I69bZt/nu+2LPcxvtLwrl4VWgC00rw1yhnjfQEs?=
 =?us-ascii?Q?eN6igX5VROTI/9lBCKnEzBRK3mCXFokeaHeFD4FGE8c0knUJroTJ9RWx4+CD?=
 =?us-ascii?Q?YrmYQkXRL/+IJR+Y047ExFiwhUO5LsB9DXdso5cgikI+Slt0cn+1qx2ftWCO?=
 =?us-ascii?Q?C3nKOid/0SlNL1QHNVEuW/0zA6BDbJawGlG4UharU2ugU29MIycVapjYqSmJ?=
 =?us-ascii?Q?SKQbdIe3yARUq5idrYIiGpU33bGLbp1Nl7Raa5pxMZ5vN1T5zMmBtuiGIlG+?=
 =?us-ascii?Q?MD3OA2mCRcPLCtYGmf7z5DKDAXVpPkLcALtu7MmgxqsBmi5f+kreIKnhH+KS?=
 =?us-ascii?Q?g/IuMfG9+a7MVuRCbIudU9C2AX3zV9eZnBrQFQOVyazmlhscmQ7dW3Ub0gyu?=
 =?us-ascii?Q?XOMoLACHCmxJvKymvaZKu+4TR/9P7QN9qR2SU6Esn6d+6UV08iG48BVe8Mx+?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: EsqO4IvHL8nAs9Bm6FCnlVfPgLeP8kn8dFdqx7WgsyxAcoqQXR94uwV9OBL2uCXfFlpPYdvHm0cQSPsV0eM9JAyT4sdfckMMaQG9u7toSvcCAaNb6avdkbuw+GBYRasFt7KXWHSEvfsguLKEKsveBftNxXDII9u+LkErBYF8FCIt7sqmSN9SBniGTRnf4koD
X-Microsoft-Exchange-Diagnostics: 1;BN4PR15MB0532;6:jR30NlYCkxEVDRhStHkr3oMPNCGgtVI216JZb+3bTMYaaLxZmyohuP3XiW4nCxHSPJWkBFlpDOiwfSGrs7kipqj7QCPA0ygVeNtpMNc0vQphCnBNFgmfwJQVBQSX5jzY3IcOWD85caEzk2aRo9Kzc0Jq8I4ljBU074t0Xi//ftSkqLzGtgFAjU1eQXiUBRhrQZlMewc6QhVE1Oca/demWvaTnDPATtWwY0RQJV784ZSjVWlCs3U8hZGJNZej/S5JfRI87dX3Ye2u3aaUHDdf34DniRlSrCYmGQVNoEDyZFqBCN7GCAU3ofgaeojduffepGZ3i4iQJRni2/SKzIAnMYmmdQ1aW4awsOtTxEHTNYfYu549e01jUGJG/hkzZv+k0OFZCeVXLKgrDLUonhRW+i1Z760dKi1bADzh2f4hwiD9x09e0vVe2kJrICg7QM4146YE3xePv/fuhDidHwTTCw==;5:vYgbOoI/H8OXmAnc4HxjFBNfpzzXEonN8qDYYsQ9JKPSi5YEzsbtC2vUufdKEvm2gh6s6mLZOhUKlZPXYdGVz7Nu4OZoNThKmg0ii8yAtG2ECGlY8fpAHYKlUiS3+PlvSsxBVd4YDdjYQAwmxV+BBn2BOL4a6ik9KFcPRjpsVks=;24:W33Q+BJsUB0QLcjcny3Ff09iy9/WzjX2tRXSOgBIioSJOnzeMaAPy3+ZBIbO2g3n6IaQNgWVXQOZFcTYvjBeLlleKSbYVKzMJgBO4Omgod0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN4PR15MB0532;7:ALBP/2+2d+0fPUOJPJrR9xT71ueizKHc8NnuNLd5udvScFnKyPSrE7G04NDu8cyQXH2FrLZ3gj+OQHcthe536xU9zi12Jn+CVPjBQqN1/Ypdm3dDJlQK7faTAaIJh6zaFISqzL6LlLIXtYCHGW+UvSJVcl5XYuNy4LPZ6d/oadZxrgotCzE3C5xHMGDxGTm+gQpmAUYLvH2hnL0QhbGkkKnGLApNYHJFblfyXI80IB7dRDOd8HA+tQtWqnP9tp9y;20:bkl0vuDDKTjCEaOBHmSQ8HZVz3z0/JU9xTBw9BmWmXTI1L0FKQxnGbXMm9rKc/ZtFaBjbvpMt85LulMNFBgjLcgbFlKxSDN0J0YyarQK6FfCiE10OBxcu63Cs8vJa9Mu49zQACvAjtjJ6b0N7J0baunABdVari4V2LOalV0PdF4=
X-MS-Office365-Filtering-Correlation-Id: 8bb9522c-cb0f-4317-eab4-08d59f384a0a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 23:10:44.4511 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb9522c-cb0f-4317-eab4-08d59f384a0a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN4PR15MB0532
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-10_09:,,
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

Reviewed-by: Josef Bacik <jbacik@fb.com>
Signed-off-by: Howard McLauchlan <hmclauchlan@fb.com>
---
 kernel/trace/trace_uprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 2014f4351ae0..17c65fa4136d 100644
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
2.17.0
