Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76019C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E062145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OzPLCrO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E062145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeIXQI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:08:56 -0400
Received: from mail-eopbgr680043.outbound.protection.outlook.com ([40.107.68.43]:44416
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725982AbeIXQI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9I3KNNTKx1NVSKeKcB/lHl+KaQRMge3e84kKlLYqpI=;
 b=OzPLCrO8DkcnStjudYcKt4B6nXJDfY4/ZK+f4VMB86haK24ys/3Ilr3DvcyNM0WV06vwYCZnOvm0R1tTsT03kGO+QRCwMoKeiVuKdBsUlhdre4e+zQCQnaNifC6Iqv9HXK6dnthiWrpfiXvZIXn8OOaKMoCjq0tqacszURJGZb0=
Received: from DM6PR02MB5227.namprd02.prod.outlook.com (20.176.116.140) by
 DM6PR02MB4059.namprd02.prod.outlook.com (20.176.75.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.20; Mon, 24 Sep 2018 10:07:34 +0000
Received: from DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::8cc4:fb25:d431:bd00]) by DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::8cc4:fb25:d431:bd00%3]) with mapi id 15.20.1164.024; Mon, 24 Sep 2018
 10:07:33 +0000
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
Subject: RE: [PATCH v7 2/7] edac: synps: Add platform specific structures for
 ddrc controller
Thread-Topic: [PATCH v7 2/7] edac: synps: Add platform specific structures for
 ddrc controller
Thread-Index: AQHUTpJW1XQNYRxn3kWgpPIZoEhCVaT1rMEAgAFj0DCAAGaLgIAAI+zggALc1YCABMdaMA==
Date:   Mon, 24 Sep 2018 10:07:33 +0000
Message-ID: <DM6PR02MB5227B76AD2D71C4EABCA48DCC1170@DM6PR02MB5227.namprd02.prod.outlook.com>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
 <1537194305-9243-3-git-send-email-manish.narani@xilinx.com>
 <20180918075522.GC22202@nazgul.tnic>
 <DM6PR02MB5227F5B1B329C903BA64A27CC11C0@DM6PR02MB5227.namprd02.prod.outlook.com>
 <20180919111553.GA9140@nazgul.tnic>
 <DM6PR02MB52279753E7FD04587393DC08C11C0@DM6PR02MB5227.namprd02.prod.outlook.com>
 <20180921090721.GB30439@nazgul.tnic>
