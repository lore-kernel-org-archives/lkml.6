Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-24197-1522439473-3-16842201939848955957
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522439472; b=l+c8WGKZA4dEhgkQi7z5b94SKiUTYRY5TQa5z7KZ7OTu8kulet
    Jcacwd93P2I7ztTOTxONG9NT1Vq0dVuQu9jfWpJNQCh1xbc4dKA24Cm0OvX+CBMG
    iYO52yjykE7w52OQaUSjllLD9ED1ar5rZQaM1Usu99l42b1nxB5YgVDmsHEuSf9S
    jdTJWohhsFPNiSYDHhxoSag2pVNtbxBNU6tckynve3kGyb6J9Pr+s3K4a2eFdBbt
    BHDQDNO158tebLWSs64FliQtva3tnEBGfiLcj2Wi7yyE0Lr3lNzAEVCt7S10k6hT
    purTNB89l+kC63RqEyGP7Z7v8PhewK4Q7S6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-id:mime-version:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:content-type:content-transfer-encoding
    :sender; s=fm2; t=1522439472; bh=nW1Yit1YDJnJjIeUiJMtsnH6n77hfSB
    ZlzPOB+YWwCY=; b=kXkKaihsrZselTcVy8/2/Y4alG9vGysb9xPpXANrs284Or0
    7+VIyXNHF4BT0u10nsuUqDX6he5a/yAjLXquc9vk8LctYgDXD1tma4pgZj2/ztwH
    bzUU5hcbCMm6YOBmyGkdaBOy6IwSpPzrNkMtJ/5nRt+lH95eI5qBN2xY/XRBXZj9
    7NuikJHuMp3GZv9jNNQPR+VslpGBot2uR3utt+74/5TlTin6MS86ffeNR5UxLFol
    EVR/4wzaHxhRvLU4N9c7oC3fbqKcH1xOfS8ssltMb9s4OutwKsgz+l61ksWINfCL
    DGJ0keXDpuUjPFP0FzCq2/rdGDx2Do+zS0nz0IQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=obnhib7y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=obnhib7y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFPsP+k17Ro/Pg1BkHw6Arhd0o6jD8OWsR1BlJ/YK5lvSZ0OvipeQvZZ3cBJRc+XiLfKwkkwZppJe9V24VvTiEP9UiByihNGp5PwQpCMSmig+D8z6JxP
    d09xBvVmn9pe/C5+Ew1n8b1xIzJuFObaGIVts1XUB37Ep7rPsbNlaD1UYN4ArYI6PpV4L8/+rCH+MFLZZxMHRZpMDtHOquUwR/RUoxihx4+54hHKYWcfOO2r
    bFnwcsXHzQFKoN1ucxYsDA==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=R4fxTKrshSIA:10 a=5P4-rgDjW2YA:10
    a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=v2DPQv5-lfwA:10 a=Lf-vpJhqX20A:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8
    a=DDOyTI_5AAAA:8 a=W9lyDw0V9Tm9_RxH-FsA:9 a=fHbMwK2xZQkNtVtp:21
    a=xHMWVowt6yiqx8h0:21 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH v5] PCI: hv: Make sure the bus domain is really unique
Thread-Topic: [PATCH v5] PCI: hv: Make sure the bus domain is really unique
Thread-Index: AQHTxSijoP6WPdZS9U+Gegx1alv9bqPovLoA
Date: Fri, 30 Mar 2018 19:35:04 +0000
Message-ID: <105A3FAC-23AF-40F9-8B83-F00DED14EC43@microsoft.com>
References: <4BF97B43-5339-4750-9704-23D6AAC4A01E@microsoft.com>
In-Reply-To: <4BF97B43-5339-4750-9704-23D6AAC4A01E@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:a::625]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR21MB0123;
 7:vNkCMJXrRP1ovRFBIdIZtPyLiDUwoCsamGfbjcUhvJNuNrXEDVQw+NWK4N+Ngxuuhps+tvs+p92Ua1JMq/FwkpL0Zt54yQKYOjtgfbQhMinPo4TwrPtqDoat1z4vVNDzsb/1d4oK8xKaJPc73OZCMSmaBPJxx4ybTiqnYdJNoTWHa2L51cZBM3Y0gOIW+tknzeKopjmt8er+DMYfPzq1MUayVoYaKXYt5XtoHH318FB2lUbnwVan6k27qbkDsyC9;
 20:kXFIhCb6DBvqKJzLi7pJa0m2ZCAMyysDnvZ7zUG2kvIoV8hulPAGprsb5cFQ0TIjyxHmtSpUoSSqFrGlYhMO3QWUOwcQWFv3dnYEO3yn2Cr1y34YsPzi3+awzLI7jz8Dqz80I3bL9lE2Ema6N3TF6zgS9Rd4tmTx2TSwMO4HYUM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 639a8849-2ce1-4a50-bca1-08d5967556b5
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:DM5PR21MB0123;
x-ms-traffictypediagnostic: DM5PR21MB0123:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sridhar.Pitchai@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR21MB0123772A648074CA714287C7F6A10@DM5PR21MB0123.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);
 SRVR:DM5PR21MB0123; BCL:0; PCL:0; RULEID:; SRVR:DM5PR21MB0123;
