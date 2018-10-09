Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D5DC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8346C21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="zJ5OF+Y5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8346C21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeJIUfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:35:24 -0400
Received: from mail-eopbgr10065.outbound.protection.outlook.com ([40.107.1.65]:5696
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726529AbeJIUfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNf8PYEFBWsf1nhyorQnt4PICUzokQRVLCyeh6kcRqM=;
 b=zJ5OF+Y5vlX6UYau3Azh8mPO9gUNvSW+QK+IbUQnNeE2Gp8CmXFQhn4l6ewexyrqSC9aLj46WTLB4jkokG2kmFlQGolSAgvhWPvKeSvZ7FwtCy3Aw+bO3eUzgYd+IhMoQfBGcJv6vepjL/DFuMPnLF+1qqs0etbfC/LF1EJ/QYA=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB5033.eurprd04.prod.outlook.com (20.176.234.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Tue, 9 Oct 2018 13:18:24 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::d971:723:f402:76bd]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::d971:723:f402:76bd%2]) with mapi id 15.20.1207.024; Tue, 9 Oct 2018
 13:18:24 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Subject: Re: [RESEND PATCH v2 3/3] ARM: dts: imx28-cfa10036: Fix the reset
 gpio signal polarity
Thread-Topic: [RESEND PATCH v2 3/3] ARM: dts: imx28-cfa10036: Fix the reset
 gpio signal polarity
Thread-Index: AQHUVkRSdlHfynMwIEC0L77BDqk26KUVbdWAgACxa4CAAH4OgIAAK/qAgAAjsICAAAuYgA==
Date:   Tue, 9 Oct 2018 13:18:24 +0000
Message-ID: <221a185c-19fc-cc89-49b1-aa77fb1f0e41@ysoft.com>
References: <1538040281-21319-1-git-send-email-michal.vokac@ysoft.com>
 <1538040281-21319-3-git-send-email-michal.vokac@ysoft.com>
 <68f4da21-6f0d-5bf9-b352-cdc423269080@ysoft.com>
 <CGME20181009002056epcas5p24207204c9e65e8f34382de6672adb993@epcas5p2.samsung.com>
 <20181009002031.GU3587@dragon>
 <20181009075145eucas1p2691c7d04aa8328080af7cbc4ab5e03b9~b4WFAVFkx0235802358eucas1p2c@eucas1p2.samsung.com>
 <bfbfd490-3872-2fd9-e088-3add596b987c@ysoft.com>
 <CAOMZO5DdV9Sm9z6wX8e4LTvbokjnOMqtgOJQOvVvysVvzaBKGw@mail.gmail.com>
In-Reply-To: <CAOMZO5DdV9Sm9z6wX8e4LTvbokjnOMqtgOJQOvVvysVvzaBKGw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0502CA0007.eurprd05.prod.outlook.com
 (2603:10a6:209:1::20) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5033;6:r96estv/dWqHH3pvkxkZKNt5iVXVigU4fwU6NWUhKD+MZvL5LfdVBrVmNT5wFsHhyeRGf0nr66e8xQXBfZbcWKXyTpq6KnGm7zGjsmrfoQtxuvluBeseYiqxLODxQXeDeuyKPOceQi2z0OWeZJl/mAIIlPxBQ8rnmKIrx7tXCsSU6A3HWjg8Mna7JIP6efeBGYNyB04Efn1CwpPt0KvCdDlv80IFUVLsQHN2F8thKh1B8z70RLlfAIHoOGuzS6bSrzX4aG3QxQMhtHm6CqTqfq7FXox97fL0XdvfzfJRtfyrsXUS/RrHeBCK3OtmVGuZ4Gia3/ennycEUDeqhmmiG79XwBuWO7UC6HRgbScdkQrLSQp3n/jZ2FXk/PhLbIqDTmNrsObgbCgqg8iu112+uxqJTBAMZ2ITQI4CPf63TfgBA2yYQwfqLeuNivOaSjHUHuU9U261D11wS4uy7TbOig==;5:G6M9H/kgHh4eRPhUzGLjU5U87kH6O16j6uC5kJme2sdSNW7hN8lPN9obtwUJ32HmKIiWKoy5GCHNxre8IC7hD3Xz6HbULkvETrQZrdmPzI2mMLnoK15lLvCTFIJo2t6zB6CPlk2j3C0+gFZ0UpijB/RDp6HbUYvc/DuaZoKiDqw=;7:Ki6kmYyur3D3SGO5l1vs6JYrmtBmNWf5NBUXgUt3Bl52vtviBpsQifK3ppxpjqKgq2sbcGuFzKp9AOBNXkqC0PjubcgYHv8KQMuJ6WUNLvnT78BMZtEzpIiiYgiGENYaamHuSUWdVx4M1Lj/nhIxrwl6Qnq2EvxwbRJPZVFkho29BWcvCrwJ6UstedG2njMI620bgKESmppPMNtp6lRLUSbJ6l9TMkl/7cnz36gS4BEvu65sqdlhbZ5OxuFT//4Q
