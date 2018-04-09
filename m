Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241284-2-10485228160254249701
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523241283; b=qYTcudTFFF2Bei7wL2bTY92gUYp0C5rkouv67EKUwkDzZ8mbfv
    SgW0ySCLnYmA4WSvNUXQzNTUlykGa2E43igFO7gyP9UNSFPcEdCaeyQ0z8BHMkHg
    fgN7K4p7g8lsKsdNM1WhT+u7IIdFazQPxyKAjysZprJyJfulp+bO+8Atl+kBHKLS
    eDlaLeZ8ryMH1odLF9z3f+6fSQYBMggDUpcAlVkSZPbuJF+ZkuiQen4Q0MRwXU+E
    71T490EMvu2pllQw5U884h1ICEkLY9GD3QTjvOu/8GDXFld3q1qvDdklJVbkp2tZ
    B64KjJwuiUISSfrkzSJFK5ONuJpbHWc3m5WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241283; bh=7ifHEMwkdd
    X8ethWo3GL/VnRnMN+luCoheg/ng5u1c0=; b=fc3Hr1W55VLdK2KVdx4sutWh/3
    cwn3l4/R0Yse4zRFN9mfdZlcOIBk+4cO9EnXGH4bjFxFoSReOiyX7PPnxyfqJuHu
    TH7TNzaY6KltWJ1TE4R4rC9hd0AiaOiZQi2tKJo7N102cddasThqkkG0b4yGwcCD
    EgCPgdH3Tf0hwu0FjKAv8hd0Uk9apcYuEqsrx6oiMMQTTzL2T0KanHKUfY2ISJjP
    mBYTn9fRBtT8/E0UvDGGrxck4vV4n3tibBLu/kvbz1j6bT3d1mksyppJ/ktxhj7y
    VhR9fKSQbib4+vZa6DOLw1vcE3Isc99OyvZMte2fAsuXYX/XQK65cPczzWfA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SLawPzZa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SLawPzZa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIny0z+uNFHHLwP6L7ijpYfZ0CdEvel69E4mArubPpKKnpRz/nfwdvPIA4O7vgkCvyiX1czq7uH6y04D+Y6DAPA55Sv1CfH4v32k5RMXn4q/Koz7sJDP
    UkMF3Qx2MhxdxD/17inMJnWZmrMbUM5x+fbsGR3x4Qua6ZGtVYBUkRgTGNzStS5et5EsN6rOE2AX9ROpwrcdKdAYjnuxFBtxowbJ+zBWVKwwhhDIb6RsxZ6x
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=JfrnYn6hAAAA:8 a=yMhMjlubAAAA:8
    a=3rXtplaHzHsDVF4GQQ0A:9 a=wPNLvfGTeEIA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757728AbeDICe2 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:34:28 -0400
