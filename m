Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3941427-1523501094-6-15247622873539217614
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523501094; b=IZovseaLqKYJTGhEZ1aj5ktyfgIByhZBOY3NGFwN8VBNQpIlOa
    p5Fsi+lx1YDYznUrDBnO6vquajrNL6bjTdygC60RQ93qbSxXmHrrhTqzgkF0DEgg
    HklHEKVR33xsRYgd+J8R1x6axxPGjqpbZvQ5UL2Cph7GfTmRiHe+TSefjkOP/doB
    lRoKb9LInKW5hJuhuYu2pn8Rg05BzfQz706/nK+bt6rKCcIucZNb03naYcKGrzcO
    VK1z2cHQPPXtGpamnvRCWmWhmZL6rMvpzAY/wqmC0rE/BFQKZdBBdrzX8xxwfMc+
    U+mQlynQghN1ecHl5PAet582zfLXZOFZScWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :content-id:mime-version:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523501094; bh=pa0HO
    B0dJ80P9qBdeps+m/N/TBpqfDwCt75Za97odsk=; b=DKax5VnJ4Is1fIlTuTHYy
    +Y0ACIJ+sktm9vU4GhvFhncMcZd8/q0hu8pMKHktI9Y0Go+wc6WtfXWFCK/iBBcD
    0PYmhVo0Nx1OgXjQP2zHwnpBLkcDA1P8tVyg+Y6VJSwjuxVd+IlNMsEjBUgmKiKq
    5Z0mAG30Ur99+OHXQ8iWOUHPoSuh2ewc9wgDZO4DwWDAiMGFCgL7uKpwTvYwS2QY
    YufZBzaX142DEPT19SzGW4sQCCNhGriUVZEUv4BSNMPR8LiK9z+21Ns/97XQ6dl1
    csJN8mPdDJUevHAKPFS9rRIgXy77Qs/E2DEOBv4cKW0Rmj+V6wgbCKMeiD3CgHoD
    Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NKstg0D/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NKstg0D/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIcCS2KISidbGXU/LNnxdXOTabHhxc6OszhiOYY/NAtf/gJ6tchxQ4/MgcDeiv1dCAERFKuh9hU2vtNitlbIEDvzqYbKjjv1aqGe7xdCWQl1Lf+qUTQq
    cedmB+b+8apsORFHgzuasXVIe8bP/ouLJPxepamVE5bkT6MZvTJ8w0M1cc50daIPvzFSw7NJy9F6GLthiddRhYe1vZ6H3xfz0rbYDfL8qizMnogdu6yRyfot
    UA3vbxJBne5JVqn0uB/eNw==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=R4fxTKrshSIA:10 a=tRVwWPG2asMA:10
    a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8
    a=1XWaLZrsAAAA:8 a=DDOyTI_5AAAA:8 a=UTXK74XPGfO0bhJ49ZAA:9
    a=lNRaUB8ZY1ejgKUP:21 a=4p3B-Gx5wS2Wx5AW:21 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan
 Cui <decui@microsoft.com>
Subject: [PATCH v7] Revert "PCI: hv: Use device serial number as PCI domain"
Thread-Topic: [PATCH v7] Revert "PCI: hv: Use device serial number as PCI
 domain"
Thread-Index: AQHT0gg1KkzwJtR5pkqCGCt02NQD2w==
Date: Thu, 12 Apr 2018 02:44:42 +0000
Message-ID: <FE7CB779-F2C9-4967-BCF1-A0DFE846B2E5@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:3::636]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MW2PR2101MB1129;
 7:pkDsj/movWbFQXDKdb43toC1EB0xDSmwFJ66LHuaiUbV6q8dcnpdj8JRRATsOqQHfGgaa5KviMHvxpwOABLOiYbKdeGpgaI/sOgar5GZTXwP/9ppVKuTmWlSkqk/PtdOAuKnJy5DhW3gkwP0aG8cfJxWiLZJ181Rq1qxNOpZKUxEBhIN9cLsm+xhXuXtDk5DUY2Ccz1h/SULEH+hSHbSGFrTRXzwG9dYJz9NOQwIgQhhAKoadw7z0ZpJQXbskjGh;
 20:rYutecjHYefXDfjaspk47hkgq/NosUvSpF++yK9QxgHWrtve2UcJuC9+2iLtYfyfdchTtsf5DjT/sUlwh9lRimAmc/uFckorHe3dGHJRMe220/0xKN84EIHiYVMnSTBEnr0KjdGONeYkC3aeRyfJ2vS2WppdnPVxuwMckrdNZ6Y=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(5600026)(3008032)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:MW2PR2101MB1129;
x-ms-traffictypediagnostic: MW2PR2101MB1129:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sridhar.Pitchai@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1129CBD739A0BA3E5A85F356F6BC0@MW2PR2101MB1129.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231225)(944501343)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011);
 SRVR:MW2PR2101MB1129; BCL:0; PCL:0; RULEID:; SRVR:MW2PR2101MB1129;
x-forefront-prvs: 06400060E1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(396003)(39860400002)(376002)(39380400002)(189003)(199004)(40224003)(2906002)(102836004)(22452003)(1511001)(105586002)(82746002)(99286004)(53936002)(5660300001)(6486002)(3660700001)(5250100002)(10090500001)(33656002)(4326008)(46003)(86612001)(106356001)(486006)(3280700002)(6636002)(97736004)(6116002)(8676002)(81166006)(6506007)(2900100001)(81156014)(6436002)(8936002)(316002)(59450400001)(54906003)(2616005)(25786009)(186003)(110136005)(6512007)(305945005)(68736007)(86362001)(7736002)(36756003)(14454004)(10290500003)(72206003)(478600001)(83716003)(476003)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB1129;
 H:MW2PR2101MB1129.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <CDE5DAA364DDED4488D6F9E472500412@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c30bd467-46c1-47b9-8870-08d5a01f5803
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c30bd467-46c1-47b9-8870-08d5a01f5803
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2018 02:44:42.2579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1129
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Michael Kelley
 \(EOSG\)" <Michael.H.Kelley@microsoft.com>, Jake Oshins <jakeo@microsoft.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When Linux runs as a guest VM in Hyper-V and Hyper-V adds the virtual PCI
bus to the guest, Hyper-V always provides unique PCI domain.

commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
overrode unique domain with the serial number of the first device added to
the virtual PCI bus.

The reason for that patch was to have a consistent and short name for the
device, but Hyper-V doesn't provide unique serial numbers. Using non-unique
serial numbers as domain IDs leads to duplicate device addresses, which
causes PCI bus registration to fail.

Revert commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
domain") so we can reliably support multiple devices being assigned to
a guest.

Fixes: 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
Signed-off-by: Sridhar Pitchai <sridhar.pitchai@microsoft.com>
Cc: stable@vger.kernel.org
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

---
Changes in v7:
* fix the commit comment. [Bjorn Helgaas]
---
 drivers/pci/host/pci-hyperv.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 2faf38eab785..ac67e56e451a 100644
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
2.14.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
