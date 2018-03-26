Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbeCZTP5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 15:15:57 -0400
Received: from mail-sn1nam01on0050.outbound.protection.outlook.com ([104.47.32.50]:59216
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751782AbeCZTPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 15:15:43 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-edac@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        bp@suse.de, tony.luck@intel.com, x86@kernel.org
Subject: [PATCH 2/2] x86/MCE: Always save MCA_{ADDR,MISC,SYND} register contents
Date: Mon, 26 Mar 2018 14:15:26 -0500
Message-Id: <20180326191526.64314-2-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180326191526.64314-1-Yazen.Ghannam@amd.com>
References: <20180326191526.64314-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:405:3b::24) To DM5PR12MB1914.namprd12.prod.outlook.com
 (2603:10b6:3:10d::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1cc47ada-a186-4398-1225-08d5934df767
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1914;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1914;3:WDWaZcJrjZtk8yi4jFsmJj25u+H11QIYlASB75EFn4tz2/eAdVtJ85jRClL3vRp+CnM1fuGadu6Ut3rCnl6K0VmiWXrkeGjxLMJrE5UdOjhBUv1oMcHsdc6WkvcajReE97jkbIzATVBkHCE6/RmgbEnfvH5cBzgi4yKRZrarkyqXM86C5nl35Vig/IgzlIvd+X/4sqNM24hazO2v79TkAqvwC4U7GPUkL+VAsf2aHzuh9+2tQBVq/FOQ6eWmbO77;25:8+Q4Ex7+/hwbgPUa4BBEx2LzLmpG7e++cAzC3692IKbRuPv4aOhPYqo6zxz7bISGw8W8FtaflI3D5uT51HPW8a+PbHnTHGkePxAfR/HNaBTkl/IJf3PYPifgICeBa9pbJkua/6z3blPIKivvgRSB7tH4ClrUicomPzRyOMUUdMSNEycQesCKFKF+e86LD09Pk0+IRmJDcLaLVmEeuqE/xKTazh1eJMe41rzKp+wUmj+iJA869oECT9hvfaAEsveFxY+D7HLCft+MAWoX6o+pzgX9JiqWkX7qOhmzw3mOaIYI7LYIKBmLyDiUF7IBzLAayDC65DkRloojpsahDpu9gg==;31:+tsKbuWl5p1iHvODLkHB1o+1OuWS/wbah+cXzkXg3Mj49OX3BwBAw10SvUEqlQY0nomO0OInhF5dmpIcK01f+ypzTR9E8Vr/UVm5TT/GgeTp8Y7+A0XG1sujhpOO8Mnpjdzx6WZf++/tneiwYAw/dxm8ImXu3UJGaMeUKVprcfzAhSKtPcKikR8autZqbIQiwgkpp4e1E6ECbdF6DeSavD1ONJnpKja4YYGg0QXZTgM=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1914:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1914;20:UKIridaL6raybdFDt1lnU77sJDTgKR+jeYi++K1ASIqm2qjvsjxoYL1i1Dsc+S2FftdSpJtmOWTVcor0DIPN6VNdsO78XFeQ1VDL3VG8J9MHemWOwV4WcYRCrBGM68KL3+dTpwChfXKaF+cyyeQMKEd2eMmYE6vxvC07A+lLRafTu4tfuqdH96gd5fBBf3BEeo5pj8I2z3a7ukWlU6OD1j9H7O14SEg/ROQP9crAEpttA0BgJOe5oNXp8EDgbMPvvlk7RTLVoSjZ8zzERlsRxqWrw8as+Do8WrF/g0vcXYOtxEBVhL7uojX3C/mVsxTeg+jgMeRUb7x4sEkyYS+Sdvs8V/l+vjMI3jsY6upq8zhiSZE7BCps/3Ku2/xGID+4BjkGHqzDc1ra0SCj/p0AbsqcEppLIWfv2a+U2Li7Bx3OUVH+Vxl7Ku6HVZ83qtOjvLixeOs/YDnVgtpd+J6FInzF+3DO4ADPCMM9dGx1FtC9DNnXPDQg0CF8Qa/+31cX;4:ZffvaVHEI6Hfwq0LrTOlT05BGmtQT+6rt9WGmHNvJbwjPcveVEAf1wKNaJ3kw+TTrbR6uCtGJr6i4Rz6JS9Rs5YNbVxXZId7YabkWyi2adymENYJt+r+PpQ1t87tzyOSijL/ckT8/ji6j6MFYrwlt9Awo2KnmGsI8n9ENJfGSo5wpXSJ+Hxe0EidcbPbMT50kxeEqM4htZFCb6Tk1iEWUMqX7qf+OtSsbPJCSYTiXWh7uWyNMQ3esymCfe9rDqO3lLY78UHAGfH2OR14YVdKYUJylM8B45dgu/PcOHyhSbNRNL2ldPzFx0+S2tRuhF2y
X-Microsoft-Antispam-PRVS: <DM5PR12MB19148C73ABBD2A58E140DC66F8AD0@DM5PR12MB1914.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR12MB1914;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1914;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(189003)(199004)(25786009)(105586002)(2351001)(6666003)(1076002)(2361001)(72206003)(97736004)(53416004)(66066001)(76176011)(386003)(7696005)(47776003)(51416003)(486005)(486005)(2906002)(52116002)(6916009)(6486002)(36756003)(4326008)(26005)(7736002)(305945005)(8936002)(53936002)(81156014)(8676002)(50466002)(81166006)(186003)(16526019)(575784001)(5660300001)(106356001)(478600001)(3846002)(316002)(956004)(2616005)(446003)(68736007)(11346002)(48376002)(50226002)(16586007)(6116002)(476003)(86362001)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1914;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB1914;23:CfIDSTrKmbdDyv2m4RIDXge4b5eVqRdzC/B8STLOU?=
 =?us-ascii?Q?zHYP/0jbPIZxcU8TQNchn2/CYDTxlY7lnsYohiDaIvGEw3NSJ9fFbFpd2/Qm?=
 =?us-ascii?Q?jk8EITVsUyEGoHnQLVMyyI7DC39YJetCCK4+oFBv/fVytg2BPx33jo7dP1tg?=
 =?us-ascii?Q?OKU8O9CB+LIn82JLbJJTychLCL/8fWFUPiBJfoA1gKM0AW+JLLDnBwEfPw8F?=
 =?us-ascii?Q?8a/uvNO+c4YfCFwMx0aW7Lc2tDdmVc0d7KU0JGjDfPdozIJyxgVbWNSRF0P5?=
 =?us-ascii?Q?17XnY/mm1QbzHvN6pFBf0l5Ta74HxgNIrvCHxXB8r5e3mZBWXlpW5YA/Kqnj?=
 =?us-ascii?Q?d4uTeHuvXmjbTvNBRNWLbTav/FAtqu83GdzVpRIA3wf0lAARjsFahEW9pe2R?=
 =?us-ascii?Q?cgY8medPiLNVg+7vawM6EENIlxavC0nUQyGqiOYdzM2YU1TBANmUsdI3TT3y?=
 =?us-ascii?Q?SeA9M5b2dj8LtLnD6gaNKCbaSaY67JKAmeLBwG1qxbfQB/iQbpdzdtOICgWE?=
 =?us-ascii?Q?VN4Ry4phh71wC1CfMMiwruXzo9amX/UJAy1IQtmWztpDs0omwJtiOOrLB63t?=
 =?us-ascii?Q?rXG0aPyA0ygwXSeoeF6bveRRHmFsr9aAiRVLAgHfm6aOY6pMZXd5xuxnGwqr?=
 =?us-ascii?Q?yXuYd5jQ9/V0f4x/oH1pOXBDsx3RsAq+AP3TK/t5PNqiuOpYmahM2uiOP4X6?=
 =?us-ascii?Q?sh25s0zl441ehJ3QXoyVVnaeI1RerC46WBHzGynhlDZUUofPnGn3U8z+1U0Y?=
 =?us-ascii?Q?dX8GHTlW8YLjJ9W976rLh7g1e3imNVbRXtsXwWTrqn8xQPN7MIeirBsHiHlj?=
 =?us-ascii?Q?2UA+ovYRcOmGzmwDKD5jUia3oxh9vU0FVf3JalZadMqIsajvnNS2lk3Xro6m?=
 =?us-ascii?Q?cs5FycJEk3pLKE6W+702raWtydIZJWYS8lYVZfFu/xbE6lAXDR2BIGq+0wcC?=
 =?us-ascii?Q?M3HUr44XqzZFNUvIwEXddrdhkMpsUf5bfe8MgORPHxafnB06P8AUkVqcDa2q?=
 =?us-ascii?Q?TtZiEbRuy7VJaDz/KlccZIFUTG0Ybotz1v6/q3tf70o+bEFbxiBIxEzLLVM/?=
 =?us-ascii?Q?H9AWMxLv1wDvv/ts5jgrAU5QmJNbiH3hPd0QWcYPY+YnCGq3/8OEJVDq4FEq?=
 =?us-ascii?Q?/hQdxGBYqa05JAk++7ov0aFqSlDl+uj3Tkxd2a5eo+kx1zdzYIvuiSAWJ24r?=
 =?us-ascii?Q?w9/1Miowf35JaguN0DPafazkjkiqfnJDlLuv62Tyc1A2YwJplgqRmlhERzVw?=
 =?us-ascii?Q?t8hHlc6X+gba10+8a9IV618QJunrZDhj0GOrN70OTrImDf9U2QpjXP3Ywzmr?=
 =?us-ascii?Q?MnF78DL6gLJ4fE0Ifg0EcM=3D?=
X-Microsoft-Antispam-Message-Info: GLkzWlf8mqqiJbY53xqlP9i0FImkjnHnKHX/hOBAYiosDKNfNjcb/f43RUdbXNyKxIdy4FNODCrmXAlkG85clKDxlE0sVcL5yBN8qIuW5Ijh/KYeFwZW+aZd/xyrfz9pwsK/hRC3kR2M0iSBP29RbVmAQ+3xGOfZxqfI3SdF6ys9Cbr02QjQ2+80ym1M4JzC
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1914;6:YsqDncifGNzO6eeIEoP93E7TIsIIsfC67vnJ686bEfONFDuQqCnluwnsR+hs5LC06NH9fzBbVjGezsit/wK+XeXMpGOCMwZM45ytf58fOwHz/uT/bFA41bOzXzqiVOxhpbL9X76Lv0bLfraVuyJ/Ph6xnXJJbxNFaXsORj+FrAR1rw+i7OjU9mX8+ih9blSpxDo0350oJzx3NZmUEHkM9nsldQ4u0LntbySEArb/2K3qu3n/HcXan2Kx0hzs1Ovv0vYF8+lxuNBUnZu9+emYZbl89a7+boSd+FEU+/HSuJMa40Q2eyqJKFzPRXWhnnB405efW4wHZm6rjVjq2vdK8hfFmbSYORJrhoUvFHn+hSYiVpqd75ahQ1b2YbN0zAH0NwPMVjDF+wMMh4VUuTuYrqJo1McbabSotW6OS00wMNC9ESLUOp2mGaQh4W8aDP0QHM3IckzfjMUcGwQcXZsG3g==;5:cDH4vBBrF1sQROBAcItPZ7DnJ/ku91UfRvkjKPl/uK/hO/OQkJKlOs24Vy91RKwHW8GESEcQ/+k7mJ4ncsyGxlGQS/1ThrJGd/GCn+LsgLwBVW7S90W56SdtxLpm3xcQIi/UhETVJuQpKuUhx1zXP2t3EFebGzj7Z9CyRsHt2HE=;24:DQb4OFinENNeY3B+Y4St7EVVaJ9tz6cidIQQgUt5yfh7q5WIVxDi7RnIkUd0WyanffhvoZlq06iK87Ah26+3sox182a4ilXZsFozpN75uxU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1914;7:RM9/Z+WNxPr7p8LPNI7QZXtRsHxMoiYkOmpeaO/QP2z+bYozxEl9/um1u6YxxFmAPMZtYCo6HtoRvT+NYPf49c1JKhrQBwTXOVilJA/+ztxcXFB5E0CsDeqxp8Vy1Tlo7ZAibYJnozZIL5Mr0cGoqzv2FbUHGzSLn9anXoaZTxvNL0itYfARXMYQTipdB0v0LGiY4OjRIRtbeD5kmtzgffwqxSwxw2VfTuom0UCjHj+nyazr3+kKhwWRM27B8APA;20:eWvl4CpwBPtVKqeHW9kuJcj9SY2W+Q/WnilIgtsrIsNLi4P+xinh4BAli37p5Qza1Cj9bmZqcFtYwEphyTaQ5fMFI5SZZsLjFjEiz1j12pOLv6tcEGTajpf8Onso4kRKkUd/PoukRE9trcjMXifEFK6GvFG3QSFcPMffPxfxgSZlwq4GQKGJMuP9bHnbxNweXc2wpdaZJPxgmXeKvAtS5mccRYfTnTpPYN60Ek6yrQDfvOzx4sItmsdS3aUwWBRV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 19:15:40.8253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc47ada-a186-4398-1225-08d5934df767
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1914
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The Intel SDM and AMD APM both state that the contents of the MCA_ADDR
register should be saved if MCA_STATUS[ADDRV] is set. The same applies
to MCA_MISC and MCA_SYND (on SMCA systems) and their respective valid
bits.

However, the Fam17h Processor Programming Reference states
"Error handlers should save the values in MCA_ADDR, MCA_MISC0, and
MCA_SYND even if MCA_STATUS[AddrV], MCA_STATUS[MiscV], and
MCA_STATUS[SyndV] are zero."

This is to ensure that all MCA state information is collected even if
software cannot act upon it (because the valid bits are cleared).

So always save the auxiliary MCA register contents even if the valid
bits are cleared. This should not affect error processing because
software should still check the valid bits before using the register
contents for error processing.

Also, print MCA_{ADDR,MISC,SYND} even if their valid bits are not set.
Printing from EDAC/mce_amd is included here since we want to do this on
AMD systems.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mcheck/mce.c     | 23 +++++++----------------
 arch/x86/kernel/cpu/mcheck/mce_amd.c | 10 +++-------
 drivers/edac/mce_amd.c               | 10 +++-------
 3 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 42cf2880d0ed..a556e1cadfbc 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -248,19 +248,14 @@ static void __print_mce(struct mce *m)
 	}
 
 	pr_emerg(HW_ERR "TSC %llx ", m->tsc);
