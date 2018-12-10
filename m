Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2DBC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254B020870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="ebeuRIJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254B020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeLJLgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:36:19 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.67]:13954 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726146AbeLJLgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:36:19 -0500
Received: from [46.226.52.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-west-1.aws.symcld.net id 2B/04-12360-CAF4E0C5; Mon, 10 Dec 2018 11:36:12 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VSa0xTZxjmO7cekcM+C4R3jUhsskSMp1IW9CB
  ZsmUmNkt20T+arsk8hSNtVkrtKVCXmNXbJq06k2nCqlyUi44SkWZeMCgNZtlqvEUwos6NYoNR
  loibTofXcwHd/j3P+zzf877vl5cljeOMiZWCAcnvFT1mJpNyLabK+e5Psx3Fo5P5ws29SULY0
  tbDCOFYHyWceXCEEIZO7WeEg53bSCF94DzxvsHWGq+1NSdX2gaaug22vschg+3v+LzPaDvt9j
  prgmtpV9v4Psq3b0nw99R9JoQSpWGUyVK4h4RY5DFSiRHvIeBc+MA0uY2gP/4PE0azWAYL8P2
  vo4wq5OItBLT8GKJVQuIOBPHhdoPqysGroWOoWcO5eA0cmxokdLwMxnb2a5jC70DiTlTzcFiE
  0T87Gb3dDgTPoilaFWZhJ4w8u6qZEC6Ah5tipIpJnA830i1aEGAM7f2XSB3nwd3bL2jdL0Fy8
  wjS64vgwrX0NDZD50iU1nEBXGmJaHsCvs5AZPOEQRc+hvvPnzC6MISgaTJBzCSNhS9OJwnQHt
  lG6dgHY42nGR3Pg66dKUp/fIuEtq1TSjtWIXPhtzNL9fpeBh68/Fcbw4grYLLpgmE3WhT9z3Z
  R5QmJi6Dn1GK9PB/2RFKGqPZjcyD5Q5pqRVQXEpx+d5UrUC26Pby1uJi3Wkt4a9lSvqTUahG/
  4p0WqZavl+QAr9B62SJvqK7wVFq8UiCOlAur9P389CTafbBqEL3NEuY87thEpsOY7ayp3OASZ
  dcX/lqPJA+iBSyLt6e7LiMT5a3xSmbgOj7Jdhjn+KUqKbjO7VFOdsYKbJY5l9ulypzsE6tld5
  UunUPvssPnGxpJ9peGR/tJo5ZkyufWq1asWl213tdBM+d/BRWYcjiUkZFhzPJJ/mp34P/6PZT
  PInMO1/yhkpLl9gZe97unjEIoo3h+ItRRAuIbyRRCfNHZHOlwomO8PCEdXl6WUV6SfPoBOptu
  fHgU1ReV3XpvqG+49Ym/boW/9I9hu6P9rb+WhOpWtRxaPcHNj9WVfB5M2efuGCncRD/qXVmzb
  OPX33zb2zVQKNobdpW1zWbsR6bk7u+O9y4/wVdYCtc6Xg54j1/6aIX0JQ6fCG+M0XmzzZTsEq
  0LSb8svgIXlR8X+QMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-27.tower-282.messagelabs.com!1544441772!464809!1
X-Originating-IP: [104.47.4.59]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8381 invoked from network); 10 Dec 2018 11:36:12 -0000
Received: from mail-am5eur02lp2059.outbound.protection.outlook.com (HELO EUR02-AM5-obe.outbound.protection.outlook.com) (104.47.4.59)
  by server-27.tower-282.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 10 Dec 2018 11:36:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIe1jzLNmHMHIsxGQ44CbqVo3nv9EmxjHPyadqZc5VA=;
 b=ebeuRIJ8foDOmA+g0XuyowHjWZwKnnGkztm5+ClsL4NPu/dpPdiZ8mA0c+njaFk66gcHjT6nCdFBNdcekiC3KxxfRNcidEX6/Fcp/Bgeu4Ki0633A7FVsME5kFJFy57jwTfQ4iPEksO4zR0ceWABGChxLjeMXQnU9jvGBF2cFRk=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.17) by
 AM5PR1001MB0995.EURPRD10.PROD.OUTLOOK.COM (10.169.154.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Mon, 10 Dec 2018 11:36:09 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::915f:2c34:17a1:da64]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::915f:2c34:17a1:da64%8]) with mapi id 15.20.1404.023; Mon, 10 Dec 2018
 11:36:09 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Kyle Tso <kyletso@google.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "badhri@google.com" <badhri@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: typec: tcpm: Extend the matching rules on PPS APDO
 selection
