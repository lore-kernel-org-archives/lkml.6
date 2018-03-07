Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-120844-1520458825-2-8363319955419519211
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520458825; b=FWmNiBFHVenUhynYX9LFyWETUPfQgtIjr7wTE8EyTjs10G9
    ozj1ZwRHsQHX15VI7BBXDQXLC2AiCH6621NW0qXb/34MDjfNDZqUjN4ACHq7um4n
    Nd9gISo8fcSHtCMVC0rxBt9Ems0xwELWt3THSqZbUhpo5AqSHH9yO/5sBMNZSHSG
    jkYmhsBz0oAa63TKANVbJXKJPUe7soqANuDunTG3jNV9tAuPJok74kYRHaoLryNS
    luUe2pOZJYGdFKRAbAwO36VMmSR4gXugaiYnZrhK7Tl4GN0hj/nas9P0jD/N+ybe
    7xLrB8K5nzxRH2GOVHiI2pJqZb7J2KjHgHEX43w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520458825; bh=bMLdl0
    Hq5NCQ41y/n96UQfPddY6Z2Qyjs0cEJPoJB6E=; b=wOl9CupPVd26QK2YK2U6sC
    xrZ2dIqdHf2K5k8taCDMUNZKe3K4au07QmFu7qw9XDsBmwLIH5ksDURNIME7FU9v
    piqtcJoZdm8Y3f5O1qO9E+Cep9gbl4/vuUOlKorIHP3rh9RgjDs6eyknQjDVYMsC
    uaERIE7rpq1t+kHso6kplmGpM8ZbGFE5t4ynzPPqhQF4oPLx++Tm0SITFqQm62CK
    ae6MvTE+7wo4UoIeVpk7LMm3sexk6tXKLIQDr9cxICvI0Z55+dr/S+ww+sRlmpiZ
    H7XNOGTvlK9GnZB+nnqHIBZYyTAbPb5ZMJIZ9LZSHPz8/xUKxIvrfYp1QlxItPEg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T4Yh/BAS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T4Yh/BAS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754757AbeCGVkW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 16:40:22 -0500
