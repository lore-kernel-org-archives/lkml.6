Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752897AbeEUPNU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 11:13:20 -0400
Received: from mail-bl2nam02on0055.outbound.protection.outlook.com ([104.47.38.55]:26976
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751843AbeEUPNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 11:13:18 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com;
From: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
To: x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Radim Krcmar <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Subject: [PATCH] Use 'imply' with SEV Kconfig CRYPTO dependencies
Date: Mon, 21 May 2018 10:12:53 -0500
Message-Id: <1526915573-22917-1-git-send-email-Janakarajan.Natarajan@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0701CA0010.namprd07.prod.outlook.com
 (2603:10b6:803:28::20) To DM5PR12MB1369.namprd12.prod.outlook.com
 (2603:10b6:3:76::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1369;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1369;3:jZn/F0kenD4WztbRXdTek/YaIMSCtcFc3xvDvToxXV6Fu++NW6q2LOFozQoBy2xHIDS/JPF++/jtKjyyB3UCtBxrWpokmA4sSfNmsYIiVP+f8vdHurlKYTgLvovW5L0QV60BL5DJ01R3ElWo/9Am/RfRdzLYMNDU4gEy6BCl777404FjKYv06XreQJbZsk1HhdJKW9LVpOfGYTuJNF1n6/BkT/7rrg93Q+ma7RXgj8q3cxyl4EEpvH/6R4y3LOf6;25:PJ1F0hCevR2QezzpAY7Y+5eruv0pguoxrrM/CNk8fLtHt+84cy1swsizg9Dfvl/Q5A8NITSDColsFE7HMCNLz+ziSJY0xKHSHYsYvafthW3Hi/OwG8YeJSJM7UfFO2hYS6ssDuTXQv2abcyz3V2WMIPN923FhP9EkakRsJYv2En+rCDRq8/sm7u2fpwMlRNwAazPuV+n2niTm0M8ZaBLDkZsRcDMwEmvm4c9hhoQupuEx/HMSYRUCdwKW8/4HmCNcKSCErZ6eYwNIGFPvqh7Yg/AyaCE1UZM55A9o0XTcL4qbjk07Lie7OiFXzI5PnDYEC7inpwp3ny6gHsBVMgGnw==;31:RTg+BjojGD7Aj0MGy5Q7fYYfgXIwduSdnuBu9P1GxjdITGgWgFK/ObkRlG5NaS9hMP2mkOzoy8YLy7iHgGGOuMQrQuROH99fq8c5dyxVPmKXqjP1ZDm3gVPVDbsgjXglPcm0pEDKU8br1lwlUl6xF0NTZSfdnqQqUKf9bWFr9XDbKvF7rU8syupbc/8KY6Me69Vprm1YCm7qHyiU5oQv/s2kFySUFgsrEvU9SiJlt6U=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1369:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1369;20:GY30WwiRBAobDD1eB0p+cpk/X4+6m73w8zfHwjLFJGlSjOhc05z/nXYjiKpALWVT7NSIwa6lwaMahwjlKVHCmyoFgEMKw2XCBwCcqR61GroRHrJvhQDByRyNYqnOagWNf/ec1BHtz4uOIpKrDKWYbOWWlah3FJfkhPQVs9oAEpcWpCdkAdHmdg/hLGorq8oS056k4QIhz/T32mhxKTA5T7BQSHO/q5ptai+irliDWgwvpC5WJCSEFNSMbyi9KUuB88dvV9We1Xad76eLoXN8tHb/KiJ+K3kyMyM70pWI3ihDAq4q5vyeUCG5bZ4VL4PY3+aFktYV6cL92l+rFuqKV9YXbpBAdhYQW4CSs1gYdLeP7tUkuuBdJcVnsVuiMuBzDxULtVyQeU2eIRavOwCCQyRzmxhkgoTiPeXhWGcag5Q5PVAK0CnfYpDstr2VqML8WlI6f6zz8jZ7U/gvFD42jrdJu0WNtXclw/lbTzQqZnbsB9RCo3tgQ1xeeWUYmnU5;4:c11JGGOuvaLbmO2Ho6g0NqpuWcXHPe6sktDowMdWs+hKZxWACI/GrhoG9sL8S4w8diFS8AdtEwUBP0QdaoxvR3qYBMsFzfcUQ0O6azWLn5ppe0Xdo19FomxqF/t9TjmGl3LmjwM80YzWxT1EE/9vR9I+lnsvYrkd12o+yOpDeoH0JDYvZeHBgRDCTy6dzbDpdDMu0FKIrnxgVnS+L64V0Ycmou3l3/cPT0YXK2Hf3OjVVkVdssFb0U4/BWB34qAwHqQQJMZ3dsMuc5PZFJ3R9LXrXskdKjHiHD6A9G/UpI6hkz9OMmIRC+DYmdXqy/w5
X-Microsoft-Antispam-PRVS: <DM5PR12MB1369377AE22B73D1CE506E14E7950@DM5PR12MB1369.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB1369;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1369;
X-Forefront-PRVS: 06793E740F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(189003)(199004)(54906003)(72206003)(6666003)(5660300001)(2906002)(8936002)(36756003)(50226002)(186003)(305945005)(26005)(7736002)(25786009)(53416004)(48376002)(6116002)(3846002)(86362001)(105586002)(386003)(50466002)(4326008)(66066001)(6486002)(316002)(53936002)(51416003)(81166006)(68736007)(478600001)(81156014)(59450400001)(97736004)(52116002)(476003)(7696005)(956004)(1857600001)(2616005)(486006)(16526019)(8676002)(47776003)(16586007)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1369;H:gi-joe.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB1369;23:QUsr3YBRCWouiTjqPixrVeoxx4tXJF7dNJOFOi2vZ?=
 =?us-ascii?Q?F4l2dhVhamPUBJObO+kjBUk0th7MHgJkc+uP7N6smQGF76dO3F5+sVxYa5Ir?=
 =?us-ascii?Q?TH3VN0l9NJ927w3ifvDABiFOO0fybSAhSEeI0UNqw0znhijG2dnRa0u4qXvm?=
 =?us-ascii?Q?oama1qQXMsaqrGwKhj8PnUfJM3LQdhOjq88fiG8CRKjgybm/NZzdNuZsSSpO?=
 =?us-ascii?Q?JpQxoh1jKWPB75aIYcamokCjXvZHbzFt/ZAQIzpBGLqcfglhPbRpmnA+CTip?=
 =?us-ascii?Q?2sFtUDkw+uAU8IVz2FBBzwlZS6Xp/iRFdHRWbX20ltdg1NTpxUtAnnUgp2Px?=
 =?us-ascii?Q?Rb0MPf4oxbJNfLCNLjM2q5hUdcG5jjgFO5DLIKqIPpFwTeZxOzS1RUnOPrh5?=
 =?us-ascii?Q?aPUf+/ocYtAMc5YiCNg5EQUGA0MwFHieWFV3dHD5oqEMeEPYEMggtsRWDw1S?=
 =?us-ascii?Q?yLWgz14rV3fWV2ePg+cNBdFVukkQfOQJSsPt9s8ak3agtZxKr86z14A0+UZX?=
 =?us-ascii?Q?2yZJKVrsVtqPcx2xZnjdV8lEbRIfgN947wqsvw0DnyH08FLVzfHbSHPD5ZEn?=
 =?us-ascii?Q?FbGUWUMPEci5RYaCu75gE80Ks/iS9SNV/+cylF3UQ4HcDegHgTcwBzPT1FdE?=
 =?us-ascii?Q?mTUdj/Fbo5b5w4GnvXyVgWaJU2kqGtRR/BqIC+CLQOR+AvhVN0ZBVAYOLMf/?=
 =?us-ascii?Q?fGZ496Uq2c9DT+Tm78hwgNMzeya86JfgvXTXOco+S5i+ukWMrSVF1LuJfYKK?=
 =?us-ascii?Q?b0FGmpT91JTXDYT8C/CViG1P4cdDFe4oYtHie2FYqWec7o1o+850sGUf9Z1I?=
 =?us-ascii?Q?FY8bkLDoPNxH2rHXQWKAp1DyFN1AwxcBYaUPiF1yiTONrokJ4Hp7pilvWpYl?=
 =?us-ascii?Q?7N5Vdnr03i3VwYe51nV5QLBIKLvTmhpw4h16o4Px7NFn7vx1zicLhs0Tgi6t?=
 =?us-ascii?Q?iTWipIfcAaMGTwearN0ID4uIgUtelrWoakqwZhCairRY3YMEi22pwDvyhQFv?=
 =?us-ascii?Q?tq599W6VXMGpOtv3Wr55KgPhpqIj2ATay4TooohAl8D9j4HkdEQDvRvl4D2v?=
 =?us-ascii?Q?5KZ6yZkYQHr9ffS5YHHW3Q8RE7M4gnHx5ckoSu6vWSFB+kcyzOZ7zlAyyGqX?=
 =?us-ascii?Q?AGyTlBi74SrWLwsFIv+VzKrH8XHswojkWC5W1ZbxsLIf7TgOTe+hlJDKJ8q+?=
 =?us-ascii?Q?uBsRxGOvoV2zFpnyHayipfRKw8kx2nnf7BY?=
X-Microsoft-Antispam-Message-Info: ztJHMTaihKfaygpELumA9sXncpLLgDoCO/5WsHf/ZdtA3B+T7EyUJqj5pkcL2Te3XLU4rIO4V4RJBj7/hwxfgv07PeNzOXLKCsEC81QJFfVpp063B67g/aqUdOlqrPCpO5Eai/K4zMHVjo3U31Jw1qMi/tajDtajR4We62aqqyzPrVw4q2xoQfwAr3645c0S
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1369;6:i6zuEVMd9X7hL3VPXTLGYIVdArKRjZpl6mDO9WQzWUrgar67WJqKjdHhatHHUi+MNWjBLEa9PQAy5QTuH2n5wNpkdHLubbNSuKrQfA2HNIJ4K9rhR/AXcEPefrDXCa2/rfvH6e5q9LxdG8F+mdTSABqMhbOZOt8vBuSynl/P7O4VQRGXrUW8Oftvds263i6Oro0LlIbYxpaGwFxDjoVeD1NWbOrkx4Yvj/cg+REPP2zzWmWK7ejTeczkiErhhI2qFYHjAaXUgq+w5jEFDxHa/wulLJT0PSkZD2xC/3TevEuJloSD/aVpjDyjVh4D69MwBT2v3Q5I5/1cjfAU4CsMbq1tEinAm7OYc3z/UBdMdCRcXQE96iyCbr84ZeN4FC6vkBfAxlAfbLcb6RpbPumDuBCcGg7SRr4jmWupkzVc5mtWv+LV5F1CPe8BUuW+JJ656bzRjlppLXzUC6lC9Nx6TQ==;5:LCzeQqgLUZomvMTyu0Mea38uzqgGGdI+mgtXnAX/igZqFNuHMj/2MoKjRVapA9EWYnXyUJK0EkgbG1EEBvtLwWS1qHoW+34lPMNjlxdFIGwCMWa2M4OdfBiUyu0/bVhrFvsPlJJ30IIQo3429GnNOdmQdtxg+9p9SPOjIncYz2o=;24:ak0LAqRVn6a12YWWwWo7ymIkLyyK+r/anniAem1fxCab86ajPjuRjAw+4G3jPdiBamfv5axJDo7d0G5icweVXIY8Y2avvmTmBMXpPSsnEGo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1369;7:DWQdz38PaHITI8lUl0iLNcJJWFQqpKH2ZlLAuNfG5mDPRpkTJWPkN2WNOWQQhSApA3kS7g67GI2PVq0BuHAA0Z2Qq2bTNDkj2EZEhdp9kMj6iH3QAfIW8gy2rRWijVTAhhuYuSEWMf3Ox+QCJkdWK4x49MqhiKNU/TvtSOdJ1YUsTU6iv8rKtGFUplkEBuOHF0fcoOGacmXSWZSXG21E3VUOzEShzM0VswgdsrzvpaH4qTZtIInRug6kU+nA/wn4;20:/ncHncR3uRIakSuklQBSRfexeHYemgcwAGhq5JFAgh9vjVKmAPWG6/r2IvhRdxgQ+y2pI13/UuQxkERdh+YKqq4VI7TTA6YBxYGggqt9oSIuPSi2RCXUBclFoTG5T29faMO3RBxiTO4bUmsSZBBgqi4S4xuHSpcc6GJ0bwBVc6y/AKAz//OUeBqgmBqdCOpN1HeJ8dwpGAesYc+HhxlLhx8Y8N97pbIlBNS+NR5nEXagW20dvdKf5lEag/dA7HF7
X-MS-Office365-Filtering-Correlation-Id: 0fe777e6-3ea9-4143-66fb-08d5bf2d603e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2018 15:13:14.5835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe777e6-3ea9-4143-66fb-08d5bf2d603e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1369
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use Kconfig imply 'option' when specifying SEV CRYPTO dependencies.

Example configuration:
.
.
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
.
.
CONFIG_KVM_AMD=y
CONFIG_KVM_AMD_SEV=y
.
.

When the CRYPTO_DEV_SP_DD is m, KVM_AMD set to y produces compile time
errors.

Since KVM_AMD_SEV depends on KVM_AMD and CRYPTO_DEV_CCP_DD, the
issue can be prevented by using 'imply' Kconfig option when specifying
the CRYPTO dependencies.

Fixes: 505c9e94d832 ("KVM: x86: prefer "depends on" to "select" for SEV")

Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 arch/x86/kvm/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 92fd433..d9b16b7 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -85,7 +85,9 @@ config KVM_AMD_SEV
 	def_bool y
 	bool "AMD Secure Encrypted Virtualization (SEV) support"
 	depends on KVM_AMD && X86_64
-	depends on CRYPTO_DEV_CCP && CRYPTO_DEV_CCP_DD && CRYPTO_DEV_SP_PSP
+	imply CRYPTO_DEV_CCP
+	imply CRYPTO_DEV_CCP_DD
+	imply CRYPTO_DEV_SP_PSP
 	---help---
 	Provides support for launching Encrypted VMs on AMD processors.
 
-- 
2.7.4
