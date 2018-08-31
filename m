Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECC9C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 06:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C26D20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 06:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iFTkOFtU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C26D20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbeHaKSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 06:18:22 -0400
Received: from mail-eopbgr20088.outbound.protection.outlook.com ([40.107.2.88]:5184
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727197AbeHaKSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 06:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDA0QLWKpYeFzNcMIzPRL1pcXvxSPLSeR3yLSRY80lo=;
 b=iFTkOFtUDAoAn7lJp3qsfUyqK3dp5Mf+6yQsWAYFc/4+uE5cXIjkTh8bax083cjE+1tPddUc5/6CknFotmBtzGiyBrq6xOm+2SAmKKYSlN81e/60Fad+mcJTfeNgQQ803e3jt3I1uW5qzj+C4jstLWXKvgagmxAcqy2FsGWRtBk=
Received: from DB5PR0401MB2213.eurprd04.prod.outlook.com (10.166.173.8) by
 DB5PR0401MB1768.eurprd04.prod.outlook.com (10.165.5.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Fri, 31 Aug 2018 06:12:23 +0000
Received: from DB5PR0401MB2213.eurprd04.prod.outlook.com
 ([fe80::f9e1:eda0:e2ec:6b1]) by DB5PR0401MB2213.eurprd04.prod.outlook.com
 ([fe80::f9e1:eda0:e2ec:6b1%7]) with mapi id 15.20.1101.016; Fri, 31 Aug 2018
 06:12:23 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Scott Wood <oss@buserror.net>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
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
CC:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        Varun Sethi <V.Sethi@nxp.com>, Udit Kumar <udit.kumar@nxp.com>
Subject: RE: [PATCH 3/5] drivers: clk-qoriq: Add clockgen support for lx2160a
Thread-Topic: [PATCH 3/5] drivers: clk-qoriq: Add clockgen support for lx2160a
Thread-Index: AQHUOLbm4rl14SxWF0C6ww3h4NBV1KTV6koAgAIMswCAAKh1AIAAANOAgADNfJA=
Date:   Fri, 31 Aug 2018 06:12:23 +0000
Message-ID: <DB5PR0401MB22130C025AA4CCAD0221781DF30F0@DB5PR0401MB2213.eurprd04.prod.outlook.com>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
 <1534747636-20064-4-git-send-email-vabhav.sharma@nxp.com>
 <4a9ea6b451683ec98c92e86a5ae6b91213a6afcf.camel@buserror.net>
 <VI1PR04MB4800E8B1E8541FCA9221A1CFF3080@VI1PR04MB4800.eurprd04.prod.outlook.com>
 <d2cfd49eb33a3ce74f0e78f2b53d3954d2cb3e76.camel@buserror.net>
 <b31ae8e788fb93971167faa9b55b497e838532c4.camel@buserror.net>
In-Reply-To: <b31ae8e788fb93971167faa9b55b497e838532c4.camel@buserror.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB5PR0401MB1768;6:s3vi6QwNBG0BAwj9UQlmlC9Hli7XH9pe3vnUNvIlJ7NRWTA6Y0JyLBJLqu649vlhe1b2lrUMtNkjPpy1dQzfRR+JgyCMLvPDnxdJ0eG1plVnLjNFrg5BgiJ/Gnu0pBg9wDSY6Yjiqsfkvsi1i7hPns3Sw6sWfKuNs9xCEd8LwHZeauMejdL8BWWoK8macHjrs+l2ZMvOIQFcmwZCOULSoTX4eulbI9Cu6AawhhaR9hKVxqfROQzwEJXzi9t05Z8kJaxkeTDQBTOihukBta0PS1P5VKzde+kPVyHU02tqoumilZeSoRwcEIK5j2++Pl491i1+xpJhkMvnK4KTIWkbfjl6not0EMhXvHbfqjawb/x0Z/xjorU6pf7+/oOUlkq9COm0ZfBz3iyWpyva9ofKthMMfHDWIWMmvAAy1EzWEfP9tSZpmxzJQ5HKiXrObh6wHmwzjAxHcXAd0Z7XQXtR4w==;5:FCwjadUuayRmdc6YOTDeFnqfcGJYIMJ63IbkYxXMdyvM+e1axmTXzaEz0IizQSnSucUHjXFoYu0dzZD2lzS7joERZ4CtXccXplzh6PRF71IXPluMSGgD7yLMpE1WS5QDZVTJIQIu+9zZNDRhhULmFb/ol743C+GgdJcZisPybCk=;7:dWj90USuJnYsDBZxdqs6WixqLow7eUA6hZk1MTRtzYMT4Bt5+PledeyaH+B2a1wKY4bVKUzuvDS++dXZrnDDTYpTD6nhDdhmAl/qpG8SU1e8yWABADX5Bx0oHAG/vJ25J0t/X0rdUR6WyZY8QvYLkDSqnNorfMkUGDxw+XIgquzE3GjO1yGMTu18aojsemqzISsCZa3JVqfmIZyZDtjE44i7fBKDndpDrhEB3KU7Ksx4uwSYCEGhwiRQFfjCoadN
x-ms-office365-filtering-correlation-id: 7ce35cd7-1dde-40db-10ed-08d60f08b7a1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR0401MB1768;
x-ms-traffictypediagnostic: DB5PR0401MB1768:
x-microsoft-antispam-prvs: <DB5PR0401MB17688562F580B5822DB87E87F30F0@DB5PR0401MB1768.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(189930954265078)(65623756079841)(185117386973197)(258649278758335)(45079756050767);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699016);SRVR:DB5PR0401MB1768;BCL:0;PCL:0;RULEID:;SRVR:DB5PR0401MB1768;
x-forefront-prvs: 07817FCC2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(39860400002)(136003)(13464003)(199004)(189003)(256004)(11346002)(53546011)(6506007)(14444005)(476003)(44832011)(446003)(110136005)(6306002)(26005)(54906003)(25786009)(105586002)(68736007)(486006)(102836004)(7416002)(2900100001)(966005)(2201001)(7736002)(8936002)(6246003)(316002)(9686003)(229853002)(86362001)(575784001)(4326008)(186003)(14454004)(305945005)(93886005)(66066001)(74316002)(8676002)(99286004)(5250100002)(76176011)(33656002)(97736004)(53936002)(55016002)(6436002)(5660300001)(45080400002)(81156014)(81166006)(106356001)(478600001)(2501003)(7696005)(3846002)(2906002)(6116002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR0401MB1768;H:DB5PR0401MB2213.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SYkMcI0ueEjuiYrn6GFZkhLqETbYHmBK05fb5TxJNJbYsP//oKSV0E+uToxX+UUyGZbx9uZo6fd4ae3JMQOzJhSjB3t5M3Kh1kbk8x/SEadc+4i1ORH6Uq2WqI6A/kiWM+McAdI3azSRi4juSUgnMDMQmrbvM9BrfexWqfTJDeyn+mPqF3wuFEvM8bQO+wsrYtrPk9+UP1ywRN9u0HaGoU0N5dfPsRD+BMDAFFk6ie1LS2pFibbl79aqP437NF5IRE2L6AlPBK3Il5tNG1Vwf5ImkBh+mX9iaQH1O39ebskiM5qSEjEYfH5MNHEKAGVc0Xkchn8fg679R1OSeY5/6b8oYSgvOuSaHZfUCUa5ggo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce35cd7-1dde-40db-10ed-08d60f08b7a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2018 06:12:23.2323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR0401MB1768
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2NvdHQsDQoNClBsZWFzZSBzZWUgbXkgcmVwbGF5IGlubGluZS4NCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1hcm0ta2VybmVsIDxsaW51eC1hcm0ta2Vy
bmVsLWJvdW5jZXNAbGlzdHMuaW5mcmFkZWFkLm9yZz4NCj4gT24gQmVoYWxmIE9mIFNjb3R0IFdv
b2QNCj4gU2VudDogMjAxOMTqONTCMzHI1SAxOjQzDQo+IFRvOiBWYWJoYXYgU2hhcm1hIDx2YWJo
YXYuc2hhcm1hQG54cC5jb20+Ow0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkZXZp
Y2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxh
bmRAYXJtLmNvbTsNCj4gbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207IHNi
b3lkQGtlcm5lbC5vcmc7IHJqd0Byand5c29ja2kubmV0Ow0KPiB2aXJlc2gua3VtYXJAbGluYXJv
Lm9yZzsgbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtcG1Admdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWwtb3duZXJAdmdlci5rZXJuZWwub3JnOw0KPiBjYXRhbGluLm1hcmlu
YXNAYXJtLmNvbTsgd2lsbC5kZWFjb25AYXJtLmNvbTsNCj4gZ3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc7IGFybmRAYXJuZGIuZGU7DQo+IGtzdGV3YXJ0QGxpbnV4Zm91bmRhdGlvbi5vcmc7IHlh
bWFkYS5tYXNhaGlyb0Bzb2Npb25leHQuY29tDQo+IENjOiBZb2dlc2ggTmFyYXlhbiBHYXVyIDx5
b2dlc2huYXJheWFuLmdhdXJAbnhwLmNvbT47IEFuZHkgVGFuZw0KPiA8YW5keS50YW5nQG54cC5j
b20+OyBsaW51eEBhcm1saW51eC5vcmcudWs7IFZhcnVuIFNldGhpDQo+IDxWLlNldGhpQG54cC5j
b20+OyBVZGl0IEt1bWFyIDx1ZGl0Lmt1bWFyQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggMy81XSBkcml2ZXJzOiBjbGstcW9yaXE6IEFkZCBjbG9ja2dlbiBzdXBwb3J0IGZvcg0KPiBs
eDIxNjBhDQo+IA0KPiBPbiBUaHUsIDIwMTgtMDgtMzAgYXQgMTI6MzkgLTA1MDAsIFNjb3R0IFdv
b2Qgd3JvdGU6DQo+ID4gT24gVGh1LCAyMDE4LTA4LTMwIGF0IDA3OjM2ICswMDAwLCBWYWJoYXYg
U2hhcm1hIHdyb3RlOg0KPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4g
PiBGcm9tOiBsaW51eC1rZXJuZWwtb3duZXJAdmdlci5rZXJuZWwub3JnIDxsaW51eC1rZXJuZWwt
DQo+ID4gPiA+IG93bmVyQHZnZXIua2VybmVsLm9yZz4gT24gQmVoYWxmIE9mIFNjb3R0IFdvb2QN
Cj4gPiA+ID4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMjksIDIwMTggNTo0OSBBTQ0KPiA+ID4g
PiBUbzogVmFiaGF2IFNoYXJtYSA8dmFiaGF2LnNoYXJtYUBueHAuY29tPjsgbGludXgtDQo+ID4g
PiA+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0K
PiA+ID4gPiByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOw0KPiA+ID4g
PiBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsgbGludXgtYXJtLQ0KPiA+ID4gPiBrZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207DQo+ID4gPiA+
IHNib3lkQGtlcm5lbC5vcmc7IHJqd0Byand5c29ja2kubmV0OyB2aXJlc2gua3VtYXJAbGluYXJv
Lm9yZzsNCj4gPiA+ID4gbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsgbGludXgtcG1Admdlci5r
ZXJuZWwub3JnOw0KPiA+ID4gPiBsaW51eC1rZXJuZWwtb3duZXJAdmdlci5rZXJuZWwub3JnOw0K
PiA+ID4gPiBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsgd2lsbC5kZWFjb25AYXJtLmNvbTsNCj4g
PiA+ID4gZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IGFybmRAYXJuZGIuZGU7DQo+ID4gPiA+
IGtzdGV3YXJ0QGxpbnV4Zm91bmRhdGlvbi5vcmc7IHlhbWFkYS5tYXNhaGlyb0Bzb2Npb25leHQu
Y29tDQo+ID4gPiA+IENjOiBZb2dlc2ggTmFyYXlhbiBHYXVyIDx5b2dlc2huYXJheWFuLmdhdXJA
bnhwLmNvbT47IEFuZHkNCj4gVGFuZw0KPiA+ID4gPiA8YW5keS50YW5nQG54cC5jb20+OyBVZGl0
IEt1bWFyIDx1ZGl0Lmt1bWFyQG54cC5jb20+Ow0KPiA+ID4gPiBsaW51eEBhcm1saW51eC5vcmcu
dWs7IFZhcnVuIFNldGhpIDxWLlNldGhpQG54cC5jb20+DQo+ID4gPiA+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggMy81XSBkcml2ZXJzOiBjbGstcW9yaXE6IEFkZCBjbG9ja2dlbiBzdXBwb3J0DQo+ID4g
PiA+IGZvciBseDIxNjBhDQo+ID4gPiA+DQo+ID4gPiA+IE9uIE1vbiwgMjAxOC0wOC0yMCBhdCAx
MjoxNyArMDUzMCwgVmFiaGF2IFNoYXJtYSB3cm90ZToNCj4gPiA+ID4gPiBGcm9tOiBZb2dlc2gg
R2F1ciA8eW9nZXNobmFyYXlhbi5nYXVyQG54cC5jb20+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBB
ZGQgY2xvY2tnZW4gc3VwcG9ydCBmb3IgbHgyMTYwYS4NCj4gPiA+ID4gPiBBZGRlZCBlbnRyeSBm
b3IgY29tcGF0ICdmc2wsbHgyMTYwYS1jbG9ja2dlbicuDQo+ID4gPiA+ID4gQXMgTFgyMTYwQSBp
cyAxNiBjb3JlLCBzbyBtb2RpZmllZCB2YWx1ZSBmb3IgTlVNX0NNVVgNCj4gPiA+ID4gPg0KPiA+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFRhbmcgWXVhbnRpYW4gPGFuZHkudGFuZ0BueHAuY29tPg0K
PiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFlvZ2VzaCBHYXVyIDx5b2dlc2huYXJheWFuLmdhdXJA
bnhwLmNvbT4NCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBWYWJoYXYgU2hhcm1hIDx2YWJoYXYu
c2hhcm1hQG54cC5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gIGRyaXZlcnMvY2xrL2Ns
ay1xb3JpcS5jICAgICAgICAgfCAxNCArKysrKysrKysrKysrLQ0KPiA+ID4gPiA+ICBkcml2ZXJz
L2NwdWZyZXEvcW9yaXEtY3B1ZnJlcS5jIHwgIDEgKw0KPiA+ID4gPiA+ICAyIGZpbGVzIGNoYW5n
ZWQsIDE0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4gPg0KPiA+ID4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9jbGstcW9yaXEuYyBiL2RyaXZlcnMvY2xrL2Nsay1x
b3JpcS5jDQo+ID4gPiA+ID4gaW5kZXgNCj4gPiA+ID4gPiAzYTE4MTJmLi5mYzZlMzA4IDEwMDY0
NA0KPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvY2xrL2Nsay1xb3JpcS5jDQo+ID4gPiA+ID4gKysr
IGIvZHJpdmVycy9jbGsvY2xrLXFvcmlxLmMNCj4gPiA+ID4gPiBAQCAtNjAsNyArNjAsNyBAQCBz
dHJ1Y3QgY2xvY2tnZW5fbXV4aW5mbyB7ICB9Ow0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gICNkZWZp
bmUgTlVNX0hXQUNDRUwJNQ0KPiA+ID4gPiA+IC0jZGVmaW5lIE5VTV9DTVVYCTgNCj4gPiA+ID4g
PiArI2RlZmluZSBOVU1fQ01VWAkxNg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gIHN0cnVjdCBjbG9j
a2dlbjsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEBAIC01NzAsNiArNTcwLDE3IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgY2xvY2tnZW5fY2hpcGluZm8NCj4gPiA+ID4gPiBjaGlwaW5mb1tdID0gew0K
PiA+ID4gPiA+ICAJCS5mbGFncyA9IENHX1ZFUjMgfCBDR19MSVRUTEVfRU5ESUFOLA0KPiA+ID4g
PiA+ICAJfSwNCj4gPiA+ID4gPiAgCXsNCj4gPiA+ID4gPiArCQkuY29tcGF0ID0gImZzbCxseDIx
NjBhLWNsb2NrZ2VuIiwNCj4gPiA+ID4gPiArCQkuY211eF9ncm91cHMgPSB7DQo+ID4gPiA+ID4g
KwkJCSZjbG9ja2dlbjJfY211eF9jZ2ExMiwgJmNsb2NrZ2VuMl9jbXV4X2NnYg0KPiA+ID4gPiA+
ICsJCX0sDQo+ID4gPiA+ID4gKwkJLmNtdXhfdG9fZ3JvdXAgPSB7DQo+ID4gPiA+ID4gKwkJCTAs
IDAsIDAsIDAsIDEsIDEsIDEsIDEsIC0xDQo+ID4gPiA+ID4gKwkJfSwNCj4gPiA+ID4gPiArCQku
cGxsX21hc2sgPSAweDM3LA0KPiA+ID4gPiA+ICsJCS5mbGFncyA9IENHX1ZFUjMgfCBDR19MSVRU
TEVfRU5ESUFOLA0KPiA+ID4gPiA+ICsJfSwNCj4gPiA+ID4NCj4gPiA+ID4gV2h5IGFyZSB5b3Ug
aW5jcmVhc2luZyBOVU1fQ01VWCBiZXlvbmQgOCBmb3IgYSBjaGlwIHRoYXQgb25seQ0KPiBoYXMN
Cj4gPiA+ID4gOCBlbnRyaWVzIGluIGNtdXhfdG9fZ3JvdXA/DQo+ID4gPg0KPiA+ID4gQ29uZmln
dXJhdGlvbiBpcyAxNiBjb3Jlcyw4IGNsdXN0ZXIgd2l0aCAyIGNvcmVzIGluIGVhY2ggY2x1c3Rl
cg0KPiA+DQo+ID4gU28/ICBUaGlzIGlzIGFib3V0IGNtdXhlcywgbm90IGNvcmVzLiAgWW91J3Jl
IGluY3JlYXNpbmcgdGhlIGFycmF5DQo+ID4gd2l0aG91dCBldmVyIHVzaW5nIHRoZSBuZXcgc2l6
ZS4NCj4gDQo+IE9oLCBhbmQgeW91IGFsc28gYnJva2UgcDQwODAgd2hpY2ggaGFzIDggY211eGVz
IGJ1dCBubyAtMSB0ZXJtaW5hdG9yLA0KPiBiZWNhdXNlIHRoZSBhcnJheSB3YXMgb2YgbGVuZ3Ro
IDguICBQcm9iYWJseSB0aGUgYXJyYXkgc2hvdWxkIGJlIGNoYW5nZWQNCj4gdG8gTlVNX0NNVVgr
MSBzbyBldmVyeSBhcnJheSBjYW4gYmUgLTEgdGVybWluYXRlZC4NCj4gDQpbQW5keV0gSG93IGFi
b3V0IHdlIGFkZCAtMSB0ZXJtaW5hdG9yIHRvIHA0MDgwIGFuZCBpbmNyZWFzZSBOVU1fQ01VWCB0
byAxNj8NCldlIGRvbid0IHdhbnQgdG8gaW5jcmVhc2UgTlVNX0NNVVggZWFjaCB0aW1lIG5ldyBz
b2Mgd2l0aCBtb3JlIGNtdXhlcyBhZGRlZC4NCg0KQlIsDQpBbmR5IFRhbmcNCg0KPiAtU2NvdHQN
Cj4gDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xw0KPiBsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdA0KPiBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cHM6Ly9lbWVhMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24u
b3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGbGlzdA0KPiBzLmluZnJhZGVhZC5vcmclMkZt
YWlsbWFuJTJGbGlzdGluZm8lMkZsaW51eC1hcm0ta2VybmVsJmFtcDtkYXRhPTAyDQo+ICU3QzAx
JTdDYW5keS50YW5nJTQwbnhwLmNvbSU3Qzk2M2QwY2RmNDk5NjQ1MzllYTQ0MDhkNjBlYTA2DQo+
IDYzYiU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzY3MTI0
Nw0KPiA5NDE0NTYxMTAxJmFtcDtzZGF0YT1yWlklMkY1SlAwVEJaUkxyJTJCcDZxYUc0b1NRZDhm
c052aXo5MkFZDQo+IDNJb0xUT3clM0QmYW1wO3Jlc2VydmVkPTANCg==
