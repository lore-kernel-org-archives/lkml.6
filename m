Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1266598-1520624321-2-4629353172099028724
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520624321; b=tuxG1/K7cGmJ+kF4xwepm72sM/78BIzCCH3/L6e34hOE6Kf
    P8/85VG4Rf2ljegpQ9gNnqJi2nbFhV1nXKlITQ0us5W3tqet/OIi1zr1D4C/rRMm
    CujPPVQHyJ4RZ3kFCQ1qbxy31YWI6qVGn58aIdYLFZ9ECCpgH8TKGPWijeRJgm5A
    t485AEGuxZjMOJKmxzvBYfHtElB0BQoY4WfZqxAwGldERoPfvpwcX0Fc901tn08z
    ptMsBido2GQKoM/qh4pYEdfzRpRg3lc3k1KkUnHYAKJBWeOuSWLImjhnAYd+LkwM
    bNyVjIBbtJ8OGG2hyJ5ImfXm4R/KLaAeXfhRxOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520624321; bh=xlKmJG
    rdmchAeA2oW8tnInBy4k6TwOxko1vblUuz3jA=; b=DTeKEYK/kcHeGhi6pTyEAK
    V8CB0K/nxnAIazIRs736XkkA6pd+7RpFhiHiLsaS5wgaZlzwrgtVd3iafHPXHDRI
    gRcUdvvgPYXYPnTle9B1azWI1zVZEzOlDTSdOV6N2BgysYngM8q96pJz/TggwclS
    IILIp2TFFlDvrllk/pxhABTL3XVPhK+I8Zfsvkues23FfT4FHOYiqqnFfhCkfuRu
    MiOP2w5ZDBY0Pso7e1WqM7x7CkZsSTdIf6hexOI8feiFKWD2e4EUV+cRh0BNUE42
    clsKi/VUkFbRaRoRfDnZQKwjQfNeLFdCpBWoExjiUsieueVdzEd2NuEHl+4l1nNQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dLXCYJTY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dLXCYJTY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932661AbeCITih (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 14:38:37 -0500
Received: from mail-bn3nam01on0090.outbound.protection.outlook.com ([104.47.33.90]:51990
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932288AbeCITic (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 9 Mar 2018 14:38:32 -0500
From: Haiyang Zhang <haiyangz@microsoft.com>
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
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Jack Morgenstein <jackm@mellanox.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3 4/6] PCI: hv: remove hbus->enum_sem
Thread-Topic: [PATCH v3 4/6] PCI: hv: remove hbus->enum_sem
Thread-Index: AQHTtXgCVAF0Xze1t027H5Kt+JHCGaPIUSng
Date: Fri, 9 Mar 2018 19:37:37 +0000
Message-ID: <BL0PR2101MB110858EC9CB2798E28FDF013CADE0@BL0PR2101MB1108.namprd21.prod.outlook.com>
References: <20180306182128.23281-1-decui@microsoft.com>
 <20180306182128.23281-5-decui@microsoft.com>
In-Reply-To: <20180306182128.23281-5-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-09T19:37:36.4665134Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [69.130.166.81]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1107;7:PqH3IHixiEhrjhBTsGgKCaTchSL38IcZJ2Ip9BS4xM1lY+fe3YCgxpzyBT5o841NBfQnba0kHTWIyZeo9PWv+6nM5qmciTq5ywDRV6Pcv6PGVJRUKSWzxwVHiVWD1oY0F3ONEc/MjBJ4gYEY7drdBDLBhNwVgP0n4UZin8yTkoEhJZLWSiMf2O5RrgyUJkveIyZUG8XVPs4JikUlARX5tkl2pN9KFwbfhbApnkpcCJHl3MAYhs9TOGbU+F6qKz9R;20:R6ylJzX5cB6ZC4smpNTCJWlZt7kcOUlQW3/MzrxfQVNHfuYThNx7v2KqHNjuHbw4jL/Un5RMv4PZ55W1LNuaW7mYhYsLXS1Dkw61aPn3pkOvUWb7zkO6gasOya9uvcb9sx57UzbGaiTtE7z6N+iO1vFTcQ4ede7v6athDuWwNWc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e22eabd-95fb-4529-6388-08d585f5559a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);SRVR:BL0PR2101MB1107;
x-ms-traffictypediagnostic: BL0PR2101MB1107:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com;
x-microsoft-antispam-prvs: <BL0PR2101MB11071A92B60F7C6CD1F20E6ACADE0@BL0PR2101MB1107.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(211936372134217)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231220)(944501255)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB1107;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1107;
x-forefront-prvs: 0606BBEB39
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(346002)(376002)(39860400002)(189003)(199004)(13464003)(66066001)(53546011)(26005)(478600001)(6506007)(97736004)(10290500003)(86612001)(2950100002)(76176011)(2201001)(4326008)(86362001)(6246003)(102836004)(1511001)(54906003)(8936002)(6666003)(110136005)(8676002)(316002)(81166006)(81156014)(74316002)(106356001)(33656002)(7736002)(305945005)(2906002)(25786009)(7696005)(5250100002)(2900100001)(3846002)(2501003)(99286004)(6116002)(8990500004)(3660700001)(10090500001)(6436002)(229853002)(53936002)(105586002)(55016002)(7416002)(9686003)(5660300001)(68736007)(22452003)(3280700002)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1107;H:BL0PR2101MB1108.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 7fHhqtcJCg2wesEPKVfh8KA0GgItadDxDsEc+VueCoWlAz8VOQloZ1XvrCswe2bZHYi43v5iGAsEKIzAySQqSsuVLN0lZt3EfPzKS5URTxJUIukYrjO100J5Hh0IGbnfhnZZ+LG+E8N33joC+6zM/8fVz5yo6VoeWFUAXqtJ8nQ/w+EmtFvjhftvp1zod5k5g+cFMc5iU8VryVU3/FyBh7xQ/MA+VaksSnggxolKoUMqMQ919OdhtNc+4ojAqhaIs0o+1vKxGxuxWc+0ALugALAY5r/hf276AGtPU4uthGpIcHa8JLKi4a/yTrz5B0H+9QbVjPS51cibeYX7U/dpfA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e22eabd-95fb-4529-6388-08d585f5559a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2018 19:37:37.6903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1107
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Dexuan Cui
> Sent: Tuesday, March 6, 2018 1:22 PM
> To: bhelgaas@google.com; linux-pci@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> olaf@aepfle.de; apw@canonical.com; jasowang@redhat.com
> Cc: linux-kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.org;
> Haiyang Zhang <haiyangz@microsoft.com>; vkuznets@redhat.com;
> marcelo.cerri@canonical.com; Michael Kelley (EOSG)
> <Michael.H.Kelley@microsoft.com>; Dexuan Cui <decui@microsoft.com>; Jack
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

Acked-by: Haiyang Zhang <haiyangz@microsoft.com>
