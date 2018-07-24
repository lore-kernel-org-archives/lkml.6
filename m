Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D331ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BF520856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YG/90KcM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0BF520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388455AbeGXNKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:10:31 -0400
Received: from mail-eopbgr20084.outbound.protection.outlook.com ([40.107.2.84]:19612
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388172AbeGXNKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UcflPHAko9pBGUutXXYZydKqIriOG1X5nxXX6NQotk=;
 b=YG/90KcMCpMBNo7yc0BKwqIRiEnSBRJr4BCSmLHBpgjAIVpdd1S7gRxvr1Gab7j+p/nOPhDqeHCrE9VKyAT+0dfzQe35hfcNsR/+ITE5dsUimk86GLpIZc+6qYX16B+K2MJjK0qYVXYxNIiOWv9Z142mgaJWhEkE19wO/Q7qgo0=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4881.eurprd04.prod.outlook.com (20.176.215.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Tue, 24 Jul 2018 12:04:15 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273%4]) with mapi id 15.20.0973.022; Tue, 24 Jul 2018
 12:04:15 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v2 3/3] PCI: imx: Initial imx7d pm support
Thread-Topic: [PATCH v2 3/3] PCI: imx: Initial imx7d pm support
Thread-Index: AQHUICflRr18LcyxG0i6IDU6xEAg0aSckWaAgAAyIICAAWjogIAAICIA
Date:   Tue, 24 Jul 2018 12:04:15 +0000
Message-ID: <24ba42f6028a90836c73317af1f9e9be2d27ba03.camel@nxp.com>
References: <cover.1532090446.git.leonard.crestez@nxp.com>
         <e42a6bb8ff0ddd6eaa31fe381875425a3730a73f.1532090446.git.leonard.crestez@nxp.com>
         <1532338685.3163.93.camel@pengutronix.de>
         <e8be199b2d5559001a93abb52ba46c283e4454a9.camel@nxp.com>
         <1532426953.32306.5.camel@pengutronix.de>