Received: from mail-sn1nam02on0101.outbound.protection.outlook.com ([104.47.36.101]:16522
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755667AbeDIA1l (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:27:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Priyalee Kushwaha <priyalee.kushwaha@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 060/293] platform/x86:
 intel_telemetry_debugfs: fix oops when load/unload module
Thread-Topic: [PATCH AUTOSEL for 4.9 060/293] platform/x86:
 intel_telemetry_debugfs: fix oops when load/unload module
Thread-Index: AQHTz5kBW7yzYCUTQUasV/y/FuZgxw==
Date: Mon, 9 Apr 2018 00:23:38 +0000
Message-ID: <20180409002239.163177-60-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:JwB0ZlMBBBT1NLRSo/TMeaeVRWV5ZX37Edht2Eu7Ja4BQkTL5nun4bahGcpp3Bcx2GfWw361A3XGlEqMb4mUGJXWVJNCJ84zQlCfUqtGTMgxrtQRYgcfpZXmMvtt80FICZf3Zedyb3u1CFQpo4Msf9pZ7qEf/9nPWzwHUaNI2uVPBgDt0Ee8d3449mk4HoKdD2aLJrTm+49p943692p4AZ7V7KdyVVNBLWHN1jZJ+8JYRc+VllJQDQyL9Ttwdghv;20:QIh+DOf8WOVPYJ2ws0Hp16GWIXEhmq9grYbOBMg+YbBYsKXMqpR7DRkN/H8kBNyv2QefxzVSIqvJHCKBh2p2szyKBAT6iuHrdS9fRW119KzDBa3GOs88cZk3qq6nAsz6cwr6tQmtFzwUGhSeKs7BOR8jUOOcieBAFknkOP1ytsE=
X-MS-Office365-Filtering-Correlation-Id: 5d3daad6-969b-46c2-a632-08d59db0b11d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0871C78C230ED913BCA5871FFBBF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39380400002)(376002)(39860400002)(199004)(189003)(105586002)(8676002)(59450400001)(3660700001)(3280700002)(6506007)(81156014)(81166006)(14454004)(99286004)(72206003)(110136005)(8936002)(54906003)(305945005)(2906002)(316002)(10290500003)(478600001)(7736002)(53936002)(6512007)(486006)(11346002)(4326008)(86362001)(575784001)(446003)(3846002)(102836004)(76176011)(476003)(25786009)(22452003)(36756003)(107886003)(10090500001)(5660300001)(6486002)(86612001)(6436002)(2616005)(68736007)(26005)(1076002)(186003)(2501003)(5250100002)(2900100001)(106356001)(66066001)(6116002)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: BVM4J1w7hT5h5geMERa0Dfw5Zo6E4rp+4aQmIO2Rjt5XSnN7g5SFVdCfnKJJra1aJ0aog0Pn1hdNlk17kSyq7xiqPfSjcMr3rT4vV8vEuMEXBFe/5CnyoOIlx7Kpw+QhB6uhJiSbrnzyAijEKYLb/oxMd5JjXBpXiDFEzixmpcd6HokLj3VwwOHIftsjx56VViSDX+k15IY1NmWb24DHndRvon1/+MlWvO6NvAklgt444N7oLlByfczCSZwdc2105xJCFjd4j55bI3wJ1gc1rzFyodDx+x17j1GCFbclO0DOsU6hLuZ67nyOFDhMKc9dknEamEBCe+ACO5wq7k7rtHBerScl6pIvjIGCgIj6vPKq4pC7wJj+D5xxC47Hn49JR9KmcOY/1SrNB8soUHWNuO3/waU5wHPXLPR25uhk3jw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3daad6-969b-46c2-a632-08d59db0b11d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:38.4093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Priyalee Kushwaha <priyalee.kushwaha@intel.com>

[ Upstream commit bf5d008164dd84d671ca2dd569a1676051f9faff ]

This fixes an oops found while testing load/unload of the
intel_telemetry_debugfs module. module_init uses register_pm_notifier
for PM callbacks, but unregister_pm_notifier was missing from
module_exit.

 [ 97.481860] BUG: unable to handle kernel paging request at ffffffffa006f0=
10
 [ 97.489742] IP: blocking_notifier_chain_register+0x3a/0xa0
 [ 97.495898] PGD 2e0a067
 [ 97.495899] PUD 2e0b063
 [ 97.498737] PMD 179e29067
 [ 97.501573] PTE 0

 [ 97.508423] Oops: 0000 1 PREEMPT SMP
 [ 97.512724] Modules linked in: intel_telemetry_debugfs intel_rapl gpio_ke=
ys dwc3 udc_core intel_telemetry_pltdrv intel_punit_ipc intel_telemetry_cor=
e rtc_cmos efivars x86_pkg_temp_thermal iwlwifi snd_hda_codec_hdmi soc_butt=
on_array btusb cfg80211 btrtl mei_me hci_uart btbcm mei btintel i915 blueto=
oth intel_pmc_ipc snd_hda_intel spi_pxa2xx_platform snd_hda_codec dwc3_pci =
snd_hda_core tpm_tis tpm_tis_core tpm efivarfs
 [ 97.558453] CPU: 0 PID: 889 Comm: modprobe Not tainted 4.11.0-rc6-intel-d=
ev-bkc #1
 [ 97.566950] Hardware name: Intel Corp. Joule DVT3/SDS, BIOS GTPP181A.X64.=
0143.B30.1701132137 01/13/2017
 [ 97.577518] task: ffff8801793a21c0 task.stack: ffff8801793f0000
 [ 97.584162] RIP: 0010:blocking_notifier_chain_register+0x3a/0xa0
 [ 97.590903] RSP: 0018:ffff8801793f3c58 EFLAGS: 00010286
 [ 97.596802] RAX: ffffffffa006f000 RBX: ffffffff81e3ea20 RCX: 000000000000=
