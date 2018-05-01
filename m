Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3459038-1525197403-2-4371542235675580207
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525197402; b=ZILmWHuZTuoEerYyy9XFuC4O4xCch6cwEqGCcg08SbMDyeQ1xC
    yhXyEde6t06rbM7tFeCCX0pDts4hk3yCtnVLSIVosbiECJXkUlGPklzAmGhpm75V
    Ce2G2hvUr/BVD8O0NtLJWYjjsTknPcVp+lHFhmLBA1vIQuzb3UssA0ALAp8u/ZPf
    eyA5+JIhuT7B7/BzHFDzfDx9lMAfF0e+5Zx7jX1XjX2fP9lntDT6iIXrc+XhC8b8
    svc5j4tM7iHluTtULN6OwMcNBYyzHgve2Nk0oQHEnS+CR3ZdjyX1KrlA7G1rVxGQ
    fdJlCol9jGbWBgIYRQSUO1mc5VP5HVyKkQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :content-id:mime-version:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525197402; bh=l9dqR
    e/SfOIFXvu2e7vJDRYT4suhto4X8g9a1NtdhFA=; b=b4/VwK2H6HCfRA2clvksM
    rEZkZr5VLMcxwe4UjMkDkg57Q9B5Q3Mt4JzQzDnUeoGfFUyUcaZhsZ/wSNtbS+3F
    drCKVoFzvKbj6mr9oUBAFApIIHB15DxBKfGVIR76dkOkpL8n2m9s34ctJpWt6Eoq
    7BRE2NsNbz5/FJBYvQJm7l85lDQHcyVElqkBkU0XN9t0WxYkopE6VKLeAhPqVXWf
    RTqI4QrdCsrIYzGKOg2KAT/lk43WYJhML0iaqFbJliW7pDlk/4qBneHjl4qLrfAo
    X18xX6pr1U5XCtZaa/yVI1gzCD6syN6I/jmOPHvpWJ+UGSkJUEn+4V/EJe4bZ8A5
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=microsoft.com header.i=@microsoft.com header.b=ey8gunLX
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject)
    header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=microsoft.com header.i=@microsoft.com header.b=ey8gunLX
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject)
      header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFHe18qyPA0fGNTLhpN0qK3jnN8Is7kdJ5IahxGc83fz1ZI5AT9WkCBIF6/ymszRcQLzZYAGJH+q3agMPiZ/uxI2SH3ELXK6wTzWyzL9yggTxNUVwYdD
    HIF7dF8zYMt4rd+vQLQNPJPtaoSSZfbUajiioqoQLcdNfPO40NyjNApqjchKcHn6Xn3ImHV4ZcbslLS8gS2L6pt3ArqmKcyv3qD7G/32Qr5F7mG3j/9VDP6q
    NaPwM8Wl7ay9GYEdwyvLlw==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=R4fxTKrshSIA:10 a=304C54EdYA4A:10
    a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10 a=Lf-vpJhqX20A:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8
    a=1XWaLZrsAAAA:8 a=DDOyTI_5AAAA:8 a=E05CELBOWN7fx6KoF4EA:9
    a=xjJM6qDijdXpazZZ:21 a=CuTTMhsHWNG5koq-:21 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas
 <helgaas@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH v8] PCI: hv: Make sure the bus domain is really unique
Thread-Topic: [PATCH v8] PCI: hv: Make sure the bus domain is really unique
Thread-Index: AQHT4XW9UqJ7Jkp6U0uFDTB4E36PZA==
Date: Tue, 1 May 2018 17:56:32 +0000
Message-ID: <6E619990-8EFD-4688-8C01-8D9C480B04AF@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:f::1c2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MW2PR2101MB1099;
 7:r4gF9UwzGBV3PC+SWW+hVr6AhiicSbPhwLGN0xRi82sJ9FeQeM5FVGzd5V1LadtLJdxtmIyvriwQ7ZyVwSIn8iV5ej32gk9aHVAIQ19ddG/dPazq6QaChecta70kbkKjPnFyROnLjTDhsXmpSzoIuqMI/ypWnDSGIwUDf9ZIDhap+eIRTB2KwuJ5MAn5jzw+GFLoZuHUlPK4NqOXnqHkBHjacv+56o/vhemOVN9n4mBumEYeZmZb/b6yBcPyewM8;
 20:kylQZryZx0gO2AsmoaP9LBo89vjapbSPmOclXur6YvySOGjOVPqCdZJQQ/WywufQQNWDAtsJR1ygYok5J6CQV9K2BaNVq9/bs0ZvxZ8N82PSba2qZ8LCGoD62RxH0nUA8FyKT2XfLvtFkh85n976guA+jUR3DCMhRyZONE+PG88=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);
 SRVR:MW2PR2101MB1099;
x-ms-traffictypediagnostic: MW2PR2101MB1099:
x-microsoft-antispam-prvs: <MW2PR2101MB10994A6486B92AA9D9BDAC6AF6810@MW2PR2101MB1099.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);
 SRVR:MW2PR2101MB1099; BCL:0; PCL:0; RULEID:; SRVR:MW2PR2101MB1099;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39380400002)(376002)(346002)(396003)(39860400002)(366004)(189003)(199004)(40224003)(68736007)(53936002)(476003)(486006)(25786009)(478600001)(110136005)(83716003)(2616005)(6116002)(4326008)(6346003)(5660300001)(10090500001)(82746002)(3280700002)(6512007)(72206003)(7736002)(3660700001)(36756003)(6436002)(5250100002)(316002)(10290500003)(2906002)(305945005)(86362001)(102836004)(106356001)(59450400001)(14454004)(2900100001)(86612001)(186003)(22452003)(6486002)(81166006)(81156014)(46003)(6636002)(54906003)(99286004)(33656002)(105586002)(97736004)(8676002)(8936002)(6506007)(1511001)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB1099;
 H:MW2PR2101MB1129.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sridhar.Pitchai@microsoft.com;
x-microsoft-antispam-message-info: qenF3yBaaaznjB7ExqadAPJdip7XF1V+vF0thw1eG0eaZx07A8DaMSSblKcpRkdeMdophTYdchdto1VsB8qmk7fSHm1sQw0WKM2usw7JloNxIOQDRGNdjBUQQqK20WoUD3kUzxZnMGR5P8UiO3h8QA5LzHL0jNgpOko3Er1d62jXcMm4xjFMJd46VevbLzvY
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <6667E4737E0DD1448C27962E5F21DE33@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f5bfb20d-0465-4ca1-3e08-08d5af8cdfe1
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5bfb20d-0465-4ca1-3e08-08d5af8cdfe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 17:56:32.8218 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1099
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
 Stephen Hemminger <sthemmin@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
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

commit 0c195567a8f6 ("netvsc: transparent VF management") avoids the need
for commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
domain").  When scripts were used to configure VF devices, the name of
the VF needed to be consistent and short, but with commit 0c195567a8f6
("netvsc: transparent VF management") all the setup is done in the kernel,
and we do not need to maintain consistent name.

Revert commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
domain") so we can reliably support multiple devices being assigned to
a guest.

This revert should only be backported to kernels that contain commit
0c195567a8f6 ("netvsc: transparent VF management").

Fixes: 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
Signed-off-by: Sridhar Pitchai <sridhar.pitchai@microsoft.com>
Cc: stable@vger.kernel.org # v4.14+
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

---
Changes in v8:
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
