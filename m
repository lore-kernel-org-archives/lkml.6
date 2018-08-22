Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA074C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9666A208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gRkcqETw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9666A208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbeHVWya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 18:54:30 -0400
Received: from mail-eopbgr710131.outbound.protection.outlook.com ([40.107.71.131]:13448
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727687AbeHVWy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 18:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imHNgXbevVFiuZ1U0Tv1Hb9IF+iQkgGANyd6bHBUHgw=;
 b=gRkcqETwfxiq1zIEZA5EkPHs+LVpsjSphJeLbCpTbt6ECxJ7W4g2fBp13zF+nn6/Q8mZfVzfrhtpwF51ufl4RoKRGcwd1+cffwFzE/iapmTocrE852lxSdo9fI1pmkqiBqAqeFZl5CEREwvnC0DdJMi19CGJZbOi/4bupxKss6U=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0154.namprd21.prod.outlook.com (10.173.173.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.1; Wed, 22 Aug 2018 19:28:17 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1101.005; Wed, 22 Aug 2018
 19:28:18 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     "jgross@suse.com" <jgross@suse.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pasha.tatashin@oracle.com" <pasha.tatashin@oracle.com>
Subject: Re: [PATCH] x86/xen: enable early use of set_fixmap in 32-bit Xen PV
 guest
Thread-Topic: [PATCH] x86/xen: enable early use of set_fixmap in 32-bit Xen PV
 guest
Thread-Index: AQHUOk5H7cOlSplD7k2vpIG/R9wp0w==
Date:   Wed, 22 Aug 2018 19:28:17 +0000
Message-ID: <CAGM2rebMaogjr-EbwBOxzB8GZqGqrM-4rG-m95O6O=WwzjJ2Rw@mail.gmail.com>
References: <20180817134016.19957-1-jgross@suse.com>
In-Reply-To: <20180817134016.19957-1-jgross@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0154;6:of73oMxOuB5ytX5HRMAcYsJyxlWEYiB4D9fRxlExSut0RGbC+HssZbf1RxcI9t4ED1a1z7OHKT5nLGQwT4zwuKCx/CH2RnDemlFO/Nd6WLgACExpZxorIM1S1LHnhhilWAhvB4SsLm0+Yn9If4+Y5S/C2CskH1UNnCZujpKjCXLWT7UD8Ubh2hwbyVMpeLYoaBFMQloTcB/GgP/U4tXyUDW8RX1hjL9yNORhKJQGTszoLT1VT+ayJ2NejJPF5fUH+aZ5EbbRPm71ehF1OD1N2LpPixFPKebE2KZIPHczlREAzloX9wTLRDp2Sau4yRajKul5FqaUsoYYj0g9QRHKGvLkPNYFIa9TcdMHRbdNnvwUSEkbNvRXHW7owP3iWLu3ndOo2nc/nGlTx+ZXKnvZI42kPgRpSZnjF9hxUaLmpRx3UZt3fhbw2fLWUKB8ZnzxtU8bdFTPUTl3pvOUkqbQ5g==;5:143fQocH+YboRCWl3s2I+rabfaUasjnFRfV0KMgd7kWnPJmGGgzBQp+7EAUyS9vywcZrMwIVDGNHKZ+s2LSXqmfKYs0rJsULeI8ZBP45xSYWUdBxz6tZZeWGwP4D++N9k6NCFNQla8eJC6aCzlmd3a2AU0p1bFQgIur6MEFcjcg=;7:LDxeyuZwYCTpz1e6o4swZIW9yRveFvEwdGlJjBjfL4DR5AtjshI6mYjUh96rbCNZhm90v/x7JPmkbuUlqDFAlpRbzFwAPTLcc0ezrpYJjwCU4XZ2XsE1ps1oD3E8a6TdENv7rjnHXOCErjeMtfqCJguk1+yoMF9duiuc8rE96QPNKAYXTQzXVBEfQiW4XbYYmORdgRuIEvOhbVDUoaskTn1MdpY3IQOxBAWf/2QlvSi77EZJN4GQImfJTKRDgEh7
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 715a9975-45f6-4e05-1b28-08d6086569da
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0154;
x-ms-traffictypediagnostic: DM5PR21MB0154:
x-microsoft-antispam-prvs: <DM5PR21MB01544FE0CEC7E6B10ABE359A9D300@DM5PR21MB0154.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231336)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699037)(76991021);SRVR:DM5PR21MB0154;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0154;
x-forefront-prvs: 0772E5DAD5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(305945005)(8676002)(446003)(3846002)(105586002)(1730700003)(61726006)(97736004)(2900100001)(316002)(106356001)(6246003)(6116002)(86362001)(186003)(575784001)(2906002)(2501003)(102836004)(66066001)(476003)(26005)(5250100002)(11346002)(7736002)(86612001)(6916009)(5660300001)(81156014)(2351001)(81166006)(4326008)(53546011)(6506007)(6346003)(61266001)(8936002)(486006)(25786009)(10290500003)(8990500004)(72206003)(14454004)(33896004)(478600001)(53936002)(54906003)(76176011)(55446002)(5640700003)(498394004)(256004)(14444005)(229853002)(9686003)(68736007)(99286004)(22452003)(6512007)(10090500001)(6486002)(98316002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0154;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: o+T8ACrGF9ZVCEuy81mCLoUYqOk4nlKX4xfhO6noO7ltKC6q1VQH7QJi9TvveI01Aj5rg5Qer3wyuYpXdyJ/VCP3C2gVGj0ojnyBbzBQh1kNu4pTGXdE7N8Ckco6TsBiojQPhV02KqE8ye196Zbe2Dz9X7VEJo3FKBrFyqg8b6uogDqgga6vjivxNQN+uh6F40fifUmd9XdpL9Eh0LQ7sPbG6iayPy4gQJqyP9FPqQJv9SeNLRqNBiDZalVGbs15whLWTbLjPadALd/Zad8b55W6JjQ4DbTnBlDoyr40McCP7eCNFpRfAkD3Nlsy2z34x9+kA1ihRSXFfgUqVd+Y5zEFOGvqWXmeYhGS33X9uCE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B2DCAE84E10B441B85B1DECC2CB57F4@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 715a9975-45f6-4e05-1b28-08d6086569da
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2018 19:28:17.9093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBBdWcgMTcsIDIwMTggYXQgOTo0MSBBTSBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3Vz
ZS5jb20+IHdyb3RlOg0KPg0KPiBDb21taXQgN2IyNWI5Y2IwZGFkODMgKCJ4ODYveGVuL3RpbWU6
IEluaXRpYWxpemUgcHYgeGVuIHRpbWUgaW4NCj4gaW5pdF9oeXBlcnZpc29yX3BsYXRmb3JtKCki
KSBtb3ZlZCB0aGUgbWFwcGluZyBvZiB0aGUgc2hhcmVkIGluZm8gYXJlYQ0KPiBiZWZvcmUgcGFn
ZXRhYmxlX2luaXQoKS4gVGhpcyBicmVha3MgYm9vdGluZyBhcyAzMi1iaXQgUFYgZ3Vlc3QgYXMg
dGhlDQo+IHVzZSBvZiBzZXRfZml4bWFwIGlzbid0IHBvc3NpYmxlIGF0IHRoaXMgdGltZSBvbiAz
Mi1iaXQuDQo+DQo+IFRoaXMgY2FuIGJlIHdvcmtlZCBhcm91bmQgYnkgcG9wdWxhdGluZyB0aGUg
bmVlZGVkIFBNRCBvbiAzMi1iaXQNCj4ga2VybmVsIGVhcmxpZXIuDQo+DQo+IEluIG9yZGVyIG5v
dCB0byByZWltcGxlbWVudCBwb3B1bGF0ZV9leHRyYV9wdGUoKSB1c2luZyBleHRlbmRfYnJrKCkN
Cj4gZm9yIGFsbG9jYXRpbmcgbmV3IHBhZ2UgdGFibGVzIGV4dGVuZCBhbGxvY19sb3dfcGFnZXMo
KSB0byBkbyB0aGF0IGluDQo+IGNhc2UgdGhlIGVhcmx5IHBhZ2UgdGFibGUgcG9vbCBpcyBub3Qg
eWV0IGF2YWlsYWJsZS4NCj4NCj4gRml4ZXM6IDdiMjViOWNiMGRhZDgzDQoNCkZpeGVzOiA3YjI1
YjljYjBkYWQgKCJ4ODYveGVuL3RpbWU6IEluaXRpYWxpemUgcHYgeGVuIHRpbWUgaW4NCmluaXRf
aHlwZXJ2aXNvcl9wbGF0Zm9ybSgpIikNCg0KUmV2aWV3ZWQtYnk6IFBhdmVsIFRhdGFzaGluIDxw
YXZlbC50YXRhc2hpbkBtaWNyb3NvZnQuY29tPg==
