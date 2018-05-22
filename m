Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeEVOlW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 10:41:22 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39048 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751199AbeEVOlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 10:41:18 -0400
From: Roman Gushchin <guro@fb.com>
To: Tejun Heo <tj@kernel.org>
CC: Roman Gushchin <guro@fb.com>, <kernel-team@fb.com>,
        <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] cgroup, docs: add a note about returning EBUSY in some cases
Date: Tue, 22 May 2018 15:36:48 +0100
Message-ID: <20180522143648.29508-1-guro@fb.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:c39d]
X-ClientProxiedBy: AM5PR0602CA0004.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::14) To DM3PR15MB1084.namprd15.prod.outlook.com
 (2603:10b6:0:12::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB1084;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1084;3:+zYRrLsN8QE5c8UGqCrObbU5EzxlX5LK8Yjbq3Ghg9omLF2fFmYl1Gi0mrAPv019F1kiZ89DJLltDbxCl9TZLPx2Ln4WoxYRQN/boVfHPh4otS8uLrNluHClT1qzhloc+P7DOtMzey1lUGHhNVbtBbDPXBTpjKqx5wCOpRaD0vTDwp68+mVM6IkNRLFaKWBjy/3d2T5AR7+LQQTV4RAwlDjMPo3vy1gHwyS4XegeB2h18bDNNWn+PplgLMqn0o8e;25:tTcvewscnGhhxix4g6qa3BuTSA6w3hx/4uYKP8RixejFjbUyREa7s5DfRPCtyiiVRwBXQ/ZaWso0NSLmZLF6VqjOm8JvGtH1kmVGiIqhjMj6qeyy+4pDcHT5jFw79NcK27Aov3T2y+02DIxV1GyTf3IXIV7w35dJCaQuGUK8omPOY7xy+tpAqDNfLHds9Zq7Q10pdwrSPffdRsEtkEXaIMJCVreC+xTA35SAVDzcvzhVeLbrOY2J7ChGXODYCpy0I7W9qF4njjeZNH93KFhp7ipqG/wk3lJ1ybEUVTk4bVmDxA9gLdMFzNrpryplyxNsqKG4go5rEprTUOYJyQFLcg==;31:G1UCxTLnlygPYResz1Ewri5qcC8HsNyDTcRScOOGan1U7UhSqSsyDhE+E7yB7tgPwcUmgN3yY7V8NEGZDrJBQDgN0EFzkhOdEa/g3YC+LXtNbotCbzrO/1ydf8eSL/BVP6pEscLv2tZLHLPiVi63QVtjvhEb2UEhpnoCAC9u/RF4qKsVqfNzecq9B+owcRJedBpLq5nxKF258GrKIAtbNZW4poaPtgsVTaQ1eIKkSNo=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1084:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1084;20:nmbRshfdQsqo32vxE9cpae+aUEF9QHY93TeTko2KsfSG8F89fm8ZHla61nNMXrjMpgTWhXv7BKWX6ngHkmmzAszDQDbIAJuRjnUuL94CNJ97dTuzckThXx2oj8hd54G+IG7tjocTaYHIH8sghBvo961ZGHDTOczRYUnuq/eHdLlI0GM3APbCGH3XIM26pK/Qk9UNAGwItl5j1BrPiDMp+TLAm6fF4Ahykei2MH+RKSCDxu1fT3yZ0zpr0xeMl+w3OeTIrEtdQgT3tsDTwIzWGhg2J4in7O1huQo0IOrUAStd5kXoDjsNZ1dBoHSlBzu8WOuFbEkpApWTWladnZz5jCjC/AL6W2E/9nfaFgOHzCf4CEIaq+H1JkN/CNuYXOATkgS+mwg69B/EFi/KJzNC66Kr7uHlQgI4Wqci3rVS0NXRm/3Dy7S+qF4/XXWjtWucG7BP5d92FjKL6Qb2Q4VPMjAEP4Jd5CcvkVd5py8N+mr8eje9IdACsLyXL4bEtVDx;4:DMcMjClBLnQ5M0Qiem8tJD+4+jsZq+0TsKjzErI80avqwaCg25vNMW+3ULXOAE9nURIPctXBCC4E0wjJWd+pwIYToRNuXBO0gM659zYcTN/4OjMiu3BSNWNYlmVMciCdK5F9+6gKyGTphdrL3JB4SvHXBjv8PWllcwdpADp7ulxY0wSnHKjbPM8Ne6kZyNOUtv8ox8pBZ++3T/JMg5y6ILOxAYQrMuyCZ/xBnZCTPBoqzWF8a9FeAAdsDwPNs9bhRcS8O84AEhnGjDkWN+R+fBXQPDE6BaD3Ij9gvy0Frq1jH30EFeW25Kn1+OsHVstQ5IWXesOU0CQKqps54ZlkubBL+ELba2yDgXeiQ47x1EU=
X-Microsoft-Antispam-PRVS: <DM3PR15MB10848E001489B435B85654FBBE940@DM3PR15MB1084.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM3PR15MB1084;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1084;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(376002)(346002)(396003)(366004)(199004)(189003)(1076002)(8676002)(81166006)(6116002)(81156014)(47776003)(86362001)(8936002)(386003)(59450400001)(1857600001)(6506007)(6666003)(16526019)(53936002)(5660300001)(50466002)(69596002)(53416004)(48376002)(5890100001)(186003)(6916009)(105586002)(6486002)(106356001)(52396003)(305945005)(476003)(2616005)(46003)(25786009)(486006)(50226002)(36756003)(2906002)(68736007)(97736004)(16586007)(7736002)(6512007)(478600001)(4326008)(52116002)(51416003)(316002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1084;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1084;23:W0UmYSz4v2yMRJDSyCvTvg8a6Ag4OMNoBHHNn3RPX?=
 =?us-ascii?Q?DPhDe5FoZ8ULGNvWzYSJGbXKYHxXqzMnKlRq5dWK+1wQa6wo2BsQHopQMouP?=
 =?us-ascii?Q?tid/CW0tOKmmXYlCnH6LFC3LHNVEu5hRCs4NV10GsGwGreZ1q1y0P2KxmiiM?=
 =?us-ascii?Q?PtLeFz8B5uaH1iSRiiF/QQ0lMGnyAABd3/5yrWHtiyN+s4xkFAfWG5U94Sxz?=
 =?us-ascii?Q?X31ONynQDVebRef96YVHYuyOZMP85UQHcPtEQKaZzHrApKsxoJ/WL+313hG5?=
 =?us-ascii?Q?CZ44xF+3lRKIzUGok6dOh73jt879HqI7yVhKBu2CedE4BphmNkJzDw7xVCub?=
 =?us-ascii?Q?96AjLWh4DR1FGMLAVCqLDQkjtgwlUK9YoyIshljGxtI0yWjnTk8XM4A3vZ1g?=
 =?us-ascii?Q?2g7YaUaK5TJW1EDVtqauQ/CDVrLTFLNNZ0i+Bkz1X0ZXPJZ4tn5Dd2T4nXFW?=
 =?us-ascii?Q?ovTe/56j192sB9SzUW+m+qHyooVRtR/Dj2hExdZpClCdFWYxLL33QZKh6ru8?=
 =?us-ascii?Q?yArOPyD6EuH+Cxu/IkmJWooLnulj9XQpF/wJYkNWIVZmOssSFf79dm/N7lAK?=
 =?us-ascii?Q?jtBuZDW7S9LSYRAl8ZzRjJWrHrEzUA1SUK19Hg9+xndh+r1UqkPGO/GonIpx?=
 =?us-ascii?Q?7SWXCN4f4nC252A8vIDEox8y8MLohRE3ZhLCRsXaZlnGr32M6r0CWRRW2D9s?=
 =?us-ascii?Q?SrEVwcEGoRZ58ZbalgnHVBd+LTnSN1ym7c/hef0RidH0D+Jaam+aoUDNhmkw?=
 =?us-ascii?Q?8h9kcuw7I6U83eYmKcZYlI/5hPCsQujW3PZDqYcdGNMC5DUUs3CkUk2/ZUt5?=
 =?us-ascii?Q?iPvrlu6ASPmf9gMl+U5nH933YE4Nd7H5ajpBWrT/wjUC2vsJjJyY8OZvzQKK?=
 =?us-ascii?Q?iR4gIw0NQ9PcUAxI5o+//mC6e1QZv81UHB1LYisRcemW91VzciuBWIxbhCqH?=
 =?us-ascii?Q?ttMSqTAylsYUFIQe29JC9xMMmj2xELiMAOM9QlFkADIk1w/CiDEKZIBKRvUh?=
 =?us-ascii?Q?CQKMJMEyrrWkjFHKHEmimTjZ3W2dQ7ofKMBGCCpgSb8frwOkzcfezcb6BKdf?=
 =?us-ascii?Q?E/wX0Czug/CaKBEiGM9AQ/Pd67ajQbvBfIInHRnvqsS4IjpPZ8KFqzZz8Uu7?=
 =?us-ascii?Q?KyX+YFpYBSWyy7EqdTPFfWmk1zzgR9xTldYyZXHaIKMfVBBZ1CyRuBtyNQ28?=
 =?us-ascii?Q?Yj0TFXofEPDg5c4fq7GaSHsraesaikJeVjUJD590VE78H4gIK1IwSshUizbk?=
 =?us-ascii?Q?jSxJslYkHQ5vRj3Cc0=3D?=
X-Microsoft-Antispam-Message-Info: KU7i/TS0GqtaqW9GTjghVlXlk13ZVGse8zCVy6ncFIo4HVrAX897hDa9zvdnXpnfyPHPJjBWUYKt3f19QJqvopIssn28s23iHuPRyhpg3/Dt538V5xDCh/W+pKedcD1B4utFkFo2u9GLEAGmk+uqczJFZJgUhvZCsdx8O0tCEaZNHi1r9feR4VtIZVsoFEzp
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1084;6:JSYVWZrWoZ2u0Ii/Wd5vEdGPuGpSS1El1r4LDTedcOof7wnAG+4xwBbyC7KYjzf7OdV8eKJiwvZdwNPTP7qQD49YtJ4yM72FgEel7+1yrzqz23lK6rCmV3ljMcYYheZmxaE8mIwOEL7S9oL3c7tqJm9DUL6WkM1XpjU6XkQ0Y69ITRwMHZ5ekcxxm8j29tbB3uJTM66q0WL9M47CULdDnBGx8W+zP0dDnPIKPBwcSX1kOVZTXMaLuh2HfFvqyboTho9xg7yYhsTydJ1/ArAphsrvbuquur5jxnMrB/v4ASX3aCpvkrn5BI0Kl+Jos3VtsxxFpfnDVMvdhIxN0PvGYL0QEz9ocinDhaAodSOQ1RrGuu3L5hAZsu0ChdCI8j32NO2qBn5ofU1QNPhOZGagg03Q8FvgJChpZN+cjRLtxgHTe9eorpRTIBLh5qSQhl55tTJkVzHtqnJpbIdvh2/riQ==;5:py/69oJ6T7l3pn8kBkTPvc2sVgO1i9olDe9s+UjHxrbyBTP55kk15WHwW3lqPmDQFi0oX0zaC5SwuIjCuljWNRO1NlpXlF2rxBZgHBtUnHHB/8xPzihPBFiQ931W5Pw8Y1/I+n6JhpfmgUHxuOpHUgWGEO0dao3yGWKsVXE12gk=;24:yfmOKHIlWI805x16JTvNm1kwxvBNkqqmIcq8W1jC4ULS6oPq88MkAzVtrnJDVhx5Fo+5Ll7G9+2sPGhrj8JgQiLrFw/A2ldJk4Yp8mJw32o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1084;7:CArKgVRmYJ3qFnepCrZWvIcjv8KOlVi/BKfxbH6syTW4nZGlS/M19X7oywoHRoLwby/cxWUd8t1wEqx46IoHOJpfUjDn1r3bJ8JpeDKJeOjSJoomcP+2EH7mPFqe4U8z0YjG6UnjeK47PhqbyFr9Dt3lnemsBWMzE584IJpr1dKhZWGvAbACyl4iNRqcllRVYX4wPIeIhAFuEVFgDbFGucQJSkXSTUA9cyZ15NAA9R7+CYpNP3n0whECZu9p4Sd1;20:SSdObyleZ7hHNKRfFzbz537WOPITyMYZBNGt4Nul9jjIFfWOW3quQ6UgrwYMluYO8ACnjxkRrZzJpusHF8RDBLJC+GmKMypreOA4QuqlfHcQSAs5VUoMpOIRiiHgEvhLBrSiMY07g2EXphlHt2fR44zv+0ThiUkGg4kkugBgazc=
X-MS-Office365-Filtering-Correlation-Id: 35f101e3-75c5-41e0-fac4-08d5bff2107c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 14:41:11.1784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f101e3-75c5-41e0-fac4-08d5bff2107c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB1084
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly document EBUSY returned by writing into cgroup.procs
if controllers are enabled; and writing into cgroup.subtree_control
if there are attached processes.

The return code might be slightly surprising, and because there is
nothing obviously better, let's document it at least.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: kernel-team@fb.com
Cc: cgroups@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/cgroup-v2.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/cgroup-v2.txt b/Documentation/cgroup-v2.txt
index 74cdeaed9f7a..57302f88a4ad 100644
--- a/Documentation/cgroup-v2.txt
+++ b/Documentation/cgroup-v2.txt
@@ -799,6 +799,9 @@ All cgroup core files are prefixed with "cgroup."
 	When delegating a sub-hierarchy, write access to this file
 	should be granted along with the containing directory.
 
+	If the target cgroup has enabled controllers, writing to this
+	file will fail with EBUSY.
+
 	In a threaded cgroup, reading this file fails with EOPNOTSUPP
 	as all the processes belong to the thread root.  Writing is
 	supported and moves every thread of the process to the cgroup.
@@ -850,6 +853,9 @@ All cgroup core files are prefixed with "cgroup."
 	the last one is effective.  When multiple enable and disable
 	operations are specified, either all succeed or all fail.
 
+	If the cgroup has attached tasks, writing to this file will
+	fail with EBUSY.
+
   cgroup.events
 	A read-only flat-keyed file which exists on non-root cgroups.
 	The following entries are defined.  Unless specified
-- 
2.14.3
