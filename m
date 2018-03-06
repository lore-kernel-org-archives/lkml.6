Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-961214-1520360614-2-1829437770588848829
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
    t=1520360614; b=f1QrgNAYLBsmcULkzt8Jqieb0IiJ0jHW2izL7c6bEMs1CtQ
    VNoWIEE73EneWZUkmkUMNEGYhBtJUIn1IWh0REAtTWcnR4S6U4X3Kj35MAz/K+7Y
    2mJv7ToKxDx3Wiv8cnETCfFhryAxwv/JvWYzINr/9Y7Av4q+n/Q0fUUewHiQWAeD
    IeVJEZERiKw0MoQi5ZQnEf3GwntD58zAwqfM4vgHbbGrC74GqdxF8nLs89pEELdp
    IMDXvuhUY6HdtBBNm71LLDMClERmy0GpaA036RgE/YqcV3sAIJ4oKrzBC+Fvca3q
    TrD3VVhV+JYOWrXKU7gXiCeU9NQcdmq/hjBjsUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520360614; bh=vxCIrS
    oAZrlKw9gBWMMUtwbcEj/n0Rn78xMG3DArWYc=; b=OLBe7Njv4OP9XCZS/HExiu
    1tBSJILr7rHe6Uy4VL4KZqHdfD8629h4M54bgG5Fp37mcKpU1AlHYk8hGw7RZRwi
    W28tX6/kpMii9eCH6ePspA7v6O45koGbQ3Bxpr1WH/8szdcosJsLTSTZklLfyEqg
    JZYZ1225ZxHeVK1TYxzvYwSe2EH2JlYe8D/LKy7B89o6A4ZKj1FYGtzBLlT2ZvMs
    O860IhkZ17l/hSy8pOnbvecoSycCOieY3h+5eO/khE7QuZLwcSg/5cRe++DZKDf3
    DZNQ1+mTLoVcxVpnp91aaI+khembwLrS7l6S8Szz6fIYSklXwNqyjDM7B5uGH5zw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=htA2v0W3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=htA2v0W3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753857AbeCFSWA (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 13:22:00 -0500
Received: from mail-hk2apc01on0139.outbound.protection.outlook.com ([104.47.124.139]:63328
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752910AbeCFSVy (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 6 Mar 2018 13:21:54 -0500
From: Dexuan Cui <decui@microsoft.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v3 1/6] PCI: hv: fix a comment typo in
 _hv_pcifront_read_config()
Thread-Topic: [PATCH v3 1/6] PCI: hv: fix a comment typo in
 _hv_pcifront_read_config()
Thread-Index: AQHTtXf9Xgdhivd5iUeAlOzYOusM+w==
Date: Tue, 6 Mar 2018 18:21:47 +0000
Message-ID: <20180306182128.23281-2-decui@microsoft.com>
References: <20180306182128.23281-1-decui@microsoft.com>
In-Reply-To: <20180306182128.23281-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.15.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0021;7:EnxiuePkeg5UnLaOE1gO7rNF5Z9XIJjaEO3R0Vv2C+zVoxZscu9V5ZAfQwyBJ2WgLpgj+cd8LE14HUzoXM5muUNNZOl6s4gGis2SDdbxCbBXOVIDxD4Ctd6eJ1d90FCYekOa8++WNXV7cuYfWjW09Nx6QEJO5ysD92pmqOH476RvicAlO+Li89SNzb0CN7ZqRY/AYv8Fk6xsGIPNU+QTsY0xjspTDQuRt4qkiBmqOeg2PdIeRTyiHaNbQSjcOEi6;20:gj7Qkxash52gnb0pndc8O2K1R1PeZGSBEpGDPfKMuRXcJYgkr5eFKodMmpicla6wQlTQjy4r4PQZMU/TFwnrQiwdXzbCExTjRARTX0n9zlz6DahhwoOdheR5Hv9pzfNC7F4tlmbTN9dEd6c87KCNV+fn1gebXP96QW15zMX7i+Y=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e66bd43-a438-43f5-f11d-08d5838f1fd3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:KL1P15301MB0021;
x-ms-traffictypediagnostic: KL1P15301MB0021:
x-microsoft-antispam-prvs: <KL1P15301MB0021D4ED737C4C1521BE74EDBFD90@KL1P15301MB0021.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:KL1P15301MB0021;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0021;
x-forefront-prvs: 06036BD506
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(346002)(376002)(366004)(199004)(189003)(5660300001)(36756003)(22452003)(1511001)(10090500001)(2501003)(66066001)(316002)(7736002)(14454004)(10290500003)(2201001)(99286004)(305945005)(7416002)(478600001)(76176011)(25786009)(4326008)(86362001)(102836004)(106356001)(6506007)(105586002)(186003)(77096007)(26005)(3660700001)(59450400001)(110136005)(2900100001)(54906003)(68736007)(50226002)(97736004)(8676002)(81156014)(81166006)(8936002)(53936002)(3280700002)(6116002)(86612001)(6436002)(6512007)(2906002)(1076002)(6486002)(2950100002)(3846002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0021;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: oN/C28vMElwxe0ww29WaZ8k5XzoX7Rq1zj6qaXQy78v87Mu4Q27Ehf+Zb6p5+IzwP/eNi+KIIaEgsII5ezaWNmHEwOBl3cZ+UZG9V1X14MsK7gBRpX37O2VA4c0HODFK7HgnFg26gW7HyoUxIU29GttTS8v6ktYSizvsDx8/+F9yrI4LN4o6tD8sK7fmTt0+xvAaqCV0Aiyk/bD8Vm8tvHuZk5gqoGj8EEk+uYoUXapOIu6bjpqANcRX6XlyoaI5JIoEOrQHY+uJEe8kLY6hSoJaLFLHcf+2x0hIx6aun/ADOWsDEQIWitlEnn4YU5Mg9LwtrkOE/VH77Q7IMxURBw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e66bd43-a438-43f5-f11d-08d5838f1fd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2018 18:21:47.5724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0021
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
