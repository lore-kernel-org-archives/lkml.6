Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2878775-1520036447-2-3988820448658771698
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
    t=1520036446; b=aWMZE4IQpXh2re9IzhBrtl2lGTQBK5BFT0C6lzFK59rqo/Q
    0zMes+IgDA+wfoiCpzGoXY8bW1MaHs4Ndm7o4iSft0QKn5dWGTksLdsivfdBoxnl
    sQ07qAkQkwCGjJ4BFWHGjtRWlBv1QvTx9wiNIy3H7EAx5f3nKUuisyYG3tXCqfmf
    N7ATR6ENQvwYzAJmar5UO3FkrIuY0dMgIsd+ySfwz2EpwhsRsuZdwHgPVbGkbmpS
    MG0UUa45VkgiLwHTeSv7K8MKiAVORWRdPS3I2YmXu39jmetabnc5hLdZQADjT9aI
    4IAd7TXccm2ToK7s5/HwZetIc6Q3eMFx42PfhjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-transfer-encoding:mime-version:sender
    :list-id; s=arctest; t=1520036446; bh=vxCIrSoAZrlKw9gBWMMUtwbcEj
    /n0Rn78xMG3DArWYc=; b=SUsZ2RESzE19UJg/TIW2Rmn2yXbhHXNdVOKBP+O2MX
    Re6onm1fa0VVj5ChM15GIw8yOkZsKKThojoEKqxeY2SOR14n5vWovDV2Xkzpb/sn
    meRTDBAWdCzELfx9vgS8iEZCkpTZN9vR2JZwJPm4vfCrAsQXA7cIkySBebFihBqA
    nvVE9sdYLX+Ma5Hm3NPk3rQou4WdUjLvI3yCCeeF9uw1sWBymUjAUC5pgnZVyvZC
    xUsV5SkSMAWDFHIWLowtVkZ091OpLmzGgyyy7CpZRsai14+RskhGf8+OtRYTx0ad
    WlpLFpWr2ALGe8xP9JG8QhiaQwqeomUUFwJLYW0dlbhg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=e9rsfjSE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=e9rsfjSE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935399AbeCCAUo (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 19:20:44 -0500
Received: from mail-sg2apc01on0110.outbound.protection.outlook.com ([104.47.125.110]:43168
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932890AbeCCAUk (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Mar 2018 19:20:40 -0500
From: Dexuan Cui <decui@microsoft.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Dexuan Cui <decui@microsoft.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 1/3] PCI: hv: fix a comment typo in _hv_pcifront_read_config()
Thread-Topic: [PATCH 1/3] PCI: hv: fix a comment typo in
 _hv_pcifront_read_config()
Thread-Index: AQHTsoVwc9zL3DkZZUigOOSbdSFRmA==
Date: Sat, 3 Mar 2018 00:20:32 +0000
Message-ID: <20180303001947.20564-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.15.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0054;7:UBceKHZAJTfPUk08AbIZlaRG05UNk/KGdpgd3m957Bb9pP55CVWaHn+KVtsnQybHlspiI47FiywiEF7xxU2aVgmQooqlAMNXdjaVO3btwmIIb11TEowPy9S7rjQvf5qAdYyf6jVGX8wju+J6XxIWkXNQTtGgtiybWKfUkZAFTugxOy7ftFY31vM9QMrCQ5rY+V2v0wDHPZPfIZTiCvGb9kCWNNjwWcrYo98xLmdxqdOGNP4ZNsUlgPqrZoaKICC7
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fb0993ae-ad62-4310-ee1c-08d5809c93c1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:KL1P15301MB0054;
x-ms-traffictypediagnostic: KL1P15301MB0054:
x-microsoft-antispam-prvs: <KL1P15301MB00541A0FDBC1F2F20627AFA4BFC40@KL1P15301MB0054.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:KL1P15301MB0054;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0054;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(189003)(199004)(5660300001)(2906002)(4326008)(6116002)(8936002)(86362001)(2501003)(8676002)(6506007)(2900100001)(6436002)(14454004)(3660700001)(86612001)(305945005)(36756003)(99286004)(316002)(97736004)(25786009)(110136005)(1511001)(102836004)(54906003)(81166006)(10090500001)(81156014)(59450400001)(3280700002)(26005)(186003)(77096007)(6512007)(6636002)(478600001)(3846002)(1076002)(22452003)(10290500003)(106356001)(66066001)(6486002)(50226002)(7416002)(68736007)(7736002)(105586002)(53936002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0054;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: hiaYUlBokXrQkJxBhokOPzjzQS/thFsoMcZxk604eKuHPjjo7JFPla6BoWW4VOGyP81rhQVZxwX/r/tRHBsq2wv0cMn34FkrrTWiIp1rt4QisiharfUwa+KBnIH1ynYGe4oWakMYwpmPaYjj3UDfKlhLdvtnjRPpeAvAama4kao=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0993ae-ad62-4310-ee1c-08d5809c93c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 00:20:32.0693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0054
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

No functional change.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Fixes: bdd74440d9e8 ("PCI: hv: Add explicit barriers to config space access=
")
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: stable@vger.kernel.org
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 2faf38eab785..1233300f41c6 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -653,7 +653,7 @@ static void _hv_pcifront_read_config(struct hv_pci_dev =
*hpdev, int where,
 			break;
 		}
 		/*
-		 * Make sure the write was done before we release the spinlock
+		 * Make sure the read was done before we release the spinlock
 		 * allowing consecutive reads/writes.
 		 */
 		mb();
--=20
2.7.4
