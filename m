Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2938067-1520546349-2-3303493410076349460
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520546348; b=hR2NNr53KBRhQK9WpN4aW6S2k9ph+PS92/EzTqBN9A7GeM7
    d4Bi1ZpLW1c/fx+xZU7gMGxM5Ca+L8jfatd3M9TiwrbUJzG1fwUmfvvfsmlRiIdY
    ENxChonLJW1BI46QRwHa4mc0d3sGSYjNR2YeUB7n1ZLmETfZUud7abUmOkkEiBUA
    jqDmTz71t9+S8qPYMLau2dmMb8zq1f1Fd9FzjV4ETSeT4hYP8jrO8UiU0uK3fPTF
    etfHdvdS7ypk+bahBTEpq3H0S/Ig/3O5GpRpEo/F5m7xpi7ABjup5kyIwVn0vwcW
    BX+0HECklFA4/JpsQw9d/TLs6KNPW5HXcWfv9Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520546348; bh=v
    zp6vB4p2USwtfarOBzqXEVE71plBc1ldD95TQva9Vg=; b=fbJ0yGHlg8iSSyj4z
    8dhUezwQHH3TNArVZcBFMalbr5/Ivnt6Yxv1Xg1VDcGVH89hMVjCr8GfDnYk3ob4
    W0ZCmC67gCc9BlZ5iD9gDwgM37KIdNBL7ZXvUkowbHSd9BsDqLnFF5jaa/4z7SPz
    C8V2MG1WMztPvODPBHCdZ2Cpywxn0JTFzrFuZWmIexY/dhb2flT7C0Vtp8ex+M8C
    opOGbobZSWIblndfRHDh7cnX3bmgVbEUAFgZDOtptIJ0/iDALNSgxsRI4F5t1NAN
    NzsBZgc+hRbRr07qTopd4CG2vqEh1c8gTDZqmceQPEiitCR7jJuBV0ar1GG4200P
    PQwzA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QKfMPrj0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QKfMPrj0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH] PCI BUS domain ID corruption
Thread-Topic: [PATCH] PCI BUS domain ID corruption
Thread-Index: AdO3H1EcY3OBHNlUSUKrkzORFww3fwAAGYAQAAGTaAAAAH5RIA==
Date: Thu, 8 Mar 2018 21:58:58 +0000
Message-ID: <DM5PR21MB0826E6291C76858FF3EEFC1BF6DF0@DM5PR21MB0826.namprd21.prod.outlook.com>
References: <DM5PR21MB0826CE724BFB0C2A9AB96014F6DF0@DM5PR21MB0826.namprd21.prod.outlook.com>
 <DM5PR21MB0826C68DB09C3856F9078931F6DF0@DM5PR21MB0826.namprd21.prod.outlook.com>
 <CAErSpo4RTtp8x6zrSSyJ1ft1aoX6Y2BThoeB7NVcF6Mn1Q8WHQ@mail.gmail.com>
