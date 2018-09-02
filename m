Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9398C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 12:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515FB20837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 12:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=LenovoBeijing.onmicrosoft.com header.i=@LenovoBeijing.onmicrosoft.com header.b="Y4D4c4Yv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515FB20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lenovo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbeIBQ4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 12:56:34 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.208]:54611 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726020AbeIBQ4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 12:56:34 -0400
Received: from [67.219.247.54] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-d.us-east-1.aws.symcld.net id CB/8A-21214-35ADB8B5; Sun, 02 Sep 2018 12:40:51 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLJsWRWlGSWpSXmKPExsWS8eIhk27wre5
  og3UfFC2mT73AaHHiZiObxeVdc9gsmifeZreY8a6d0WLi898sFrcmHGNyYPfYOesuu8fiPS+Z
  POadDPTonv2PxePzJrkA1ijWzLyk/IoE1owrB7IKLilVHJ02jbGBcYZSFyMXh5DAE0aJr617m
  CGcQ4wSx5r2sYM4LAIrmCVOdp2EyvQzSRzY9YIJwrnHKPFu4RUgh5ODTUBV4ubqV6wgtojAJ0
  aJgy21XYwcHMwCVRLrl1iAhIUFMiUOrF/HAlGSJfH/TwczhG0k8efZIrAxLAIqEnPvLgKL8wr
  ESBzc8AhspBBQb+vyQ2A1nAKGErv6jjOC2IwCYhLfT60BizMLiEvcejIfzJYQEJBYsuc8M4Qt
  KvHy8T9WCFtBYv27w1C2rMSl+d2MIL9ICPQyS3TdXwTVoCvxYepUKNtX4uX1GawQRVuBHl67l
  x0ioSVx4s5KqCuCJG79/AAVz5bYMuMuC4RdJfH1+laobXISq3ofQsU3M0ucmh8PYctIPN56g3
  ECo94sJE/MAoedpsT6XfoQYUWJKd0P2WeBw0VQ4uTMJywLGFlWMZolFWWmZ5TkJmbm6BoaGOg
  aGhoBsa65iV5ilW6KXmmxbmpicYmuoV5iebFecWVuck6KXl5qySZGYOJKKeD22sG4tz39EKMk
  B5OSKK9fWWe0EF9SfkplRmJxRnxRaU5q8SFGDQ4OgSsHj8xmlGLJy89LVZLgVb3ZHS0kWJSan
  lqRlpkDTK0wpRIcPEoivBYgad7igsTc4sx0iNQpRnuOT097JjFzzFs5CUj+eT8VSN7pnjaJWQ
  hsqpQ4bzJImwBIW0ZpHtxQWC64xCgrJczLyMDAIMRTkFqUm1mCKv+KUZyDUUmY98INoCk8mXk
  lcLtfAZ3FBHQWy9UOkLNKEhFSUg2M4tV5m98xXsvMCBdqDcqY8fKX7/n5Yhcul4YGJX1W8vzY
  nblCarfxlnUJ/fu/N/rOujHVOmGasWhrieibqxdEX9Uts05+67h4hdEk9pQpUwpvSwcun1rOl
  2P0Y+MK58nbw/pKivbF377+UMzp9YTXT0ozPqoovOeeLufw/1L7xbfXryx4+u7QNyWW4oxEQy
  3mouJEACMFHTwABAAA
X-Env-Sender: hehy1@lenovo.com
X-Msg-Ref: server-36.tower-426.messagelabs.com!1535892051!1104521!1
X-Originating-IP: [104.232.225.2]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 27688 invoked from network); 2 Sep 2018 12:40:51 -0000
Received: from unknown (HELO maesmtp01.lenovo.com) (104.232.225.2)
  by server-36.tower-426.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 2 Sep 2018 12:40:51 -0000
