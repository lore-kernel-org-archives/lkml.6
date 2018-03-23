Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1673992-1521822472-2-17298571521783859386
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
    t=1521822471; b=CJDgOVn2xUjjSc0aOVzrRps9AKFef/3Xym/uRSDSloCHWMl
    6zeVAU36FdgwjiUfZLQdsQViEHHbqkGgbEnzU1AxXmnto2UZ9A6Vins4TpyRiNc9
    gYN/pbC2G/7FbDw4kd+g5jICReKkowjobRw96RnfWpSTWpxQ4ILFZ9DkFNqOag2F
    bCiff6MwoxDJ2p7TwSV1K5u2WQLpEJz/XNZ9tqCTMveFUpLynqqA2fflIDlH8i1+
    jO1wOdvNX2+osGI9WuHoupKzZl6IEJw/XiLeZ2JUToov8TCIsqCj+Zy29W6mPila
    O40ogGLW/yZFvsF1Bv+kLfDuGiVFQvTeh1qdpTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :content-id:mime-version:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521822471; bh=M
    eSQhrPH/XuzBKdoIbjfO9FPILt5Prrwmv4iaURXXTE=; b=DxGDSmn3FoWaS8vrM
    4E52EdGIaNkqGicRd3U7JbTSaoN51C4ywvR8iE4CxLdzjwnMvkgi97qJO5LEksKj
    a9cm3qeYqskekokY7wyyO2fYyCztW5orHDcZJPtXlQszIswWRPC9bqcsqbg/wMeX
    HU5hgYV9G/cCMVUJvnIxQAmkJ+mVoqgc2i2adx7JCMkOUChJ6Ku1BhXB4A3yOgMT
    zzoxMd88EoAqONieTig+TW++EIYOaOfxYdRecTAaLCp3p7XHlzJsTRU8svaoRrxk
    Ch6LTg0OVOjeGakTMjHjN9A1iwmFFq70iorEnM2PWMxf3dlumMEZvLWeUmFFPVUv
    v0MfA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bCbbgyMl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bCbbgyMl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH v4] PCI: hv: Make sure the bus domain is really unique
Thread-Topic: [PATCH v4] PCI: hv: Make sure the bus domain is really unique
Thread-Index: AQHTwsHOzK3K+pWrsEiwBezyUMpMLw==
Date: Fri, 23 Mar 2018 16:12:58 +0000
Message-ID: <2C72A4DB-2108-41DF-87B5-9E438C84C3F2@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [98.232.109.128]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR21MB0122;
 7:DlwHD5Y0IYjlE/15UWQaeEsshb7AbGFCMGrzPlSP0oslPc/XIIs0/LS4iykIctdc1BRxt4aADEQseny4wPy+wqe/jKfu+t4+ATuTu9noUOMj3T4/pnXMV4xURJtBQ3Uay1qalQaABMsD87qAeK11XfzpWQfIiLSOQcbDwbQj3UEEk7vTjYMsmh31n7Ts/+OU1sfdAuHjWx2OGMZO4EuYwS73JoKjJQ7FoJE283pPM3WjYblTRB+GqA1Wo1gaS5M4;
 20:JeNMmE0psC2X+pNoqrMilUXqBoQuwJ3VZeRByi3rY0ykAyHEfNaoFE9siMq8dwE+VbmR6DxXU4/bHHp22DnPh5T6kRdqK0lBYrytd8GFdmF1u6kFgfRmDP/gMmfiyAKh2pmNvW6NSRE3YBYn1dL7gB19edMbrLRX5R4SRXs5PqQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd7fa936-f429-4ea6-b000-08d590d8f19e
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:DM5PR21MB0122;
x-ms-traffictypediagnostic: DM5PR21MB0122:
x-microsoft-antispam-prvs: <DM5PR21MB0122132C7954873168BE70F6F6A80@DM5PR21MB0122.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);
 SRVR:DM5PR21MB0122; BCL:0; PCL:0; RULEID:; SRVR:DM5PR21MB0122;
