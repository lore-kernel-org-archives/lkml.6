Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1535057-1522085656-2-16818977562789371693
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522085655; b=oBlBoY4oK61FCe+YbzBAU8lBk9kD8WkB0oLayV6fTDmrlgc
    D6/kP2f5rXaX5XBLUpJbxMhQ+mQB1efMpIyFdtAlLCy8vAmMnDHjS+8DC5ySXbl6
    TdEwmot12SRK/PPNQIJofbLZdtRiPq6B0I0by0t4LRZlFyz7CiKfGPgEY5qPagYD
    sq4m+VG8ITrI8Fqk/PgYb5yvR6LLbHHmqwYuhMAlNk5x/WspkkIb+pDGX2hzz6t3
    NmpEMD8XffJd4tLs+DwBW0/ZRHU9hxO8hPwchXqh8l72ABNTD/NBt6JMJPZnq8da
    kfPib6uRDxlMotsRTLN+DRWg5/Rc5lYmOhLMUvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :content-id:mime-version:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522085655; bh=j
    l5pECkkkabU/yJ1WMj4FnLKtZrKFAw4o2RnxxA/yiM=; b=MG+e+gCyaWch71URw
    iJTg+3UOz59XuMYtsKaFXrjpDBe9d+7gcaNAUAvZ7DQGK1ccnFlAkD1Fg2aZsy+7
    /FKHzwvFhCJNYWjo6fLwiwO9YdGxsaF5gI8ylm6CLsYYKR87y8S1/FO6MTl4wGi4
    X4qhndYpJs2azaN7OUvjgivS8Lba94saqt5hy25nl50awkINNGsLRKMa7H7xHPSP
    mGDkXbb7LKIuKXt48I7U9f+Um93+yhpUo/GXLSWR6E02khZN+tocU9d/Pt+a7SlX
    N+KXtgEqfEtxR9JxOx6t3kgrgN6H8TR53v9e7C5CyeuIkF09vwDKWL6rl8S15K77
    B75cQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iVdIY/XH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iVdIY/XH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIvN5q1r2F0sqU8074v6NmRdAameGsmUJm46gIuRvqE9wufZIfGgA7+vENdnIwDSqljBxkHW1ecHAkmyLwnHibHumPpxowg6lBQaYbrVR1+Tl9eUWmjf
    0Qt5JKYgrQQg/nLslTVCO44EQI7pLf/TIKTcSnlSwvcMSMcKjlwFrKzE5ZXNdb6rDdWAzHWc9VNsHBkOqfHHKZf791/ySPnWpltroHu06YeE2Cs+2cb+gMeS
    UBWQBMRho0iunHxQ3B1Htw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=R4fxTKrshSIA:10 a=304C54EdYA4A:10
    a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=v2DPQv5-lfwA:10 a=Lf-vpJhqX20A:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8
    a=DDOyTI_5AAAA:8 a=TJwFz8ZtrAjXZAKalxcA:9 a=OoFXV0ZVjYguGQTa:21
    a=c-QSpngrcT_FAKKh:21 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH v5] PCI: hv: Make sure the bus domain is really unique
Thread-Topic: [PATCH v5] PCI: hv: Make sure the bus domain is really unique
Thread-Index: AQHTxSijoP6WPdZS9U+Gegx1alv9bg==
Date: Mon, 26 Mar 2018 17:34:04 +0000
Message-ID: <4BF97B43-5339-4750-9704-23D6AAC4A01E@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:2::57b]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR21MB0505;
 7:0HEhiJZoQYHciQ7Hsm3oViFG0jaemVCPKy1pljrocAz6SvztunOM1UBY6YBv92p3ZQ/Ao8y5PK/YSUML/zd46D+kzjcMuZxYRSVX5xQXOJ5eQcc7AOJ1uuvNCjsIiAyqi0iOQPYVyt/GSbwY+Uw34ACzISNjsGGF+fSSiz3YmCJxf+mV+E0Kuk1c9oyDMoxFVv4Qz25vjv+ynTxtLPMMRwygmw4IKq7mO2ZMiyjNc0ydEhXv5EzlwnNRnHwTrq+D;
 20:qsQpaQMWaiREZwZR4AdPVBHTXnhFv6ubJdO6TADOKy17MjMhaeuNBWCrERkTHYBOmKx1LsdWwVyggo8OHT6JcsEfzEFd6tvNb31YWwE5maRFhAy8hIbKFTMQ28+HrHZv8FOmksPsUdFPXb1kZmHt28C9YLJU2zYNyGL07d9qtUI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c59d6fb6-7a58-4234-45e9-08d5933fc5b5
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:DM5PR21MB0505;
x-ms-traffictypediagnostic: DM5PR21MB0505:
x-microsoft-antispam-prvs: <DM5PR21MB05059ABCBBD079887CF319F2F6AD0@DM5PR21MB0505.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);
 SRVR:DM5PR21MB0505; BCL:0; PCL:0; RULEID:; SRVR:DM5PR21MB0505;
x-forefront-prvs: 06237E4555
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(189003)(199004)(40224003)(81156014)(6116002)(106356001)(6346003)(8676002)(10290500003)(102836004)(2900100001)(97736004)(6506007)(53936002)(2906002)(54906003)(68736007)(22452003)(83716003)(486005)(486005)(10090500001)(86362001)(6436002)(59450400001)(110136005)(3280700002)(105586002)(2616005)(186003)(99286004)(478600001)(8936002)(72206003)(6486002)(33656002)(5250100002)(25786009)(82746002)(6512007)(5660300001)(36756003)(46003)(305945005)(6636002)(86612001)(14454004)(4326008)(316002)(7736002)(81166006)(1511001)(476003)(3660700001)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR21MB0505;
 H:DM5PR21MB0826.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sridhar.Pitchai@microsoft.com;
x-microsoft-antispam-message-info: wTzRVhcUTrZKzQesBFx9+2G/c4wrv5UMvbBayxS7ONczPHrB6rL4h8bFtnU5k/pmEnR8CYJEA0s1plMnkQOU4vuOHitv7pcpqLbkK2JOS07eQ3oqEJspOy207PJITUf9Ui4lqgMqOlWGWU6WEVB25ncS8TG4beWr1oty92w42qJ/C19oBK9oTUXpj+4JayQgHy2SEMtTHfTOnE+SkMMCsGig8UcW6EmIbec8WoZ4Q0Wmr1eFp+thggbnVLkrvvmyq9MrYUQAwp7TG0iQw09Kjdn3vkL/Bw21DqXZK+9gVGwu7S4zgdplEk2NPrDm4qKFBSQIzpBSL1b6dm04TBj10g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <D41D726659399547827459B242A9D37B@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c59d6fb6-7a58-4234-45e9-08d5933fc5b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2018 17:34:04.9815 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0505
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
domain") need to be reverted. Also, we no longer need it as commit
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
Changes in v5:
* fix the commit comment. [Lorenzo Pieralisi, Bjorn Helgaas]
* fixed the patch white space.
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
