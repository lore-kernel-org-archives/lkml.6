Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C60C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3858A2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="4raGPaF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3858A2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbeIKAOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 20:14:44 -0400
Received: from mail-eopbgr680087.outbound.protection.outlook.com ([40.107.68.87]:62784
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727607AbeIKAOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 20:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgSMlIMVVodBKXkKruoKcsYParrX1sz06zxVSQcmdoE=;
 b=4raGPaF9wJSf1crP1rjH5IXnZEwyHiwL94nU9qe+1vbGJmupS7R9ShCmlfYg1+g/QB/LEY0PttDe4Y11Twm1PSMLbJ0uChfh11zxK6imX0hK4vu63U4v9GbtvOK3msYDh+yNkc5n2tC8/9VEWbAaeF8Yem7s7BcVH28zr8Sp+/E=
Received: from CY1PR02MB2138.namprd02.prod.outlook.com (10.166.190.144) by
 CY1PR02MB1119.namprd02.prod.outlook.com (10.163.15.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Mon, 10 Sep 2018 19:19:01 +0000
Received: from CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::d401:dced:c223:a99a]) by CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::d401:dced:c223:a99a%4]) with mapi id 15.20.1122.019; Mon, 10 Sep 2018
 19:19:00 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Olof Johansson <olof@lixom.net>
CC:     "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michal Simek <michals@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Subject: RE: [PATCH v11 08/11] firmware: xilinx: Add debugfs for query data
 API
Thread-Topic: [PATCH v11 08/11] firmware: xilinx: Add debugfs for query data
 API
Thread-Index: AQHUK1L5qIHiD+7Sx0y2fKG4m0GUmKTnXnWAgALA2yA=
Date:   Mon, 10 Sep 2018 19:19:00 +0000
Message-ID: <CY1PR02MB21386F9699EC6FA4CD344497B8050@CY1PR02MB2138.namprd02.prod.outlook.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
 <1533318808-10781-9-git-send-email-jollys@xilinx.com>
 <CAOesGMjMcznFAQj0L-=J5+gJ5ENsdejqP2SdYomu=C9bJqG+YQ@mail.gmail.com>
