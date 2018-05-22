Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbeEVKL1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:11:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47362 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752245AbeEVKLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:11:05 -0400
From: Roman Gushchin <guro@fb.com>
To: Shuah Khan <shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>,
        <linux-kselftest@vger.kernel.org>
Subject: [PATCH] kselftest/cgroup: fix variable dereferenced before check warning
Date: Tue, 22 May 2018 11:10:31 +0100
Message-ID: <20180522101031.8451-1-guro@fb.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:e9ac]
X-ClientProxiedBy: AM6PR0102CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:209:14::35) To BL2PR15MB1075.namprd15.prod.outlook.com
 (2603:10b6:201:17::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL2PR15MB1075;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1075;3:1HafuT+IlWtW86V8AJPDvBYg45XTiEv5SA9ngl9FJL4bKSKoVoHB9sZGH6L7A1kyNu0lHQIJip0y+DdxBbLoM8glCTjuBwaWXnfOUdGtRQHFvQsGlw7Btp76sTKhxJSrkVNSBEiArfxyMja9JEzApKvQLXk8aJmUj8xP3U++DHFPFI9kPoCufG1+fbHkFYfBluEAEaQt7y2ocrCy5zQQNMXtxP1FMXDPgL2MpLpsbWFgGTiTHgWHnciW/Vah8p1q;25:IPIgx89e67f+yRjTBei2iSZc6dekE+GTWCcE5gUzTEcD7AEyZLuw36KMHwdeqz1ZSi/5A7pZxiMPDIoBz5NhkGZh3TpHz7mES+WS5FxgrBTlhhe/xVigHvlt7OmV6h32C8hjRZ6XkssiIqdWOb+bmPz3KNT6wuMOeC6u7hAjqPf+WiAYkMbJciH0ONjKmJLHK3Co6WCHWQw49Ityg1bAO88KglvY2PC+HKlk11MIs6ziRSymZcfDVib5pDuloiz2KoAS/eDb45FJfVceGhoFCTC4JP6pStjIN38WGecBwJ9COvLwC8t0e+ztHr0RBJ/1mprjEcgpKNXES8aX218TRA==;31:skMv3ilDHBPimHKcp0c2SNZBk6pzxymQOSfRMQiRuGM88LlOAlYSxIwmzEMI0nzZ5HfGFCoRq7mLVbHr/ZiKwRO/xYcByaxGkEGygpfBNMgBhfP5t1CzTfw1gr3zcroMrYeIM92Zte0BABW9Q1stbzeCbZQcYjDR4Iazw1mNkLmVlgvvW4NQHA5pem4+d1Tb0aLLTxMha76eWryNAQlUj25Qc0duXyUsedTz+TFXXnw=
X-MS-TrafficTypeDiagnostic: BL2PR15MB1075:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1075;20:qfBqoJGQET7uffjwuaEe0pEvMfH2toXtUI32HlunElYO0h92aTt0hvp6w74YD4RJmTVZkGclPcFx1+LE9142x3ARANswp7CCN99akzQTq9svFQ4SmTaagmvLTC7qpO4XSQB6zhHJuK8N3hwm0Eg4rt1kY1N9GqIiWmHOKjj90hLy18IMDmPy58CJbsoYu1shiauMOSlE8/e8ptlBBuf+RfBIKgduYdOg54cfcjU/eZUpeta0ktOSt9NKRVhg/IdunZvRQHyCOuWS5u7HK9FS/l2assLNBiQ3NBcOp/heqQoKnFuIkUSOd67OHcSwaW8+MJw9R86Hk4UKPT9jF+t99WiZw9T8d3B853uURiq2J8cRPNNvNTXaXfKpXtPSToRJWFE+B96Ran5uepE6uuOGVAbvVEedusXAAbaWwUa0Lb43PJSskKd4FWe61JFESsmGytO/2Ua9tX27orE+V4+ZDljeDSgkkV9ZbfYEIocGOM7nmaJCbelFQ17Qjt3/cXtq;4:GkC671vudVzN1Sd5+83U/e+s7e/CPAlA9EqvrCnIXjQIUzUr/cdm00tBXBfMXhwYvisj8BZCleNHqW9Yv9sTziCja6SMKZ7jp4bgM99NodjsO3IkTnatQwz16uupR8okRYXtFYOLPDXwqF7pyhbfDcwg49lSUCJDM/Majy16p6o8cnJ92YkOwTpXzWTBdtoyqmCzPEMiOlhmujJQD6FX1avbjLI2EYccAIT01+rvoAi86rUvJ3LWAEqfXgKH0y91eFiWm0csyjyQBhMAmbW4+0oDOplrjXjcR7GQZZspr4yurh7crTtxb36Hmqums0dRukT/HmJXUsGNFYomeARvgqJCSQogikBIckC6J9jvw74XfIaF/yzh/zLYoAYCXzkb
X-Microsoft-Antispam-PRVS: <BL2PR15MB10752003C01AEBE1F6A5CA33BE940@BL2PR15MB1075.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(67672495146484)(146099531331640);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL2PR15MB1075;BCL:0;PCL:0;RULEID:;SRVR:BL2PR15MB1075;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(396003)(39380400002)(366004)(376002)(346002)(39860400002)(189003)(199004)(53936002)(69596002)(47776003)(51416003)(106356001)(476003)(6512007)(478600001)(97736004)(53416004)(386003)(6506007)(4326008)(486006)(105586002)(52396003)(52116002)(25786009)(2906002)(86362001)(1857600001)(6916009)(50466002)(46003)(16526019)(1076002)(36756003)(305945005)(48376002)(8676002)(50226002)(5660300001)(6666003)(81166006)(8936002)(81156014)(186003)(2616005)(16586007)(7736002)(6486002)(6116002)(68736007)(316002)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR15MB1075;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR15MB1075;23:o+ROP0TaMyWOK82HLknS6vicFK1XPbcCaPbtYvdRm?=
 =?us-ascii?Q?9VexvEElxIlAA0X+1eGBoJd0U9dUILUJVh/ttFlo7Mfeo3woOz1iDYUC0O+9?=
 =?us-ascii?Q?lXf9sUscRyCUBFOynOFRK7qkqH1DT3hHbiyDWfBolCSbxmch9nz56sVmsVMu?=
 =?us-ascii?Q?OA2jGzRZVHFg7S92vIzBpNhozVngOaTsaNfJjxR5sZUc/f37QDp44CBI7+kg?=
 =?us-ascii?Q?UkdgvfxtBG6q72U0cDbpTfWNgr6rCYj3oV9KJcHJMRucodPF3yrbIavSxbxl?=
 =?us-ascii?Q?9PFqdVmQhDnDRLB47gUVD4RP4poPSV8y8KBql0aUv+GWt4nGOKbpxdOcNPqa?=
 =?us-ascii?Q?SOQUzxvVUK+xmI665O/fRFXKShJMb7PTTnM9KlBziJfSnPyT7dehuo6AY1hs?=
 =?us-ascii?Q?JNb9p0n5cbJ/+/CF146cuZeP7NwYSbrEV/2rXC2bQW5UxIm0oqeNFKMvT0Lf?=
 =?us-ascii?Q?COJ+eN7oit3pynfQsbwFNvjuEfRlbRMtAh/NgbFzc1X8nAXQHRW4EH5lmpRc?=
 =?us-ascii?Q?Vow+sn7+2ev4Ec/YwOOAZPe5l/PgktAgugAzHNf4Hqp6MaIJtl51NSfLJjIh?=
 =?us-ascii?Q?PKGZewIuspPgSd2UwKSQJnq1ThzgxTjIyDpKWJ6lfE81kgzMcne0tFXnZB35?=
 =?us-ascii?Q?UghR4U8iBWyp5hEGVDykZVAD6qUY7CHPUxk8jrz89sy4DDjDio36X64JFpLw?=
 =?us-ascii?Q?cqekZX/p9g8KqqfAWfDqlZKiG65InXVOZl57X2LjNP+Q/yPZlZHrHFFnjzJ2?=
 =?us-ascii?Q?AN9X1Bpg7wNyt1Sb5x/mCz+KfNvJl0Wel8WZWSX7qk0iftffrzbCQZpQ81o1?=
 =?us-ascii?Q?gIz7N7D2AwwzRpXPys/4rVrL1WMx2lPbP0g6nPK1ChW5onULz6zNDqdV431z?=
 =?us-ascii?Q?mb0KBC5xcAWoD/S0LMoHzX4u9ZJw5aVEtL8neEKvzsPXHtH66dLdNn/XzA4Q?=
 =?us-ascii?Q?zk7bvgFVOCdqHDaGIg5p9KRXu1KjywcbJeA8SKeZYxQIkVcKoV4ZYd7jivub?=
 =?us-ascii?Q?zELBf/7A8oEWPFppanw6Gk7QPAgImtpKrIZglnCIEYMpqfQM6LLqpIMoyENO?=
 =?us-ascii?Q?jCYUMKH8+j+CNOjDAdbKbzO/eBpQfSWXHkbfZfPEzwT28nrU9QrAX/PkHQ0T?=
 =?us-ascii?Q?y3Hf/is13mMDZd5ADJuTI+mVSIDExmC3lBQsRhMbGxFVjUnqxbDvCCimyM0t?=
 =?us-ascii?Q?h5xec66ySQIm08xNUzkRLTJ8nq2ti55BSZANei3L096DAEuA8aWq9ivXzfBc?=
 =?us-ascii?Q?ufFCkDvwjpGCtSHXMKRDafw2JtSXs6SYaGv8+ZMuppUD4iVxFvZlngEZpY1G?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: O5zns+j9JTjH96P+c9PSDkohkq1Sv8GRo0sGxC//g4t4NfE3wJM2hQRrHW1DdOs+R0PUhZuOMTL/UXMl92XJf/qk9sOmJkS4P0a5gaLtGitFyCDI5yMUV5zJQbUvgLrX3lAKl1axGRagZjRb2SEyJe/4Wt62lJt/adAhTsENUzwdFcVVh1Ny4Hh5/2swwEIy
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1075;6:bG+Z7yrIu0dNWf3Ho0aZyYLD/Kojfavt+fFAdwDZZoTuSpO/k4ja1HgsfNotYy//+sVOMWLqnhy3H0+Lk7y5+6mJliakiYtzNcqLPWhm3MppyxuAHt7sDIGkoHRZ85cszX57CXucFjo589DfhE2aNyKxVQLV9Yql5qL6BQWMfHevLeqdL+4+bo99nt2QE15z1XiMHhRucYipEEouXpP03DtS3wxmA+9BETmAgE0Xjl7Jnk6shIAUVGv64XTVRMKof8rNo7OySW0X69qlVar4/nlBHFZNydseZqFNQBpa4hQ+WRPU7FfVyD6XXxfbSdPkCqZZKsDtVCphzs9vI59EFCaUbIsCCuiqHsWAifaoYKLBzuYZtKfLuol0Yk11lAmrgpeNKxN+Exu+5UMD1tLIwre9ibQicd428pwQr1PCtjchuWUcIugZcdbV2yM8l9LHs5l6UHu+iz6EOhk5GZvc4w==;5:XYpPmf+N6AAh5kd5gR9IpF7ohINjaoTR9ejWLCkjNKCmUTe6YPLhpAMQHL5nZajdbfpJNJLYKgMsbXUHLRhhKmAYZoFvNqp3T0IqdL4TlqywdveqJXoiZwDtOhXIUqeTq9eysZPfXgwa9xVYlKTfjFFtq9zp0X3kcwozCQEo6t4=;24:KN58PnhyY5i0hjpgqt0rxvdNRmrw0QQMzyZtYBUAlLuYE+PuB8QsOr+hDNhbReY3QN85l2r1O2ULFJ3YR+YpICVc+BJE/xjZVxL0kgTjRzA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1075;7:clYmxiKEpiQOnefMd1jKva1uGG7QxmJ0TTK5TCf3k2cQ3HR3tfjEcnC1OUb7sAdOVyRzC7QBaArm5JUYRRCUZwq4sIv6oPUAtfa62HjqDlG+GNXhAPoXgxHma4zZHCY2Nw52r3txg7aqMJgRl/eKEToJ7a5VZXSo1TRvztJ3nAQSJ5EuAKh/CAUPd91wdAeRB42oqc48/zGtQxQ+AgdgIrVyFjQEyuI1zpuM7bk1p0S9DXxdjPJDBabcjQo0KXuc;20:popocJuH21Rvm2l5azvTwt1UEiobxi6GBocyBH9VVa4E8+rdenMSaF4dqRxxQE4DPWfvKy911qTgSKJAGh9uePwOS0EktOzynfitFyJZHX3aApiZ6qYyDiVavWgZu9muxC6xF9slBfcutvMuw9TLk7kqH7VYeGd7JmKUh1Scxgo=
X-MS-Office365-Filtering-Correlation-Id: b16702c5-4e36-47ac-29bc-08d5bfcc5023
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 10:10:57.4532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b16702c5-4e36-47ac-29bc-08d5bfcc5023
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR15MB1075
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cg_name(const char *root, const char *name) is always called with
non-empty root and name arguments, so there is no sense in checking
it in the function body (after using in strlen()).

Signed-off-by: Roman Gushchin <guro@fb.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/cgroup/cgroup_util.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 41cc3b5e5be1..b69bdeb4b9fe 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -59,8 +59,7 @@ char *cg_name(const char *root, const char *name)
 	size_t len = strlen(root) + strlen(name) + 2;
 	char *ret = malloc(len);
 
-	if (name)
-		snprintf(ret, len, "%s/%s", root, name);
+	snprintf(ret, len, "%s/%s", root, name);
 
 	return ret;
 }
@@ -70,8 +69,7 @@ char *cg_name_indexed(const char *root, const char *name, int index)
 	size_t len = strlen(root) + strlen(name) + 10;
 	char *ret = malloc(len);
 
-	if (name)
-		snprintf(ret, len, "%s/%s_%d", root, name, index);
+	snprintf(ret, len, "%s/%s_%d", root, name, index);
 
 	return ret;
 }
-- 
2.14.3
