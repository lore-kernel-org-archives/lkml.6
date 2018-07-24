Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D06DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B4220874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=LenovoBeijing.onmicrosoft.com header.i=@LenovoBeijing.onmicrosoft.com header.b="qu4jnzAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B4220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lenovo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388391AbeGXKwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:52:44 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.211]:51001 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726209AbeGXKwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:52:44 -0400
Received: from [67.219.247.54] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-d.us-east-1.aws.symcld.net id CD/9C-01620-895F65B5; Tue, 24 Jul 2018 09:47:04 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTf0wTZxj2u7teT8fhUSC864RsTTSjWztqpjl
  nwn78sVyysOxH1GVsyiG17SiF9NqJW5bhSNxGZUAHVECYYqe0SNBqBpoybTOpNSoIhAwnOBlC
  ALdh8AdRgd310G33x3fP+z3P873v9+Z7KVzVrVRTxmKH0W7jrRpyBWFKm9LrPHc3Z2eMD2xgW
  4crSLbv0R3Eelo6CNZT04vY80O7Sbb0UDvJdvdOEmyDpxRjg11Rgu0/vV8kqn5TspUHS3H2SG
  QBY6smHhLs7OU9SrZnPqJgr1Z2Y+zDOVEXPPcN/loiFxoNk9yJFi13KDiJcf2XnFxT9F3uTON
  RJedqWCC42zevEtzFA78oudlAGvf1WRfGBcb+xLie6wvKd+gPFRZbbmFxjsJ8vGc3KnKvLO4c
  TS1Bc/FlaAWlYiYQ9IaakRx0Ixjud5NSQDAtONTNNOMy8x0G97+qw+RgGMG+5hJFGVpOkUw6R
  G8NxlRJjBfB4EwoFuDMbRL8B+/FVIlMDoR/jpASTmJ4iHovETJeC6HxRUzCBLMaJkauxTDNfA
  TjVV6FnO57BN72atFAUcuZTBgJmSUNYlKhdvR6TI8zKdBYWx/LBQwD3mAPLuNkmPxjQSFZEfM
  e/HVyq7ytgYYHY0uSVOj7wRVrADDlOJQPtC4RBoj4zizhBwpou/K6jLNgvG1RKRsiCO63dhEy
  oYWf2suRjPPh6MAiKeNsiJ4bxGScBv7yG4RsDuCw6LmCV6KX6v9ziXqxWFxsa/vppe3noNp1Q
  1kf60sCROvGiAOI8KP1uXaLyewo4C1WnSEjQ2cwrBX/upfX6fnPdHl6p6Az8oJDZ9DzOwW9sK
  tguzVPbzM6Akh8wcvErxO1zeWF0dMUpkmmhV83Z6vicwvzdpl5wbzN7rQahTBaRVEaoIN3RC7
  BbjQZi3dYrOIYPKaBitMk0V9INC0U8QWCxSRTF9CrVJPP7capvSPV4vro7xpxveaqdeMqwlZo
  M6pT6GRxflSMZDM7bU8OfTxefShVnUgjsUxVXJHRXmBx/J+fQikU0iTSESl5nMXmeJJ7SiwLE
  8tK3r5JKsvB/0upS9DhzJ3bjnnSfyydDg99qjo8dXH/hhn1x1lZnevVtYGZ+Lc+r4jX+nx+7v
  k3pxPCe9W/+9d0pH/gfn/o28wXVnadmt/YUYb0995OefaTphOjQv4t7U2TkLPmS20037ls9d3
  pnPmSuC1jz7x4OaFiz45VHqHmyBuNT533vTK/8eypC7NQ51inIQQzb9DidoH/B7/VQxRZBAAA
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-6.tower-426.messagelabs.com!1532425610!1292986!1
X-Originating-IP: [103.30.234.46]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15649 invoked from network); 24 Jul 2018 09:47:03 -0000
Received: from unknown (HELO mapsmtp01.lenovo.com) (103.30.234.46)
  by server-6.tower-426.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 24 Jul 2018 09:47:03 -0000
Received: from HKGWPEXCH02.lenovo.com (unknown [10.128.62.31]) by mapsmtp01.lenovo.com with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-SHA)
         id 2ff8_96e7_a88c9967_3e27_40af_92eb_6adabde1602b;
        Tue, 24 Jul 2018 17:46:48 +0800
Received: from APC01-HK2-obe.outbound.protection.outlook.com (65.55.88.207) by
 HKGWPEXCH02.lenovo.com (10.128.62.31) with Microsoft SMTP Server (TLS) id
 14.3.389.1; Tue, 24 Jul 2018 17:46:48 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector1-lenovo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWiifrRDQzElJQi5K+4UImBZQC3ljIb5mKAUzpsXf1k=;
 b=qu4jnzAnpwgs/cOhAx8ISnLt+AcZ7yhz1k9pFdoehxp7MQZRzfSvzmqJyDEdzuKNsK/jGBMUH/bAJM01eJQBcZwQ6bGG55iEANDOcnDBm1xoaUZYHSNjM29FUy46PbF+Q3kajPiQNkaI7RPzowsxSv5H7Hlsecg7LflCn5WexVM=
