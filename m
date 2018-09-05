Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704DFC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 03:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34B420857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 03:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=LenovoBeijing.onmicrosoft.com header.i=@LenovoBeijing.onmicrosoft.com header.b="NEyZaFm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34B420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lenovo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbeIEHyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 03:54:45 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.113]:12019 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727305AbeIEHyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 03:54:45 -0400
Received: from [67.219.250.198] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.us-west-2.aws.symcld.net id 33/AF-04940-FEC4F8B5; Wed, 05 Sep 2018 03:26:39 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTbWxLURje6b1t79iVox17NUwUCYvWOiLdL/O
  RaLDEkEiMcWdXW9pueu/o5gezIes0tVEfm2xlE8znCJlljGVs3ciGCZsZjfnYxOYzImb09tbX
  j3PyvO/zvM/7npNzKELxVqaiWAfP2m2MRS0bRhqj+7SagcXu5Ngdvqn6g542pG/qyJHpH9Qck
  elzC5/I9Yf6dyN94evvpL5z721Jgtxwtfip3FBe2ysxlPqSDAUlQ6Th08XoJdKVUrMtNd2xVm
  qq8uXJMzqUjrrn3HZUrXSiYZQCv0bw1NslE4NbCBqPeaVCQOKTBLzL/0yIjFsCrs6GUNCNwHl
  tD3KicEqGJ0PH6T6pgCPxIug5mB/0InAPgvK6riChxBaoqb1KiCIrtBR75CKOg1feVomASTwJ
  2iv7SSeiKBqvgsEhldgsH4GvzUcKmnCcBD73pWAtwqPha/OZYC2Bo6CzpyyIAWOoqG0lRDwKe
  l8MSUX9Uuj89l4u5seD+7SLFPE4uF9WgIRmgF0EVB31hAgNvPd4QkaJ0PylPZRvRHCzF4k4Bp
  7k5oQ0G+HsuZ2hfDZ8eXRZKuJoqHT5SbHBKQIOFT4MGY2Fj1eG0F40vfifQxQHLoDAU+F8TSg
  9AfYX+OUCpvFI8B3uIb2IrET6VLvZaOKtjNmi0cXGanS6OI1uRmDFztIy2ZpUbSan2cJyvCZO
  y2zhtFyWdZ0lTWtj+Yso8MDSMvI2VKOmk8Z6NIaSqEfRYw3uZMWI1PS0LBPDmdbYMy0sV4+mU
  BRuv9lQglSkLd3GqoG+tiigG2lnjaxjvdkSeLG/pUBFqCPpLIGmuQzGypmNItWM4qnSU0VFBD
  U44AnsXQUHighF0E8VRfuEAiwUmDJtf+x+/4H7aJxKSaOwsDBFRAZrt5r5//k+FEUhtZJ2CS4
  RZhv/p2tfYCBJYKCKG3uEgXjmL6Xajs4nnmXvWe+8vJKgHiy/UyGbp61eMnfzz/JtiSlocvbL
  oyktTVsffqU2J7dU+fm8C2XweFrjvrV1y975529KubT8wewfHbPnLGh2b1yxetau+Po3RRNPK
  NctzMsdCJ/yYcGLtu4Jftlxf+/w7pnHY55lOvkj3tL5Oa3Xxx+uXJ6Q5Ihj76pJzsToYgg7x/
  wC2S1hUv4DAAA=
X-Env-Sender: hehy1@lenovo.com
X-Msg-Ref: server-35.tower-346.messagelabs.com!1536117992!2949065!1
X-Originating-IP: [103.30.234.46]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 29164 invoked from network); 5 Sep 2018 03:26:39 -0000
Received: from unknown (HELO mapsmtp01.lenovo.com) (103.30.234.46)
  by server-35.tower-346.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 5 Sep 2018 03:26:39 -0000
Received: from HKGWPEXCH02.lenovo.com (unknown [10.128.62.31]) by mapsmtp01.lenovo.com with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-SHA)
         id 1179_357f_4c2276a2_1385_442d_823d_98e8753dea18;
        Wed, 05 Sep 2018 11:26:31 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (65.55.88.245) by
 HKGWPEXCH02.lenovo.com (10.128.62.31) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 5 Sep 2018 11:26:31 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector1-lenovo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6/IslNjdn22fR63Y2uDE2kp4w7PJhHH5UI3xVcjrgo=;
 b=NEyZaFm7Nw9Arro/IESPBXqiQjDJg6SlS7LPCPowRxBULb7vdRvjvv3d11TyhAj8U0whna2xeC1lJ1ZNyiaoBW1BUId1JDxVQQQW5SS8a2irkSbIkGWST9pEhqLqwJ/3XH457q3QqKu6pUL8wd2IqIm9RhiAnlnuLld6uqfBIZw=
