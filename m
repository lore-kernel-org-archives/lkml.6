Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1039939-1520361116-2-9477624590902369734
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520361116; b=KQTCfF8+znEKcyU/8tJ0G6xaCLuBaNiwqkLQS7w82kX81lL
    Anvs8zNQxtp9RAiaUwQouveVc++zjJk3pM+ppfu7hEwKHyvR6euuP2GAGI+kn6Rc
    NFAheCWqbmZF7ktDJePipTUdd+dvcILJ0jIpVfq42Q7c8ywMqpB8LE1jozuC4LKm
    UpjNW+m2PwAKchz3Ds3Iy3FaTcBvo42862CtuuUy+Vtf3eGhJBtLL80kI3HNPade
    nEBqgED/JH1HQKNNbCSxapUh7dnYyt7ZgnFBbGxQ1pGG0UNI40kNHxciwk3dwFfg
    1Ylri4UdlLMn92nV47J+mpktYV3d6hMBBvE/W/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520361116; bh=GYE43q
    wEBWv/LusnWU6+vW4I+GjRj/qponhaDvDlV5U=; b=Oi/wrTrqn+SIYAgZLDmix6
    lhMbexO3UI6vC8g3ugNxQ0t0mEDsJ3SZn9e4vMToPv4qGBInmRHcvqMVZjDqO6L0
    YD1UloGN9igUsQvrnQlmbWE44gxV6i10P2i+XJmtC4vafPU3FU6n+bFDNo7wD6LL
    MzDlh2GreNPXHS0flbbRyVxVs1nkQZ7iesmbi/1qX/l2jhm6SeF1hh27aTPbgryL
    FUJA3yAR7Y4/XKlIDaurLTAXEJpay4Y02zFezpwyw42MiZe9uBm+UcIjlqvxDFnd
    hVypHlAKljLd5q1v3ATTPIM0wHvrlogJlEotMb00gK1EvPExHyDnUCI03KA0lc0w
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OXfrE+9B x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OXfrE+9B x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932613AbeCFSby (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 13:31:54 -0500
Received: from mail-sn1nam01on0135.outbound.protection.outlook.com ([104.47.32.135]:56224
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932112AbeCFSbx (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 6 Mar 2018 13:31:53 -0500
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
        Jack Morgenstein <jackm@mellanox.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3 5/6] PCI: hv: hv_pci_devices_present(): only queue a
 new work when necessary
Thread-Topic: [PATCH v3 5/6] PCI: hv: hv_pci_devices_present(): only queue a
 new work when necessary
Thread-Index: AQHTtXgDV0gFreswJ0+dCeB1Pa2oMaPDh7Bg
Date: Tue, 6 Mar 2018 18:31:50 +0000
Message-ID: <DM5PR2101MB1030E50AF7A98DF19359D853DCD90@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <20180306182128.23281-1-decui@microsoft.com>
 <20180306182128.23281-6-decui@microsoft.com>
In-Reply-To: <20180306182128.23281-6-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-06T18:31:49.4442004Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:wuC9/FFigzorUAmTzGqdIEPR1XCpwnAG5KtVDwisLIif+s3lx/bwMfe3q2mMQi9pCeIOFnQ6030SEmMzGT5H+kVUUAAaN3+VZU6R+kGmE4wciTulhNqmoo/LVCzW6Gt49txrEfKepySQCYN5CV+TDj3XS3iU6m7GwfCEgaKlwovTsmJEVqwsi/ZwdfYLrEiD4mVYVvmRbOr7GHoa/HrKUt7/3v4zW1JylTZJpP7QnuVFSiBqUo/gqRtd4Kj8Gg2y;20:6VLGEMEHsqa65+X4QhqrjBDRXHxFtfqL1bJkhBHGMsGI4kof6MMLwDakaU56+nZhDNO8552Z0dUI0G0ATgfr2ioaRhQsSII4ZGjSlD4ISOWTn5IwDqBv6KGm4lTSnNNE+uVRUVvcw0TInkmCl+UaKWZffzB3M/HLU8kSA+dhpDk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48bd863c-3aeb-4334-19f6-08d583908738
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08050E533B008F8F4014BE7EDCD90@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(211936372134217)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06036BD506
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39860400002)(396003)(39380400002)(199004)(189003)(13464003)(54906003)(105586002)(8990500004)(25786009)(2201001)(59450400001)(6246003)(99286004)(7696005)(22452003)(316002)(10090500001)(76176011)(26005)(2900100001)(6436002)(6506007)(55016002)(3280700002)(53546011)(53936002)(9686003)(4326008)(110136005)(5660300001)(86612001)(1511001)(86362001)(102836004)(66066001)(97736004)(14454004)(8676002)(81166006)(33656002)(72206003)(81156014)(478600001)(74316002)(6116002)(3846002)(2950100002)(68736007)(106356001)(229853002)(10290500003)(5250100002)(2501003)(305945005)(3660700001)(7416002)(2906002)(8936002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1030.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: O0Za/a9TqFPtpQr85zcwtb/Ak3FP4zrpAuDc6+2EAjtpY39XZebrJNf8zeKnBO1NXuJhmUZJ7KKPsrbig4VCASO1nVbvNAUa9ElPrE6u2tHaIfQdITa0PE7LT3eaysxRw3zkYXhiAwoZ+OYbbuYcMmTi9xfyStYZ4Kb7b7LVF9FeEl3nV1lAJkliy9SWyWXJMiQn4Qa9jPLGTvzbRnqb86OtxJ/hSRr3RmQ4C8yv+tqxVH0ghFBZvhbjMDzqJUA2XxNcrJxxwF2N4T/ELWI65C5tVe6RS9CeNjXHBqz28otkeqH+q+y6tZOQV5GANinvprI5ZPhc7LMar+lCCdgg1g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48bd863c-3aeb-4334-19f6-08d583908738
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2018 18:31:50.8202
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
ft.com>; Jack
> Morgenstein <jackm@mellanox.com>; stable@vger.kernel.org
> Subject: [PATCH v3 5/6] PCI: hv: hv_pci_devices_present(): only queue a n=
ew work when
> necessary
>=20
> If there is a pending work, we just need to add the new dr into
> the dr_list.
>=20
> This is suggested by Michael Kelley.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Jack Morgenstein <jackm@mellanox.com>
> Cc: stable@vger.kernel.org
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
