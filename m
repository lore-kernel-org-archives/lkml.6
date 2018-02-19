Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753183AbeBSQNu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:13:50 -0500
Received: from mail-dm3nam03on0076.outbound.protection.outlook.com ([104.47.41.76]:32437
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752692AbeBSQNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:13:48 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com;
From: Brijesh Singh <brijesh.singh@amd.com>
To: kvm@vger.kernel.org
Cc: Brijesh Singh <brijesh.singh@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Borislav Petkov <bp@suse.de>, Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] KVM: SVM: Fix SEV LAUNCH_SECRET command
Date: Mon, 19 Feb 2018 10:13:25 -0600
Message-Id: <20180219161325.46988-1-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR21CA0069.namprd21.prod.outlook.com
 (2603:10b6:300:db::31) To DM2PR12MB0156.namprd12.prod.outlook.com
 (2a01:111:e400:50ce::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6a4b9ca6-4fc0-406d-18e4-08d577b3c0e1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM2PR12MB0156;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0156;3:4KezwSyLqc3dNahURAgIQsVz6kFtidyvcfDi/XiNXh6Vd/6bD8M83QgxDhQZBJadxVN+PVPc5TOOpETjdTsuclk5HJxhJ600b7pWGs+WRROB9X0QjubxQvfdwPabKfhFrD62xJ0CVkQOHn8hHbMSeAEk0AC/bEPYoEuzplTgQ3gOUxTCBc0KX8Pwtq+G/uTwQN6ZjkaKlPEsSOEmiIL6Jv5A0CmsxWhpoeoHnkNlF3XrtRUNmJwiCUZ8CnZMWGSa;25:EmKgVMkKgM/in52UHaXg3hgGtKAR+qOoq9dgM0lg3k3WIyFCdBoq+uwwCNdGE3Llivai2RpDtYmWGmF6Pm+Xao0S/kTcMbkMfH+MVkzghJB7O3IQcCuLS5jR5QGsUpXwf5ad8e2goDqnwei9fIvI6HWwDRy4srBO1SJ0qITKSej+PV87P/EpZO76cjduBg2RbQqGcIC8NoHvv08W5h17jWpdzDuFh6exUC/FcZd2UepWqAZa2oWCU9Trecb+Cx8ASGloGJ7hNGbkKqOS9VLvHGblVtYZuOrQ4MnAAWoG840ENuAU42RCzbWgoYuGkNO9U5YvhzoPQQAG9zc4091dHQ==;31:hIs8yc9jNkfYyJhjl4eb2nzcERYgFqmhE1j/l8+KnUluLi/geDm/5xP5UW+sk0+5DxJMb0f6TJdjq8rWuoQsHf1KtvsPMmeirWfPVbr0PtDZtpdjrKWvILHVSnj549tthpErV00u0Tdp+fVqg0F/DR38MpzraB78ZprBghuycdm+CJ+KLkT0cqshnkVpApWAyzqeiUemLbDxH9aC9gvtBsGWXO/kjRL9aE34alHeHDQ=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0156:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0156;20:RqEwreCtg9WLfbaWFmsczFFdTgEnVbdL/3PzV+Bv2+O2YJOcX07lFNybVKNW/XVCvqh6mN+9B6KLjvBzmnCIRjtb6Kp6yalEXvYNksUfIAUOFMvgnV7Is7UZB6P8kNp5Ddlcemmx18FmecGSNLiWGNN7s41vjRXSvWwONYUNjiOjsiqJV/644fLKWLVIkw0eopuvWFyaRmKkQGF0hL/dyf1JnEVN6QwFK0Ho+32oA0/UslXNEMcPx0ufeHWVLs+tftKlH9cHVkFbaC5a/lscsM5OfgtV3upbDGbbvW5E671JO48hpgCL1NR85fiX7fAEZzGFlnlT0TTTEt3cdQuBhar/EidekpqCZx6UomVCXXJyug0K44n3QizJtCQmlVFQ15Z75q/oNZKuJr/4v2DWI4rSazQteYKv1TORL8h0Ywyj+VM8/bbYg1M57anL6isu8OdJpzKyglsjiYjQTnS+Nx7XXOsXLyMSubIW9DTxxKWr0T6mu5CkakfVnrKRFch1;4:6TBHvIYeRq3w+Gz1DWP8j9MurxKJ0gfsezpMrlrsxYKE4KjJkIMSt9GVEugW3XELRFNfs+0kBpkO0a0904JSWxz0tS1GPneYjzl7xGracvk2zoU4VMrlLiKC1kzwETJzDBt4RcAH8QMQ/REY+DbOD4paGwXG4+QS2/ZJhrcx94FBYw275QGOOob3NOwdou5vkz63RLgVzujFcwePY86etkP2jP+Bg6VzRoOVeT2QoH4S8kDXwnUzI3EqUzasoMwKFvvhOgsG3KAzMf2IgzzNGKiVBCn1Yx5CaSnUtaGNH22XLivouFJyDzC4bnjZNhMaMUbSJW3w1nKuhog0xaxCBA==
X-Microsoft-Antispam-PRVS: <DM2PR12MB0156FB1FD7A3A76128CDC769E5C80@DM2PR12MB0156.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231101)(944501161)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM2PR12MB0156;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0156;
X-Forefront-PRVS: 0588B2BD96
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(39380400002)(396003)(366004)(189003)(199004)(2351001)(478600001)(4326008)(2361001)(106356001)(54906003)(50466002)(6116002)(3846002)(86362001)(68736007)(1076002)(5660300001)(1857600001)(6486002)(52116002)(53936002)(7696005)(25786009)(23676004)(2906002)(6666003)(26005)(16526019)(186003)(66066001)(105586002)(47776003)(386003)(59450400001)(8676002)(53416004)(2870700001)(50226002)(6916009)(97736004)(36756003)(81166006)(81156014)(305945005)(8936002)(316002)(7736002)(219293001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0156;H:wsp141597wss.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMTU2OzIzOk9BNDFmRFppS0FVcnZZS3pMZGMzeVgwTmhN?=
 =?utf-8?B?NUs2ay9BZ1JBREdoUytwL3RrdVM4NEFoeThwdmZmYnpHc09DZ1dqUElhYXAy?=
 =?utf-8?B?bExUN1ZPRzgzdGRjam1YZmxIcTdmeFNYK0ZrdG9XVnRjdFN5cmRzais2ZThH?=
 =?utf-8?B?YTNXVWl5S1p4bFRHK2RpcTY0b2wzdW53MG13N014aFpscnNZUk9hdzVoRnlv?=
 =?utf-8?B?cXNGZnNUQVIyeWhrT0ZCR01WK3l5cG1ZR2ZmWGJaOUhwbWZxWXBXTVpua3R0?=
 =?utf-8?B?d0p1V0VaSkZEaHhUc0ZwbFFQZTlCdjlJVStCbVBMYmMxdHhOMmtuOC9yZVo5?=
 =?utf-8?B?SEdBeTZwRXdoaTdWUis5aHpiWXZ6NW9BSlZlOTF3ay9hZW12UVlWdE1PZUE3?=
 =?utf-8?B?OWN4L2dBZUFxRXB4WS9CMUZJZk13S0krbDBUcS9mS2hBcEdPOEZlSHRBemRx?=
 =?utf-8?B?b3Q0NzJ1NU5ib1BZcnlwN01STzVMem81Wm5kN0Q5SDgxT2grSmRxN3Nma2FO?=
 =?utf-8?B?WkFwdzRqQXpQUEliN3gvV1dqV3I1ZG8vSjFlT1FRbFRCUC9iUlcyUEJXakhR?=
 =?utf-8?B?MForc21FQWxrdktqYmkvRmFLL3ZyWURKc21OSjJtUXVkSHFuUlhKZ3VWNDlM?=
 =?utf-8?B?NCtUVHk2U3dJUWxOZnJjTEp3RHNxTWl2aitVOWZFOWNFTzB1UzZNUU9CbHpk?=
 =?utf-8?B?ODhPcm1IaWxoUk5HcUFMZXVreEVrM3NDV3ZrV1cxczBpbDBiR0I0STd5NkhW?=
 =?utf-8?B?S0pZRXdPYTZRc2s1T2RsOVQ4aGNxT2Q4NTVaOEloTU56WVp6RkVFK3k1QVpQ?=
 =?utf-8?B?MHhLclBKUU42dm9NNWt3TGh2Uk53ZW42SE9sZDZRekQ0Y0dyaklXUGpsZ1c0?=
 =?utf-8?B?dWFKRlErN1E0QjNrMnYxU3lvMjlPb0VGQWZKUkdkRUw0cnNnYlIvN29EaFov?=
 =?utf-8?B?enNPMHE0U0dxaWlRb2daMFJYZ3pab0ZOcldwM3RFUkkwbWJrMVBLTy9PaDlr?=
 =?utf-8?B?emxRV3kwOEtBU25qd2RwVytGU3R0MXZpbWd6VkZ4NXI1WmJIUEQwb1RicFor?=
 =?utf-8?B?L0VyMDZIWEE4aCtvMUkwSFBHMk1HMmNtQjZmKzNuSVNESU45dGpnVFJGRkdt?=
 =?utf-8?B?bkNVblNFc2xrcWQ4UU9sREtkRTR4UEJnZGRlbWhqdEIxUVQyUkRHZjJLdVly?=
 =?utf-8?B?VEdZbENidk92N1dLN3pPOUZ0aW1RLzM2aXFYUW9XeFJrcnFZbVpLWTZWOHFp?=
 =?utf-8?B?U1hBKzBiMUk1aEZGMVd2a3NocFZjZ0tGeHVKaFZrRm02V1l2RTZScXRtbm9v?=
 =?utf-8?B?QU9ZTmR5cGE0MUdicEMydXNkdzFWNFZoSUY0MUw2NjUwUTZSditnS253Nktp?=
 =?utf-8?B?MTNiSmkrOWViY1F3UnhxbVo2NldTS2ZCNDZpbURwWE9obWNZSXlHNStxYjFH?=
 =?utf-8?B?SDArVkV0VlV2RGJybERXTXpVN1kxbGVoVklmZDR1MnVOU0ZObVBJb3l6N2to?=
 =?utf-8?B?RjhzalM4elVhdDB0cnZoeG9VNUJ3SHoyTm1KLzk1Z0szWk1UMGtPbmdVQXZq?=
 =?utf-8?Q?mEBHC8bvOMkmwDprLDkrH9LjLVC18qj35MkO+c2faF64=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0156;6:sTDofi21+u+48qv+gVmxyqXwChxaWChYEuk+g7neGLAVAiKXmiJ1J6vCPQun4uRFyM6tP8wL2fy5zuGeXeZJs2fXLuWBwbfK1V8ObCpFKo0iz/79k5U9crEqFaOScPUAi58nO8b/hlhjqHqqCouR6nXoflf2QpO7fQN7JfPGR0PmVIAPuNSbqha7n2ocskH23mAcen1QR0pT+EEL+GXFJySN8mPv5Z/Y5vgXUJ0RbILu5j3lKhDvh0EcPMb1NyTWdwPaLgQvUHc5CB93Unrioc4Rqgf3SJj+6+SubesmXAXLjahd+Sw9ME35W97tQ9dTSzme13ZONRclgyCxMYqzWFpZZqZ1UGS2lVHyPxvg00U=;5:NyobN9+WYjjlD1HDcZ+p//r6AE2Osht5iYhoZimb6mW6GsbBOo1Q5MrCAo1FqfvYQDpuiCf8h+63+Fx+lCubEZ0s0JGqsBfANcTZy9GZahusgOEXSsiXbmcMlIkCS9E6vtaCg57gN8xZmq4iB5wNTOF9zkKextxEDRd1kZRyMak=;24:ywyHn+7Mp8Bt2Citn5bLOEPWR5rTFhW/7P/fbKdfk7SlzsUiMQuiVcHxSfQsIp/obHknMeJAWJOYaqDIeb0qN5b2IfM2YWWBrqm53qiGHmk=;7:MJ/ptLVqMSC9QenN+GIdoKXAbJPAMY7INZ2kVjMNR7u7bcsb+ezo+VueNOPv6PXwVyoZSR5HpZvZNypFYtxxY7MQ2/Gv8CKeDXjrYHgKbVtG6den6tSvx2e3s4rZPzGGvEX5J2UgkL7OwFsP7jaVA31m10EJ4nZDBlxZJY1dHCmjYPhdFuK4DIcffQwATUm33Q0sCpyZt8+HCvbsrDoYkSBnSvo2Vxf/hy47wgq/O2JV/COHJgTamPqQqI33yvTh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0156;20:zBIbsHzOvA/H1zB4dEE7lk3hGKxes/IhKrbltWZdDri5QVczzNti1fnTRfFJ4Ym+XHT89rXo77dNlT0w9DU5e7O4hl9dU++8yYMGVA4PWJYWyUd/kshrA39RpAxFzd+Of5sXtXZRoqdiAv/lNifsVXbgy4BjsooHFfA0De5++57P+31XIVrPD861VSBgP0GUzuzliuAyuUf0d4WbAppnieikEVLcr+9HldNPQZuZ04raxrJMydhT+e3UEpauv3JX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2018 16:13:45.0840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4b9ca6-4fc0-406d-18e4-08d577b3c0e1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0156
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SEV LAUNCH_SECRET command fails with error code 'invalid param'
because we missed filling the guest and header system physical address
while issuing the command.

Fixes: 9f5b5b950aa9 (KVM: SVM: Add support for SEV LAUNCH_SECRET command)
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kvm/svm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index a2f1bb73640c..22fc3022386a 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -6599,7 +6599,7 @@ static int sev_launch_secret(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	struct page **pages;
 	void *blob, *hdr;
 	unsigned long n;
-	int ret;
+	int ret, offset;
 
 	if (!sev_guest(kvm))
 		return -ENOTTY;
@@ -6625,6 +6625,10 @@ static int sev_launch_secret(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (!data)
 		goto e_unpin_memory;
 
+	offset = params.guest_uaddr & (PAGE_SIZE - 1);
+	data->guest_address = __sme_page_pa(pages[0]) + offset;
+	data->guest_len = params.guest_len;
+
 	blob = psp_copy_user_blob(params.trans_uaddr, params.trans_len);
 	if (IS_ERR(blob)) {
 		ret = PTR_ERR(blob);
@@ -6639,8 +6643,8 @@ static int sev_launch_secret(struct kvm *kvm, struct kvm_sev_cmd *argp)
 		ret = PTR_ERR(hdr);
 		goto e_free_blob;
 	}
-	data->trans_address = __psp_pa(blob);
-	data->trans_len = params.trans_len;
+	data->hdr_address = __psp_pa(hdr);
+	data->hdr_len = params.hdr_len;
 
 	data->handle = sev->handle;
 	ret = sev_issue_cmd(kvm, SEV_CMD_LAUNCH_UPDATE_SECRET, data, &argp->error);
-- 
2.14.3
