Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520121931-2-8572664536408269432
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
    t=1520121931; b=DBdUx2IY1nESP5UY8ncCSG8W25NOJJ3lYlqTYiz2N7JPOBn
    w4b6aWZtns997BHzUBasGLdT/9gYgSQsTzQl1Bpp5M7m54jSV4OcIzSvurpTcuVt
    uKu9q9VdQd0l72Vz61W0AEgw3IyU30ug4MHU/pO6+CByDdUHORFc4IoTQ1F4WEJv
    ngmeEckVBkHoDUo2YGqz6i+wjrwmQs5m43pDrzoDuCu0BUEIgmueoI7yiAl9MWx0
    +Efq59zcMCPuZ+eVAri0PILa66jpjtYhEqKI4kuecdgNlwJfjs2lfp9dExmpm9XL
    Lw6hlWbkUXfyhJYeh4hTlaJQDVFGc69v5E5vf/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121931; bh=t06PW7
    dQCcz98CQMPCrnug1+oDlGIxRXnNgjxph36X8=; b=FK7dfEmmtYO2pXT5GG2hpC
    q0CvtdTw0g3ZWykAE1NJEwA8B1eLU0j2p5m/PH4evpJwqc/UDL4h27/oRdyFUL1/
    n6DIM2ya/dsBsZVrNhtYv0vJBP57JFqVFejkiig3txGm+3LbuZfvBzV2hz7DN12j
    KX9TbaRHUvNgMO7OiAyxMW9UakSIsWmldIIqfYLnuVLHXLmo3wnFtVEy+YtdKNHS
    SsatEyP3LPezHnOofDP8vwKLrtREMIbA+LQ+MoLXuR7IAh6Kk2TDYmB5mOw/fBYM
    kDrHzPhHtyQ8Sso63jJwnSysl/FTEfjxF6603QVLWbsfF/nSCcwt8sj1Jus1VhMw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Louu27pl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Louu27pl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932119AbeCDAFQ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:05:16 -0500
Received: from mail-bn3nam01on0111.outbound.protection.outlook.com ([104.47.33.111]:54931
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933643AbeCCWbR (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:31:17 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Prarit Bhargava <prarit@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Arcari <darcari@redhat.com>,
        Myron Stowe <mstowe@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 020/219] PCI/MSI: Stop disabling MSI/MSI-X in
 pci_device_shutdown()
Thread-Topic: [PATCH AUTOSEL for 4.9 020/219] PCI/MSI: Stop disabling
 MSI/MSI-X in pci_device_shutdown()
Thread-Index: AQHTsz7n/Ui79xUjkkm4AlL2HzUCKg==
Date: Sat, 3 Mar 2018 22:28:07 +0000
Message-ID: <20180303222716.26640-20-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:sxsMeYvrYTBOtdRd1KCeR+b/ZQRXTjRUW9nsRYSnugmwlGd3o66XgJm2c/6BX0qNs0GwhCRnyhW80JcRXSBvwtcmSrMmh7QT6sziao/rlxWcnFRpw9K+Cv62/h0hRlpRTyAuMNk1vGaz+6JKg8qrg8Rw/lwugbDQjbmjtlWOSPlR1d9pGySPFSPhPF5gG8onCTP1jQEUFRpMbzpadbf+WrBuo01lBzHkMYse2mY+q5DxiUP+sAVgiJrDoQmAHepU
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 822bda15-4a7f-4afc-f364-08d5815676d5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB097082D12CAC2FE7ABD60824FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(54534003)(7416002)(575784001)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(966005)(7736002)(8676002)(6512007)(6306002)(81156014)(305945005)(72206003)(6436002)(53936002)(6116002)(6666003)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: ivZRohezpKGur54su/HZY9ZgylIqpx+8KIKhnRVNvwTps+Eiv6y8jmfkV9iXulzCeNqYsN1tYks7JJ/JNP8JnJdLGWFIUy5gBXoup9qPE6IDF14qzpvpCFpmZ8WCSn5KjjOkIBJ+1/27doNjn7970+sqmsptNMIMhK7KpfyZBs8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822bda15-4a7f-4afc-f364-08d5815676d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:07.0256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Prarit Bhargava <prarit@redhat.com>

[ Upstream commit fda78d7a0ead144f4b2cdb582dcba47911f4952c ]

The pci_bus_type .shutdown method, pci_device_shutdown(), is called from
device_shutdown() in the kernel restart and shutdown paths.

Previously, pci_device_shutdown() called pci_msi_shutdown() and
pci_msix_shutdown().  This disables MSI and MSI-X, which causes the device
to fall back to raising interrupts via INTx.  But the driver is still bound
to the device, it doesn't know about this change, and it likely doesn't
have an INTx handler, so these INTx interrupts cause "nobody cared"
warnings like this:

  irq 16: nobody cared (try booting with the "irqpoll" option)
  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.2-1.el7_UNSUPPORTED.x86_64 =
#1
  Hardware name: Hewlett-Packard HP Z820 Workstation/158B, BIOS J63 v03.90 =
06/
  ...

The MSI disabling code was added by d52877c7b1af ("pci/irq: let
pci_device_shutdown to call pci_msi_shutdown v2") because a driver left MSI
enabled and kdump failed because the kexeced kernel wasn't prepared to
receive the MSI interrupts.

Subsequent commits 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even
if kernel doesn't support MSI") and  e80e7edc55ba ("PCI/MSI: Initialize MSI
capability for all architectures") changed the kexeced kernel to disable
all MSIs itself so it no longer depends on the crashed kernel to clean up
after itself.

Stop disabling MSI/MSI-X in pci_device_shutdown().  This resolves the
"nobody cared" unhandled IRQ issue above.  It also allows PCI serial
devices, which may rely on the MSI interrupts, to continue outputting
messages during reboot/shutdown.

[bhelgaas: changelog, drop pci_msi_shutdown() and pci_msix_shutdown() calls
altogether]
Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=3D187351
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Alex Williamson <alex.williamson@redhat.com>
CC: David Arcari <darcari@redhat.com>
CC: Myron Stowe <mstowe@redhat.com>
CC: Lukas Wunner <lukas@wunner.de>
CC: Keith Busch <keith.busch@intel.com>
CC: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pci/pci-driver.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 802997e2ddcc..d81ad841dc0c 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -463,8 +463,6 @@ static void pci_device_shutdown(struct device *dev)
=20
 	if (drv && drv->shutdown)
 		drv->shutdown(pci_dev);
-	pci_msi_shutdown(pci_dev);
-	pci_msix_shutdown(pci_dev);
=20
 	/*
 	 * If this is a kexec reboot, turn off Bus Master bit on the
--=20
2.14.1
