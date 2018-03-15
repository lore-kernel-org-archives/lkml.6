Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2930480-1521074200-2-6756346247477729058
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521074199; b=uNUh2kHvwBLkB410EZ4urh2cKNy0C0oHYhHonSMYkumwmir
    SQaI9ZlUcuKz+LqCtzXu78CQzf2KdHfMbx1HVDqHdSZqXZmeNcZy4ngswedddrrL
    15P7UPlY8CbXxpwFKLS1EnZaTsSG1LLLo12+I84sjQxvPLDAwYte6gYUdaoiCBO8
    ygvgzFd9sxYQ9L4dBIJOTk3TDePen8EzfqexEWfR9YzUCfNYrCG8weTJRPwo81Pm
    iZ4E0RKd6sZ7uaS6sIt3feCtxdsD7F5zZPENGD6sro7/nOZWkoT65+eFahBNycUu
    +IPh0gdm+RAVP28TiMBLZgYWntsj2mXsWEjdOkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :content-id:mime-version:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521074199; bh=q
    09wsH5yCuDQlshnhCUA5dwVHtyNIjr1rbUdLNE6i2c=; b=JEU8LqbXC7o7dYMDF
    A7Yl/wk3cv2/WUpxUxtn7Vc3P5Tny3WbBgSZi5gk5YC95PhTl9U/rFQMmUxOiG95
    kYsJp9j60Vb5eQGorre1JKwz6GCroj50Ioz4IL3XJr16b9XfGgFIj3ZkxaNfag1V
    Nkp8bUMizwQMLuPrDTCen1mJbPTuP6kihHky06TZMbGkZ3Uo6f6vwqW3GL4W1EPa
    gQMpTDgi/b/Wv//QUCJBfaMLUTDAAFcaDcy3SZobYYan2nVOBElIs1PDcaAapymk
    JRaMiwhh5HLlEGRRMY7fHsXjSlKU+kIgSVCFcXHweObNn/J03KOcPxI9sg/8Gkg8
    OVx1w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hpFoE7/s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hpFoE7/s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v3]PCI: hv: fix PCI-BUS domainID corruption
Thread-Topic: [PATCH v3]PCI: hv: fix PCI-BUS domainID corruption
Thread-Index: AQHTu/D/DaxTLK2/o0CSPNG8bCOBxQ==
Date: Thu, 15 Mar 2018 00:03:07 +0000
Message-ID: <C600E28F-E581-431E-9CD4-47C776E8E70F@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [167.220.1.236]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR21MB0281;
 7:6gF7htWv5XaaFM17nzLmjwESWBB2sLyTLwbz4ee3HZ8Ut7Mx76f5Xe0+ke7SxgMszlz58T+re7f/ikQnYlKKRxmRsYPkjzkUroj8oLjiT4xo6aEXaeBy3OuZu40BRaXhKGgE02wFap78243YnD1YnaRyOeKCdyRMeHM/4ad/ymXCkKN/KFbXPkmJ7YHeFy9QaxxDBPQuunaFcN7ZgV1q9hY2yo5obg2HROg0Zm5nBznEK1kbC/Ro39MkifSylrYY;
 20:1wtzInOneYj7SIi0cJMc9XGCKKZmyPgBkxNUc8lYEHAtjhGWmS95n2OF0aneYI3no4vYsQuQLaBEm1nf3yFlqS4evpAbOnZ9qSNlWOErnledJkm3FNTu4EbnQiB7RqpnIBu8xJbqFawUcSqBsQLx0l3eHGmCWqDyFYKL1PTzSgI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ba59a5ca-5ef5-42dd-5460-08d58a08220f
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:DM5PR21MB0281;
x-ms-traffictypediagnostic: DM5PR21MB0281:
x-microsoft-antispam-prvs: <DM5PR21MB0281FEA65926272200CD034BF6D00@DM5PR21MB0281.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231221)(944501270)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);
 SRVR:DM5PR21MB0281; BCL:0; PCL:0; RULEID:; SRVR:DM5PR21MB0281;
x-forefront-prvs: 0612E553B4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(39380400002)(39860400002)(366004)(376002)(199004)(189003)(40224003)(6486002)(7736002)(2906002)(106356001)(186003)(6512007)(53936002)(81156014)(22452003)(5660300001)(8676002)(6116002)(36756003)(3280700002)(3660700001)(3846002)(8936002)(6436002)(316002)(305945005)(81166006)(5250100002)(83716003)(6346003)(59450400001)(478600001)(72206003)(82746002)(68736007)(26005)(99286004)(33656002)(4326008)(86362001)(86612001)(97736004)(102836004)(6506007)(25786009)(6916009)(2900100001)(105586002)(10090500001)(10290500003)(14454004)(66066001)(54906003)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR21MB0281;
 H:DM5PR21MB0826.namprd21.prod.outlook.com; FPR:; SPF:None; PTR:InfoNoRecords;
 A:1; MX:1; LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sridhar.Pitchai@microsoft.com;
x-microsoft-antispam-message-info: fhXrXeIdgYROsJ/h633igWks++B5VJAwlY8hN63PdWkLyy2MUFyPgiHAOof32wZ+ug0tWZNvZkV5ylAdTeohgvA6kfhkeB15AOuhIJmKt3DdDHKH3Qx7hoiD+oMino4s1ehEiH/xpCovRd/DxDXpvFHy5506T9KFKYlUbJ00n0syf5n/3oodmJwhOf/wBlhMUi+GurgjZiWBcsPvNOtMTMdf0rf2v9OxYBSSkUyEKgjOeBbKfEdFnNW0umRB+jbajoKMri6Dp2a7QT7Qa5km4poKb2Cl79x9sv5tv0gS1gdzfXp/QwZcs0wInYorg96CcQF5RT918UXUl5I6+qzfFg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <1B5A05844DF417449790A25B09C5853A@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba59a5ca-5ef5-42dd-5460-08d58a08220f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2018 00:03:07.7657 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0281
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
 "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 Jake Oshins <jakeo@microsoft.com>, Bjorn Helgaas <bhelgaas@google.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Whenever PCI bus is added, HyperV guarantees the BUS id is unique. Even
with that when a first device is added to the bus, it overrides bus domain
ID with the device serial number. Sometime this can result in BUS ID not
being unique. In this case, when PCI_BUS and a device to bus is added, the
first device overwrites the bus domain ID to the device serial number,
which is 0. Since there exsist a PCI bus with domain ID 0 already the PCI
bus addition fails. This patch make sure when a device is added to a bus,
it never updated the bus domain ID. Since we have the transparent SRIOV
mode now, the short VF device name is no longer needed.

Fixes: 4a9b0933bdfc("PCI:hv:Use device serial number as PCI domain")
Cc: stable@vger.kernel.org
Signed-off-by: Sridhar Pitchai <srpitcha@microsoft.com>
---

Changes in v3:
* fix the commit comment. [KY Srinivasan, Michael Kelley]
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