In-Reply-To: <CAOesGMjMcznFAQj0L-=J5+gJ5ENsdejqP2SdYomu=C9bJqG+YQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR02MB1119;6:YlbdWc3YhV6Xft0TRf3CgO5A9yYKiuSVifF9ff/vt9dyXVa4c6F7UHjrDn5+WHiHLFCxvUfNbcZgyEMEMZGRGoyjngl1fp3YiOIYodY/PSVosy3e8y40kXi6lrBOyUynkhAf+BSaASRQ+qR3g31t84MvpipeUx48MmxBNkjSkIBZQMkvvbHeI40NeLmJ0m9AQgbQpwLvJnBte1i9+wYDnQHTKPBqW+SjjCoAzTWJfPixdzuAK4b+kx6sB0alFhbNKglAuJVmSlGg9zMxknZpQkJhTpL2VmjPhpRsF2vIGYPG9PVCKEPJ7tIA//ioRGhS52HoaPjgxJHqvtoVbX9T3V3Ej51b2iD3tebbT2YG2dpuB1a5SP1Ut0ecUVt+kv3LXRvOZ2QL0ldydcZM1/sq2fb/0GhSIoF3UIzepr+fA5HWJutWgaaHwZ6jTC1A6pDnbhCSGjTZou/ghku4LPt+AQ==;5:K7AcMxdYW8krRm2hZ3VhLz99W7oy4DCrNaMbTBJ9x6mXK6auJvXtWd1FTPQ+CGrdtcDtT8J2QE+SF13y6XFbHmWAlxoI6P2QLDv3M4/DbZ1QuNKEpVBC4x6MakuLmQhsHFvBPHz7xnwU+LQHfe3JM8GeWvqJSaDbttKqqLgg5UI=;7:A3Z2y/EqfLhOeBYunFrfa+Yw2T4R4Q757ZQNvkSvI+rklGTn/pVz3LdPHv/hm4L19VAoFLbZdrMW6OZQP7dtbUhwRDFgLjAfmetzdJP7ts71Z5z550FFdQ/T5h56knOyBp0flzFzza50MQjfohRajIlWLwyZp/txZm/1wJcDyB5oWUkDaEmnZx+S+U904Rbj5uLfwpErZ45oQrC4GZuLWXdHZsJukOzOhY/S4Ircv+7+dceyEsIl8p+n/Polszio
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(346002)(39860400002)(366004)(13464003)(199004)(189003)(476003)(72206003)(229853002)(66066001)(9686003)(39060400002)(11346002)(26005)(446003)(6436002)(97736004)(55016002)(478600001)(6916009)(256004)(14444005)(4326008)(86362001)(5660300001)(25786009)(6246003)(7416002)(5250100002)(14454004)(81166006)(53936002)(76176011)(81156014)(316002)(2900100001)(74316002)(8676002)(53546011)(6506007)(33656002)(305945005)(8936002)(486006)(99286004)(105586002)(106356001)(7696005)(102836004)(68736007)(2906002)(186003)(3846002)(6116002)(7736002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1119;H:CY1PR02MB2138.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: af7a3926-a854-4e04-0b31-08d617524364
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR02MB1119;
x-ms-traffictypediagnostic: CY1PR02MB1119:
x-microsoft-antispam-prvs: <CY1PR02MB11199C66B4333AC8044A0276B8050@CY1PR02MB1119.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:CY1PR02MB1119;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1119;
x-forefront-prvs: 07915F544A
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0vnJHJpdfVDVwW4mKX5WvLJd5NjbkEvVohGt98LBW1iKVtMXO/bU55NKH05tvS4augJnoKB8P7d3m7re9ptxJUqhNVSkItLjlaBHcsFfsv6SMP6YKGgKKbF4R/vG8lt+LeaL7Ku0eJBgxJrYONlj7txWVzwhHHQn+UXfVHBAjQiOa4iXlNisNgmyXh7jN1OeAO9XQ4+3Pb7Qf7BlJgcLg0+zn1uOz2ixH7a3KF1kcS27qqCRkIP/3EhOlrUvjmmIAaOBctCKzGVbqdcWOwz6Z/Lzdbg0rdFGQcMBhVuxqe6LFvn2c2z5NMMKwi3IDE5elSlIIvRmXs92iOGgFVlIgQyOfKJfVrn3iOWPYXSOz+E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7a3926-a854-4e04-0b31-08d617524364
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 19:19:00.3797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgT2xvZiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBPbG9mIEpv
aGFuc3NvbiBbbWFpbHRvOm9sb2ZAbGl4b20ubmV0XQ0KPiBTZW50OiBTYXR1cmRheSwgU2VwdGVt
YmVyIDA4LCAyMDE4IDY6MTUgUE0NCj4gVG86IEpvbGx5IFNoYWggPEpPTExZU0B4aWxpbnguY29t
Pg0KPiBDYzogYXJkLmJpZXNoZXV2ZWxAbGluYXJvLm9yZzsgSW5nbyBNb2xuYXIgPG1pbmdvQGtl
cm5lbC5vcmc+OyBHcmVnIEtyb2FoLQ0KPiBIYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZz47IG1hdHRAY29kZWJsdWVwcmludC5jby51azsgU3VkZWVwDQo+IEhvbGxhIDxzdWRlZXAu
aG9sbGFAYXJtLmNvbT47IGhrYWxsd2VpdDFAZ21haWwuY29tOyBLZWVzIENvb2sNCj4gPGtlZXNj
b29rQGNocm9taXVtLm9yZz47IERtaXRyeSBUb3Jva2hvdiA8ZG1pdHJ5LnRvcm9raG92QGdtYWls
LmNvbT47DQo+IE1pY2hhZWwgVHVycXVldHRlIDxtdHVycXVldHRlQGJheWxpYnJlLmNvbT47IFN0
ZXBoZW4gQm95ZA0KPiA8c2JveWRAY29kZWF1cm9yYS5vcmc+OyBNaWNoYWwgU2ltZWsgPG1pY2hh
bHNAeGlsaW54LmNvbT47IFJvYiBIZXJyaW5nDQo+IDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBNYXJr
IFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsgbGludXgtY2xrDQo+IDxsaW51eC1jbGtA
dmdlci5rZXJuZWwub3JnPjsgUmFqYW4gVmFqYSA8UkFKQU5WQHhpbGlueC5jb20+OyBMaW51eCBB
Uk0NCj4gTWFpbGluZyBMaXN0IDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+
OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0DQo+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnPjsgRFRNTCA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBKb2xseQ0KPiBTaGFoIDxK
T0xMWVNAeGlsaW54LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTEgMDgvMTFdIGZpcm13
YXJlOiB4aWxpbng6IEFkZCBkZWJ1Z2ZzIGZvciBxdWVyeSBkYXRhIEFQSQ0KPiANCj4gSGksDQo+
IA0KPiBJIG5vdGljZWQgdGhlIGJlbG93IHdoZW4gSSB3YXMgcmV2aWV3aW5nIHRoZSBjb2RlIGZv
ciBtZXJnZSBpbnRvIGFybS1zb2MuDQo+IFdvdWxkIHlvdSBtaW5kIGZvbGxvd2luZyB1cCB3aXRo
IGFuIGluY3JlbWVudGFsIHBhdGNoPyBJIGRvbid0IHRoaW5rIHdlIG5lZWQNCj4gdG8gYXNrIE1p
Y2hhbCB0byByZXNwaW4gZm9yIHRoaXM6DQo+IA0KDQpTdXJlLiBJIHdpbGwgc3VibWl0IGluY3Jl
bWVudGFsIHBhdGNoZXMgZm9yIHN1Z2dlc3RlZCBjaGFuZ2VzLg0KDQpUaGFua3MsDQpKb2xseSBT
aGFoDQoNCg0KPiBPbiBGcmksIEF1ZyAzLCAyMDE4IGF0IDEwOjUzIEFNLCBKb2xseSBTaGFoIDxq
b2xseS5zaGFoQHhpbGlueC5jb20+IHdyb3RlOg0KPiA+IEZyb206IFJhamFuIFZhamEgPHJhamFu
dkB4aWxpbnguY29tPg0KPiA+DQo+ID4gQWRkIGRlYnVnZnMgZmlsZSB0byBxdWVyeSBwbGF0Zm9y
bSBzcGVjaWZpYyBkYXRhIGZyb20gZmlybXdhcmUgdXNpbmcNCj4gPiBkZWJ1Z2ZzIGludGVyZmFj
ZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJhamFuIFZhamEgPHJhamFudkB4aWxpbnguY29t
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvbGx5IFNoYWggPGpvbGx5c0B4aWxpbnguY29tPg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL2Zpcm13YXJlL3hpbGlueC96eW5xbXAtZGVidWcuYyB8IDI3DQo+
ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyNyBp
bnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS94aWxp
bngvenlucW1wLWRlYnVnLmMNCj4gPiBiL2RyaXZlcnMvZmlybXdhcmUveGlsaW54L3p5bnFtcC1k
ZWJ1Zy5jDQo+ID4gaW5kZXggZmMxMWRiOS4uNDUzMmJkMCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL2Zpcm13YXJlL3hpbGlueC96eW5xbXAtZGVidWcuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZmly
bXdhcmUveGlsaW54L3p5bnFtcC1kZWJ1Zy5jDQo+ID4gQEAgLTMzLDYgKzMzLDcgQEAgc3RhdGlj
IGNoYXIgZGVidWdmc19idWZbUEFHRV9TSVpFXTsgIHN0YXRpYyBzdHJ1Y3QNCj4gPiBwbV9hcGlf
aW5mbyBwbV9hcGlfbGlzdFtdID0gew0KPiA+ICAgICAgICAgUE1fQVBJKFBNX0dFVF9BUElfVkVS
U0lPTiksDQo+ID4gICAgICAgICBQTV9BUEkoUE1fSU9DVEwpLA0KPiA+ICsgICAgICAgUE1fQVBJ
KFBNX1FVRVJZX0RBVEEpLA0KPiA+ICB9Ow0KPiA+DQo+ID4gIC8qKg0KPiA+IEBAIC0xMDUsNiAr
MTA2LDMyIEBAIHN0YXRpYyBpbnQgcHJvY2Vzc19hcGlfcmVxdWVzdCh1MzIgcG1faWQsIHU2NA0K
PiAqcG1fYXBpX2FyZywgdTMyICpwbV9hcGlfcmV0KQ0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgIHNwcmludGYoZGVidWdmc19idWYsICJJT0NUTCByZXR1cm4gdmFsdWU6ICV1XG4iLA0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcG1fYXBpX3JldFsxXSk7DQo+ID4gICAg
ICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICsgICAgICAgY2FzZSBQTV9RVUVSWV9EQVRBOg0KPiA+
ICsgICAgICAgew0KPiA+ICsgICAgICAgICAgICAgICBzdHJ1Y3QgenlucW1wX3BtX3F1ZXJ5X2Rh
dGEgcWRhdGEgPSB7MH07DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICBxZGF0YS5xaWQgPSBw
bV9hcGlfYXJnWzBdOw0KPiA+ICsgICAgICAgICAgICAgICBxZGF0YS5hcmcxID0gcG1fYXBpX2Fy
Z1sxXTsNCj4gPiArICAgICAgICAgICAgICAgcWRhdGEuYXJnMiA9IHBtX2FwaV9hcmdbMl07DQo+
ID4gKyAgICAgICAgICAgICAgIHFkYXRhLmFyZzMgPSBwbV9hcGlfYXJnWzNdOw0KPiANCj4gVGhp
cyBpcyB1c3VhbGx5IGEgcGF0dGVybiB3ZSB0cnkgdG8gYXZvaWQgKGhhdmluZyBmdWxsIGNvZGUg
YmxvY2tzIGluIGEgc3dpdGNoDQo+IHN0YXRlbWVudCwgYW5kIGxvY2FsIHZhcmlhYmxlcykuDQo+
IA0KPiBQbGVhc2UgbW92ZSB0aGUgZGVjbGFyYXRpb24gb2YgcWRhdGEgdG8gdGhlIHRvcCBvZiB0
aGUgZnVuY3Rpb24gc28geW91IGNhbiBkcm9wDQo+IHRoZSBicmFjZXMuDQo+IA0KPiA+ICsNCj4g
PiArICAgICAgICAgICAgICAgcmV0ID0gZWVtaV9vcHMtPnF1ZXJ5X2RhdGEocWRhdGEsIHBtX2Fw
aV9yZXQpOw0KPiA+ICsgICAgICAgICAgICAgICBpZiAocmV0KQ0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGJyZWFrOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgaWYgKHFkYXRhLnFp
ZCA9PSBQTV9RSURfQ0xPQ0tfR0VUX05BTUUpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
c3ByaW50ZihkZWJ1Z2ZzX2J1ZiwgIkNsb2NrIG5hbWUgPSAlc1xuIiwNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIChjaGFyICopcG1fYXBpX3JldCk7DQo+ID4gKyAgICAgICAg
ICAgICAgIGVsc2UgaWYgKHFkYXRhLnFpZCA9PSBQTV9RSURfQ0xPQ0tfR0VUX0ZJWEVERkFDVE9S
X1BBUkFNUykNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBzcHJpbnRmKGRlYnVnZnNfYnVm
LCAiTXVsdGlwbGllciA9ICVkLCBEaXZpZGVyID0gJWRcbiIsDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBwbV9hcGlfcmV0WzFdLCBwbV9hcGlfcmV0WzJdKTsNCj4gPiArICAg
ICAgICAgICAgICAgZWxzZQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHNwcmludGYoZGVi
dWdmc19idWYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiZGF0YVswXSA9
IDB4JTA4eFxuZGF0YVsxXSA9IDB4JTA4eFxuIGRhdGFbMl0gPQ0KPiAweCUwOHhcbmRhdGFbM10g
PSAweCUwOHhcbiIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwbV9hcGlf
cmV0WzBdLCBwbV9hcGlfcmV0WzFdLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcG1fYXBpX3JldFsyXSwgcG1fYXBpX3JldFszXSk7DQo+IA0KPiBJZiB5b3UgYW50aWNpcGF0
ZSBtb3JlIHFpZHMgaGVyZSBsYXRlciwgYSBzd2l0Y2ggY291bGQgYmUgbmljZXIgdGhhbiBhIHNl
cXVlbmNlIG9mDQo+IGlmL2Vsc2UuDQo+IA0KPiANCj4gDQo+IC1PbG9mDQo=
