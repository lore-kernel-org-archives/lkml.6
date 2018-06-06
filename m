Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NuJXhyTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4196D607CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751921AbeFFLsh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 07:48:37 -0400
Received: from mail-eopbgr00070.outbound.protection.outlook.com ([40.107.0.70]:51010
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751770AbeFFLsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 07:48:35 -0400
From: "Y.b. Lu" <yangbo.lu@nxp.com>
To: Richard Cochran <richardcochran@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 09/10] dpaa_eth: add support for hardware timestamping
Thread-Topic: [PATCH 09/10] dpaa_eth: add support for hardware timestamping
Thread-Index: AQHT+9MtmNWDOxXFrU61CgMXgIYqmaRQHgYAgADk+qCAAK+5gIABbXHA
Date: Wed, 6 Jun 2018 11:48:31 +0000
Message-ID: <DB6PR0401MB2536C69465964BB0BD1A4203F8650@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <20180604070837.19265-1-yangbo.lu@nxp.com>
 <20180604070837.19265-10-yangbo.lu@nxp.com>
 <20180604134920.ezhe6jz5ntpnqyzj@localhost>
 <DB6PR0401MB2536376432EC481473A5B4A3F8660@DB6PR0401MB2536.eurprd04.prod.outlook.com>
 <20180605135748.mlarwiyzf2oe27ax@localhost>
In-Reply-To: <20180605135748.mlarwiyzf2oe27ax@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0401MB2600;7:7p2qGlr89fPoSwNJx5/iclcCci/NoI+UVUrqsa6x+3LPXbAQ30/Xz89iryi4tFnq6DcRu3kuwIyk6MGeLSkuHXePWMaXX87+/UET3IsqkK1dmyheEOF/yE3mnCThnM8KvFDonlstCZ9AFYrpURfVJkOkMUFe5RERluluAV+t1U/SWnpn1brEskLH0287WDiiOHEwvTg2EAXiKBFpyTMyKFGbuHbw3Xe4k0qgVy7DFOnTGucmiZsHCkCsgu7J73rR
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0401MB2600;
x-ms-traffictypediagnostic: DB6PR0401MB2600:
x-microsoft-antispam-prvs: <DB6PR0401MB2600CB07FE5A0CE4B0230DE5F8650@DB6PR0401MB2600.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(65623756079841)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0401MB2600;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0401MB2600;
x-forefront-prvs: 06952FC175
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(39380400002)(346002)(39860400002)(376002)(366004)(189003)(199004)(13464003)(53546011)(446003)(5660300001)(68736007)(11346002)(66066001)(33656002)(99286004)(316002)(76176011)(476003)(8936002)(7696005)(486006)(186003)(478600001)(74316002)(14454004)(93886005)(54906003)(7736002)(305945005)(4326008)(39060400002)(81166006)(55016002)(6506007)(5250100002)(3280700002)(229853002)(8676002)(25786009)(6916009)(97736004)(106356001)(3660700001)(3846002)(81156014)(6116002)(105586002)(2906002)(6436002)(26005)(53936002)(1411001)(102836004)(2900100001)(9686003)(86362001)(6246003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0401MB2600;H:DB6PR0401MB2536.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 0ZTMcxQtlRP23+vf2yOMjhDA5MzeHBzOzukkLMIXTO+Wvv00ktCkBmrNNP/jTk/Tf4+XZQtwm1vX6Zi5mVv9ZBSnE636vIAoVOndo7qIXFKCYXnoSxiDhHVippp7mLAyN3ExjI2woLtcWqGwdlUTgsZiVla1GpPvobHQ66ANrf/tMs0LPKUJ0hw7bDbhcuH/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5bcbd89d-fc35-4aed-e9d8-08d5cba36d5f
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bcbd89d-fc35-4aed-e9d8-08d5cba36d5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2018 11:48:31.7122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2600
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmljaGFyZCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNo
YXJkIENvY2hyYW4gW21haWx0bzpyaWNoYXJkY29jaHJhbkBnbWFpbC5jb21dDQo+IFNlbnQ6IFR1
ZXNkYXksIEp1bmUgNSwgMjAxOCA5OjU4IFBNDQo+IFRvOiBZLmIuIEx1IDx5YW5nYm8ubHVAbnhw
LmNvbT4NCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IE1hZGFsaW4tY3Jpc3RpYW4gQnVj
dXINCj4gPG1hZGFsaW4uYnVjdXJAbnhwLmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5l
bC5vcmc+OyBTaGF3biBHdW8NCj4gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBEYXZpZCBTIC4gTWls
bGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
UmU6IFtQQVRDSCAwOS8xMF0gZHBhYV9ldGg6IGFkZCBzdXBwb3J0IGZvciBoYXJkd2FyZSB0aW1l
c3RhbXBpbmcNCj4gDQo+IE9uIFR1ZSwgSnVuIDA1LCAyMDE4IGF0IDAzOjM1OjI4QU0gKzAwMDAs
IFkuYi4gTHUgd3JvdGU6DQo+ID4gW1kuYi4gTHVdIEFjdHVhbGx5IHRoZXNlIHRpbWVzdGFtcGlu
ZyBjb2RlcyBhZmZlY3RlZCBEUEFBIG5ldHdvcmtpbmcNCj4gcGVyZm9ybWFuY2UgaW4gb3VyIHBy
ZXZpb3VzIHBlcmZvcm1hbmNlIHRlc3QuDQo+ID4gVGhhdCdzIHdoeSB3ZSB1c2VkIGlmZGVmIGZv
ciBpdC4NCj4gDQo+IEhvdyBtdWNoIGRvZXMgdGltZSBzdGFtcGluZyBodXJ0IHBlcmZvcm1hbmNl
Pw0KPiANCj4gSWYgdGhlIHRpbWUgc3RhbXBpbmcgaXMgY29tcGlsZWQgaW4gYnV0IG5vdCBlbmFi
bGVkIGF0IHJ1biB0aW1lLCBkb2VzIGl0IHN0aWxsDQo+IGFmZmVjdCBwZXJmb3JtYWNlPw0KDQpb
WS5iLiBMdV0gSSBjYW4ndCByZW1lbWJlciBhbmQgZmluZCB0aGUgb2xkIGRhdGEgc2luY2UgaXQg
aGFkIGJlZW4gYSBsb25nIHRpbWUuDQpJIGp1c3QgZGlkIHRoZSBpcGVyZiB0ZXN0IHRvZGF5IGJl
dHdlZW4gdHdvIDEwRyBwb3J0cy4gSSBkaWRu4oCZdCBzZWUgYW55IHBlcmZvcm1hbmNlIGNoYW5n
ZXMgd2l0aCB0aW1lc3RhbXBpbmcgY29kZSDwn5iKDQpTbywgbGV0J3MgbWUgcmVtb3ZlIHRoZSBp
ZmRlZiBpbiBuZXh0IHZlcnNpb24uDQpUaGFua3MgYSBsb3QuDQoNCg0KPiANCj4gVGhhbmtzLA0K
PiBSaWNoYXJkDQo=
