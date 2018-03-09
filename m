Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1266598-1520624215-2-2387465246535707523
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520624215; b=GcsSBbEhxhgUF8nI7frSPa8PxNjrVpX5sRQ2/cxCZuBr+aw
    6/XJzUMFZ6jw2Ui6CdrecKfxHacbtDKXkbli4bS6DWbCoemM2SFfJgX3uDTODc0X
    t9pt3tZvkllGMivaozxRrnVR9/Chqwz3hb6EU8NKPMaHDkfFZBK6LUJPX7TEbcy0
    PfpZREMeXRxoqVLMEkRwPffpmOST/4ZQto5WKhD8Y+6arazm7GLixvdpbr/lb0/n
    2AWibGKaySYp0RFHU5ZLw792xy6R48BG0JS+yJty3L0BEwFyZLGHmgW51hNVGGdf
    TpHqhtEC8s8QufDZh58qEXIcWOeQFWuooLODDnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520624215; bh=C7UB0A
    Mv7cOQU4tgjdRDFrQnE03Il6WX8dme0o32DGY=; b=jKZWLvhrCn9PQ/ktr11K1s
    YUOL+cLEtDGvuNtEv2N65Y/EB3KIvvZTV3jbG4LyP+1Wpt/YUcJCq/1tcueRBW2P
    IAkkwkImwDS31cU3cz80taGUkPxZi+s5+cVSb18Cx7axQeIyPwjllQY+RIQOV9LY
    i0Ka3JdjE2FPd8+O+7dcAq6bPaaNBA0WppqsCovspamjd3x6UYrvLNdEDfJuHeQE
    DmIkpmNg0thA8fE5WP+8VFkWBi6Zg1MHbCgk5Xs4MkFdNVGp3A3x+mtRAwWQUaBq
    0sTC9hYmmFIT4SHKzXE/w4w3vPC40QG1aM1UOpAawOWHxWG37+XT3UMuqlcfVfzg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KIcl0Xax x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KIcl0Xax x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932221AbeCITgx (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 14:36:53 -0500
Received: from mail-sn1nam01on0131.outbound.protection.outlook.com ([104.47.32.131]:40444
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932183AbeCITgw (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 9 Mar 2018 14:36:52 -0500
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
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3 1/6] PCI: hv: fix a comment typo in
 _hv_pcifront_read_config()
Thread-Topic: [PATCH v3 1/6] PCI: hv: fix a comment typo in
 _hv_pcifront_read_config()
Thread-Index: AQHTtXf+1/APsie5jk+8YyH+J8BagaPIUOoA
Date: Fri, 9 Mar 2018 19:36:49 +0000
Message-ID: <BL0PR2101MB1108E9E17C9C35BA1A2E5311CADE0@BL0PR2101MB1108.namprd21.prod.outlook.com>
References: <20180306182128.23281-1-decui@microsoft.com>
 <20180306182128.23281-2-decui@microsoft.com>
In-Reply-To: <20180306182128.23281-2-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-09T19:36:48.0840547Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [69.130.166.81]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1012;7:iXs3If4qduIU4fAClJ068VGjb2JxpNwlGrLSIuo1QH2yGXJaFJvTpS7kHhV8FS/cP9BaS6B8/RvTQp8I7l81nBiGkrFLzRdc3GgvwyyfO/Lambin7Vh9EHmUSpy5AEMVX1EHnrvSrYab7oEeNGmeVES7ukVYQGSV0c6rZ6b0hPiS0xVdv8vKDQQDAW97DRvyLPyfu8r4xAiU99QnPNeTKWv0dHfVUa5ObHrawWIKKu3NpRF+HzLAXIoN4bfjB12W;20:kMjeWNozpclG5mHZJjwcuZPRC3MD4VLYDEmITlgFOkewyfXOt7orQBNbiD5WQneI5Kbrb7T14yZXuNIiUYMvs6YH0zccv5F9bPl8xZNkfXTl8pL3XLrXdcdUUMs1yrHBDGWjavsJmv8i8gOJwVefOqCS0adCSK+UqJvJvxJd9Fs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 56150212-a0b3-431d-79d8-08d585f51a1b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);SRVR:BL0PR2101MB1012;
x-ms-traffictypediagnostic: BL0PR2101MB1012:
x-microsoft-antispam-prvs: <BL0PR2101MB1012C9A85BE43BE1DB3AA927CADE0@BL0PR2101MB1012.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(211936372134217)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231220)(944501255)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB1012;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1012;
x-forefront-prvs: 0606BBEB39
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(39860400002)(346002)(376002)(199004)(189003)(13464003)(6116002)(33656002)(5660300001)(106356001)(54906003)(53936002)(9686003)(110136005)(74316002)(10290500003)(55016002)(102836004)(1511001)(6246003)(8990500004)(99286004)(478600001)(22452003)(26005)(7416002)(14454004)(305945005)(10090500001)(6346003)(7736002)(3846002)(66066001)(81156014)(105586002)(81166006)(68736007)(76176011)(8676002)(7696005)(2900100001)(8936002)(2501003)(59450400001)(316002)(6436002)(6506007)(5250100002)(3660700001)(3280700002)(97736004)(2950100002)(25786009)(86612001)(2201001)(4326008)(86362001)(2906002)(229853002)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1012;H:BL0PR2101MB1108.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com;
x-microsoft-antispam-message-info: 55xcKdYyM0vEolEAJnlty5H7L/4OOgQVCF3uZ1y0SLHbrLe9WSJ5Hi10TUdlQXnRw4CZ70rdfNvyPb2trSAhctwL442G44oJ4GIJZJoDV77JmxK6DDd1gnlHInXBpIzE0Zqa7YQATrpom105bR6cEW+jabO6Bkj5yBz9mFv/KEF3C+JCZenioiolmFJ1QDZB7Gmshy0RMkTJa56VlGbT1sNUvH4EkvZarmsaO6ncptc6Otk64AaIpyMHNjbbSlpSx4QIt/JM3Zl/RrWtx3M449DdHt4yWF0v9Bs7Wgk5VJWIeqzz/+f5eowaDTEWfrAlZGXIXCNNBVbvuPCtBZqkEw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56150212-a0b3-431d-79d8-08d585f51a1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2018 19:36:49.1881
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
> <Michael.H.Kelley@microsoft.com>; Dexuan Cui <decui@microsoft.com>;
> stable@vger.kernel.org
> Subject: [PATCH v3 1/6] PCI: hv: fix a comment typo in
> _hv_pcifront_read_config()
>=20
> No functional change.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Fixes: bdd74440d9e8 ("PCI: hv: Add explicit barriers to config space acce=
ss")
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: stable@vger.kernel.org
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> ---

Acked-by: Haiyang Zhang <haiyangz@microsoft.com>
