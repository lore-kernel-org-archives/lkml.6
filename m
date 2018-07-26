Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679DAC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE8020685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EoPS4ViW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE8020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbeGZNLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:11:39 -0400
Received: from mail-eopbgr50087.outbound.protection.outlook.com ([40.107.5.87]:39264
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729354AbeGZNLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWPBUwA/tS87iCqHb0G2R3tX/n6wkpFUA4uKwj95uT0=;
 b=EoPS4ViWPvier5wsn4Bi3GIlkRU7/b8iIO+2nBVJUZDT/yoBOAmjqILngjjwYAY+NiQKJED5FSw0lrDkKg4z0U0z/yioylDVo9/tJEjRqob6tjzhe6npthYriNkF5z6QcmYvXhJ+65D0XQp7aSLUz+BCIMKUMIX1Br1vP3/nOKQ=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4947.eurprd04.prod.outlook.com (20.176.215.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Thu, 26 Jul 2018 11:55:04 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::6c5e:bec5:949d:4cc1]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::6c5e:bec5:949d:4cc1%2]) with mapi id 15.20.0973.022; Thu, 26 Jul 2018
 11:55:04 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ", Sascha Hauer" <kernel@pengutronix.de>,
        ", linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v7 1/6] dt-bindings: mailbox: allow mbox-cells to be equal
 to 0
Thread-Topic: [PATCH v7 1/6] dt-bindings: mailbox: allow mbox-cells to be
 equal to 0
Thread-Index: AQHUJK1m6vAx3xRmv0idxy22l34kDKShQFmAgAAU83CAAAs2AIAABHog
Date:   Thu, 26 Jul 2018 11:55:04 +0000
Message-ID: <AM0PR04MB4211F722024F7F183774D592802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20180726065331.6186-1-o.rempel@pengutronix.de>
 <20180726065331.6186-2-o.rempel@pengutronix.de>
 <CABb+yY2+WwxHBtQfU3TJTErpfzfkNH8iwwYyXbmWAQy8UsqLRQ@mail.gmail.com>
 <AM0PR04MB421178C5283BDCCF11F5E2AF802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CABb+yY1DQbGnWL=HZc=xPLdJjKgkpdvCHmm6Pr6_MvERR=D56Q@mail.gmail.com>
