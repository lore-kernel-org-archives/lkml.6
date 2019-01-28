Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DE2C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647862171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="kVTx/zGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfA1W7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 17:59:33 -0500
Received: from mail-eopbgr1300125.outbound.protection.outlook.com ([40.107.130.125]:48695
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726694AbfA1W7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 17:59:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7TqUn0cj6qot7rq5oSYt87AwEbmouHizuU6Qto9T/A=;
 b=kVTx/zGs94Gt2d8gNFr6wyotcbc5GoLyVVbhYAm2HchfzpBrv96ImORcPrq6OTmth8SWYR4cBSPIFEgirni2BzgA7fAoaH/MmZd6t563G6Wq7X9YikPX0ddIp19mgAYNrkzggh5jAjOTYupur5526jkHbQ02nhFZBIhpTWV1et4=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0154.APCP153.PROD.OUTLOOK.COM (10.170.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.6; Mon, 28 Jan 2019 22:58:41 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f%9]) with mapi id 15.20.1601.007; Mon, 28 Jan 2019
 22:58:41 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Josh Poulson <jopoulso@microsoft.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>
Subject: RE: [PATCH] nfit: add Hyper-V NVDIMM DSM command set to white list
Thread-Topic: [PATCH] nfit: add Hyper-V NVDIMM DSM command set to white list
Thread-Index: AdSzXEwehYqXUZ6BQmeL43zJlZYVRgD8FF6AAADrNfAAAPKsAAACH5PQ
Date:   Mon, 28 Jan 2019 22:58:41 +0000
Message-ID: <PU1P153MB01693CEF0955362BA0AD09BCBF960@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB0169DF967C5BAAC8334FCC42BF990@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4gnpn9VBHBoSFn_2sAdvfD85wRffvfYfuurwMxXYSBAZQ@mail.gmail.com>
 <PU1P153MB0169CE6B02AE7D67E25DDD89BF960@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4hGYFuW901KZ1xCR4TucgRTkqZ=SOsLOK0MpKq0BBCokw@mail.gmail.com>
