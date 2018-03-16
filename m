Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753741AbeCPUjS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 16:39:18 -0400
Received: from mail-by2nam03on0059.outbound.protection.outlook.com ([104.47.42.59]:55584
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752514AbeCPUhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 16:37:54 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com;
From: Babu Moger <babu.moger@amd.com>
To: joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, babu.moger@amd.com
Subject: [PATCH v2 1/5] KVM: VMX: Fix the module parameters for vmx
Date: Fri, 16 Mar 2018 16:37:22 -0400
Message-Id: <1521232646-79580-2-git-send-email-babu.moger@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1521232646-79580-1-git-send-email-babu.moger@amd.com>
References: <1521232646-79580-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN6PR17CA0018.namprd17.prod.outlook.com
 (2603:10b6:404:65::28) To MWHPR12MB1776.namprd12.prod.outlook.com
 (2603:10b6:300:113::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 15ee58ec-bbce-4cf6-3882-08d58b7dca51
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1776;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1776;3:WVEOA/L7e0wkJ023PUkYd92KGB4vJJSbaFmnoImvyvGfJf0V5eh67V+0MlXripyRBE90pfXoMBcS16wZygQhLZ/7FiyFMuNpXgewTfO6w6VDL/b+eBVbZJaB/nx7EP/fv1XNe0ONKhwYYruA/qmRvo5iJizyGShzwCmFsnD447vyNjMQKsfdZxd8xgc9m/ZZXJ4CqlzX1lBOB58Nhr0lX7ueXZWZ2KjL0SggCqAWJMo63XqsPr4DKgzWCSrFsz09;25:JFTlX8xUHr7+O/+Dgvtlhl6BXLXNcLYmkGETf4fdgzCYx2rP21+Y+4YlZ19vBrvwMeM0g5vZTxSxNl29CeojnlfMsaL+zxY+hYi94CxxmqF8mOWrHruM8nN4JjEeErJ/infb/1rIIC2GQMfR0UzIT7tDr3DB4N4UsdHfIfxNEHoy7/BIqDftNOPVmlcVT12JSBcjVmRNB1umJMqg1tiDWoXn7QDV3U/gEQnJnyst0JyWxKiiF9pZl5H9JdjSoV3gBJjd2iXnPSa2KJYt74o2lg4V4ruGL2mPGF68SYiMA3h9cxEtgawMA2X5KjwYD+MWDBrxaCJYEFvvh/YpOYc5bQ==;31:DbVMyt60zCtgMuKbM8frgZ/rxDWVrPTngIZkr2gxAhh0EAWB84LlzvMUvjkJ4eOShZdvOnLkY4Py3mocvWFaO8+FiGvz3J2z4bXuJDCcfvafmIXd85Ia5rqL5UO6j4oPSYiD/bo220/3MKBEZIBuxY/fkE31XrmxVpcGqJla7Z7tG1FTmdNglSdRuBrG83wSVbFf0XMesv1q0s3ukTXzZrcxW9/QPzPWfKkoiP/OjmY=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1776:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1776;20:Quh+enu6pLPwwBDijQmh+vVVzPT2fOA0Q/+XrTiOdPdaH2nhkpydNjYvCsveen+iGdghmWnpCginnw8xpYzuKFaW04YBNKbAUv65hGognN6n+VJuCNTIoGHE2Kv3pUXzBTzwCs9KhB9Y4jGzQgnyYQ3wZfiz/c/7LoKqyEW0OLBtBSKtSzWqb15kxvmKNMl62C26fcrW1zxitfM/eUMpOHdyN4Yoa7wQ6g3L4X6jgFxmzM1IEXVLMcO+DjL7l9ziIZqGHKx1D7YJqJf62vXDXA4ADDr6B87xOUzoRbKmZYio+0LWYr1iC2wZVx35fMzEaEtza1RBT5BcR9Mu/m9CSGVtFo59rr0fzeWWZMp16gg7PUS6QeQXIefaYDiHP741KZ3MaFRIuj5Q7JtBsrhkL6iSxa7HK4ZvBtRaXV+DPC9eVixWrhdIuowj/hNOvrCdKbjqVtewByrzExsWVSb4zUyZ90eI/PSqvmVnGrOO+qLNjGKHPetwY7hAg2AtxfwM;4:3fbSOqN/73eciENpMYvWjujiURKqP91CBIvbnSj4MUo1cQvqi8hDbirCS8PrstB1RuVm1Sk66TFDlYlHMrhFg3F3WiTMOAxB1I7zMNYAn+8oLf3B4tdWZU9+8pUFDWrJPMGJ8FLoRLbHCiWazjh6vjwgOfpvq3JanxkmMbNgbMM8Ojf2idyTEgKXC69QFxddP/1QAIE17rNIRCvTlk1uhnx2JXoQeCBIEjU9coBezTWiAdY0+NcI+onQjS+9volx+h401wvPhU6sK3sNm5ayTPak1H31bHd/UHVnn3VPQDd5Mgj/+NKScRdBEDdpi25e
X-Microsoft-Antispam-PRVS: <MWHPR12MB1776B52C727E1E6FF586AE1395D70@MWHPR12MB1776.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR12MB1776;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1776;
X-Forefront-PRVS: 0613912E23
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(39860400002)(346002)(39380400002)(189003)(199004)(81166006)(8676002)(81156014)(50226002)(6116002)(7736002)(186003)(16526019)(3846002)(26005)(305945005)(106356001)(2950100002)(16586007)(478600001)(4720700003)(386003)(6666003)(25786009)(316002)(59450400001)(66066001)(97736004)(8936002)(4326008)(50466002)(48376002)(52116002)(51416003)(7696005)(68736007)(53936002)(76176011)(72206003)(36756003)(105586002)(53416004)(2906002)(6486002)(47776003)(5660300001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1776;H:linux-pyp0.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1776;23:TEOD/WcK0YBCknSBoRebCNaD6FQkgjSgHd0xWfL0X?=
 =?us-ascii?Q?brVqjwNc7PceDv7ox9b/oQhz2tdcz/Ms8BuI0DEcrPijJJbI89BTvUVlduWS?=
 =?us-ascii?Q?EA7gIq9JKyv1Kb9BRVDhmrDWup7kU+jIPYaoiVMRTV4+e0l9y9JMdR+0HNax?=
 =?us-ascii?Q?3P2JD1i+irDV9RVH442VObdV8zuIL0l4QadXKuAHS6Tbt2tpdBmfR+4wrUqw?=
 =?us-ascii?Q?LrSh9E6ZOWHu9jy6wOhyUxlD/AKfxY+n1zyp61DnY372upX2hSQc34XEc/oy?=
 =?us-ascii?Q?/dZ++4qpQojv/FoANNOSCYJbKZP8QiXFscIDZLfctTQrXzyUHRe/suEkLZ7c?=
 =?us-ascii?Q?aG+9bLdTrl1p9cwQeia8L8ZhWtw9aA+WXDCWzWWgo9vXfyeA1U7DaXaFqCve?=
 =?us-ascii?Q?KNt9KDEI1f9x0sCu2mIIIEHnYs9Rg/2vZsMKHUToGHcN8xD6osYlCc12PWa4?=
 =?us-ascii?Q?9ZLIxveSVfiSRbdqYSNpVYCT+Bx4oSkK+ZQzhJYD5niboMzWvUE+JSazAQ+X?=
 =?us-ascii?Q?TijRFXP7Sv4QV4BVzp7yBR5syWKCnIu924Xc7dCCaq+XASoUDgzCr7uvCOHQ?=
 =?us-ascii?Q?Dw1b8NKrx8qnk5GDPPEc/PcD+hBhNA7kuc/+A8ubZTZ40jUmLgxNFz4p2dcY?=
 =?us-ascii?Q?AYU3gv8TP1h42rOqitHG4Q7jX0ut+kWPlsRVIuzPcb43hRL9NVsbWGT13+Dh?=
 =?us-ascii?Q?SXD3cEcv2e4qkSvZm31z8JRy4Vpaf5mzk2xaKUjykG2P9WJEmIiVKrFFXzKU?=
 =?us-ascii?Q?HL+qpivjgv+9o3zpIQ13Y6dIhL9vqZJMFDYfTcQUvy+eXEZgjbGxqcWp7Otg?=
 =?us-ascii?Q?W9678n+Nl1kmRiPV3yY0usjlVUY18L7fK+lk8/S8JUIYnsGOsacgZbZS0Yv1?=
 =?us-ascii?Q?6cnKyFDRH0/o20iiPbf1Gx+/8mEDgKl+86pvCcY5cqkW9jsoMA1bzQGPCXUg?=
 =?us-ascii?Q?uEkjnutdiDRyAeCUvG8p0AyBpj2WkiVO3yMx3UzjC1MP3+7OX6OZj/Thw+hk?=
 =?us-ascii?Q?Dwgkvs5uERyk9xp5kmQ0hi26YgUM+ERCzLp7c844bHPAJhCc0BHandsI9VrA?=
 =?us-ascii?Q?loICRVNbqxh05I3IrZKLoU+DNXDOtHWteGFRX9XaRispzVEr4J1M7j3hCeOH?=
 =?us-ascii?Q?t6HxOJ9IPXif4cxzkXlwW7cZGPbjEhwCxIUCn8U2egu/9r2qTKqhg=3D=3D?=
X-Microsoft-Antispam-Message-Info: iF0rD9SRRlXX2vJdue/d/+iADOBcYw1+hH81BvP1OT3XX6YW0R9OFYF2ixaOHE39DJuV4ixQauouKNFTaS4//6h3xd2DhkwMO4J0aYgkcG69ahN5KY3QVaxqrnlrmTvS9R73jZXmhzK8OQFtPJn2sc+1dqgmdzOSbp+rB7VW59iXX1vg9cKCGDAWaVpm/3+s
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1776;6:p87091nwq/uFtfZ9jxAeAUMxQ8XwwS0d+RYyEkCTJDJKTH9/1SZYM7jWThowa4jRmvfhO3oxQk9zXY4vRFaRFViCs7XVgoSdU0Nq5EAAZm1WUDS78mGmForAYefK/HfLSLXGaCiVaGGy4jFMs8fzTYw71c5uA0pXLuwW6puhdrad6I8GOXH52x3gHzgqgO+JwJv8QeWtd03rxutJHIVTvVgGus75jDFLE8JQESlVJST3idwZfoQVUew6iOPUPSCRqRfdV8hEQXHOBu+aS5cldun5Jj5d0mzHQ+uMY5m39Olz5DgBUGz+o2htzuM5LIPqhL+488QvGFdN1gJhPkaeJuBmb1yIGUzJHKg79kzHU5A=;5:Vqhe6EgWoX9i6VNonoPwpFw1c0xdQAK/iPBJV1PyCZqeSly8tKt7JDMaJolBgwa1g/h48yQinxH//5A6mz2yHZmMZhdWKVu0+A03fOAim9qHcfHbDjy1EFIESM/RiGiVQRr5H7EOrWoYZAdPjoSbvUcF6iGGjIC7RJU1yEGuBl4=;24:oCLIi6q3cSVte8zpLBtfsssy20+SpryRj5BrZgRwjfnHJP0r7sf4fa+Mjdbb66sK5NpgbROLwu9hbFWLPWievYOqBF0ee3VWb7E96d1FGXg=;7:L0bxcWo/b0d4tkf9bllixpVznPOWZOrZAEVXOZvOzTLyNY5Bo2VzzqwL7JZOYDUHcW5sKx/Al3pAUN4nM9Tj1Rh9x5uSMANhbRQh/IFt6cY8IM0NXkvctwftEOwXuTdTv7RQjBo1VJtLZpWndWMD0s6uvuHp9zZGKvMrWxRfCNxmb+/dykNf8mFd6q1DtuNdEAKvHkIAy5jj1q12qtZZekC1JZGbZxbO7B4do4EUwAwHzsRTv5qWQ90mFzIaC3j6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1776;20:lcBJXjm7aLu9ozHV5gyOFLv7WV2pk5H9+9Nw8mbKogCRFQBZ1DkMUi3tmmLwZoG756HMxkCbYiEKniGH/xu6un/zvR0+21rODCCzsu62TrhLxX1U2gHxiTFJc1dGrZW4TrmsnN30IHj45w9acHRDbtRPJE4WWQFi5U2pYWoln3RqfU/hZfXmO+Sh10akEvus7dRtwRqTfmCbj/ITc1vecEhtmATrsQHewXh4+AKq4JHl9XzD6+4stzhfttgVVc4H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 20:37:50.9599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ee58ec-bbce-4cf6-3882-08d58b7dca51
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1776
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vmx module parameters are supposed to be unsigned variants.

Also fixed the checkpatch errors like the one below.

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+module_param(ple_gap, uint, S_IRUGO);

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kvm/vmx.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index c829d89..c9a9080 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -163,24 +163,24 @@
 #define KVM_VMX_DEFAULT_PLE_WINDOW_MAX    \
 		INT_MAX / KVM_VMX_DEFAULT_PLE_WINDOW_GROW
 
-static int ple_gap = KVM_VMX_DEFAULT_PLE_GAP;
-module_param(ple_gap, int, S_IRUGO);
+static uint ple_gap = KVM_VMX_DEFAULT_PLE_GAP;
+module_param(ple_gap, uint, 0444);
 
-static int ple_window = KVM_VMX_DEFAULT_PLE_WINDOW;
-module_param(ple_window, int, S_IRUGO);
+static uint ple_window = KVM_VMX_DEFAULT_PLE_WINDOW;
+module_param(ple_window, uint, 0444);
 
 /* Default doubles per-vcpu window every exit. */
-static int ple_window_grow = KVM_VMX_DEFAULT_PLE_WINDOW_GROW;
-module_param(ple_window_grow, int, S_IRUGO);
+static uint ple_window_grow = KVM_VMX_DEFAULT_PLE_WINDOW_GROW;
+module_param(ple_window_grow, uint, 0444);
 
 /* Default resets per-vcpu window every exit to ple_window. */
-static int ple_window_shrink = KVM_VMX_DEFAULT_PLE_WINDOW_SHRINK;
-module_param(ple_window_shrink, int, S_IRUGO);
+static uint ple_window_shrink = KVM_VMX_DEFAULT_PLE_WINDOW_SHRINK;
+module_param(ple_window_shrink, uint, 0444);
 
 /* Default is to compute the maximum so we can never overflow. */
-static int ple_window_actual_max = KVM_VMX_DEFAULT_PLE_WINDOW_MAX;
-static int ple_window_max        = KVM_VMX_DEFAULT_PLE_WINDOW_MAX;
-module_param(ple_window_max, int, S_IRUGO);
+static uint ple_window_actual_max = KVM_VMX_DEFAULT_PLE_WINDOW_MAX;
+static uint ple_window_max        = KVM_VMX_DEFAULT_PLE_WINDOW_MAX;
+module_param(ple_window_max, uint, 0444);
 
 extern const ulong vmx_return;
 
@@ -6640,7 +6640,7 @@ static int handle_invalid_guest_state(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
-static int __grow_ple_window(int val)
+static uint __grow_ple_window(uint val)
 {
 	if (ple_window_grow < 1)
 		return ple_window;
@@ -6655,7 +6655,7 @@ static int __grow_ple_window(int val)
 	return val;
 }
 
-static int __shrink_ple_window(int val, int modifier, int minimum)
+static uint __shrink_ple_window(uint val, uint modifier, uint minimum)
 {
 	if (modifier < 1)
 		return ple_window;
-- 
1.8.3.1