x-forefront-prvs: 06274D1C43
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(39860400002)(376002)(346002)(39380400002)(189003)(199004)(40224003)(6512007)(76176011)(97736004)(46003)(53936002)(3660700001)(6246003)(5250100002)(7736002)(1511001)(305945005)(6506007)(83716003)(81156014)(81166006)(86362001)(86612001)(8676002)(486005)(11346002)(476003)(6636002)(486005)(102836004)(8936002)(446003)(2616005)(186003)(82746002)(59450400001)(229853002)(110136005)(54906003)(14454004)(25786009)(4326008)(478600001)(22452003)(36756003)(316002)(10290500003)(5660300001)(99286004)(33656002)(72206003)(3280700002)(2906002)(105586002)(6486002)(106356001)(6436002)(2900100001)(6116002)(68736007)(10090500001)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR21MB0123;
 H:DM5PR21MB0826.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
x-microsoft-antispam-message-info: LJbTpWjhsPzbMXxJ8mKygzxhXGakLh/0cPfyRXkPi3YN/opssuwJ3dqOG8AbUJ+bC4i1iKSoH7ES41Cnblzso3GbA9rnI6E6zjM3irS9S45e+Jz2FxlCxxSDkr179CVKZQrXUbQFshuoEh4Pa/p9nlxJjYn0PYrMbTL8sSN29IX3tcy8RASYGJrR6pGa4QRWeccPWssq/Sm7u9HvZZIpkSUVCI+Y/XaCq8vj/R3+FN9npqnlnRbiSE0wSP4UaQAMuJlChi2KM3r5yRsyNSlz+Naqgw/2GYa0UFyuGhX8VshZXXnok3Ql1mR9aMqgM+nA6WqUothPw/3c13PuE0C3IRSMw/l+FsIcB9xGoolOMxnXOB82PnNepaZv3Jg35L98WNottpxszKODMCYNXiOk+7+nv9ZWlAU5e1IhfJVTZf0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <FF499C56F5D02B45A29016340960282A@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 639a8849-2ce1-4a50-bca1-08d5967556b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2018 19:35:04.9651 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0123
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

  >When Linux runs as a guest VM in Hyper-V and Hyper-V adds the virtual
  >PCI bus to the guest, Hyper-V always provides unique PCI domain.
  >
  >commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
  >overrode unique domain with the serial number of the first device added
  >to the virtual PCI bus. The reason for that patch is to have a consistent
  >and short name for the device. But commit 4a9b0933bdfc ("PCI: hv: Use
  >device serial number as PCI domain") will not guarantee unique domain id.
  >For example, if the serial number of the device is 0 and there exists a
  >PCI bus with domain 0 already, this will cause the PCI bus registration
  >with kernel fails.
  >
  >commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
  >domain") need to be reverted. Also, we no longer need it as commit
  >4a1626dd233e ("netvsc: transparent VF management") remove the
  >need for it.
  >
  >Revert commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
  >domain") so we can reliably support multiple devices being assigned to
  >a guest.
  >
  >This revert should only be backported to kernels that contain commit
  >4a1626dd233e ("netvsc: transparent VF management").
  >
  >Fixes: 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
  >Signed-off-by: Sridhar Pitchai <sridhar.pitchai@microsoft.com>
  >Cc: stable@vger.kernel.org
  >
  >---
  >Changes in v5:
  >* fix the commit comment. [Lorenzo Pieralisi, Bjorn Helgaas]
  >* fixed the patch white space.
  >---
  > drivers/pci/host/pci-hyperv.c | 11 -----------
  > 1 file changed, 11 deletions(-)
  >
  >diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
  >index 2faf38eab785..ac67e56e451a 100644
  >--- a/drivers/pci/host/pci-hyperv.c
  >+++ b/drivers/pci/host/pci-hyperv.c
  >@@ -1518,17 +1518,6 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
  > 	get_pcichild(hpdev, hv_pcidev_ref_childlist);
  > 	spin_lock_irqsave(&hbus->device_list_lock, flags);
  > 
  >-	/*
  >-	 * When a device is being added to the bus, we set the PCI domain
  >-	 * number to be the device serial number, which is non-zero and
  >-	 * unique on the same VM.  The serial numbers start with 1, and
  >-	 * increase by 1 for each device.  So device names including this
  >-	 * can have shorter names than based on the bus instance UUID.
  >-	 * Only the first device serial number is used for domain, so the
  >-	 * domain number will not change after the first device is added.
  >-	 */
  >-	if (list_empty(&hbus->children))
  >-		hbus->sysdata.domain = desc->ser;
  > 	list_add_tail(&hpdev->list_entry, &hbus->children);
  > 	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
  > 	return hpdev;
  >-- 
>2.14.1

Hi Lorenzo,
Did you get a chance to look at the patch v5. Please let me know if
anything I need to address further.

Thanks
Sridhar 

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
