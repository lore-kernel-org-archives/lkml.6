Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-890859-1521138259-2-8316412331802457378
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521138259; b=Cqrnl15dhap8dKFM9kFBft9+TM75y8Fl/mim5L7/mR0gVe/
    0j4hmL5NSnPrKwbqEytdyg+FmwQnNjsZQnbo1lupNpPoVChYKE3OE9mOV6xpKE8Y
    P4LpEtaadb6zFE0PUUtY41RQHWQkgGTJkOTxvjxIk9vmJChKmA2Z65psqzDvzCQu
    LxNIRaTng5A9nIiO46JNu7AW/dj+9ArE3VEiFOaat2y2Gn/zyeWee2KqR7jk+4eg
    p2lNAJS8046rqI/nqpcX0iQgK22guNMEjWuZOAGRTereoSMcbaElrt31PvgwtiTX
    7x01rc8Bm3qio/UoZ+TKpLU07bNN38qRegB/9tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-id:mime-version:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:content-type:content-transfer-encoding
    :sender; s=arctest; t=1521138259; bh=hMTEMNWYT7HMls9DM2bycn3iL+a
    wI39CejT2l6DmNKo=; b=QhBqIug+yXs1UC7kQwPiUicz9yGfck3Ev4mC+IzQbwm
    eRImhwgszrysc5zGXuJ5hRE67gnXsieLjxqXoU/FQ4IFWCZzO73m/cotdh9ff5xz
    dQ1FsshubkSVcFimi4Nso0Rp5G6yInydX/wiPkqUaBBj60x8ruhsSpPXyrX0EJMg
    lGTV5iDNneyc4bsNZCxINWAVyiGHmU80/JLAFo7QuymNePjUJDH4uJOGJmeawba+
    umPY6xJajuGIc4XBdxUcGBrseg3o4HNoj1x9SkbUpD45QZ1YFE1RLCLcWoOoZsF1
    EWjCn77HekrwxegCjzcKSUVXMLVxNtoBau3Q+D4Gc+g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OR3mVAqw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OR3mVAqw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
Subject: Re: [PATCH v3]PCI: hv: fix PCI-BUS domainID corruption
Thread-Topic: [PATCH v3]PCI: hv: fix PCI-BUS domainID corruption
Thread-Index: AQHTu/D/DaxTLK2/o0CSPNG8bCOBxaPRM+cAgABaE+D//5pngA==
Date: Thu, 15 Mar 2018 18:24:08 +0000
Message-ID: <04DBCCAB-4BA7-4E05-A047-44824995963E@microsoft.com>
References: <C600E28F-E581-431E-9CD4-47C776E8E70F@microsoft.com>
 <20180315120522.GA15651@e107981-ln.cambridge.arm.com>
 <DM5PR21MB0826439DF296763A3FA861C3F6D00@DM5PR21MB0826.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR21MB0826439DF296763A3FA861C3F6D00@DM5PR21MB0826.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:6::57e]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR21MB0188;
 7:E0jNjL6uuRADbgU32CG1E/xGpSHVwixJMBr47mxwXRGOUzzlN5csVBlr1ijHQZr7me620AievHhf4MA6cGU/irV5MmRLE3UW/MYApFNWxjrOh15wnmzBRvnFw8XoMmGCPV+KWY7YdEU8Jz0y6kiN+EBBnmzTGzEyGKNWjIQYtIFGYqeScSK9f7NFpXfv3kVJeh8znu6OMiGvzfCOHoFgcCwcVPxH/tgJ4bO6W8Xv++CvpKobJswd/manO8McjmsC;
 20:kQphXELRxh5ZcK6TF24bLaD7ul41fjh3mtsZk8iawgvXnhf730l+SFLcZtQfrJjhGAh422ObEmHnnYFVB9aGW/4ZURJdYwuDWay3WI7uIAZZB4ah5IhLonGwgu3pGSAP5mHN0MnJGPeyGFFeKvzZ317vPZ1cu/x7ZmX7Eo/gt/Q=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f95380a3-0a3a-4467-028e-08d58aa1f14a
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:DM5PR21MB0188;
x-ms-traffictypediagnostic: DM5PR21MB0188:
x-microsoft-antispam-prvs: <DM5PR21MB01888183ED06673BBD81BC8CF6D00@DM5PR21MB0188.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(9452136761055)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501270)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);
 SRVR:DM5PR21MB0188; BCL:0; PCL:0; RULEID:; SRVR:DM5PR21MB0188;
x-forefront-prvs: 0612E553B4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(366004)(396003)(39380400002)(39860400002)(40224003)(13464003)(189003)(199004)(7736002)(86612001)(8936002)(2900100001)(36756003)(5660300001)(83716003)(305945005)(6346003)(102836004)(53936002)(59450400001)(6246003)(53546011)(97736004)(86362001)(6506007)(6116002)(2906002)(3660700001)(106356001)(22452003)(8676002)(81156014)(33656002)(4326008)(81166006)(46003)(25786009)(229853002)(478600001)(316002)(14454004)(72206003)(105586002)(6486002)(76176011)(99286004)(10090500001)(54906003)(5250100002)(3280700002)(10290500003)(82746002)(68736007)(6916009)(2950100002)(6436002)(6512007)(186003)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR21MB0188;
 H:DM5PR21MB0826.namprd21.prod.outlook.com; FPR:; SPF:None; PTR:InfoNoRecords;
 MX:1; A:1; LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sridhar.Pitchai@microsoft.com;
