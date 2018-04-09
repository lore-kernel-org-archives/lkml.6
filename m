Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238120-2-6008106914612620401
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
    1523238120; b=pUybbYgX/6AWrtcwBNMUhhRhr+6wR4autcPwO7mI5HYi5Mh+lT
    5FeCy8IlVEj1lmzglyXLgufzGV/1mg/gxk402cQQbpYAa0BHTaeB77O/7XTjkvge
    YGL2Oek7SaxchR2YKsp2Fo0/MTL2gC+BF58i2pobGSf5rp36TfKSXql6B8ie7Gv6
    dMV/sG89Ms8g1AfOKFg4rhbT6K1N+cCcmtEcBoqSWhXcsaMhebBkqTyh6dC6M5I8
    fMeGTBl1dcDjpCtugKlabAnGOXQBBFkuEXYlr3n9EwbqZg65Ejcya25pawEkR6/4
    K/SE5MV2v3jSwUr2TkNkrkv8W4EcmF6l74OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238120; bh=aIhKWDCbZM
    fyQ1ArMfJXUwxXkXUHxxQ4+0ORHG5GkvE=; b=V1tsh2QonwMsFJ/L22H1j+a3L6
    UIBFWxVt7VsdpJHX0Ybq9v6o5N9ka9apaI2Is4CRshBlvgmZtv82DouqNbp9wO20
    lWHIsOUX2b6Vmmn4eheVSq7JOwK8w60sS1C1IF/1/rqZpTHzlhzu7jn/RpEDZZOO
    1lCQDBAZ32Hls9hUPUL2KcAnK+jppYpbZLjnoDK3pW8Wx6hNpIVYwIMu3GdJyVKQ
    yId3MiHufbdKzs0Azp4wRlineB9+MJ7LOQhSQkuDRDDmesAyIiH0mUO2OJrXhtGe
    PHPA2PVbyvT0nVH9tb2CWLdHrdFtJFNskhZv/n4unt/h83ajl+DY5FktWl9A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Bl7BffBv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Bl7BffBv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHa3wmG5jZSoXZnypY4oruCl0JSNhZ8xjlHQ7nqUGR9ehdYIyZ/5vJl0y9v83Tu5/bhK9zlVsmCL5ou6ELs+SKqE7gzjzII4VJ95SD0hdHAbFmcmdiBe
    G3qKWfjy7r0s+hi7Hi7PMW69bQJ4hyCooPo/1yHbX0zxzwkzHGmubNW+R/DkoJ4KATuG9OmPCFE2jc5QqZjgFPZkrIsSqw/7QXppwObRY3a1f2G3NDnXn8Ac
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=Chcayl1aHP8A:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10 a=taGs_qngAAAA:8 a=e5mUnYsNAAAA:8
    a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=fytQkneqYxwBSb-776AA:9
    a=5BAjD85fliRULvPp:21 a=7FgQ47uuo-uroY06:21 a=wPNLvfGTeEIA:10
    a=DM_PlaNYpjARcMQr2apF:22 a=Vxmtnl_E_bksehYqCbjh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932726AbeDIBlM (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:41:12 -0400
Received: from mail-by2nam01on0123.outbound.protection.outlook.com ([104.47.34.123]:51296
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755819AbeDIAe4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:56 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 002/162] e1000e: Undo e1000e_pm_freeze if
 __e1000_shutdown fails
Thread-Topic: [PATCH AUTOSEL for 4.4 002/162] e1000e: Undo e1000e_pm_freeze if
 __e1000_shutdown fails
Thread-Index: AQHTz5mT2lRspo5j9kiCFmt5UpPoHg==
Date: Mon, 9 Apr 2018 00:27:44 +0000
Message-ID: <20180409002738.163941-2-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:Kubj1dKzR1+RjV6UY1hTo9rzFiuoQYsbmaKPkVeSciaWRC0uWlxagxuehlqJZMQJCfEYuuSOgn53p9VGuZ+JK9frJmm3a32GHrlphcHYGQ/IjRAUakUmVHMBJqOBp2TdmuPD9l3JVIaTI4aHpTuTiPEg1q8zuKBIvGB4Y/asj+byDyfSNTECG4BVJQF5wmQ4fL45k7ENhZExUVrrHzoXsQVtnXW//QwNiA0Ox9Yk71TEWDsI/HjMRy3arlRjXjOU;20:P2Qw1G2iNnO9E0f5vzNmaKsqzYYDhCZxRyB53tf/KcHOKXKguAzNQbaNRE7dtJYgqStPJRz7SriqXQICb58pTKeB0GIRQLJ3LFsFyPILqsB7L1DiUDMvndSsMa6YvXz3BS9Je8yFvFYPeRa9Xceby63O2Ar0QYyCIvsDcZJ+c5Q=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 02855a82-5329-4259-f70c-08d59db1b464
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB080681C2E938CBD13E364D35FBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(199004)(189003)(51234002)(2906002)(25786009)(2501003)(10290500003)(476003)(11346002)(446003)(97736004)(5250100002)(68736007)(2616005)(102836004)(6506007)(59450400001)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(1076002)(186003)(15760500003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(6306002)(575784001)(86362001)(966005)(14454004)(72206003)(8936002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 3ZlbxMioh3tstSUqigWiBBzmy4zS6yEXQ2bct6pEFECxGmmUN905NE8rvGgkB+vwZP9VB5BwkdbNGtA+Us+Z/wC54+ncEfvuWSZ11QMwSPrghyHDqXWzjp+mLuCVfrycoxRZIwGNrFowHYhaDk3C3kK+3vJXOQg1pt4Thw6ijpkwrUtg/09zcOjCl8wp9vmfrsX3cnSBa8IZGF7mEExaKLNxl3YRe5LoaIPnxMbknzq/yNbuJadZKuRl2o8b0cIwqr5Hu6PhLClG51ou7r14trsnMzFKQaRBgnIMhk8vwiREF3jqvSrUe1TRiL7Rr7uAHMqqWNhH/vOTD9CEAsI4pdqzRN1E+l1i6QjQosOeS5BdTbvavqNZpEOse95ae05mCn6SlodCCX1DKxDucVh+qOhqhRP1vSSslDh5VUjKzuM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02855a82-5329-4259-f70c-08d59db1b464
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:27:44.1296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
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
index e356e9187e84..12bdb7b5241a 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6589,12 +6589,17 @@ static int e1000e_pm_thaw(struct device *dev)
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