In-Reply-To: <CABb+yY1DQbGnWL=HZc=xPLdJjKgkpdvCHmm6Pr6_MvERR=D56Q@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4947;6:fM8BHAaoY93J/cgD+uQd/5Laqdm9J9yEznlI8O72StIemHR3B7aGaRuVnJnkfU+Gj+XIRP/I0CUaul5IoCI8ohCO0+l8H13su0xKgmQahKXtWj7dZk/JARB8hORTO88sQnclPnb9Mnm/VZ12mAnSajeGmpPAuj4+Q9kQukuLInV79LSr4dllJtcCpoyus/HJCRfFb3NPYN9HDaZdMkVZrJlghHNO0gWRsiFBwkqOo3wcNeElBb1D/ouGnTnKFIxEmR8/xLs2L/qqVSdxzX7Ujh5zpIOyLvOS1fd/CzvFutdSV1UxhpuuyhMHdq65SZ+3RufiCLrnJZAPkwGg5lQkd8mdcv+wlPHjatkQ9PSDY5k98pOL3QMkRDASKQm4e07y5tcEk/v5faZUiMrmWW9fIsp4KxEF8XrGg/n4yb5k9wartIUy2gkzTE9qmvG0Z+uw2vMhyNF4+45LejfbQTB8pg==;5:5xek6Bz7Jy1JDav3J4cg/usRb0es1M5CiM4gZZMRQRWAurz3595MSVJBMxcwtk6ICZfs97zMyXxGDs3n9bDLKwNpXx4G/hOoKp9GbB3Rv4+BfDWlHmA6oWgYJE9cxLV02ScfXxzXyHrBC+jwXeC6bUVcAZOV30bQ7qgkGn0fsM8=;7:h/rrMgpEPc5d7IKVRqpnHmGyoKtFYmrLI+8TXb0PsVwrxfFfGEpP+Vj2gb767toP1HuCO/ESMGroyhi7qkdhgYeUG2T3ZwiFbZ2FPUJD8Tx7RQdT+sOow+OkUjNeek+04asXZ6doV8aJsSqmXeDkxMd8cEodg+0ipmQQN5DFrPEZGetxYaTiaU0qBqZWXfIRGT4hd8q+3BYA5GPYr5q2YrfWkHXHqLLrBLTaknyoPbGoU28WIhJsdy7t9UF5axv9
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 233b072a-4672-4405-1c69-08d5f2ee9fe1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4947;
x-ms-traffictypediagnostic: AM0PR04MB4947:
x-microsoft-antispam-prvs: <AM0PR04MB4947E7AC0C331BE5F893173A802B0@AM0PR04MB4947.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4947;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4947;
x-forefront-prvs: 07459438AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(396003)(366004)(13464003)(199004)(189003)(66066001)(6916009)(97736004)(5660300001)(316002)(33656002)(93886005)(105586002)(1411001)(7416002)(106356001)(76176011)(53546011)(102836004)(446003)(476003)(6506007)(186003)(99286004)(26005)(11346002)(486006)(7696005)(6436002)(68736007)(2906002)(6246003)(3846002)(15650500001)(53936002)(5250100002)(81166006)(6116002)(8676002)(2900100001)(8936002)(54906003)(86362001)(9686003)(55016002)(256004)(74316002)(39060400002)(25786009)(14454004)(4326008)(305945005)(7736002)(478600001)(81156014)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4947;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oZe5k5IlcylTH9FS9CNY+sjgb7BBR5+wHJ7JTN0AdVIU5uVqj/8liwURQghPiaBmVYBX4wUEr4UQ530heKiZPKzYYBRWUDDdAJucIY1Uya8ybSrH/5IoaOccH32E7b/Pkc3fFdIw4WqwbQJ0uT9V9qwt8M52BYUbuUtCMLS4V6CjTmpLUJYD2uq+1m2FP8EyFeJFTj59Yf+OJHgb9oZtiDkEuzpEhwJRMH0kvEnZxhJo6d+Rrb/W+0Ro3caGE+7S1R+USJk38I1g2cu6as1jBtuvf9i+V4Dy2IpnA7Y1sWFIn4YG1UJoZ80MY+9ltW86g9ZelRbn3CUR+TtBuJA6vj1Rs5LLhyxvGEYH9W8rKkI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 233b072a-4672-4405-1c69-08d5f2ee9fe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2018 11:55:04.0324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4947
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYXNzaSBCcmFyIFttYWlsdG86
amFzc2lzaW5naGJyYXJAZ21haWwuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgSnVseSAyNiwgMjAx
OCA3OjM3IFBNDQo+IFRvOiBBLnMuIERvbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KPiBDYzog
T2xla3NpaiBSZW1wZWwgPG8ucmVtcGVsQHBlbmd1dHJvbml4LmRlPjsgU2hhd24gR3VvDQo+IDxz
aGF3bmd1b0BrZXJuZWwub3JnPjsgRmFiaW8gRXN0ZXZhbSA8ZmFiaW8uZXN0ZXZhbUBueHAuY29t
PjsgUm9iDQo+IEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IE1hcmsgUnV0bGFuZCA8bWFy
ay5ydXRsYW5kQGFybS5jb20+Ow0KPiBWbGFkaW1pciBaYXBvbHNraXkgPHZsYWRpbWlyX3phcG9s
c2tpeUBtZW50b3IuY29tPjsgU3VkZWVwIEhvbGxhDQo+IDxzdWRlZXAuaG9sbGFAYXJtLmNvbT47
IERldmljZXRyZWUgTGlzdCA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+Ow0KPiBMaW51eCBL
ZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgLCBTYXNj
aGEgSGF1ZXINCj4gPGtlcm5lbEBwZW5ndXRyb25peC5kZT47ICwgbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnLCBsaW51eC0NCj4gbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9y
Zywgc3J2X2hldXBzdHJlYW0gPGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc+OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY3IDEvNl0gZHQtYmluZGluZ3M6IG1haWxib3g6IGFsbG93IG1ib3gtY2VsbHMgdG8gYmUN
Cj4gZXF1YWwgdG8gMA0KPiANCj4gT24gVGh1LCBKdWwgMjYsIDIwMTggYXQgNDozMCBQTSwgQS5z
LiBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4gd3JvdGU6DQo+ID4+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEphc3NpIEJyYXIgW21haWx0bzpqYXNzaXNpbmdoYnJh
ckBnbWFpbC5jb21dDQo+ID4+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDI2LCAyMDE4IDU6NDIgUE0N
Cj4gPj4gVG86IE9sZWtzaWogUmVtcGVsIDxvLnJlbXBlbEBwZW5ndXRyb25peC5kZT4NCj4gPj4g
Q2M6IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz47IEZhYmlvIEVzdGV2YW0NCj4gPj4g
PGZhYmlvLmVzdGV2YW1AbnhwLmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+
OyBNYXJrDQo+ID4+IFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsgQS5zLiBEb25nIDxh
aXNoZW5nLmRvbmdAbnhwLmNvbT47DQo+ID4+IFZsYWRpbWlyIFphcG9sc2tpeSA8dmxhZGltaXJf
emFwb2xza2l5QG1lbnRvci5jb20+OyBTdWRlZXAgSG9sbGENCj4gPj4gPHN1ZGVlcC5ob2xsYUBh
cm0uY29tPjsgRGV2aWNldHJlZSBMaXN0IDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47DQo+
ID4+IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc+OyAsIFNhc2NoYQ0KPiA+PiBIYXVlciA8a2VybmVsQHBlbmd1dHJvbml4LmRlPjsgLA0KPiA+
PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcsIGxpbnV4LQ0KPiA+PiBtZWRp
YXRla0BsaXN0cy5pbmZyYWRlYWQub3JnLCBzcnZfaGV1cHN0cmVhbSA8bGludXgtYXJtLQ0KPiA+
PiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54
cC5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMS82XSBkdC1iaW5kaW5nczogbWFp
bGJveDogYWxsb3cgbWJveC1jZWxscyB0bw0KPiA+PiBiZSBlcXVhbCB0byAwDQo+ID4+DQo+ID4+
IE9uIFRodSwgSnVsIDI2LCAyMDE4IGF0IDEyOjIzIFBNLCBPbGVrc2lqIFJlbXBlbA0KPiA+PiA8
by5yZW1wZWxAcGVuZ3V0cm9uaXguZGU+DQo+ID4+IHdyb3RlOg0KPiA+PiA+IEZyb206IERvbmcg
QWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQo+ID4+ID4NCj4gPj4gPiBNYWlsYm94IGRl
dmljZXMgbWF5IGhhdmUgb25seSBvbmUgY2hhbm5lbCB3aGljaCBtZWFucyB0aGUNCj4gPj4gPiBt
Ym94LWNlbGxzIGF0IGxlYXN0IDEgZG9lcyBub3QgbWFrZSBzZW5zZSBmb3IgdGhpcyB0eXBlIGRl
dmljZXMuDQo+ID4+ID4gTGV0J3MgcmVtb3ZlIHRoYXQgbGltaXRhdGlvbiB0byBhbGxvdyB0aGUg
bWJveC1jZWxscyB0byBiZSBlcXVhbCB0byAwLg0KPiA+PiA+DQo+ID4+IE9LDQo+ID4+DQo+ID4+
IEJ1dCBwbGVhc2UgcmVhbGlzZSB0aGF0IHlvdSdsbCBoYXZlIHRvIHdyaXRlIG1vcmUgY29kZSAt
LSBpbXBsZW1lbnQNCj4gPj4geW91ciBvd24NCj4gPj4gb2ZfeGxhdGUoKSBjYWxsYmFjay4NCj4g
Pj4gTW9zdCBkZXZlbG9wZXJzIHdvdWxkIHByZWZlciB0byBjYWxsIHRoZSBvbmx5IGNoYW5uZWwg
YXMgY2hhbm5lbA0KPiA+PiBudW1iZXIgMCwgYW5kIHVzZSB0aGUgY29tbW9uIG9mX3hsYXRlIGlt
cGxlbWVudGF0aW9uLg0KPiA+Pg0KPiA+DQo+ID4gWWVzLCB0aGF0J3MgdHJ1ZSBiZWNhdXNlIHRo
ZSBjb21tb24gb2ZfeGxhdGUgYXNzdW1pbmcgdGhlIG1ib3gtY2VsbHMgaXMgMS4NCj4gPiBBbmQg
dGhlcmUncyBhbHJlYWR5IHN1Y2ggdXNlcnM6DQo+ID4gYXJjaC9hcm0vYm9vdC9kdHMvYmNtMjgz
eC5kdHNpDQo+ID4NCj4gWW91IG1lYW4gdGhhdCBpcyBhIGdvb2QgdGhpbmcsIHJpZ2h0Pw0KDQpO
bywgSSBtZWFuIHRoZXJlJ3Mgc2ltaWxhciBIVyBpbiBrZXJuZWwgYWxyZWFkeSB0aGF0IG9ubHkg
aGFzIG9uZSBjaGFubmVsLg0KQXJlIHlvdSBzdWdnZXN0aW5nIGV2ZW4gZm9yIG9uZSBjaGFubmVs
IG1haWxib3gsIHdlIHNob3VsZCBzdGlsbCB1c2UNCk1ib3gtY2VsbHMgMSBhbmQgdXNlICdtYm94
ZXMgPSA8Jm1haWxib3ggMD4nIGluIGRldmljZXRyZWU/DQoNClJlZ2FyZHMNCkRvbmcgQWlzaGVu
Zw0K
