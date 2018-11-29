Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6F2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC98C20834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="CF2/f0BT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC98C20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeK2Vsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:48:39 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:37720 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeK2Vsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:48:39 -0500
X-IronPort-AV: E=Sophos;i="5.56,294,1539673200"; 
   d="scan'208";a="23646942"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Nov 2018 03:43:43 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 29 Nov 2018 03:43:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VP4slUa6YwhpC1O47SZdnXRRsJy6Ko4ZY73t64cUNrw=;
 b=CF2/f0BTqQVM67RV20v4Sn/1bs7Jx0Y14k3meD+323MZoyyjel4fgjcp6Lnz09StDLb5XySk546Nj/QHK1kZ35nlg+o7HvnSqdo2w+TF7cyYwezRwtDpupCxAiTP/mh83rzFDSKITpAXYiLF2eZPgXSJi8myRf2SaBsbEsCv6nE=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0824.namprd11.prod.outlook.com (10.163.112.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18; Thu, 29 Nov 2018 10:43:41 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681%5]) with mapi id 15.20.1361.019; Thu, 29 Nov 2018
 10:43:41 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <harinik@xilinx.com>
CC:     <harini.katakam@xilinx.com>, <Nicolas.Ferre@microchip.com>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>
Subject: Re: [RFC PATCH] net: macb: Apply RXUBR workaround only to versions
 with errata
Thread-Topic: [RFC PATCH] net: macb: Apply RXUBR workaround only to versions
 with errata
Thread-Index: AQHUh804bu3Co8uTGEqCd0JItPQ7vKVmj6eAgAABfoA=
Date:   Thu, 29 Nov 2018 10:43:41 +0000
Message-ID: <fbd59625-b36b-76f3-6f88-78efe901f67a@microchip.com>
References: <1542967157-8053-1-git-send-email-harini.katakam@xilinx.com>
 <b838b826-9395-fbe9-1b4c-34be574b33cf@microchip.com>
 <CAFcVECKw0utBH6-owf-0C1M07Tr2tH3Gu=X7cp04XuvXWHoJiA@mail.gmail.com>
