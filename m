Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C415CC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBD720897
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TP4tim+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FBD720897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbeG0Kkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:40:36 -0400
Received: from mail-eopbgr30062.outbound.protection.outlook.com ([40.107.3.62]:13392
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730340AbeG0Kkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5GPump/HzNE56rCJ5LpS2urECYXMOlTnJ3GE2gKC2A=;
 b=TP4tim+8rik4l7BMX6KG7wDUG9RVTQZ8f/Q6dcxRenOWzXM1gTKKSq6WkTj/tokDIFxUeWQ0yYa7IesIyHZ2Fw/VWQ6KnAz4OXFKlHAfnH169SI8i21LSTXWIHSFmhzyb/3txLPBG6G3JzWQrtSPwT4hP/BpgJ35k7FHghirsB4=
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com (10.170.211.19) by
 DB6PR04MB3238.eurprd04.prod.outlook.com (10.170.215.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.22; Fri, 27 Jul 2018 09:15:40 +0000
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd]) by DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd%4]) with mapi id 15.20.0973.022; Fri, 27 Jul 2018
 09:15:40 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>
Subject: RE: [PATCH v8 2/6] ARM: imx6: register pm_power_off handler if
 "fsl,pmic-stby-poweroff" is set
Thread-Topic: [PATCH v8 2/6] ARM: imx6: register pm_power_off handler if
 "fsl,pmic-stby-poweroff" is set
