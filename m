Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239435-2-10813241815249929572
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
    1523239434; b=QSR+J2c52/6xKPnrwxFPTd1+bp8vpbQwFTvsJ95jc5grABWjnm
    qaNmp7meTO8yqgaAVUGljwkFklnPdH6cCtJ6a1kHlG4ZpjuU6wIO5GsM/dDZ64AK
    +Ac/mxWn169jmsI1eEgmf+njQUy5DozqFHRTdes5nprm5vtRHK2q5J3twgENvizs
    93hYhVqM9YE9j1SwM3n0uwBVuhBaiX07tB6vlLVCZGNSOFsaDWmGluBR7giXgZdz
    30BLlQ/+N2RiqQTeXObTSTUPXtCj9FbXVI6laVqb9fGsUuSiI3PQxhbuiqQEBCHo
    KUlpye/xxAaCgdqLayN8GiY1nptr+bM516EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239434; bh=v3GZfbMkfa
    9ri98l7Udh0ceGHlZ8qCXC92ZKvD/NdIc=; b=Mfsbg4OjxfNXL6nL8sdMuqi+kQ
    n6HnVmFSOBapUr93I+czk3BFRar7ZXVdOYO6LQtTCDK2YPwfLCKhGxF1Kywp9hs4
    ni/Oba6cVssEjiUqRQs5UceK6WiTFaRBCcXrzuuCSMrj99rLY41NK6IVy2HPSNjf
    DARZ2S9bCqzzihraHakXiyP6yZ7k50bBmokXbGza6TB5nWqEvfops34NOWrgeXUu
    L35QMHMZQevdePgVWWZpnji3rLOy1OIOBu7bwVxG4ETdiPiiCwtcb623FWXfV8VA
    D2+TKv0RHhAP5hJo3bgMSCyQjtcWrofaq6iJS/ztbvH4XE+PHRkEXXGu+FGQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gMhKS6Ii x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gMhKS6Ii x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA76zy/2BL5DVzSigd93BPFgCIo/x2ioIT++RL87Hph0l0yNj6FZyUsFqq79/JJ2q61DSUaM6zpy3/+7YN+0bcRhCkK5X4uNvPk19HIrQjOte/0zpY+0
    c1Seh45I1EJ9Uf0sTm0DL1Y0qRgTNHz78LUvzduSLhmzku7nptFJPR1WZFI28xvwc4/++JrKMxnCCUND70s45CmU1wbnPhtdP2+2oRoxph4gWdAjk3BDatIT
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=1XWaLZrsAAAA:8 a=yMhMjlubAAAA:8
    a=RUsd5_n2bj49b8eLYCQA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756356AbeDICDV (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:03:21 -0400
Received: from mail-sn1nam01on0133.outbound.protection.outlook.com ([104.47.32.133]:23728
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756390AbeDIAcD (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 192/293] PCI/PM: Avoid using
 device_may_wakeup() for runtime PM
Thread-Topic: [PATCH AUTOSEL for 4.9 192/293] PCI/PM: Avoid using
 device_may_wakeup() for runtime PM
Thread-Index: AQHTz5lAanRJQict+0yWFsZ9f0P3PA==
Date: Mon, 9 Apr 2018 00:25:24 +0000
Message-ID: <20180409002239.163177-192-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:sQlN6Kky54Nt+2HA/PX5JsJw36bkkgQQR35CRxLwkEzySxtzNz9Pz/CCti7HcI/dVq4LTXMsS2Qczjh7S8NQXETJAZk9PAPE6txvzbmlysWubMzD3k26CeOSrsMxqWv1Ckf5qgTQwQyfgTISeHZTmC0a1aNpRvjew+4xVu5p1eXtj5dnJePwb/X+ZovFgj20cpGeUs6QOE11YWwX7mHbUqbsWWAyun2MRU+EPWM7JPNBdQ2JKKlRHhv7vnJhSofh;20:P3NJLD9LZNImmpCs6wf2KXoRAy3nmaY5rbTu8gLCngB1+ySN9icrlpDth0NxmIZM/yE2EYbDewzAXE280B/14t94PadR+cl8SrQ1aamlgOuvpNI1v0SKj9/hCk/6NpTuAeFvAnAB7bYYi/Co7fCtumtyAcOxCcTT0kVQ4qKzhdo=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1b4821c1-ece2-4fd6-91db-08d59db14fb1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0870C543D9A75C3F3714CE41FBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(39380400002)(376002)(199004)(23433003)(189003)(53936002)(2906002)(6512007)(102836004)(2616005)(76176011)(14454004)(446003)(10090500001)(11346002)(476003)(486006)(107886003)(59450400001)(2900100001)(97736004)(66066001)(6506007)(6436002)(106356001)(99286004)(105586002)(3660700001)(6116002)(86612001)(3280700002)(6666003)(2501003)(10290500003)(26005)(8676002)(8936002)(478600001)(68736007)(5250100002)(5660300001)(316002)(4326008)(72206003)(186003)(110136005)(6486002)(7736002)(25786009)(3846002)(86362001)(36756003)(22452003)(81156014)(81166006)(575784001)(305945005)(54906003)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: onMx+EEYeD5kPOnbRQVofi1oN5F+w33kVCywAzYfto/9Vpd3/9dVBv32v0ER5uaphd0cFzMYfNgGvIUt5/2Qv6u9O3CRPuymNQxHB7EogVqCZa6HaR7hJu51J3+bEQqSWQxIzfHq2YH39KoYKGE6y/N8R5WcqnC4CRvOvGBJnqKNkI3YSTOALCB3E7URkUEFpPQJYlil5bnAYO74hpSPBMdMJvm5QZu268LwR2D2L5zobsSx52tgdbAsdYk7C0KzX2NgF4iNv/d7wKPNwq8AMsjigzCypeVC2HsRu2PSn5Mw6+oedyIFEKbmJaQquRsUcOo3ziWE+MCVh06ZdJyAQ/V99Crx/lDYBxxmpiqYVJ3/4pUuQB8iU+61MrWARfMehaiyak+70WeZppyM4Tg2JJeYfVpxopx6cMelgdYOZn4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4821c1-ece2-4fd6-91db-08d59db14fb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:24.5189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 666ff6f83e1db6ed847abf44eb5e3402d82b9350 ]

pci_target_state() calls device_may_wakeup() which checks whether or not
the device may wake up the system from sleep states, but pci_target_state()
is used for runtime PM too.

Since runtime PM is expected to always enable remote wakeup if possible,
modify pci_target_state() to take additional argument indicating whether or
not it should look for a state from which the device can signal wakeup and
pass either the return value of device_can_wakeup(), or "false" (if the
device itself is not wakeup-capable) to it from the code related to runtime
PM.

While at it, fix the comment in pci_dev_run_wake() which is not about sleep
states.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pci/pci.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 774b0e2d117b..d6480b30ea8a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1958,12 +1958,13 @@ EXPORT_SYMBOL(pci_wake_from_d3);
 /**
  * pci_target_state - find an appropriate low power state for a given PCI =
dev
  * @dev: PCI device
+ * @wakeup: Whether or not wakeup functionality will be enabled for the de=
vice.
  *
  * Use underlying platform code to find a supported low power state for @d=
ev.
  * If the platform can't manage @dev, return the deepest state from which =
it
  * can generate wake events, based on any available PME info.
  */
-static pci_power_t pci_target_state(struct pci_dev *dev)
+static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
 {
 	pci_power_t target_state =3D PCI_D3hot;
=20
@@ -2000,7 +2001,7 @@ static pci_power_t pci_target_state(struct pci_dev *d=
ev)
 	if (dev->current_state =3D=3D PCI_D3cold)
 		target_state =3D PCI_D3cold;
=20
-	if (device_may_wakeup(&dev->dev)) {
+	if (wakeup) {
 		/*
 		 * Find the deepest state from which the device can generate
 		 * wake-up events, make it the target state and enable device
@@ -2026,13 +2027,14 @@ static pci_power_t pci_target_state(struct pci_dev =
*dev)
  */
 int pci_prepare_to_sleep(struct pci_dev *dev)
 {
-	pci_power_t target_state =3D pci_target_state(dev);
+	bool wakeup =3D device_may_wakeup(&dev->dev);
+	pci_power_t target_state =3D pci_target_state(dev, wakeup);
 	int error;
=20
 	if (target_state =3D=3D PCI_POWER_ERROR)
 		return -EIO;
=20
-	pci_enable_wake(dev, target_state, device_may_wakeup(&dev->dev));
+	pci_enable_wake(dev, target_state, wakeup);
=20
 	error =3D pci_set_power_state(dev, target_state);
=20
@@ -2065,9 +2067,10 @@ EXPORT_SYMBOL(pci_back_from_sleep);
  */
 int pci_finish_runtime_suspend(struct pci_dev *dev)
 {
-	pci_power_t target_state =3D pci_target_state(dev);
+	pci_power_t target_state;
 	int error;
=20
+	target_state =3D pci_target_state(dev, device_can_wakeup(&dev->dev));
 	if (target_state =3D=3D PCI_POWER_ERROR)
 		return -EIO;
=20
@@ -2103,8 +2106,8 @@ bool pci_dev_run_wake(struct pci_dev *dev)
 	if (!dev->pme_support)
 		return false;
=20
-	/* PME-capable in principle, but not from the intended sleep state */
-	if (!pci_pme_capable(dev, pci_target_state(dev)))
+	/* PME-capable in principle, but not from the target power state */
+	if (!pci_pme_capable(dev, pci_target_state(dev, false)))
 		return false;
=20
 	while (bus->parent) {
@@ -2139,9 +2142,10 @@ EXPORT_SYMBOL_GPL(pci_dev_run_wake);
 bool pci_dev_keep_suspended(struct pci_dev *pci_dev)
 {
 	struct device *dev =3D &pci_dev->dev;
+	bool wakeup =3D device_may_wakeup(dev);
=20
 	if (!pm_runtime_suspended(dev)
-	    || pci_target_state(pci_dev) !=3D pci_dev->current_state
+	    || pci_target_state(pci_dev, wakeup) !=3D pci_dev->current_state
 	    || platform_pci_need_resume(pci_dev)
 	    || (pci_dev->dev_flags & PCI_DEV_FLAGS_NEEDS_RESUME))
 		return false;
@@ -2159,7 +2163,7 @@ bool pci_dev_keep_suspended(struct pci_dev *pci_dev)
 	spin_lock_irq(&dev->power.lock);
=20
 	if (pm_runtime_suspended(dev) && pci_dev->current_state < PCI_D3cold &&
-	    !device_may_wakeup(dev))
+	    !wakeup)
 		__pci_pme_active(pci_dev, false);
=20
 	spin_unlock_irq(&dev->power.lock);
--=20
2.15.1