0000
 [ 97.604812] RDX: ffff880179eaf210 RSI: ffffffffa0131000 RDI: ffffffff81e3=
ea20
 [ 97.612821] RBP: ffff8801793f3c68 R08: 0000000000000006 R09: 000000000000=
005c
 [ 97.620847] R10: 0000000000000000 R11: 0000000000000006 R12: ffffffffa013=
1000
 [ 97.628855] R13: 0000000000000000 R14: ffff880176e35f48 R15: ffff8801793f=
3ea8
 [ 97.636865] FS: 00007f7eeba07700(0000) GS:ffff88017fc00000(0000) knlGS:00=
00000000000000
 [ 97.645948] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [ 97.652423] CR2: ffffffffa006f010 CR3: 00000001775ef000 CR4: 000000000034=
06f0
 [ 97.660423] Call Trace:
 [ 97.663166] ? 0xffffffffa0031000
 [ 97.666885] register_pm_notifier+0x18/0x20
 [ 97.671581] telemetry_debugfs_init+0x92/0x1000

Signed-off-by: Priyalee Kushwaha <priyalee.kushwaha@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/platform/x86/intel_telemetry_debugfs.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/intel_telemetry_debugfs.c b/drivers/platf=
orm/x86/intel_telemetry_debugfs.c
index ef29f18b1951..4cc2f4ea0a25 100644
--- a/drivers/platform/x86/intel_telemetry_debugfs.c
+++ b/drivers/platform/x86/intel_telemetry_debugfs.c
@@ -97,11 +97,9 @@
 	} \
 }
=20
-#ifdef CONFIG_PM_SLEEP
 static u8 suspend_prep_ok;
 static u32 suspend_shlw_ctr_temp, suspend_deep_ctr_temp;
 static u64 suspend_shlw_res_temp, suspend_deep_res_temp;
-#endif
=20
 struct telemetry_susp_stats {
 	u32 shlw_swake_ctr;
@@ -807,7 +805,6 @@ static const struct file_operations telem_ioss_trc_verb=
_ops =3D {
 	.release	=3D single_release,
 };
=20
-#ifdef CONFIG_PM_SLEEP
 static int pm_suspend_prep_cb(void)
 {
 	struct telemetry_evtlog evtlog[TELEM_MAX_OS_ALLOCATED_EVENTS];
@@ -937,7 +934,6 @@ static int pm_notification(struct notifier_block *this,
 static struct notifier_block pm_notifier =3D {
 	.notifier_call =3D pm_notification,
 };
-#endif /* CONFIG_PM_SLEEP */
=20
 static int __init telemetry_debugfs_init(void)
 {
@@ -960,14 +956,13 @@ static int __init telemetry_debugfs_init(void)
 	if (err < 0)
 		return -EINVAL;
=20
-
-#ifdef CONFIG_PM_SLEEP
 	register_pm_notifier(&pm_notifier);
-#endif /* CONFIG_PM_SLEEP */
=20
 	debugfs_conf->telemetry_dbg_dir =3D debugfs_create_dir("telemetry", NULL)=
;
-	if (!debugfs_conf->telemetry_dbg_dir)
-		return -ENOMEM;
+	if (!debugfs_conf->telemetry_dbg_dir) {
+		err =3D -ENOMEM;
+		goto out_pm;
+	}
=20
 	f =3D debugfs_create_file("pss_info", S_IFREG | S_IRUGO,
 				debugfs_conf->telemetry_dbg_dir, NULL,
@@ -1014,6 +1009,8 @@ static int __init telemetry_debugfs_init(void)
 out:
 	debugfs_remove_recursive(debugfs_conf->telemetry_dbg_dir);
 	debugfs_conf->telemetry_dbg_dir =3D NULL;
+out_pm:
+	unregister_pm_notifier(&pm_notifier);
=20
 	return err;
 }
@@ -1022,6 +1019,7 @@ static void __exit telemetry_debugfs_exit(void)
 {
 	debugfs_remove_recursive(debugfs_conf->telemetry_dbg_dir);
 	debugfs_conf->telemetry_dbg_dir =3D NULL;
+	unregister_pm_notifier(&pm_notifier);
 }
=20
 late_initcall(telemetry_debugfs_init);
--=20
2.15.1
