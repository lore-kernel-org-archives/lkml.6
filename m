Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171F7C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F6B20685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="csPD9Uyn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F6B20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbeGZOUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:20:11 -0400
Received: from mail-cys01nam02on0047.outbound.protection.outlook.com ([104.47.37.47]:11508
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730030AbeGZOUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdE78pAcJ7JGjvmOlsbKg1bhiAVZCCHhz+H9mSSim78=;
 b=csPD9UynMp7jPqnPo9eyNJpXdwsNsqKrZm50bWBh9/TrrIYOGTPp+41WtywDrL7GSyEJm/kDgt+iogsQPsaizEIxRbwu+/kYEABKqvWX++32mpSXSEv2XpH2isYiMGRO/88InuV5KS91/LcuAlGoDDaE2efZl93gnIaYbB/e0Yc=
Received: from CY1PR02MB2091.namprd02.prod.outlook.com (10.166.190.27) by
 CY1PR02MB1277.namprd02.prod.outlook.com (10.163.16.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.16; Thu, 26 Jul 2018 13:03:17 +0000
Received: from CY1PR02MB2091.namprd02.prod.outlook.com
 ([fe80::4919:8491:1e24:d74f]) by CY1PR02MB2091.namprd02.prod.outlook.com
 ([fe80::4919:8491:1e24:d74f%6]) with mapi id 15.20.0973.022; Thu, 26 Jul 2018
 13:03:16 +0000
From:   Rajan Vaja <RAJANV@xilinx.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
Subject: RE: [PATCH] clk: clk-fixed-factor: Clear OF_POPULATED flag in case of
 failure
Thread-Topic: [PATCH] clk: clk-fixed-factor: Clear OF_POPULATED flag in case
 of failure
Thread-Index: AQHUHdCCl8UpVqbkLUGzkDbeupCIAqSgMMkAgAFVOLA=
Date:   Thu, 26 Jul 2018 13:03:16 +0000
Message-ID: <CY1PR02MB2091CE50B9163419EB7D67EFB72B0@CY1PR02MB2091.namprd02.prod.outlook.com>
References: <1531833420-27175-1-git-send-email-rajan.vaja@xilinx.com>
 <153253683456.48062.11538822357721957211@swboyd.mtv.corp.google.com>
In-Reply-To: <153253683456.48062.11538822357721957211@swboyd.mtv.corp.google.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 10.0.260.4
dlp-reaction: no-action
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RAJANV@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR02MB1277;6:b/cvSY0jUEMZUVgKeeYLWsChKyLfKTs94b5XOENqIRuwmI+LLtYfCl5RwG/mx9P6Nw2YzzhhmeoGqHZ6UGHDgppeMcbZosyzBpgliV8W7NTIREaMKU/tTXa3fOo2WAbuzWqJpN7y2ud60IzvpnUJfH8WmdNXXsz1P/GkIfVANJSbnMOQPj1xVaIjY847nX/e8r2hGe49HCgMDDo6dKqBoWQmjUwOgTxv5nSMsWoym9ZK8g6rxWp2tx70Bgg1svO2+NITiKVeakW9SMmpZBvVJ/cgGUclOd+3p+m79LlCmcRO/OKMCLKW548agY5cE9xkT3V8KQ2BEq/GDLDe4AR/E/Yz5nnHGamLuA6an16Q66V/6MFPEX5WzDYPJO/cLiu/nAWVHFRqRuMOMGdXjFxlVUIn6MriIgQLTFU9dHQEccDeWNDP41d+YkPuW1FoaLK2pYfIs7dBN0XtqzxXj9qNkQ==;5:ieXikxyLJ4R9dAxB9AG2XKa5voGZbjMyIVon0R7j9t3p0vp9voq7WTwEQie49mJ3Uby/jJ3DsE1FNagYctoc2UebsyDGskwKZZ/6me/coDaiTqzPzxDomgiZkZLsxd8xWess2QhKrsK1zYSWad1OTgWR367su7q7lIC5wI20LKc=;7:1lnPfy4YOF8wFNxDjkcl6MZ3WRacOBhLVGVrR3avfVj62elieovDYeTJdS6oDAUpVh69wG8G5Ot3rkYke2TMT1FmjrxXbklVYDZEWCsmdHxFShcmTHqmVLYaouT1fFSEGnEGSxg1zAN7ol6uyP4e64ZiE8uzF8Sji17lZfUXwXoE1iQA5K7ErAlFXepjkl4fuG8Ln/HSvOuUK44vwyVPTtR1RDc/bIFYs17ZvLX69Z8GQwP/preiq1ti4MuMyiXE
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 78ae8591-6ac3-41c7-e6e4-08d5f2f82768
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR02MB1277;
x-ms-traffictypediagnostic: CY1PR02MB1277:
x-microsoft-antispam-prvs: <CY1PR02MB1277BAA6D6291C7EFAB7A0CFB72B0@CY1PR02MB1277.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CY1PR02MB1277;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1277;
x-forefront-prvs: 07459438AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(376002)(396003)(346002)(199004)(189003)(13464003)(97736004)(8936002)(256004)(14444005)(68736007)(66066001)(105586002)(106356001)(5250100002)(2906002)(81166006)(5660300001)(81156014)(8676002)(305945005)(74316002)(7736002)(4326008)(6916009)(6246003)(25786009)(86362001)(316002)(446003)(54906003)(11346002)(33656002)(55016002)(72206003)(102836004)(26005)(186003)(229853002)(99286004)(53546011)(6506007)(7696005)(76176011)(2900100001)(6116002)(3846002)(9686003)(478600001)(486006)(6436002)(14454004)(476003)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1277;H:CY1PR02MB2091.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5yVTH0Ah6srr2zZzTsuBaNz1EaR/NfYDflLZfoN304OagQdwh9JrZfxfAecVVL17FFIxK8YTDOXV3MtQtdgn9jbB0KbyDfc5Cvjmk/D6zyJhQuH0YEAa9ORQ0udjR9RHm+gfKJOqDd8oSTvQjC0ydeqq/VejoKdINiuidnQu4Js6YRjJCDW80na9aQrMLfAVa4Gw1iRxffRCgvkvUkpo822unZA0LhrF671krkK968szsJ9320wrm2jofV2n4RjzpcI+o4JGe3sjitGOZNzbENN14rQN5TZj/ZUcv7HOYjdk5261A7EQTNRqKZi06RgYpi+/SlGk8xPDEzxYwBiXbSVLE85tFiKs2A3X4KZLHBA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ae8591-6ac3-41c7-e6e4-08d5f2f82768
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2018 13:03:16.9380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1277
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVw
aGVuIEJveWQgW21haWx0bzpzYm95ZEBrZXJuZWwub3JnXQ0KPiBTZW50OiAyNSBKdWx5IDIwMTgg
MTA6MTEgUE0NCj4gVG86IFJhamFuIFZhamEgPFJBSkFOVkB4aWxpbnguY29tPjsgbXR1cnF1ZXR0
ZUBiYXlsaWJyZS5jb20NCj4gQ2M6IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFJhamFuIFZhamENCj4gPFJBSkFOVkB4aWxpbnguY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBjbGs6IGNsay1maXhlZC1mYWN0b3I6IENsZWFyIE9GX1BP
UFVMQVRFRCBmbGFnIGluIGNhc2Ugb2YNCj4gZmFpbHVyZQ0KPiANCj4gUXVvdGluZyBSYWphbiBW
YWphICgyMDE4LTA3LTE3IDA2OjE3OjAwKQ0KPiA+IEZpeGVkIGZhY3RvciBjbG9jayBoYXMgdHdv
IGluaXRpYWxpemF0aW9ucyBhdCBvZl9jbGtfaW5pdCgpIHRpbWUNCj4gPiBhbmQgZHVyaW5nIHBs
YXRmb3JtIGRyaXZlciBwcm9iZS4gQmVmb3JlIG9mX2Nsa19pbml0KCkgY2FsbCwNCj4gPiBub2Rl
IGlzIG1hcmtlZCBhcyBwb3B1bGF0ZWQgYW5kIHNvIGl0cyBwcm9iZSBuZXZlciBnZXRzIGNhbGxl
ZC4NCj4gPg0KPiA+IER1cmluZyBvZl9jbGtfaW5pdCgpIGZpeGVkIGZhY3RvciBjbG9jayByZWdp
c3RyYXRpb24gbWF5IGZhaWwgaWYNCj4gPiBhbnkgb2YgaXRzIHBhcmVudCBjbG9jayBpcyBub3Qg
cmVnaXN0ZXJlZC4gSW4gdGhpcyBjYXNlLCBpdCBkb2Vzbid0DQo+ID4gZ2V0IGNoYW5jZSB0byBy
ZXRyeSByZWdpc3RyYXRpb24gZnJvbSBwcm9iZS4gQ2xlYXIgT0ZfUE9QVUxBVEVEDQo+ID4gZmxh
ZyBpZiBmaXhlZCBmYWN0b3IgY2xvY2sgcmVnaXN0cmF0aW9uIGZhaWxzIHNvIHRoYXQgY2xvY2sN
Cj4gPiByZWdpc3RyYXRpb24gaXMgYXR0ZW1wdGVkIGFnYWluIGZyb20gcHJvYmUuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBSYWphbiBWYWphIDxyYWphbi52YWphQHhpbGlueC5jb20+DQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvY2xrL2Nsay1maXhlZC1mYWN0b3IuYyB8IDkgKysrKysrKystDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9jbGstZml4ZWQtZmFjdG9yLmMgYi9kcml2ZXJz
L2Nsay9jbGstZml4ZWQtZmFjdG9yLmMNCj4gPiBpbmRleCBkNzJlZjJkLi5mM2FlNGZmIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL2Nsay1maXhlZC1mYWN0b3IuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvY2xrL2Nsay1maXhlZC1mYWN0b3IuYw0KPiA+IEBAIC0xNzcsOCArMTc3LDE1IEBAIHN0
YXRpYyBzdHJ1Y3QgY2xrICpfb2ZfZml4ZWRfZmFjdG9yX2Nsa19zZXR1cChzdHJ1Y3QNCj4gZGV2
aWNlX25vZGUgKm5vZGUpDQo+ID4NCj4gPiAgICAgICAgIGNsayA9IGNsa19yZWdpc3Rlcl9maXhl
ZF9mYWN0b3IoTlVMTCwgY2xrX25hbWUsIHBhcmVudF9uYW1lLCBmbGFncywNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXVsdCwgZGl2KTsNCj4gPiAtICAgICAg
IGlmIChJU19FUlIoY2xrKSkNCj4gPiArICAgICAgIGlmIChJU19FUlIoY2xrKSkgew0KPiA+ICsg
ICAgICAgICAgICAgICAvKg0KPiA+ICsgICAgICAgICAgICAgICAgKiBJZiBwYXJlbnQgY2xvY2sg
aXMgbm90IHJlZ2lzdGVyZWQsIHJlZ2lzdHJhdGlvbiB3b3VsZCBmYWlsLg0KPiA+ICsgICAgICAg
ICAgICAgICAgKiBDbGVhciBPRl9QT1BVTEFURUQgZmxhZyBzbyB0aGF0IGNsb2NrIHJlZ2lzdHJh
dGlvbiBjYW4gYmUNCj4gPiArICAgICAgICAgICAgICAgICogYXR0ZW1wdGVkIGFnYWluIGZyb20g
cHJvYmUgZnVuY3Rpb24uDQo+ID4gKyAgICAgICAgICAgICAgICAqLw0KPiA+ICsgICAgICAgICAg
ICAgICBvZl9ub2RlX2NsZWFyX2ZsYWcobm9kZSwgT0ZfUE9QVUxBVEVEKTsNCj4gPiAgICAgICAg
ICAgICAgICAgcmV0dXJuIGNsazsNCj4gPiArICAgICAgIH0NCj4gDQo+IEJUVywgdGhpcyBwYXRj
aCB3YXMgc2VyaW91c2x5IG1hbmdsZWQgZm9yIG1lIHNvIEkgaGFkIHRvIGFwcGx5IGl0IGJ5DQo+
IGhhbmQuIFBsZWFzZSBiZSBtb3JlIGNhcmVmdWwgbmV4dCB0aW1lIGFuZCBjb25zaWRlciB1c2lu
ZyBzb21ldGhpbmcgbGlrZQ0KPiBnaXQtc2VuZC1lbWFpbCBhbmQgZ2l0LWZvcm1hdC1wYXRjaCB0
byBzZW5kIHBhdGNoZXMuDQpbUmFqYW5dIEkgdXNlZCBnaXQtc2VuZC1lbWFpbCBvbmx5IGFuZCBz
ZW50IHNhbWUgd2F5IGFzIEkgdXNlZCB0byBzZW5kIG90aGVyIHBhdGNoZXMuIE5vdCBzdXJlIHdo
ZXJlIHdhcyBpc3N1ZS4NClNvcnJ5IGZvciB0aGUgaW5jb252ZW5pZW5jZS4gIA0KDQo=
