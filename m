Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753886AbeBWShQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 13:37:16 -0500
Received: from mail-dm3nam03on0058.outbound.protection.outlook.com ([104.47.41.58]:60672
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753303AbeBWShJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 13:37:09 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com;
From: Brijesh Singh <brijesh.singh@amd.com>
To: kvm@vger.kernel.org
Cc: Al Viro <viro@ZenIV.linux.org.uk>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Borislav Petkov <bp@suse.de>, Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] KVM: SVM: no need to call access_ok() in LAUNCH_MEASURE command
Date: Fri, 23 Feb 2018 12:36:50 -0600
Message-Id: <20180223183650.92983-1-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR21CA0070.namprd21.prod.outlook.com
 (2603:10b6:300:db::32) To DM2PR12MB0153.namprd12.prod.outlook.com
 (2a01:111:e400:50ce::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0ca42a45-016a-4f53-542c-08d57aec713c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM2PR12MB0153;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0153;3:aNOp7YH81nK9lme625nPteyZ1tdV0lDZxjaGKygAMHRxOSTil5amXO4KmgseLGxRceFk9JTXpD0heKpoftWNt4i5tfkwmo/EwRuJQg6g4ZNAJqArOsd4OHqfLaE7KRXsCtLKAivWTIjdfI6ZrsoWn7b8agsS8teSqXJ3nQ4FzuJOIGH6DFD0KolyZMXFikVmSoD8fphE+CRzhF0J5eBnusi6A+en13GcwhhzOKoTdDroeSWI3CZMLAzDz5Ta9J/p;25:p9bggwyZBV9oba6uX2Wi6PMkjQaruege4WMGLsHJEqjC676FsOr0tnUfQMKyRBbpEsIH1TA2+WVpfLAPsXkTyZDbFzMLFdIM8tgFxNSYj6/VS2PHg8nolc9fy4FKIJeVXm+i2d0uSLfxU/50XmrZhMqUmiJxgamB7HWFataCDFa8fzdVkpP7MLDfZNBd6aux9iItKAspLAELGZbANdKtHXZ0ziJNDL/0hQBf7uRWTlaSJdGMw524hH2wcgGTTpfKD7llMlU+AxAwb1IxKsIpOKsYRfDGT6M7NjkS/9KSApZEi7a4bucgdlBQY8ylyg/jy4SmT/CJzVBLAorGGaGRFg==;31:UgQ99/w2syA0xOF8RTmwmSZIRQHQOvC+1uutxyRX+VuUPbb9ewQSsh4lwq9JQKEfLjTWUaHIFuKdvkTxMO8v4Xj+LcK3TqUaHCBRDupWur1jGa0cKE/6pQHitwMSvE+Pqpenm92f2Vc+2cmdoNVMoepF+JEyPhBxhdfyLCk0Eq0Z43VHYqjfCJghzfMBADh02FSh1FJ2l2CB2L8MSuEpDEHuGphONkrutFsA09i7UcA=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0153:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0153;20:K72DGCZNW2tMDcW90Welxs0oIPhiZE0vH05p0Owy8hJX+fivJh8LuKVhIjvNszumXyyKBKu0FmMGOT1ZqIKpjVBd28opWC7pcfJJavw2g7SprvmhGhyijQZkTbxm+anQpNktZ9XJHNb0eFtOezIe3Oa1VOpAMzgfk/LXTSYZA+wIJ4btR2Z5+QZ4iMDurtgPOdC2+BcuvW04nA7xntOTlv9xnYbGli6IC2oSienGF1/D0Y/fIfFil1V+mjxQnoNKo8u55x8YXtK3VbT78B5sHSB8Jc8BcWrNp5RN6l+MJkpfqhDokYfm3h6jUGkk1+X3HwadYASJwL5M9iEyBIfV8rvTyD9fpQ1h7u0mlzlt6Cn3oP1DD6dxAIrVrWYyRl1P097H/xFIWPY22k7rx9lUdg8qSjyHahtUxwPfrdhP5qOsJUu6lfgmJnc0g18PUmjxL3Vdr5ETE6F18jY0MIPJa/9y1VoI9WqQVqALrkcJv+OkYQGq7PIEnTUtXdQkLHtW;4:gN9rEM6wxwuHV6GF81PPyfWFQ9wURFHDPBh7ETOLkehZ2u4pOEDcD+0R8gvJAtnNMtir2nNzkDzVl/+VAYFs11vOfAxyMdq5PXoqq5EguIRo1tR+eSG4VEMAmI9RmRbe45+cGSr6ejcJvtSZ5lFdZHBRjTXmVuD3ZuEdZL6tVk9bRtuC7S4JJnxeMoCkE23Lq9jkWfmXkYAsk0sOuGA38D8J9YV2ky/zFy1w1M5rXbV41LqKLhP7bB/wKGh1nf9FwFg3+cguj5rAhqvqVkmf4ICidurwmzv7ee8OdhbD8BqQfGJCdE/UnGYNnOmR6UiYwISucBKtiVU8vOq6RY6ztQ==
X-Microsoft-Antispam-PRVS: <DM2PR12MB0153909C5E482CD348505E57E5CC0@DM2PR12MB0153.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001082)(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231101)(944501161)(6055026)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM2PR12MB0153;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0153;
X-Forefront-PRVS: 0592A9FDE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(39380400002)(366004)(346002)(396003)(199004)(189003)(68736007)(53416004)(97736004)(26005)(59450400001)(6486002)(106356001)(105586002)(1857600001)(2351001)(2361001)(386003)(6916009)(50466002)(5660300001)(53936002)(7736002)(305945005)(6306002)(6666003)(66066001)(47776003)(36756003)(2906002)(8936002)(50226002)(54906003)(3846002)(1076002)(16526019)(966005)(23676004)(52116002)(8676002)(86362001)(7696005)(4326008)(81166006)(6116002)(25786009)(316002)(2870700001)(186003)(81156014)(478600001)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0153;H:wsp141597wss.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMTUzOzIzOm9mTDE2RjZKajZva05nQ1FqV1d6VVE4Z1dC?=
 =?utf-8?B?djNKT3hyemozcVZYY1hOQnJJSFNENlVmSDdSbUs3b3JEV2FsRFdhUVNPTmZ5?=
 =?utf-8?B?bzVmOGZsckZoc1dheUVQd1VSMGMxQjJoNWUvRUNIWi9hOXVjZDBWS2dkNmox?=
 =?utf-8?B?ajFubno5eHFlNlNVL3VrWE5qT2UyaThJNXNPWDJvZnRCb3lxc3Q5UHJOVDg2?=
 =?utf-8?B?TGt0dUJUb2NhSGdKUldmWDZuL3EzYkhPVHJ3L3RVdk9pTnYvZmhGYVhIdmpN?=
 =?utf-8?B?aFk3OS9leXdaaXk1MDVXMUtzeTlZQ2o2SEExQUM3TStEZ2oxanFyUGl1RXkr?=
 =?utf-8?B?R3RjNjRnMDdWR3BlbnIzcUlvVEE4Y1dSRWRpaW03Q0JLeHpYWWtoMGl3d0NY?=
 =?utf-8?B?RG5jODlPLzl2VHppbVl0bjhTU3RWclZZZklUWnMxOFhISU5WZjZ5N0RSdWp5?=
 =?utf-8?B?d0NST09rOG9Zd3VsSzRXODJiT09uQXFYd2xBd1FqcUhxdWk0UDI0c0hKVnpP?=
 =?utf-8?B?TkowbzdZdzU0NFluUG9zODFabUhXVy9uaGo5UCs2dXNjbHZ1YVFLZkdmejAv?=
 =?utf-8?B?OEJFRU12NU9lcmpjSmpSQ0JqSklmTHZPdnVvdVlrOGJSNkxMN2lvMVIyUDVv?=
 =?utf-8?B?dWV5cEdBejkvSC84VktINmcxckhMMmlNbjJhc2ZlUkoxSlhKNWZwTGZLZ0Nk?=
 =?utf-8?B?OTFacFVRR09IaUpsYk52NzBNYk9WMndhZ3ROM01EVHRiTHdhNUxOWm5ZNlkv?=
 =?utf-8?B?LzRWcllidU1CdjFscUxpUGJvdTFBM0xTNXp0WWJHc1F6SVNGb3FpeWZaZ0pW?=
 =?utf-8?B?SEEwSkY2bjJ2YTlCNlR2YmhpcUxJYUFPZUlpZzVTSUhUVGsvcFVxQkZkbXZR?=
 =?utf-8?B?OXVkYnZXRHIwRWVYL0ovSDlYc3lDdkozanVINk1wczMzT0RidFQwTGVQNlN3?=
 =?utf-8?B?RTBRRHgvdURWN0Y5MlF3SmFUbnI5ZFE2YzR6K2s3bnZwRFJweWJOaitpbVFY?=
 =?utf-8?B?RlNyamR5U05KNnQ2Y3FZMW5rUFVOd0lDUUM0a0JoZDRMOGhVM1BBRnB4VXlk?=
 =?utf-8?B?cFZVdHJFTG8ydkdqUHB5cjRQSVMyanFEaUVNMFNIdmdESGZ4Rmg5eGFJak14?=
 =?utf-8?B?MU5xZnlSUG1Eam5pSGZ5dElsUXczLzRkalFzcEl6eTlhTjVERUd2TnVkNkpS?=
 =?utf-8?B?MGgyTTc0L0QyenFmMng5QW5mL2p4ZUJWcFFKMWdZWGhtVVhpSERIWndUd0wr?=
 =?utf-8?B?YzloMDBpSGVzTEh5MXk3ODg4OU1kejR2RmlHb3EzVzdnbjV6MGVtbE5UNE9F?=
 =?utf-8?B?V29HaFFiU3Y3NVFmQzc0VDVPeENyUmJIN0h6UkR5aGtyVGxFYnd6aHpRVTRQ?=
 =?utf-8?B?Wk5IZ0pibkFUaXgyR3lTQ1piTFFhWTRnTHRkb0R1YzByQ2luZEgxTXBRczQ5?=
 =?utf-8?B?S054T1lTbzIvR2JHOXJMdVByNFFrVHUvYzg5OWFwYlQzMnhrWnVaVVRYZENn?=
 =?utf-8?B?UC9OdzF0eDdvVjJDYzRSdGxGRVlMeEVOOStaWjBaYzExYVJiZHpFclFEQU04?=
 =?utf-8?B?bWtjNTVRVW9SdWJQRjJMaEpSSU4xUjA5K2s1N2U2aEVZMmJiVDhSMDgyZVVJ?=
 =?utf-8?B?Y0lFOVIwQXZLWHcxRGpPY291aXd1dVlmZktta1crS1A3WTUxZEpIc3BBPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0153;6:lgruWL53Aptki6NRdVrGPXdgA3sg+R4X/Qg8Z8zF79vZRCi1C2ea9IP5yiNkNVvJVa8BxALvRIaJNIgITYs0HEeCkV6LXwWdknDxmyAvLgPnrf1Fdmn3HlSBwpE3M3LIcPbwDsg4TbM0cABBbC03+5nZdqVpSzsYO8RbhOX+mZwXX//s6AJRZO/JRViZXaoQ4RZBPDRLVx+BmUAsJhJuM7bMEQ3ELta+Vgx58FJaBOZDMsHv2NGnJzBPuuYbPx5Ffup4suGPvWQC7fS2ru2iTKhjLlHRUbkyZj67R86BGDJoM1vLk7bFa7kAAw1I4RisVgz2ez9tnCB7PsDegxubvIkobbx80mh4Z3vmpZyGkpY=;5:4Avygk+DNO8kQoA8epGshMvcWi7qze7Yl/yO9HQsIs8pImnS4Gy1DzkTtbGkO/RTYAw+CPWCtoG9FTppLGDbHXbHfZqzifxzM4hhHmSC5mEgIjgc1EdJ9HtDLJHij/vhNxq1J/zbUq9Rby4GUe6HqZ1CJsteXdTFbK5tj2JUfzw=;24:LpaSc4cbJa1PpSBHIWpeZuv6csUMt9Qt70+GYNPrVxW8s/enRl+CyBNJnPbY2rhYl0oTxY8t39fyzoxk4sXoM+J2kyEI3vZ1Gr+keWu10u0=;7:H/tPrPMQkDzj2AWJh+l3MkdBknUCDfskoYw9qojscsAT1OeO7lCP+uv7Dr+/H6fMwOX+tPWWfbZ7CmbJNB8MM4wBRVKn92N6+PxqPqEal0ttIGRKSPQQPfrIGU90uRdKBsRv5cRF0jOP4ua8rVCAvd7LRIKS4mTj+3/qmzimLzUjZ7inrFmowCp//+MsLPnmoU2ZPJCxt98ho5Ww93xlZiVfWwWcTlC3MQxMZxSCBf83kzxCZ8tzUiriIkUNStIU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0153;20:j3kc5B3pRF5xN/syOP9FS3/20fDyoV/6PFbE/oJqje0P4B8AhP67HvN9kcYb57llRbFkeAtZfj9WTbUcnToPKB8ILNOYAy63jcXs9ovbOm1kfbeq9amnMEJeO7dCmkO/zt1z7PWirFwDg43O61+wK6Rsy9+b4VSoZqNYAEZUfZczkmPjHosJ9cqlLJ5jxDxM9qpNNiXG5rtIwhMCpOpLKojKFa+2qcUgQb0bGexmkWwQlnjnxhEGSCW2htaWuoJG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2018 18:37:06.1723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca42a45-016a-4f53-542c-08d57aec713c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0153
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the access_ok() to validate the input before issuing the SEV
command does not buy us anything in this case. If userland is
giving us a garbage pointer then copy_to_user() will catch it when we try
to return the measurement.

