Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2296094-1521050767-2-6835225802000099114
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521050766; b=kwyjKL5bSidXtTkPRI0xyVqwVB3eemH29GZhZCSUP00rG4d
    Pyr1qrYwYE3TUfQzwUnpEVcUwWV2QIhjilnCLRmW84X33e3nV83ZMxGgZDF1YNcP
    GJsnUXZiqpKARWBwda8SzFrlzG0+6nMSkRZO0lAGZxX3xttB5DhTNaYllTLEyGXx
    oTFIoLQK8CHDi8uGmpY/Zy1nOVyT68Cl3rxvaGOVKagJF8IW7WJIOfji1fgb5VLI
    PKgvXiT3rzh6FzebGsvAgnDNnsAIFMr9VUIryWWDol0iINJ9qVnhNJFxCYt+TUJL
    kkvDLUEu+qdf/mMdFruQnOSbgYF2L41mqGrEMJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :content-id:mime-version:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521050766; bh=Y
    2uqhIdHblNF+/lIaDCmF5E2WU0DmCMAyt/FJ78yaEc=; b=n8WAciHq/gWT2NzyB
    dZj4dzj+yibxLBkGZUAGc9ZqdzIgFysw3vFa85S+vURFoTYcSwL+7gpIrfzs98du
    vOSK6MhvKPU/ubCDKYkKlsF6Eh+9aMaKMfrIGJWCOkPWI71eY3xGKKebthpIivvH
    vyhpU4f+9oyL82kALFjPEo6ugNI4k040YLqopd1/aIAc1uLBAbGFP+oYjps6Vei1
    pn3QIEry3AF63iLO7JcxMvt8gDfOiG7YHtmytBgz2bd+5p3NXKzrHTy78owvnQyD
    7VKbVtbsDHBrtpxlBk2gxKVKye01kUJRzZlKqU+7uzNnTM9Ea1deVFDnPrlIaRHR
    9dJ4w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QMdmstk8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QMdmstk8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v2]PCI: hv: fix PCI-BUS domainID corruption
Thread-Topic: [PATCH v2]PCI: hv: fix PCI-BUS domainID corruption
Thread-Index: AQHTu78ZG8K5ecbT80ie9TifFjyK4w==
Date: Wed, 14 Mar 2018 18:05:56 +0000
Message-ID: <048A5571-8706-496C-99FB-35A0CF506A8B@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:4::292]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR21MB0778;
 7:cUAKm2Pn4nyoVdCS9EnJuJCDcaFx/v/0gmAWEKJPTC5TiHovUw+oi+QEFS1Gf562pEuMcvZCpVJTCAjlcN59W55Bi7TAiBSJclXr0l6Sblc13EpsxdRNPUynYUojojC7vmuAHb2kKAf4dYQm6yBWj7G5wb8ddoSiznCLO7ZNzDj3hWpIz/MztI9PYnvg6+8lGFbAqonHStebC7Ye73sd/L5zqZIIoaZerXv9h3Haxih0WDACVCCiLrxqAv/FT41V;
 20:aLQCQHg4pDex36NUGsXPVkweA1R22VPB2sLm/ChQo2ofC2C/zQtPR4sZcqraQFR9bvjODtQOiQuqPJe+Y8EKTct8vCEgjlXNUqd1HrkYQRDsmu93Vc81jWOsXk7rTSINpYjTCDqhay++mjDD/XaN7hz+ITHXgCrALwD68bjLKqU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eeae4002-0991-42b5-ac8e-08d589d63c20
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:DM5PR21MB0778;
x-ms-traffictypediagnostic: DM5PR21MB0778:
x-microsoft-antispam-prvs: <DM5PR21MB077854A72E01B670B0E35664F6D10@DM5PR21MB0778.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501262)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);
 SRVR:DM5PR21MB0778; BCL:0; PCL:0; RULEID:; SRVR:DM5PR21MB0778;