In-Reply-To: <CAErSpo4RTtp8x6zrSSyJ1ft1aoX6Y2BThoeB7NVcF6Mn1Q8WHQ@mail.gmail.com>
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
x-originating-ip: [2001:4898:80e8:7::74b]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR21MB0476;
 7:hHzIVXBwJMElRE8fgr9+cbPF6Vr8yE2AbiQnjnFSAIxNqGqTNlTi1I50+tRh0X+eUGbFin8Rw1+k5AdEHyctPW5HtiLqibKFveN1b1RT8qtgZmo3BNnaHJNZ1ymrAno1cx+rN8evZDVvxH+5xJ5BWIUCWrLuIO8ubz24e2lk+pEGSbVjwPU1rHj5B/qFLpJkAlM2A1Ul5Gf1w1aIO0wy/+VHvqq2p5wca433iPzE5Mz1uYpcOfXSmkHvr8DT0OaU;
 20:yXOQNb/Dle7QI9BBXZP4dm6ol/72X6mIn/hFQI//iDJQVJ1uhFINbMup1iFN1uPBYo/OBCosisda2RLzmfDVhK4p+cbdOqa58GSA+U8temGAslUGlOVdZY1QLy0STMQV4bM4rdqcBrizxHe7OSkvsIzV0XUU5dsBBMpYGKIb0xA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 070d02ce-f31c-411c-444b-08d5853fcb88
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:DM5PR21MB0476;
x-ms-traffictypediagnostic: DM5PR21MB0476:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sridhar.Pitchai@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR21MB04764241E21F466A3F056273F6DF0@DM5PR21MB0476.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(9452136761055)(189930954265078)(85827821059158)(211936372134217)(153496737603132)(219752817060721);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040515)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501255)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041300)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
 SRVR:DM5PR21MB0476; BCL:0; PCL:0; RULEID:; SRVR:DM5PR21MB0476;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(376002)(39380400002)(39860400002)(396003)(54534003)(40764003)(13464003)(51914003)(199004)(189003)(40224003)(3280700002)(22452003)(7736002)(305945005)(74316002)(229853002)(86612001)(5660300001)(8936002)(8676002)(81156014)(81166006)(2950100002)(14454004)(6916009)(33656002)(316002)(186003)(53546011)(59450400001)(6506007)(7696005)(102836004)(99286004)(76176011)(105586002)(97736004)(54906003)(6306002)(478600001)(46003)(3660700001)(8990500004)(55016002)(5250100002)(6246003)(2906002)(6436002)(4326008)(68736007)(10090500001)(86362001)(575784001)(966005)(106356001)(9686003)(2900100001)(72206003)(53936002)(25786009)(6116002)(10290500003)(217873001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR21MB0476;
 H:DM5PR21MB0826.namprd21.prod.outlook.com; FPR:; SPF:None; PTR:InfoNoRecords;
 A:1; MX:1; LANG:en;
x-microsoft-antispam-message-info: YzY/bEh3hjR8QlL4YIj3kSYQlCtxj5FRu1eWGQccF81taPDI9GE3yutjqbRQcVwQbDLUFA/8gxigiuO3KzzlUSGrCeAGtTvsNJPPLFBqBhKFVElbQxBzTIXSrf91Ca1TgEqHQXwnf1DjMT6eB5Mbpx7Lq4MHVu6+gFC6DjkmAscvqqCOPuZ67o0vbmBg7Q+e5PRZODamHW8tJzOo3I4R0gq8XMNMINaCR0g/T2kGvaDypVgLkovkMMFBP14Q6MTXkIGLtp5I/AyTNhAjCef3LNa6dPdIClARIpa0c88M6fxmuhF5FooNLbjEDmbJOu2yowHS2wwUqNsQLcgZYbijMg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 070d02ce-f31c-411c-444b-08d5853fcb88
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 21:58:58.4470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0476
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
Cc: David Davis <David.Davis@microsoft.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jake Oshins <jakeo@microsoft.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks Bjorn,
I will send another mail, with 
1: the patch applied to 4.16. 
2: I will send a text mail (instead of HTML). 
3: add Signed-off-by:

Thanks for your help.

Thanks,
Sridhar Pitchai

-----Original Message-----
From: Bjorn Helgaas <bhelgaas@google.com> 
Sent: Thursday, March 8, 2018 1:40 PM
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
Cc: Jake Oshins <jakeo@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>; Dexuan Cui <decui@microsoft.com>; KY Srinivasan <kys@microsoft.com>; David Davis <David.Davis@microsoft.com>; devel@linuxdriverproject.org; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI BUS domain ID corruption

[+cc Lorenzo]

On Thu, Mar 8, 2018 at 12:55 PM, Sridhar Pitchai <Sridhar.Pitchai@microsoft.com> wrote:
> Hi,
>
> I would like to submit the following patch. This patch addresses the 
> issue when we try to add a VMBUS, the domain ID for the PCI bus is overwritten.

Hi Sridhar,

Thanks for the patch!

This area is maintained by Lorenzo now (cc'd), so please copy him on the next round.

We can't apply it as-is because it contains no Signed-off-by (see https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Ftree%2FDocumentation%2Fprocess%2Fsubmitting-patches.rst&data=04%7C01%7CSridhar.Pitchai%40microsoft.com%7C99c90ec96a544d9dedd808d5853d33ff%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636561420271631010%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwifQ%3D%3D%7C-2&sdata=1zcgL6ZK7FwFka3x%2FAwJJnLMOQG5kQD0eQ1UguSjiCA%3D&reserved=0).

This email is also too fancy (HTML, etc) and I think will be rejected by the mailing lists (see https://na01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fvger.kernel.org%2Fmajordomo-info.html%23taboo&data=04%7C01%7CSridhar.Pitchai%40microsoft.com%7C99c90ec96a544d9dedd808d5853d33ff%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636561420271631010%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwifQ%3D%3D%7C-2&sdata=icGYJhzoRJ%2Bw4xZPGrtrvDY%2BcNDys1HDllV4Agz11ro%3D&reserved=0).  What you want is a plain-text email.

Please also run "git log drivers/pci/host/pci-hyperv.c" and make your subject and changelog match the format and style of previous patches.

It looks like this basically reverts 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain"), so you should explain what was wrong with that commit.

Also, it doesn't look like this would apply cleanly to v4.16-rc1.
Your patch shows this:

 -               hbus->sysdata.domain = desc->ser & 0xFFFF;

but v4.16-rc1 has this:

                hbus->sysdata.domain = desc->ser;

Bjorn

> srpitcha@ linux srpitcha/patch >cat 
> 0001-PCI-BUS-domain-ID-curruption.patch
>
> From a0c407f3e2d57c84ac349f064dcee1d2961e5ca3 Mon Sep 17 00:00:00 2001
>
> From: Sridhar Pitchai <sridhar.pitchai@gmail.com>
>
> Date: Thu, 8 Mar 2018 12:33:50 -0800
>
> Subject: [PATCH] PCI BUS domain ID corruption
>
>
>
>     When PCI BUS is added, PCI_BUS domain ID is set. When PCI_BUS and 
> device to
>
>     the bus is racing against each other, the first device tends to 
> overwrite
>
>     the domain ID. In order to avoid the race, this patch make sure 
> when a
>
>     device is added to a bus it never updates the bus domain ID. Since 
> we have
>
>     the transparent SRIOV mode now, the short VF device name is no 
> longer
>
>     needed.
>
>
>
> diff --git a/drivers/pci/host/pci-hyperv.c 
> b/drivers/pci/host/pci-hyperv.c
>
> index 1713bfc..6d43f81 100644
>
> --- a/drivers/pci/host/pci-hyperv.c
>
> +++ b/drivers/pci/host/pci-hyperv.c
>
> @@ -1321,19 +1321,6 @@ static struct hv_pci_dev 
> *new_pcichild_device(struct hv_pcibus_device *hbus,
>
>         get_pcichild(hpdev, hv_pcidev_ref_childlist);
>
>         spin_lock_irqsave(&hbus->device_list_lock, flags);
>
>
>
> -       /*
>
> -        * When a device is being added to the bus, we set the PCI domain
>
> -        * number to be the device serial number, which is non-zero and
>
> -        * unique on the same VM.  The serial numbers start with 1, and
>
> -        * increase by 1 for each device.  So device names including this
>
> -        * can have shorter names than based on the bus instance UUID.
>
> -        * Only the first device serial number is used for domain, so the
>
> -        * domain number will not change after the first device is added.
>
> -        * The lower 16 bits of the serial number is used, otherwise some
>
> -        * drivers may not be able to handle it.
>
> -        */
>
> -       if (list_empty(&hbus->children))
>
> -               hbus->sysdata.domain = desc->ser & 0xFFFF;
>
>         list_add_tail(&hpdev->list_entry, &hbus->children);
>
>         spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>
>         return hpdev;
>
> --
>
> 2.7.4
>
>
>
> srpitcha@ linux srpitcha/patch >
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