x-forefront-prvs: 0620CADDF3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(39380400002)(366004)(396003)(376002)(346002)(189003)(199004)(40224003)(72206003)(59450400001)(6486002)(81156014)(110136005)(10090500001)(8676002)(99286004)(106356001)(82746002)(102836004)(5250100002)(54906003)(7736002)(6346003)(33656002)(6512007)(66066001)(68736007)(305945005)(5660300001)(25786009)(83716003)(8936002)(14454004)(1511001)(186003)(86612001)(6506007)(97736004)(53936002)(2900100001)(81166006)(4326008)(2906002)(10290500003)(6636002)(22452003)(6436002)(36756003)(86362001)(316002)(478600001)(6116002)(26005)(3846002)(105586002)(3660700001)(3280700002)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR21MB0122;
 H:DM5PR21MB0826.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sridhar.Pitchai@microsoft.com;
x-microsoft-antispam-message-info: jJp/FhXNpI/0FUH3s1EmMFnSNaywaG5nzosouh3EyLCS/SXES+R5DyUk+05Ir7wV63nn7TbAU1Dt4iMlNtzbnSYN7ghnaHkwLh0rArYuVuLwgBYQ3j1I243p/0QC1gmqoRP4xoBYeF3c8tlxJY4O6u8TfcsD0vlVI5jHTFwdWwH4sWVOLeuWXZT2vqcZP0cEyIAD0nXtLv4Dq3QY+wWfZTFYPPcwIc/C2ygRxr70avD7rhzNnj2qb+5JQ1CUDUs5Pqijr9Da9q0qcVDKWoUETM0dxhelKrfm9YvU7muqTXwUfDAwi882Sf2VNxIEaCCSZ70Xed9DRbxB5oVmMONWOA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <01208D52E2B9E34496ABA7C2C447B2B2@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7fa936-f429-4ea6-b000-08d590d8f19e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2018 16:12:58.1665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0122
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
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Michael
 Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 Jake Oshins <jakeo@microsoft.com>, Bjorn Helgaas <bhelgaas@google.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When Linux runs as a guest VM in Hyper-V and Hyper-V adds the virtual
PCI bus to the guest, Hyper-V always provides unique PCI domain.

commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
overrode unique domain with the serial number of the first device added
to the virtual PCI bus. The reason for that patch is to have a consistent
and short name for the device. But commit 4a9b0933bdfc ("PCI: hv: Use
device serial number as PCI domain") will not guarantee unique domain id.
For example, if the serial number of the device is 0 and there exists a
PCI bus with domain 0 already, this will cause the PCI bus registration
with kernel fails.

commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
domain") need to be reverted. Also, we no longer need it, as commit
4a1626dd233e ("netvsc: transparent VF management") remove the
need for it.

Revert commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
domain") so we can reliably support multiple devices being assigned to
a guest.

This revert should only be backported to kernels that contain commit
4a1626dd233e ("netvsc: transparent VF management").

Fixes: 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
Signed-off-by: Sridhar Pitchai <sridhar.pitchai@microsoft.com>
Cc: stable@vger.kernel.org

---
Changes in v4:
* fix the commit comment. [Lorenzo Pieralisi, Bjorn Helgaas]
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

-   /*
-    * When a device is being added to the bus, we set the PCI domain
-    * number to be the device serial number, which is non-zero and
-    * unique on the same VM.  The serial numbers start with 1, and
-    * increase by 1 for each device.  So device names including this
-    * can have shorter names than based on the bus instance UUID.
-    * Only the first device serial number is used for domain, so the
-    * domain number will not change after the first device is added.
-    */
-   if (list_empty(&hbus->children))
-       hbus->sysdata.domain = desc->ser;
    list_add_tail(&hpdev->list_entry, &hbus->children);
    spin_unlock_irqrestore(&hbus->device_list_lock, flags);
    return hpdev;
--
2.14.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