x-forefront-prvs: 0611A21987
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39380400002)(366004)(376002)(346002)(396003)(39860400002)(199004)(189003)(40224003)(4326008)(86612001)(72206003)(14454004)(8936002)(6436002)(106356001)(6512007)(6486002)(6506007)(59450400001)(81156014)(82746002)(6116002)(5660300001)(33656002)(68736007)(186003)(25786009)(305945005)(478600001)(7736002)(10090500001)(105586002)(81166006)(53936002)(8676002)(102836004)(6346003)(36756003)(97736004)(54906003)(83716003)(316002)(3280700002)(86362001)(6916009)(46003)(2900100001)(22452003)(99286004)(5250100002)(10290500003)(2906002)(3660700001)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR21MB0778;
 H:DM5PR21MB0826.namprd21.prod.outlook.com; FPR:; SPF:None; PTR:InfoNoRecords;
 A:1; MX:1; LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sridhar.Pitchai@microsoft.com;
x-microsoft-antispam-message-info: WdcbOYzKGiQByXeZ2XDH8UyX04f6GqVkLayvZ/5O0G5w2T10qjlVKimlh9Gvy+Z4a46uV3HIgEhLkvyBPmt0b4gM8MzCKyOhlzGmWpX0Amz25DMawjt3YSS9+57UHea+PRNk9mhVTnetO2u+gjGamctkm0LdAgNIwEmJ1SbBdxz63r6LCa/EQTZN8k8Ou7t0d411snl/4vq+rKUZO8YXI9qxG0McpMW0AQ60tAGx3z9nn/Wb+DNf87DIVQP82xWzt7vTv1WxLZqhTjg2blDXxRfpn6ZGWD0ug+IKzQBsJdqK+jRqH+Hnq5ZGcZoxefdDRuyY758cKuRbTQDGwqRglg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <3A055D528F3ED94DB940682E3EE86475@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeae4002-0991-42b5-ac8e-08d589d63c20
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2018 18:05:56.5855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0778
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Stephen Hemminger <sthemmin@microsoft.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jake Oshins <jakeo@microsoft.com>, Bjorn Helgaas <bhelgaas@google.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Whenever PCI bus is added, HyperV guarantees the BUS id is unique. Even with
that when a first device is added to the bus, it overrides bus domain ID with
the device serial number. Sometime this can result in BUS ID not being unique.
In this case, when PCI_BUS and a device added to the bus, even before the PCI
BUS is added to kernel, the first device tends to overwrite the domain ID with
0. Since there exists a PCI bus with domain ID 0 already the PCI bus addition
fails. This patch make sure when a device is added to a bus, it never updated
the bus domain ID. Since we have the transparent SRIOV mode now, the short VF
device name is no longer needed.

Fixes: 4a9b0933bdfc("PCI:hv:Use device serial number as PCI domain")
Cc: stable@vger.kernel.org
Signed-off-by: Sridhar Pitchai <srpitcha@microsoft.com>
---

Changes in v2:
* fix the commit comments.
---
 drivers/pci/host/pci-hyperv.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 2faf38e..ac67e56 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1518,17 +1518,6 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
 	get_pcichild(hpdev, hv_pcidev_ref_childlist);
 	spin_lock_irqsave(&hbus->device_list_lock, flags);
 
-	/*
-	 * When a device is being added to the bus, we set the PCI domain
-	 * number to be the device serial number, which is non-zero and
-	 * unique on the same VM.  The serial numbers start with 1, and
-	 * increase by 1 for each device.  So device names including this
-	 * can have shorter names than based on the bus instance UUID.
-	 * Only the first device serial number is used for domain, so the
-	 * domain number will not change after the first device is added.
-	 */
-	if (list_empty(&hbus->children))
-		hbus->sysdata.domain = desc->ser;
 	list_add_tail(&hpdev->list_entry, &hbus->children);
 	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
 	return hpdev;
-- 
2.7.4


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