In-Reply-To: <CAPcyv4hGYFuW901KZ1xCR4TucgRTkqZ=SOsLOK0MpKq0BBCokw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-01-28T22:58:39.1053740Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=758b6cbb-ae68-4505-a938-b652923e5bd2;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:f:e868:ce4c:61e9:a83a]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0154;6:D/k9JGQMTHMp4sWw0he68tnI9vueOVeTb1duLni3jAsAi7u8/V8AP+pXlStaQR4wMXlkvtX/4dTUY1ZOZPG2T/cpqWP/7n7QBXu1hmEd1hDIsC605X9NBwOBn4MuJSRjZGG5W0rNfg91PcgDr045a6b6ns5NcweuWcLUk86ll/2WR8kllojI1XNErHOF7AOtHQnmTVYBSeJDhEYTX9MwvKLUQJmE6Sm8qj2tt/bANIlJw5xwnVdclYthQQruYgeKKCEFZsTzmM0rML7Fp4CIcZS+udzC6Az7g0LpVLJ4eIOFoh5/ItIFiyi9BweiC5rMqO50Yf0F5MQkhsqVFNnnydLf5sHQsdWs9DxipBeiRblPEsoj7IBth2cntpEqI2wQ+Ef2Er7QRYIrbbTy0yqDafF23O0yw/9OypsyZAK+e3IZ3FcbCu0Kcb4hLnjDCJCgJI1rZYgq31WVlLBH2aGneg==;5:9l0UOAZKpTV4Yv47dplePk2rBx2pvSc9FEXvchHA5bAWmAh5bMpZN/eyK9BdgSLETmy3svO4x0jSpBlyjQtF+l6Mx5rThk2K2EEwOmdOEOoC0hJccjuflBRUWYslmmsIn8NjnfJ2MHD7JjWpD4EUqU5gWYkmups8rjWt2AMtsJ+S5WrM8XGnkrr9h0d2EVc0OnEaP2cS85rYwmaL5XI6Dw==;7:U8tX25ZwIlgF9bPyfsytI4ZNXTpuoR+qaF2TcSxtF4HCYIVmW8I5LVRyGaRYYLXjrvSpVt/mjjNyrHkdWNOISAWJGI+V9VzulxAsvyMcNkUGHpDiwnHAvFbWEkfDAuA+n7vZGHxY/E4FGBsopK/vNQ==
x-ms-office365-filtering-correlation-id: 6bbfb1b8-b4c7-488b-886b-08d6857425e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0154;
x-ms-traffictypediagnostic: PU1P153MB0154:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <PU1P153MB0154865FA8E39C3819DA7CF8BF960@PU1P153MB0154.APCP153.PROD.OUTLOOK.COM>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(376002)(346002)(396003)(39860400002)(199004)(189003)(53546011)(186003)(6506007)(6116002)(446003)(46003)(486006)(99286004)(966005)(97736004)(74316002)(4326008)(76176011)(106356001)(105586002)(102836004)(68736007)(7416002)(256004)(2906002)(53936002)(86612001)(217873002)(316002)(478600001)(55016002)(25786009)(71190400001)(476003)(86362001)(93886005)(7696005)(71200400001)(11346002)(8936002)(81156014)(22452003)(54906003)(8676002)(81166006)(8990500004)(6246003)(9686003)(10090500001)(6306002)(10290500003)(33656002)(305945005)(6436002)(7736002)(229853002)(6916009)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0154;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DAnMfMqg/DuS3Wey6j98kfDkmmHcyRWUpFNVkogObESEAvOkMNofE/8LDEGTc41QQ32LD9OHUmk2qftMT/DMXbTm+8zdlRqldISrhJvCvN8LIs98l+cQg0ShP0a7vmjLV1XUq9eqeDm/qffXgPCkNUav/bUW/yiP1JVZtL5EAl6J50BDzJU4gsfMMMFd+oMMsVuwvArMRFA+mufBpQcdmB6HVWtKKkmuuv+tM2Fjz8U99X1wvWrA+H25gvccy1YGqzmzQxAPupwDGQm6xZlDIZaJJw6yCbZX7ptRqeIaikiuYoS6vwQBx95PW7/kYhVb2pgzkvtA8nNA3W9wQFYuJ6C4gVz0rSi44iTdPfdrbM14tsg7EjR5u7WioGKcYeNOOlUCJWBg4jV/R4H+wV/5K0SpXE77WfNOt3Wynhinrbk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bbfb1b8-b4c7-488b-886b-08d6857425e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 22:58:41.3214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gU2VudDog
TW9uZGF5LCBKYW51YXJ5IDI4LCAyMDE5IDE6NTUgUE0NCj4gDQo+IE9uIE1vbiwgSmFuIDI4LCAy
MDE5IGF0IDE6NDAgUE0gRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4gd3JvdGU6DQo+
IA0KPiA+IEkgbWFkZSB0aGUgYmVsb3cgc2ltcGxlIGNoYW5nZS4gSXMgdGhpcyBlbm91Z2g/IFBs
ZWFzZSBzdWdnZXN0IHRoZSBwcm9wZXINCj4gPiB3b3JkaW5nL3NlbnRlbmNlLCBhcyBJJ20gcmVs
YXRpdmVseSBuZXcgdG8gTlZESU1NLCBhbmQgSSBkb24ndCByZWFsbHkga25vdw0KPiB0aGUgaGlz
dG9yeSBvZiB0aGUgc3RhbmRhcmRpemF0aW9uIHByb2Nlc3MuDQo+IA0KPiBIb3cgYWJvdXQgc29t
ZXRoaW5nIGEgYml0IG1vcmUgcmVsZXZhbnQgZm9yIHRoZSBjb2RlIGluIHF1ZXN0aW9uOg0KPiAN
CiANCj4gVGhlcmUgYXJlIDQgImxlZ2FjeSIgTlZESU1NIGNvbW1hbmQgc2V0cw0KPiAoTlZESU1N
X0ZBTUlMWV97SU5URUwsTVNGVCxIUEUxLEhQRTJ9KSB0aGF0IHdlcmUgY3JlYXRlZCBiZWZvcmUg
YW4gRUZJDQo+IHdvcmtpbmcgZ3JvdXAgd2FzIGVzdGFibGlzaGVkIHRvIGNvbnN0cmFpbiB0aGlz
IHByb2xpZmVyYXRpb24uIFRoZQ0KPiBuZml0IGRyaXZlciBwcm9iZXMgZm9yIHRoZSBzdXBwb3J0
ZWQgY29tbWFuZCBzZXQgYnkgR1VJRC4gTm90ZSwgSWYNCj4geW91J3JlIGEgcGxhdGZvcm0gZGV2
ZWxvcGVyIGxvb2tpbmcgdG8gYWRkIGEgbmV3IGNvbW1hbmQgc2V0IHRvIHRoaXMNCj4gcHJvYmUg
Y29uc2lkZXIgdXNpbmcgYW4gZXhpc3Rpbmcgc2V0LCBvciBvdGhlcndpc2Ugc2VlayBhcHByb3Zh
bCB0bw0KPiBwdWJsaXNoIHRoZSBjb21tYW5kIHNldCBhdA0KPiBodHRwOi8vd3d3LnVlZmkub3Jn
L1JGSUNfTElTVA0KDQpMb29rcyBwZXJmZWN0ISBMZXQgbWUgdXNlIHRoaXMsIHJlYmFzZSB0aGUg
cGF0Y2ggdG8gDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC9udmRpbW0vbnZkaW1tLmdpdC90YWcvP2g9bGlibnZkaW1tLWZpeGVzLTUuMC1yYzQNCmFuZCBw
b3N0IGEgdjIgbGF0ZXIgdG9kYXkuDQoNClRoYW5rcywNCi0tIERleHVhbg0K