Received: from TY2PR03MB3343.apcprd03.prod.outlook.com (20.177.20.145) by
 TY2PR03MB3808.apcprd03.prod.outlook.com (20.177.79.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.13; Tue, 24 Jul 2018 09:46:44 +0000
Received: from TY2PR03MB3343.apcprd03.prod.outlook.com
 ([fe80::ac73:48dc:59b:aa89]) by TY2PR03MB3343.apcprd03.prod.outlook.com
 ([fe80::ac73:48dc:59b:aa89%3]) with mapi id 15.20.0995.014; Tue, 24 Jul 2018
 09:46:43 +0000
From:   Huaisheng HS1 Ye <yehs1@lenovo.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC:     "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>,
        "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bart.vanassche@wdc.com" <bart.vanassche@wdc.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        NingTing Cheng <chengnt@lenovo.com>,
        Huaisheng Ye <yehs2007@zoho.com>
Subject: RE: [External]  Re: [PATCH 3/5] s390, dcssblk: Allow a NULL-kaddr to
 ->direct_access()
Thread-Topic: [External]  Re: [PATCH 3/5] s390, dcssblk: Allow a NULL-kaddr to
 ->direct_access()
Thread-Index: AQHUIyv5eXsxwu+AR02Z8DnUz36qrKSeHQnw
Date:   Tue, 24 Jul 2018 09:46:43 +0000
Message-ID: <TY2PR03MB3343901A038D3E3D836C438992550@TY2PR03MB3343.apcprd03.prod.outlook.com>
References: <20180724084510.6104-1-yehs2007@zoho.com>
 <20180724084510.6104-4-yehs2007@zoho.com>
 <192a9dac-921f-e222-3a7d-32d43679cd12@de.ibm.com>
In-Reply-To: <192a9dac-921f-e222-3a7d-32d43679cd12@de.ibm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.120.61.139]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY2PR03MB3808;20:dwVxVSVTQEA9Ok3bExU1ZjmXLgEKt2XNeYDxaG3M+wARx/KeLoq6GN+kCun6sMfvQD9oed7m+Zdi+TuPAPypI2+Bhoj5jcuh0LGMM2SmcYLqN7nsC9vohY+UNMH+n0sJsgOicC0vxksMSvTdStIA/BU77mffZjfxPpp3uYvqPL6WJbdA5pztTGqW0juQwyQq1ON9RTDzTRYMscfhB0RvRY8hJQOu2jutKDQiB2CtAg27gPxsnlGEAHWSVuJFFMKBGNXlPSJQzdntUOMe8GlMzBLX9Ln1IWJXwjPfUdkeUxUK7scMgO1010/vg2OvrEy78uQjLCPsDC6ZqdoMuGZRVg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(366004)(39850400004)(396003)(189003)(199004)(97736004)(106356001)(6436002)(105586002)(25786009)(99286004)(229853002)(54906003)(305945005)(8936002)(81156014)(8676002)(81166006)(7736002)(55016002)(33656002)(316002)(66066001)(74316002)(9686003)(2900100001)(110136005)(6246003)(6116002)(68736007)(186003)(5250100002)(5660300001)(3846002)(2501003)(102836004)(53546011)(6506007)(26005)(7416002)(2906002)(476003)(486006)(256004)(11346002)(446003)(76176011)(7696005)(14444005)(2201001)(4326008)(86362001)(14454004)(53936002)(478600001)(9126004);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR03MB3808;H:TY2PR03MB3343.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: ec591bac-6e7b-4df6-fb3c-08d5f14a5d2b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:TY2PR03MB3808;
x-ms-traffictypediagnostic: TY2PR03MB3808:
x-microsoft-antispam-prvs: <TY2PR03MB3808A27D818ADFC8E1A2EF2492550@TY2PR03MB3808.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(3940261145250)(190383065149520)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:TY2PR03MB3808;BCL:0;PCL:0;RULEID:;SRVR:TY2PR03MB3808;
x-forefront-prvs: 0743E8D0A6
Received-SPF: None (HKGWPEXCH02.lenovo.com: yehs1@lenovo.com does not
 designate permitted sender hosts)