Received: from mail-hk2apc01on0116.outbound.protection.outlook.com ([104.47.124.116]:65315
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754553AbeCGVkU (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 16:40:20 -0500
From: Dexuan Cui <decui@microsoft.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jack Morgenstein <jackm@mellanox.com>
Subject: RE: [PATCH v3 6/6] PCI: hv: fix 2 hang issues in hv_compose_msi_msg()
Thread-Topic: [PATCH v3 6/6] PCI: hv: fix 2 hang issues in
 hv_compose_msi_msg()
Thread-Index: AQHTtXgCGuFYGGn/Jki0TgY7mD0986PEtmOAgACL6bA=
Date: Wed, 7 Mar 2018 21:40:03 +0000
Message-ID: <KL1P15301MB0006B22926A4DC338BFEB78DBFD80@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <20180306182128.23281-1-decui@microsoft.com>
 <20180306182128.23281-7-decui@microsoft.com>
 <20180307123441.GD15139@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180307123441.GD15139@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-07T21:39:59.3403353Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2001:4898:80e8:2::718]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0071;7:i19Wab2pFPXJjH4HSKOHfHwQzp4y+7OeGOp4SkWxzmviBuQIhD9vtlw61HVzSVV9MLSZZuIIRw9FE9v6iRj2dF5Nsl5fz0qvpaTWTfdZzZxtTy386d/piB70Dclrxw+7F+a/Wo21jA6tBf+gqI2W3w/6w77krj+Sh/nq8ZV4a/+koOvFIqtfGiMA2mUMHY4W3+8QBQp7uOa66tFSDRUOOtbuIsN+L4tnQ4W9bprBtYTrVm7OJu9q4EtJ2wHd0QA2;20:5n/nAjqC878Ma/8z98w8aNEZ3xzTLygO82sowHS4jziJnM0uQCMWASAh5q/ydDPu2jYjL8uYqdLm5H1tqGFfXgWT5Fh/F6+ywWJgo7Z4p6xRXs/wxn5OpDh1vTbFEEoge0DIC0eqGIVltY9NEVqaQrXns1qeVjkTdHpxxTVXnDk=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 59e99049-2df2-4c08-9043-08d58473fd17
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:KL1P15301MB0071;
x-ms-traffictypediagnostic: KL1P15301MB0071:
x-microsoft-antispam-prvs: <KL1P15301MB007169139B13E0D03651C927BFD80@KL1P15301MB0071.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(9452136761055)(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:KL1P15301MB0071;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0071;
x-forefront-prvs: 0604AFA86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(366004)(39380400002)(396003)(189003)(199004)(305945005)(8936002)(74316002)(10290500003)(106356001)(6246003)(478600001)(105586002)(8990500004)(2900100001)(46003)(6506007)(7736002)(8676002)(102836004)(99286004)(186003)(59450400001)(81156014)(81166006)(229853002)(53936002)(54906003)(77096007)(97736004)(9686003)(316002)(7416002)(55016002)(14454004)(3280700002)(6916009)(68736007)(2950100002)(86362001)(7696005)(5660300001)(10090500001)(3660700001)(86612001)(6436002)(4326008)(76176011)(25786009)(2906002)(22452003)(33656002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0071;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: jEjK0JQL00FSlDH7Yt6Pw/ag/sZW8+S2LoVJQqMZoa8M4j9GBPuN5hBfv2m3AVCiKws9fk4V6F4FRGij1ip/Dlp0yHEAnNsm7Ht7CgujXqBeOzVhlUpPsjb9fZoaEuRaSmDL1cHRcfJLhJ4tajIbZpdQ71zclB0enfQ/9jhaXXSfoMnY4ldon0rPj6tTJ3Q2I1dtEkAMnsVt0D4C0Pk7YJIwqpJvLg/G/chHyBdfUCJb/ZLcd6vDMUFbBug9hAu7Hq+fkDjTFOIEohQYqJC89GTgp//rZH/XCysKZmTrxWXX54hzxA9HmtefPdN/zYmXw9aoGLS4DPyaq0rXcxx3MA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e99049-2df2-4c08-9043-08d58473fd17
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2018 21:40:03.8843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0071
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Wednesday, March 7, 2018 04:35
> On Tue, Mar 06, 2018 at 06:21:56PM +0000, Dexuan Cui wrote:
> > 1. With the patch "x86/vector/msi: Switch to global reservation mode"
> > (4900be8360), the recent v4.15 and newer kernels always hang for 1-vCPU
> > Hyper-V VM with SR-IOV. This is because when we reach
> hv_compose_msi_msg()
> > by request_irq()  -> request_threaded_irq() -> __setup_irq()->irq_start=
up()
> >  -> __irq_startup() -> irq_domain_activate_irq() -> ... ->
> > msi_domain_activate() -> ... -> hv_compose_msi_msg(), local irq is
> > disabled in __setup_irq().
> >
> > Fix this by polling the channel.
> >
> > 2. If the host is ejecting the VF device before we reach
> > hv_compose_msi_msg(), in a UP VM, we can hang in hv_compose_msi_msg()
> > forever, because at this time the host doesn't respond to the
> > CREATE_INTERRUPT request. This issue also happens to old kernels like
> > v4.14, v4.13, etc.
>
> If you are fixing a problem you should report what commit you are fixing
> with a Fixes: tag and add a CC: stable@vger.kernel.org to the commit log
> to send it to stable kernels to which it should be applied; mentioning
> kernel versions in the commit log is useless and should be omitted.

Hi Lorenzo,
Thanks for your comments!
This patch does have a "Cc: stable@vger.kernel.org" in the sign-off area. :=
-)

Here the patch is made to resolve 2 issues:
#1 is triggered by the x86 global reservation mode (4900be8360) patch.
4900be8360 in itself is good. It's just that drivers/pci/host/pci-hyperv.c
should be fixed.

#2 is a longstanding issue since the first day the pci-hyperv driver was
accepted into the kernel.

So IMO actually we don't really need to add a Fixes: tag, which is usually
used to specify a specific commit that introduces a bug that is being fixed=
.

> Side note: you should not have stable@vger.kernel.org in the email
> addresses CC list you are sending the patches to (you mark patches for
> stable by adding an appropriate CC tag in the commit log).

Sorry, I didn't know this, but actually I didn't add stable@vger.kernel.org
manually. Instead I used "git send-email" to send this patchset, and it tol=
d
me "The Cc list above has been expanded by additional addresses found
in the patch commit message."

I didn't find a way to disable this behavior of "git send-email" by checkin=
g
its manual and googling it. This is strange.

> Here:
>
> git.kernel.org/.../Documentation/process/stable-kernel-rules.rst
>
> Last but not least, most of the patches in this series do not justify
> sending them to stable kernels at all so you should remove the
> corresponding tag from the patches.

I hope at least these 2 patches can go into the stable kernels:
[PATCH v3 3/6] PCI: hv: serialize the present/eject work items
[PATCH v3 6/6] PCI: hv: fix 2 hang issues in hv_compose_msi_msg()
Especially the second one, which fixes a real hang issue for UP virtual
machines running v4.15 and newer.
And,  IMO the patches are small enough (<100 lines) , but definitely
the maintainers make the final call.

>
> Thanks,
> Lorenzo
>
> > Fix this by polling the channel for the PCI_EJECT message and
> > hpdev->state, and by checking the PCI vendor ID.
> >
> > Note: actually the above issues also happen to a SMP VM, if
> > "hbus->hdev->channel->target_cpu =3D=3D smp_processor_id()" is true.
> >
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > Tested-by: Adrian Suhov <v-adsuho@microsoft.com>
> > Tested-by: Chris Valean <v-chvale@microsoft.com>
> > Cc: stable@vger.kernel.org
> > Cc: Stephen Hemminger <sthemmin@microsoft.com>
> > Cc: K. Y. Srinivasan <kys@microsoft.com>
> > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> > Cc: Jack Morgenstein <jackm@mellanox.com>
> > ---
> >  drivers/pci/host/pci-hyperv.c | 58


Thanks,
-- Dexuan