Thread-Topic: [PATCH] usb: typec: tcpm: Extend the matching rules on PPS APDO
 selection
Thread-Index: AQHUjRA9iR+V8w1vUkO6AmQvwyOQdaV3soBQgAAnBDA=
Date:   Mon, 10 Dec 2018 11:36:09 +0000
Message-ID: <AM5PR1001MB099433159E3519D8F534E38F80A50@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20181206030227.9507-1-kyletso@google.com>
 <AM5PR1001MB0994F844103F31DBD373AAB880A50@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM5PR1001MB0994F844103F31DBD373AAB880A50@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR1001MB0995;6:5gkgZ9NV0k/lAA7VT0UEkQvEjOfNT/aZVPH/WNfcuCoLcRqGAYZn95dcQMOfIxhU7+3+SQG05I3yawoup8fkvSklyvj33NQqMeBSpZnJRtXofzpAgPUwjrkhNlRf8wSH5xsJzHbkIJvF+ni8IePLsUOT9Hdbsl7god2xaB0P9lieYOL2bZmooaM7CYee11l6cgPPC0fbVRXnOPak5jqHIO8YyTRhvLK43AaWvq1i380dMGJRh2NdQ3VMMiCGjziTqPm47bp7wOb3DqaM9spyv0Krspsql5+RkAIQMmNGyz3+xHe7hS+q/ziDRezabPg1QCD5vh8F4DgUqITanF87DQfY+mj4zf+UafFMcjEidmJR+7cYXgNL0P0MNrwlRjseyBhmSGIq3NqacHRyDqW4NAk2UcweZ3P12oHdtHoQsgPwMFjZXmTShz+AN3d+Srg5nFl2eXw8xsf/jokEqMCEwA==;5:saj/xSzdN112v7UtNdOS8Fi0FqVPs2WFLm8IAfLUn6xOhguZYqtzN9GdX0rAMkUytb72FZ8p7cxNRKXOmBW3K9N+GRvtIyaBnJzmTGge6S3xSSBlGweHrOZVYy+i3hwI8vxuYp//Js8BBOZULLG6zKdIpFGBxw9pk/y6f6JCr84=;7:SU1AwAiCIsEbEryuZJ4slrGkRq9YGkBnwuXF/3Xt7Wp6vU9RuCe2UyDlO+x0Zj1z8ABDKZCqyfUrGSMJbYtogVgudKIJT3T/EdT1bl3O436jVDaUyWJ3Aw6BA5NUuvChWh0OVv0AvDETHlbkhFbtKg==
