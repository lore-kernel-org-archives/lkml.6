Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-779193-1521136619-2-5231965445648071688
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521136618; b=FUjVKm+l9KxzA8fsT1LLNyvedMvXLw89h+hmte1IQ4YuTLW
    b9APmyxCHiJiHo0014BjB2e+wkyiOy3eP/fVAhGBFhWu3XGVurXkRhH49j5jFsVX
    K2A0TJ+HQoKrFuBQVtffd1/QQNsdKOtnFOXNP8yOBP/+qW24sjCcYiOqJYuXsSjv
    MgdMOfA1Q5m1G0+ZZTz44LVoAOmPIjU9Yy7tgNcQCYNTX5oiQXqUDl/u6uT+AQrh
    g44RwL/6/1pPlYs9pA04JacgBcOJPikjvbfnGqCbFh+L5LeFn5OvJx9ISOdtYi3P
    uUD7MdWzeOapBhNVoRBmN0p8ZSD46PDeDbxm3/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521136618; bh=h
    a8ucRVJhfWMoMYs6lVnP63PPj46Eqo8+du9DdG1VIw=; b=H2UaXigc7rePg7J31
    lVtYHPfkJpRsupoi2DDHB8/0v8As/Zr1oEP3k0IplwkSmRlN8lFNndvIAUgzabZH
    XubKdI2d0fFyMyJ7yL1+tycwz9FAobcSEs6oLNnGjj4758jhwXkpp7yuCckg56b1
    Xpr7o/Ylij81iIMVLr3rwWu+cpv1uHHFp17hPMonW647BEjR0Un7dzmFy+tFObbD
    yC3K3QfwRs8vanVCoPyO2FbwTt3IRS0WV6nBlFXgdUGzQXSjFC/cAg9wvFJGHWC5
    NPt0/7QAguEMo2L6EIVlBR8tLmy8atuNaUs0Cy1zyRQgOjuGjlAeJe1uHkRYy1Fv
    EGfew==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eeU1hwoW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eeU1hwoW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCH v3]PCI: hv: fix PCI-BUS domainID corruption
Thread-Topic: [PATCH v3]PCI: hv: fix PCI-BUS domainID corruption
Thread-Index: AQHTu/D/DaxTLK2/o0CSPNG8bCOBxaPRM+cAgABaE+A=
Date: Thu, 15 Mar 2018 17:56:47 +0000
Message-ID: <DM5PR21MB0826439DF296763A3FA861C3F6D00@DM5PR21MB0826.namprd21.prod.outlook.com>
References: <C600E28F-E581-431E-9CD4-47C776E8E70F@microsoft.com>
 <20180315120522.GA15651@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180315120522.GA15651@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=srpitcha@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-15T17:56:45.8530099Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:1::ad]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR21MB0860;
 7:bSD0ioS96thZAeRuHVp8lXtv1XI3FE+d4XIxPMktKfXc/DeRCCnEoDCAJ3vT0l50A0DIyuEFip9o2mKuZCSanoJFt7nu7Q+mT478gln0gvLJJEYp3FrwnepMKAlfa9OGIqKG96fhqwzpg6AiMezwbsw+BGKugBZ2OnHb3y7scoNkelqUfGASM3FlWMj1kzbnWdlQ2cnPQ5fjFaBNEq45O9SGJkc1WVuFj8osmYDsS8AZw3F+k3y0wXpM2JR5gwr5;
 20:qlhjzvF2JeOpWYSDAFFXrA0lM0BNuwaU79ieKkUWE1FzJO4U2YiQx3pNw7Vf1e4Cs8LJkx/axaIhc5pQdNnYNlgMEUENuA4Kbk0rc05VLxFIAUUp7t2z8I7D26xsxgkUjhyd9jstgXNbUuSQzHvfzAKUPTSBalXLTT/yOIFDlFA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 207af073-e472-441a-ee3e-08d58a9e1f7f
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:DM5PR21MB0860;
x-ms-traffictypediagnostic: DM5PR21MB0860:
x-microsoft-antispam-prvs: <DM5PR21MB0860D5425DBAEC743061BE16F6D00@DM5PR21MB0860.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(9452136761055)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501270)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);
 SRVR:DM5PR21MB0860; BCL:0; PCL:0; RULEID:; SRVR:DM5PR21MB0860;
