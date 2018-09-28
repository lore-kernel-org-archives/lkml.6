Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688D3ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25071204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="kgHPm3aV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25071204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbeI1Xmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:42:38 -0400
Received: from mail-cys01nam02on0055.outbound.protection.outlook.com ([104.47.37.55]:54104
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbeI1Xmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+tJLsLm8YjTCCOeIotknWu3P/lf0fqRKFR7dv8lQY4=;
 b=kgHPm3aVj5sbIMFOJgxDPA5bwCpjN3e0IAqKw5nFqCtd/xSNx5R6oAf+hic6/heWaSsmrxX2zevcZ4UjLulgiiDC+0kUz0+kQ+4zzM4Fp1sXwXZTAM2f9eI3Cddu+8CIYSkaVQFJUBKosJIQq+D7/5rqR820H8FjgVYbpJ8mxJ8=
Received: from BL2PR02MB2130.namprd02.prod.outlook.com (10.167.97.16) by
 BL2PR02MB387.namprd02.prod.outlook.com (10.141.91.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.25; Fri, 28 Sep 2018 17:15:45 +0000
Received: from BL2PR02MB2130.namprd02.prod.outlook.com
 ([fe80::281b:9a9:7f2:2913]) by BL2PR02MB2130.namprd02.prod.outlook.com
 ([fe80::281b:9a9:7f2:2913%5]) with mapi id 15.20.1164.024; Fri, 28 Sep 2018
 17:15:42 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Olof Johansson <olof@lixom.net>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michal Simek <michals@xilinx.com>,
        ARM-SoC Maintainers <arm@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>
Subject: RE: [PATCH v3 2/4] firmware: xilinx: Add zynqmp IOCTL API for device
 control
Thread-Topic: [PATCH v3 2/4] firmware: xilinx: Add zynqmp IOCTL API for device
 control
Thread-Index: AQHUVcSqwfN6zMRvQEKlKLUStW4Ud6UDCROAgALo5+A=
Date:   Fri, 28 Sep 2018 17:15:41 +0000
Message-ID: <BL2PR02MB21308D0B6AF76A8094E70863B8EC0@BL2PR02MB2130.namprd02.prod.outlook.com>
References: <1537985581-32164-1-git-send-email-jollys@xilinx.com>
 <1537985581-32164-3-git-send-email-jollys@xilinx.com>
 <CAOesGMhEcMB4caAPtCSq-m5zQBDc-8Z4f_xAkomnEwVaHyX2Mw@mail.gmail.com>
In-Reply-To: <CAOesGMhEcMB4caAPtCSq-m5zQBDc-8Z4f_xAkomnEwVaHyX2Mw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL2PR02MB387;6:j7oZB8KsvWulkPQWPln/ZxSdXHkErVy023pcrLpKduJ4VR4beR4VEposc9Qk//UPG3+OPKk36lwt3k6UBRAXK2dEszvRRnFhUaiGh1WYf9z5I/EtYNFz2DPy5iXGGRrqtGbtEPeJTgMpKKHJMSeUn8u+FmhNfFw8Wu0WogoXowzvJ27m9loWlDozcP5Q3HvOL+aBdx4efIw63VwjCvoG9x+rPEskQ51pktOkV1jOsJrduATQanwKDEOSgpLBrAV2grTfc9CrIgQR/2SYynphCJcYOIF8dTF816RiymlEDMpdxSdmEkN45YG1v8dxgVZAClm80hOX1ljcy9O6uKbTRBczQZNnmAD523YH5hvi6nPdMvR7eQZ1BMgt+tlv9YZNd1dC9AXXtuv8hz9BbhQ2m3Se881omX/hf6ocJp61WXe5ihth4xfph4bln0Df08cLQLK+16nz2AEbNzJz76SLqQ==;5:5h5Z2M9UvRebmBaX5ES2eJgKgD+R9h9/XeFthP4aUcskMrJxoaunxqnE0cuvNNJ3rxoWjz1rhL41qdMyW+gIkwhP6yUAYBkxnqqbvGREWaVJC5Icp1hvFXECEKednDSnrwGZsrj5ez8Kke0dYrUH/EAKarVw3jeTZtqt/OKM0oM=;7:0jkfylhaqfiVVlpfkHX/9TR5kcmx4pL3IpfWUIiqDP7369ePPXWxx2vV1ccnWPfPpJb+1nvT74u2EnbroD2WDAi5IOWowzPMUkxCX1z+vcdorhbcRIKiw/v5QjQxjrcVaQt7tfjduWE/dDmLNS3wr7x28SLUDKH5nbk0eovl8EecspLO/w9DMYAs5wxGETRzGigFVrNZUhOJqUc2GGRFoKLVjWgkzMG217uLQS0A3NtaHCS3R5EUaMgVz2jjwF/G
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(366004)(136003)(39860400002)(199004)(189003)(13464003)(51914003)(81166006)(8936002)(81156014)(7736002)(74316002)(6246003)(6436002)(11346002)(316002)(476003)(446003)(102836004)(6346003)(53546011)(7696005)(4326008)(26005)(229853002)(68736007)(6506007)(186003)(25786009)(99286004)(54906003)(76176011)(8676002)(2900100001)(86362001)(107886003)(305945005)(105586002)(106356001)(6916009)(3846002)(6116002)(33656002)(72206003)(97736004)(71190400001)(256004)(71200400001)(34290500001)(217873002)(53936002)(478600001)(14444005)(55016002)(2906002)(5660300001)(486006)(5250100002)(14454004)(66066001)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR02MB387;H:BL2PR02MB2130.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 7f1d0e38-aca9-435b-f0b1-08d625660569
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL2PR02MB387;
x-ms-traffictypediagnostic: BL2PR02MB387:
x-microsoft-antispam-prvs: <BL2PR02MB38728D8951A3B3F19706FABB8EC0@BL2PR02MB387.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(9452136761055)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:BL2PR02MB387;BCL:0;PCL:0;RULEID:;SRVR:BL2PR02MB387;
x-forefront-prvs: 0809C12563
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-microsoft-antispam-message-info: QTeIygT9t6/n73jDF2lHbBxNa/5h+Z7k1XHn+Jc4i07/t6j4d3SoOlSgnnin6w14T1jHT6crtF+MLASdQj8ehrVlvzo6ccr4Jnp7uv1ByI07DTY6NloIbj1KTk/iut1IUaSfAuCdMwT6XX66ZghIHEF7hqRIAhHvupnPZpwfippGUfaXRuz2Lr2TOZHk0g69hfiCJDmwVj+50uXsLKPeoUu+/BQ16MVeL0SVXSiahT8TNn/QGsIw0z4xVqudoGsQutxm3Cb9/NWIDEtKFnL8l4R3U4WgiIYLeBuKZX3h2tfhccKUlVjSlcqUPK7GnYsj7vz+xKbHYtunQev6Mh0d7BKTcuBj71cTR+J11xVBKKY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1d0e38-aca9-435b-f0b1-08d625660569
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 17:15:41.8630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR02MB387
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgT2xvZiwNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3LiBQdXNoZWQgdjQgd2l0aCBzdWdnZXN0
ZWQgZml4ZXMuIExldCB1cyBrbm93IGlmIHNlcmllcyBsb29rcyBnb29kIGFuZCB3ZSBjYW4gY3Jl
YXRlIHB1bGwgcmVxdWVzdCBmb3Igc2FtZS4NCg0KVGhhbmtzLA0KSm9sbHkgU2hhaA0KDQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogT2xvZiBKb2hhbnNzb24gW21haWx0
bzpvbG9mQGxpeG9tLm5ldF0NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMjYsIDIwMTgg
MTo0OSBQTQ0KPiBUbzogSm9sbHkgU2hhaCA8Sk9MTFlTQHhpbGlueC5jb20+DQo+IENjOiBNaWNo
YWVsIFR1cnF1ZXR0ZSA8bXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb20+OyBTdGVwaGVuIEJveWQNCj4g
PHNib3lkQGNvZGVhdXJvcmEub3JnPjsgTWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlueC5jb20+
OyBBUk0tU29DDQo+IE1haW50YWluZXJzIDxhcm1Aa2VybmVsLm9yZz47IGxpbnV4LWNsayA8bGlu
dXgtY2xrQHZnZXIua2VybmVsLm9yZz47IFJhamFuDQo+IFZhamEgPFJBSkFOVkB4aWxpbnguY29t
PjsgTGludXggQVJNIE1haWxpbmcgTGlzdCA8bGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZz47IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LQ0KPiBrZXJuZWxA
dmdlci5rZXJuZWwub3JnPjsgUmFqYW4gVmFqYSA8UkFKQU5WQHhpbGlueC5jb20+OyBKb2xseSBT
aGFoDQo+IDxKT0xMWVNAeGlsaW54LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAyLzRd
IGZpcm13YXJlOiB4aWxpbng6IEFkZCB6eW5xbXAgSU9DVEwgQVBJIGZvciBkZXZpY2UNCj4gY29u
dHJvbA0KPiANCj4gSGksDQo+IA0KPiBKdXN0IG5pdHMgb24gY29kZSByZWFkYWJpbGl0eSBiZWxv
dy4gQXBwcm9hY2ggbG9va3MgT0sgdG8gbWUuDQo+IA0KPiBPbiBXZWQsIFNlcCAyNiwgMjAxOCBh
dCAxMToxMyBBTSBKb2xseSBTaGFoIDxqb2xseS5zaGFoQHhpbGlueC5jb20+IHdyb3RlOg0KPiA+
DQo+ID4gRnJvbTogUmFqYW4gVmFqYSA8cmFqYW4udmFqYUB4aWxpbnguY29tPg0KPiA+DQo+ID4g
QWRkIFp5bnFNUCBmaXJtd2FyZSBJT0NUTCBBUEkgdG8gY29udHJvbCBhbmQgY29uZmlndXJlIGRl
dmljZXMgbGlrZQ0KPiA+IFBMTHMsIFNELCBHZW0sIGV0Yy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFJhamFuIFZhamEgPHJhamFuLnZhamFAeGlsaW54LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBKb2xseSBTaGFoIDxqb2xseXNAeGlsaW54LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9m
aXJtd2FyZS94aWxpbngvenlucW1wLmMgICAgIHwgNDMNCj4gKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ID4gIGluY2x1ZGUvbGludXgvZmlybXdhcmUveGxueC16eW5xbXAu
aCB8ICA0ICsrKy0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS94aWxpbngv
enlucW1wLmMNCj4gPiBiL2RyaXZlcnMvZmlybXdhcmUveGlsaW54L3p5bnFtcC5jDQo+ID4gaW5k
ZXggODRiM2ZkMi4uNjcxYTM3YSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Zpcm13YXJlL3hp
bGlueC96eW5xbXAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZmlybXdhcmUveGlsaW54L3p5bnFtcC5j
DQo+ID4gQEAgLTQyOCw2ICs0MjgsNDggQEAgc3RhdGljIGludCB6eW5xbXBfcG1fY2xvY2tfZ2V0
cGFyZW50KHUzMiBjbG9ja19pZCwNCj4gdTMyICpwYXJlbnRfaWQpDQo+ID4gICAgICAgICByZXR1
cm4gcmV0Ow0KPiA+ICB9DQo+ID4NCj4gPiArLyoqDQo+ID4gKyAqIHp5bnFtcF9pc192YWxpZF9p
b2N0bCgpIC0gQ2hlY2sgd2hldGhlciBJT0NUTCBJRCBpcyB2YWxpZCBvciBub3QNCj4gPiArICog
QGlvY3RsX2lkOiAgSU9DVEwgSUQNCj4gPiArICoNCj4gPiArICogUmV0dXJuOiAwIGlmIElPQ1RM
IGlzIHZhbGlkLCBlbHNlIC1FSU5WQUwgICovIHN0YXRpYyBpbmxpbmUgaW50DQo+ID4gK3p5bnFt
cF9pc192YWxpZF9pb2N0bCh1MzIgaW9jdGxfaWQpDQo+IA0KPiBJIHRoaW5rIG1vc3Qgd2hvIGNv
bWUgYWNyb3NzIHRoZSB1c2Ugb2YgdGhpcyB3b3VsZCBleHBlY3QgYW4NCj4gLippc192YWxpZCgp
IHRvIHJldHVybiB0cnVlIChub24tMCkgd2hlbiB2YWxpZCwgYW5kIDAgb3RoZXJ3aXNlLg0KPiAN
Cj4gPiArew0KPiA+ICsgICAgICAgaWYgKGlvY3RsX2lkID09IElPQ1RMX1NFVF9QTExfRlJBQ19N
T0RFIHx8DQo+ID4gKyAgICAgICAgICAgaW9jdGxfaWQgPT0gSU9DVExfR0VUX1BMTF9GUkFDX01P
REUgfHwNCj4gPiArICAgICAgICAgICBpb2N0bF9pZCA9PSBJT0NUTF9TRVRfUExMX0ZSQUNfREFU
QSB8fA0KPiA+ICsgICAgICAgICAgIGlvY3RsX2lkID09IElPQ1RMX0dFVF9QTExfRlJBQ19EQVRB
KQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gDQo+IFRoaXMgaXMgcHVyZWx5IGEg
bWF0dGVyIG9mIHRhc3RlLCBhbmQgbm8gcmVxdWlyZW1lbnQgdG8gY2hhbmdlLCBidXQgSSBmaW5k
IGENCj4gc3dpdGNoIHNsaWdodGx5IGVhc2llciB0byByZWFkIGZvciB0aGlzIGtpbmQgb2YgdXNh
Z2U6DQo+IA0KPiAgICAgICAgIHN3aXRjaChpb2N0bF9pZCkgew0KPiAgICAgICAgIGNhc2UgSU9D
VExfU0VUX1BMTF9GUkFDX01PREU6DQo+ICAgICAgICAgY2FzZSBJT0NUTF9HRVRfUExMX0ZSQUNf
TU9ERToNCj4gICAgICAgICBjYXNlIElPQ1RMX1NFVF9QTExfRlJBQ19EQVRBOg0KPiAgICAgICAg
IGNhc2UgSU9DVExfR0VUX1BMTF9GUkFDX0RBVEE6DQo+ICAgICAgICAgICAgICAgICByZXR1cm4g
MTsNCj4gICAgICAgICBkZWZhdWx0Og0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ICAg
ICAgICAgfQ0KPiANCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiArfQ0K
PiA+ICsNCj4gPiArLyoqDQo+ID4gKyAqIHp5bnFtcF9wbV9pb2N0bCgpIC0gUE0gSU9DVEwgQVBJ
IGZvciBkZXZpY2UgY29udHJvbCBhbmQgY29uZmlncw0KPiA+ICsgKiBAbm9kZV9pZDogICBOb2Rl
IElEIG9mIHRoZSBkZXZpY2UNCj4gPiArICogQGlvY3RsX2lkOiAgSUQgb2YgdGhlIHJlcXVlc3Rl
ZCBJT0NUTA0KPiA+ICsgKiBAYXJnMTogICAgICBBcmd1bWVudCAxIHRvIHJlcXVlc3RlZCBJT0NU
TCBjYWxsDQo+ID4gKyAqIEBhcmcyOiAgICAgIEFyZ3VtZW50IDIgdG8gcmVxdWVzdGVkIElPQ1RM
IGNhbGwNCj4gPiArICogQG91dDogICAgICAgUmV0dXJuZWQgb3V0cHV0IHZhbHVlDQo+ID4gKyAq
DQo+ID4gKyAqIFRoaXMgZnVuY3Rpb24gY2FsbHMgSU9DVEwgdG8gZmlybXdhcmUgZm9yIGRldmlj
ZSBjb250cm9sIGFuZCBjb25maWd1cmF0aW9uLg0KPiA+ICsgKg0KPiA+ICsgKiBSZXR1cm46IFJl
dHVybnMgc3RhdHVzLCBlaXRoZXIgc3VjY2VzcyBvciBlcnJvcityZWFzb24gICovIHN0YXRpYw0K
PiA+ICtpbnQgenlucW1wX3BtX2lvY3RsKHUzMiBub2RlX2lkLCB1MzIgaW9jdGxfaWQsIHUzMiBh
cmcxLCB1MzIgYXJnMiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICB1MzIgKm91dCkN
Cj4gPiArew0KPiA+ICsgICAgICAgaW50IHJldDsNCj4gPiArDQo+ID4gKyAgICAgICByZXQgPSB6
eW5xbXBfaXNfdmFsaWRfaW9jdGwoaW9jdGxfaWQpOw0KPiA+ICsgICAgICAgaWYgKHJldCkNCj4g
PiArICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gDQo+IFNvIHdpdGggY2hhbmdlZCByZXR1
cm4gdmFsdWVzLCB0aGlzIHdvdWxkIHR1cm4gaW50bzoNCj4gDQo+ICAgICAgICAgaWYgKCF6eW5x
bXBfaXNfdmFsaWRfaW9jdGwoaW9jdGxfaWQpKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1F
SU5WQUw7DQo+IA0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiB6eW5xbXBfcG1faW52b2tlX2Zu
KFBNX0lPQ1RMLCBub2RlX2lkLCBpb2N0bF9pZCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGFyZzEsIGFyZzIsIG91dCk7IH0NCj4gPiArDQo+ID4gIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgenlucW1wX2VlbWlfb3BzIGVlbWlfb3BzID0gew0KPiA+ICAgICAgICAgLmdldF9h
cGlfdmVyc2lvbiA9IHp5bnFtcF9wbV9nZXRfYXBpX3ZlcnNpb24sDQo+ID4gICAgICAgICAucXVl
cnlfZGF0YSA9IHp5bnFtcF9wbV9xdWVyeV9kYXRhLCBAQCAtNDQwLDYgKzQ4Miw3IEBAIHN0YXRp
Yw0KPiA+IGNvbnN0IHN0cnVjdCB6eW5xbXBfZWVtaV9vcHMgZWVtaV9vcHMgPSB7DQo+ID4gICAg
ICAgICAuY2xvY2tfZ2V0cmF0ZSA9IHp5bnFtcF9wbV9jbG9ja19nZXRyYXRlLA0KPiA+ICAgICAg
ICAgLmNsb2NrX3NldHBhcmVudCA9IHp5bnFtcF9wbV9jbG9ja19zZXRwYXJlbnQsDQo+ID4gICAg
ICAgICAuY2xvY2tfZ2V0cGFyZW50ID0genlucW1wX3BtX2Nsb2NrX2dldHBhcmVudCwNCj4gPiAr
ICAgICAgIC5pb2N0bCA9IHp5bnFtcF9wbV9pb2N0bCwNCj4gPiAgfTsNCj4gPg0KPiA+ICAvKioN
Cj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9maXJtd2FyZS94bG54LXp5bnFtcC5oDQo+
ID4gYi9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlL3hsbngtenlucW1wLmgNCj4gPiBpbmRleCAwMTVl
MTMwLi43YTlkYjA4IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvZmlybXdhcmUveGxu
eC16eW5xbXAuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvZmlybXdhcmUveGxueC16eW5xbXAu
aA0KPiA+IEBAIC0zNCw3ICszNCw4IEBADQo+ID4NCj4gPiAgZW51bSBwbV9hcGlfaWQgew0KPiA+
ICAgICAgICAgUE1fR0VUX0FQSV9WRVJTSU9OID0gMSwNCj4gPiAtICAgICAgIFBNX1FVRVJZX0RB
VEEgPSAzNSwNCj4gPiArICAgICAgIFBNX0lPQ1RMID0gMzQsDQo+ID4gKyAgICAgICBQTV9RVUVS
WV9EQVRBLA0KPiA+ICAgICAgICAgUE1fQ0xPQ0tfRU5BQkxFLA0KPiA+ICAgICAgICAgUE1fQ0xP
Q0tfRElTQUJMRSwNCj4gPiAgICAgICAgIFBNX0NMT0NLX0dFVFNUQVRFLA0KPiA+IEBAIC05OSw2
ICsxMDAsNyBAQCBzdHJ1Y3QgenlucW1wX2VlbWlfb3BzIHsNCj4gPiAgICAgICAgIGludCAoKmNs
b2NrX2dldHJhdGUpKHUzMiBjbG9ja19pZCwgdTY0ICpyYXRlKTsNCj4gPiAgICAgICAgIGludCAo
KmNsb2NrX3NldHBhcmVudCkodTMyIGNsb2NrX2lkLCB1MzIgcGFyZW50X2lkKTsNCj4gPiAgICAg
ICAgIGludCAoKmNsb2NrX2dldHBhcmVudCkodTMyIGNsb2NrX2lkLCB1MzIgKnBhcmVudF9pZCk7
DQo+ID4gKyAgICAgICBpbnQgKCppb2N0bCkodTMyIG5vZGVfaWQsIHUzMiBpb2N0bF9pZCwgdTMy
IGFyZzEsIHUzMiBhcmcyLA0KPiA+ICsgdTMyICpvdXQpOw0KPiA+ICB9Ow0KPiA+DQo+ID4gICNp
ZiBJU19SRUFDSEFCTEUoQ09ORklHX0FSQ0hfWllOUU1QKQ0KPiA+IC0tDQo+ID4gMi43LjQNCj4g
Pg0K
