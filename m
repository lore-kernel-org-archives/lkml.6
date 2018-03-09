Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3755284-1520571764-2-18415110974742041366
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520571763; b=MoonrQitIo4MTCGUUTuhzpcEwS6wSkQy9nwFItIf4EfMl9E
    azWbWGlBnI7P5romBPcn1JrJhub9x4pWBg8BS8et4pGgT5yzU4EOefCgeJdGboqE
    FWvupXtZZJ6Ms6hCQl70WAxhqbl/u1oDSi9x6wdEdKgQt7yrTNKT7uk6mBmRQjQh
    v8ddB2gOZifW5MLAgaRJnYk8PEc2hd3+6le6RNlO60hkx2HyUs53XGJaPJRi2Qxy
    ysBOAYZJWtTt9QL7LnrW8Veucqz6vbbqtNQo6aUtSJViZ8pq/EVrdMdxHuPsOBRZ
    rRGEpWIHEEdvS1c59f4ABT8Ua71VSKfq9Y/tODQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-id:mime-version:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:content-type:content-transfer-encoding
    :sender; s=arctest; t=1520571763; bh=S0USK5/z8oS+tGSbQ4Swi6/Pzco
    f5Os7K86kfhR6mhs=; b=jq6kWzz/uEm6Ng+HcR+3nyiUK5DDPAHoK18QjSbIOq8
    QyWGWz59oViS+hQ3ID/jfXJRPyvnTRsV1XLVTKi1IOi3fRe2RDLrZRNZZxvOHWBE
    6pChUpLvU2Kj5kBvbf95wkV6a4UGIoR9Tf9T+5Ty4ziOrH3R2DOsKa0bR8wQYtMG
    e4oZzP68+l6lJBEuetF3JeMyEFtFYq7pqL/a4Gq5rrlglIADhzSYmXXb4+L/hDUn
    0DBqcaD5kJJXRhA0181a/apG9Q/N1otX5MTbGoZMmnJYieGxMHFJDfmuXvZBZ5Ng
    X4NKZX0SgQZ/+HflbL3TEvBOvoFvsPqLu3srWMRwzuQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=So/mwaUE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=So/mwaUE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Jake Oshins <jakeo@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Dexuan
 Cui <decui@microsoft.com>
Subject: [PATCH] PCI: hv: fix bus domain ID corruption
Thread-Topic: [PATCH] PCI: hv: fix bus domain ID corruption
Thread-Index: AQHTt2LLU4f2U+zlPUKLwzS9FiUhSKPG0skA
Date: Fri, 9 Mar 2018 05:02:34 +0000
Message-ID: <19EE9647-AE9B-443E-ADBD-51CCEFC3EDEA@microsoft.com>
References: <A9BC9573-36AA-4493-A086-F99F9204BEC9@microsoft.com>
In-Reply-To: <A9BC9573-36AA-4493-A086-F99F9204BEC9@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=srpitcha@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-08T21:58:55.7326370Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [98.232.109.128]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR21MB0779;
 7:3CzSf+Xdi0jw/K+IydLdSEnaZ3Mxak6GJXOWIcT+CfVddsbcCTVVcsbJf6LqtnL2i0DPBqNEsllVcJeFsL8bZpJpAykSDKa1VgnxSsNBJK2nN4WLl4vntz8OC1ewOxtkfssZUaWwSJ1AicCF2gItK9B7mbKwgudrmTZUolvYffg6CXsDqImSQTXIghgMRovw28Qw9hfcvJqf9F/HU2a25numrDJfnQSXOZlIfK98hZe4JXdmdHyhlAZH9pksCeG5;
 20:turHkGOtrdYYPMqk5INLzT8RT1E195j8AUO1yv6Ta02AoFRVOSyxeLl32CNAxkeKrmlDoqnzijBXv2sJMhessD/+0XGTXgBadjmcKJVr6MCG48ZdeBIpq6Lx3+/sRQVberAUBKt22B+GEle85rDG8JPc2nBWupl87i4hBAucm6U=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 26983074-eaf4-4acf-f70a-08d5857af8be
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:DM5PR21MB0779;
x-ms-traffictypediagnostic: DM5PR21MB0779:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sridhar.Pitchai@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR21MB0779538EC74528FC0AA35B26F6DE0@DM5PR21MB0779.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231220)(944501255)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
 SRVR:DM5PR21MB0779; BCL:0; PCL:0; RULEID:; SRVR:DM5PR21MB0779;
x-forefront-prvs: 0606BBEB39
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(39860400002)(366004)(39380400002)(396003)(189003)(199004)(40224003)(36756003)(10090500001)(4326008)(25786009)(106356001)(68736007)(6436002)(6512007)(82746002)(5250100002)(33656002)(6486002)(22452003)(53936002)(186003)(26005)(59450400001)(102836004)(1857600001)(66066001)(316002)(6506007)(86612001)(3280700002)(110136005)(54906003)(105586002)(2906002)(3660700001)(2900100001)(2950100002)(6636002)(99286004)(1511001)(76176011)(97736004)(8936002)(86362001)(14454004)(7736002)(6116002)(83716003)(72206003)(5660300001)(81166006)(305945005)(81156014)(3846002)(478600001)(8676002)(10290500003)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR21MB0779;
 H:DM5PR21MB0826.namprd21.prod.outlook.com; FPR:; SPF:None; PTR:InfoNoRecords;
 MX:1; A:1; LANG:en;
x-microsoft-antispam-message-info: jYdXnDZKtj39+RhQLdYjVfkhqM0NaeME0saGPELaeMBpIaR4swpydMl5nPkEwaeMi9DH2u9JQVZDtZwKXEwcOCslKxblZ830LwthhKh1zt1Je0GXlzYid8cYIZiKu4C866mBFcq1EvuN9C3KdGWdlye+NoxGPFxSY4cadEXV4C96zB56cy8xPAoxPSb/IOJk6/s0tcDa0Kl7WMm32yNvMe2L85uAwTMAgtZXH9Ft7RZZCqaUJrE0k6IiceImOfme/hapl8cLwVOjkHiNh6o9vCg5/xMLGiCqab6BLqrf1HCbNLasNnoHWUCzniYNo8bkK+GQz0slCFmOq/tGOuggVA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <5CDB13B82B129F48B3D574DF9F2EE0F9@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26983074-eaf4-4acf-f70a-08d5857af8be
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2018 05:02:34.7571 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0779
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
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When PCI BUS is added, PCI_BUS domain ID is set. When PCI_BUS and a device
added to the bus is racing against each other, the first device tends to
overwrite the domain ID. In order to avoid the race, this patch make sure
when a device is added to a bus, it never updated the bus domain ID. Since
we have the transparent SRIOV mode now, the short VF device name is no
longer needed.

Fixes: 4a9b0933bdfc("PCI:hv:Use device serial number as PCI domain")
Cc: stable@vger.kernel.org
Signed-off-by: Sridhar Pitchai <srpitcha@microsoft.com>
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
