Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520117705-2-11351363499293941135
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
    t=1520117704; b=oMPia3NQLitX780vc/97tthKISYPeZPN8qUPqpDWysMBWIm
    X1C7s4UiVA6rHK34Xzg9mnB7zJ6tePhFy0Of8OQ6qAAndclwMKTLSRNcj+8DBo9q
    KBnLlLdbwDiNgSgVdGsVblaVF27E7dXkI48VSPMOaQCYQtdIGMXHCvJLJVMjf47I
    +bzGhqUsf5fxAj9wle4gacKGJilNwjkHoKcWi9lR95p0LiOfgunkKAhWxycEvwYQ
    ij8sbdr4obVAfxo7yd2Ed/V20qNMXh7RqDYm7slXSUN1H/c23QfpbDczCfQ3EX6Y
    S84o9OpYw+VLNZlk8OW2jR0RFIpwP8rBN9TIkfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117704; bh=K703Oj
    nWehtlAfoggrnV8koc9DZlEcm0l7Nh1aXe974=; b=iRbUX8Ctj9+XPbb27SCiIf
    RXCWnQkW+F28oC8PNjspx/7f7J2iRqTldaknwcwSIWVt+9pJAlUKB2dbmOAz+CTX
    PxPOTct1eFylNdNVx3iy74f2K+P4jyypjh02bJVdH/CUENeGYTkkoftReEUkbFHZ
    WB3XiBruDN3P77ARvPBmgBBBYVffd4YcnZu69kQE2cTf8X7TXAsIiP4N/FV7ZUY6
    i6XfmwxvJ+vZZ825mXXvvsUJXFjTOgKIfYsFt7GQC9CRuNds8R5aPsJAGs+zkCHd
    7hbR1xcixx5YQ2kEKnxa9hzkSiE06QSK0AWdF19YaIs9EG9+L46m10AYLuf4htHg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=b0gh4dtK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=b0gh4dtK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935386AbeCCWlC (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:41:02 -0500
Received: from mail-cys01nam02on0109.outbound.protection.outlook.com ([104.47.37.109]:30112
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935365AbeCCWlA (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:00 -0500
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
Subject: [PATCH AUTOSEL for 3.18 05/63] PCI/MSI: Stop disabling MSI/MSI-X in
 pci_device_shutdown()
Thread-Topic: [PATCH AUTOSEL for 3.18 05/63] PCI/MSI: Stop disabling MSI/MSI-X
 in pci_device_shutdown()
Thread-Index: AQHTsz+cVvcbChRWj0OP1Vj451QxzQ==
Date: Sat, 3 Mar 2018 22:33:11 +0000
Message-ID: <20180303223228.27323-5-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB344;7:ooOa9Ykl4OzjIvrEVoo28jwM480pjjiC6Mi/ICUscIM11rSjGsvukfVqWs1Z7kThideLKQhTtilvYLcJG5eiF4Tq+NEZ6QX1SyVYpfpGB68hQL6q1Aq4q0rCflXS1k0cpWMqZA7HfkIlSwB9pOOm5n+48oT6hDbS4OSm6ETFm3acHZxX2sIeLaETjKmXtUMpdVyqIWt+az4t0GtrEGS7TzqXUxZjGAG9Iox0JHIAMvX/OBD8eE8KO1EtdAcTfRvu
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d64a305d-e476-47ab-8585-08d58157d422
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB344;
x-ms-traffictypediagnostic: MWHSPR01MB344:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB344E5AC881308855C41FC90FBC40@MWHSPR01MB344.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHSPR01MB344;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB344;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(39380400002)(189003)(54534003)(199004)(8676002)(5660300001)(5250100002)(2501003)(6506007)(575784001)(7736002)(7416002)(36756003)(25786009)(3846002)(6116002)(966005)(97736004)(305945005)(2900100001)(76176011)(6436002)(10090500001)(26005)(8936002)(186003)(81166006)(102836004)(81156014)(106356001)(86362001)(10290500003)(3660700001)(2906002)(99286004)(14454004)(86612001)(105586002)(478600001)(4326008)(6486002)(53936002)(107886003)(68736007)(316002)(54906003)(110136005)(6512007)(72206003)(3280700002)(22452003)(2950100002)(1076002)(6306002)(6666003)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB344;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: zy6CLRPlqVC6Ql97quoB3f8uyLuaMKVaMcV4Xg26q46ALkthGC6xmZaAl2Vfuctbu3K2TT428PsHCnGwyR49xBp+viNLhCXsem4yGQMkIBLZ9T2kDU8SHnw7tiQ+13GcwcEk3e4MBxUTPsNJI+k6GgnlNqaT5gmgk6KKq3toQLU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d64a305d-e476-47ab-8585-08d58157d422
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:11.4035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB344
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
index 0ad37e69746d..b92480973586 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -450,8 +450,6 @@ static void pci_device_shutdown(struct device *dev)
=20
 	if (drv && drv->shutdown)
 		drv->shutdown(pci_dev);
-	pci_msi_shutdown(pci_dev);
-	pci_msix_shutdown(pci_dev);
=20
 #ifdef CONFIG_KEXEC
 	/*
--=20
2.14.1
