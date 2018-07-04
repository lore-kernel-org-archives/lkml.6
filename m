Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62313C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 01:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0804424449
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 01:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="k8FiConZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0804424449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932754AbeGDBm7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 21:42:59 -0400
Received: from mail-eopbgr00072.outbound.protection.outlook.com ([40.107.0.72]:19835
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932263AbeGDBm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 21:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FW4VSfSzMSgrmOaOR4GWuGjcxMmTATJvRQKuPMi177k=;
 b=k8FiConZ+CPiG71Q7W88xVPWQpf4tvLunxA2mtXNI5xh0+mLkNwQS0j+GtIATk4GtWlZWkfyjFeKScoH23XHrfOq0z3aW9bq3lop9vxIBDpNtIkCXLXEAb/MBK1fGOxEhFG+n30JgZunCdI2kuxFkPiCk2ZhSrLIV3+yFSqlUpA=
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com (10.170.211.19) by
 DB6PR04MB3224.eurprd04.prod.outlook.com (10.170.211.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.26; Wed, 4 Jul 2018 01:42:54 +0000
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::982d:7c4d:d525:42f9]) by DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::982d:7c4d:d525:42f9%5]) with mapi id 15.20.0906.026; Wed, 4 Jul 2018
 01:42:54 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "festevam@gmail.com" <festevam@gmail.com>,
        Anson Huang <anson.huang@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
Thread-Topic: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
Thread-Index: AQHUDD3lErATOOOC6U2dIIt1Q++idKR6JNEAgADqWICAABaiAIAAAEeAgAAAwgCAAADKgIAAAMqAgAAAjgCAAAEVAIAAAkuAgACVe4CAAUXqgIAAIwsAgAA5qACAAXmsAA==
Date:   Wed, 4 Jul 2018 01:42:54 +0000
Message-ID: <1530697336.15665.43.camel@nxp.com>
References: <CAOMZO5BjOEGWv2dC-bp0BYHq+PhLssEKic+o7ock8_1Dobd=sQ@mail.gmail.com>
         <AM3PR04MB131507901BFEE1A5E426EECBF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
         <CAOMZO5D8tjnjbwMdLGd7KF7_4PwqRWX8XH8kdcF3-5e-r2YQEA@mail.gmail.com>
         <AM3PR04MB1315E7AED2BCE2265E6C443DF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
         <CAOMZO5D8v4KM9S4ooHTDbA+vc8BZN_eO_wDuOPA+8Hcq-SmLDw@mail.gmail.com>
         <AM3PR04MB1315C7C7CFF990615732FFBCF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
         <CAOMZO5AM5VRS7UiWuvAQ8vvTB8OM+iwofuYrbsL_yB9e0Z9Kyg@mail.gmail.com>
         <AM3PR04MB13155B8D567ABEF7EF03249AF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
         <CAOMZO5BdtxKjQge5ONpnjr1yNVeTJf4u8Gh-fPqpHz7G9ipOTg@mail.gmail.com>
         <1530526335.15665.13.camel@nxp.com> <20180703053843.GC4348@dragon>
         <AM3PR04MB131542D42FCD798FDBBA54BFF5420@AM3PR04MB1315.eurprd04.prod.outlook.com>
         <CAOMZO5BY99f5jjU+73=8WjqwBKr_q2S1mvx90URZUBkgOVn9YA@mail.gmail.com>
