Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520119026-2-4493602396594311563
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
    t=1520119025; b=kF0Oa4dWHfmpbJYGGFIy0AjMeB0Zf2AWn4NdmSyn5Se9tjj
    ZBmcHoBa5FtCSAHsN7IS2ZCzseQJIWwtietOsV6GtTfbZ5w2OwhCq+WvsVwpAHd6
    YqJSJzWEh5m5TU6PlRi51/J+7Iwjfdams8TnqC4FnwDGjbXFXNHWtG+jORCG4wWW
    nvOBV/RWVUcso7SsKpm/dS7PP7XzTGgeUJIhN0ZslyPJjUuMk5Rt+uKnBfDBHJn9
    v0F0gXSH35EcOeBooDsXTHiSPQPEgijwS3bkflwXuvkLIKxvo3bQZiJZrMA6NiXu
    u4y0VfkmFnBsiRUR55Z02+1o2D9idfBA8z6R/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119025; bh=VFpixt
    3ZihPGivWoJnkLwL/MjHjbl15wwnQ1tN+tsgc=; b=Q2LfGTrhnBdfOfmgYB5Y7t
    n00ACGhN9ohGTq+NTQO0MS3Px/P4kLVBY745CMv9Yoib21S8iRRUjPK9kQ9pXPYw
    fV0w3NCkjR0aJ1O3XPYuOKOzZHl9ZEwNwf/UYnPF95kJkLS4cMvvSInaGYfx3Ea0
    7usEpFFrxC3d/g5vA2tePDBVTYt23OzHyjcdJV7OXD2h4/TmViVLddo130VqJrGu
    ggAt4SS+c/Sfa98eISNyamVU5TCr0BbEuQBzEr2F2Gak7dLn8JSneFqQiHyKgiIk
    cNMdlbr4keiFmOj4K6suab9ZOxYjBU1pbnL1Uj63+M3gQjM0lOIKuo7ZxXR5+jEg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aVZas7qO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aVZas7qO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbeCCXQr (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:16:47 -0500
Received: from mail-cys01nam02on0111.outbound.protection.outlook.com ([104.47.37.111]:42492
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934899AbeCCWiM (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:38:12 -0500
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
Subject: [PATCH AUTOSEL for 4.4 009/115] PCI/MSI: Stop disabling MSI/MSI-X in
 pci_device_shutdown()
Thread-Topic: [PATCH AUTOSEL for 4.4 009/115] PCI/MSI: Stop disabling
 MSI/MSI-X in pci_device_shutdown()
Thread-Index: AQHTsz9Jwwc1wvGH3028VAxyTTjO9w==
Date: Sat, 3 Mar 2018 22:30:52 +0000
Message-ID: <20180303223010.27106-9-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1100;7:nQ17cirzNPtLksgBUodwiOzQxuqg0TEXxYuqWwurkqFSJIvUS4tK4+h80nLeyi92gNSAanKiZJWnc3RxmvZ67MvAbjXUw0ED8ZuCY//QSfrbscsWjDST4y1Qws1rXLZ0pqv8zkaryL0TN2QMD0aiDE285H+CfhfElQo58SCDuyofo+LKmrcJt1aBToQ0kaFA/QwfM4jEiwY5Z2XNCgDJIr3LXvIGpW/9iZQpZJDGN+H1qwHWMPBPC4q2JjLwC6cp
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 100c5a8f-527a-4ae6-9fde-08d5815768d3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1100;
x-ms-traffictypediagnostic: MW2PR2101MB1100:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1100259D06A35918434D905AFBC40@MW2PR2101MB1100.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1100;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1100;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(396003)(366004)(346002)(54534003)(199004)(189003)(22452003)(97736004)(7736002)(5250100002)(105586002)(2906002)(6506007)(72206003)(966005)(66066001)(4326008)(305945005)(10290500003)(186003)(3280700002)(102836004)(2950100002)(6666003)(2501003)(478600001)(26005)(2900100001)(10090500001)(53936002)(8676002)(25786009)(81166006)(81156014)(575784001)(54906003)(7416002)(86362001)(6436002)(106356001)(110136005)(68736007)(36756003)(316002)(6512007)(5660300001)(107886003)(8936002)(1076002)(6486002)(3660700001)(99286004)(6306002)(76176011)(3846002)(86612001)(14454004)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1100;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: GIQgkWW6XbQ29ZKdgrZtXfbwYdlLuP4z/AcRru2eo9+2vayeKocqohk/uQFeFzwZyIHz3zOtikFhPMj2HukXWZ+qtt9bjZ7tv0526F8FaJUFgYpHz9ltAaVXVe/b7nj/g8HasK2zsdEaroDsA/HEtN9FEw+g/1ipWnym3xj4sho=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100c5a8f-527a-4ae6-9fde-08d5815768d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:30:52.4165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1100
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
index 32bd8ab79d53..5e42b5f2f565 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -463,8 +463,6 @@ static void pci_device_shutdown(struct device *dev)
=20
 	if (drv && drv->shutdown)
 		drv->shutdown(pci_dev);
-	pci_msi_shutdown(pci_dev);
-	pci_msix_shutdown(pci_dev);
=20
 #ifdef CONFIG_KEXEC_CORE
 	/*
--=20
2.14.1