In-Reply-To: <CAFcVECKw0utBH6-owf-0C1M07Tr2tH3Gu=X7cp04XuvXWHoJiA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P189CA0021.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::34) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0824;6:sxJvPtn9EiG2YS6DJAIgQAA8bnVboawuwRPOMiOXJ//pT8Yugq26VBlMduoE+X62KV6JduOtgaYkMp0i0r7KpkOBhs5VXnIVvbKDleEoSZz0UBfCsv5uhpXovYgUQT3nrclSpoBO/IJ9a9guxmcv6N/5ZqPv2+f4FC/VCuOkA0RiKVf/j6OIDohu28823fJYTSgj0gTyprzxnFcWTIc+XdDSB/6ZBsAoMyCgN3z66MHimguUPeE/x8OBRaIGdlo5sReIxApj7AcsCwlLz9sDhZ2gBbuZRQB1ONaeJkmoL9iGTBTmPeV2gxvYa2zSxNrmJBMdv9uNVJLD18NArNMi6HG2EG8vJ9TSR8/L1rqrCefrpG7H4oErnI5iXfdKGQjW9VzR6vFrpOCL4p3Dadyjdu3cMrelqm7RDDmZJL62fj/d36wOjdcqOSXlucH0CitTZFO+NV2wIgCUSnEX3cl0LjbOTaLIC6NTy4DtYHcqnUQ=;5:jRdHa2npysm1P6yUAcxRT2ZF9Rd7GTHZ/DHY/JNMVfeqLIAZUXjgx7/6sSFg+va6J0Ec+8vmTFKrgclLfBLAap38mR1MTv9kEVRGohJEgOHglmuihjKLVWotwNQ6EXuQ1jezN6m3b/MV3q9XocdmE+DnaJYH00Ut5dUWrUjE5v4=;7:1PFbpiq1XBA3uUqbXKWUsPzDjPOPl1OQ0AtVeYVrlJwGPB32+i6Bde/6Cwf84BK0XpKoSlJNPhhJfYvUnAJ1EQ1w3t8zCaomnzmxJkenybZQ9leSpRozPcN01ImyDWBBuG1nG7IZ5pS0XbzhUF2AsA==
x-ms-office365-filtering-correlation-id: ed0859c4-e325-45e0-4866-08d655e78723
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0824;
x-ms-traffictypediagnostic: BY2PR11MB0824:
x-microsoft-antispam-prvs: <BY2PR11MB08241A7F1882EB9F3F069DB687D20@BY2PR11MB0824.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231453)(999002)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0824;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0824;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(366004)(39860400002)(69234005)(189003)(199004)(486006)(14444005)(256004)(2616005)(305945005)(446003)(7736002)(476003)(11346002)(316002)(14454004)(86362001)(68736007)(31696002)(3846002)(6116002)(186003)(2906002)(72206003)(31686004)(99286004)(6486002)(6916009)(229853002)(97736004)(386003)(53546011)(6506007)(966005)(76176011)(26005)(102836004)(54906003)(25786009)(6246003)(53936002)(8676002)(36756003)(8936002)(106356001)(81156014)(81166006)(66066001)(6436002)(105586002)(71200400001)(52116002)(71190400001)(6306002)(6512007)(478600001)(5660300001)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0824;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /Rlx8yQqAxTc3jInTi4ad78fnDg2jvwX0NmsgNFYUFmhP66chq6sTYV5tzrMyPBf9LkCp4a8qkdijXe7C/XN0QOnUQSD3bIjh1pzHomSpTho72ZxzeXghPUqrBxYSmAkYdp313alOL2I6xvFzHXb4LBC+TkEo4sOl8mr+6OVuyM134NZGRV5zOns2CTN/K35k0ICe2tegtB1wb01Kdb+ilU2lUpTCrOwhNq4nl43iRl/L+jJRaw2Zn4xwkm5yszXLyTEwdLzCWtBOw+K+0mkPEo2CV9XaOnf8wZTOYq13zFQpKLoucrYXCkEENOMmpyTsxQiQO0gW3Y3GnixFhjMN37Q160FkbFvJ7MPA2g+M8Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DED11D583FE8CD42842754469157A7C1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0859c4-e325-45e0-4866-08d655e78723
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 10:43:41.5699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0824
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDI5LjExLjIwMTggMTI6MzgsIEhhcmluaSBLYXRha2FtIHdyb3RlOg0KPiBIaSBDbGF1
ZGl1LA0KPiBPbiBUaHUsIE5vdiAyOSwgMjAxOCBhdCAzOjUxIFBNIDxDbGF1ZGl1LkJlem5lYUBt
aWNyb2NoaXAuY29tPiB3cm90ZToNCj4+DQo+Pg0KPj4NCj4+IE9uIDIzLjExLjIwMTggMTE6NTks
IEhhcmluaSBLYXRha2FtIHdyb3RlOg0KPiA8c25pcD4NCj4+PiAtICAgICAgICAgICAgIGlmIChz
dGF0dXMgJiBNQUNCX0JJVChSWFVCUikpIHsNCj4+PiArICAgICAgICAgICAgIGlmICgoYnAtPmVy
cmF0YSAmIE1BQ0JfRVJSQVRBX1JYTE9DS1VQKSAmJg0KPj4+ICsgICAgICAgICAgICAgICAgIChz
dGF0dXMgJiBNQUNCX0JJVChSWFVCUikpKSB7DQo+Pg0KPj4gSnVzdCBhc2tpbmcsIGRpZCB5b3Ug
bWFuYWdlIHRvIHRlc3QgdGhpcyBvbiBvdGhlciBwbGF0Zm9ybXMgdGhhdCBoYXZlbid0DQo+PiB0
aGlzIGlzc3VlPw0KPj4gU0FNQTVEMiBkYXRhc2hlZXQgWzFdIHN0YXRlcyB0aGlzOg0KPj4gIldo
ZW4gaW4gcGFja2V0IGJ1ZmZlciBmdWxsIHN0b3JlIGFuZCBmb3J3YXJkIG1vZGUsIG9ubHkgZ29v
ZCByZWNlaXZlZA0KPj4gZnJhbWVzIGFyZSB3cml0dGVuIG91dCBvZiB0aGUgRE1BLCBzbyBubw0K
Pj4gIGZyYWdtZW50cyB3aWxsIGV4aXN0IGluIHRoZSBBSEIgYnVmZmVycyBkdWUgdG8gTUFDIHJl
Y2VpdmVyIGVycm9ycy4gVGhlcmUNCj4+IGlzIHN0aWxsIHRoZSBwb3NzaWJpbGl0eSBvZiBmcmFn
bWVudHMgZHVlIHRvDQo+PiAgRE1BIGVycm9ycywgZm9yIGV4YW1wbGUgdXNlZCBiaXQgcmVhZCBv
biB0aGUgc2Vjb25kIGJ1ZmZlciBvZiBhDQo+PiBtdWx0aWJ1ZmZlciBmcmFtZS4iDQo+Pg0KPj4g
QnV0IGl0IGlzIHRydWUgdGhhdCBub3doZXJlIGlzIHByZXNlbnRlZCB0aGF0IHRoaXMgbXVzdCBi
ZSBzcGVjaWFsIHRyZWF0ZWQuDQo+Pg0KPiANCj4gWWVzLCBJIHRlc3RlZCBpdCBvbiBaeW5xTVAg
d2hpY2ggZG9lcyBOT1QgaGF2ZSB0aGlzIGVycmF0YSAtIGRpZCBwZXJmIGFuZA0KPiBwaW5nIGZs
b29kIGFuZCBkaW50IHNlZSBhbnkgaXNzdWVzLg0KDQpHcmVhdCEgVGhhbmsgeW91LCBIYXJpbmkh
DQoNCj4gSnVzdCBGWUksIHRoZSBlcnJhdGEgaW4gdGhlIElQIHZlcnNpb24gaW4gWnlucSBjYXVz
ZXMgYW4gUlggbG9jayB1cCB1bmRlcg0KPiBoaWdoIHN0cmVzcyAod2hlbiB0aGVyZSBpcyBvYnZp
b3VzbHkgbXVsdGlwbGUgUlhVQlIgaW50ZXJydXB0cykuIFRoZSBSWCByZXNldA0KPiBpcyBhIHBy
ZS1lbXB0aXZlIHdvcmthcm91bmQgdG8gKm1vc3RseSogYXZvaWQgdGhlIGlzc3VlLg0KPiBQbGVh
c2Ugc2VlIEFuc3dlciByZWNvcmQgNTIwMjggaW4NCj4gaHR0cHM6Ly93d3cueGlsaW54LmNvbS9z
dXBwb3J0L2RvY3VtZW50YXRpb24vZXJyYXRhL2VuMjQ3LnBkZg0KPiANCj4+IE1vcmVvdmVyLCBp
ZiB5b3UgZG8gdGhpcyBvbmx5IGZvciBNQUNCX0VSUkFUQV9SWExPQ0tVUCBhbmQgc3RpbGwgaGF2
ZSBSWFVCUg0KPj4gaW50ZXJydXB0IGVuYWJsZWQgZXZlcnkgdGltZSBpdCB3b3VsZCBub3QgbWFr
ZSBzZW5zZSB0byBzdGlsbCBlbmFibGUgaXQuDQo+PiBPciwgaWYgeW91IHdhbnQgaXQgZW5hYmxl
ZCBldmVyeSB0aW1lLCB5b3Ugc2hvdWxkIGNsZWFyIGl0IG5vIG1hdHRlciB0aGUNCj4+IE1BQ0Jf
RVJSQVRBX1JYTE9DS1VQIGlzIHNldCBvciBub3QsIHdpdGggc29tZXRoaW5nIGxpa2UgdGhpczoN
Cj4+DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoYnAtPmNhcHMgJiBNQUNCX0NBUFNf
SVNSX0NMRUFSX09OX1dSSVRFKQ0KPj4NCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcXVldWVfd3JpdGVsKHF1ZXVlLCBJU1IsIE1BQ0JfQklUKFJYVUJSKSk7DQo+Pg0KPj4NCj4g
VGhhbmtzIGZvciBwb2ludGluZyB0aGlzIG91dCAtIHllcyBpJ2xsIG1vdmUgdGhlIFdUQyBjb2Rl
IG91dHNpZGUgdGhlIGNoZWNrLg0KPiANCj4gUmVnYXJkcywNCj4gSGFyaW5pDQo+IA0K
