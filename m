Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9996FC4646D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 01:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF4121BC7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 01:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=LenovoBeijing.onmicrosoft.com header.i=@LenovoBeijing.onmicrosoft.com header.b="WypjO6NB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF4121BC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lenovo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbeHID62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 23:58:28 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.4]:30081 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727530AbeHID61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 23:58:27 -0400
Received: from [67.219.250.102] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.us-west-2.aws.symcld.net id 5B/0D-02308-88A9B6B5; Thu, 09 Aug 2018 01:36:08 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLJsWRWlGSWpSXmKPExsWSLvdKT7djVna
  0wbVlvBbTp15gtDhxs5HNYufDt2wWy/f1M1pc3jWHzaJ54m12ixnv2hktzpy+xGox8flvFotb
  E44xOXB57Jx1l91j8Z6XTB6bVnWyecw7GejRPfsfi8eWq+0sHp83yQWwR7Fm5iXlVySwZuz7d
  om94KhExcdH79kbGOdIdDFycQgJPGeUeDtvLhuEc5xRYv2OzWAOi8AKZomnx9ayQmQmMkks+D
  sVyOEEcu4xSuz4qgViswmoStxc/QqsSETgEJPE494LLCAJZoHtjBLd22xAbGGBNIm1y28BxTm
  AitIl3l3QBAmLCBhJtLxoZQaxWQRUJF72HWcDKeEViJFYMCseYlW6xOkJP8FKOAUMJK5N+Ad2
  AqOAmMT3U2uYIDaJS9x6Mh/MlhAQkFiy5zwzhC0q8fIxTH2QxK2fH9gh4vIS/at7WSBsWYlL8
  7sZQc6XEOhllvj9dSVUQlfiw9SpUIN8JboaL0IVAYNo3bGtbBAJLYlb179CFWVLHN6xACpeJf
  H1+lZWCFtOYlXvQxaI5k3MEo/fTGCESMhIPLnVzDKBUX8Wki9mAQOAWUBTYv0uqLCixJTuh+w
  gNq+AoMTJmU9YFjCyrGK0SCrKTM8oyU3MzNE1NDDQNTQ00jU0stA1MjLUS6zSTdQrLdYtTy0u
  0TXSSywv1iuuzE3OSdHLSy3ZxAhMeAxAsIPx24uUQ4ySHExKorz/TLOjhfiS8lMqMxKLM+KLS
  nNSiw8xynBwKEnwTp4JlBMsSk1PrUjLzAGmXpi0BAePkghvMkiat7ggMbc4Mx0idYrRnuNUc8
  8kZo5Fv6YAyT/vpwLJO93TJjELseTl56VKifP2g7QJgLRllObBDYXlikuMslLCvIxAZwrxFKQ
  W5WaWoMq/YhTnYFQS5tUDmcKTmVcCt/sV0FlMQGe90c4EOaskESEl1cBoIrq5L7tkbYxyl7Vm
  kVHuFJ/ydcZmTWXi9+ZY2vrv+2Ob/vM7wx7v82Zr87SX3bvw4tKRHefsOjse34kUSnt5xnFpY
  3du2w535Q9SFhJ6laeUX/4/WWuz/eWJZqtvPLGTDuz+7MMke7kyhn39v+KN4RYigQdNlwru/R
  Kr02v4jH+mFpeTzAwlluKMREMt5qLiRADhGb9WEAQAAA==
X-Env-Sender: hehy1@lenovo.com
X-Msg-Ref: server-28.tower-326.messagelabs.com!1533778559!2076191!1
X-Originating-IP: [103.30.234.46]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21187 invoked from network); 9 Aug 2018 01:36:07 -0000
Received: from unknown (HELO mapsmtp01.lenovo.com) (103.30.234.46)
  by server-28.tower-326.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 9 Aug 2018 01:36:07 -0000
Received: from HKGWPEXCH02.lenovo.com (unknown [10.128.62.31]) by mapsmtp01.lenovo.com with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-SHA)
         id 6dc5_502a_4b7971c5_3498_489b_9aa2_0c4da8b7fd55;
        Thu, 09 Aug 2018 09:35:58 +0800