In-Reply-To: <1532426953.32306.5.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4881;6:DfNLao2NrmlKtFy2Vo7gsY1R9lRRpg6C0Qew3Mo8Zm18Uw/rU+Hpi3z+Tz4BrvD9nYu2w+/M523Y961xv5JLep1PGlH482EhJde85jOugckBeslPQ5qV8Vf5piVi3fSVsZF9ePVywX3giAK2fZkG9tR85gvDOpzKHv2oktP95q8RWWQKmu0RmXW44ZsOIwiJNJ75VH1F/RME2r5dzQTGUiNh2Q5WKyuoYnTwh/hLZ8VMZ5o0dcVPCOHh9he5cGUwtM5szFhgiyLhPemprQTL7Jm/DH0GZNj1fZVKOLHa/pLuvsoWDfVlgWQt4nxuPzsTfW9g8FP7msr4mqBasnTZ2OFz/jb4n26XnxBuKjHwi1ZTyf5daYF0oc/5fKN+LOPZqn/lxBYThJNOP5i83F554Mu1XX9C3n3dRHAPDF+qfrRK7AHoklxDBB7KJ8nl7+8li9R9An+MOvbTcw57qsdEfg==;5:AGPUrZWjenHDBM941ILWxCVSFL2B9WhXjwMwA/eNZkn5ZtClmBEg4fBB6NGkLRykuqkgdHPmifIkJoW6TdEuBHsp7Y3YPkbXYw6bqRvLAgMMaRr3E1CtTINFbH7JVYRzupoNlS+NYlsVwfjk+6c0hNpO1T8ZZiMZ6TFs/vBIKx8=;7:7lSl6CBl6Aj/RcQM44z7PPhU6zT5qfi+T7KYiLD1xADOZHaa9UK8nNEVeAYiW+QTqiEcPuJZXVuT1RjiLsxVIH5U0BLpGNolxKgM8yxvGYZMgT/5Fys9KyOGALf349hkiF1er+btnxES6fceJm3vIqxUfUqQ0REkFFAc2chBZiHl+uKTmjttmqCLkeB0ZlcoDRvL+QD+zH8a+WMbhJ1BZENvT+DpmJLk17cpgXeJx2xVkpcN7IObBxdbCT0vfZh9
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e5984474-47da-4614-012d-08d5f15d93c6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4881;
x-ms-traffictypediagnostic: AM0PR04MB4881:
x-microsoft-antispam-prvs: <AM0PR04MB4881C64C88495446F47D76F2EE550@AM0PR04MB4881.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4881;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4881;
x-forefront-prvs: 0743E8D0A6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(136003)(39860400002)(199004)(189003)(44832011)(7416002)(229853002)(2900100001)(36756003)(5660300001)(105586002)(6116002)(305945005)(66066001)(50226002)(106356001)(3846002)(6512007)(6486002)(68736007)(53936002)(6436002)(4326008)(39060400002)(25786009)(97736004)(6246003)(118296001)(478600001)(26005)(6506007)(81166006)(8936002)(76176011)(7736002)(2906002)(14454004)(8676002)(81156014)(186003)(11346002)(86362001)(446003)(102836004)(99286004)(5250100002)(256004)(14444005)(476003)(316002)(2616005)(93886005)(110136005)(486006)(2501003)(54906003)(6636002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4881;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KazkPOyTQNZX4tFwwf5RlpsfAPw2O3V7BFMJPT9PBObC35dlAOFw1hpUa522eTDC7mHw8ojnkhTIGq7+e73OE4WwtOccAi+SAIFjDujDERK59yb+nZUiQgz7+bvKFEIjPGSFVyPMK1IOdD1zsXyvUoAmGtoxhhVcvc19cW+HSH7xC6tb+CWpPy/LlGSAxs/iet0T9WCYkJls11EyFrNcvmVg1yeekSt0ZuJOcVcKIHMG20d5RWjrvRv9mE7BSq2xorpSVlTVz60E+n9U5PHHV33wtwSf0yeuMKRtuNsdVm8Z+famJxy4ukxd4BFl1jjWMeft1We84H04P6FT9UBz0w2m+XaPsblJkPFprVcMv4g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B58E1A02811C6547A9D6F61DEAE10E21@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5984474-47da-4614-012d-08d5f15d93c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2018 12:04:15.5335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4881
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA3LTI0IGF0IDEyOjA5ICswMjAwLCBMdWNhcyBTdGFjaCB3cm90ZToNCj4g
QW0gTW9udGFnLCBkZW4gMjMuMDcuMjAxOCwgMTI6MzcgKzAwMDAgc2NocmllYiBMZW9uYXJkIENy
ZXN0ZXo6DQo+ID4gT24gTW9uLCAyMDE4LTA3LTIzIGF0IDExOjM4ICswMjAwLCBMdWNhcyBTdGFj
aCB3cm90ZToNCj4gPiA+IEFtIEZyZWl0YWcsIGRlbiAyMC4wNy4yMDE4LCAxNTo0NyArMDMwMCBz
Y2hyaWViIExlb25hcmQgQ3Jlc3RlejoNCj4gPiA+ID4gT24gaW14N2QgdGhlIHBjaWUtcGh5IHBv
d2VyIGRvbWFpbiBpcyB0dXJuZWQgb2ZmIGluIHN1c3BlbmQgYW5kIHRoaXMgY2FuDQo+ID4gPiA+
IG1ha2UgdGhlIHN5c3RlbSBoYW5nIGFmdGVyIHJlc3VtZSB3aGVuIGF0dGVtcHRpbmcgYW55IHJl
YWQgZnJvbSBQQ0kuDQo+ID4gPiA+IA0KPiA+ID4gPiBGaXggdGhpcyBieSBhZGRpbmcgbWluaW1h
bCBzdXNwZW5kL3Jlc3VtZSBjb2RlIGZyb20gdGhlIG54cCBpbnRlcm5hbA0KPiA+ID4gPiB0cmVl
LiBUaGlzIHdpbGwgcHJlcGFyZSBmb3IgcG93ZXJpbmcgZG93biBvbiBzdXNwZW5kIGFuZCByZXNl
dCB0aGUgYmxvY2sNCj4gPiA+ID4gb24gcmVzdW1lLg0KPiA+ID4gPiANCj4gPiA+ID4gQ29kZSBp
cyBvbmx5IGZvciBpbXg3ZCBidXQgYSB2ZXJ5IHNpbWlsYXIgc2VxdWVuY2UgY2FuIGJlIHVzZWQg
Zm9yDQo+ID4gPiA+IG90aGVyIHNvY3MuDQo+ID4gPiA+IA0KPiA+ID4gPiArc3RhdGljIHZvaWQg
aW14Nl9wY2llX2x0c3NtX2Rpc2FibGUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ID4gPiArew0K
PiA+ID4gPiArCXN0cnVjdCBpbXg2X3BjaWUgKmlteDZfcGNpZSA9IGRldl9nZXRfZHJ2ZGF0YShk
ZXYpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJc3dpdGNoIChpbXg2X3BjaWUtPnZhcmlhbnQpIHsN
Cj4gPiA+ID4gKwljYXNlIElNWDZROg0KPiA+ID4gPiArCWNhc2UgSU1YNlNYOg0KPiA+ID4gPiAr
CWNhc2UgSU1YNlFQOg0KPiA+ID4gPiArCQlyZWdtYXBfdXBkYXRlX2JpdHMoaW14Nl9wY2llLT5p
b211eGNfZ3ByLCBJT01VWENfR1BSMTIsDQo+ID4gPiA+ICsJCQkJICAgSU1YNlFfR1BSMTJfUENJ
RV9DVExfMiwgMCk7DQo+ID4gPiANCj4gPiA+IEhhcyB0aGlzIGJlZW4gdGVzdGVkIG9uIGkuTVg2
PyBMVFNTTSBkaXNhYmxlIHJlcXVpcmVzIGEgbW9yZSBjb21wbGV4DQo+ID4gPiBzZXF1ZW5jZSBv
biB0aGlzIFNvQyB0byBhdm9pZCBoYW5naW5nIHRoZSBzeXN0ZW0uIFNlZSBjb21taXQNCj4gPiA+
IDNlM2U0MDZlMzgwNyAiUENJOiBpbXg2OiBQdXQgTFRTU00gaW4gIkRldGVjdCIgc3RhdGUgYmVm
b3JlIGRpc2FibGluZw0KPiA+ID4gaXQiLg0KPiA+IA0KPiA+IFRoaXMgcGF0Y2ggb25seSBlbmFi
bGVzIHN1c3BlbmQvcmVzdW1lIGZvciBpbXg3ZCB3aXRoIG90aGVyIFNPQ3MgdG8NCj4gPiBmb2xs
b3cgbGF0ZXIuIFRoZSBsdHNzbV9kaXNhYmxlIGZ1bmN0aW9uIGlzIGp1c3Qgc3ltbWV0cmljIHdp
dGgNCj4gPiBsdHNzbV9lbmFibGUuDQo+ID4gDQo+ID4gVGhlIDZRIHBhcnRzIGFyZSBhZmZlY3Rl
ZCBieSBlcnJhdGEgIkVSUjAwNTcyMyBQQ0llOiBQQ0llIGRvZXMgbm90DQo+ID4gc3VwcG9ydCBM
MiBwb3dlciBkb3duIFtpLk1YIDZEdWFsLzZRdWFkIE9ubHldIi4NCj4gPiANCj4gPiBUaGlzIGRl
c2lnbiBlcnJvciBzZWVtcyB0byBoYXZlIHRoZSBzYW1lIHJvb3QgY2F1c2UgYXMgeW91ciBwcm9i
bGVtIChubw0KPiA+IGRlZGljYXRlZCByZXNldCBjb250cm9sKSBzbyB0aGlzIHdvcmtzIG91dCBx
dWl0ZSBuaWNlbHk6IHRoZSBzb2x1dGlvbg0KPiA+IGlzIHRvIG5ldmVyIHBvd2VyIGRvd24gcGNp
IG9uIGFmZmVjdGVkIGNoaXBzLg0KPiANCj4gSSBkb24ndCBxdWl0ZSBsaWtlIGNvZGUgdGhhdCBs
b29rcyBsaWtlIGl0IGlzIGRvaW5nIHRoZSByaWdodCB0aGluZywNCj4gYnV0IHRoZW4gZG9lc24n
dC4gQ2FuIHdlIGF0IGxlYXN0IGVtaXQgYSB3YXJuaW5nIHRoYXQgdGhlcmUgbWlnaHQgYmUNCj4g
ZHJhZ29ucyBpZiBhbnlvbmUgdHJpZXMgdG8gY2FsbCB0aGlzIG9uIGkuTVg2Pw0KDQpCdXQgdGhl
IGZ1bmN0aW9uIHdpbGwgaW5kZWVkIHRvZ2dsZSB0aGUgcmlnaHQgYml0cyB0byBpbml0aWF0ZSBs
dHNzbQ0KZGlzYWJsaW5nLiBJZiB0aGlzIGlzIG5vdCB1c2VmdWwgb3IgY2FuJ3QgYmUgdXNlZCBy
aWdodCB0aGVuIGl0J3MgdGhlDQpjYWxsZXIncyBwcm9ibGVtIDopDQoNCkkgY2FuIGFkZCBhIGRl
ZmF1bHQ6IGNsYXVzZSB0byB0aGUgc3dpdGNoIHdoaWNoIHJldHVybnMgLUVOT1NZUyBhbmQgbGV0
DQpJTVg2USBmYWxsIHRoYXQgd2F5LCB3b3VsZCB0aGF0IGJlIE9LPyBUaGlzIHdvdWxkIGFsc28g
aGVscCB3aGVuIGFkZGluZw0KbmV3IHZhcmlhbnRzLg==
