Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A2BC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816D720827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s0iqqW4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816D720827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbeKHMEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 07:04:09 -0500
Received: from mail-eopbgr40083.outbound.protection.outlook.com ([40.107.4.83]:62813
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728675AbeKHMEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 07:04:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aldrEAZ3y+S7ZiDV7UbwxXwaDDIRfksV7LeDqCzE1Go=;
 b=s0iqqW4aOxWBIvtOZDbVOYvqRlgPszdZgysM9ZCKWDalL82JaoJina/RC+Zu170uqcbbOJaHwiWS1I49w457kn4n+C/Of2x5nd8MNo2pCmZR+A2MqS92ktRgE7xOalCKwOkP4fl95C3SZVI01Q4OkexxxzglwKmrS28Dfwi9jlA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3708.eurprd04.prod.outlook.com (52.134.70.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Thu, 8 Nov 2018 02:30:53 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 02:30:53 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] ARM: dts: imx7d-sdb: add rev-a board support
Thread-Topic: [PATCH] ARM: dts: imx7d-sdb: add rev-a board support
Thread-Index: AQHUdllc2yTfT4Rj4kWlQDRFrtQfPqVEFXiAgAEAYuCAABDCgIAAAX8g
Date:   Thu, 8 Nov 2018 02:30:53 +0000
Message-ID: <DB3PR0402MB3916B027A9C724D349C7969EF5C50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1541567625-11812-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5AL03yy6Vj_eC=h7scSDnuja1G8rsWER+r7w3FEVaceDg@mail.gmail.com>
 <DB3PR0402MB3916B318947B803BC5ADF4A6F5C50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAOMZO5DiTbEsVXTCfE8fJ=4+yU4oXR1gex7Bj-k=FowKHWJaxw@mail.gmail.com>
In-Reply-To: <CAOMZO5DiTbEsVXTCfE8fJ=4+yU4oXR1gex7Bj-k=FowKHWJaxw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3708;6:exfcdnU+4vAFbMgcWxYbG7KCmrR83mZ6RfdvoZ9wrCT88jl4d6TPEQUVVVkxU5sg6hUeDa86+Pla7nIZVSVLEkQtbP/dOfh+CWAFMBdTIT+Vrd88FNh/6TCQ/qdRVOYoWPnY9fQ7mXEwdLn1LDl5w+PgxFtJXkVuGuBQcbFLl8i+NKvfBesizQdH8hfLdzxpg19g/R6uqUsL/VzBLtJ20xS5qGbVnjcxpJPvDFVKbTEYQWdYy9w8npA6zqOU4/WKcsUjBm0p3iZz/oWUTNAAJ/+6L7qU4kWQyCZKkhROZlqu/j8RdGzD9jfB4HGd/VGfKS0s2xhIjvo1NYxn1da9X7L29UekamncgqaDETh3b6LSSLTB9AMCFaInKopMR+YAstXeaoNyYefCKRGZN2vxZIVAZN8O54K2IXybKDKD19eR/Zek0IorgoAkMygTxhShB8rZAHltXxgW/g6GzsuxUQ==;5:fx0iVjVlccQ0DQY2M3q1zW/gtP2eu3hmtGkrIdNzqNwQUf+5kQiKFqcvKv1UwVIjoQTWeGKv/Ps8X2yvknzqPCc3OudW9abQ3jCASlYreozNp1/umfJ38faf5Fp5Gbz+MlXGQAKygbqCUWqC7vRqBJ6p3U78UuW0vUlGZm1rjv8=;7:TIXQK1xXBTNDGkzTDUfJKWHLyVG3yfttdnhF/PD0Ki5xbURxuTTX0jPFFifGzlnDP93ef1oYC+QNPBKeSs0CPr4a0gwF+w+l8Rf3W73cmcLWbec+3JzmK0O6Hs3nO6e/uIasSvI4OcnBtwloyGJ0ZA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4a229065-b762-4171-79c3-08d64522349c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3708;
x-ms-traffictypediagnostic: DB3PR0402MB3708:
x-microsoft-antispam-prvs: <DB3PR0402MB3708A4719A508CBBD4144A99F5C50@DB3PR0402MB3708.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(185117386973197)(180628864354917)(9452136761055)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3708;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3708;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(39860400002)(376002)(346002)(189003)(199004)(13464003)(74316002)(305945005)(71200400001)(25786009)(71190400001)(5660300001)(39060400002)(14444005)(256004)(97736004)(54906003)(6506007)(53546011)(6116002)(3846002)(102836004)(68736007)(8936002)(81156014)(6246003)(81166006)(7696005)(76176011)(99286004)(2906002)(186003)(1411001)(66066001)(26005)(86362001)(44832011)(6436002)(316002)(33656002)(446003)(11346002)(53936002)(8676002)(486006)(93886005)(2900100001)(105586002)(6916009)(478600001)(106356001)(55016002)(476003)(7736002)(9686003)(4326008)(229853002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3708;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nOdnNXSCPaVqQ67klkN6KFEyT3g3cJ1BzL8kzsJfSpk452Dcigd5a3WPC5cjp1rRzYMpY50eQdOIFOWFynoXiecyb05S0Slw/lzAZ9TRhvayGKUxVwCkIUYlc8Wa4VRqIxcmvDnyV3w748Drrlh5E0Iyq20iOZO+wzfhnFy5nFcT32yOl+wdMCcx/IaAcOONfhcgaQlfkxiJLQN4/iibyWy12WHJO0IdyobZVw1Ct1RTLpRyfFZpSlNYQvHdxUTy4wfA6uIfOPoapZo+5+tx4HLn4/UiJLb82NJDj2VbiPu8eDTPvCWIGv8FApIs9Yf8Sjo1hpp065ydFeWjUmjx6IsqaQD/iP+UqQ5nTZlgBXA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a229065-b762-4171-79c3-08d64522349c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 02:30:53.2753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3708
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEZhYmlvDQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8gRXN0ZXZhbSBbbWFpbHRvOmZlc3RldmFtQGdt
YWlsLmNvbV0NCj4gU2VudDogMjAxOOW5tDEx5pyIOOaXpSAxMDoyMQ0KPiBUbzogQW5zb24gSHVh
bmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IENjOiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJu
ZWwub3JnPjsgTWFyayBSdXRsYW5kDQo+IDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47IFNoYXduIEd1
byA8c2hhd25ndW9Aa2VybmVsLm9yZz47IFNhc2NoYQ0KPiBIYXVlciA8cy5oYXVlckBwZW5ndXRy
b25peC5kZT47IFNhc2NoYSBIYXVlciA8a2VybmVsQHBlbmd1dHJvbml4LmRlPjsNCj4gRmFiaW8g
RXN0ZXZhbSA8ZmFiaW8uZXN0ZXZhbUBueHAuY29tPjsgb3BlbiBsaXN0Ok9QRU4gRklSTVdBUkUg
QU5EDQo+IEZMQVRURU5FRCBERVZJQ0UgVFJFRSBCSU5ESU5HUyA8ZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmc+OyBsaW51eC1rZXJuZWwNCj4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+
OyBtb2RlcmF0ZWQgbGlzdDpBUk0vRlJFRVNDQUxFIElNWCAvIE1YQw0KPiBBUk0gQVJDSElURUNU
VVJFIDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBkbC1saW51eC1pbXgN
Cj4gPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBBUk06IGR0czog
aW14N2Qtc2RiOiBhZGQgcmV2LWEgYm9hcmQgc3VwcG9ydA0KPiANCj4gSGkgQW5zb24sDQo+IA0K
PiBPbiBXZWQsIE5vdiA3LCAyMDE4IGF0IDExOjI0IFBNIEFuc29uIEh1YW5nIDxhbnNvbi5odWFu
Z0BueHAuY29tPg0KPiB3cm90ZToNCj4gDQo+ID4gUmVnYXJkaW5nIHRoZSBmZWMyIHNldHRpbmdz
IGluIGlteDdkLXNkYi5kdHMsIG9yaWdpbmFsbHkgaXQgdXNlcyBSZXYtQQ0KPiA+IGJvYXJkIChi
dXQgc29tZSBub2RlcyBhcmUgdXNpbmcgUmV2LUIgYm9hcmQpLCBpbiB0aGlzIHBhdGNoLCBJIGNs
ZWFuDQo+ID4gdXAgYWxsIHRoZSBzZXR0aW5ncyBpbiBpbXg3ZC1zZGIuZHRzIHVzaW5nIFJldi1C
IGJvYXJkLCBzbyBiZWxvdyBpcw0KPiA+IGFkZGVkIHRvIGlteDdkLXNkYi5kdHMgZm9yIFJldi1C
IGJvYXJkLCBhbmQgaW4gaW14N2Qtc2RiLXJldmEuZHRzIEkgaGF2ZSB0bw0KPiBkZWxldGUgaXQs
IHNpbmNlIFJldi1BIGJvYXJkIGhhcyBubyB0aGlzIHBpbi4NCj4gPg0KPiA+IC0gICAgICAgcGlu
Y3RybC0wID0gPCZwaW5jdHJsX2VuZXQyPjsNCj4gPiArICAgICAgIHBpbmN0cmwtMCA9IDwmcGlu
Y3RybF9lbmV0MiAmcGluY3RybF9lbmV0Ml9lcGRjMF9lbj47DQo+ID4gKyAgICAgICBwaW5jdHJs
LWFzc2VydC1ncGlvcyA9IDwmZ3BpbzEgNCBHUElPX0FDVElWRV9MT1c+Ow0KPiANCj4gInBpbmN0
cmwtYXNzZXJ0LWdwaW9zIiBvbmx5IGV4aXN0cyBpbiB0aGUgTlhQIHZlbmRvciBrZXJuZWwsIHNv
IHlvdSBjYW5ub3QgdXNlDQo+IHN1Y2ggcHJvcGVydHkgaW4gbWFpbmxpbmUuDQoNClRoYW5rcyBm
b3IgcG9pbnRpbmcgb3V0IHRoaXMgaXNzdWUsIEkgbWFkZSBhIG1pc3Rha2Ugd2hlbiBkb2luZyB0
aGUgc2VhcmNoIGluIGdpdCByZXBvLi4NClNvLCBpZiB3ZSBoYXZlIHRvIGFzc2VydCBhIEdQSU8s
IHRoZXJlIGlzIG5vIGNvbW1vbiB3YXkgaW4gcGluY3RybCBkcml2ZXI/IEhhdmUgdG8NCmRvIGl0
IGluIGRyaXZlciBpdHNlbGY/IExpa2UgdGhpcyBjYXNlLCB3ZSBoYXZlIHRvIGFzc2VydCB0aGUg
R1BJTyBpbiBmZWMgZHJpdmVyPw0KDQpPciwgYnkgZGVmYXVsdCB0aGUgR1BJTyBpcyBMT1cgb24g
dGhlIGJvYXJkIHdoaWNoIGlzIGZvciBGRUMyLCB3ZSBjYW4ganVzdCBza2lwIGl0IG5vdz8NClRo
ZSBFUERDIGRyaXZlciBpcyBOT1QgZW5hYmxlZCB5ZXQgaW4gdXBzdHJlYW0gbWFpbmxpbmUuDQoN
CkFuc29uLg0K
