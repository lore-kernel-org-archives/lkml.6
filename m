Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417DAC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E929720824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="TwusgNnW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E929720824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410083AbeKXCIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 21:08:10 -0500
Received: from mail-eopbgr30058.outbound.protection.outlook.com ([40.107.3.58]:62800
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388306AbeKXCIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 21:08:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+qTAOFWA3lJs4iHchep8y4lKzGRkFf7k480zsP78io=;
 b=TwusgNnWT4GR4UIwPfmbKDWX0hFXM1TM9+kW1NJbG46VXSJIkukIaO+XOYP2E7xLSeI3Z4Qpxpf4DluD574zSSx8XGzF6NIYL82VojE9KA/aF8iX1VZV7N/TNg/fkpPK4wI+yKagWYdRdEoENitRyLgeq+Hmep5Q6QTrg7SiMzw=
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com (20.178.13.96) by
 VI1PR08MB2941.eurprd08.prod.outlook.com (10.170.238.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Fri, 23 Nov 2018 15:23:30 +0000
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::b9e5:694c:a7d1:d37b]) by VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::b9e5:694c:a7d1:d37b%4]) with mapi id 15.20.1339.031; Fri, 23 Nov 2018
 15:23:30 +0000
From:   Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To:     David Newall <glibc@davidnewall.com>,
        Florian Weimer <fweimer@redhat.com>,
        Daniel Colascione <dancol@google.com>
CC:     nd <nd@arm.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Vlastimil Babka <vbabka@suse.cz>,
        Carlos O'Donell <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: Official Linux system wrapper library?
Thread-Topic: Official Linux system wrapper library?
Thread-Index: AQHUeYuU4J3dLZKEX06mfdiwAKJEwaVKawj+gAA1+ICAASqMJIAAVfkAgBFOAaeAAAohgIAAFDkA
Date:   Fri, 23 Nov 2018 15:23:30 +0000
Message-ID: <b0c3ecce-c4d0-246d-d702-21674f950e34@arm.com>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com>
 <877ehjx447.fsf@oldenburg.str.redhat.com>
 <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com>
 <875zx2vhpd.fsf@oldenburg.str.redhat.com>
 <CAKOZuetdgk1QYhx1538-98rFpogMin=8DkPnCtU9_=ip23Vk7w@mail.gmail.com>
 <87efbbvrx9.fsf@oldenburg.str.redhat.com>
 <a50dbc52-b5e8-6684-508d-b96ad8d70d4f@davidnewall.com>
