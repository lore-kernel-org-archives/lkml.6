Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4EBC10F04
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B156A222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GW+byEq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390438AbfBNJr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:47:29 -0500
Received: from mail-eopbgr70054.outbound.protection.outlook.com ([40.107.7.54]:7392
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387897AbfBNJr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZo0EYZdce+xKep50GdgE5PeB9RzURF+SN5MDNW2Pwo=;
 b=GW+byEq7vnX6wcKrNP3zeIdNaYYIxTbHE1PQoS1ZxCzBI/yi4LIVv/bXPY9u/BACBBJoCjkrcAePtUOryV8FXIahRBKE3OJeZjNUmghWRW7qqn6z3QqcC1/ft98OdG2PLxaKDqJUtYSGwhj99ynATIMmudeE388ben7fKKZ/P98=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3724.eurprd04.prod.outlook.com (52.134.66.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Thu, 14 Feb 2019 09:47:21 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 09:47:21 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V5 1/2] arm64: dts: freescale: imx8qxp: add cpu opp table
Thread-Topic: [PATCH V5 1/2] arm64: dts: freescale: imx8qxp: add cpu opp table
Thread-Index: AQHUxDuuhaCLw8pC3kmWnqf7p/Ku56Xe97CAgAAUFhA=
Date:   Thu, 14 Feb 2019 09:47:21 +0000
Message-ID: <DB3PR0402MB39163EE75B512102C5FE19E9F5670@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1550131046-2069-1-git-send-email-Anson.Huang@nxp.com>
 <20190214083419.slnuolyy5xhz4szy@vireshk-i7>
In-Reply-To: <20190214083419.slnuolyy5xhz4szy@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2ad2eae-1999-4743-1ef1-08d692616aab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3724;
x-ms-traffictypediagnostic: DB3PR0402MB3724:
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtEQjNQUjA0MDJNQjM3MjQ7MjM6VkZsczlxZi9hdXlidW1Qb2pDWldMVGV6?=
 =?gb2312?B?WldPa3hwVE1MdDd0R1hvLzJqbnJDOENsY2UvS2s4aGZCZ2pyN1ZpT3R0dUZs?=
 =?gb2312?B?c2xreVdXVVpZK2dLdURZdkE0ZCtKcm5jUEc4a29HTGROQ0hvdVUzYmtGQ3cr?=
 =?gb2312?B?dlc3STNpTU41eE90aXQ3VFY0R0ZxdGdaaW5YOGNXMCsvUVlZN21rUk9ORTM5?=
 =?gb2312?B?SjNTNnUvWXFlV2hNb1Q1cktKZ3MyVjRPNHdWREZjZmMyMnI4VDZ4dHpVbldQ?=
 =?gb2312?B?SjhJcDVhRTJENks5TkZ2UHAwNWo3QjVqWmRaQzdOQ1JHNGVaZ2lhVlgwV04w?=
 =?gb2312?B?T0J4UDNhanNXSHRyRjR0RUVEc2FXdll1SU9YZG1nNUtwYksra0hsMGZQSDJC?=
 =?gb2312?B?WW0vNEh6eWNkRnhxQ2gzcDBNU3FnendqcnpzOXlKZUJBcEFsL0g2cEZraFVR?=
 =?gb2312?B?bERUQWcrTndqbjRSUlNjbkphdkJDdzJadHVtSVJtWElxOHZmUGlPSmh2amlz?=
 =?gb2312?B?ZEFWNm1CRDREVVRwVVBWdTgzNzcveWgyVUN1Qm02cmFsTGZFdmQ0Nm80VSsv?=
 =?gb2312?B?K2paOVJKYjh1azhicUFwV2pMeWVRemZ2THdqRzFBdWFlTkdHSzlaUEtlR3lG?=
 =?gb2312?B?NjB4aXRBZzU3d0dMTk0vUFM4ZlpDcUVEeXhLbElIUWlYVlpaTmgvQ3JrbmNW?=
 =?gb2312?B?S2xnL2F3bjM0NjQ2U0tOMDNhcjRaNWE0R0M0djlUd1hsbTBNbTR4dzg4c1A3?=
 =?gb2312?B?VUE5RmxhS3l3NUk5YTRGT2xrOUFNOUZnazcxdlRVWmNyU3ROL1dkWCtKR1hC?=
 =?gb2312?B?dEZMZUFNK21GRVNqZVIvVXQ1ZGlHSldUeVZVRC9KQngvTFZvbUhKRmhFV0lN?=
 =?gb2312?B?bTVrQ1FKUHpTWkMwTEkvSUMxUHd6bUhGRkF3S3pqdHhMWkUwWnhJRVBYSVE1?=
 =?gb2312?B?N1czNERlSHEwQyt3cVZpOG5OM2ZCRzVSNVJkbXBMNXlBbXJZRjBRRnhYa3Ro?=
 =?gb2312?B?KysrNWxXNDFSNm9JOVNrbC9hMjlQblJVSFhLNXRqTm4wVmJtSFljQkppTUhl?=
 =?gb2312?B?RmhVcit5b0VRdUtBS1J5eVZ6WVlqL1E4Q2N0R2xqODJ4VVNOSDhoWHVYdmtk?=
 =?gb2312?B?azZMV0dkMXVOeVM2SWR5dEVIUVlLOGJqMWhzcjdXOHJMeGdFdDJBeHB1YXBm?=
 =?gb2312?B?NDhrc1MvbktvOWZNV2EzRnZCUmNTSXRKZzlKRU5GQXZGbFI3Y0FyeGJzSUlh?=
 =?gb2312?B?anAwWm8yM2ZlbmE4VXo1SkZiQW1WNTNsUmJtUnRNbm5hUDVUeUNCT3FsbkFN?=
 =?gb2312?B?QzEvbnVqT0ZSWlYvNTUzTU1seDIveFI0WElNYUR2WnRLazNLbFhCUHp3Z1Z2?=
 =?gb2312?B?QklNeFdsNnR1OW91Zklma2lVY1ZIQXQvT1RncmR1Rnc4QlRkQ2tQRXlzazAv?=
 =?gb2312?B?Nm9pN1JmV3Y1UDNvdFlxc3k3RDhRbGZTdTNidmJmRCthdnNaUCtPMkdoT2F3?=
 =?gb2312?B?bTFmTjhScGJWeW4zMVV3ZjNYQ042RXhDbDJOYmNINGJSZU5mT0RKcEI0VEwy?=
 =?gb2312?B?aW1PSDN3UHVZd0J4Y0tCYm4vTmtLVUtUZm45RWNodER5R2FlWDVjcnB4emNa?=
 =?gb2312?B?c3lCMDFza2I0dE9WbytpS2l5V1lOTldMcWN1K0E1K2VpbFQ0Tk1IWkJQbWJm?=
 =?gb2312?B?UE9WR2tGS25JalZiZFpLQUxPWXhCVU5hTGtLQnBPUGRtQUdISXd6aDFwWmlW?=
 =?gb2312?B?OG5VemxDRmNhT1VSVFhyTDl3PT0=?=
x-microsoft-antispam-prvs: <DB3PR0402MB37246B759F769BD64169B6C1F5670@DB3PR0402MB3724.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(396003)(39860400002)(189003)(199004)(13464003)(97736004)(54906003)(55016002)(8936002)(81166006)(8676002)(81156014)(7736002)(33656002)(446003)(44832011)(74316002)(305945005)(2906002)(3846002)(7696005)(256004)(476003)(486006)(99286004)(11346002)(7416002)(14444005)(71190400001)(71200400001)(6916009)(6116002)(26005)(478600001)(6246003)(53936002)(14454004)(6506007)(102836004)(186003)(53546011)(76176011)(316002)(6436002)(86362001)(9686003)(25786009)(105586002)(66066001)(106356001)(4326008)(68736007)(229853002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3724;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mvBh1Rx4xBMympAHb+lV7o3NwSXmjq98V4NO0xDjqvmb2qdFelAH1kX6yPBsQqUGnO6v0dC+lFc8gruw+nwuDkaLIryFO3h89X7FqZOgl6wYJVLHDrlm913aTlOLbZRS1DlTcaYDTvdbacO44cKdM4iFmQlrT0SwUzmzARtbh0T6TWgX0TCHCJgR/y14Q/9LAZKn5tz0CokHEsUE9ZLIBqvWMq2ybj6Y6VkctB8VnDXkYqriqHSjo3GR13GIiZPbC4GpV4/E3AulQ3TtU/5j5Zne356lwUu7PphTaxsDd3tYDYEyqUMmiWgnY76BttdTzcwR2G485FucbgNBt3xJVD75Eo8hq9vVHwN+slobpW1jF5lfi29KnxQQJlTTRkNEwlPmPOerwREsftAhaAcmK3T9267G1xP7wKGpB3oZHw4=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ad2eae-1999-4743-1ef1-08d692616aab
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 09:47:21.7455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3724
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFZpcmVzaA0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZpcmVzaCBLdW1hciBbbWFpbHRvOnZpcmVzaC5rdW1h
ckBsaW5hcm8ub3JnXQ0KPiBTZW50OiAyMDE5xOoy1MIxNMjVIDE2OjM0DQo+IFRvOiBBbnNvbiBI
dWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gQ2M6IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFy
ay5ydXRsYW5kQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0
cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBt
dHVycXVldHRlQGJheWxpYnJlLmNvbTsgc2JveWRAa2VybmVsLm9yZzsgQWlzaGVuZyBEb25nDQo+
IDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IERhbmllbCBCYWx1dGEgPGRhbmllbC5iYWx1dGFAbnhw
LmNvbT47DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1jbGtAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LQ0KPiBpbXhAbnhwLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWNSAxLzJdIGFybTY0OiBkdHM6IGZyZWVzY2FsZTog
aW14OHF4cDogYWRkIGNwdSBvcHANCj4gdGFibGUNCj4gDQo+IE9uIDE0LTAyLTE5LCAwODowMiwg
QW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gQWRkIGkuTVg4UVhQIENQVSBvcHAgdGFibGUgdG8gc3Vw
cG9ydCBjcHVmcmVxLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29u
Lkh1YW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBzaW5jZSBWNDoNCj4gPiAJLSBy
ZW1vdmUgcmVkdW5kYW50IGNsb2NrLWxhdGVuY3kgcHJvcGVydHkgaW4gQTM1XzA7DQo+ID4gCS0g
YWRkICNjb29saW5nLWNlbGxzIGZvciBhbGwgQTM1IGNvcmUuDQo+ID4gLS0tDQo+ID4gIGFyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaSB8IDI3DQo+ID4gKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCsp
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14
OHF4cC5kdHNpDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0
c2kNCj4gPiBpbmRleCA0MDIxZjI1Li5mYWQxMjU5IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaQ0KPiA+IEBAIC0zNCw2ICszNCw5IEBADQo+
ID4gIAkJCXJlZyA9IDwweDAgMHgwPjsNCj4gPiAgCQkJZW5hYmxlLW1ldGhvZCA9ICJwc2NpIjsN
Cj4gPiAgCQkJbmV4dC1sZXZlbC1jYWNoZSA9IDwmQTM1X0wyPjsNCj4gPiArCQkJY2xvY2tzID0g
PCZjbGsgSU1YX0EzNV9DTEs+Ow0KPiANCj4gQXMgSSBzYWlkIGluIG15IHByZXZpb3VzIGVtYWls
LCBtZW50aW9uaW5nIGNsb2NrcyBpcyBpbXBvcnRhbnQgdG9vIGZvciBvdGhlcg0KPiBDUFVzLg0K
DQpBbHRob3VnaCBhbGwgQ1BVcyBzaGFyZSBzYW1lIGNsb2NrIGFuZCBvcHAgdGFibGUsIGJ1dCBP
SywgSSB3aWxsIGFkZCBjbG9jayB0bw0KYWxsIENQVXMuDQoNCkFuc29uLg0KPiANCj4gPiArCQkJ
b3BlcmF0aW5nLXBvaW50cy12MiA9IDwmYTM1XzBfb3BwX3RhYmxlPjsNCj4gPiArCQkJI2Nvb2xp
bmctY2VsbHMgPSA8Mj47DQo+ID4gIAkJfTsNCj4gPg0KPiA+ICAJCUEzNV8xOiBjcHVAMSB7DQo+
ID4gQEAgLTQyLDYgKzQ1LDggQEANCj4gPiAgCQkJcmVnID0gPDB4MCAweDE+Ow0KPiA+ICAJCQll
bmFibGUtbWV0aG9kID0gInBzY2kiOw0KPiA+ICAJCQluZXh0LWxldmVsLWNhY2hlID0gPCZBMzVf
TDI+Ow0KPiA+ICsJCQlvcGVyYXRpbmctcG9pbnRzLXYyID0gPCZhMzVfMF9vcHBfdGFibGU+Ow0K
PiA+ICsJCQkjY29vbGluZy1jZWxscyA9IDwyPjsNCj4gPiAgCQl9Ow0KPiA+DQo+ID4gIAkJQTM1
XzI6IGNwdUAyIHsNCj4gPiBAQCAtNTAsNiArNTUsOCBAQA0KPiA+ICAJCQlyZWcgPSA8MHgwIDB4
Mj47DQo+ID4gIAkJCWVuYWJsZS1tZXRob2QgPSAicHNjaSI7DQo+ID4gIAkJCW5leHQtbGV2ZWwt
Y2FjaGUgPSA8JkEzNV9MMj47DQo+ID4gKwkJCW9wZXJhdGluZy1wb2ludHMtdjIgPSA8JmEzNV8w
X29wcF90YWJsZT47DQo+ID4gKwkJCSNjb29saW5nLWNlbGxzID0gPDI+Ow0KPiA+ICAJCX07DQo+
ID4NCj4gPiAgCQlBMzVfMzogY3B1QDMgew0KPiA+IEBAIC01OCw2ICs2NSw4IEBADQo+ID4gIAkJ
CXJlZyA9IDwweDAgMHgzPjsNCj4gPiAgCQkJZW5hYmxlLW1ldGhvZCA9ICJwc2NpIjsNCj4gPiAg
CQkJbmV4dC1sZXZlbC1jYWNoZSA9IDwmQTM1X0wyPjsNCj4gPiArCQkJb3BlcmF0aW5nLXBvaW50
cy12MiA9IDwmYTM1XzBfb3BwX3RhYmxlPjsNCj4gPiArCQkJI2Nvb2xpbmctY2VsbHMgPSA8Mj47
DQo+ID4gIAkJfTsNCj4gPg0KPiA+ICAJCUEzNV9MMjogbDItY2FjaGUwIHsNCj4gPiBAQCAtNjUs
NiArNzQsMjQgQEANCj4gPiAgCQl9Ow0KPiA+ICAJfTsNCj4gPg0KPiA+ICsJYTM1XzBfb3BwX3Rh
YmxlOiBvcHAtdGFibGUgew0KPiA+ICsJCWNvbXBhdGlibGUgPSAib3BlcmF0aW5nLXBvaW50cy12
MiI7DQo+ID4gKwkJb3BwLXNoYXJlZDsNCj4gPiArDQo+ID4gKwkJb3BwLTkwMDAwMDAwMCB7DQo+
ID4gKwkJCW9wcC1oeiA9IC9iaXRzLyA2NCA8OTAwMDAwMDAwPjsNCj4gPiArCQkJb3BwLW1pY3Jv
dm9sdCA9IDwxMDAwMDAwPjsNCj4gPiArCQkJY2xvY2stbGF0ZW5jeS1ucyA9IDwxNTAwMDA+Ow0K
PiA+ICsJCX07DQo+ID4gKw0KPiA+ICsJCW9wcC0xMjAwMDAwMDAwIHsNCj4gPiArCQkJb3BwLWh6
ID0gL2JpdHMvIDY0IDwxMjAwMDAwMDAwPjsNCj4gPiArCQkJb3BwLW1pY3Jvdm9sdCA9IDwxMTAw
MDAwPjsNCj4gPiArCQkJY2xvY2stbGF0ZW5jeS1ucyA9IDwxNTAwMDA+Ow0KPiA+ICsJCQlvcHAt
c3VzcGVuZDsNCj4gPiArCQl9Ow0KPiA+ICsJfTsNCj4gPiArDQo+ID4gIAlnaWM6IGludGVycnVw
dC1jb250cm9sbGVyQDUxYTAwMDAwIHsNCj4gPiAgCQljb21wYXRpYmxlID0gImFybSxnaWMtdjMi
Ow0KPiA+ICAJCXJlZyA9IDwweDAgMHg1MWEwMDAwMCAwIDB4MTAwMDA+LCAvKiBHSUMgRGlzdCAq
Lw0KPiA+IC0tDQo+ID4gMi43LjQNCj4gDQo+IC0tDQo+IHZpcmVzaA0K
