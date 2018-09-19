Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA041ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A59F208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="nmc+3ctq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A59F208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbeISKpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 06:45:21 -0400
Received: from mail-eopbgr700047.outbound.protection.outlook.com ([40.107.70.47]:58707
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726019AbeISKpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 06:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NL/a60zTe22GV6n8SKU+26sg6FE2pnF5IZD7lx2qX9Q=;
 b=nmc+3ctqxy66z7aB4rmcqkFFuzp1+r4/ZnqT52VdD/7AzkdNcQTjRBsqhmHfXLjZzuL+ZTqV2SuWLHN7uNgC3/qPYghZRw3himZ/hhbp+izMaP1iAcG39Ul32bOzQWvshSrXmdD9j2rqZq29yu+QIAg9+zwAnERlHID4IJwehjI=
Received: from DM6PR02MB5227.namprd02.prod.outlook.com (20.176.116.140) by
 DM6PR02MB4444.namprd02.prod.outlook.com (20.176.105.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Wed, 19 Sep 2018 05:08:54 +0000
Received: from DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::8cc4:fb25:d431:bd00]) by DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::8cc4:fb25:d431:bd00%3]) with mapi id 15.20.1143.017; Wed, 19 Sep 2018
 05:08:50 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v7 1/7] edac: synopsys: Fix code comments and naming
 convention
Thread-Topic: [PATCH v7 1/7] edac: synopsys: Fix code comments and naming
 convention
Thread-Index: AQHUTpJJfC+LOp0j9EO9O/F3P2oYsaT1rCWAgAFj+nA=
Date:   Wed, 19 Sep 2018 05:08:50 +0000
Message-ID: <DM6PR02MB52271CFF653377B4810CD305C11C0@DM6PR02MB5227.namprd02.prod.outlook.com>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
 <1537194305-9243-2-git-send-email-manish.narani@xilinx.com>
 <20180918075311.GB22202@nazgul.tnic>
