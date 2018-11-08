Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2105C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 01:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0BD20837
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 01:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NERiqhsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0BD20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbeKHK6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 05:58:06 -0500
Received: from mail-eopbgr30085.outbound.protection.outlook.com ([40.107.3.85]:6800
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728169AbeKHK6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 05:58:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjSmQcOAlBq4ph7i4754s/Go5LdQFzVGG2vf3wZprBY=;
 b=NERiqhsp5tgxY/Dy8LsosBcdPriTejpOaXsTRB9Dls1van5jNb9fVh5IUbSOi/4l22UyTcKjiw5Qzgi0ecc67LHY6EPQpU4RhcABqxVA9wAGEm23U2kzjo+NO2fj/7zTmfM85lP1+wy1qcPjzGl/P3spqDlhPKES9QPflRONtyc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3899.eurprd04.prod.outlook.com (52.134.71.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.22; Thu, 8 Nov 2018 01:24:51 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 01:24:51 +0000
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
Thread-Index: AQHUdllc2yTfT4Rj4kWlQDRFrtQfPqVEFXiAgAEAYuA=
Date:   Thu, 8 Nov 2018 01:24:51 +0000
Message-ID: <DB3PR0402MB3916B318947B803BC5ADF4A6F5C50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1541567625-11812-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5AL03yy6Vj_eC=h7scSDnuja1G8rsWER+r7w3FEVaceDg@mail.gmail.com>
In-Reply-To: <CAOMZO5AL03yy6Vj_eC=h7scSDnuja1G8rsWER+r7w3FEVaceDg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3899;6:ylpoLE9bAt2VlLoaiUrvopIViSkuj/6s6yazWI3aD+JhI91S/nc9qyya4gYCiyonuFcwDoj0dMISCLNncdNm4EsOFliFOs7AFuiwMkLWerIMscL90WLt206OCDgmqbjnAoeORUvLsD30OtBIUyjoeyK/M6sXcuqjpiSfjPVtVLJ3XH3bY2csjYkWvBIp0noQq/nGgUt8xFkzVLFiuqsKGnp+ERhDO1A0HxxINOdY9gsYiNIFVZLdMxIyhcGZGQbDDdCfJ45hjReZphUpBLm3DBtSdWkEf59xeyAxLxqTpdFktr9z/O7tutI1nd591HS7lIOoWvn54VzMa3kaYakUdZT8DEmthoAuu6FWMpArkN+v3vKae8t5ePlWtTbpyKEbRLS5VIxGz9Xny4UKZzVO9o/XnezNISKMfNueRcjSyGoqF0Npw5GOoT0aKn4iNU02SCQXecjenxMQG9eTVwKjnA==;5:E2Wdy+lUZB5ZA29GwDZ0OreJ39fuvPVHd2UGR5xzJGp6DgV7q1AeMAi9JBLejqPjPeNjpE8OQ3G3E2BzEHGY6ELbHH4OR4rQt+NcYLO75Q6ELWGDxn1pKvmT4b2XjXgJaB9OhXrSLSSkgrW/l5Im4HGrHWA2q2Y3idYCyrzXU3s=;7:e6JhmsiI/KUZjoUeEE0sHQyvtniarljGAziVf0gUbK1IRWUiGvNB7aM4OI96yZld6RZ9hkx1b4pA3JLhw3Z/oZwXIO98qZmmM9n+e7AMWZzFbpQVWyVIYhQvJBsmZwMqlfHO20/3FRyJZ6DR8jGWGg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 564f321e-fc97-4275-94c2-08d64518faf5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3899;
x-ms-traffictypediagnostic: DB3PR0402MB3899:
x-microsoft-antispam-prvs: <DB3PR0402MB389968E83D3338EDB8813F8CF5C50@DB3PR0402MB3899.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(185117386973197)(180628864354917)(9452136761055)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3899;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3899;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(366004)(13464003)(189003)(199004)(2906002)(5660300001)(53546011)(6506007)(6916009)(102836004)(186003)(74316002)(9686003)(33656002)(26005)(305945005)(7736002)(6116002)(3846002)(86362001)(106356001)(105586002)(6436002)(316002)(54906003)(14444005)(256004)(25786009)(4326008)(55016002)(478600001)(39060400002)(14454004)(97736004)(99286004)(44832011)(486006)(1411001)(81156014)(81166006)(68736007)(8676002)(8936002)(76176011)(6246003)(7696005)(66066001)(2900100001)(11346002)(446003)(53936002)(229853002)(476003)(71200400001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3899;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LabSyrXFTeFVucn9atyBC+WU5HF7u5Wx1N/qZRsBF6Dg1lo4UR3E4fkJ0cxieNBv5+nbCjTfxa4a63LEuBP3qoTrM7xGbOHEQggRnm69b8GY8U+6oS13KCOvNFIjOZZcttMPZDelivVtOOogmQHORScANi+Ijve632PgCPfDNG8YS/9GaxAC+CBLV7MfgFATWGIJ3/enT+WnhbKTVvqG8a80MCxfn0bB/V9u+ItB2fZA1QKQ1DS85dWTFgF10jKfm2GbbVEAzBycQ4CTF6IhfuDIPo0tqrWQQCQLS9TJjWQlKnoXq39+OjLRsg/crskaQWfr9utNmja/jMu+4Xb+xXOu72E6LGsfB6jaY8TyrD8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 564f321e-fc97-4275-94c2-08d64518faf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 01:24:51.0652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3899
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEZhYmlvDQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8gRXN0ZXZhbSBbbWFpbHRvOmZlc3RldmFtQGdt
YWlsLmNvbV0NCj4gU2VudDogMjAxOOW5tDEx5pyIN+aXpSAxODowMw0KPiBUbzogQW5zb24gSHVh
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
PiBPbiBXZWQsIE5vdiA3LCAyMDE4IGF0IDM6MTkgQU0gQW5zb24gSHVhbmcgPGFuc29uLmh1YW5n
QG54cC5jb20+DQo+IHdyb3RlOg0KPiANCj4gPiArJmZlYzIgew0KPiA+ICsgICAgICAgcGluY3Ry
bC0wID0gPCZwaW5jdHJsX2VuZXQyPjsNCj4gPiArICAgICAgIC9kZWxldGUtcHJvcGVydHkvcGlu
Y3RybC1hc3NlcnQtZ3Bpb3M7DQo+IA0KPiAicGluY3RybC1hc3NlcnQtZ3Bpb3MiIGRvZXMgbm90
IGV4aXN0IGluIG1haW5saW5lLCBzbyBub3Qgc3VyZSB3aHkgeW91IGFyZQ0KPiBkZWxldGluZyBp
dC4NCg0KUmVnYXJkaW5nIHRoZSBmZWMyIHNldHRpbmdzIGluIGlteDdkLXNkYi5kdHMsIG9yaWdp
bmFsbHkgaXQgdXNlcyBSZXYtQSBib2FyZCAoYnV0IHNvbWUgbm9kZXMgYXJlDQp1c2luZyBSZXYt
QiBib2FyZCksIGluIHRoaXMgcGF0Y2gsIEkgY2xlYW4gdXAgYWxsIHRoZSBzZXR0aW5ncyBpbiBp
bXg3ZC1zZGIuZHRzIHVzaW5nIFJldi1CIGJvYXJkLA0Kc28gYmVsb3cgaXMgYWRkZWQgdG8gaW14
N2Qtc2RiLmR0cyBmb3IgUmV2LUIgYm9hcmQsIGFuZCBpbiBpbXg3ZC1zZGItcmV2YS5kdHMgSSBo
YXZlIHRvDQpkZWxldGUgaXQsIHNpbmNlIFJldi1BIGJvYXJkIGhhcyBubyB0aGlzIHBpbi4NCg0K
LQlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfZW5ldDI+Ow0KKwlwaW5jdHJsLTAgPSA8JnBpbmN0cmxf
ZW5ldDIgJnBpbmN0cmxfZW5ldDJfZXBkYzBfZW4+Ow0KKwlwaW5jdHJsLWFzc2VydC1ncGlvcyA9
IDwmZ3BpbzEgNCBHUElPX0FDVElWRV9MT1c+Ow0KIA0KQW5zb24uDQoNCg==