-	if (m->addr)
-		pr_cont("ADDR %llx ", m->addr);
-	if (m->misc)
-		pr_cont("MISC %llx ", m->misc);
+	pr_cont("ADDR %016llx ", m->addr);
+	pr_cont("MISC %016llx\n", m->misc);
 
 	if (mce_flags.smca) {
-		if (m->synd)
-			pr_cont("SYND %llx ", m->synd);
-		if (m->ipid)
-			pr_cont("IPID %llx ", m->ipid);
+		pr_emerg(HW_ERR "IPID %016llx ", m->ipid);
+		pr_cont("SYND %016llx\n", m->synd);
 	}
 
-	pr_cont("\n");
 	/*
 	 * Note this output is parsed by external tools and old fields
 	 * should not be changed.
@@ -639,12 +634,10 @@ static struct notifier_block mce_default_nb = {
  */
 static void mce_read_aux(struct mce *m, int i)
 {
-	if (m->status & MCI_STATUS_MISCV)
-		m->misc = mce_rdmsrl(msr_ops.misc(i));
+	m->misc = mce_rdmsrl(msr_ops.misc(i));
+	m->addr = mce_rdmsrl(msr_ops.addr(i));
 
 	if (m->status & MCI_STATUS_ADDRV) {
-		m->addr = mce_rdmsrl(msr_ops.addr(i));
-
 		/*
 		 * Mask the reported address by the reported granularity.
 		 */
@@ -667,9 +660,7 @@ static void mce_read_aux(struct mce *m, int i)
 
 	if (mce_flags.smca) {
 		m->ipid = mce_rdmsrl(MSR_AMD64_SMCA_MCx_IPID(i));
-
-		if (m->status & MCI_STATUS_SYNDV)
-			m->synd = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND(i));
+		m->synd = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND(i));
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
index f7666eef4a87..5a37ae704578 100644
--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -799,13 +799,12 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 	mce_setup(&m);
 
 	m.status = status;
+	m.addr	 = addr;
 	m.misc   = misc;
 	m.bank   = bank;
 	m.tsc	 = rdtsc();
 
 	if (m.status & MCI_STATUS_ADDRV) {
-		m.addr = addr;
-
 		/*
 		 * Extract [55:<lsb>] where lsb is the least significant
 		 * *valid* bit of the address bits.
@@ -819,9 +818,7 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 
 	if (mce_flags.smca) {
 		rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), m.ipid);
-
-		if (m.status & MCI_STATUS_SYNDV)
-			rdmsrl(MSR_AMD64_SMCA_MCx_SYND(bank), m.synd);
+		rdmsrl(MSR_AMD64_SMCA_MCx_SYND(bank), m.synd);
 	}
 
 	mce_log(&m);
@@ -849,8 +846,7 @@ _log_error_bank(unsigned int bank, u32 msr_stat, u32 msr_addr, u64 misc)
 	if (!(status & MCI_STATUS_VAL))
 		return false;
 
-	if (status & MCI_STATUS_ADDRV)
-		rdmsrl(msr_addr, addr);
+	rdmsrl(msr_addr, addr);
 
 	__log_error(bank, status, addr, misc);
 
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 2ab4d61ee47e..004425cc8ddf 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -990,16 +990,12 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 
 	pr_cont("]: 0x%016llx\n", m->status);
 
-	if (m->status & MCI_STATUS_ADDRV)
-		pr_emerg(HW_ERR "Error Addr: 0x%016llx\n", m->addr);
+	pr_emerg(HW_ERR "Error Addr: 0x%016llx\n", m->addr);
+	pr_emerg(HW_ERR "Misc: 0x%016llx\n", m->misc);
 
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
 		pr_emerg(HW_ERR "IPID: 0x%016llx", m->ipid);
-
-		if (m->status & MCI_STATUS_SYNDV)
-			pr_cont(", Syndrome: 0x%016llx", m->synd);
-
-		pr_cont("\n");
+		pr_cont(", Syndrome: 0x%016llx\n", m->synd);
 
 		decode_smca_error(m);
 		goto err_code;
-- 
2.14.1
