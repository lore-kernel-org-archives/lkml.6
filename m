Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520121378-2-12109574745580670976
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520121377; b=g7bE7zbLbdUyF39USSnlyAMH4a1t8byNpnh6MvXeHnKRYcK
    ge04O3kA36x2YjJoGBg2dtInYqvjJlP2tmDnQwg52C6H5CfYuPVvTmliwmD6X6+T
    B/0MjZkgOAKhpv2vLd2ZLUB6B4qSjATTmodiWJd5obWBeVoIXgWabuBrrbH/3Y2q
    GsJtLVr964Wf3KP8fZ+uTNxjIUMfN9NzbqoipQ1apjDEzImhUlZHxQOmdOVt0u9A
    o+qkiwB52G/AMlkQeGsY7UyDuCK2AAgKNwLXavwhkHl9vnybInklO37dlTyj/9dh
    fhJtHYGNahR2sRrIbus2n3egY1aDCs4fJ8PFndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121377; bh=QREJIE
    qZGKFms2+srj2InuEFh0sIyHOYPy1Kq4dBH9E=; b=v+CyaxwvxuPRJpiBZH3fFj
    zUzJyTOZRbOeUyG7lq27+N+MYzN5Ao2CSRsI98+KJntXFFwiRiMs/0wJIeTyU6hG
    7RI2x3ojgYpX1lohapg/nZkIMnz/xpQbRcGnbE8KjU2P1PpuQe4Mcb+NhAAKFMY4
    FGDwEeQN775nbebuVBbS7eKdu7w3ofDf06Jn5HF9sAvAVXgnFd7tjS2kg7+YTs6r
    noGOWn4VngjigxJZM3w8+xSwhXyTddawys8eA+csGlXedfg7vbzyrND42n2M9iLc
    sPUzJjMAMv+grUc3XXws6q57WaqszueytArGThUK88cni1ePLkrjMAOxxynZFgNQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=d6eh3zYG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=d6eh3zYG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933902AbeCCWcz (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:32:55 -0500
Received: from mail-cys01nam02on0126.outbound.protection.outlook.com ([104.47.37.126]:47215
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932725AbeCCWcw (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:52 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Long Li <longli@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 062/219] PCI: hv: Properly handle PCI bus
 remove
Thread-Topic: [PATCH AUTOSEL for 4.9 062/219] PCI: hv: Properly handle PCI bus
 remove
Thread-Index: AQHTsz7249ltE9RbrUSk8QiI1FtjKA==
Date: Sat, 3 Mar 2018 22:28:32 +0000
Message-ID: <20180303222716.26640-62-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1098;7:J0CP3tK80AUQdaLyyjWhSrzap1PsWUhuj1qgNvrJWYyqWn+PpdBfhWdCbp6L77dcs1dI5d8nsroe1+Ym3xjaaAQK2tAjJqsFddY+Gpt0t6mwEU5YjJP+HQjhzpVfes0jOCzq4CFES5Qtdr0xrgwr8/U2L7GBFBdPxYe2Fw79L1zj6QAgixr8xmq8w6XH66yoD2X9TAimFynrvPRJbad2sKvbi0hFiks0v4666kwx/aYXGzUpJoAcY78KSkEt4dn2
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca0ed1cc-1d24-4bef-6702-08d58156b229
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1098;
x-ms-traffictypediagnostic: MW2PR2101MB1098:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1098C20BF166BC1B8BCDCFA5FBC40@MW2PR2101MB1098.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1098;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1098;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(39380400002)(366004)(396003)(346002)(199004)(189003)(2906002)(8936002)(36756003)(6512007)(81156014)(10290500003)(81166006)(99286004)(6436002)(68736007)(478600001)(3846002)(22452003)(53936002)(8676002)(110136005)(54906003)(4326008)(316002)(76176011)(6116002)(7736002)(105586002)(305945005)(3660700001)(1076002)(14454004)(97736004)(25786009)(186003)(72206003)(26005)(102836004)(86362001)(6666003)(2501003)(3280700002)(6506007)(5660300001)(10090500001)(59450400001)(66066001)(106356001)(5250100002)(2900100001)(2950100002)(86612001)(6486002)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1098;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Ow5Qp3J19na0Pb/mkwYPqDcPGl9Xr/hrpVJmbqEIiayhr1ykr8bCC5RL/L2nzYyZjzzWZcGUXTqeKBoxU5G24t/I8szc4tsYZWa46gGikiVdBIqRR5j59yLYSsOe0XFGltaTypSGZdq/oEuShUTtwNHlhqsuWagrYZReUxlqFyA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0ed1cc-1d24-4bef-6702-08d58156b229
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:32.2600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1098
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Long Li <longli@microsoft.com>

[ Upstream commit d3a78d8bf759d8848339dcc367c4c1678b57a08b ]

hv_pci_devices_present() is called in hv_pci_remove() when we remove a PCI
device from the host, e.g., by disabling SR-IOV on a device.  In
hv_pci_remove(), the bus is already removed before the call, so we don't
need to rescan the bus in the workqueue scheduled from
hv_pci_devices_present().

By introducing bus state hv_pcibus_removed, we can avoid this situation.

Reported-by: Xiaofeng Wang <xiaofwan@redhat.com>
Signed-off-by: Long Li <longli@microsoft.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index dafb4cdb2b7f..43aa630f419a 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -351,6 +351,7 @@ enum hv_pcibus_state {
 	hv_pcibus_init =3D 0,
 	hv_pcibus_probed,
 	hv_pcibus_installed,
+	hv_pcibus_removed,
 	hv_pcibus_maximum
 };
=20
@@ -1489,13 +1490,24 @@ static void pci_devices_present_work(struct work_st=
ruct *work)
 		put_pcichild(hpdev, hv_pcidev_ref_initial);
 	}
=20
-	/* Tell the core to rescan bus because there may have been changes. */
-	if (hbus->state =3D=3D hv_pcibus_installed) {
+	switch(hbus->state) {
+	case hv_pcibus_installed:
+		/*
+		* Tell the core to rescan bus
+		* because there may have been changes.
+		*/
 		pci_lock_rescan_remove();
 		pci_scan_child_bus(hbus->pci_bus);
 		pci_unlock_rescan_remove();
-	} else {
+		break;
+
+	case hv_pcibus_init:
+	case hv_pcibus_probed:
 		survey_child_resources(hbus);
+		break;
+
+	default:
+		break;
 	}
=20
 	up(&hbus->enum_sem);
@@ -2170,6 +2182,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 	hbus =3D kzalloc(sizeof(*hbus), GFP_KERNEL);
 	if (!hbus)
 		return -ENOMEM;
+	hbus->state =3D hv_pcibus_init;
=20
 	/*
 	 * The PCI bus "domain" is what is called "segment" in ACPI and
@@ -2312,6 +2325,7 @@ static int hv_pci_remove(struct hv_device *hdev)
 		pci_stop_root_bus(hbus->pci_bus);
 		pci_remove_root_bus(hbus->pci_bus);
 		pci_unlock_rescan_remove();
+		hbus->state =3D hv_pcibus_removed;
 	}
=20
 	ret =3D hv_send_resources_released(hdev);
--=20
2.14.1