x-ms-office365-filtering-correlation-id: 62bbdc99-b8f4-467c-be4e-08d65e93ae59
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR1001MB0995;
x-ms-traffictypediagnostic: AM5PR1001MB0995:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <AM5PR1001MB0995E0AA07317FF72404B27FA7A50@AM5PR1001MB0995.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231472)(944501520)(52105112)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM5PR1001MB0995;BCL:0;PCL:0;RULEID:;SRVR:AM5PR1001MB0995;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(366004)(396003)(39850400004)(51444003)(189003)(199004)(476003)(3846002)(6246003)(478600001)(2940100002)(8936002)(7696005)(186003)(55016002)(486006)(11346002)(9686003)(446003)(4326008)(6116002)(81156014)(53936002)(26005)(66066001)(229853002)(97736004)(54906003)(81166006)(8676002)(68736007)(74316002)(110136005)(99286004)(6436002)(5660300001)(33656002)(106356001)(71190400001)(53546011)(93156006)(316002)(71200400001)(76176011)(217873002)(72206003)(2501003)(2201001)(14444005)(6506007)(256004)(25786009)(102836004)(305945005)(7736002)(2906002)(14454004)(86362001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB0995;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: si8ZftJP/OrsEvPOudh2hjwQm3mBbCnPSLZDGrXNPO1fqHAqIEs0Btbn9gIotanFJeJawyznfgV2hnyHczFP0cfEfsDmpxa/OOBioHiUvAmh1XE11N5dQu39W3cvhv3ADovyDyyuXF3ASa/2/xWBA0CTej6of3KWfGszbyK7FgIBffYQCyXsKYMYL5MUN5obukoKTRRpjdWCghAVGvF1O8Bh9F9k43DevMgt1SuflA/nbCLrXQCHz7+ljByj82vdYpOC7HkdjJIl5aVvIdCg0HIVRNoWrgj2xlrAT+xo9sGoNoNwTsJkk7xwxIp+VYrj94YbsnjoH9GRFWJx8SbjE95h1q7fD1+mFsahG5tGOmo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bbdc99-b8f4-467c-be4e-08d65e93ae59
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 11:36:09.6730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB0995
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAgRGVjZW1iZXIgMjAxOCAwOTowMSwgQWRhbSBUaG9tc29uIHdyb3RlOg0KDQo+IE9uIDA2
IERlY2VtYmVyIDIwMTggMDM6MDIsIEt5bGUgVHNvIHdyb3RlOg0KPiANCj4gPiBDdXJyZW50IG1h
dGNoaW5nIHJ1bGVzIGVuc3VyZSB0aGF0IHRoZSB2b2x0YWdlIHJhbmdlIG9mIHNlbGVjdGVkDQo+
ID4gU291cmNlIENhcGFiaWxpdHkgaXMgZW50aXJlbHkgd2l0aGluIHRoZSByYW5nZSBkZWZpbmVk
IGluIG9uZSBvZiB0aGUNCj4gPiBTaW5rIENhcGFiaWxpdGllcy4gVGhpcyBpcyByZWFzb25hYmxl
IGJ1dCBub3QgcHJhY3RpY2FsIGJlY2F1c2UgU2luaw0KPiA+IG1heSBub3Qgc3VwcG9ydCB3aWRl
IHJhbmdlIG9mIHZvbHRhZ2Ugd2hlbiBzaW5raW5nIHBvd2VyIHdoaWxlIFNvdXJjZQ0KPiA+IGNv
dWxkIGFkdmVydGlzZSBpdHMgY2FwYWJpbGl0aWVzIGluIHJhbGV0aXZlbHkgd2lkZXIgcmFuZ2Uu
IEZvcg0KPiA+IGV4YW1wbGUsIGEgU291cmNlIFBETyBhZHZlcnRpc2luZyAzLjNWLTExVkAzQSAo
OVYgUHJvZyBvZiBGaXhlZA0KPiA+IE5vbWluYWwgVm9sdGFnZSkgd2lsbCBub3QgYmUgc2VsZWN0
ZWQgaWYgdGhlIFNpbmsgcmVxdWlyZXMgNVYtIDEyVkAzQQ0KPiA+IFBQUyBwb3dlci4gSG93ZXZl
ciwgdGhlIFNpbmsgY291bGQgd29yayB3ZWxsIGlmIHRoZSByZXF1ZXN0ZWQgdm9sdGFnZSByYW5n
ZSBpbg0KPiBSRE9zIGlzIDVWLTExVkAzQS4NCj4gDQo+IElzIHRoZXJlIGEgcmVhbCB3b3JsZCBl
eGFtcGxlIG9mIGEgc2luayByZXF1aXJpbmcgdGhlIDVWIC0gMTJWIHJhbmdlPyBJbiB0aGF0DQo+
IHNjZW5hcmlvIGNvdWxkIHdlIG5vdCBhZGQgYW4gYWRkaXRpb25hbCBzaW5rIGNhcGFiaWxpdHkg
d2hpY2ggYWxsb3dzIGZvciB0aGlzIHJhbmdlDQo+IHRvIGJlIHN1cHBvcnRlZCwgYW5kIHRoZSBj
dXJyZW50IGltcGxlbWVudGF0aW9uIHNob3VsZCB3b3JrIGp1c3QgZmluZT8NCg0KT2ssIEkgbWF5
YmUgc2hvdWxkIGhhdmUgd2FpdGVkIHVudGlsIGFmdGVyIG15IG1vcm5pbmcgY29mZmVlIHRvIHJl
c3BvbmQuIFNvDQpiZWNhdXNlIHRoZSBsb3dlciBsaW1pdCBvbiB0aGUgc2luayBzaWRlLCBpcyBo
aWdoZXIgdGhhbiB0aGUgYWR2ZXJ0aXNlZCBzb3VyY2Uncw0KUFBTIG1pbmltdW0gdm9sdGFnZSBp
dCBuZXZlciBnZXRzIHNlbGVjdGVkPyBQZXJzb25hbGx5IEknZCBwcmVmZXIgdG8ga2VlcCB0aGUN
CnVwcGVyIGxpbWl0IGNoZWNraW5nIGFzIGlzIGFzIEkgdGhpbmsgdGhhdCdzIGFuIGFkZGl0aW9u
YWwgc2FmZXR5IGJlbmVmaXQNCmhlbHBpbmcgdG8gcHJldmVudCBvdmVyLXZvbHRhZ2Ugc2NlbmFy
aW9zLiBJIHRoaW5rIGlmIGEgUFBTIEFQRE8gY2FuIHN1cHBseSB1cA0KdG8gMTFWIHRoZW4gdGhl
IHN5c3RlbSBzaG91bGQgYmUgY2FwYWJsZSBvZiBoYW5kbGluZyB0aGF0IHZvbHRhZ2UsIG90aGVy
d2lzZQ0KaXQgc2hvdWxkbid0IGJlIGNvbnNpZGVyZWQgYXQgYWxsLiBUaGUgU291cmNlIHByb3Zp
ZGVzIGxpbWl0cyBjaGVja2luZyBhcyB3ZWxsDQp0byBtYWtlIHN1cmUgdGhlIFNpbmsgZG9lc24n
dCByZXF1ZXN0IGEgdmFsdWUgYWJvdmUgdGhlIG1heGltdW0gdm9sdGFnZSBsaW1pdA0KZm9yIHRo
YXQgc2VsZWN0ZWQgQVBETy4NCg0KRm9yIHRoZSBsb3dlciBsaW1pdCBJJ20gbW9yZSBpbmNsaW5l
ZCB0byBhZ3JlZSB3aXRoIGFsbG93aW5nIGEgaGlnaGVyIG1pbmltdW0NCm9uIHRoZSBzaW5rIHNp
ZGUgYXMgdGhhdCdzIGxlc3Mgb2YgYSBzYWZldHkvZGFtYWdlIGlzc3VlIGFzIEkgdW5kZXJzdGFu
ZCBpdC4NCkZXSVcsIHdoYXQgaXMgdGhlIHJlYWwgd29ybGQgc2NlbmFyaW8/IFdoYXQgaGFwcGVu
cyBpZiB2b2x0YWdlIGRyb3BzIGJlbG93IDVWPw0KDQo+IA0KPiA+DQo+ID4gVG8gaW1wcm92ZSB0
aGUgdXNhYmlsaXR5LCBjaGFuZ2UgdGhlIG1hdGNoaW5nIHJ1bGVzIHRvIHdoYXQgbGlzdGVkDQo+
ID4gYmVsb3c6DQo+ID4gYS4gVGhlIFNvdXJjZSBQRE8gaXMgc2VsZWN0YWJsZSBpZiBhbnkgcG9y
dGlvbiBvZiB0aGUgdm9sdGFnZSByYW5nZQ0KPiA+ICAgIG92ZXJsYXBzIG9uZSBvZiB0aGUgU2lu
ayBQRE8ncyB2b2x0YWdlIHJhbmdlLg0KPiA+IGIuIFRoZSBtYXhpbXVtIG9wZXJhdGlvbmFsIHZv
bHRhZ2Ugd2lsbCBiZSB0aGUgbG93ZXIgb25lIGJldHdlZW4gdGhlDQo+ID4gICAgc2VsZWN0ZWQg
U291cmNlIFBETyBhbmQgdGhlIG1hdGNoaW5nIFNpbmsgUERPLg0KPiA+IGMuIFRoZSBtYXhpbXVt
IHBvd2VyIHdpbGwgYmUgdGhlIG1heGltdW0gb3BlcmF0aW9uYWwgdm9sdGFnZSB0aW1lcyB0aGUN
Cj4gPiAgICBtYXhpbXVtIGN1cnJlbnQgZGVmaW5lZCBpbiB0aGUgc2VsZWN0ZWQgU291cmNlIFBE
TyBkLiBTZWxlY3QgdGhlDQo+ID4gU291cmNlIFBETyB3aXRoIHRoZSBoaWdoZXN0IG1heGltdW0g
cG93ZXINCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEt5bGUgVHNvIDxreWxldHNvQGdvb2dsZS5j
b20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvdXNiL3R5cGVjL3RjcG0vdGNwbS5jIHwgMjkgKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2Vy
dGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dXNiL3R5cGVjL3RjcG0vdGNwbS5jDQo+ID4gYi9kcml2ZXJzL3VzYi90eXBlYy90Y3BtL3RjcG0u
YyBpbmRleCAzNjIwZWZlZTI2ODguLjMwMDFkZjdiZDYwMg0KPiA+IDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvdXNiL3R5cGVjL3RjcG0vdGNwbS5jDQo+ID4gKysrIGIvZHJpdmVycy91c2IvdHlw
ZWMvdGNwbS90Y3BtLmMNCj4gPiBAQCAtMjIxMyw3ICsyMjEzLDggQEAgc3RhdGljIHVuc2lnbmVk
IGludA0KPiA+IHRjcG1fcGRfc2VsZWN0X3Bwc19hcGRvKHN0cnVjdCB0Y3BtX3BvcnQgKnBvcnQp
DQo+ID4gIAl1bnNpZ25lZCBpbnQgaSwgaiwgbWF4X213ID0gMCwgbWF4X212ID0gMDsNCj4gPiAg
CXVuc2lnbmVkIGludCBtaW5fc3JjX212LCBtYXhfc3JjX212LCBzcmNfbWEsIHNyY19tdzsNCj4g
PiAgCXVuc2lnbmVkIGludCBtaW5fc25rX212LCBtYXhfc25rX212Ow0KPiA+IC0JdTMyIHBkbzsN
Cj4gPiArCXVuc2lnbmVkIGludCBtYXhfb3BfbXY7DQo+ID4gKwl1MzIgcGRvLCBzcmMsIHNuazsN
Cj4gPiAgCXVuc2lnbmVkIGludCBzcmNfcGRvID0gMCwgc25rX3BkbyA9IDA7DQo+ID4NCj4gPiAg
CS8qDQo+ID4gQEAgLTIyNjMsMTYgKzIyNjQsMTggQEAgc3RhdGljIHVuc2lnbmVkIGludA0KPiA+
IHRjcG1fcGRfc2VsZWN0X3Bwc19hcGRvKHN0cnVjdCB0Y3BtX3BvcnQgKnBvcnQpDQo+ID4gIAkJ
CQkJY29udGludWU7DQo+ID4gIAkJCQl9DQo+ID4NCj4gPiAtCQkJCWlmIChtYXhfc3JjX212IDw9
IG1heF9zbmtfbXYgJiYNCj4gPiAtCQkJCSAgICBtaW5fc3JjX212ID49IG1pbl9zbmtfbXYpIHsN
Cj4gPiArCQkJCWlmIChtaW5fc3JjX212IDw9IG1heF9zbmtfbXYgJiYNCj4gPiArCQkJCSAgICBt
YXhfc3JjX212ID49IG1pbl9zbmtfbXYpIHsNCj4gPiArCQkJCQltYXhfb3BfbXYgPSBtaW4obWF4
X3NyY19tdiwNCj4gPiBtYXhfc25rX212KTsNCj4gPiArCQkJCQlzcmNfbXcgPSAobWF4X29wX212
ICogc3JjX21hKSAvIDEwMDA7DQo+ID4gIAkJCQkJLyogUHJlZmVyIGhpZ2hlciB2b2x0YWdlcyBp
ZiBhdmFpbGFibGUgKi8NCj4gPiAgCQkJCQlpZiAoKHNyY19tdyA9PSBtYXhfbXcgJiYNCj4gPiAt
CQkJCQkgICAgIG1pbl9zcmNfbXYgPiBtYXhfbXYpIHx8DQo+ID4gKwkJCQkJICAgICBtYXhfb3Bf
bXYgPiBtYXhfbXYpIHx8DQo+ID4gIAkJCQkJICAgIHNyY19tdyA+IG1heF9tdykgew0KPiA+ICAJ
CQkJCQlzcmNfcGRvID0gaTsNCj4gPiAgCQkJCQkJc25rX3BkbyA9IGo7DQo+ID4gIAkJCQkJCW1h
eF9tdyA9IHNyY19tdzsNCj4gPiAtCQkJCQkJbWF4X212ID0gbWF4X3NyY19tdjsNCj4gPiArCQkJ
CQkJbWF4X212ID0gbWF4X29wX212Ow0KPiA+ICAJCQkJCX0NCj4gPiAgCQkJCX0NCj4gPiAgCQkJ
fQ0KPiA+IEBAIC0yMjg1LDE0ICsyMjg4LDE2IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQNCj4gPiB0
Y3BtX3BkX3NlbGVjdF9wcHNfYXBkbyhzdHJ1Y3QgdGNwbV9wb3J0ICpwb3J0KQ0KPiA+ICAJfQ0K
PiA+DQo+ID4gIAlpZiAoc3JjX3Bkbykgew0KPiA+IC0JCXBkbyA9IHBvcnQtPnNvdXJjZV9jYXBz
W3NyY19wZG9dOw0KPiA+IC0NCj4gPiAtCQlwb3J0LT5wcHNfZGF0YS5taW5fdm9sdCA9IHBkb19w
cHNfYXBkb19taW5fdm9sdGFnZShwZG8pOw0KPiA+IC0JCXBvcnQtPnBwc19kYXRhLm1heF92b2x0
ID0gcGRvX3Bwc19hcGRvX21heF92b2x0YWdlKHBkbyk7DQo+ID4gLQkJcG9ydC0+cHBzX2RhdGEu
bWF4X2N1cnIgPQ0KPiA+IC0JCQltaW5fcHBzX2FwZG9fY3VycmVudChwZG8sIHBvcnQtPnNua19w
ZG9bc25rX3Bkb10pOw0KPiA+ICsJCXNyYyA9IHBvcnQtPnNvdXJjZV9jYXBzW3NyY19wZG9dOw0K
PiA+ICsJCXNuayA9IHBvcnQtPnNua19wZG9bc25rX3Bkb107DQo+ID4gKw0KPiA+ICsJCXBvcnQt
PnBwc19kYXRhLm1pbl92b2x0ID0NCj4gPiBtYXgocGRvX3Bwc19hcGRvX21pbl92b2x0YWdlKHNy
YyksDQo+ID4gKwkJCQkJICAgICAgcGRvX3Bwc19hcGRvX21pbl92b2x0YWdlKHNuaykpOw0KPiA+
ICsJCXBvcnQtPnBwc19kYXRhLm1heF92b2x0ID0NCj4gPiBtaW4ocGRvX3Bwc19hcGRvX21heF92
b2x0YWdlKHNyYyksDQo+ID4gKwkJCQkJICAgICAgcGRvX3Bwc19hcGRvX21heF92b2x0YWdlKHNu
aykpOw0KPiA+ICsJCXBvcnQtPnBwc19kYXRhLm1heF9jdXJyID0gbWluX3Bwc19hcGRvX2N1cnJl
bnQoc3JjLCBzbmspOw0KPiA+ICAJCXBvcnQtPnBwc19kYXRhLm91dF92b2x0ID0NCj4gPiAtCQkJ
bWluKHBkb19wcHNfYXBkb19tYXhfdm9sdGFnZShwZG8pLCBwb3J0LQ0KPiA+ID5wcHNfZGF0YS5v
dXRfdm9sdCk7DQo+ID4gKwkJCW1pbihwb3J0LT5wcHNfZGF0YS5tYXhfdm9sdCwgcG9ydC0NCj4g
PiA+cHBzX2RhdGEub3V0X3ZvbHQpOw0KPiA+ICAJCXBvcnQtPnBwc19kYXRhLm9wX2N1cnIgPQ0K
PiA+ICAJCQltaW4ocG9ydC0+cHBzX2RhdGEubWF4X2N1cnIsIHBvcnQtPnBwc19kYXRhLm9wX2N1
cnIpOw0KPiA+ICAJfQ0KPiA+IC0tDQo+ID4gMi4yMC4wLnJjMi40MDMuZ2RiYzNiMjk4MDUtZ29v
Zw0KPg0K
