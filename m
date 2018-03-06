Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1039940-1520361092-2-16372084277412754059
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520361091; b=EEsIO+kU0Dl+YrkFugaP/8B5zurs+FPSqGUG18K3bYvhs+Y
    d+kLhIazWcCXEZVeerdAGqoR/FedCBOsjsNdMSwgBLG+7k3Q+ZWzq76DL/nELZsD
    WRC3tSYa/Bgdu7nRZ4thPju/QYehvDnrtM4LvXD/Z2xPVuDjq/8VTyjis05DFyvt
    ou/garG+6W0wXoYnFsn3bD8tFzYtfs/EBxMshioYPgQ37uYDJAhGMhpPUNoGnDi8
    UjgPu1VG/p1cEbEeLxYgZsxEtp8md+u5bQu7wMjv79NmMEPZIPE1aO3pQHH3gHNo
    WMfH/cHVIzztHzE+1PGvJht+pmzB5zQPRWw7Yxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520361091; bh=J1VzzL
    M52ad1xXc05L3FvhKkLTot2ns4RdulfnX4HNw=; b=HXfV52/ePQeTSDLe1NfnVB
    0BbNmv5U71ttEy/GnjolazLpEehdrk5ydx35JIohmUs9HSk910ef3O1FuxGioKgW
    VBwe3dTEcvcjyBy4pMqi21yiPYVCdWWVTmaelxl8uTtjrj0DEMOH3m2N4TbjAGsw
    JjoCZfkLk0PNpsG0t3g4L5xrWjtpz+KE9x5kibIG1fy9lcFNivLWWpByX7vmY8JZ
    6sCmpT2L5ragBUSMN/5uDWAfnMJY/FTuGynzJsePfor/M9PJ7hDB8FN4ik1y5OFS
    W6Ek29bCquPwIazUbbMe5Mjqg4R7MHuE3V0PEJssP180AvIp3F8sNdjD1fKdAJyw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oiezNtlc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oiezNtlc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932804AbeCFSbN (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 13:31:13 -0500
Received: from mail-sn1nam01on0138.outbound.protection.outlook.com ([104.47.32.138]:23134
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932753AbeCFSbM (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 6 Mar 2018 13:31:12 -0500
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
Subject: RE: [PATCH v3 4/6] PCI: hv: remove hbus->enum_sem
Thread-Topic: [PATCH v3 4/6] PCI: hv: remove hbus->enum_sem
Thread-Index: AQHTtXgC7sFn0ihnGUijpdbsTUKmxKPDh3/w
Date: Tue, 6 Mar 2018 18:31:09 +0000
Message-ID: <DM5PR2101MB1030C8B38BAFA59EDBFFA308DCD90@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <20180306182128.23281-1-decui@microsoft.com>
 <20180306182128.23281-5-decui@microsoft.com>
In-Reply-To: <20180306182128.23281-5-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-06T18:31:08.1929449Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0808;7:8dhXeQsUY9+66gT6HMxug4Dwh/zpGyKrUzi4bFM4pALGIWQq7irhPqNSASyyX9x4fSagy//UuUSN2WpO7JQXEv5/ogL2hMT5AelP7in0e4OXEZzG59luHc/Btm+Yw48wK4eyAHUvRfGWCiYL0/xrPqstEmA5TLMz1di0O7FLb6AbndU2Apb3+ldXeh3jHIaMBlH82/ZWhYdyPXeeN40x4K3QcLGpCRNMvCgEzr3Zy0cQAHlbgzuzqzb8+pzTKZV4;20:zNyVUSBEjdTSovArezaDs1CRyoo6bIxrNjxdnnimNVlEUuFGyxQiZSRCzPpII+YC0qe0dEh9U8lB5Zj79VKupTiz3YsnZsXmPodfYdSW3qSpdvvII/j1aVzp2vUbc0Wu6TsF0qWltnYMWZQRbe/MFQgNNlK30CyYxK8AZ9UOpPA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bf0af4a2-151f-4f0a-ba09-08d583906ebb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);SRVR:DM5PR2101MB0808;
x-ms-traffictypediagnostic: DM5PR2101MB0808:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08087F5EA261F97C0674A183DCD90@DM5PR2101MB0808.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(211936372134217)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0808;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0808;
x-forefront-prvs: 06036BD506
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(346002)(376002)(366004)(396003)(189003)(199004)(13464003)(74316002)(2501003)(6436002)(33656002)(3660700001)(106356001)(5250100002)(8676002)(5660300001)(81166006)(2900100001)(8936002)(81156014)(7416002)(53936002)(25786009)(4326008)(9686003)(10290500003)(14454004)(72206003)(6246003)(478600001)(55016002)(3280700002)(305945005)(7736002)(66066001)(97736004)(1511001)(86612001)(53546011)(105586002)(7696005)(2950100002)(6506007)(102836004)(110136005)(54906003)(6116002)(68736007)(3846002)(10090500001)(76176011)(2201001)(22452003)(99286004)(229853002)(86362001)(2906002)(26005)(8990500004)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0808;H:DM5PR2101MB1030.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: feMnRqtTy82/yZVRy5/9p2KF5Y4pOxqPFFvKFxF8t9FHrbkz8UP4Nabz1aQm+NmDavGFUUAlik5qFXfdm/m6INpdPEXwUHhykf6B7ixH7iwA3PdayF5x6UArcB3vkdSo35AhcDmqg0trItlHpuVL50nlL71T1K0XwlRGu9Q1fRYP+OyqgQ/Dm3Ox8EpwMHBSXhjWea25J5k4KluIWrG7vBp5Br62oMc8YKd2F5WbgTombJjQGtg+Rnss4HfOIuelXbVAEr5NgqwQgHm+018h0hSQbE2QcsiQOrcHEa3gze4q0ledKJZ+k3LRtej1Z+vuqgIztamarf9Ab0qBrqjhkw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0af4a2-151f-4f0a-ba09-08d583906ebb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2018 18:31:09.7097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0808
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
> Subject: [PATCH v3 4/6] PCI: hv: remove hbus->enum_sem
>=20
> Since we serialize the present/eject work items now, we don't need the
> semaphore any more.
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
>  drivers/pci/host/pci-hyperv.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
