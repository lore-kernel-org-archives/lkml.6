Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523242062-2-9359146671257744896
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523242061; b=BePUO9wlEgYlwNQ2skyGcBBHdpSefugKh2nosiLA2LjVf9wAMf
    WQRUpMhzPdVBmFmrgQLHEyRYqxcDO8/38osXsFVr/RN1snw3/voIKMrreeQiUKJt
    HAYroKLOvEerUn4hEa7+kx2ov3LKHOhs6fytJH5FEm9MyXpLrqYbS1TPNDnjQldy
    qbSyWifTm3/RKu8VaX988bfWu375+dYFO1p6Cc4eLqSmRK/pEk9ruz8JP3K+vPWA
    slD/LvOgsSgdtsa18w6nowr8CKH/wOKVJal2u8YMR5fOdkVZYIDfqYISDZPlTrZQ
    PxVlAHGkRl1/TOQrFqNyDGdPaETY08Oqvg+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242061; bh=aR+G+frGj6
    aNQdhg+b76Yh0FoWMHfVxqU84YRcSOqEA=; b=deYlpoTgFZzwLz1WDU3emsUsrC
    L210+XJMAMrXCMxbl1UqfAB6MGXxfIXWY+HbCLwawco2PUQC8xPg3lToq0uhrRni
    ZYC1txVD28qJTc/Z5TmiY985JZBADY1e/QTxOmCCNSjX/BW/VXXJ55IF/maqiqv3
    m1k92Vjpu2XqAFB/uW0x7K48vQzJjK2OCi8e5jfqjC5Xl4jwdv8VUcBMWuOydDK6
    ToM7BxDcqYKmv8/ughEk9xbAX9HHTdKiXJdLSiKiHK9C+x0QBEG7GOTPhGv0v1Ca
    QMPO/tdoMstkWVwGl0psOdO9XXkDUxkPJTYGabdkfK7aeU/Wb9eEOtiBx1Uw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Gb0U8NJY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Gb0U8NJY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCuyoLt8gfiBA9uO7hPj4FTRD515sd6xQurb0fOCsSr2jbIE2klef/kIwTdZGMtHQKuvi9f75YV3aRSyY0vcSHogP2a8qg+2InjAmqQbvlPP+53pmdwG
    EWFrWIR7PHk7IgAEQT7U+m92Vq9on5QtZces/kLIk+Qn4bhpJg0cwDhjN2ndCpgE9ZFyOyRLBBDm5hFCa2kEotDGVIOGE9kvoOI+VV5LWrpQlLhxVObQo2gI
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=kisvEzXjW6IA:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10 a=taGs_qngAAAA:8 a=e5mUnYsNAAAA:8
    a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=fytQkneqYxwBSb-776AA:9
    a=5BAjD85fliRULvPp:21 a=LbzWePWyPtW3bOaS:21 a=wPNLvfGTeEIA:10
    a=DM_PlaNYpjARcMQr2apF:22 a=Vxmtnl_E_bksehYqCbjh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755406AbeDIA0l (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:26:41 -0400
Received: from mail-cys01nam02on0098.outbound.protection.outlook.com ([104.47.37.98]:9607
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755332AbeDIA0j (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:39 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 005/293] e1000e: Undo e1000e_pm_freeze if
 __e1000_shutdown fails
Thread-Topic: [PATCH AUTOSEL for 4.9 005/293] e1000e: Undo e1000e_pm_freeze if
 __e1000_shutdown fails
Thread-Index: AQHTz5jkYyzN19hwp0yuM28imT4pCg==
Date: Mon, 9 Apr 2018 00:22:50 +0000
Message-ID: <20180409002239.163177-5-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:oQIsGttmP7agkCMK4AAkrt7bjlyjR/Agdx0Scs927444wGlsStxzDBTwxZr8NK+PgZ/tU5Hlduij5NR4XOc1p46kcoWzvhOtwKbM2DPozvI+rvsEerCE7StOIfld5dOnGJl55/8VAGCPZwq8xWtBxIXc8v38z5+73xjJU+/kHj/OQO9phQjp1V0gWxjxQqyUyX6MOVIdNqxAxvU1qe6GvXocKjsBgnsrxYFqd5dpn78Ko0KWH4nMLh/Lgr69QQuu;20:LdixC1TCxw4feh4CC27XBNIAqFQd9nUbNNqbnbr/HrRfTrlxAls7EOTD40yKG1vR11uwG/V7BlPbrb3RcjncPIGiw89vycwxabUoAvJHhmjzVCzXMTbcOZV529GvRvCLCGOXYL+iVJjm5EwnfZPk4GnT8ffUnhMh3gPO1vLB4d4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: e748760f-7b9e-48f5-c313-08d59db08b4d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015CAF7D75F66D88C2CD26FFBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(51234002)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(966005)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(6306002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(575784001)(476003)(6666003)(59450400001)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(15760500003)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: zNfaziHyMFdnMhsFpa31sFMSO63ltIxbGvnErjaej312a/sHSddQIl83HdLm3I3mb+6V4PkSVNGG+FGlNOC9E9eCgIvxJV8haV+skjRNqQyGxXUoe/brgr4mseGw+VKDwcZ4OfwGwCyP/4u4Xiq3UhUyowppmOOFnnbteKH8YjhWdBoNM+ybqzMfWJdb/olSavLZKORkBtWCakkvIoduESSWV9VYEyMfKbFO6ZQZvQHFfOO+jOc0Zy5Y6Y2q1Rf6m0ehLswOmg3KXTaC4O1S6xIuPDKl2XDdv7pgOLOQI3LNuDJAgCL7B+RnVsmZbHCqPWYK3hdAO4QW4pPDfTIILTmdXWC4MBFargWrNMxEjnp9IWL9xHW325Gozs3N6lttouWCSeTlcicDvttvFNymgEbHjWdx2eoOlX5HDCLmCKs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e748760f-7b9e-48f5-c313-08d59db08b4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:22:50.0810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Chris Wilson <chris@chris-wilson.co.uk>

[ Upstream commit 833521ebc65b1c3092e5c0d8a97092f98eec595d ]

An error during suspend (e100e_pm_suspend),

[  429.994338] ACPI : EC: event blocked
[  429.994633] e1000e: EEE TX LPI TIMER: 00000011
[  430.955451] pci_pm_suspend(): e1000e_pm_suspend+0x0/0x30 [e1000e] return=
s -2
[  430.955454] dpm_run_callback(): pci_pm_suspend+0x0/0x140 returns -2
[  430.955458] PM: Device 0000:00:19.0 failed to suspend async: error -2
[  430.955581] PM: Some devices failed to suspend, or early wake event dete=
cted
[  430.957709] ACPI : EC: event unblocked

lead to complete failure:

[  432.585002] ------------[ cut here ]------------
[  432.585013] WARNING: CPU: 3 PID: 8372 at kernel/irq/manage.c:1478 __free=
_irq+0x9f/0x280
[  432.585015] Trying to free already-free IRQ 20
[  432.585016] Modules linked in: cdc_ncm usbnet x86_pkg_temp_thermal intel=
_powerclamp coretemp mii crct10dif_pclmul crc32_pclmul ghash_clmulni_intel =
snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic snd_hda_inte=
l snd_hda_codec snd_hwdep lpc_ich snd_hda_core snd_pcm mei_me mei sdhci_pci=
 sdhci i915 mmc_core e1000e ptp pps_core prime_numbers
[  432.585042] CPU: 3 PID: 8372 Comm: kworker/u16:40 Tainted: G     U      =
    4.10.0-rc8-CI-Patchwork_3870+ #1
[  432.585044] Hardware name: LENOVO 2356GCG/2356GCG, BIOS G7ET31WW (1.13 )=
 07/02/2012
[  432.585050] Workqueue: events_unbound async_run_entry_fn
[  432.585051] Call Trace:
[  432.585058]  dump_stack+0x67/0x92
[  432.585062]  __warn+0xc6/0xe0
[  432.585065]  warn_slowpath_fmt+0x4a/0x50
[  432.585070]  ? _raw_spin_lock_irqsave+0x49/0x60
[  432.585072]  __free_irq+0x9f/0x280
[  432.585075]  free_irq+0x34/0x80
[  432.585089]  e1000_free_irq+0x65/0x70 [e1000e]
[  432.585098]  e1000e_pm_freeze+0x7a/0xb0 [e1000e]
[  432.585106]  e1000e_pm_suspend+0x21/0x30 [e1000e]
[  432.585113]  pci_pm_suspend+0x71/0x140
[  432.585118]  dpm_run_callback+0x6f/0x330
[  432.585122]  ? pci_pm_freeze+0xe0/0xe0
[  432.585125]  __device_suspend+0xea/0x330
[  432.585128]  async_suspend+0x1a/0x90
[  432.585132]  async_run_entry_fn+0x34/0x160
[  432.585137]  process_one_work+0x1f4/0x6d0
[  432.585140]  ? process_one_work+0x16e/0x6d0
[  432.585143]  worker_thread+0x49/0x4a0
[  432.585145]  kthread+0x107/0x140
[  432.585148]  ? process_one_work+0x6d0/0x6d0
[  432.585150]  ? kthread_create_on_node+0x40/0x40
[  432.585154]  ret_from_fork+0x2e/0x40
[  432.585156] ---[ end trace 6712df7f8c4b9124 ]---

The unwind failures stems from commit 2800209994f8 ("e1000e: Refactor PM
flows"), but it may be a later patch that introduced the non-recoverable
behaviour.

Fixes: 2800209994f8 ("e1000e: Refactor PM flows")
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=3D99847
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ether=
net/intel/e1000e/netdev.c
index 528a926dd979..87cbefb16050 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6645,12 +6645,17 @@ static int e1000e_pm_thaw(struct device *dev)
 static int e1000e_pm_suspend(struct device *dev)
 {
 	struct pci_dev *pdev =3D to_pci_dev(dev);
+	int rc;
=20
 	e1000e_flush_lpic(pdev);
=20
 	e1000e_pm_freeze(dev);
=20
-	return __e1000_shutdown(pdev, false);
+	rc =3D __e1000_shutdown(pdev, false);
+	if (rc)
+		e1000e_pm_thaw(dev);
+
+	return rc;
 }
=20
 static int e1000e_pm_resume(struct device *dev)
--=20
2.15.1