In-Reply-To: <a50dbc52-b5e8-6684-508d-b96ad8d70d4f@davidnewall.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-originating-ip: [217.140.106.49]
x-clientproxiedby: CWLP265CA0352.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:5a::28) To VI1PR08MB4223.eurprd08.prod.outlook.com
 (2603:10a6:803:b5::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB2941;6:LOF8ajeGnIOIQe2ae7bOHQFSjauty+vm7XD1W/hOYA9ynbo7g1qTi1C+MThQm+eiQ0NK+8wks97X/sYt9Pz60mP/KSZXZtdTj6xkz8b6n1tCXurJgxwmjpESMm+LybC4F1kAWqIMP1Ipf0gAo3Ij79CfIsfGh087nyuSYZG58sBZnp++WNsWdyzvKA7rgSA6Ic9id6K5/PbpYjgFyf6snTfhJNEk96kLLTASpETHKef4Q59fW/JWb2iMPT4eUJbAilSEhnHyqMqfUBOWvGiLQzSZvSEWe7/TkOINhQIZtzfHclHTWsjI+tA4GHBZAaYRyWSzLXcgC0A2Z+fnfbndkJQqj8QDBqJhYVb7TvRb7YFgd44tlV93AQBgsVpGjRKPOs7CvodeGaQ3PZLn/KRctSybyp7h4JOZhlqrLqS9KqO4yo6+7hlRhYgrgIV2+fu32gcPjT14Xr/LHKq2xQ5AOw==;5:xoaXxgaNLQHnaPp9gOQ1nio17LeK0E83NlW1tGNRrMzC24gm/jGk0aH3RyH5BpmpJV4hCvQ2cqcWPyMALuEGDS0xcWZxDnk1OfWMzEAQz477+R/VsL1XklVTqbOqN5qfw+9gVrODhTbSQFy9njNHeKNss7TKSigPS+gKBAnEOU0=;7:ihowNm71txTGqR83HfONKeO2GYc4tWRYFUhK3IxZaVfVxCD1kdQ7uJJvmXFcqTtxME+1CPCU/Ok0Y+VqO1Fnk9wbioiAWSt4z/sM3WqC0MNMYrjB5yMx+UoXjHczzVlOX5FJjIo1TWDl5132gNsrow==
x-ms-office365-filtering-correlation-id: 749edfc6-6c05-4bfc-fe8d-08d651579fbd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB2941;
x-ms-traffictypediagnostic: VI1PR08MB2941:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB29410B5CC3CCBBF37B57F2C1EDD40@VI1PR08MB2941.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(278428928389397);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231442)(944501410)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR08MB2941;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB2941;
x-forefront-prvs: 086597191B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(376002)(396003)(136003)(189003)(199004)(99286004)(6246003)(26005)(86362001)(2616005)(476003)(229853002)(31696002)(2906002)(11346002)(446003)(14454004)(486006)(52116002)(6486002)(97736004)(7736002)(102836004)(3846002)(186003)(6506007)(7416002)(44832011)(386003)(110136005)(54906003)(65806001)(65826007)(65956001)(5660300001)(53546011)(76176011)(66066001)(53936002)(58126008)(256004)(71200400001)(71190400001)(6512007)(25786009)(31686004)(36756003)(8936002)(39060400002)(478600001)(2900100001)(81166006)(81156014)(93886005)(316002)(4326008)(6116002)(8676002)(305945005)(64126003)(72206003)(106356001)(6436002)(68736007)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2941;H:VI1PR08MB4223.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cq9DgkimWw+C6sUbp+06gIrH/YeMK5Qwjp95NbT2JiO+y/gU4cf01Xw5r93/OwqylW9lxP5VEZfHARD6KujNjKabLZj9/24amhq/myb0rd0cPZZa7nhxHTouHILyGsfUK8tbyJRml1BPyWIVudGQ2Y5NgfuHrCa7iBwWBjMI7KFwdl2QnEP9ohrHhmSyZvvvCYyKT5u3rv47XVyY2YebiU3tmOlX9GAGcGa+UPvLPv90DT0x03KHNnd6X7ngkZxsOziZ3WAcDYEsEzEEIT1OwmwxFRe4XzYszv4mJLYkkh5qf0DYELWDi1/CQorOWx6TP773Gm50W05ok8Srj9FV/UNnKypWeD9c+YBPladKurc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7486BCEF38AA2B4BAB428D6D6DEEA79D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 749edfc6-6c05-4bfc-fe8d-08d651579fbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2018 15:23:30.7131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2941
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjMvMTEvMTggMTQ6MTEsIERhdmlkIE5ld2FsbCB3cm90ZToNCj4gT24gMjQvMTEvMTggMTI6
MDQgYW0sIEZsb3JpYW4gV2VpbWVyIHdyb3RlOg0KPj4gQnV0IHNvY2tldGNhbGwgZG9lcyBub3Qg
ZXhpc3Qgb24gYWxsIGFyY2hpdGVjdHVyZXMuwqAgTmVpdGhlciBkb2VzDQo+PiBnZXRwaWQsIGl0
J3MgY2FsbGVkIGdldHhwaWQgb24gc29tZSBhcmNoaXRlY3R1cmVzLg0KPj4gLi4uDQo+PiBJIHRo
aW5rIGl0IHdvdWxkIGJlIGEgcG9vciBhcHByb2FjaCB0byBleHBvc2UgYXBwbGljYXRpb24gZGV2
ZWxvcGVycyB0bw0KPj4gdGhlc2UgcG9ydGFiaWxpdHkgaXNzdWVzLsKgIFdlIG5lZWQgdG8gYWJz
dHJhY3Qgb3ZlciB0aGVzZSBkaWZmZXJlbmNlcyBhdA0KPj4gYSBjZXJ0YWluIGxheWVyLCBhbmQg
YXBwbGljYXRpb25zIGFyZSB0b28gbGF0ZS4NCj4gDQo+IEludGVyZXN0aW5nLsKgIEkgdGhpbmsg
dGhlIG9wcG9zaXRlLsKgIEkgdGhpbmsgZXhwb3NpbmcgdGhlIE9TJ3MgaW50ZXJmYWNlcyBpcyBl
eGFjdGx5IHdoYXQgYSBjLWxpYnJhcnkgc2hvdWxkIGRvLsKgIEl0IG1pZ2h0IGFsc28gcHJvdmlk
ZQ0KPiBhbHRlcm5hdGl2ZSBpbnRlcmZhY2VzIHRoYXQgd29yayBjb25zaXN0ZW50bHkgYWNyb3Nz
IGRpZmZlcmVudCBwbGF0Zm9ybXMsIGJ1dCBpbiBhZGRpdGlvbiB0bywgbm90IGluc3RlYWQgb2Yg
dGhlIE9TIGludGVyZmFjZS4NCg0KeW91IGRvbid0IHVuZGVyc3RhbmQgdGhlIHBvaW50IG9mIHRo
ZSBjIGxhbmd1YWdlIGlmIHlvdSB0aGluayBzby4NCg==
