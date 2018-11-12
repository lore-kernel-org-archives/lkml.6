Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFCDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C841223DD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="bQQWufWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C841223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbeKLWil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 17:38:41 -0500
Received: from mail-db5eur01on0084.outbound.protection.outlook.com ([104.47.2.84]:32594
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727109AbeKLWik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 17:38:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaeDctChsJ3foCIdKXo6C6nLxRv7jPtWJO9ibYojgQ0=;
 b=bQQWufWGVYk7Eka8IcJJSWxfi25430omkTE+BHTPYms0vL5uVrBg+iR0ByqeDcuK7WVdT+2+sZUwT0daqxnE9wYpMzGxIbLVMdV48eaHt0gs9ZKv+iI5GlCJACrJZZhKSaQjzFbvppyzl5bz758OoLMm71rZOIdUjWLvwnbxUVc=
Received: from VI1PR08MB3294.eurprd08.prod.outlook.com (52.134.31.11) by
 VI1PR08MB0687.eurprd08.prod.outlook.com (10.163.169.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Mon, 12 Nov 2018 12:45:27 +0000
Received: from VI1PR08MB3294.eurprd08.prod.outlook.com
 ([fe80::8db0:9eca:8ed:92b1]) by VI1PR08MB3294.eurprd08.prod.outlook.com
 ([fe80::8db0:9eca:8ed:92b1%3]) with mapi id 15.20.1294.044; Mon, 12 Nov 2018
 12:45:26 +0000
From:   Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To:     Daniel Colascione <dancol@google.com>,
        Florian Weimer <fweimer@redhat.com>
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
Thread-Index: AQHUeYuU4J3dLZKEX06mfdiwAKJEwaVKawj+gAA1+ICAAXcRAA==
Date:   Mon, 12 Nov 2018 12:45:26 +0000
Message-ID: <45cf58e0-909e-262c-5b9f-b91d62350a79@arm.com>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com>
 <877ehjx447.fsf@oldenburg.str.redhat.com>
 <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com>
In-Reply-To: <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-originating-ip: [217.140.106.49]
x-clientproxiedby: LO2P265CA0434.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::14) To VI1PR08MB3294.eurprd08.prod.outlook.com
 (2603:10a6:803:3e::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB0687;6:UlV+LVUwpNKY2ZM/NfZqkDEkowNRm3fqubDRrIyYd5VIsIqCTep/2YgEktUUXXycxJkI8BbyxvGxUJyArzVA+vySqmQcEQYc/0AZpYzz2/2BddKJGYiKfvxQ2Og+khH2MKA07z5Z+5/fF056SHZelBhcmcwvmy5KS2G1VJKkZu3HU9xZRCmksAgQLIv9WOaH5m5oNz08BRBHXTOvq15SQervdY3Eqm0ENUQyEWDCl8D6QUzB/+8o4t0TwwZhvSQNLCfhbNJb/U3Or7ctKl7rFqoRQnh6uCXWu9cRhK3t8buOFZCWQ4Iz0VdV6Z8gGXQefmrJP7yLdtZFZn3Op5nQZvX3JdDlS83I3DAI8GChjOCISgmzSXhEIL21LTBks/vXiOhEiOYoKu7jVJkGpQQ1eRRBxTtsvRC9RbaDtX4Kvd3+MXVjkL4j+UAKm1CFza9LgRD+LNVv1u6LN5NwDla+/+3DGM0PKVEgfswuVrIRSl4=;5:1xsd6xdwyP1TwpxFuXYddMdIrujL2YtNWDob39xBOwGuVZ5gj09lhWw/qfCPyMgpUWSkW/QetYQu0Md1AciZC+dxe9cqpaeXXoiuwUPkapWIah6Wm0brxEpDPQmUJLqTImapaZHbFXsBqc79Tb6i8hBpshCyjj5nblYOO0ZiC2c=;7:poJrZUgd6afNLOpDOuEr/7yFfp6r93TmMiN4CH5kuL/uk7UsCpk4zz15vpUONmeI4gVIKNcMQyfD7m6Ac0of8ISgXYPfb/0qZvSCHqPQ4y14pxCRVsEUgrY26dsy26FXoNEoLddLB7oqrBDEzHIDeg==
x-ms-office365-filtering-correlation-id: 53191a91-5a0b-4e80-3a14-08d6489cb80f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB0687;
x-ms-traffictypediagnostic: VI1PR08MB0687:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB0687428405B87AAC1B0731E4EDC10@VI1PR08MB0687.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(278428928389397);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR08MB0687;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB0687;
x-forefront-prvs: 0854128AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(346002)(396003)(136003)(199004)(189003)(64126003)(68736007)(2906002)(561944003)(65826007)(53936002)(6246003)(44832011)(6512007)(6486002)(229853002)(7416002)(4326008)(102836004)(386003)(446003)(36756003)(6506007)(97736004)(186003)(86362001)(11346002)(486006)(26005)(76176011)(31696002)(5660300001)(14454004)(25786009)(53546011)(52116002)(2616005)(39060400002)(476003)(71190400001)(31686004)(14444005)(81156014)(105586002)(81166006)(8676002)(65956001)(66066001)(65806001)(99286004)(2900100001)(478600001)(305945005)(7736002)(256004)(316002)(106356001)(8936002)(6436002)(6116002)(3846002)(72206003)(71200400001)(93886005)(54906003)(58126008)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB0687;H:VI1PR08MB3294.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rUtFudN9u2ZgB0lLYYIWaZ35d8+WyugJPU+CHWnmRzPsteEPU9YoGNItk/c1FDtexMr73YHRUnusGn725eyK2Czg6y82CU59aTBA63GAPc4bmGqxamduBob3qAVRUvyzW1OUXIpahZdynUKSBcMRc3YUEBeKG/bcE/w0hfmVmLiWeMRz6P8HH7nq5zX3eymR3LhpPu8gQmBtVwFs/+FW+hHZKzWoUFmAutpcc12AHztxIyCrvZ4fTpYJpTCbDIKN0r9ibKkQ3UElZYtqo2o5ZN5iaZhhy8OGHrRT7Xs2zYzIibNemtYp3xBxTFiF7bmDUOFLocCW1qkFnQk+e3NgWx6HsRU3R/A8ZeAx8AIaWbY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1701A8B6BAE31F4EAB383EDAF3D5504B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53191a91-5a0b-4e80-3a14-08d6489cb80f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2018 12:45:26.8263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB0687
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMTEvMTggMTQ6MjIsIERhbmllbCBDb2xhc2Npb25lIHdyb3RlOg0KPiBPbiBTdW4sIE5v
diAxMSwgMjAxOCBhdCAzOjA5IEFNLCBGbG9yaWFuIFdlaW1lciA8ZndlaW1lckByZWRoYXQuY29t
PiB3cm90ZToNCj4+IFdlIGhhZCBhIHBhdGNoIGZvciB0aGUgbWVtYmFycmllciBzeXN0ZW0gY2Fs
bCwgYnV0IHRoZSBrZXJuZWwgZGV2ZWxvcGVycw0KPj4gY291bGQgbm90IHRlbGwgdXMgd2hhdCB0
aGUgc3lzdGVtIGNhbGwgZG9lcyBpbiB0aGVybXMgb2YgdGhlIEMvQysrDQo+PiBtZW1vcnkgbW9k
ZWwNCj4gW3NuaXBdDQo+PiBBIGxvdCBvZiB0aGUgbmV3IHN5c3RlbSBjYWxscyBsYWNrIGNsZWFy
IHNwZWNpZmljYXRpb25zIG9yIGFyZSBqdXN0DQo+PiBzb21ld2hhdCBtaXNkZXNpZ25lZC4gIEZv
ciBleGFtcGxlLCBwa2V5X2FsbG9jDQo+IFtzbmlwXQ0KPj4gZ2V0cmFuZG9tIHN0aWxsIGNhdXNl
cyBib290IGRlbGF5cw0KPiBbc25pcF0NCj4+IEZvciBjb3B5X2ZpbGVfcmFuZ2UsIHdlIHN0aWxs
IGhhdmUgZGViYXRlcyB3aGV0aGVyIHRoZSBzeXN0ZW0gY2FsbCAoYW5kDQo+PiB0aGUgZ2xpYmMg
ZW11bGF0aW9uKSBzaG91bGQgcHJlc2VydmUgaG9sZXMgb3Igbm90LA0KPiBbc25pcF0NCj4gDQo+
IFRoZXNlIG9iamVjdGlvbnMgaWxsdXN0cmF0ZSBteSBwb2ludC4gZ2xpYmMgZGV2ZWxvcG1lbnQg
aXMgbm90IHRoZQ0KPiBwcm9wZXIgZm9ydW0gZm9yIHJhaXNpbmcgcG9zdC1ob2Mgb2JqZWN0aW9u
cyB0byBzeXN0ZW0gY2FsbCBkZXNpZ24uDQo+IFdpdGhob2xkaW5nIHdyYXBwZXJzIHdpbGwgbm90
IHVuLXNoaXAgdGhlc2Ugc3lzdGVtIGNhbGxzLiBBcHBsaWNhdGlvbnMNCj4gYXJlIGFscmVhZHkg
dXNpbmcgdGhlbSwgdmlhIHN5c2NhbGwoMikuIERldmVsb3BlcnMgYW5kIHVzZXJzIHdvdWxkIGJl
DQo+IGJldHRlciBzZXJ2ZWQgYnkgcHJvdmlkaW5nIGFjY2VzcyB0byB0aGUgc3lzdGVtIGFzIGl0
IGlzLCB3aXRoDQo+IGFwcHJvcHJpYXRlIGRvY3VtZW50YXRpb24gY2F2ZWF0cywgdGhhbiBieSBo
b2xkaW5nIG91dCBmb3Igc29tZQ0KPiBhbHRlcm5hdGUgYW5kIG1vcmUgaWRlYWwgc2V0IG9mIHN5
c3RlbSBjYWxscyB0aGF0IG1heSBvciBtYXkgbm90DQo+IGFwcGVhciBpbiB0aGUgZnV0dXJlLiBU
aGlzIHJlc2lzdGFuY2UgdG8gZXhwb3NpbmcgdGhlIGNhcGFiaWxpdGllcyBvZg0KPiB0aGUgc3lz
dGVtIGFzIHRoZXkgYXJlLCBldmVuIGluIGZsYXdlZCBhbmQgd2FydHkgZm9ybSwgaXMgd2hhdCBJ
IG1lYW50DQo+IGJ5ICJtaXNwbGFjZWQgaWRlYWxpc20iIGluIG15IHByZXZpb3VzIG1lc3NhZ2Uu
IElmIHRoZSBrZXJuZWwgcHJvdmlkZXMNCj4gYSBzeXN0ZW0gY2FsbCwgbGliYyBzaG91bGQgcHJv
dmlkZSBhIEMgd3JhcHBlciBmb3IgaXQsIGV2ZW4gaWYgaW4gdGhlDQo+IG9waW5pb24gb2YgdGhl
IGxpYmMgbWFpbnRhaW5lcnMsIHRoYXQgc3lzdGVtIGNhbGwgaXMgZmxhd2VkLg0KDQpmbGF3cyBj
YW4gYmUgd29ya2VkIGFyb3VuZC4NCg0KaXQncyBqdXN0IG1vcmUgd29yayB0byBkbyB0aGF0LCBo
ZW5jZSB3cmFwcGVycyBhcmUgZGVsYXllZC4NCg0KKHdoaWxlIG5ldyBmbGF3ZWQgc3lzY2FsbHMg
Z2V0IGFkZGVkLCB0aGVyZSBhcmUgbWlzc2luZw0Kc3lzY2FsbHMgZm9yIGltcGxlbWVudGluZyBw
b3NpeCBzZW1hbnRpY3Mgb3IgZm9yIGJldHRlciBsaWJjDQpxdWFsaXR5LCBzbyBhcmUgdGhlIHBy
aW9yaXRpZXMgb2YgbGludXggcmlnaHQ/KQ0KDQo+IEkgYWdyZWUgd2l0aCB0aGUgcHJvcG9zYWxz
IG1lbnRpb25lZCBhYm92ZSB0byBzcGxpdCBzeXN0ZW0gaW50ZXJmYWNlDQo+IHJlc3BvbnNpYmls
aXR5LCBoYXZpbmcgZ2xpYmMgaGFuZGxlIGhpZ2hlci1sZXZlbCBjb25jZXJucyBsaWtlIHN0ZGlv
DQo+IHdoaWxlIHB1bnRpbmcgc3lzdGVtIGNhbGwgd3JhcHBlcnMgYW5kIG90aGVyIGxvdy1sZXZl
bCBmYWNpbGl0aWVzIHRvIGENCj4ga2VybmVsLXByb3ZpZGVkIHVzZXJzcGFjZSBsaWJyYXJ5IHRo
YXQgY2FuIG1vdmUgZmFzdGVyIGFuZCBtb3JlDQo+IGV4cGxpY2l0bHkgY29uZm9ybSB0byB0aGUg
TGludXgga2VybmVsJ3MgdXNlcnNwYWNlIEFCSS4NCg0KY29uc3VtaW5nIGxpbnV4IHVhcGkgaGVh
ZGVycyBpcyBhIGh1Z2UgcHJvYmxlbSAobm90IGp1c3QgZm9yDQpnbGliYyk6IHRoZSBsaWJjIGhh
cyB0byByZXBlYXQgdWFwaSBkZWZpbml0aW9ucyB1bmRlciBhcHByb3ByaWF0ZQ0KZmVhdHVyZSBt
YWNyb3MgdXNpbmcgcHJvcGVyIGxpYmMgdHlwZXMgZXRjLCB0aGlzIHVzdWFsbHkgY3JlYXRlcw0K
Y29uZmxpY3QgYmV0d2VlbiBsaW51eCBhbmQgbGliYyBoZWFkZXJzIGFuZCBhIGxvdCBvZiBkdXBs
aWNhdGVkDQp3b3JrIGF0IGV2ZXJ5IGxpbnV4IHJlbGVhc2UuIHRoZSBzaXR1YXRpb24gd291bGQg
YmUgd29yc2UgaWYgYWxsDQpuZXcgdHlwZXMgd2VyZSBleHBvc2VkIGZvciBuZXcgc3lzY2FsbHMg
d2hlbiB0aGV5IGFwcGVhcmVkLg0KDQp0aGUgcHJvcG9zYWwgbWVudGlvbmVkIGFib3ZlIGRvZXMg
bm90IHNvbHZlIHRoaXMgaW4gYW55IHdheS4NCg==