received-spf: None (protection.outlook.com: lenovo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: S2BbZnUHCevWz7gqXoGbrdR4oAVyhJlgowWTYMeBu2792z3tNZV18a1eUArydGp9HSJFbfmT/sex8LwyvwdfceTUZK+a37C4fSClzoQ0bElt1Lnhnhx3FJF35VXHa3WqiNUbx5i0lsvOnvjM32zXoX04Y34HYAgL/EDGwkixzIxKv+zbd3RYb/HhZ0VkzPQ1n+splx5uPtDWgjsjCA3JCVnh/jqr6aNI7/kfeF7iKqaITqExUErwvwKOrBKolcdeMmhT/Vgo1LvoqoagcWci/YAlEotJlrviRL6E4ycJPriw2lqoF07cjiiInXtUtYj3kQoC6PTfmMggxIlEwZ5bQD/Y8Jz4xla8gUGo1FHUI/I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ec591bac-6e7b-4df6-fb3c-08d5f14a5d2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2018 09:46:43.3288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR03MB3808
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2hyaXN0aWFuIEJvcm50cmFlZ2VyIDxib3JudHJhZWdlckBkZS5pYm0uY29tPg0KU2Vu
dDogVHVlc2RheSwgSnVseSAyNCwgMjAxOCA0OjU0IFBNDQo+IE9uIDA3LzI0LzIwMTggMTA6NDUg
QU0sIEh1YWlzaGVuZyBZZSB3cm90ZToNCj4gPiBGcm9tOiBIdWFpc2hlbmcgWWUgPHllaHMxQGxl
bm92by5jb20+DQo+ID4NCj4gPiBkY3NzYmxrX2RpcmVjdF9hY2Nlc3MoKSBuZWVkcyB0byBjaGVj
ayB0aGUgdmFsaWRpdHkgb2Ygc2Vjb25kIHJhbmsNCj4gPiBwb2ludGVyIGthZGRyIGZvciBOVUxM
IGFzc2lnbm1lbnQuIElmIGthZGRyIGVxdWFscyB0byBOVUxMLCBpdA0KPiA+IGRvZXNuJ3QgbmVl
ZCB0byBjYWxjdWxhdGUgdGhlIHZhbHVlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSHVhaXNo
ZW5nIFllIDx5ZWhzMUBsZW5vdm8uY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3MzOTAvYmxv
Y2svZGNzc2Jsay5jIHwgMyArKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvczM5MC9ibG9j
ay9kY3NzYmxrLmMgYi9kcml2ZXJzL3MzOTAvYmxvY2svZGNzc2Jsay5jDQo+ID4gaW5kZXggMGEz
MTJlNC4uOWMxM2RjNSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3MzOTAvYmxvY2svZGNzc2Js
ay5jDQo+ID4gKysrIGIvZHJpdmVycy9zMzkwL2Jsb2NrL2Rjc3NibGsuYw0KPiA+IEBAIC05MTUs
NyArOTE1LDggQEAgc3RhdGljIERFVklDRV9BVFRSKHNhdmUsIFNfSVdVU1IgfCBTX0lSVVNSLCBk
Y3NzYmxrX3NhdmVfc2hvdywNCj4gPiAgCXVuc2lnbmVkIGxvbmcgZGV2X3N6Ow0KPiA+DQo+ID4g
IAlkZXZfc3ogPSBkZXZfaW5mby0+ZW5kIC0gZGV2X2luZm8tPnN0YXJ0ICsgMTsNCj4gPiAtCSpr
YWRkciA9ICh2b2lkICopIGRldl9pbmZvLT5zdGFydCArIG9mZnNldDsNCj4gPiArCWlmIChrYWRk
cikNCj4gPiArCQkqa2FkZHIgPSAodm9pZCAqKSBkZXZfaW5mby0+c3RhcnQgKyBvZmZzZXQ7DQo+
IA0KPiBTbyB5b3UgYXJlIHRyYWRpbmcgb2YgYSBsb2FkICsgYWRkIChkZXZfaW5mby0+c3RhcnQg
c2hvdWxkIGJlIGNhY2hlIGhvdCkgYWdhaW5zdCBhDQo+IGNvbXBhcmUrYnJhbmNoIC4gTm90IHN1
cmUgdGhhdCB0aGlzIGlzIGFsd2F5cyBhIHdpbi4NCg0KSG1tLi4udGhlIGNhbGN1bGF0aW9uIHBy
b2Nlc3Mgb2YgcGZuIGlzIG1vcmUgY29tcGxpY2F0ZWQgdGhhbiBrYWRkci4gSSB0aGluayB5b3Ug
YWdyZWUgdG8gY2hlY2sgcGZuIGJ1dCBub3Qgc3VyZSBrYWRkciwgcmlnaHQ/DQpGcm9tIHRoZSBs
b2dpY2FsIGNvbnNpc3RlbmN5IG9mIGNvZGUsIEkgdGhpbmsgaXQgc2hhbGwgYmUgYmV0dGVyIHRv
IGdpdmUgcGZuIGFuZCBrYWRkciBzaW1pbGFyIHRyZWF0bWVudC4NCg0KQ2hlZXJzLA0KSHVhaXNo
ZW5nIFllDQo=
