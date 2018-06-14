Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 87539C004E4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 03:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34980208B5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 03:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a476hHAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34980208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935941AbeFNDEk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 23:04:40 -0400
Received: from mail-eopbgr20051.outbound.protection.outlook.com ([40.107.2.51]:47040
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935777AbeFNDEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 23:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8IhAIThdlv+INrt9nI/oBCQzz9ihOPA8Qso0w0yCsg=;
 b=a476hHADfVKQgItX8s4H+dwEVbTwsXpYo9RGFlxUkuOnSRgMugCg9yOF/Cr9JmJr0sWPr+PzrT83j+2g3eqqC+O86l7d7jnky/dxy4r+WrpLODyqsOjwNARbjn+g5uHh6rbbZlnuyKJJOZEXHRChA57NRpqCT2nvv73TCVOFJ/0=
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com (10.170.211.19) by
 DB6PR04MB3030.eurprd04.prod.outlook.com (10.170.213.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.15; Thu, 14 Jun 2018 03:04:35 +0000
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::15a5:6ba0:ac66:7977]) by DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::15a5:6ba0:ac66:7977%2]) with mapi id 15.20.0841.011; Thu, 14 Jun 2018
 03:04:35 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v3 0/6] add virt-dma support for imx-sdma
Thread-Topic: [PATCH v3 0/6] add virt-dma support for imx-sdma
Thread-Index: AQHUAVHamC9wTHQjkEKuAo/ffjDFC6Ra5GaAgAH2IQCAAYQyAIABPX0A
Date:   Thu, 14 Jun 2018 03:04:35 +0000
Message-ID: <1528974252.10947.4.camel@nxp.com>
References: <1528729173-28684-1-git-send-email-yibin.gong@nxp.com>
         <1528714877.2842.3.camel@pengutronix.de> <1528822708.13468.9.camel@nxp.com>
         <1528906072.21021.22.camel@pengutronix.de>