In-Reply-To: <20180918075311.GB22202@nazgul.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB4444;6:ewMNK+OQh4fHdCgdxYkXr4xP5LTsy06+/EKMV/Z0zThC9+YOZ05qQn42sWNJBdyFx8fdg597Bg8Kxv1xsLmoyg+XpvUMDZlP5oNOy1zzKeeYsgtexhcrEjkWA9sQOiwbJYG706G48M5v+YlFvZdbPMdbv8Zqw3JP0y150MY4xrliPGCWTj5ZUPz4sB8WPn9wkDF5oJXdARjvtjCArUlBdy1HSIxwRC54Ts4ZTTCpoSvKRVP43kjCnFLlOVbyPuL7q0FsaLEvPMNuchLHH1tEOjgUnLb3S7JqoQrviy6bMGYMGQAaxGogx8sYPNhgxRpGoNEjMJD05M7i162gZYGRI4YKEAUPncRnmJx8V5H8ck3hKaLU2s2hp5mNDkwbVgIRl40pDurSQ46aX3LudLNIJ2sC4nKnO9hFt4vXI+bOyul+9U85nPO8JIP9K3tgsMCxzYD8MITgd8QaWvPVK1pweg==;5:naTx/1neXhLVP7vYn6vLPzTYU+ueVfS8uEd+/JEsuyWQDdxkDIbA1ymrsFYbZmwtHWal9tXGZvo9EByRXmlER2enoeT0DSRNg299xqIxG7krGVvMAWhnA2TlIAlK+Cuo6egWULPXBB0NQg3VTD/W4qhSk7TD/ne07XRgDGhZmmQ=;7:leEc4kJIrfaDSS2K6xqjTQFh+NACOCYcjPQmycCMoRd/Rbt+x+xyleGP4p+SSlx0YN9mVtjivuayCHkuDj5drIwC/QumX2ti8n+jTJstOgFU4Z6v9sTlnbpjLEajRosBwYeV8QOwyzePO6bmP9j8CnruR3T9aRFRLG78YzUPwYq9R5CRWvkdqoVBGA9UQeEq9umsNRA5p0jo6kUqkqrQTB4Gi5SBB7lqHYsqT/O7Cj/gKI7UrZejGF7gU6SuP1xJ
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: e564a066-4318-4516-123c-08d61dedfd02
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB4444;
x-ms-traffictypediagnostic: DM6PR02MB4444:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <DM6PR02MB4444F2D598B447ABF960BC43C11C0@DM6PR02MB4444.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:DM6PR02MB4444;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4444;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(39860400002)(346002)(376002)(189003)(199004)(13464003)(54906003)(7696005)(55016002)(6436002)(229853002)(3846002)(97736004)(74316002)(66066001)(105586002)(9686003)(76176011)(6246003)(68736007)(53936002)(106356001)(7736002)(7416002)(316002)(6506007)(99286004)(6116002)(305945005)(33656002)(446003)(476003)(478600001)(11346002)(486006)(2900100001)(26005)(25786009)(14454004)(6916009)(53546011)(5250100002)(72206003)(8936002)(102836004)(2906002)(5660300001)(8676002)(81156014)(4326008)(186003)(86362001)(81166006)(256004)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4444;H:DM6PR02MB5227.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3f44Y495zBW0inlOIrlzQArmf2FWLDFAD8HZZ3hDpoI2kGJ844rxKNCOdF1+Lo1FsJAK/KUEZKFucfS98UzjJ4ekwuqPkeauWrJnxDsYJO2vcGjRcUJsUK5mm71lyC9MgwFPPSERRl8rQV57/mcQUSlc3xjDwxAytCcnAFve1yeI9KgoH+WkC0tqrQumfEx5j3z0XMQd8KV7snkS4PXAHM2qA9uwGOTiul/XtzEX8QItCtQgqc0AF7GAUBg2aj7u+4W0oDE/M0QFu9rQhk04kIkeb+x1zy5XUyKVBfEyPkqSMaVI0fG/bs9uPba+bUwwcCNADZgKfwOWqoTeG76mTrHDhWa6VniBX+RiGvzk+24=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e564a066-4318-4516-123c-08d61dedfd02
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 05:08:50.6838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4444
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXMsDQoNClRoYW5rcyBhIGxvdCBmb3IgdGhlIHJldmlldy4NCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgW21haWx0bzpicEBhbGll
bjguZGVdDQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAxOCwgMjAxOCAxOjIzIFBNDQo+IFRv
OiBNYW5pc2ggTmFyYW5pIDxNTkFSQU5JQHhpbGlueC5jb20+DQo+IENjOiByb2JoK2R0QGtlcm5l
bC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOyBtY2hlaGFiQGtlcm5lbC5vcmc7DQo+IE1pY2hh
bCBTaW1layA8bWljaGFsc0B4aWxpbnguY29tPjsgbGVveWFuZy5saUBueHAuY29tOw0KPiBzdWRl
ZXAuaG9sbGFAYXJtLmNvbTsgYW1pdC5rdWNoZXJpYUBsaW5hcm8ub3JnOw0KPiBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+
IGVkYWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyAxLzddIGVkYWM6IHN5bm9wc3lzOiBGaXggY29k
ZSBjb21tZW50cyBhbmQgbmFtaW5nDQo+IGNvbnZlbnRpb24NCj4gDQo+IE9uIE1vbiwgU2VwIDE3
LCAyMDE4IGF0IDA3OjU0OjU5UE0gKzA1MzAsIE1hbmlzaCBOYXJhbmkgd3JvdGU6DQo+ID4gVXBk
YXRlIHRoZSBjb21tZW50cyBpbiB0aGUgU3lub3BzeXMgRURBQyBkcml2ZXIuIE1pbm9yIGNoYW5n
ZXMgdG8NCj4gPiBmdW5jdGlvbiBuYW1lcyBhbmQgcmV0dXJuIHR5cGVzIGFyZSBhbHNvIGluY2x1
ZGVkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFuaXNoIE5hcmFuaSA8bWFuaXNoLm5hcmFu
aUB4aWxpbnguY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2VkYWMvc3lub3BzeXNfZWRhYy5j
IHwgMTc2DQo+ID4gKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgODAgaW5zZXJ0aW9ucygrKSwgOTYgZGVsZXRpb25zKC0pDQo+
IA0KPiBTbyB0aGlzIHBhdGNoIGRvZXMgYSBidW5jaCBvZiB0aGluZ3MgdG9nZXRoZXIgYW5kIHNo
b3VsZCBiZSBzcGxpdCBpbnRvOg0KPiANCj4gKiBmdW5jdGlvbmFsIGNoYW5nZXMgbGlrZSBjb2Rl
IGNsZWFudXANCj4gKiBmdW5jdGlvbnMgcmVuYW1pbmcNCj4gKiBjb21tZW50cyBjbGVhbnVwDQo+
IA0KPiBNYXliZSBpbiB0aGF0IG9yZGVyLg0KPiANCj4gVGhpcyB3YXkgeW91J2xsIGhhdmUgb25l
IGxvZ2ljYWwgc2V0IG9mIGNoYW5nZXMgcGVyIHBhdGNoIGFuZCByZXZpZXcgd2lsbCBiZQ0KPiBh
bG1vc3QgdHJpdmlhbC4NCj4gDQpPa2F5LCBJIHdpbGwgZG8gdGhhdCBpbiB2OC4NCg0KVGhhbmtz
LA0KTWFuaXNoDQo=
