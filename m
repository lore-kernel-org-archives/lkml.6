Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1AFC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB74213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mfzhhDmj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB74213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeJIACF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:02:05 -0400
Received: from mail-eopbgr00071.outbound.protection.outlook.com ([40.107.0.71]:47780
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726291AbeJIACF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=by3xohoAqatOiSYDA7fOaXaVRjOBc4kMZFOjZc2uPX0=;
 b=mfzhhDmjSxJ4CxM+YR6ERj/jqnIwd+/FBmqeFbVEiQJPbbDVSNKwHOe8LICevErrUdWlm86DZVbXsxKARjugS8fy6C3kg7MNv/ARfqM6Gr9hM9xPUXNWc3fyshbi090xaWJUXrlDK7WBOJTVNyfj9+ZP1UpAsUMkw/kOfMMuipg=
Received: from AMSPR04MB503.eurprd04.prod.outlook.com (10.242.107.152) by
 AMSPR04MB520.eurprd04.prod.outlook.com (10.242.20.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Mon, 8 Oct 2018 16:49:24 +0000
Received: from AMSPR04MB503.eurprd04.prod.outlook.com
 ([fe80::d081:5636:5890:c63c]) by AMSPR04MB503.eurprd04.prod.outlook.com
 ([fe80::d081:5636:5890:c63c%8]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 16:49:24 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: RE: [GIT PULL v2] for-next updates for soc/fsl drivers for v4.20 take
 2
Thread-Topic: [GIT PULL v2] for-next updates for soc/fsl drivers for v4.20
 take 2
Thread-Index: AQHUXwWmGvvGDpgPZ0W+7E2wPwS4C6UVjWcw
Date:   Mon, 8 Oct 2018 16:49:24 +0000
Message-ID: <AMSPR04MB50382DC37553EDBF2C0F2C58FE60@AMSPR04MB503.eurprd04.prod.outlook.com>
References: <20181005193040.28598-1-leoyang.li@nxp.com>
 <CAK8P3a2gtZUif_hPkd7ob=mWYTeh8Vgf-Y9nMwpi2YtHoBF2Bg@mail.gmail.com>
In-Reply-To: <CAK8P3a2gtZUif_hPkd7ob=mWYTeh8Vgf-Y9nMwpi2YtHoBF2Bg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AMSPR04MB520;6:evpwOIKcyIcePbGiJ5f91LrKTVeiLFZMnyTHwnxINqUAYnuy0vYnzWXoV02+/bRX2RZSUYBwD2CAhPI28/iPbHCns6gv/FQco0XCb06KGI+UCHfhfvbGjm5a6kS41ZSaD795gxb5ZOafOl6Mpw0pUl3NgIUyJGGnlf4Bd2EcfWkwGCUShPzt4Ri0sYg/SmbtrtfIMUp4YLHJqeTLS4O7QFhBdndcrakj0Pk4MQsf/Spa4NtC4DJN5Rbg816nrZAG5vZqae97zyexo7+Q8X4y7Z8Y70Udsd+rrrTIzo+zxhNB23Hmonhoj4lQJHuc+wNKq2L3wmlVe0imISJsMedzoyiO5jobhbKYERLRkoE7D9+MMUII//bswZBFfaVhtJTSOb2FXWkR7C5mxzMnBFWEF/GI/gNteZAFDsRt4KDmiivda98emLjv/XhthN3Dz2kDNwj9X6Nx9S2lAZeMQQIHnA==;5:cU0mdKpg/aT8pWG+oO+8z0F0aol0z66lOLeCwxnbZLBuQ8JAvHocavHzEEH/OFkrzTGIvS7oTaQPA/8UoKo4CWWqQDj3WQwvUpGHh0DhrVgCaMNz8LazcWyBi+OZ2mB92dLi61QIOtk68lMd/PgiTmPa+Rcpwv9EsO0HpiaDyZw=;7:2G3mcfrL7wUDPDa6LBXeIPdPeaB4honWCPSZg7UXlB2AX+FpTGnhLmS8PZqJTQ78xHitDcFmirQm8TULz6VL8s0UOLSDbK+wgQjKOVQm6njeN5EjwWiIt/JqMgFvhKigcSRxmxcUkaeueGmp+EpEzrhmILMnazwu7k/kvCLq24B81HuHVZZXG89euE1oVtylUHc9OZ8DRrZ8WITL2aa034eDTYhLSynHCO5tpvQsMAKjDOGFYwW8dbTh4AvvsZxe
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0cb9a18c-2185-49c6-6397-08d62d3e00d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AMSPR04MB520;
x-ms-traffictypediagnostic: AMSPR04MB520:
x-microsoft-antispam-prvs: <AMSPR04MB520A2265BC21859EB3ECA338FE60@AMSPR04MB520.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AMSPR04MB520;BCL:0;PCL:0;RULEID:;SRVR:AMSPR04MB520;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(396003)(346002)(376002)(199004)(189003)(13464003)(256004)(6916009)(33656002)(81166006)(478600001)(86362001)(68736007)(217873002)(54906003)(6116002)(3846002)(81156014)(14444005)(2900100001)(5660300001)(8676002)(14454004)(102836004)(9686003)(55016002)(305945005)(7736002)(6506007)(53546011)(4326008)(2906002)(105586002)(76176011)(97736004)(26005)(6246003)(71200400001)(71190400001)(7696005)(53936002)(15650500001)(186003)(74316002)(5250100002)(446003)(11346002)(476003)(229853002)(99286004)(316002)(486006)(25786009)(6436002)(106356001)(8936002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AMSPR04MB520;H:AMSPR04MB503.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: X/0ODAZPTKYGOBdBQ/GA8c6UbzCiNRAqu6E/DA6hlP6iVBJDkqCUQn04b5cTtVWbe/CKgXyYvsWlSXk8qRw1KoUBgXTX6mOU68DuqO/bFVrozlKHfKhL9XuEdFYhblQn2zrrDEfZcOn33u8I8bshEm8dpPbHMBOBmA/UPjX5Av/b3pAnGPgeesF8SbtkcEZ5Yup3UiJpdwzeQEkeCY6NIjkSnkw9raW5mWRQ7RMpMEd3dSx9TcRIB1g3juQau3praaKauNl9Pyz1LYKeBT2jn36st7SrPPFu+/b10cl4I+z2hsC6wPvcBsF4UmXtX1EgvW5vvXwhqfDNu7I01FD7qk9j6e1gipEnzHwIlPk7h4M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb9a18c-2185-49c6-6397-08d62d3e00d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 16:49:24.3415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMSPR04MB520
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJuZCBCZXJnbWFubiA8
YXJuZEBhcm5kYi5kZT4NCj4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDgsIDIwMTggNzo1MSBBTQ0K
PiBUbzogTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+DQo+IENjOiBhcm0tc29jIDxhcm1Aa2Vy
bmVsLm9yZz47IExpbnV4IEFSTSA8bGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZz47IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5r
ZXJuZWwub3JnPjsgU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBS
ZTogW0dJVCBQVUxMIHYyXSBmb3ItbmV4dCB1cGRhdGVzIGZvciBzb2MvZnNsIGRyaXZlcnMgZm9y
IHY0LjIwIHRha2UNCj4gMg0KPiANCj4gT24gRnJpLCBPY3QgNSwgMjAxOCBhdCA5OjMwIFBNIExp
IFlhbmcgPGxlb3lhbmcubGlAbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4g
TlhQL0ZTTCBTb0MgZHJpdmVycyB1cGRhdGVzIGZvciB2NC4yMCB0YWtlIDINCj4gPg0KPiA+IC0g
VXBkYXRlIHFibWFuIGRyaXZlciB0byBiZXR0ZXIgd29yayB3aXRoIENQVSBob3RwbHVnDQo+ID4g
LSBBZGQgS2NvbmZpZyBkZXBlbmRlbmN5IG9mIDY0LWJpdCBETUEgYWRkcmVzc2luZyBmb3IgcWJt
YW4gZHJpdmVyDQo+ID4gLSBVc2UgbGFzdCByZXBvbnNlIHRvIGRldGVybWluZSB2YWxpZCBiaXQg
Zm9yIHFibWFuIGRyaXZlcg0KPiA+IC0gRGVmZXIgYm1hbl9wb3J0YWxzIHByb2JlIGlmIGJtYW4g
aXMgbm90IHByb2JlZA0KPiA+IC0gQWRkIGludGVycnVwdCBjb2FsZXNjaW5nIEFQSXMgdG8gcWJt
YW4gZHJpdmVyDQo+IA0KPiBQdWxsZWQgaW50byBuZXh0L2RyaXZlcnMuDQo+IA0KPiBJIHdhcyBh
IGxpdHRsZSBzdXJwcmlzZWQgdG8gc2VlIHRoZXNlIGNvbW1pdHMgaW4geW91ciBicmFuY2g6DQo+
IA0KPiAgICAgICBBUk06IGR0czogQkNNNjN4eDogRml4IGluY29ycmVjdCBpbnRlcnJ1cHQgc3Bl
Y2lmaWVycw0KPiAgICAgICBNQUlOVEFJTkVSUzogdXBkYXRlIHRoZSBBbm5hcHVybmEgTGFicyBt
YWludGFpbmVyIGVtYWlsDQo+ICAgICAgIEFSTTogZHRzOiBzdW44aTogZHJvcCBBNjQgSERNSSBQ
SFkgZmFsbGJhY2sgY29tcGF0aWJsZSBmcm9tIFI0MCBEVA0KPiAgICAgICBBUk06IGR0czogYXQ5
MTogc2FtYTVkMl9wdGNfZWs6IGZpeCBuYW5kIHBpbmN0cmwNCj4gDQo+IFRoZXNlIGFyZSBmcm9t
IG91ciBlYXJsaWVyICdmaXhlcycgYnJhbmNoIGFuZCB0aGV5IHdlcmUgYWxzbyBwYXJ0IG9mIHlv
dXINCj4gZml4ZXMgYnJhbmNoIHRoYXQgSSBhbHJlYWR5IHB1bGxlZCwgd2hpY2ggeW91IGhhZCBi
YXNlZCBvbiB0b3Agb2YgdGhlIG90aGVyDQo+IGZpeGVzLg0KPiANCj4gSW4gdGhlIGZ1dHVyZSwg
cGxlYXNlIGRvbid0IGRvIHRoaXMgYWdhaW4uIEluc3RlYWQsIGJhc2UgZWFjaCBicmFuY2ggb24g
dG9wDQo+IG9mIGEgcGxhaW4gLXJjIHVubGVzcyB5b3UgaGF2ZSBhIHNwZWNpZmljIHJlYXNvbiB0
byByZXF1aXJlIHNvbWV0aGluZyBlbHNlDQo+IChsaWtlIGluIHRoaXMgY2FzZSwgd2hlcmUgeW91
IHJlcXVpcmUgdGhlIGZpeGVzIHRvIGJ1aWxkIG9uIHRvcCBvZikuDQoNCkkgcmViYXNlZCBteSBz
ZWNvbmQgZml4IHB1bGwgcmVxdWVzdCB0byB0aGUgYXJtLXNvYyBmaXggYnJhbmNoIGJlY2F1c2Ug
c29tZSBwYXRjaGVzIGZyb20gbXkgZmlyc3QgZml4IHB1bGwgcmVxdWVzdCB3ZXJlIGNoZXJyeSBw
aWNrZWQgdG8gdGhlIGZpeCBicmFuY2guICBJIGRpZCB0aGUgcmViYXNlIHRvIGF2b2lkIGNvbmZs
aWN0cyBpbiBtZXJnZS4gICBCdXQgcHJvYmFibHkgeW91ciBmb3ItbmV4dCBicmFuY2ggZG9lc24n
dCBoYXZlIGFsbCB0aGUgZml4IHBhdGNoZXMgeWV0LCBzbyB0aGVzZSBwYXRjaGVzIHNob3dlZCB1
cC4NCg0KPiANCj4gVGhpcyB0aW1lIHdlIHdlcmUgbHVja3kgYmVjYXVzZSB0aGUgJ2ZpeGVzJyBi
cmFuY2ggeW91IGJ1aWx0IG9uIHdhcyBhbHNvDQo+IGRvbmUgb24gdG9wIG9mIC1yYzEsIHNvIGF0
IGxlYXN0IGl0IGRpZCBub3QgY29udGFpbiBhbnkgY29tbWl0cyBmcm9tDQo+IHVwc3RyZWFtIHRo
YXQgd2VyZSBub3QgYWxyZWFkeSBwYXJ0IG9mIG91ciBuZXh0L2RyaXZlcnMuDQo+IA0KPiAgICAg
ICAgQXJuZA0K
