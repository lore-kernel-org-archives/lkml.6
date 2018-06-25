Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AE6C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364A5251B4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="T75nQrwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364A5251B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932653AbeFYLZU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 07:25:20 -0400
Received: from mail-he1eur01on0098.outbound.protection.outlook.com ([104.47.0.98]:7806
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753277AbeFYLZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 07:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HchY8GQaW7PLwMI6l6htxFf1XMMi/wG4DuGYptb4h/k=;
 b=T75nQrwavN3x1dtCx9BvoFO1zES7KD65usJW/XQIKn+Aybtmn61sDINmlCwltE/hJc5IyvEg1hdb3fpAeU5qJou7t65kOER2+kZVtqCqOYfsRCbMFCH6InwYvCZaKgHJwqDFYgC7jyVLzf2AiVCXOaw98hn9MaYPPB5yuFRAtWw=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB1982.eurprd05.prod.outlook.com (10.166.45.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Mon, 25 Jun 2018 11:25:13 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::5570:f225:bd5b:1aa3]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::5570:f225:bd5b:1aa3%9]) with mapi id 15.20.0884.023; Mon, 25 Jun 2018
 11:25:13 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "davem@davemloft.net" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] igb: allow optionally getting mac address from device
 tree
Thread-Topic: [PATCH] igb: allow optionally getting mac address from device
 tree
Thread-Index: AQHUDFqtNe5LEInLtEypBdCLEe5kFKRwnfCAgAA3toA=
Date:   Mon, 25 Jun 2018 11:25:13 +0000
Message-ID: <1529925911.12558.12.camel@toradex.com>
References: <20180625080042.32286-1-marcel@ziswiler.com>
         <20180625.170547.658198698048994134.davem@davemloft.net>
In-Reply-To: <20180625.170547.658198698048994134.davem@davemloft.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB1982;7:5i7JkxI2Wrz936bvRx5s6EiKLOIWJ0+w4ALRoI11BuvfSybuuVIfuMHcTEQYJa6wwpOBUhgaH/IiT6hzWmO724O+7SvIM0MI/JhM1TQHHGxtr9aWfx2jVrtsRhSfI6InVfsT5vPsCDd9PbmIjbdJEVG1zCqBsi1wyQgy6xsfXWh8hK94Wluif3us62BF3sRcIBdtLXegeKkW5sderTZxJ8AeNmEdal4yA7uCajATyVEkw7xKsHS68rMynDGtGr/s
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4128785a-9a48-440d-fa48-08d5da8e51fd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB1982;
x-ms-traffictypediagnostic: VI1PR0501MB1982:
x-microsoft-antispam-prvs: <VI1PR0501MB198211D89BA4295D433E12E5FB4A0@VI1PR0501MB1982.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR0501MB1982;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB1982;
x-forefront-prvs: 0714841678
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(39840400004)(346002)(376002)(51914003)(189003)(199004)(6116002)(3846002)(305945005)(486006)(478600001)(68736007)(44832011)(14454004)(2616005)(8936002)(8676002)(476003)(6436002)(2906002)(4326008)(99286004)(106356001)(105586002)(7736002)(2501003)(5250100002)(11346002)(446003)(5660300001)(86362001)(97736004)(2351001)(2900100001)(26005)(186003)(25786009)(36756003)(3660700001)(102836004)(316002)(54906003)(103116003)(6486002)(66066001)(81166006)(6512007)(81156014)(6246003)(1730700003)(76176011)(3280700002)(53936002)(6916009)(229853002)(5640700003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB1982;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QXc1uhjqgeDTfwevjeywDAp5tDS8P9P8sByaQcc4xtxCqcvAcRHNnyJ+y4CD+qRitBziKrcvVC8TjYJDUWR0LBk7bx3jlkyC1avwWXnSwM+n8t2K22swgDyIFDGjAP0Ah/CID7u+mFHVEZXeKw70Ag9LwBN8/4G7NHGT0hLmRER8ds6Vuk0wX+fuj5Adj3dELgNTanzxbmjEkskHbv6vfE9FzO9U1hiCRVnr24lrjZ7lbrXFv/NL46WkEy4m1FkTqWlq66HKvKpWrQIFuzCRAqmyJTPHIAaL2Mqo+XSY3rMz20C8eSpFYkfYdSSUtrpm4vTMSew4pImppzHJdggRBztMY2GOziwuwzETP+o/oY4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4D9CDAF00431740A555AC30CEB7D0DC@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4128785a-9a48-440d-fa48-08d5da8e51fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2018 11:25:13.7197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB1982
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGF2aWQNCg0KT24gTW9uLCAyMDE4LTA2LTI1IGF0IDE3OjA1ICswOTAwLCBEYXZpZCBNaWxs
ZXIgd3JvdGU6DQo+IEZyb206IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsQHppc3dpbGVyLmNvbT4N
Cj4gRGF0ZTogTW9uLCAyNSBKdW4gMjAxOCAxMDowMDo0MiArMDIwMA0KPiANCj4gPiBAQCAtMzEy
Miw3ICszMTI0LDExIEBAIHN0YXRpYyBpbnQgaWdiX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2
LA0KPiA+IGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkICplbnQpDQo+ID4gIAkJYnJlYWs7DQo+
ID4gIAl9DQo+ID4gIA0KPiA+IC0JaWYgKGV0aF9wbGF0Zm9ybV9nZXRfbWFjX2FkZHJlc3MoJnBk
ZXYtPmRldiwgaHctDQo+ID4gPm1hYy5hZGRyKSkgew0KPiA+ICsJLyogdHJ5IHRvIGdldCB0aGUg
TUFDIGFkZHJlc3MgZnJvbSBkZXZpY2UgdHJlZSBkYXRhICovDQo+ID4gKwlpYXAgPSBvZl9nZXRf
bWFjX2FkZHJlc3MocGRldi0+ZGV2Lm9mX25vZGUpOw0KPiA+ICsJaWYgKGlhcCkNCj4gPiArCQlt
ZW1jcHkoaHctPm1hYy5hZGRyLCBpYXAsIEVUSF9BTEVOKTsNCj4gDQo+IFRoaXMgaXMgZXhhY3Rs
eSB3aGF0IGV0aF9wbGF0Zm9ybV9nZXRfbWFjX2FkZHJlc3MoKSBzaG91bGUgYmUgZG9pbmcuDQoN
ClllcywgeW91IGFyZSBhYnNvbHV0ZWx5IHJpZ2h0LiBUaGF0IGluZGVlZCBhbHJlYWR5IHdvcmtz
IGp1c3QgZmluZSBnaXZlbiBhDQpwcm9wZXIgZGV2aWNlIHRyZWUuIFN0cnVnZ2xpbmcgd2l0aCB0
aGUgZGV2aWNlIHRyZWUgcGFydCBJIHByb2JhYmx5IG1pc3NlZA0Kbm90aWNpbmcgdGhpcy4NCg0K
U29ycnkgZm9yIHRoZSBub2lzZSBhbmQgdGhhbmtzIGZvciB0aGUgdGlwIQ0KDQpDaGVlcnMNCg0K
TWFyY2Vs
