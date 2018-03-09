Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1242004-1520624232-2-9728614553127557931
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
    t=1520624232; b=PyTJi4KLGuJ92VEOlQ12ajhXVRqkTciWDl9cOdeb5tjwib/
    6RHoQ/fcJzPk+Os59GNSdXkIEbgHEcz4Ay71jTMK9Pn5YG5hKqPHJUH3hUntOeO/
    wz8KF66IQguuZj90DejwbWfcMhnN8oAI4zrF9AOsioznBbvyZ4PtC66U+7KhDmSD
    PCgBm3tbSECmoO3wMW2P3FAAk5SV9KCHxnmde+hG/MbWe9uYUkgwzBTtO9/UMSZq
    LECugMWlSh/dqyIBCBmbwiNUYHBw0bOp9qXrhXNBg/ohG0AOzuozAfX5tVIuARYT
    Qja8iw60rjlW1HDB8LLXHz4zhXw4bpWRZwYhKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520624232; bh=mfAbKk
    wZ8RwSRd+0Of5fv6moQVepZGV+ZbEStrkDo18=; b=HHNQNFIbPT7FfKy4YJm7kC
    QRqRoL1+Gl13Nnz7Oa3pPNkg6pplUoiE1sxH/t/y0kYkr3unDK1VP6YjD1M0jlFS
    z2kOttZPUmVQdMIRS20IznYXxVw/+00aWCG00MpEidpSe13rQDv7VXZB517sxeV/
    d7A5RFAIAHKydbB1EKKX2NBWcz1qAOPo5yK+BRhGRVd2R152uDDkr4QYSngM4pVG
    3rEbIs85IEtffCoT6jfJXmMrPqMiWj3gjRvcd8LG5nGByT1TkGLotHrmHUJJUmT0
    ZmbrtMjbvJXeFRES5/3y5QxR4PO+sMxTtzDtKqDgb3KyH9D3EounGfk7+cnmosCA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=efwEODpM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=efwEODpM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932233AbeCIThJ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 14:37:09 -0500
Received: from mail-sn1nam01on0118.outbound.protection.outlook.com ([104.47.32.118]:22896
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932183AbeCIThH (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 9 Mar 2018 14:37:07 -0500
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
Subject: RE: [PATCH v3 2/6] PCI: hv: hv_eject_device_work(): remove the bogus
 test
Thread-Topic: [PATCH v3 2/6] PCI: hv: hv_eject_device_work(): remove the bogus
 test
Thread-Index: AQHTtXf/BjuCjnLnaUGMP/eWx6KZNqPIUQJw
Date: Fri, 9 Mar 2018 19:37:03 +0000
Message-ID: <BL0PR2101MB1108CF77A0EAE6689CE28A23CADE0@BL0PR2101MB1108.namprd21.prod.outlook.com>
References: <20180306182128.23281-1-decui@microsoft.com>
 <20180306182128.23281-3-decui@microsoft.com>
In-Reply-To: <20180306182128.23281-3-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-09T19:37:02.8155794Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [69.130.166.81]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1012;7:/Ap3HGNbjpVdt/0J/OLUO5yJiNE71R41rVyaIPWCSzuZJ38ZCcFnd0h7ODDfVOENg5vWFhdhRKEOzenKFVxUJJR8GzOGb/SpfrvNBdRtKc//Lfm+KGbJw9OofBaELXgHafkxXF6V33nBoVYPm+xZamH+ya7b0NJ19UrvOQvF3Fvd5d16mIg4DIbA702KRwLsEQ+VhF+jQHUvT/j2xt2goMOxLjNzrq4sdYd/2tg+ALK3lHXWMz5JTD0Rec+g0MgJ;20:tWBqmPbRkjFY/ShYJ6A/xZ8hxHBnQ/RSMLcMz/gnQRqB8mADp8jqCMyA0guIZInIDbKILJVoJUsyv6fu5v5D/wIgqzFrp6Iwm4mrOKaXncys/VOIMyP0sWfDuKYtyoWYHcxOfSnVgyALDVQZlr3iJALR+xcfCSy51QYHS49mWj0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f6ebd136-ff77-424a-8406-08d585f522e6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);SRVR:BL0PR2101MB1012;
x-ms-traffictypediagnostic: BL0PR2101MB1012:
x-microsoft-antispam-prvs: <BL0PR2101MB10125B15CF9A11A6455FA300CADE0@BL0PR2101MB1012.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(211936372134217)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231220)(944501255)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB1012;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1012;
x-forefront-prvs: 0606BBEB39
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(39860400002)(346002)(376002)(199004)(189003)(13464003)(6116002)(33656002)(5660300001)(106356001)(54906003)(53936002)(9686003)(110136005)(74316002)(10290500003)(55016002)(102836004)(1511001)(6246003)(8990500004)(99286004)(478600001)(22452003)(26005)(7416002)(14454004)(305945005)(10090500001)(6346003)(7736002)(3846002)(66066001)(81156014)(105586002)(81166006)(68736007)(76176011)(8676002)(7696005)(2900100001)(8936002)(2501003)(316002)(6436002)(6506007)(5250100002)(3660700001)(3280700002)(97736004)(2950100002)(25786009)(86612001)(2201001)(4326008)(86362001)(2906002)(229853002)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1012;H:BL0PR2101MB1108.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com;
x-microsoft-antispam-message-info: e/WTucvU+Hvdw6ACR/YYRY5BTv+uWZXMOaUMnQqK+99GdzHFsbhjXKdMdys5l8RTCkDdUdx8ww0Tsek7m/oTzc3z5yC73DARJEdKWkPGcopacGw5dtJTRnbADwaAMhQ8anmV1D3SYOaOUGjwwgL9rCVXxqBzV4+foSxXUPvhEiDplKhCy1kVYKl05yssbxGIz2a6KkJPlJwW93GIV7EJU2LKxjx0rWI/jRuXufNn7TW4VpKhv7fgwM2TevGGV6ma1zB/tdFPj92bh7Alsjt5UIcrqhURbyTSq0k2GTeP7PSEj7u5Q8V8cNe/3gdpUNvb2HkvrjYJ84ILhD1TigYHxg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ebd136-ff77-424a-8406-08d585f522e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2018 19:37:03.9375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1012
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
> Subject: [PATCH v3 2/6] PCI: hv: hv_eject_device_work(): remove the bogus=
 test
>=20
> When we're in the function, hpdev->state must be hv_pcichild_ejecting:
> see hv_pci_eject_device().
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