Received: from JPN01-TY1-obe.outbound.protection.outlook.com (23.103.139.178)
 by HKGWPEXCH02.lenovo.com (10.128.62.31) with Microsoft SMTP Server (TLS) id
 14.3.389.1; Thu, 9 Aug 2018 09:35:53 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector1-lenovo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuqjwpOP+El0tnG6wf/Rr0l9umtggIC0NmunlboKuLk=;
 b=WypjO6NB+TDkc3tZs38H1WNN7odkHMR3JIbxmb3qJe3q0y+9kNJCbiYHn3XioMtjrazNlqpQcVg1PXN4j/erUqui+r5zdINeZIws9ts7v5EhgGOqdPT32LntSbr4YhsVAmSoE9n/i2h0y3O4uzzaEOF1nyEKylRDF6uOhQNz/Ss=
Received: from TYAPR03MB3181.apcprd03.prod.outlook.com (52.133.218.141) by
 TYAPR03MB3245.apcprd03.prod.outlook.com (52.133.188.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.10; Thu, 9 Aug 2018 01:35:52 +0000
Received: from TYAPR03MB3181.apcprd03.prod.outlook.com
 ([fe80::1df6:3391:c505:927f]) by TYAPR03MB3181.apcprd03.prod.outlook.com
 ([fe80::1df6:3391:c505:927f%5]) with mapi id 15.20.1059.010; Thu, 9 Aug 2018
 01:35:54 +0000
From:   Ocean HY1 He <hehy1@lenovo.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
        "oceanhehy@gmail.com" <oceanhehy@gmail.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [External]  Re: [PATCH] ACPI: nfit: check dcr immediately
 following its assignment codes
Thread-Topic: [External]  Re: [PATCH] ACPI: nfit: check dcr immediately
 following its assignment codes
Thread-Index: AQHULz9ej3T6+sjKYkC+yegdKhCh1qS2o2yA
Date:   Thu, 9 Aug 2018 01:35:53 +0000
Message-ID: <TYAPR03MB31812802CA589A9018B58E5789250@TYAPR03MB3181.apcprd03.prod.outlook.com>
References: <1533739821-9864-1-git-send-email-oceanhehy@gmail.com>
 <1533750167.7673.0.camel@intel.com>
In-Reply-To: <1533750167.7673.0.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [57.197.58.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYAPR03MB3245;20:A+O6Dxi4z91I5mSnje+8YiAf1xHMWCD80ULshJUJi3Eez8GqEKmdhxSQVtWQNdt4Ynsb3egHfKGqqHxDUrYZbJOpL6s+pGzE9+xl3Gf/clR9B1V5zah02R/7j9I9L2y1akDXQXP4P/w9kupiotRZQWqomkooIUQjN+IPL4Ff0PIm7WMY/PS17XE1gqg83zqiZIcLgiY/SGeXWM6hVS12X82d7FyIOd77JzJTLZSwu6KkS7ZJxywQvpK8kXplOzy13fMjWpSoncztREe05g7qioofuKqwI3fGBJfCs5GNLFdNrjID0SMwtS8G6BQH7e9ZxtS9hkyOdkjEjCFKQ5ePYA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 43cc34ab-3ab7-49b6-bf1d-08d5fd98728b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:TYAPR03MB3245;
x-ms-traffictypediagnostic: TYAPR03MB3245:
x-microsoft-antispam-prvs: <TYAPR03MB32453CA584F0A32CB020497989250@TYAPR03MB3245.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(3940261145250)(9452136761055)(85827821059158)(162533806227266)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:TYAPR03MB3245;BCL:0;PCL:0;RULEID:;SRVR:TYAPR03MB3245;
x-forefront-prvs: 0759F7A50A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(136003)(396003)(346002)(366004)(13464003)(199004)(189003)(33656002)(2201001)(186003)(86362001)(2900100001)(68736007)(99286004)(6246003)(478600001)(25786009)(14454004)(97736004)(7416002)(39060400002)(6436002)(316002)(7736002)(105586002)(106356001)(54906003)(110136005)(2501003)(229853002)(5250100002)(102836004)(2906002)(4326008)(305945005)(486006)(256004)(5660300001)(53936002)(76176011)(9686003)(7696005)(53546011)(11346002)(6506007)(74316002)(446003)(8936002)(8676002)(81166006)(81156014)(26005)(55016002)(476003)(6116002)(3846002)(66066001)(14773001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR03MB3245;H:TYAPR03MB3181.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (HKGWPEXCH02.lenovo.com: hehy1@lenovo.com does not
 designate permitted sender hosts)
received-spf: None (protection.outlook.com: lenovo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cKmL+eKRoUuxeTcUWoWRc93nPvVgD5Wun8qrA3x7reYvIirEMy9toqyxcm4yX8ca2wktU7hf5F4l5G/bZsbFiW+aCbvd6U6GiLBzM3JMoHrFwaMuAo+FcBTuN2hN7suF2j+mUuPQP/1bQO8heWv3/csZjaNg0EE1Rgu7lOyiN4aIAObARlk24n7HQaa0maQJrK8/7dflpEjSKO4PKvyAFvs8GEC2qx4mb6VqHTbcMohQUNwa6lsTQglnO4HxXA+AabH8CBzmuiRo04Z1HnLiSGb/zOjnOabshDzM0WXvNJWIyYdUxJxeVjxvB4b2Yxv7wbpyEhQuHtATiy9LHpPiGzbKLSiG+fb93+O74Bo3xr8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 43cc34ab-3ab7-49b6-bf1d-08d5fd98728b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2018 01:35:53.8663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR03MB3245
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmVybWEsIFZpc2hhbCBM
IDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMDks
IDIwMTggMTo0MyBBTQ0KPiBUbzogV2lsbGlhbXMsIERhbiBKIDxkYW4uai53aWxsaWFtc0BpbnRl
bC5jb20+OyByb3NzLnp3aXNsZXJAbGludXguaW50ZWwuY29tOw0KPiBvY2VhbmhlaHlAZ21haWwu
Y29tOyBKaWFuZywgRGF2ZSA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+OyBsZW5iQGtlcm5lbC5vcmc7
DQo+IHJqd0Byand5c29ja2kubmV0DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnOyBsaW51eC0NCj4gYWNwaUB2Z2VyLmtlcm5lbC5v
cmc7IE9jZWFuIEhZMSBIZSA8aGVoeTFAbGVub3ZvLmNvbT4NCj4gU3ViamVjdDogW0V4dGVybmFs
XSBSZTogW1BBVENIXSBBQ1BJOiBuZml0OiBjaGVjayBkY3IgaW1tZWRpYXRlbHkgZm9sbG93aW5n
IGl0cw0KPiBhc3NpZ25tZW50IGNvZGVzDQo+IA0KPiANCj4gT24gV2VkLCAyMDE4LTA4LTA4IGF0
IDEwOjUwIC0wNDAwLCBPY2VhbiBIZSB3cm90ZToNCj4gPiBGcm9tOiBPY2VhbiBIZSA8aGVoeTFA
bGVub3ZvLmNvbT4NCj4gPg0KPiA+IEluIGNvbW1pdCA2Njk3YjJjZjY5ZDQzNjMyICgibmZpdDog
Zml4IG11bHRpLWludGVyZmFjZSBkaW1tIGhhbmRsaW5nLA0KPiA+IGFjcGk2LjEgY29tcGF0aWJp
bGl0eSIpLCB0aGUgY2hlY2sgY29kZXMgb2YgZGNyIHdlcmUganVzdCBmb2xsb3dpbmcgaXRzDQo+
ID4gYXNzaWdubWVudCBjb2Rlcy4gQnV0IHRoZXkgd2VyZSBzZXBhcmF0ZWQgYnkgY29tbWl0IGFk
OWFjNWUxOTU3NTMxYTgNCj4gPiAoIm5maXQ6IGFsd2F5cyBhc3NvY2lhdGUgZmx1c2ggaGludHMi
KS4NCj4gPg0KPiA+IEp1c3QgY2hhbmdlIHRoZSBjaGVjayBjb2RlcyBiYWNrIHRvIG9yaWdpbmFs
IHBvc2l0aW9uLCB3aXRob3V0IGZ1bmN0aW9uDQo+ID4gY2hhbmdlLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogT2NlYW4gSGUgPGhlaHkxQGxlbm92by5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvYWNwaS9uZml0L2NvcmUuYyB8IDEyICsrKysrKy0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gVGhpcyBzZWVtcyBsaWtl
IHVubmVjZXNzYXJ5IGNodXJuLiBEb2VzIGl0IGNhdXNlIGFueSBwcm9ibGVtcyBpbg0KPiBwcmFj
dGljZT8NCj4gDQpUaGUgb3JpZ2luYWwgY29kZXMgZG8gbm90IGNhdXNlIGFueSBwcm9ibGVtcy4N
Ck9jZWFuLg0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9uZml0L2NvcmUuYyBi
L2RyaXZlcnMvYWNwaS9uZml0L2NvcmUuYw0KPiA+IGluZGV4IDdjNDc5MDAuLmM5ZTRjOWEgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9hY3BpL25maXQvY29yZS5jDQo+ID4gKysrIGIvZHJpdmVy
cy9hY3BpL25maXQvY29yZS5jDQo+ID4gQEAgLTEwNzgsNiArMTA3OCwxMiBAQCBzdGF0aWMgaW50
IF9fbmZpdF9tZW1faW5pdChzdHJ1Y3QgYWNwaV9uZml0X2Rlc2MNCj4gKmFjcGlfZGVzYywNCj4g
PiAgCQkJYnJlYWs7DQo+ID4gIAkJfQ0KPiA+DQo+ID4gKwkJaWYgKGRjciAmJiAhbmZpdF9tZW0t
PmRjcikgew0KPiA+ICsJCQlkZXZfZXJyKGFjcGlfZGVzYy0+ZGV2LCAiU1BBICVkIG1pc3Npbmcg
RENSICVkXG4iLA0KPiA+ICsJCQkJCXNwYS0+cmFuZ2VfaW5kZXgsIGRjcik7DQo+ID4gKwkJCXJl
dHVybiAtRU5PREVWOw0KPiA+ICsJCX0NCj4gPiArDQo+ID4gIAkJbGlzdF9mb3JfZWFjaF9lbnRy
eShuZml0X2ZsdXNoLCAmYWNwaV9kZXNjLT5mbHVzaGVzLCBsaXN0KSB7DQo+ID4gIAkJCXN0cnVj
dCBhY3BpX25maXRfZmx1c2hfYWRkcmVzcyAqZmx1c2g7DQo+ID4gIAkJCXUxNiBpOw0KPiA+IEBA
IC0xMTAxLDEyICsxMTA3LDYgQEAgc3RhdGljIGludCBfX25maXRfbWVtX2luaXQoc3RydWN0IGFj
cGlfbmZpdF9kZXNjDQo+ICphY3BpX2Rlc2MsDQo+ID4gIAkJCWJyZWFrOw0KPiA+ICAJCX0NCj4g
Pg0KPiA+IC0JCWlmIChkY3IgJiYgIW5maXRfbWVtLT5kY3IpIHsNCj4gPiAtCQkJZGV2X2Vycihh
Y3BpX2Rlc2MtPmRldiwgIlNQQSAlZCBtaXNzaW5nIERDUiAlZFxuIiwNCj4gPiAtCQkJCQlzcGEt
PnJhbmdlX2luZGV4LCBkY3IpOw0KPiA+IC0JCQlyZXR1cm4gLUVOT0RFVjsNCj4gPiAtCQl9DQo+
ID4gLQ0KPiA+ICAJCWlmICh0eXBlID09IE5GSVRfU1BBX0RDUikgew0KPiA+ICAJCQlzdHJ1Y3Qg
bmZpdF9pZHQgKm5maXRfaWR0Ow0KPiA+ICAJCQl1MTYgaWR0X2lkeDsNCg==
