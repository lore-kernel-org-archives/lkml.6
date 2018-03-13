Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3767103-1520965458-2-12275554692958300649
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
    t=1520965457; b=bcxYQNsJnCEyCQAiBzL+Z1HLyt0rzWRcU3knzBjU7/oApGb
    8UihY6nZQwWpX9wAB268OukL8usLo51C66jCjE4i1kauiFcJX5HF6RR6BBE00fEC
    Bz7h2Ue3SXA5RADy6Q9dH+nU/lM2xsa1h+JDeKV13o4yOJvFjd5F/o3YyH9OGZkD
    9I04eKq+tkUtrh0my+aendFcXYwZfjx0Ez7G/HM9o1KdPRlM6J/m62AzzHpED58C
    hzHmoBOKJsJ7r2kUx+z2BmjBDaTEKnM75w/MiQFB4V5x5fHfDDyBAvm67jtE532u
    kbBfX+PP2BFs0Qx7QWYzNzHTEYVP4YlQOoO71lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520965457; bh=i+Fdp6
    Cliglvrou5EONEI5F2QRAkaex2JnHc6kQk4XQ=; b=Y29iWTGBPZQVqxzd/tbCk3
    yCMmxRtfouK8tX+yN8qoMjjyd6dROjIIPBHH3zCgATlYb3wUvCw2P1tCmUAPSPgB
    l+UvLE5KClMv6/kFVAX+Ecf01/gdQ/d304RSTa4m4klhBJjNqKXWroJur6qTD3Uu
    BFZNgQFlSga+QPjR6X7e65Si/PfWWrC1RdValm7us1KyKj06QiDAYWjmZC9yoG8W
    lxR945sR5EyK9QC1sZLisbg+k+1sWE3hmjlOXv5gJA/qnwIxTDAgKn54MTYqU71Z
    BPl8ew1CXw0tRQJXR8wPDhZlkq0H5tNwzj0t5dH706xbcGc1GtwdHMVaQ/zNDKrg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LSNGTHV0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LSNGTHV0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbeCMSYA (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 14:24:00 -0400
Received: from mail-sg2apc01on0139.outbound.protection.outlook.com ([104.47.125.139]:6304
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750855AbeCMSX6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 13 Mar 2018 14:23:58 -0400
From: Dexuan Cui <decui@microsoft.com>
To: 'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>,
        "'bhelgaas@google.com'" <bhelgaas@google.com>
CC: "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'driverdev-devel@linuxdriverproject.org'"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "'vkuznets@redhat.com'" <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "'stable@vger.kernel.org'" <stable@vger.kernel.org>,
        'Jack Morgenstein' <jackm@mellanox.com>
Subject: RE: [PATCH v3 6/6] PCI: hv: fix 2 hang issues in hv_compose_msi_msg()
Thread-Topic: [PATCH v3 6/6] PCI: hv: fix 2 hang issues in
 hv_compose_msi_msg()
Thread-Index: AQHTtXgCGuFYGGn/Jki0TgY7mD0986PEtmOAgACL6bCAB64LMA==
Date: Tue, 13 Mar 2018 18:23:39 +0000
Message-ID: <SG2P15301MB00158D30D602950F05F8B14ABFD20@SG2P15301MB0015.APCP153.PROD.OUTLOOK.COM>
References: <20180306182128.23281-1-decui@microsoft.com>
 <20180306182128.23281-7-decui@microsoft.com>
 <20180307123441.GD15139@e107981-ln.cambridge.arm.com>
 <KL1P15301MB0006B22926A4DC338BFEB78DBFD80@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <KL1P15301MB0006B22926A4DC338BFEB78DBFD80@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
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
x-originating-ip: [2001:4898:80e8:2::477]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2P15301MB0096;7:SZyEyvQgvspeza3rOfaCnMsHGsIEau1VUokkovJPIqL/1slQ11IAn3cPmrlLOM6/LbatT03bKWIR7vhGH3zmsKVErcnmljVGZasAHl2Fr7TBfqG3BKedOqK9JJq7+2FizEGcu7gP8qdJ5Z6Xasay+1/5DJzdLI01wfqKJ/qa9eUUa+MfZdXMhSLgShyJlg06Vprvh9hy2CVDggjDe3DtRWdZ/Sj7t9Mn9gXXMHe8a14p0GNVD0nbagmAakkkltbe;20:efF0rJ/56iAKbUA1OI5NzDIrd/90xgymJfl6in2Yr7nM1rrBzqsgP38HEQj99eofzFdBeE3Zl/R3L/TXkJGmC9OX63CONzY6+DVq+vZtsIstrjuwVv20JL4FNJhztqiEkglCpTG2qmOTJzTCFYM0Rffe8TJezxhhyeAkpk67dco=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bbc756e6-80a9-4c70-743d-08d5890f8b80
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:SG2P15301MB0096;
x-ms-traffictypediagnostic: SG2P15301MB0096:
x-microsoft-antispam-prvs: <SG2P15301MB0096A16A453A27CB0C4C9C28BFD20@SG2P15301MB0096.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(9452136761055)(211936372134217)(84791874153150)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:SG2P15301MB0096;BCL:0;PCL:0;RULEID:;SRVR:SG2P15301MB0096;
x-forefront-prvs: 0610D16BBE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(97736004)(86362001)(46003)(7416002)(5250100002)(53936002)(3280700002)(25786009)(68736007)(8990500004)(86612001)(10090500001)(74316002)(55016002)(33656002)(10290500003)(93886005)(106356001)(105586002)(9686003)(2950100002)(5660300001)(102836004)(6116002)(81166006)(8936002)(8676002)(81156014)(110136005)(7696005)(2900100001)(6346003)(6246003)(316002)(305945005)(2906002)(54906003)(3660700001)(4326008)(53546011)(6436002)(6506007)(14454004)(186003)(99286004)(7736002)(22452003)(59450400001)(229853002)(76176011)(478600001)(491001);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P15301MB0096;H:SG2P15301MB0015.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-microsoft-antispam-message-info: ZSy6AuluKNjKN/kscZhMGzHQFiajwUZ3ur+VABJIt0R65qR76lAwOkU1pI3V4O2AwJdMk/NpsUh4TohoKfyS3d6Ach8PO9bCPNtQUR68PtsHwdWuSWXjfTKCxgfIu+4glLoswyu061QKy/A+MMdxYpP0PvSlkicQX1+PbpRZOZj+/UU41Acs8eF9XLYL1pNUE3wtpNowoVpZf2u0VdGhCRj2eIfNDSENUCw/cVxDC5igYtBKW0w+8LtBC90dL43FZvTPjqx55AXrC1q+GZViYK/NRiQga/nZHbASmlpIcx7DQSEtBM58HPkwAikL4zCOUUkmMXZ1zU0+BxsYlg4L0w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc756e6-80a9-4c70-743d-08d5890f8b80
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2018 18:23:39.4954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0096
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> From: Dexuan Cui
> Sent: Wednesday, March 7, 2018 13:40
> To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: bhelgaas@google.com; linux-pci@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> olaf@aepfle.de; apw@canonical.com; jasowang@redhat.com; linux-
> kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.org; Haiyang
> Zhang <haiyangz@microsoft.com>; vkuznets@redhat.com;
> marcelo.cerri@canonical.com; Michael Kelley (EOSG)
> <Michael.H.Kelley@microsoft.com>; stable@vger.kernel.org; Jack
> Morgenstein <jackm@mellanox.com>
> Subject: RE: [PATCH v3 6/6] PCI: hv: fix 2 hang issues in hv_compose_msi_=
msg()
>=20
> > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Sent: Wednesday, March 7, 2018 04:35
> > On Tue, Mar 06, 2018 at 06:21:56PM +0000, Dexuan Cui wrote:
> > > 1. With the patch "x86/vector/msi: Switch to global reservation mode"
> > > (4900be8360), the recent v4.15 and newer kernels always hang for 1-vC=
PU
> > > Hyper-V VM with SR-IOV. This is because when we reach
> > hv_compose_msi_msg()
> > > by request_irq()  -> request_threaded_irq() -> __setup_irq()->irq_sta=
rtup()
> > >  -> __irq_startup() -> irq_domain_activate_irq() -> ... ->
> > > msi_domain_activate() -> ... -> hv_compose_msi_msg(), local irq is
> > > disabled in __setup_irq().
> > >
> > > Fix this by polling the channel.
> > >
> > > 2. If the host is ejecting the VF device before we reach
> > > hv_compose_msi_msg(), in a UP VM, we can hang in
> hv_compose_msi_msg()
> > > forever, because at this time the host doesn't respond to the
> > > CREATE_INTERRUPT request. This issue also happens to old kernels like
> > > v4.14, v4.13, etc.
> >
> > If you are fixing a problem you should report what commit you are fixin=
g
> > with a Fixes: tag and add a CC: stable@vger.kernel.org to the commit lo=
g
> > to send it to stable kernels to which it should be applied; mentioning
> > kernel versions in the commit log is useless and should be omitted.
>=20
> Hi Lorenzo,
> Thanks for your comments!
> This patch does have a "Cc: stable@vger.kernel.org" in the sign-off area.=
 :-)
>=20
> Here the patch is made to resolve 2 issues:
> #1 is triggered by the x86 global reservation mode (4900be8360) patch.
> 4900be8360 in itself is good. It's just that drivers/pci/host/pci-hyperv.=
c
> should be fixed.
>=20
> #2 is a longstanding issue since the first day the pci-hyperv driver was
> accepted into the kernel.
>=20
> So IMO actually we don't really need to add a Fixes: tag, which is usuall=
y
> used to specify a specific commit that introduces a bug that is being fix=
ed.
>=20
> > Side note: you should not have stable@vger.kernel.org in the email
> > addresses CC list you are sending the patches to (you mark patches for
> > stable by adding an appropriate CC tag in the commit log).
>=20
> Sorry, I didn't know this, but actually I didn't add stable@vger.kernel.o=
rg
> manually. Instead I used "git send-email" to send this patchset, and it t=
old
> me "The Cc list above has been expanded by additional addresses found
> in the patch commit message."
>=20
> I didn't find a way to disable this behavior of "git send-email" by check=
ing
> its manual and googling it. This is strange.
>=20
> > Here:
> >
> > git.kernel.org/.../Documentation/process/stable-kernel-rules.rst
> >
> > Last but not least, most of the patches in this series do not justify
> > sending them to stable kernels at all so you should remove the
> > corresponding tag from the patches.
>=20
> I hope at least these 2 patches can go into the stable kernels:
> [PATCH v3 3/6] PCI: hv: serialize the present/eject work items
> [PATCH v3 6/6] PCI: hv: fix 2 hang issues in hv_compose_msi_msg()
> Especially the second one, which fixes a real hang issue for UP virtual
> machines running v4.15 and newer.
> And,  IMO the patches are small enough (<100 lines) , but definitely
> the maintainers make the final call.
>=20
> >
> > Thanks,
> > Lorenzo
> >
> > > Fix this by polling the channel for the PCI_EJECT message and
> > > hpdev->state, and by checking the PCI vendor ID.
> > >
> > > Note: actually the above issues also happen to a SMP VM, if
> > > "hbus->hdev->channel->target_cpu =3D=3D smp_processor_id()" is true.
> > >
> > > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > > Tested-by: Adrian Suhov <v-adsuho@microsoft.com>
> > > Tested-by: Chris Valean <v-chvale@microsoft.com>
> > > Cc: stable@vger.kernel.org
> > > Cc: Stephen Hemminger <sthemmin@microsoft.com>
> > > Cc: K. Y. Srinivasan <kys@microsoft.com>
> > > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> > > Cc: Jack Morgenstein <jackm@mellanox.com>
> > > ---
> > >  drivers/pci/host/pci-hyperv.c | 58
>=20
>=20
> Thanks,
> -- Dexuan

Hi Lorenzo, Bjorn, and all,
Do you need more ACKs? Currently Michael and Haiyang reviewed and ack'd=20
the patchset.

Should I send a v4 that just removes the "CC: stable@vger.kernel.org" tag
for patches 1, 2, 4 and 5? I tend to avoid a v4 as I supppose it would be=20
easier if you just remove the tags if you belive it's necessary (IMHO all t=
he
6 paches are not big and it would be great if we can have all of them in=20
the old stable kernels, but I respect your decision).

Please let me know if I missed something when addressing the comments,
 and if I should send a v4.

Thanks!
-- Dexuan
