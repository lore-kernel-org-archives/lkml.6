Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D17CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85212145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="diLcrLAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85212145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbeIXR6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:58:00 -0400
Received: from mail-he1eur01on0056.outbound.protection.outlook.com ([104.47.0.56]:23336
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729224AbeIXR56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuqniBJqZWxi8fi46ZY3UdMLuNOKGv4agb6OGyxTLmo=;
 b=diLcrLAjtynoEZP6rdFXDoevc+oseUBgPo6MzSqANhC7f/gdIafHNvGWbjxVQEOjnSr9IsjKCj++peMjuaowGYoQUG3MurVVWIRuBdtSNBd0OSVPSNkimus40lP3JQSbVB6Na2WJqkIhER9DQU22beqi2umJ+e0Q/oFml3+cLNQ=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB4846.eurprd04.prod.outlook.com (20.177.49.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 24 Sep 2018 11:56:09 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::6d90:90af:e2ce:80f2]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::6d90:90af:e2ce:80f2%3]) with mapi id 15.20.1143.017; Mon, 24 Sep 2018
 11:56:09 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     Scott Wood <oss@buserror.net>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel-owner@vger.kernel.org" 
        <linux-kernel-owner@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>
CC:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        Andy Tang <andy.tang@nxp.com>
Subject: RE: [PATCH v2 3/5] drivers: clk-qoriq: Add clockgen support for
 lx2160a
Thread-Topic: [PATCH v2 3/5] drivers: clk-qoriq: Add clockgen support for
 lx2160a
Thread-Index: AQHUTAb6cv1C3xaC1EGZKHQAGneRK6Txu1qAgA2nBsA=
Date:   Mon, 24 Sep 2018 11:56:08 +0000
Message-ID: <VI1PR04MB4800CA1AFEB6EB7B56680CBBF3170@VI1PR04MB4800.eurprd04.prod.outlook.com>
References: <1536871075-3732-1-git-send-email-vabhav.sharma@nxp.com>
         <1536871075-3732-4-git-send-email-vabhav.sharma@nxp.com>
 <4fa10f679ad4b1b619daa521a8641c145cf8537e.camel@buserror.net>