In-Reply-To: <20180921090721.GB30439@nazgul.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB4059;6:iJzR8LBfpuyB0rlhlHwxgbyoMW3y7NKsDk/OGRO9algIGvfhsl6z5MX7tpVKgnZXcCeVKY2uEu4Wim/nR7sUz2hx3Vukj8Gqyx//NyMkgTXNH05OZQN+paflDl1iVMKw/uP2kjeG+2snyApF/EH6gWayFgvbNo4s+DXUBmGgsWMsSmlinHHbgH/DL09xDuqzLzauo8a31MKpLuPg7yXqUsADUgHPBH2BNl4hkdbbYl5ZZFB80WSeNUEl5gOjJmJDdIrAxiHAqptk/Xlk9NPI/X73cPLjkX9vxxWEMSq9jznfQ+GdjAjRMnoQYt5wweMtmwALLQx47MxIwzmGFUtKRn7iAh1BepSuAWo/YQF8lMCUhBWBuZR940dCSSuUF2wP7FK63ScQBKPBnAFy0v7NIXuwY6o+iyQqac2pqVgEVdBGynN23unt6A+O1LyZMPJwoRpBSuolNHsCIGd97FXD1w==;5:YchbSg+iW1E7WjdDwZgy9fd6JypHGJHNo8i+n9ZuE7vwhbXYTfNrPRIkMlxa3xsmg/dfZhwNA9ls+E/pLoaHKS0kI8NCgFJoVQDNG1eiyLx4oX9eQP9nU/Uo0nhDCFCZOMIP++5c5C9b31a6ICINolJzpWEhuz6IOkYn7CtzyNs=;7:IMsAEtAUgBKinZ1xOFMYGyBIDR91YvsUqAtrKir756XJHrolZXf1HzNKEobvo7MMvPsRwj7GZ5lkaYvpnBWpECt0rGlbkmhXJ0W+gOh5xtv7YGfzfe7GRrII2JZ7wPCl1pdGXs35o8TgYdZwlVR8K3Lk/vOVuIGOK0jyBTZll28aBFjGQcQ/smjZ0pN2ljuJg24h0CiEPSwU4UgW5hkSchXoz4dBNUX6bkrsIjClJS2lfc7x9R/7gwd+2EOUQYiZ
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(376002)(346002)(396003)(13464003)(189003)(199004)(51914003)(3846002)(478600001)(25786009)(14454004)(72206003)(66066001)(186003)(446003)(11346002)(486006)(476003)(256004)(105586002)(76176011)(106356001)(71200400001)(71190400001)(4326008)(7696005)(54906003)(316002)(93886005)(6436002)(55016002)(68736007)(53936002)(9686003)(97736004)(2900100001)(74316002)(2906002)(305945005)(7736002)(8676002)(8936002)(81166006)(81156014)(6506007)(53546011)(26005)(102836004)(7416002)(33656002)(6246003)(86362001)(229853002)(6116002)(6916009)(5660300001)(5250100002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4059;H:DM6PR02MB5227.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: b079a25e-987f-4fef-5cba-08d622058b9c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB4059;
x-ms-traffictypediagnostic: DM6PR02MB4059:
x-microsoft-antispam-prvs: <DM6PR02MB4059FFC621CF8F439087B170C1170@DM6PR02MB4059.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(185117386973197)(9452136761055)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(149066)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:DM6PR02MB4059;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4059;
x-forefront-prvs: 0805EC9467
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hJ0S6IXfj+6EOMnn+E9CgMl2gR6wRvdBKEqKF4RnaiDz95/eItMZGtCFYSKgoFUxw4duzf8zUoWjwqvEeq0cXfXmHOFq1rZ1sorpII3Gu8Z64Zk+ueV8txFhyDjOHKQN9jr6ev8IWWJw6GxMhUX1Tnkx9AmKjBee+7pdvpiwa61Ut9MMhwqYPQfich/HvLKvVCyV4UbUlAd9oEFewHLxDul4yROHPh4zLLSae4npVY2n7/la55Jc34V0C08OnwphMWNYb2wBDzCuElpKKNhOiTvq8qbY7JtOMe9a2J+smI2hH0G5IC3jpD+pLzUCQa7glkwZ2uHIWdYVH8BnrxXjU95YQaYXAtU6w6z7ywMlecA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b079a25e-987f-4fef-5cba-08d622058b9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 10:07:33.1224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXMsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEJvcmlzbGF2IFBldGtvdiBbbWFpbHRvOmJwQGFsaWVuOC5k
ZV0NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMjEsIDIwMTggMjozNyBQTQ0KPiBUbzogTWFu
aXNoIE5hcmFuaSA8TU5BUkFOSUB4aWxpbnguY29tPg0KPiBDYzogcm9iaCtkdEBrZXJuZWwub3Jn
OyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgbWNoZWhhYkBrZXJuZWwub3JnOw0KPiBNaWNoYWwgU2lt
ZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47IGxlb3lhbmcubGlAbnhwLmNvbTsNCj4gc3VkZWVwLmhv
bGxhQGFybS5jb207IGFtaXQua3VjaGVyaWFAbGluYXJvLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBlZGFj
QHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMi83XSBlZGFjOiBzeW5wczogQWRkIHBsYXRmb3JtIHNw
ZWNpZmljIHN0cnVjdHVyZXMgZm9yDQo+IGRkcmMgY29udHJvbGxlcg0KPiANCj4gT24gV2VkLCBT
ZXAgMTksIDIwMTggYXQgMDE6MzM6NThQTSArMDAwMCwgTWFuaXNoIE5hcmFuaSB3cm90ZToNCj4g
PiBBcGFydCBmcm9tIHRoaXMgb25lLCBJIGhhdmUgY292ZXJlZCBhbGwgdGhlIGNvbW1lbnRzIGZy
b20gdGhlIHByZXZpb3VzDQo+IHJldmlldy4NCj4gDQo+IEFyZSB5b3Ugc3VyZT8NCj4gDQo+IExl
dCdzIHNlZS4gSSBzYWlkOg0KPiANCj4gfCBLaWxsIGFsbCB0aGF0ICJmdW5jdGlvbiBwb2ludGVy
IiBmbHVmZi4gSGVyZSdzIGhvdyBJJ3ZlIGNoYW5nZWQgaXQ6DQo+IHwNCj4gfCAvKioNCj4gfCAg
KiBzdHJ1Y3Qgc3lucHNfcGxhdGZvcm1fZGF0YSAtICBzeW5wcyBwbGF0Zm9ybSBkYXRhIHN0cnVj
dHVyZQ0KPiB8ICAqIEBlZGFjX2dldGVycm9yX2luZm86IGVkYWMgZXJyb3IgaW5mbw0KPiB8ICAq
IEBlZGFjX2dldF9tdHlwZTogICAgIGdldCBtdHlwZQ0KPiB8ICAqIEBlZGFjX2dldF9kdHlwZTog
ICAgIGdldCBkdHlwZQ0KPiB8ICAqIEBlZGFjX2dldF9lY2NzdGF0ZTogIGdldCBFQ0Mgc3RhdGUN
Cj4gCQkJICBeXl5eXl5eXl5eXl5eDQo+IA0KPiBUaGlzIGlzIHN1cHBvc2VkIHRvIGRlbm90ZSB0
aGF0IHRoaXMgZnVuY3Rpb24gcmV0dXJucyB3aGV0aGVyIEVDQyBjaGVja2luZyBpcw0KPiBlbmFi
bGVkIG9uIHRoZSBjb250cm9sbGVyIG9yIG5vdC4NCj4gDQo+IFlvdXIgcGF0Y2ggaGFzOg0KPiAN
Cj4gKyAqIHN0cnVjdCBzeW5wc19wbGF0Zm9ybV9kYXRhIC0gIHN5bnBzIHBsYXRmb3JtIGRhdGEg
c3RydWN0dXJlLg0KPiArICogQGdldGVycm9yX2luZm86ICAgICBHZXQgZXJyb3IgaW5mby4NCj4g
KyAqIEBnZXRfbXR5cGU6ICAgICAgICAgR2V0IG10eXBlLg0KPiArICogQGdldF9kdHlwZTogICAg
ICAgICBHZXQgZHR5cGUuDQo+ICsgKiBAZ2V0X2VjY3N0YXRlOiAgICAgIEdldCBlY2NzdGF0ZS4N
Cj4gDQo+IFNvIHdoYXQgaXMgImVjY3N0YXRlIj8gSXMgaXQgYSBzdHJ1Y3Qgb3IgYSB2YXJpYWJs
ZSBvciAuLi4/DQo+IA0KPiBEbyB5b3Ugc2VlIG15IHBvaW50Pw0KPiANCj4gSSBrbm93LCBpdCBp
cyBhIHNtYWxsIHRoaW5nIGJ1dCBkb2N1bWVudGluZyBvdXIgY29kZSBwcm9wZXJseSBpcyBzb21l
dGhpbmcNCj4gd2hpY2ggcGVvcGxlIHdvdWxkIGJlIHRoYW5raW5nIHVzIGZvci4gRXZlbiB5b3Ug
d2lsbCBiZSB0aGFua2luZyB5b3Vyc2VsZiB3aGVuDQo+IHlvdSBsb29rIGF0IHRoaXMgbW9udGhz
IGZyb20gbm93IGFmdGVyIGhhdmluZyBmb3Jnb3R0ZW4gaXQgYWxsLg0KPiANCj4gUGxlYXNlIGNo
ZWNrIHRoZSByZXN0IG9mIHlvdXIgYWRkaXRpb25zIGZvciBzaW1pbGFyIGRpc2NyZXBhbmNpZXMu
DQpPa2F5IHN1cmUuIFdpbGwgYmUgcmVjdGlmaWVkIGluIHY4Lg0KDQpUaGFua3MsDQpNYW5pc2gN
Cg0K
