Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1039940-1520361163-2-12509165586783707062
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520361157; b=uNO0xI0ipVc3LdbuBdBcpjvWEUUoEL+fKdFI0QUjEdkRpxD
    BWdyF6ZfWaL3FpibG29TB44wDcJva/58gGss7KZJtTTH3JMA+PYGd9KByCxvbhmw
    hu1ZYcJGQ5JyWkDjEZi1Lz4pZzYkUg4H8nV9cr6pRzd8xGFyjSsWyxQzS6mZQemx
    EQolOypYGSevn9FiPpY8Ax1Si1aMhbcMBh11B7WXuv5lPahCqtacOOOTCF6Bhqqi
    m29Ri7zF7/tZvq0eamBH7pP0uTZPHC+TGiaIwVUgxuWcox1SyBvpXCNIG+2Do4ld
    oGpcH0nyhjjrulLScrP4+OGJh2azkpMPCGD4Lxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520361157; bh=4NOG7S
    hFztCTtKhhZKyQQccyAhleDRsNr9HZ8JjEBcI=; b=DwU+N/18mqSi6GBGfprrKL
    TrIBEGGC4KgTngauNizVnCrBwVxpyZburbV+KZNKZpy2vxkKyKhT7K6d0HnV7DO3
    1WPBInXDcFFUi8j0M53xhldaDFWjv0tazla8XuklU0Xce85x70VFn4ZViEvC7pRr
    RQlfSYlT9Pc9/VKJgh/EsfguMEt8vf8wWCIsCIm/sMgVIJ39aqE6Zr8o+Ct4dd7e
    C/mbSLJj+EpcrDmMICObRn9k6qF7Km16ybXvZaRgSVtvoleNtT4f+rHw08Gzg8k+
    Hae27Qxf1d7L7RkK1JaQZgVKlqt6UJnPFLcTEZSmPkq27028KlJDxZyzFgHdiDug
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=efUJlD/Q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=efUJlD/Q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933158AbeCFSce (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 13:32:34 -0500
Received: from mail-sn1nam01on0118.outbound.protection.outlook.com ([104.47.32.118]:37703
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932182AbeCFScc (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 6 Mar 2018 13:32:32 -0500
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jack Morgenstein <jackm@mellanox.com>
Subject: RE: [PATCH v3 6/6] PCI: hv: fix 2 hang issues in hv_compose_msi_msg()
Thread-Topic: [PATCH v3 6/6] PCI: hv: fix 2 hang issues in
 hv_compose_msi_msg()
Thread-Index: AQHTtXgFdCO20wAcVUqfkAuQIELq66PDh95A
Date: Tue, 6 Mar 2018 18:32:29 +0000
Message-ID: <DM5PR2101MB1030B09B080E5854B0E7B9A9DCD90@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <20180306182128.23281-1-decui@microsoft.com>
 <20180306182128.23281-7-decui@microsoft.com>
In-Reply-To: <20180306182128.23281-7-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-06T18:32:27.6766897Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:tHfjbULNXxNGOkTAy/6N13VQQYTwmgF0uVml3t9tSEqtDWh8ieb8N32XZFnJGQMxUibs3ke3FX9Y6PVod0UFGz3yb6CvDvnKgVKOFfOL5WfYTZjOzY2Wn7DkM5iEiCRcURjG0VNfyI8MT3qwezoVZCHu5pQ2xJRseqo6VdUnPe3eYI+G/hb0aui8AgV56syX8PDCz+UCW4yHa0DG0KQkx6TNnY2qSg5F4e0woEHmqOkdwKOvL/kkHJeLXD0fksOB;20:kJNpTImTvCNlCRkjQo/X4Sm8opWz052a7lmWkNy5grNTHUonwponyu96TZRsgXdB3e1bnDrCpRlnhdwkxN3FVimeSkPweG6Cfiqlii3yEvmndA5vLE6BQlGN4w+uemYfn4VYLhnPgv4yVJ9abY+UTXq4tpoQFUIIf2RcfdqInBQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9c2bf51a-2c3e-44a5-30ac-08d583909e04
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0805FA7B4625ACB942BFEBB0DCD90@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(211936372134217)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06036BD506
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39860400002)(396003)(39380400002)(199004)(189003)(13464003)(54906003)(105586002)(8990500004)(25786009)(2201001)(59450400001)(6246003)(99286004)(7696005)(22452003)(316002)(10090500001)(76176011)(26005)(2900100001)(6436002)(6506007)(55016002)(3280700002)(53546011)(53936002)(9686003)(4326008)(110136005)(5660300001)(86612001)(1511001)(86362001)(102836004)(66066001)(97736004)(14454004)(8676002)(81166006)(33656002)(72206003)(81156014)(478600001)(74316002)(6116002)(3846002)(2950100002)(68736007)(106356001)(229853002)(10290500003)(5250100002)(2501003)(305945005)(3660700001)(7416002)(2906002)(8936002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1030.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 9mUghOwlhchdmwpgiDDvpnZZ2m/0xwEJ4N+lb+Bf7NAGem8YeaunRsL+JdVRsq+i5e2F1gLOIr6CTSOy+NzFrI/XKv0oTlmJqu5QJyykoUy4HWALRs6QW7sJEElzAng/XvXzDXVy6V0wFHpeeFNFXC2Ci7gVftx9uZuzaiFXd2l7+zikGd6lP2Nc/FRbolsXokRkpP8eGgzqAFOxXEbnSx70gsCcM9e2qB7ewYbVd6KTz1pUDifKjJUUTJJzUcXeSy1NU/7fIp6ExuLbesWVwErz15VvxL8fNG4NOFGfBgt5Rj95C5OVWukvKG/a1Ui4IN0g7HfOpz1jfIumw7WUZw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2bf51a-2c3e-44a5-30ac-08d583909e04
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2018 18:32:29.0535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> -----Original Message-----
> From: Dexuan Cui
> Sent: Tuesday, March 6, 2018 10:22 AM
> To: bhelgaas@google.com; linux-pci@vger.kernel.org; KY Srinivasan <kys@mi=
crosoft.com>;
> Stephen Hemminger <sthemmin@microsoft.com>; olaf@aepfle.de; apw@canonical=
.com;
> jasowang@redhat.com
> Cc: linux-kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.org;=
 Haiyang Zhang
> <haiyangz@microsoft.com>; vkuznets@redhat.com; marcelo.cerri@canonical.co=
m; Michael
> Kelley (EOSG) <Michael.H.Kelley@microsoft.com>; Dexuan Cui <decui@microso=
ft.com>;
> stable@vger.kernel.org; Jack Morgenstein <jackm@mellanox.com>
> Subject: [PATCH v3 6/6] PCI: hv: fix 2 hang issues in hv_compose_msi_msg(=
)
>=20
> 1. With the patch "x86/vector/msi: Switch to global reservation mode"
> (4900be8360), the recent v4.15 and newer kernels always hang for 1-vCPU
> Hyper-V VM with SR-IOV. This is because when we reach hv_compose_msi_msg(=
)
> by request_irq()  -> request_threaded_irq() -> __setup_irq()->irq_startup=
()
>  -> __irq_startup() -> irq_domain_activate_irq() -> ... ->
> msi_domain_activate() -> ... -> hv_compose_msi_msg(), local irq is
> disabled in __setup_irq().
>=20
> Fix this by polling the channel.
>=20
> 2. If the host is ejecting the VF device before we reach
> hv_compose_msi_msg(), in a UP VM, we can hang in hv_compose_msi_msg()
> forever, because at this time the host doesn't respond to the
> CREATE_INTERRUPT request. This issue also happens to old kernels like
> v4.14, v4.13, etc.
>=20
> Fix this by polling the channel for the PCI_EJECT message and
> hpdev->state, and by checking the PCI vendor ID.
>=20
> Note: actually the above issues also happen to a SMP VM, if
> "hbus->hdev->channel->target_cpu =3D=3D smp_processor_id()" is true.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Tested-by: Adrian Suhov <v-adsuho@microsoft.com>
> Tested-by: Chris Valean <v-chvale@microsoft.com>
> Cc: stable@vger.kernel.org
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Jack Morgenstein <jackm@mellanox.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 58 +++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