x-microsoft-antispam-message-info: niwH2ER0CkAGATyedjBSYopHfM4l+28eZ4jrOZnA19oNacozU8MTKxIRL1yFSo3p3JNDpdXd5lFFwX+gMflDdcU8mSbeGF16G3HfBeSJe1ag2ep4rMBuaSQnMNEkTADcOdJh3v7YOBPIFEWH8FoKpGFnCncG6ju2uZHRSBu+uA/+TgAo+Rj4TvgYWhWBQsDEJWra9oR03DVFr33CAUm8DieyRNsEd40mfnAEN3DZ10Zs0wCF8GxcRsQ9XBiEvbC45L9SmbUS1/SqHVsLLsjrRD8wMV788NHiplieYLCHEgK5wKvC5oDjqDRLIqAMCAJTqo/UdRR1zcRJ7bwd2uYIWQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <54D386F0F486464C812EB83AACD4DCC7@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f95380a3-0a3a-4467-028e-08d58aa1f14a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2018 18:24:08.3132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0188
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

Apologies for not aligning my reply, I just realized after looking into
the mail archive in LKML.  I have aligned the replay now.


On 3/15/18, 10:56 AM, "Sridhar Pitchai" <Sridhar.Pitchai@microsoft.com> wrote:

Hi Lorenzo,
Answering the question inline.
Kindly let me know if it clarifies. I will send out another patch after we agree on the clarification.

Thanks
Sridhar Pitchai

-----Original Message-----
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Sent: Thursday, March 15, 2018 5:05 AM
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>; Jake Oshins <jakeo@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>; Dexuan Cui <decui@microsoft.com>; KY Srinivasan <kys@microsoft.com>; Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>; devel@linuxdriverproject.org; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3]PCI: hv: fix PCI-BUS domainID corruption

On Thu, Mar 15, 2018 at 12:03:07AM +0000, Sridhar Pitchai wrote:
Whenever PCI bus is added, HyperV guarantees the BUS id is unique. Even

"Whenever a PCI bus is added"
Sridhar>> yes

with that when a first device is added to the bus, it overrides bus domain
ID with the device serial number. Sometime this can result in BUS ID not

Define "Sometime".

Sridhar>> HyperV when it creates a PCI bus it guarantees it provide a unique ID for it.
But, that unique BUS ID is replaced with device serial number. 0 is a valid
device serial number, and if there exists a PCI bus with domain ID 0 (Gen 1
version of hyperV VM have this for para virtual devices), this will result in
PCI bus id not being unique.


being unique. In this case, when PCI_BUS and a device to bus is added, the
first device overwrites the bus domain ID to the device serial number,
which is 0. Since there exsist a PCI bus with domain ID 0 already the PCI

s/exsist/exist

Sridhar>> yes

bus addition fails. This patch make sure when a device is added to a bus,
it never updated the bus domain ID.

s/updated/updates
Sridhar >> yes

Since we have the transparent SRIOV mode now, the short VF device name
is no longer needed.

I still do not understand what this means and how it is related to the
patch below, it may be clear to you, it is not to me, at all.

Sridhar >> the patch below, was introduced to make the device name small, by taking only
16bits of the serial number. Since we are not going to have the serial number
updated to the BUS id, this has to be removed.

Fixes: 4a9b0933bdfc("PCI:hv:Use device serial number as PCI domain")

Fixes: 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
Sridhr >> yes

I asked you an explicit question. Commit above was added for a reason
I assume. This patch implies that kernel has been broken since v4.11
which is almost a year ago and nobody every noticed ? Or there are
systems where commit above is _necessary_ and this patch would break
them ?

I want a detailed explanation that highlights *why* it is safe to apply
this patch and send it to stable kernels, commit log above won't do.

Sridhar>> HyperV provides a unique domain ID for PCI BUS. But it is modified by the child
device when it is added. This cannot produce a unique domain ID all the time.
Here in the bug, we see the collision between the serial number and already
existing PCI bus. The cleaner way is never touch the domain ID provided by
hyperV during the PCI bus creation. As long as hyperV make sure it provides a
unique domain ID for the PCI for a VM it will not break, and HyperV will
guarantees that the domain for the PCI bus for a given VM will be always unique.
The original patch was also intending to have a unique domain ID for the PCI
bus, by taking the serial number of the device, but it is not sufficient, when
the device serial number is number which is the domain ID of the existing PCI
bus.  With the current kernel we can repro this issue by adding a device with a
serial number matching the existing PCI bus domain id. (in this case that
happens to be zero).


Thanks,
Lorenzo

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
