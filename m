Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1039940-1520361058-2-11470788191321376318
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
    t=1520361058; b=suyzUgUsneRyDXPUbEh0yR8BaurAr+xg5++/N6CyviZb5Pp
    mz3/Huledt/lhssmrj2k0qgJCdXbJtrt+FJ7a71hw2w/HDAlVLNXJFU61qrQisUa
    yOjqvLhLJJgxGkgj/bGWfkanL8mowspWtXPtcOGQfDtv71U5MSmyPY5F9k9QOzg0
    zOwwg/6iPGB1U1ljwnrS79/a/JiKOvqW01Da5EPteAsN5dVnVLG75GCz2BCuqiad
    Eep9c7/EBzOWxTe9nw4tzqFkfmc5pGaXRCNwp+a2UhTc13YXfW0QxOu+M24wjBda
    MR+bEp+xxBmWR1+aRQcJzzagtExynQFKPeVgKBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520361058; bh=OIIhdv
    FZ58I4M4I4QJOdo24vTGHjWp5owX1KCki5sI8=; b=KEHMwucKxYXrJ/HYg1kuOW
    2P8QIvVVzzbNek/tZ6qhlqOidOp8+OSiL2SbCHOvSw6PKi/SaSycYiH0VIi3X0m4
    EMXLArp4fSDukuiIB8s57PzOIhFtRkYg4QsQI+TtsUOS58hXbAHo7d6Gp265PMjm
    6z0pJHhsib4dlEpouH2yHWY1XdTxQVj5Iu9PwVBZX0gViPoRbaf7IiBMJLVSxvO4
    dwtCQht1Lq3K0IAxEhb5GwL4gZjD2OD+2pf233R6PUVoc5d4gurZlexLB0YasBRC
    2Eo61BmBxv6Tnq7Pj8vblmSew40nMLxDLQnWaVe8b5JuTbRUjJjYZjeEZNrtyOCA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Y7x9UtLe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Y7x9UtLe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754028AbeCFSak (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 13:30:40 -0500
Received: from mail-sn1nam01on0093.outbound.protection.outlook.com ([104.47.32.93]:49765
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753901AbeCFSah (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 6 Mar 2018 13:30:37 -0500
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
Subject: RE: [PATCH v3 3/6] PCI: hv: serialize the present/eject work items
Thread-Topic: [PATCH v3 3/6] PCI: hv: serialize the present/eject work items
Thread-Index: AQHTtXgB6lWrZGCe00CPLCBSKQV72qPDhzOw
Date: Tue, 6 Mar 2018 18:30:33 +0000
Message-ID: <DM5PR2101MB1030ADC2C68C322A91706011DCD90@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <20180306182128.23281-1-decui@microsoft.com>
 <20180306182128.23281-4-decui@microsoft.com>
In-Reply-To: <20180306182128.23281-4-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-06T18:30:31.7253905Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;7:x9ZU5RLoarHVC9pBnl5KCZVRe0p8BhBMbPZKpD2Vmuy7wLiJ0G2VfKBDhkaDHEbHTulh6dcpu8zsz+APq13SoBarrus+LhxHxNvcbYbLyAmt65w+w6X4j2YUdCFFL6skqGPY6TVJ3DW2icVW70O1FG/8EeqhGtnfyDtDHXLqHxC0l0T8roIz5ykS5jTVtC39I+MGbPDBjytxI78uXpYTCpupzlbgNcxrVm7dTNOJyFnDRDD/rvxJx8qI/HWQQdcA;20:0L+7iimS05yoxyzqzWNoNXw8uYhr1v9pLE9huruGIlznEUaJMHxK2eMGdTfh+f/PJjt8emKuijRqeW5bBYntTTgYkvCl3+1xKwSzz1POe4WvX9I72C2PR31RwFHaySpIJ5qkoC5KosEbbll1uIxsM3o7To6FQ0SOrYqmp2XQxR8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b6b225b5-4924-4df1-a5f8-08d5839058e3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1112D1BBFF08C5B13E681109DCD90@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(211936372134217)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 06036BD506
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(366004)(39380400002)(346002)(13464003)(199004)(189003)(6506007)(110136005)(68736007)(305945005)(4326008)(105586002)(10090500001)(7736002)(2201001)(6436002)(316002)(97736004)(102836004)(72206003)(2900100001)(2501003)(86612001)(10290500003)(14454004)(478600001)(6116002)(86362001)(2950100002)(74316002)(229853002)(22452003)(81156014)(54906003)(76176011)(81166006)(2906002)(7416002)(9686003)(53936002)(99286004)(6246003)(3846002)(8936002)(66066001)(1511001)(5660300001)(7696005)(3280700002)(26005)(8990500004)(53546011)(3660700001)(8676002)(33656002)(55016002)(5250100002)(106356001)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1030.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: lswv8XvGtCo3CtNWkNgRYW+71rsMAgvbZdu0gc0MU0YzaZ5sbFlPKE8LxEmllS8VToKryubuUH21tIzGv1uNYQqcJpanOS8Woc76COlPGOsYw/fvXeBv0ELa4C1Sdi1iwhLjMmXp+YHWYda+AIl530G6HLA6i3NP7vGeHngy/tOdAgih8xtvQiQzZTmKBlSQQBnOSCnyblqRHtUXnGW2gUR8mDYxWXl25tmbFkKIZLvGmJP0ynDWVvQKpmQ/ku3JlE6nMXxMxtPfRWQBRdG/Eae4McU1embKN5Njwbfy6LNZ6VRaKHyjFJeFW3C5rnmABo0zbP9L1YPIQCucuqUejA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b225b5-4924-4df1-a5f8-08d5839058e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2018 18:30:33.1165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
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
> Subject: [PATCH v3 3/6] PCI: hv: serialize the present/eject work items
>=20
> When we hot-remove the device, we first receive a PCI_EJECT message and
> then receive a PCI_BUS_RELATIONS message with bus_rel->device_count =3D=
=3D 0.
>=20
> The first message is offloaded to hv_eject_device_work(), and the second
> is offloaded to pci_devices_present_work(). Both the paths can be running
> list_del(&hpdev->list_entry), causing general protection fault, because
> system_wq can run them concurrently.
>=20
> The patch eliminates the race condition.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Tested-by: Adrian Suhov <v-adsuho@microsoft.com>
> Tested-by: Chris Valean <v-chvale@microsoft.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Jack Morgenstein <jackm@mellanox.com>
> Cc: stable@vger.kernel.org
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