x-forefront-prvs: 0612E553B4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(39380400002)(39860400002)(366004)(376002)(40224003)(13464003)(199004)(189003)(106356001)(81166006)(81156014)(46003)(53936002)(105586002)(25786009)(10290500003)(97736004)(7736002)(6246003)(8936002)(6346003)(6436002)(6506007)(102836004)(5250100002)(305945005)(72206003)(7696005)(76176011)(2900100001)(99286004)(59450400001)(6116002)(186003)(33656002)(4326008)(8676002)(14454004)(53546011)(229853002)(22452003)(2906002)(86362001)(8990500004)(55016002)(5660300001)(86612001)(68736007)(478600001)(3660700001)(9686003)(3280700002)(74316002)(2950100002)(54906003)(316002)(10090500001)(6916009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR21MB0860;
 H:DM5PR21MB0826.namprd21.prod.outlook.com; FPR:; SPF:None; PTR:InfoNoRecords;
 A:1; MX:1; LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sridhar.Pitchai@microsoft.com;
x-microsoft-antispam-message-info: tY7RfC0Wbeh67F7+o0GiA7aSNrGo6E+RtlNlksqIrSpekODtcPlksI/c+Bs7AWZ+xXTC1R9sM49Ayds78J6lM9fZ8/ggmWq/g0FMgyyRHXARq20gwvg4bNyC8mcsSbX4be/h65YkhI6BQZfgtPlmYSJywM8zp/39v41RQkwGHqcOfMFZ7JX/FEMRE2Lr49PIPTLLIA/QrARwFd/9kpc3DoTidt1x4NRbQQ1q8k2vvNKUFJEn0uGwDWe1ruyaPPi/9Le3VnLiZpVtpEw9paN/lRKQQrS0hdMwPVJZQSRMSwQOZR2AQAcklGbgBWTIojTlVeWWqsL9grt3FGYNT74MXw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 207af073-e472-441a-ee3e-08d58a9e1f7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2018 17:56:47.8549 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0860
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
> Whenever PCI bus is added, HyperV guarantees the BUS id is unique. Even

"Whenever a PCI bus is added"
Sridhar>> yes

> with that when a first device is added to the bus, it overrides bus domain
> ID with the device serial number. Sometime this can result in BUS ID not

Define "Sometime".

Sridhar>> HyperV when it creates a PCI bus it guarantees it provide a unique ID for it. But, that unique BUS ID is replaced with device serial number. 0 is a valid device serial number, and if there exists a PCI bus with domain ID 0 (Gen 1 version of hyperV VM have this for para virtual devices), this will result in PCI bus id not being unique. 

> being unique. In this case, when PCI_BUS and a device to bus is added, the
> first device overwrites the bus domain ID to the device serial number,
> which is 0. Since there exsist a PCI bus with domain ID 0 already the PCI

s/exsist/exist

Sridhar>> yes

> bus addition fails. This patch make sure when a device is added to a bus,
> it never updated the bus domain ID. 

s/updated/updates
Sridhar >> yes

> Since we have the transparent SRIOV mode now, the short VF device name
> is no longer needed.

I still do not understand what this means and how it is related to the
patch below, it may be clear to you, it is not to me, at all.

Sridhar >> the patch below, was introduced to make the device name small, by taking only 16bits of the serial number. Since we are not going to have the serial number updated to the BUS id, this has to be removed.

> Fixes: 4a9b0933bdfc("PCI:hv:Use device serial number as PCI domain")

Fixes: 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
Sridhr >> yes

I asked you an explicit question. Commit above was added for a reason
I assume. This patch implies that kernel has been broken since v4.11
which is almost a year ago and nobody every noticed ? Or there are
systems where commit above is _necessary_ and this patch would break
them ?

I want a detailed explanation that highlights *why* it is safe to apply
this patch and send it to stable kernels, commit log above won't do.

Sridhar>> HyperV provides a unique domain ID for PCI BUS. But it is modified by the child device when it is added. This cannot produce a unique domain ID all the time. Here in the bug, we see the collision between the serial number and already existing PCI bus. The cleaner way is never touch the domain ID provided by hyperV during the PCI bus creation. As long as hyperV make sure it provides a unique domain ID for the PCI for a VM it will not break, and HyperV will guarantees that the domain for the PCI bus for a given VM will be always unique.
The original patch was also intending to have a unique domain ID for the PCI bus, by taking the serial number of the device, but it is not sufficient, when the device serial number is number which is the domain ID of the existing PCI bus.
With the current kernel we can repro this issue by adding a device with a serial number matching the existing PCI bus domain id. (in this case that happens to be zero).

Thanks,
Lorenzo

> Cc: stable@vger.kernel.org
> Signed-off-by: Sridhar Pitchai <srpitcha@microsoft.com>
> ---
> 
> Changes in v3:
> * fix the commit comment. [KY Srinivasan, Michael Kelley]
> ---
>  drivers/pci/host/pci-hyperv.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index 2faf38e..ac67e56 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -1518,17 +1518,6 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
>  	get_pcichild(hpdev, hv_pcidev_ref_childlist);
>  	spin_lock_irqsave(&hbus->device_list_lock, flags);
>  
> -	/*
> -	 * When a device is being added to the bus, we set the PCI domain
> -	 * number to be the device serial number, which is non-zero and
> -	 * unique on the same VM.  The serial numbers start with 1, and
> -	 * increase by 1 for each device.  So device names including this
> -	 * can have shorter names than based on the bus instance UUID.
> -	 * Only the first device serial number is used for domain, so the
> -	 * domain number will not change after the first device is added.
> -	 */
> -	if (list_empty(&hbus->children))
> -		hbus->sysdata.domain = desc->ser;
>  	list_add_tail(&hpdev->list_entry, &hbus->children);
>  	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>  	return hpdev;
> -- 
> 2.7.4 
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