Suggested-by: Al Viro <viro@ZenIV.linux.org.uk>
Fixes: 0d0736f76347 (KVM: SVM: Add support for KVM_SEV_LAUNCH_MEASURE ...)
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---

We no longer need patch [1]. This patch implements Al Viro's recommendation [2]

[1] https://marc.info/?l=linux-kernel&m=151905677729098&w=2.
[2] https://marc.info/?l=linux-kernel&m=151923536116467&w=2

 arch/x86/kvm/svm.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index b3e488a74828..ca69d53d7e6d 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -6236,16 +6236,18 @@ static int sev_launch_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 static int sev_launch_measure(struct kvm *kvm, struct kvm_sev_cmd *argp)
 {
+	void __user *measure = (void __user *)(uintptr_t)argp->data;
 	struct kvm_sev_info *sev = &kvm->arch.sev_info;
 	struct sev_data_launch_measure *data;
 	struct kvm_sev_launch_measure params;
+	void __user *p = NULL;
 	void *blob = NULL;
 	int ret;
 
 	if (!sev_guest(kvm))
 		return -ENOTTY;
 
-	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data, sizeof(params)))
+	if (copy_from_user(&params, measure, sizeof(params)))
 		return -EFAULT;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
@@ -6256,17 +6258,13 @@ static int sev_launch_measure(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (!params.len)
 		goto cmd;
 
-	if (params.uaddr) {
+	p = (void __user *)(uintptr_t)params.uaddr;
+	if (p) {
 		if (params.len > SEV_FW_BLOB_MAX_SIZE) {
 			ret = -EINVAL;
 			goto e_free;
 		}
 
-		if (!access_ok(VERIFY_WRITE, params.uaddr, params.len)) {
-			ret = -EFAULT;
-			goto e_free;
-		}
-
 		ret = -ENOMEM;
 		blob = kmalloc(params.len, GFP_KERNEL);
 		if (!blob)
@@ -6290,13 +6288,13 @@ static int sev_launch_measure(struct kvm *kvm, struct kvm_sev_cmd *argp)
 		goto e_free_blob;
 
 	if (blob) {
-		if (copy_to_user((void __user *)(uintptr_t)params.uaddr, blob, params.len))
+		if (copy_to_user(p, blob, params.len))
 			ret = -EFAULT;
 	}
 
 done:
 	params.len = data->len;
-	if (copy_to_user((void __user *)(uintptr_t)argp->data, &params, sizeof(params)))
+	if (copy_to_user(measure, &params, sizeof(params)))
 		ret = -EFAULT;
 e_free_blob:
 	kfree(blob);
-- 
2.14.3