x-ms-office365-filtering-correlation-id: 4e54ed59-fd52-4d93-dce7-08d62de9b108
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5033;
x-ms-traffictypediagnostic: DB7PR04MB5033:
x-microsoft-antispam-prvs: <DB7PR04MB5033C82A949EA180396F7FEF9EE70@DB7PR04MB5033.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:DB7PR04MB5033;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5033;
x-forefront-prvs: 08200063E9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39850400004)(136003)(346002)(376002)(189003)(199004)(81156014)(8676002)(1411001)(8936002)(81166006)(316002)(6116002)(3846002)(76176011)(52116002)(217873002)(99286004)(2900100001)(53936002)(72206003)(478600001)(14454004)(14444005)(256004)(54906003)(5250100002)(97736004)(6512007)(2906002)(93886005)(71200400001)(186003)(31686004)(85182001)(7736002)(305945005)(25786009)(5660300001)(6916009)(26005)(106356001)(66066001)(229853002)(68736007)(105586002)(486006)(11346002)(6486002)(2616005)(476003)(31696002)(71190400001)(4326008)(53546011)(6506007)(386003)(6436002)(36756003)(39060400002)(102836004)(86362001)(345774005)(6246003)(446003)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5033;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uIAahmq789azsdaR6XBOWa3nUSW4bKNcWDWEl7syHoXLdPO+lcSdV958N5gTkMp6yECZqmMrg34+0PuUQXMVojLeUCH1SI0JNMv+DwYTCprBHDRKaMwji1czfWOXbwgtbX/3dJZESD3xdrloAJgd8xY2NNplClI7emcbQN0FcV3Snwf1IPZIDZjtRTsOv+O2ciq1ZPnoxSILrfH28vhROonHaPVcuE1G0mjGrowAmPRGHH/oi7vUo2DW9IBHqNlRWeP3vx5pejXJ9B60VJE7ye1a8fhCZ+RdvaDEtbQWbhRbRgLH59uxHzBzxn3aBjEbMYquT/xkm2r2Okhj5hFnY+qUzTLdnKZDVcaoltHHvCU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4ABAED82C092C84A99FC717CA45BA740@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e54ed59-fd52-4d93-dce7-08d62de9b108
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2018 13:18:24.6531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5033
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS4xMC4yMDE4IDE0OjM2LCBGYWJpbyBFc3RldmFtIHdyb3RlOg0KPiBIaSBNaWNoYWwsDQo+
IA0KPiBPbiBUdWUsIE9jdCA5LCAyMDE4IGF0IDU6MzAgQU0gVm9rw6HEjSBNaWNoYWwgPE1pY2hh
bC5Wb2thY0B5c29mdC5jb20+IHdyb3RlOg0KPiANCj4+IFNvcnJ5IGZvciB0aGUgaW5jb252ZW5p
ZW5jZSA6KCBMZXNzb24gbGVhcm5lZC4uDQo+Pg0KPj4gU28gaW4gb3RoZXIgd29yZHMgKG5vIG9m
ZmVuc2UpOiBicm9rZW4gZHJpdmVycyBuZWVkIHRvIHN0YXkgYnJva2VuIGJlY2F1c2UNCj4+IHVz
ZXJzIG1heSBhbHJlYWR5IGdldCB1c2VkIHRvIHRoZSBicm9rZW4gYmVoYXZpb3I/DQo+IA0KPiBJ
biBvcmRlciB0byBrZWVwIHRoZSBvbGQgZHRiJ3Mgd29ya2luZyB5b3UgY291bGQgaW50cm9kdWNl
IGEgbmV3DQo+IHByb3BlcnR5IChsaWtlIHJlc2V0LWdwaW8tYWN0aXZlLWxvdywgZm9yIGV4YW1w
bGUpLg0KPiANCj4gVGhlbiB0aGUgZHJpdmVyIGJlaGF2aW9yIGNhbiBiZSBtYWRlIHVudG91Y2hl
ZCBmb3IgdGhlIG9sZCBkdGIncyBhbmQNCj4gb25seSBuZXcgZHRiJ3Mgd2l0aCB0aGlzIG5ldyBw
cm9wZXJ0eSB3b3VsZCBoYXZlIHRoZSBjb3JyZWN0IEdQSU8NCj4gcmVzZXQgYmVoYXZpb3IuDQoN
ClRoYW5rIHlvdSB2ZXJ5IG11Y2ggRmFiaW8hDQpJIHNhdyB0aGVzZSB4eHgtYWN0aXZlLWxvdy9o
aWdoIHByb3BlcnRpZXMgaW4gbWFueSBkZXZpY2UgdHJlZQ0Kc291cmNlcyB3b25kZXJpbmcgd2h5
IHRoZSBoZWNrIHBlb3BsZSB1c2UgdGhlbSB3aGVuIHRoZXkgY291bGQNCnVzZSBHUElPX0FDVElW
RV9MT1cvSElHSC4gQW5kIHRoaXMgaXMgdGhlIGV4cGxhbmF0aW9uLg0KDQpBbmQgSSBmZWVsIGxp
a2UgYW4gaWRpb3Qgb25jZSBhZ2FpbjogZ2l0IGdyZXAgLWwgInJlc2V0LWFjdGl2ZS1sb3ciDQpm
aXJzdCBoaXQgaXM6DQoNCiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3Bs
YXkvc3NkMTMwN2ZiLnR4dA0KDQpPb29vcHMuDQpUaGUgd2VpcmQgdGhpbmcgaXMgdGhhdCB1c2Fn
ZSBvZiByZXNldC1hY3RpdmUtbG93IGlzIGRvY3VtZW50ZWQNCmluIHRoZSBleGFtcGxlIGJ1dCBp
dCBpcyBub3QgaW1wbGVtZW50ZWQuDQoNClNvIHRoZSBwYXRjaCBuby4yIHNob3VsZCBiZSByZXZl
cnRlZCBhbmQgcGF0Y2ggbm8uMyBub3QgYXBwbGllZCBhdCBhbGwuDQoNCkkgd2lsbCBwcmVwYXJl
IGEgbmV3IHBhdGNoIHV0aWxpemluZyB0aGUgcmVzZXQtYWN0aXZlLWxvdyBwcm9wZXJ0eS4NCg0K
QWdhaW4sIHNvcnJ5IGZvciB0aGUgdHJvdWJsZXMgYW5kIHRoYW5rIHlvdSBmb3IgeW91ciBjb21t
ZW50cy4NCk1pY2hhbA0K
