Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2203218-1521047856-2-13986008194569413648
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
    t=1521047855; b=J0meHB8yc2/eHa17KinzDwHwEHsGHv7hnHLkd2cPUrmKTca
    AM5Yeui9fnwHWtyudoll5CMXc8DneJA/c6PcZBNJ07kKcC5axpwe/0ZJ5SS+3hU3
    R/1AXx5apeqmQOgvnDmZJ+TycUZLUM8GWUuaPkmDe65fe0pA2udNsT6AwrXG0ft8
    559EQyUFl6Qj90OX8ky6X2dZCJrmnIib06vc4IAgsUtIA/Q6Gc28C2X1mGvXbqrg
    OQwj8NC2m++9b2xk1UXMvDNgX2+2ZkO+2PtpfAKLG+0X1DW164arnf2dlG7JT8XQ
    dklX+AygvU0QC40l/Um9uyzBh2AnPXOZmaNcEfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521047855; bh=B2Yjuu
    dfgFd5kxRWXtIeErgvNNFQT8zdEC5wVIET2SQ=; b=rPSt1G0c6YuMfo2PAfhZR9
    w8DWrKkMGXKGT52Yf7gholgafOQTsSJjWKMGGmdcVJTlF1pVDL1uNSe9BpYUtooM
    +2lvo8GK3iy8az4QB35QASxIW5KusnX83gbfR8yDIk9uC+prRjC4Ydu1yjBcRgJa
    2tRq2UdKMest54BGvmXyBrp4ibEd16SQ0pzVejQh4blP8kmJaE80edXzLfLEPYps
    POv1PLuSnQOBJddY0yKNgL6ohXs4Fx+9f5kp3kj0oHbhed6HT6DWtmVJrmQkWWDJ
    HIafTIWBJ0o5NEAkAJ0tLo6svqMeYzxLaE79sBnKkEoUq4lcX75Br684MDd4AtSQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hbzdTKm9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hbzdTKm9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750950AbeCNRRd (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 13:17:33 -0400
Received: from mail-hk2apc01on0130.outbound.protection.outlook.com ([104.47.124.130]:42752
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751314AbeCNRRc (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 14 Mar 2018 13:17:32 -0400
From: Dexuan Cui <decui@microsoft.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: "'bhelgaas@google.com'" <bhelgaas@google.com>,
        "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
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
Thread-Index: AQHTtXgCGuFYGGn/Jki0TgY7mD0986PEtmOAgACL6bCAB64LMIACueIAgABYCrA=
Date: Wed, 14 Mar 2018 17:17:13 +0000
Message-ID: <KL1P15301MB0006D5A4BD0ED296804637C9BFD10@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <20180306182128.23281-1-decui@microsoft.com>
 <20180306182128.23281-7-decui@microsoft.com>
 <20180307123441.GD15139@e107981-ln.cambridge.arm.com>
 <KL1P15301MB0006B22926A4DC338BFEB78DBFD80@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <SG2P15301MB00158D30D602950F05F8B14ABFD20@SG2P15301MB0015.APCP153.PROD.OUTLOOK.COM>
 <20180314115000.GC27868@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180314115000.GC27868@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-14T17:17:10.0170916Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2001:4898:80e8:4::467]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0008;7:XETrW1RmOD9Rfu9nEDyhVnVaOa1huk1Rx2QUupqA+/1Klj9BCTseE5nOfwWr3ienOm3NGI8GpGxneIKwjltePl+TWrOC2AYm1a3g6RkOS4GO/Naug+v/XdUSTKYRyAtj7z0AjQPvtVgv0ul9FnpVBpTSIEdyEOK45cTSf13nIg7MHwgdaEfBILPOeIt6fTY37xkR375WueCuO+H9+/mlkRcWsp2bbgzhjUgAfnfbk4AeOEjay5etM3/JtmDZGd/T;20:GAyvxCAbVSVA5W5zRmi97oXobLG5MLGrI+mGOVJtLrTakuO3HKVdpt+/kaWi95b8K5nz4icLQpmZnNFBuJG6nn10q3Aa1+JrffbUQzMo0q5BPAIshfiTuHmM3ktuO7LihJCelqAQlklguHmRrxSLJNmApnbnYZuaaMGdhiI+pdI=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1c612c1e-9cae-40c0-1c44-08d589cf6dce
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:KL1P15301MB0008;
x-ms-traffictypediagnostic: KL1P15301MB0008:
x-microsoft-antispam-prvs: <KL1P15301MB0008A4FDA96651CC5091AB46BFD10@KL1P15301MB0008.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:KL1P15301MB0008;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0008;
x-forefront-prvs: 0611A21987
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(39860400002)(376002)(396003)(346002)(52314003)(189003)(199004)(7416002)(22452003)(478600001)(6436002)(8936002)(966005)(14454004)(4326008)(9686003)(55016002)(3660700001)(25786009)(6306002)(53936002)(46003)(6246003)(76176011)(10290500003)(68736007)(8990500004)(74316002)(7696005)(86362001)(97736004)(6506007)(81166006)(106356001)(305945005)(10090500001)(102836004)(229853002)(99286004)(186003)(77096007)(54906003)(81156014)(93886005)(33656002)(2900100001)(2906002)(86612001)(8676002)(5660300001)(316002)(2950100002)(7736002)(6916009)(105586002)(3280700002)(6116002)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0008;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: AW1Ym4rdz/sffQ4nIdpZyPB9VQIyr9+S/eEkIitpjdcw+oGd2rAlmHJwuIZA2pCZv3AD4jAMrbqTcegBQkbBHh6IJrJvmmBBkS434SqH5zVb4Uy57Q7TwLMjSnAMHkpa4jIcFbIpfdh9ARZLddlD7O8euvDn4/tjuUgsLQC7XoWcKukoP8p6RJWGo1ZMsldA052yG5JcI9blkHC34M070VHkGXXKcblg5d4SNsWNOWsPceT3tk90HdWRgXfnzRoCXaEDbklu1tpx3rIyjH6kc/k1QmsylKoeYqsp00AvUIwh7WaHJHUBriFdHRPJf8s4I7f3J2giIB9lQkltI7gIRg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c612c1e-9cae-40c0-1c44-08d589cf6dce
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2018 17:17:13.1565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0008
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Wednesday, March 14, 2018 04:50
> On Tue, Mar 13, 2018 at 06:23:39PM +0000, Dexuan Cui wrote:
>=20
> [...]
>=20
> > Hi Lorenzo, Bjorn, and all,
> > Do you need more ACKs? Currently Michael and Haiyang reviewed and ack'd
> > the patchset.
> >
> > Should I send a v4 that just removes the "CC: stable@vger.kernel.org" t=
ag
> > for patches 1, 2, 4 and 5? I tend to avoid a v4 as I supppose it would =
be
> > easier if you just remove the tags if you belive it's necessary (IMHO a=
ll the
> > 6 paches are not big and it would be great if we can have all of them i=
n
> > the old stable kernels, but I respect your decision).
>=20
> I think you need a v4 since for patches that are actually fixing a bug I
> want a Fixes: tag added and I want them to be applicable independently
> of other patches in the series. Send them in a separate series if you
> prefer - I just want to make sure they apply independently.

Ok, I'll send 2 series: one for
[6/6] PCI: hv: fix 2 hang issues in hv_compose_msi_msg()
[3/6] PCI: hv: serialize the present/eject work items
These fix real issues reported by Mellanox when they tested SR-IOV with VMs
runnning on Hyper-V. I'll add stable tags for them.

The other series will cover these 4 patces which don't need to go in stable=
:
[5/6] PCI: hv: hv_pci_devices_present(): only queue a new work when necessa=
ry
[4/6] PCI: hv: remove hbus->enum_sem
[2/6] PCI: hv: hv_eject_device_work(): remove the bogus test
[1/6] PCI: hv: fix a comment typo in _hv_pcifront_read_config()
=20
> As for marking patches for stable kernels, I do not think it is right
> to send cosmetic churn to stable kernels anyway, at least that's my
> reading of the policy.
>=20
> You can easily post a v4 with patches reshuffled - I will apply them
> accordingly.
OK.
=20
> Before re-posting please read this to improve formatting (I can do it
> for you but while at it you can do it yourself):
> https://marc.info/?l=3Dlinux-pci&m=3D150905742808166&w=3D2
Will read. Thanks!

-- Dexuan