Thread-Index: AQHUJMI3zxg7besZtU2SpY3UmAmXRaSiyTNA
Date:   Fri, 27 Jul 2018 09:15:40 +0000
Message-ID: <DB6PR04MB3223A62E5609BF6431ABEA40892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-3-o.rempel@pengutronix.de>
In-Reply-To: <20180726092220.17250-3-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB3238;6:Al06/pdSL7MXBvWVEfqB5id/yU6JTOVXZtr7O9e1i+/ZuEdiP4FIb3cg4tg9esFLgO4I6qkLwntWala+m5TBrKOyqa83k8LLRrCT0EXQxFehO8qTFem8WzK+P/fp7z/h5fjzN8mjhuBNNKXOcXt/QF2wFWsVVmRwPhvDA2WHsNgTM4Mzu2WSGsRgzb6+Mmy0UWHB1t2GDIYEfGKgayDpEe2XIMYKW3BUooj0JZG0stlCQBf0YYkX+dll4FxaBWHD+bkEjzdMOQrpPYrzzU5y5W0Y+DoOppnc3sGvnm1a67o1zELI9UkVibFPgnsVAM2bZXRNaCzAoqLR1QSYT/XV/UzeJQt1k+i8wYk+z6Pv6sonIvLlf1AbvZfPVLc/Hove8k8nZn3kX7eBBcS3lwMR3xHmaxTep3jefL5ib27hmnA3T+XYxpM8ihSarXolqmeajTILAuUcdR+oJi9jhvsGJw==;5:bQ+8UHkWqEGz1nXQqtKvYCSZWFAFduq7SDKxtQaQusQmMF7yr688V1tVn8lYmgVncgfukY/E+L1n7kYR0ViQIG0hvvi/UTXhQHUiU9xaJqHyd+x+xqcalq7wNMd9C3QexL8rR2BLJ3gRSSLGqi1ohOcDY/C/sWxIKQXfROvNdMU=;7:xBAZpbFYadglmUqxrZkc6puGrPgy0lZSKVb8dhg48vrNcOI2nCbZ/ad2Mrc2F/RhzuKupEnsGxdcouhzl3VTLmflDIK32qvu/5YdYF8eJux8xehYkNx7u5+UnyJYCu95bN1l3K64jT22QfM+if+t/2kLghHgi2tXUyo6d5Ljsddyet4auvCu5gLO+ECgHzdq5xcmVJOW+qlyxwSD73pYRSD938AKrneXkcA8x5Dbnl4ofA80pyA1WOOJng+DdAus
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 780d3c31-5dd0-4b70-0184-08d5f3a185d5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3238;
x-ms-traffictypediagnostic: DB6PR04MB3238:
x-microsoft-antispam-prvs: <DB6PR04MB3238CA2402AD1024B71DAD4A892A0@DB6PR04MB3238.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(189930954265078)(185117386973197)(85827821059158)(258649278758335)(45079756050767)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3238;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3238;
x-forefront-prvs: 07467C4D33
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(366004)(346002)(376002)(189003)(13464003)(199004)(68736007)(66066001)(7696005)(76176011)(6506007)(14444005)(256004)(26005)(102836004)(53546011)(186003)(476003)(11346002)(14454004)(446003)(486006)(6116002)(110136005)(74316002)(5250100002)(305945005)(54906003)(478600001)(2900100001)(86362001)(45080400002)(7736002)(966005)(3846002)(99286004)(316002)(7416002)(5660300001)(8936002)(229853002)(55016002)(6436002)(39060400002)(81166006)(105586002)(2906002)(33656002)(81156014)(106356001)(8676002)(9686003)(6306002)(25786009)(97736004)(4326008)(6246003)(53936002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3238;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Wj5tIgx8aZETU67rv9avCkvNBoBpp5JwNi6jE68NxDVC5UgxnKyVuPkW5PKukORKPTZAg4y1TRgN4/hLACZmK3oIShbPkNht61ykwwLnbQNVm4xBTR5K9kEZGX0w+F7GokCwhyzfoL/4GWzHKtEjDeUwl0LVfjvKphvtCsZ1yK4fUkDEXXG/CK9yR0z61S6y72qjkISZaWPy1tpSeuUAol4AvItNIv8a16OpGYKaQSO+U1z9lghFD0cArBrSPXrGTJkCgyQRd2RkAW5c/xidDMjz6amVoUVvzywMRnSacpohjt+ZZQUYs9kwnmw+BqIKInAybqVx++tWfT0ytKYZsvrloAMW9v0zGoltfUDDolc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 780d3c31-5dd0-4b70-0184-08d5f3a185d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2018 09:15:40.2115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3238
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogT2xla3NpaiBSZW1wZWwg
W21haWx0bzpvLnJlbXBlbEBwZW5ndXRyb25peC5kZV0NCj4gU2VudDogMjAxOMTqN9TCMjbI1SAx
NzoyMg0KPiBUbzogU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgTWFyayBCcm93biA8
YnJvb25pZUBrZXJuZWwub3JnPjsNCj4gUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29j
a2lAaW50ZWwuY29tPg0KPiBDYzogT2xla3NpaiBSZW1wZWwgPG8ucmVtcGVsQHBlbmd1dHJvbml4
LmRlPjsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1jbGtAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBBbmRyZXcgTW9ydG9u
DQo+IDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPjsgTGlhbSBHaXJkd29vZCA8bGdpcmR3b29k
QGdtYWlsLmNvbT47DQo+IExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+
OyBSb2IgSGVycmluZw0KPiA8cm9iaCtkdEBrZXJuZWwub3JnPjsgTWFyayBSdXRsYW5kIDxtYXJr
LnJ1dGxhbmRAYXJtLmNvbT47IE1pY2hhZWwNCj4gVHVycXVldHRlIDxtdHVycXVldHRlQGJheWxp
YnJlLmNvbT47IFN0ZXBoZW4gQm95ZA0KPiA8c2JveWRAY29kZWF1cm9yYS5vcmc+OyBGYWJpbyBF
c3RldmFtIDxmYWJpby5lc3RldmFtQG54cC5jb20+OyBSdXNzZWxsDQo+IEtpbmcgPGxpbnV4QGFy
bWxpbnV4Lm9yZy51az47IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBSb2JpbiBH
b25nDQo+IDx5aWJpbi5nb25nQG54cC5jb20+OyBBLnMuIERvbmcgPGFpc2hlbmcuZG9uZ0BueHAu
Y29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjggMi82XSBBUk06IGlteDY6IHJlZ2lzdGVyIHBtX3Bv
d2VyX29mZiBoYW5kbGVyIGlmDQo+ICJmc2wscG1pYy1zdGJ5LXBvd2Vyb2ZmIiBpcyBzZXQNCj4g
DQo+IE9uZSBvZiB0aGUgRnJlZXNjYWxlIHJlY29tbWVuZGVkIHNlcXVlbmNlcyBmb3IgcG93ZXIg
b2ZmIHdpdGggZXh0ZXJuYWwNCj4gUE1JQyBpcyB0aGUgZm9sbG93aW5nOg0KPiAuLi4NCj4gMy4g
IFNvQyBpcyBwcm9ncmFtbWluZyBQTUlDIGZvciBwb3dlciBvZmYgd2hlbiBzdGFuZGJ5IGlzIGFz
c2VydGVkLg0KPiA0LiAgSW4gQ0NNIFNUT1AgbW9kZSwgU3RhbmRieSBpcyBhc3NlcnRlZCwgUE1J
QyBnYXRlcyBTb0Mgc3VwcGxpZXMuDQo+IA0KPiBTZWU6DQo+IGh0dHBzOi8vZW1lYTAxLnNhZmVs
aW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnd3dy4NCj4gbnhw
LmNvbSUyRmFzc2V0cyUyRmRvY3VtZW50cyUyRmRhdGElMkZlbiUyRnJlZmVyZW5jZS1tYW51YWxz
JTJGSU0NCj4gWDZEUVJNLnBkZiZhbXA7ZGF0YT0wMiU3QzAxJTdDeWliaW4uZ29uZyU0MG54cC5j
b20lN0MxOTNmZDE5ZTNhDQo+IDQwNDE2ZmZhNGEwOGQ1ZjJkOTU4M2MlN0M2ODZlYTFkM2JjMmI0
YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MxDQo+ICU3QzYzNjY4MTkzNzY2MTkxNDA3NiZhbXA7
c2RhdGE9bElDQWVsWXBVaDQlMkZ0JTJGczdOOW1kazJjTFFNaQ0KPiBjSGNPcVEwN3ZUT1VveU5Z
JTNEJmFtcDtyZXNlcnZlZD0wDQo+IHBhZ2UgNTA4Mw0KPiANCj4gVGhpcyBwYXRjaCBpbXBsZW1l
bnRzIHN0ZXAgNC4gb2YgdGhpcyBzZXF1ZW5jZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9sZWtz
aWogUmVtcGVsIDxvLnJlbXBlbEBwZW5ndXRyb25peC5kZT4NCj4gLS0tDQo+ICBhcmNoL2FybS9t
YWNoLWlteC9wbS1pbXg2LmMgfCAyNSArKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L21hY2gtaW14L3BtLWlteDYuYyBiL2FyY2gvYXJtL21hY2gtaW14L3BtLWlteDYuYw0KPiBpbmRl
eCAwMTc1MzlkZDcxMmIuLjJmNWM2NDNmNjJmYiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vbWFj
aC1pbXgvcG0taW14Ni5jDQo+ICsrKyBiL2FyY2gvYXJtL21hY2gtaW14L3BtLWlteDYuYw0KPiBA
QCAtNjAxLDYgKzYwMSwyOCBAQCBzdGF0aWMgdm9pZCBfX2luaXQgaW14Nl9wbV9jb21tb25faW5p
dChjb25zdCBzdHJ1Y3QNCj4gaW14Nl9wbV9zb2NkYXRhDQo+ICAJCQkJICAgSU1YNlFfR1BSMV9H
SU5UKTsNCj4gIH0NCj4gDQo+ICtzdGF0aWMgdm9pZCBpbXg2X3BtX3N0YnlfcG93ZXJvZmYodm9p
ZCkgew0KPiArCWlteDZfc2V0X2xwbShTVE9QX1BPV0VSX09GRik7DQo+ICsJaW14NnFfc3VzcGVu
ZF9maW5pc2goMCk7DQo+ICsNCj4gKwltZGVsYXkoMTAwMCk7DQo+ICsNCj4gKwlwcl9lbWVyZygi
VW5hYmxlIHRvIHBvd2Vyb2ZmIHN5c3RlbVxuIik7IH0NCj4gKw0KPiArc3RhdGljIGludCBpbXg2
X3BtX3N0YnlfcG93ZXJvZmZfcHJvYmUodm9pZCkgew0KPiArCWlmIChwbV9wb3dlcl9vZmYpIHsN
Cj4gKwkJcHJfd2FybigiJXM6IHBtX3Bvd2VyX29mZiBhbHJlYWR5IGNsYWltZWQgICVwICVwZiFc
biIsDQo+ICsJCQlfX2Z1bmNfXywgcG1fcG93ZXJfb2ZmLCBwbV9wb3dlcl9vZmYpOw0KJ3N5c2Nv
bi1wb3dlcm9mZicgYW5kICdwbWljLXN0YnktcG93ZXJvZmYgJyBzaG91bGQgYmUgY2hvc2VuIGFz
IGEgc2luZ2xlDQpQb3dlcm9mZiB3YXkgZm9yIGFueSBpLm14NiBib2FyZC4gV2h5IG5vdCBkZWxl
dGUgZGlyZWN0bHkgJ3N5c2Nvbi1wb3dlcm9mZicgaW4gZHRzIA0KdG8gYXZvaWQgc3VjaCB0d28g
cG93ZXIgb2ZmIHdheXMgY29leGlzdD8NCj4gKwkJcmV0dXJuIC1FQlVTWTsNCj4gKwl9DQo+ICsN
Cj4gKwlwbV9wb3dlcl9vZmYgPSBpbXg2X3BtX3N0YnlfcG93ZXJvZmY7DQo+ICsJcmV0dXJuIDA7
DQo+ICt9DQo+ICsNCj4gIHZvaWQgX19pbml0IGlteDZfcG1fY2NtX2luaXQoY29uc3QgY2hhciAq
Y2NtX2NvbXBhdCkgIHsNCj4gIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wOw0KPiBAQCAtNjE3LDYg
KzYzOSw5IEBAIHZvaWQgX19pbml0IGlteDZfcG1fY2NtX2luaXQoY29uc3QgY2hhcg0KPiAqY2Nt
X2NvbXBhdCkNCj4gIAl2YWwgPSByZWFkbF9yZWxheGVkKGNjbV9iYXNlICsgQ0xQQ1IpOw0KPiAg
CXZhbCAmPSB+Qk1fQ0xQQ1JfTFBNOw0KPiAgCXdyaXRlbF9yZWxheGVkKHZhbCwgY2NtX2Jhc2Ug
KyBDTFBDUik7DQo+ICsNCj4gKwlpZiAob2ZfcHJvcGVydHlfcmVhZF9ib29sKG5wLCAiZnNsLHBt
aWMtc3RieS1wb3dlcm9mZiIpKQ0KPiArCQlpbXg2X3BtX3N0YnlfcG93ZXJvZmZfcHJvYmUoKTsN
Cj4gIH0NCj4gDQo+ICB2b2lkIF9faW5pdCBpbXg2cV9wbV9pbml0KHZvaWQpDQo+IC0tDQo+IDIu
MTguMA0KDQo=
