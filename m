Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234378-2-8727889837854922393
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523234377; b=bkzsG3gc3byKr6iekk8CAVP6N6KP2D3aiV5hbmU48/jPj4tOsL
    WlUslfuE790kxmd5OEZJfk1UqQIq2p8NsNCFgx0B4QxuslfyOkWHhyxa49u0++Fc
    TyUAmsfNvSAOy/fKRtnXplVpQAc5QHvUCbChbNGZm7v/0QAI3gbuqJJgwJRnAZp7
    st7nG6gYDtb8yEuZZ8TVvHBRKTOWYxrXWRrFh3QJYZNCZdA75P+gpgK/5sUmQpyw
    +zt2WJ9MfCP/Y3uHWhCq1Y0KpEhK44rDAYkX6ibbKPEe73Ro/72b4LtiLkuF9uxg
    YrMUrl6C3uteJI4D6W+eoasVlR9iE8RstewA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234377; bh=iiBiFrke9X
    VkcpihJPR0vDQE4jiO29o80flhMojPWEw=; b=gxtey0ZlnSGtuP6EoqyYgN0HKe
    na+Xh2EO6kQYfIeRZTWVFzBVE9pePwPwGKwGbYGU1sbWzc5bXEQ+Pgc/jba5p7Cz
    FLUlCSMwWvyajKWvxDKuaaVnu2xtKhZHPAiWbrQ5eWLSjKQx1lQzN3PbIL0J4fJb
    UD4N1Im9RIDBUG/WlmnGiK0ZRbukNB4I2WdzIbLllj2BbI8oeDtSd1LcJbLxhzbc
    ZnnSUbj0yYNY9vOobP5q0pcbYM4f5r34KaGU+/cUNoEyoOR4wVm3R+s+du7dR3I8
    6x7+fUV7bWL4GeQVDhsy4RrM6t1WCs8lVyXrB+4E1NA22wkxHO9Sg4t1PtBA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hLkeiYLD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hLkeiYLD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCfh1ukgFYaTynRKcbXmElmB0GFi7o9tiKs56gcb1368ngFIGWlmOMx2Hnp6m2AqO6JSigPvuOk/biP/znxkxUKrMr0DmHjcBMAnweeOc3hxqZT3YXZf
    4FiKpol6wMo4QVlncXVjhbNtgBORtBNptXDE9bLIUfH+azoCA57R0ZeXmtDYMrfMq1/xOiFcaARMj1BXdSqyDpkMupKfmj+DEhZ3VM1bE44kgaZBhp3yu6gp
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=QqrzTvMQf64A:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10 a=taGs_qngAAAA:8 a=e5mUnYsNAAAA:8
    a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=fytQkneqYxwBSb-776AA:9
    a=5BAjD85fliRULvPp:21 a=7FgQ47uuo-uroY06:21 a=wPNLvfGTeEIA:10
    a=DM_PlaNYpjARcMQr2apF:22 a=Vxmtnl_E_bksehYqCbjh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933153AbeDIAjf (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:39:35 -0400
Received: from mail-co1nam03on0103.outbound.protection.outlook.com ([104.47.40.103]:45124
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933114AbeDIAj2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:28 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 002/101] e1000e: Undo e1000e_pm_freeze if
 __e1000_shutdown fails
Thread-Topic: [PATCH AUTOSEL for 3.18 002/101] e1000e: Undo e1000e_pm_freeze
 if __e1000_shutdown fails
Thread-Index: AQHTz5qdWu16ZLUOo0aMkcASDhehYw==
Date: Mon, 9 Apr 2018 00:35:10 +0000
Message-ID: <20180409003505.164715-2-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1047;7:WZ7Cz9oZ0YdNWm5PQeANdurZhyx4WfbkafOICbvWPGiOZkxH0jGnXXfS/dUZRztcBLVEjPUCEi7xglbhJfwSjb8eW2lWnz+atjWLKLIR0YcJvs0xFMYOAnXEjyh/j3boxnwy1wGhazZt68spVQRSXPjkkzU0VjGtKtb+7q2y9zxYw8emqrXkLDcxq95tleFqiTbuo38c77zQNKI465cLI3XXbPEigAfUefJ06AoXV6BF288Quv8h+1YtW44J+Wl9;20:K6K5pO2jGR7qs/bXCITtFAH1WWjLaBLs3vT9FqE+d9hzHfvf6DNP6WV2GEmKv2RcwUjsEckBezapH/58cLDGlxPw0j8F9+EWaYXwQNHnvOFFA5KZvt9Q70M/AujIJjsUt9Mq5HilT7MvTE+qt6LgBdV++/p2f6kgU0bpg3FXt/U=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8460544a-a078-428f-dbdc-08d59db25868
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1047;
x-ms-traffictypediagnostic: DM5PR2101MB1047:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1047DC18ED635CF3546E5320FBBF0@DM5PR2101MB1047.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1047;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1047;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(39380400002)(189003)(199004)(51234002)(97736004)(3660700001)(2900100001)(2906002)(8936002)(11346002)(3280700002)(106356001)(446003)(68736007)(72206003)(1076002)(966005)(86612001)(25786009)(3846002)(36756003)(107886003)(6116002)(81166006)(4326008)(486006)(81156014)(6306002)(6512007)(6436002)(53936002)(14454004)(8676002)(26005)(575784001)(5250100002)(86362001)(105586002)(6666003)(305945005)(186003)(10290500003)(7736002)(10090500001)(102836004)(6486002)(2616005)(5660300001)(316002)(15760500003)(2501003)(66066001)(22452003)(54906003)(99286004)(110136005)(478600001)(59450400001)(476003)(76176011)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1047;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: RdTMfLvFsaZ74bCUwK8VHj8h+v6l+jHt9vxs1/99i3MeunOQdl6aISczMtbYc19N+vzJ41siDQh9gT7VWmE0rGxPHfTjtVtr9f2YzzIZe3cSjEf4atQuiLZ5Xy0vSyKLRxESVdvcOEN7MvRbvA4Fq2+Fupkcw/ZQD51g1JaUaLwthGRhu39TV864hKzdh87sZ5mTfp7TsH8md1HMRCK658GMdbMPDbzDx4ELtLtQJAWjPGtQU2Jr/9LE9IdsfysjL9oVYrF0EDjnUk7LeGDeZ0vzoyg3+mRBOgHrlQchy3O8wfT+MfiOqrwz6ttludJUPycrD5/O8Swz+FqJA/kdcPft3Du5IcWFk3viaU2L2jmayuQiXkW7Hrg9tqKjL7KP2teHRia69uobCPCGbNpZ09FGTMPmNfzYPzTi3Dl5Bhk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8460544a-a078-428f-dbdc-08d59db25868
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:10.7205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1047
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
index 3df8366a8356..a82ff60f0921 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6357,12 +6357,17 @@ static int e1000e_pm_thaw(struct device *dev)
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