In-Reply-To: <1528906072.21021.22.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB3030;7:IWCYx08ui6iEFZ90lGRFxYUPO5RtiGPpOjrSbFo8gbgH3nC71FAfBLsdCeUXTJmzmAswLQExqB2GmFBVe25BiB4EMO/bMlno/7BsUX1OIQ3IVdKvaiNvcns+x8w8sfDWnFRIYk1xPkzsf0uFxukU/PBqTnF5UQ5HH2Jno+W3bzpQGMUHZD3iyoshAOGxXikrqIcX5HPzMxDjf8VVUuz3Jp7s8YOpE3csy9TbEevJbFJFjUM36ayECWrgavhpc2Q3
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1920cd7b-d0e8-466f-6118-08d5d1a38f6d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3030;
x-ms-traffictypediagnostic: DB6PR04MB3030:
x-microsoft-antispam-prvs: <DB6PR04MB303046E993C47C2E4041D9A0897D0@DB6PR04MB3030.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3030;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3030;
x-forefront-prvs: 0703B549E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(39860400002)(366004)(396003)(376002)(189003)(199004)(3280700002)(8676002)(99286004)(26005)(6486002)(186003)(2900100001)(66066001)(81166006)(81156014)(53936002)(68736007)(54906003)(3660700001)(59450400001)(229853002)(316002)(2906002)(93886005)(305945005)(6512007)(102836004)(106356001)(5660300001)(6506007)(103116003)(110136005)(7736002)(97736004)(105586002)(76176011)(36756003)(25786009)(14454004)(4326008)(6116002)(50226002)(478600001)(3846002)(446003)(11346002)(486006)(476003)(2201001)(2616005)(2501003)(5890100001)(86362001)(8936002)(6246003)(6436002)(5250100002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3030;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Bf8tv/pcCPE3poYZvZQsqYNpIHBrv4IelywAfXZ0ha/E+PP0fo1BwQ5LGDTFHTXYPB+22Lsqd3WyNuC1q+/U+i+v7melnbiUAQYjIiA7or2sDxfWv0hyJsWrfPIvtKaDdNbDie+1rWTJN+a2WlEqRgElwO8bKGOIvM55kWhtzWKUicrURDmJDx1P6b7YH33O
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <65897C81DB15FF4C829230941BCE8DFD@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1920cd7b-d0e8-466f-6118-08d5d1a38f6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2018 03:04:35.7727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTHVjYXMsDQoJSSBoYXZlIGlkZW50aWZpZWQgdGhlIHJvb3QgY2F1c2UgYmVzaWRlcyB0aGUg
bG9ja2RlcCBpc3N1ZS4NCldpbGwgY29udGFpbiB0aGUgVUFSVCBwYXRjaCBpbnRvIG15IG5leHQg
djQgcGF0Y2hzZXQuDQoNCkhpIFNhc2NoYSwNCglXaWxsIGFkZHJlc3MgeW91ciBjb21tZW50cyBp
biB2NCB0b28uIFRoYW5rIHlvdSBib3RoIGlucHV0Lg0KDQpPbiDkuIksIDIwMTgtMDYtMTMgYXQg
MTg6MDcgKzAyMDAsIEx1Y2FzIFN0YWNoIHdyb3RlOg0KPiBIaSBSb2JpbiwNCj4gDQo+IEFtIERp
ZW5zdGFnLCBkZW4gMTIuMDYuMjAxOCwgMDg6NTggKzAwMDAgc2NocmllYiBSb2JpbiBHb25nOg0K
PiA+IA0KPiA+IEhpIEx1Y2FzLA0KPiA+IAlJcyB0aGUgYmVsb3cgREVBRCBMT0NLIGlzc3VlIHNh
bWUgYXMgeW91ciBzaWRlPyBJZiB5ZXMsIHRoZW4NCj4gPiBJJ20gYWZyYWlkIHRoYXQgd2UgaGF2
ZSB0byBtYWtlIGFub3RoZXIgcGF0Y2ggZm9yIHVhcnQgdG8gc3BsaXQgZG1hDQo+ID4gZnVuY3Rp
b25zIGluIHVhcnQgZHJpdmVyIG91dCBvZiB0aGUgY29kZSBhcmVhIHdoaWNoIHByb3RlY3RlZCBi
eQ0KPiA+IHBvcnQubG9jay4gVGhlIHdhcm5pbmcgbWFrZSBzZW5zZSBzaW5jZSBhbGxvY2F0ZSBz
ZG1hIGJkIG1lbW9yeQ0KPiA+IGR5bmFtaWNhbGx5IGluIHZpcnQtZG1hIGluc3RlYWQgb2Ygc3Rh
dGljIGFsbG9jYXRlZCBhcyBiZWZvcmUuIEknbGwNCj4gPiBtYWtlIGFub3RoZXIgdWFydCBwYXRj
aCBpbnRvIG15IG5leHQgdmVyc2lvbiBwYXRjaHNldC4NCj4gWWVzLCBJIHNlZSB0aGUgc2FtZSBs
b2NrZGVwIHNwbGF0IG9uIG15IHN5c3RlbS4gVGhvdWdoIEknbSBub3Qgc3VyZQ0KPiBpZg0KPiB0
aGlzIGlzIHJlYWxseSB0aGUgcm9vdCBjYXVzZSBvZiB0aGUgaXNzdWUgSSBzZWUuDQo+IA0KPiBJ
J20gZ2V0dGluZyB0aW1lb3V0cyBmb3IgYSBzZXJkZXYgYXR0YWNoZWQgZGV2aWNlIGFuZCBJIGRv
bid0IHRoaW5rDQo+IHRoaXMgc3lzdGVtIGV2ZXIgZW50ZXJzIG1lbW9yeSByZWNsYWltLCBzbyB0
aGUgaXNzdWUgcmVwb3J0ZWQgYnkNCj4gbG9ja2RlcCBzZWVtcyB0byBiZSBhIG1vc3RseSB0aGVv
cmV0aWNhbCBvbiB0aGlzIHN5c3RlbS4gQnV0IGxldHMgc2VlDQo+IGhvdyBmYXIgSSBnZXQgd2hl
biB5b3UgZml4ZWQgdGhpcyBpc3N1ZSwgbWF5YmUgdGhlIHJlYWwgYnVnIGlzIGhpZGluZw0KPiBi
ZWhpbmQgdGhpcyBvbmUuDQo+IA0KPiBSZWdhcmRzLA0KPiBMdWNhcw==