Received: from HK0PR03MB3170.apcprd03.prod.outlook.com (52.133.151.140) by
 HK0PR03MB2964.apcprd03.prod.outlook.com (52.133.212.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Wed, 5 Sep 2018 03:26:29 +0000
Received: from HK0PR03MB3170.apcprd03.prod.outlook.com
 ([fe80::102a:649e:6d08:6fbc]) by HK0PR03MB3170.apcprd03.prod.outlook.com
 ([fe80::102a:649e:6d08:6fbc%2]) with mapi id 15.20.1122.009; Wed, 5 Sep 2018
 03:26:29 +0000
From:   Ocean HY1 He <hehy1@lenovo.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Ocean He <oceanhehy@gmail.com>
CC:     Ross Zwisler <ross.zwisler@linux.intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [External]  Re: [PATCH v2] libnvdimm, region_devs: stop
 NDD_ALIASING bit test if one test pass
Thread-Topic: [External]  Re: [PATCH v2] libnvdimm, region_devs: stop
 NDD_ALIASING bit test if one test pass
Thread-Index: AQHURGgUNqUDopRFREWpgmzMUi8l4qTg/KHA
Date:   Wed, 5 Sep 2018 03:26:29 +0000
Message-ID: <HK0PR03MB317036BE69B40E73896A044189020@HK0PR03MB3170.apcprd03.prod.outlook.com>
References: <1536058062-18894-1-git-send-email-oceanhehy@gmail.com>
 <CAPcyv4iVYjbs_ds9tL4rceH5cSck=D-AkkejFh+rHXdY25nGfw@mail.gmail.com>
In-Reply-To: <CAPcyv4iVYjbs_ds9tL4rceH5cSck=D-AkkejFh+rHXdY25nGfw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [57.197.58.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK0PR03MB2964;20:WywWaF+7EwwP1EGedWQKX+CPNAK2wOXgmZUE1ApHdM7S7t3qUfQTifNetcM/zcH9znPK88yy05sh5ItkfClvHdeIfyYWp+AIfAqH8r62nDhFhT5HhYLZ4V3AonJuABnG9DEU6jCyG7ZlyjUy/K8jvU1ZojuK1mDb0TroKeHjbp/OSZY0ED1WYJzzUkW1MSxHhVgAuktW7KXrt/NwlfFkElBBDNIruAkVlE1LiRuZrXsr1UErAcsUxpEKquV3dtQ4qAse2rK2qhA4HsrPJmAbIoVFElZgAnTK4/+uKAulAuPL724Y8Sw3A2ZVRwN4j7YtkP+xOPlHaNuK40AC8x/gqA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c3b4b7bd-300d-4328-9fb6-08d612df5ef0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HK0PR03MB2964;
x-ms-traffictypediagnostic: HK0PR03MB2964:
x-microsoft-antispam-prvs: <HK0PR03MB296468A86E50DEF32C3A8CF889020@HK0PR03MB2964.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(3940261145250)(9452136761055)(85827821059158)(162533806227266)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:HK0PR03MB2964;BCL:0;PCL:0;RULEID:;SRVR:HK0PR03MB2964;
x-forefront-prvs: 078693968A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39850400004)(396003)(376002)(346002)(189003)(199004)(13464003)(53936002)(5660300001)(55016002)(5250100002)(6436002)(9686003)(4326008)(486006)(25786009)(229853002)(256004)(2900100001)(74316002)(26005)(476003)(11346002)(446003)(6246003)(186003)(39060400002)(81156014)(105586002)(8676002)(106356001)(33656002)(86362001)(305945005)(2906002)(81166006)(54906003)(97736004)(110136005)(14454004)(6116002)(478600001)(68736007)(7696005)(7736002)(102836004)(316002)(76176011)(66066001)(99286004)(8936002)(53546011)(3846002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0PR03MB2964;H:HK0PR03MB3170.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (HKGWPEXCH02.lenovo.com: hehy1@lenovo.com does not
 designate permitted sender hosts)
received-spf: None (protection.outlook.com: lenovo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: w/w1RSfPK732Fc6N3KGJSbDsHROFUqZFMo0u9hPFH03eCBYvjt7+eW2NHEAs9nWxY2z0bt1xgKjtT53qanDxoDPNSje6PKjzqXDOVIvc5VkaAYinLcGZDE4GMgeYKZLqEdhxXltAC0IeXMVsLHmRKmt+yHkAZOmrAPgzW5AKaUgy5foh1kVQI0LluTaBwKRQPTNuF5Z7joOCNGZzlkmfrm+kvLSOkqjV1CEdTpGDs/XuB3YUURxlOcxezyetRQQ9eLLsjy89gZvcQav/32SQwvtsHFN7uJq5ce5XqZbw1eocwMhTc4swvOC+9DpPHlWe1lzqsKbFU8xhtFNqmeDYMRFxwTbD2gxoTLEETwLfhkU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b4b7bd-300d-4328-9fb6-08d612df5ef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2018 03:26:29.7867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB2964
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuIFdpbGxpYW1zIDxk
YW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAwNCwg
MjAxOCAxMTo1OCBQTQ0KPiBUbzogT2NlYW4gSGUgPG9jZWFuaGVoeUBnbWFpbC5jb20+DQo+IENj
OiBSb3NzIFp3aXNsZXIgPHJvc3Muendpc2xlckBsaW51eC5pbnRlbC5jb20+OyBWaXNoYWwgTCBW
ZXJtYQ0KPiA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPjsgRGF2ZSBKaWFuZyA8ZGF2ZS5qaWFu
Z0BpbnRlbC5jb20+OyBsaW51eC0NCj4gbnZkaW1tIDxsaW51eC1udmRpbW1AbGlzdHMuMDEub3Jn
PjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc+OyBPY2VhbiBIWTEgSGUgPGhlaHkxQGxlbm92by5jb20+DQo+IFN1YmplY3Q6IFtFeHRl
cm5hbF0gUmU6IFtQQVRDSCB2Ml0gbGlibnZkaW1tLCByZWdpb25fZGV2czogc3RvcA0KPiBORERf
QUxJQVNJTkcgYml0IHRlc3QgaWYgb25lIHRlc3QgcGFzcw0KPiANCj4gT24gVHVlLCBTZXAgNCwg
MjAxOCBhdCAzOjQ3IEFNLCBPY2VhbiBIZSA8b2NlYW5oZWh5QGdtYWlsLmNvbT4gd3JvdGU6DQo+
ID4gRnJvbTogT2NlYW4gSGUgPGhlaHkxQGxlbm92by5jb20+DQo+ID4NCj4gPiBUaGVyZSBpcyBu
byBuZWVkIHRvIGZpbmlzaCBlbnRpcmUgbG9vcCB0byBleGVjdXRlIE5ERF9BTElBU0lORyBiaXQg
dGVzdA0KPiA+IGFnYWluc3QgZXZlcnkgbnZkaW1tLT5mbGFncy4NCj4gDQo+IE9mIGNvdXJzZSB0
aGVyZSBpcy4gSSBzZWUgbm90aGluZyBzdG9wcGluZyBzb21lb25lIG1peGluZyBhbiBOVkRJTU0N
Cj4gdGhhdCBzdXBwb3J0cyBsYWJlbHMgd2l0aCBvbmUgdGhhdCBkb2Vzbid0LiANCkhpIERhbiwN
ClRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4NCg0KSSBvbmx5IGhhdmUgTlZESU1NIHdoaWNoIHN1
cHBvcnRzIGxhYmVsLCBzbyBJIGNvdWxkIG5vdCBkbyB0aGlzIHR5cGUgdGVzdCB5ZXQuDQpBcyBJ
IHVuZGVyc3RhbmQgeW91ciB3b3JkcywgaW4gbWl4aW5nIHN0YXR1cywgdGhlIG5zdHlwZSB3b3Vs
ZCBiZQ0KTkRfREVWSUNFX05BTUVTUEFDRV9QTUVNIGlmIG9uZSBOVkRJTU0gc3VwcG9ydHMgbGFi
ZWxzLiBBbSBJIHJpZ2h0Pw0KDQpCeSB0aGUgd2F5LCBkbyB5b3UgdGhpbmsgbXkgcGF0Y2ggaXMg
dmFsdWFibGUgdG8gc2F2ZSBhIGZldyBjcHUgY3ljbGVzIGhlcmU/DQoNCk9jZWFuLg0KPiBJZiBh
bnl0aGluZyBJIHRoaW5rIHdlDQo+IG5lZWQgZml4ZXMgdG8gbWFrZSBzdXJlIHRoaXMgb3BlcmF0
ZXMgY29ycmVjdGx5IHRvIGZvcmNlIGRpc2FibGUNCj4gQkxLLW1vZGUgY2FwYWN0aXkgd2hlbiB0
aGUgUE1FTSBjYXBhY2l0eSBpcyBpbnRlcmxlYXZlZCB3aXRoIGENCj4gbGFiZWwtbGVzcyBOVkRJ
TU0uDQpJIGFtIHRyeWluZyB0byB0cmFuc2xhdGUgeW91ciB3b3JkcyB0byB0ZXN0IHN0ZXBzLCBw
bGVhc2UgY29ycmVjdCBtZSBmb3INCm1pc3VuZGVyc3RhbmRpbmcuDQojMS4gUHJlcGFyZSAyIE5W
RElNTXMgd2hpY2ggaGFzIG5vIGxhYmVsIGNhcGFjaXR5Lg0KIzIuIENyZWF0ZSBhIHJlZ2lvbiB3
aGljaCBoYXMgUE1FTSBjYXBhY2l0eSBhbmQgaW50ZXJsZWF2ZWQuDQppcG1jdGwgY3JlYXRlIC1m
IC1nb2FsIC1zb2NrZXQgMHgxIFBlcnNpc3RlbnRNZW1vcnlUeXBlPUFwcERpcmVjdA0KIzMuIENy
ZWF0ZSBhIEJMSy1tb2RlIGNhcGFjaXR5IG5hbWVzcGFjZSwgdGhlbiB0aGlzIG5hbWVzcGFjZSBz
aG91bGQgYmUgDQoiZm9yY2UgZGlzYWJsZSIgPw0KbmRjdGwgY3JlYXRlLW5hbWVzcGFjZSAtciBy
ZWdpb24xIC1zIDFnIC10IHBtZW0gLW0gc2VjdG9yDQoNCk9jZWFuLg0K