In-Reply-To: <4fa10f679ad4b1b619daa521a8641c145cf8537e.camel@buserror.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4846;6:WbnNVH6i7VwzIqzTuQEKR5ktwJYbilKAssVtbVFHj9fM2LL6kSEtOFTbA6oz730NK3O5nz0yu0L7doZ4EPILudP2UL9h7z0K4HlKkCvq6b74YWNFZ7bX4Kp3dKBXI2LtZyTjGhpje5M9CRooAb4EDWFB5CJw2cQxF5hLs+lUqFeH3lx3j6X6HTHtYCmavhUtLP84NYcFzZduDoYUqcwKZ7PqUHI9rJ0/O7Ebx5g+nYucKd0mHLD5vLpiZfgOWKJ0cTufxYmGFcIHJ8p/0x5dXZ3eKz6PlCY1wQd5uiLnNfQzZtazcqmwgPd7//F8XeoWT8EHEXUu5FNyeKLAr8aMwzTZRxhoTlw/oMiI/2G8nQXPkDo05LA9T2wDGkr5z8W7AGpl8qUtkqfPryh+sZ2P8/t0UlxNFIhce+9ThvVhq6TZNqCv+ernfmvbIYzs7/3FETujFXfEEkN6Tqs9HVtn5w==;5:5SicK3CcWb8B0CH+8jPre2BsutLRGMsHX477Lc8zofl7wirbLVTZMmalKciGFeWXuWyEGXj8eBmREFu/OuMguDFkYiF93QDwLm74e+iL97WzbxCiqd4Z/8LtD0coeNXvoVRkwz9wIzeE3fPZ6KcrLcX8D8zcKLJlyYfJL+E2av8=;7:VUw6/FX4HXlCtADahnma6vgutzro7+uShNW60bpCDwkgAOlrnhcMCTKl3+oYpDLnDTzgjDqdPhoY0UO/OYJ110pf2qZ33cxc8NvAcklNV2pC/rLm45wlvB3pZ2Qx7WOjlnp64tBs8OhmsMy0ev/bInfiMvdp8mfxqq+PQtBUCCtFcV2XhJD5+fV5ie/NMTFqidXf+OxHlkMoXJC2oTBGHXM3USz98thF5CPhcQ9/YVAjxYGcAHVWVwXXzNTcWnDA
x-ms-office365-filtering-correlation-id: 8511f67a-5ede-4e3d-e255-08d62214b76c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4846;
x-ms-traffictypediagnostic: VI1PR04MB4846:
x-microsoft-antispam-prvs: <VI1PR04MB48461659BC8DE1ACFB901CEFF3170@VI1PR04MB4846.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(65623756079841)(258649278758335)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:VI1PR04MB4846;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4846;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(396003)(346002)(136003)(189003)(199004)(13464003)(71190400001)(71200400001)(44832011)(14444005)(6506007)(106356001)(53546011)(486006)(26005)(2501003)(229853002)(478600001)(186003)(66066001)(2900100001)(14454004)(102836004)(105586002)(9686003)(5250100002)(97736004)(68736007)(55016002)(8936002)(53936002)(76176011)(99286004)(316002)(2906002)(6436002)(476003)(8676002)(33656002)(3846002)(6116002)(446003)(110136005)(11346002)(54906003)(7696005)(81156014)(86362001)(5660300001)(7416002)(6246003)(4326008)(25786009)(305945005)(2201001)(7736002)(81166006)(256004)(74316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4846;H:VI1PR04MB4800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ncf1+jwvHc9ETxN7Iojbcnc526VNYwin1NtBLWReq1dwvg8MPqg4uHUf0ls8J9fgvJH2YUFFZMyiT1qSOVPwgUdBfCHU0FGP6vadbBDOHs19IjYmKrWS66XNLG9LTJT6pMDFxt6DBNE5BEexNskmvztEprtEOPa/aO/gOCvXag/7u2Oh2lH0jKHxkBbJofj+hho5MKGWdh147+0ILXHmBrDVAknW7RMQriRQc8Qr0ELDKNhSxjKo2ax1L3AIoL+kMAvMFzBntAWrVqrcaT4MJQx4uLnAkcbFnPuNhZkQzSSFHii+NLUnVYCenmraEL+0LdssgM5KOpHIxzO1UFeHOjjFDucb93Zek49XxQcW/jw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8511f67a-5ede-4e3d-e255-08d62214b76c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 11:56:08.9841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4846
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2NvdHQgV29vZCA8b3Nz
QGJ1c2Vycm9yLm5ldD4NCj4gU2VudDogU3VuZGF5LCBTZXB0ZW1iZXIgMTYsIDIwMTggMTI6NTQg
QU0NCj4gVG86IFZhYmhhdiBTaGFybWEgPHZhYmhhdi5zaGFybWFAbnhwLmNvbT47IHN1ZGVlcC5o
b2xsYUBhcm0uY29tOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gbWFyay5ydXRsYW5kQGFy
bS5jb207IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBsaW51eC1hcm0tDQo+IGtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnOyBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsgc2JveWRAa2Vy
bmVsLm9yZzsNCj4gcmp3QHJqd3lzb2NraS5uZXQ7IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnOyBs
aW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gcG1Admdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWwtb3duZXJAdmdlci5rZXJuZWwub3JnOw0KPiBjYXRhbGluLm1hcmluYXNAYXJt
LmNvbTsgd2lsbC5kZWFjb25AYXJtLmNvbTsNCj4gZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7
IGFybmRAYXJuZGIuZGU7IGtzdGV3YXJ0QGxpbnV4Zm91bmRhdGlvbi5vcmc7DQo+IHlhbWFkYS5t
YXNhaGlyb0Bzb2Npb25leHQuY29tDQo+IENjOiBsaW51eEBhcm1saW51eC5vcmcudWs7IFZhcnVu
IFNldGhpIDxWLlNldGhpQG54cC5jb20+OyBVZGl0IEt1bWFyDQo+IDx1ZGl0Lmt1bWFyQG54cC5j
b20+OyBZb2dlc2ggTmFyYXlhbiBHYXVyDQo+IDx5b2dlc2huYXJheWFuLmdhdXJAbnhwLmNvbT47
IEFuZHkgVGFuZyA8YW5keS50YW5nQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIg
My81XSBkcml2ZXJzOiBjbGstcW9yaXE6IEFkZCBjbG9ja2dlbiBzdXBwb3J0IGZvciBseDIxNjBh
DQo+IA0KPiBPbiBGcmksIDIwMTgtMDktMTQgYXQgMDI6MDcgKzA1MzAsIFZhYmhhdiBTaGFybWEg
d3JvdGU6DQo+ID4gRnJvbTogWW9nZXNoIEdhdXIgPHlvZ2VzaG5hcmF5YW4uZ2F1ckBueHAuY29t
Pg0KPiA+DQo+ID4gQWRkIGNsb2NrZ2VuIHN1cHBvcnQgZm9yIGx4MjE2MGEuDQo+ID4gQWRkZWQg
ZW50cnkgZm9yIGNvbXBhdCAnZnNsLGx4MjE2MGEtY2xvY2tnZW4nLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogVGFuZyBZdWFudGlhbiA8YW5keS50YW5nQG54cC5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogWW9nZXNoIEdhdXIgPHlvZ2VzaG5hcmF5YW4uZ2F1ckBueHAuY29tPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFZhYmhhdiBTaGFybWEgPHZhYmhhdi5zaGFybWFAbnhwLmNvbT4NCj4gPiBBY2tl
ZC1ieTogU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPg0KPiA+IC0tLQ0KPiA+ICBkcml2
ZXJzL2Nsay9jbGstcW9yaXEuYyAgICAgICAgIHwgMTQgKysrKysrKysrKysrKy0NCj4gPiAgZHJp
dmVycy9jcHVmcmVxL3FvcmlxLWNwdWZyZXEuYyB8ICAxICsNCj4gPiAgMiBmaWxlcyBjaGFuZ2Vk
LCAxNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9jbGsvY2xrLXFvcmlxLmMgYi9kcml2ZXJzL2Nsay9jbGstcW9yaXEuYyBpbmRleA0K
PiA+IDNhMTgxMmYuLmU5YWU3MGIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jbGsvY2xrLXFv
cmlxLmMNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9jbGstcW9yaXEuYw0KPiA+IEBAIC03OSw3ICs3
OSw3IEBAIHN0cnVjdCBjbG9ja2dlbl9jaGlwaW5mbyB7DQo+ID4gIAljb25zdCBzdHJ1Y3QgY2xv
Y2tnZW5fbXV4aW5mbyAqY211eF9ncm91cHNbMl07DQo+ID4gIAljb25zdCBzdHJ1Y3QgY2xvY2tn
ZW5fbXV4aW5mbyAqaHdhY2NlbFtOVU1fSFdBQ0NFTF07DQo+ID4gIAl2b2lkICgqaW5pdF9wZXJp
cGgpKHN0cnVjdCBjbG9ja2dlbiAqY2cpOw0KPiA+IC0JaW50IGNtdXhfdG9fZ3JvdXBbTlVNX0NN
VVhdOyAvKiAtMSB0ZXJtaW5hdGVzIGlmIGZld2VyIHRoYW4NCj4gPiBOVU1fQ01VWCAqLw0KPiA+
ICsJaW50IGNtdXhfdG9fZ3JvdXBbTlVNX0NNVVgrMV07IC8qIC0xIHRlcm1pbmF0ZSBpZiBmZXdl
ciB0bw0KPiA+IE5VTV9DTVVYKzEgKi8NCj4gDQo+IFlvdSBuZWVkIHRvIGFkZCB0aGUgLTEgdGVy
bWluYXRvciB0byBwNDA4MCwgYW5kIHJlbW92ZSB0aGUgImlmIGZld2VyIg0KPiBjb21tZW50IHNp
bmNlIHRoZSB3aG9sZSBwb2ludCBvZiB0aGlzIGlzIHRoYXQgZXZlcnkgYXJyYXkgZ2V0cyAtMSB0
ZXJtaW5hdGVkLg0KT2ssIFVwZGF0ZWQNCj4gDQo+IFdoeSBkaWQgeW91IGNoYW5nZSAidGVybWlu
YXRlcyIgdG8gInRlcm1pbmF0ZSIgYW5kICJ0aGFuIiB0byAidG8iPw0KPiANCj4gVGhpcyArMSBj
aGFuZ2Ugc2hvdWxkIGJlIGEgc2VwYXJhdGUgcGF0Y2ggZnJvbSBseDIxNjBhIHN1cHBvcnQuDQpT
dXJlLCBTZW5kaW5nIGFzIHNlcGFyYXRlIHBhdGNoDQo+IA0KPiAtU2NvdHQNCg0K