In-Reply-To: <CAOMZO5BY99f5jjU+73=8WjqwBKr_q2S1mvx90URZUBkgOVn9YA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB3224;7:ibRNJQ3/qNv7fyeyvVMbPdQZUI1sMFp1yKqEZLHd+TuhpV6IjRC88TNt+o1T7qO2Nb2Ok9lf3lB6RvWpE5ExfBUzp1bLUXA3zyikHbwEaBCsMySC079HtZDtqdlALUlgqHio9efltvpMKJ2ykRIF/wv4uvSxMDAZbRzG1ZqZnPcMZ/zbLLffeqMZNxAMQWG5wwOC4tttsdBZggHYHaWg2ESzh0fNMKBVE3QMCsIU97LfJW+fN64fuS3Lt4iEv7SZ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: be0c5ede-7853-4159-98b4-08d5e14f7649
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3224;
x-ms-traffictypediagnostic: DB6PR04MB3224:
x-microsoft-antispam-prvs: <DB6PR04MB322467413320749646083BB689410@DB6PR04MB3224.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3224;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3224;
x-forefront-prvs: 0723A02764
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(376002)(136003)(346002)(189003)(199004)(2906002)(97736004)(14454004)(102836004)(103116003)(6636002)(99286004)(5660300001)(2900100001)(478600001)(6486002)(6436002)(6246003)(53936002)(6512007)(4326008)(66066001)(7736002)(50226002)(305945005)(36756003)(105586002)(316002)(6506007)(8936002)(86362001)(54906003)(39060400002)(25786009)(229853002)(486006)(53546011)(106356001)(2501003)(110136005)(5250100002)(6116002)(11346002)(76176011)(2616005)(256004)(81156014)(186003)(8676002)(476003)(446003)(93886005)(3846002)(26005)(68736007)(81166006)(99106002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3224;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pvFELuk4kATqATKlV+PPCka1w1EHcVWpQAZ95oKKwEyTWpaLW9kPyMKR9mEYY+R0Ilaap6TYsR934ynKm6GWBo3ARHyjZnTAGpNW6uX+Dpi9FmKGjvNhTFdtcIg6tDkymNjWFQR3vw0btSvpWDmcOU8zrWj81d7kGuEVjy1I5xSegwJH3Z2sIaDubObQfYx6/TphTr2UErLxbaxtq0i8195sP0c9w7kvGfWEnD2HlleS1r5bmuB5v0VeGxF5D9UCY05Y+M7BpgHlD4Z/nwhBAVudzM2u69gJxQGV4DczAa16ph7x8clITPC7aoja9W/lpaQxmnQ2hP46FInF0fhW/gY3jpr0vxO+WQLE/fA1dQA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B891B2205B58049928F6419B42AAB82@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0c5ede-7853-4159-98b4-08d5e14f7649
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2018 01:42:54.4733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3224
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24g5LqMLCAyMDE4LTA3LTAzIGF0IDA4OjEwIC0wMzAwLCBGYWJpbyBFc3RldmFtIHdyb3RlOg0K
PiBIaSBBbnNvbiwNCj4gDQo+IE9uIFR1ZSwgSnVsIDMsIDIwMTggYXQgNDo0NCBBTSwgQW5zb24g
SHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IHdyb3RlOg0KPiANCj4gPiANCj4gPiBJdCBp
cyBOT1QgZWFzeSB0byBpZGVudGlmeSB3aGljaCBzd2l0Y2ggaXMgY3JpdGljYWwgb3IgTk9ULCBh
bmQNCj4gPiBkaWZmZXJlbnQgcGxhdGZvcm1zDQo+ID4gaGF2ZSBkaWZmZXJlbnQgYm9hcmQgZGVz
aWduLCBpdCB3aWxsIGludHJvZHVjZSBtYW55IHBsYXRmb3JtDQo+ID4gc3BlY2lmaWVkIGNvZGUs
IHNvIEkgdGhpbmsNCj4gPiBqdXN0IHJldmVydCB0aGUgcGZ1emUxMDAgc3dpdGNoIGVuYWJsZS9k
aXNhYmxlIHBhdGNoIHNob3VsZCBiZSBPSw0KPiA+IGZvciBub3cuDQo+IEkgaGF2ZSBzZW50IHRo
ZSBwZnV6ZTEwMCByZWd1bGF0b3IgcGF0Y2ggcmV2ZXJ0IGFuZCBpdCBpcyBsaW51eC1uZXh0DQo+
IG5vdy4gU2hvdWxkIHByb2JhYmx5IHJlYWNoIDQuMTgtcmM0Lg0KPiANCj4gPiANCj4gPiBBZnRl
ciBhIGNvdXBsZSBvZiByZWxlYXNlIGN5Y2xlcywgYWRkIHRoZSBwZnV6ZTEwMCBzd2l0Y2gNCj4g
PiBlbmFibGUvZGlzYWJsZSBwYXRjaA0KPiA+IGJhY2sgdG8gc3VwcG9ydCB0aGlzIGZlYXR1cmUs
IEkgYmVsaWV2ZSB1c2VycyBzaG91bGQgc3dpdGNoIHRvIG5ldw0KPiA+IGR0YiB3aXRoICJyZWd1
bGF0b3ItYWx3YXlzLW9uIg0KPiA+IGV4aXN0aW5nIGFscmVhZHkuDQo+IFRoYXQgd2lsbCBzdGls
bCBicmVhayBvbGQgZHRiIGNvbXBhdGliaWxpdHkuDQo+IA0KPiBZb3UgY2Fubm90IGZvcmNlIHVz
ZXJzIHRvIHVzZSAicmVndWxhdG9yLWFsd2F5cy1vbiIgYW5kIHRoZSBvbGQgZHRicw0KPiBuZWVk
IHRvIGFsd2F5cyB3b3JrLg0KPiANCj4gU28gd2hhdGV2ZXIgbmV3IGZlYXR1cmUgeW91IG5lZWQg
dG8gaW50cm9kdWNlIGl0IG5lZWRzIHRvIGJlIGRvbmUgaW4NCj4gc3VjaCBhIHdheSB0aGF0IHRo
ZSBleGlzdGluZyBkdGIncyB3aWxsIGNvbnRpbnVlIHdvcmtpbmcuDQpCdXQgYWN0dWFsbHkgZXhp
c3RpbmcgZHRiIGlzIG5vdCByaWdodCBzaW5jZSB0aGUgY3JpdGljYWwgcG93ZXIgcmFpbA0KbWlz
c2luZyAncmVndWxhdG9yLWFsd2F5cy1vbicuIEl0J3MgYSBmaXggcGF0Y2ggZm9yIGR0cywgbm90
IHJlbGF0ZWQNCndpdGggZm9sbG93aW5nIGR0Yi9rZXJuZWwgYnJlYWsgcnVsZXMsIGp1c3QgYSBz
aW1wbGUgZHRzIHBhdGNoLiBXaHkNCnNob3VsZCB3ZSBtYWtlIHByb21pc2UgZm9yIHRoZSB3cm9u
ZyBkdGJzPw==