Received: from USEXEDGE02.lenovo.com (unknown [10.62.65.5]) by maesmtp01.lenovo.com with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-SHA)
         id 1e3c_3d4e_b3f0095c_e600_41aa_81d9_54dc6752316c;
        Sun, 02 Sep 2018 12:40:45 +0000
Received: from APC01-SG2-obe.outbound.protection.outlook.com (65.55.88.243) by
 USEXEDGE02.lenovo.com (10.62.65.5) with Microsoft SMTP Server (TLS) id
 14.3.389.1; Sun, 2 Sep 2018 08:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector1-lenovo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2ySnUKzBRi4Wz3D4y3xvOZpKV1imx1OJH9filIoawM=;
 b=Y4D4c4YvQ6X2hJJwcBC66EyjDuuVwYomPxWfSmhLkYVW1EfMPm21zyoMFh1owU5AzfrSdHRyYr1rn7OmqJG2O7EmuVZ+N+WzbkXM0HFxeMvnHuRyHDufHFcLObC/x4PvOWzo2nUOPHrletsUGSMu8xgugH+MC8ysjnjWTV1LghE=
Received: from HK0PR03MB3170.apcprd03.prod.outlook.com (52.133.151.140) by
 HK0PR03MB3586.apcprd03.prod.outlook.com (52.133.214.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 12:40:20 +0000
Received: from HK0PR03MB3170.apcprd03.prod.outlook.com
 ([fe80::102a:649e:6d08:6fbc]) by HK0PR03MB3170.apcprd03.prod.outlook.com
 ([fe80::102a:649e:6d08:6fbc%2]) with mapi id 15.20.1122.009; Sun, 2 Sep 2018
 12:40:19 +0000
From:   Ocean HY1 He <hehy1@lenovo.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
        "oceanhehy@gmail.com" <oceanhehy@gmail.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: RE: [External]  Re: [PATCH] libnvdimm, region_devs: stop NDD_ALIASING
 bit test if one test pass
Thread-Topic: [External]  Re: [PATCH] libnvdimm, region_devs: stop
 NDD_ALIASING bit test if one test pass
Thread-Index: AQHUQKw4Xe+ErEooJUqLaVzaIYyoBaTc8RIQ
Date:   Sun, 2 Sep 2018 12:40:19 +0000
Message-ID: <HK0PR03MB3170B411EB9DF9740AABFAD4890D0@HK0PR03MB3170.apcprd03.prod.outlook.com>
References: <1534651288-30306-1-git-send-email-oceanhehy@gmail.com>
 <1535665860.5995.78.camel@intel.com>
In-Reply-To: <1535665860.5995.78.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [223.72.48.46]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK0PR03MB3586;20:nhPS2ZElXcCR1Hk7kL04cziMtwT5Fko+0LTT7O52Mw7mAHgXsVGp948lN/3h4/Q/R+yDHAKHIaWRaojd8kMH/YvIDbyaYw7FYvZvXqwAYRUVswF/iDjILTDR+geXWrjE7D+z9Fl/toeg/UHkEYGYNfItiWw9V949zYIN4epciJiqcOYA7SaIJXcMvjMOF6/MIye0jvtRG0Oml6Rhht9df9ldNDqKSHeyIuHB+DjRNSfzgJBpkH9Ylj/wOYstV0BKt+rh0moAsg2NS4ivJHHYrvE8UljkCmomL9skPlO8c+zYRdXMgijKQAW9Fz6EOlTlFbouSSi5njYxmNsML4RGVA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5a15c4b6-1f12-438b-36dd-08d610d13e52
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HK0PR03MB3586;
x-ms-traffictypediagnostic: HK0PR03MB3586:
x-microsoft-antispam-prvs: <HK0PR03MB358648ED289CCE54D39AC4F9890D0@HK0PR03MB3586.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(3940261145250)(9452136761055)(85827821059158)(162533806227266)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231340)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:HK0PR03MB3586;BCL:0;PCL:0;RULEID:;SRVR:HK0PR03MB3586;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(376002)(346002)(39840400004)(13464003)(199004)(189003)(33656002)(6506007)(9686003)(53546011)(99286004)(478600001)(68736007)(7696005)(76176011)(53936002)(6436002)(229853002)(26005)(55016002)(102836004)(97736004)(186003)(105586002)(39060400002)(8676002)(4326008)(106356001)(7736002)(305945005)(25786009)(6246003)(14454004)(74316002)(110136005)(54906003)(316002)(81156014)(81166006)(86362001)(3846002)(8936002)(486006)(5660300001)(2900100001)(256004)(6116002)(446003)(2201001)(2501003)(5250100002)(66066001)(11346002)(14444005)(476003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0PR03MB3586;H:HK0PR03MB3170.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: lenovo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: v6cvsyNw05loOEzKkSWqrHTzMI1NiyycPtss7oE0MnEO907sAc/RupSruHhIa3a85HWJAByXDpa3494i2yt39SCy6dPrh9S/lGBmN8dds5ye/gXDIV5rWWOuBL4Cy9/GFdOOuXMq0f0rPV4EEn/Z/oX4CA3sCDaw383vMVp5XopjymeLjB8mQtEUbavw0dKXI8ND2asdjm+VX5awoMvOqeB+dpX5ZC16oqzFZyo1ocBlXx4+kXrxK1qG4ZvYjbD5t9RoQvorR8VJ3pbmuiuL86PlMHcSp2tcXoF9LNyNcNmgWbabs+g5r6PvmvS5fHHHwVhnfpPum576HrN9yX3GnP2YkY7+KD7zJzRvE96NQrQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a15c4b6-1f12-438b-36dd-08d610d13e52
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 12:40:19.7417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB3586
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmVybWEsIFZpc2hhbCBM
IDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDMxLCAy
MDE4IDU6NTEgQU0NCj4gVG86IFdpbGxpYW1zLCBEYW4gSiA8ZGFuLmoud2lsbGlhbXNAaW50ZWwu
Y29tPjsgcm9zcy56d2lzbGVyQGxpbnV4LmludGVsLmNvbTsNCj4gb2NlYW5oZWh5QGdtYWlsLmNv
bTsgSmlhbmcsIERhdmUgPGRhdmUuamlhbmdAaW50ZWwuY29tPg0KPiBDYzogbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZzsgT2NlYW4gSFkxIEhl
DQo+IDxoZWh5MUBsZW5vdm8uY29tPg0KPiBTdWJqZWN0OiBbRXh0ZXJuYWxdIFJlOiBbUEFUQ0hd
IGxpYm52ZGltbSwgcmVnaW9uX2RldnM6IHN0b3AgTkREX0FMSUFTSU5HDQo+IGJpdCB0ZXN0IGlm
IG9uZSB0ZXN0IHBhc3MNCj4gDQo+IA0KPiBPbiBTdW4sIDIwMTgtMDgtMTkgYXQgMDA6MDEgLTA0
MDAsIE9jZWFuIEhlIHdyb3RlOg0KPiA+IEZyb206IE9jZWFuIEhlIDxoZWh5MUBsZW5vdm8uY29t
Pg0KPiA+DQo+ID4gVGhlcmUgaXMgbm8gbmVlZCB0byBmaW5pc2ggZW50aXJlIGxvb3AgdG8gZXhl
Y3V0ZSBORERfQUxJQVNJTkcgYml0DQo+ID4gdGVzdA0KPiA+IGFnYWluc3QgZXZlcnkgbnZkaW1t
LT5mbGFncy4gSW4gcHJhY3RpY2UsIGFsbCB0aGUgbmRfbWFwcGluZy0+bnZkaW1tDQo+ID4gaGF2
ZSB0aGUgc2FtZSBmbGFncy4NCj4gPg0KPiA+IEJlY2F1c2UgdGhlIGNoZWNrIG9mIGFsaWFzIGlz
ICJpZiAoYWxpYXMpIiBidXQgbm90DQo+ID4gImlmIChhbGlhcyA9PSBuZF9yZWdpb24tPm5kcl9t
YXBwaW5ncykiLCB0aGVyZSBpcyBubyBmdW5jdGlvbiBjaGFuZ2UNCj4gPiB3aGlsZQ0KPiA+IGp1
c3Qgc2F2ZSBhIGZldyBjeWNsZXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBPY2VhbiBIZSA8
aGVoeTFAbGVub3ZvLmNvbT4NCj4gPiAtLS0NCj4gPiBBIHRlc3QgdG8gY2hlY2sgaWYgYWxsIHRo
ZSBuZF9tYXBwaW5nLT5udmRpbW0gaGF2ZSB0aGUgc2FtZSBmbGFncywNCj4gPiB1c2luZw0KPiA+
IExlbm92byBUaGlua1N5c3RlbSBTUjYzMCBhbmQgNC4xOC1yYzYuDQo+ID4NCj4gPiAjIGlwbWN0
bCBzaG93IC1kaW1tDQo+ID4NCj4gPiBEaW1tSUQgIENhcGFjaXR5ICAgICAgICBIZWFsdGhTdGF0
ZSAgICAgQWN0aW9uUmVxdWlyZWQgIExvY2tTdGF0ZQ0KPiA+ICAgIEZXVmVyc2lvbg0KPiA+IDB4
MDAyMSAgMTI1LjcNCj4gPiBHaUIgICAgICAgSGVhbHRoeSAgICAgICAgIDAgICAgICAgICAgICAg
ICBEaXNhYmxlZCAgICAgICAgMDEuMDAuMDAuNDgNCj4gPiA4OA0KPiA+IDB4MDEyMSAgMTI1LjcN
Cj4gPiBHaUIgICAgICAgSGVhbHRoeSAgICAgICAgIDAgICAgICAgICAgICAgICBEaXNhYmxlZCAg
ICAgICAgMDEuMDAuMDAuNDgNCj4gPiA4OA0KPiA+IDB4MTAyMSAgMTI1LjcNCj4gPiBHaUIgICAg
ICAgSGVhbHRoeSAgICAgICAgIDAgICAgICAgICAgICAgICBEaXNhYmxlZCAgICAgICAgMDEuMDAu
MDAuNDgNCj4gPiA4OA0KPiA+IDB4MTEyMSAgMTI1LjcNCj4gPiBHaUIgICAgICAgSGVhbHRoeSAg
ICAgICAgIDAgICAgICAgICAgICAgICBEaXNhYmxlZCAgICAgICAgMDEuMDAuMDAuNDgNCj4gPiA4
OA0KPiA+DQo+ID4gIyBpcG1jdGwgY3JlYXRlIC1mIC1nb2FsIC1zb2NrZXQgMHgwIFBlcnNpc3Rl
bnRNZW1vcnlUeXBlPUFwcERpcmVjdA0KPiA+DQo+ID4gIyBpcG1jdGwgY3JlYXRlIC1mIC1nb2Fs
IC1zb2NrZXQgMHgxIFBlcnNpc3RlbnRNZW1vcnlUeXBlPUFwcERpcmVjdA0KPiA+DQo+ID4gIyBy
ZWJvb3QsIHRvIG1ha2UgZ29hbCBjb25maWd1cmF0aW9uIHRha2UgZWZmZWN0Lg0KPiA+DQo+ID4g
IyBuZGN0bCBjcmVhdGUtbmFtZXNwYWNlIC1yIHJlZ2lvbjAgLXMgMTAwbSAtdCBwbWVtIC1tIGZz
ZGF4DQo+ID4NCj4gPiAjIG5kY3RsIGNyZWF0ZS1uYW1lc3BhY2UgLXIgcmVnaW9uMSAtcyAxMDBt
IC10IHBtZW0gLW0gZnNkYXgNCj4gPg0KPiA+ICMgcmVib290IGFuZCBmaW5kIGFsbCB0aGUgbmRf
bWFwcGluZy0+bnZkaW1tIGhhdmUgdGhlIHNhbWUgZmxhZ3MuDQo+ID4NCj4gPiAgZHJpdmVycy9u
dmRpbW0vcmVnaW9uX2RldnMuYyB8IDQgKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
dmRpbW0vcmVnaW9uX2RldnMuYw0KPiA+IGIvZHJpdmVycy9udmRpbW0vcmVnaW9uX2RldnMuYw0K
PiA+IGluZGV4IGVjMzU0M2IuLmZjM2JjMWMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9udmRp
bW0vcmVnaW9uX2RldnMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbnZkaW1tL3JlZ2lvbl9kZXZzLmMN
Cj4gPiBAQCAtMjM0LDggKzIzNCwxMCBAQCBpbnQgbmRfcmVnaW9uX3RvX25zdHlwZShzdHJ1Y3Qg
bmRfcmVnaW9uDQo+ID4gKm5kX3JlZ2lvbikNCj4gPiAgCQkJc3RydWN0IG5kX21hcHBpbmcgKm5k
X21hcHBpbmcgPSAmbmRfcmVnaW9uLQ0KPiA+ID5tYXBwaW5nW2ldOw0KPiA+ICAJCQlzdHJ1Y3Qg
bnZkaW1tICpudmRpbW0gPSBuZF9tYXBwaW5nLT5udmRpbW07DQo+ID4NCj4gPiAtCQkJaWYgKHRl
c3RfYml0KE5ERF9BTElBU0lORywgJm52ZGltbS0+ZmxhZ3MpKQ0KPiA+ICsJCQlpZiAodGVzdF9i
aXQoTkREX0FMSUFTSU5HLCAmbnZkaW1tLT5mbGFncykpDQo+ID4gew0KPiA+ICAJCQkJYWxpYXMr
KzsNCj4gPiArCQkJCWJyZWFrOw0KPiANCj4gSSB0aGluayB3ZSBjYW4gZ28gYSBzdGVwIGZ1cnRo
ZXIsIGFuZCBpbnN0ZWFkIG9mIHRoZSAnYnJlYWsnIGZvbGxvd2VkDQo+IGJ5IGEgY2hlY2sgZm9y
IHRoZSAnYWxpYXMnIHZhcmlhYmxlLCBpbiB0aGUgbG9vcCwganVzdCByZXR1cm4NCj4gTkRfREVW
SUNFX05BTUVTUEFDRV9QTUVNIGlmIHRoZSBORERfQUxJQVNJTkcgYml0IGlzIGZvdW5kIGZvciBh
bnkNCj4gbWFwcGluZy4gT3V0c2lkZSB0aGUgbG9vcCwgc2ltcGx5IHJldHVybiBORF9ERVZJQ0Vf
TkFNRVNQQUNFX0lPLiBUaGF0DQo+IG1ha2VzIGl0IG11Y2ggY2xlYW5lciBhbmQgbm93IHdlIGNh
biBnZXQgcmlkIG9mICdhbGlhcycgZW50aXJlbHkuDQo+IA0KSGkgVmlzaGFsLA0KDQpUaGFua3Mg
Zm9yIGNvbW1lbnRzIGFuZCBJIHdvdWxkIHNlbmQgdmVyc2lvbiAyIHBhdGNoIGxhdGVyLg0KDQpP
Y2Vhbi4NCj4gPiArCQkJfQ0KPiA+ICAJCX0NCj4gPiAgCQlpZiAoYWxpYXMpDQo+ID4gIAkJCXJl
dHVybiBORF9ERVZJQ0VfTkFNRVNQQUNFX1BNRU07DQo=
