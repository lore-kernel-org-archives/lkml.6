Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31579C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54702086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54702086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeLLKPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:15:46 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.3]:14705 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726681AbeLLKPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:15:45 -0500
Received: from [46.226.52.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-west-1.aws.symcld.net id 0D/E4-12385-8CFD01C5; Wed, 12 Dec 2018 10:15:36 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VSWUwTURTlzUzbARnzKBquFUxsYgjGFiofjPu
  WmPphosagERIcYOw0aUvtTEPxR1BJBCKgFoJIQRQB0QAhuFVx4UMtqRqRKIgLSo1r4h6XGOO0
  g6gfLznvnHPPve/l0qR2WK2jeY/EuxycTa+OoYRUKsNw4wnOTut4pWNHawIEu/tYl5otP3meY
  i996CTYu/4GNXu0tZRkQ81BYrnGfKTHbW4MrDdf9p3SmM9/LdaYP/XMWqfaorI6cgs8W1VC18
  gzlXMg2VPXvB8Vo73J5SiGpnAXCZ1DLWT4osU1BPiGPyLlEkLwre+5phxF02rMwsEbY+ownoY
  z4VftGBU2kfgeAc8eV5NhIR5vguN3GzWKaTOc/tFPKHg1VP70RngKz4ETI8cifgZz0B1sUind
  2gloaNsXMUXjDXDxsJcKY4ST4HPJyUgBiRPgQagpEgoYQ8vF26SCp8Or8V8qxc9DYNcwUvh5c
  PN+SMa0jGdD5fgihU6CwaaKyCsBj6iht2psInMt1A5Uk4rwEEFw1xtqMqjh8kQoCy0VpRO8E0
  53fJoongUd+55SSvEjEl7UNVJK50So6ixU+K8quPXhXeQftTgP3vtuaqrRvPp/Hlcvl5A4Bbr
  8qQo9G7wVTzX1kQ+Lg8ChEHUEUR2IzXVZLYJk56w2gyktzWAyzTeYFsiHzTByOwyckXcbCnlR
  MpiMXKFoFIvsebZ8o4OXepC8X/nOKxfOoXflln40gyb005mh4zhbOzW3IL9I4EQhx+W28WI/S
  qRpPTAp8h5q41y8hfdss9rkJf0jAx2rn8b4H8syIzo5u2i1KNIASqeHgmV1JH297EsDqaUcBQ
  5el8A8CVtx2Cq4HZNBfxZ+ECXp4hkUFRWljXXyLrtV+l9/jRJopI9nSkbllFirQ5rs91oehZB
  HsfUS4VEk7q+kK0Y93jZLfuhlTV1t8iphbjc2Txlc0b9xaXDJ7WuJZSvde4pLv7NFu9OvnlnW
  LIzuKMkY/5J+b3zmWW/W/BUe3Zlh3u572VYifmuP92SdSpnJGPu8MaRpTfalvAM776gXR/t9C
  xf27WznDEcbA6mZeTlTLYtz3rRulw687R31J3ZHSXpKFDjTXNIlcr8BpIeXO+sDAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-26.tower-262.messagelabs.com!1544609736!42793!1
X-Originating-IP: [104.47.4.55]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20129 invoked from network); 12 Dec 2018 10:15:36 -0000
Received: from mail-am5eur02lp2055.outbound.protection.outlook.com (HELO EUR02-AM5-obe.outbound.protection.outlook.com) (104.47.4.55)
  by server-26.tower-262.messagelabs.com with AES256-SHA256 encrypted SMTP; 12 Dec 2018 10:15:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieuFSNiqLmmti6hINTEM2b2e0a8+X5WCFNDPfsBCZn8=;
 b=CDFY97RPulhA79T7GRpBorpgpXh1HVfWtob9UT3fml4iehgp0ITEpr1fnBTADHtMf/KY88xMtEHyajOELeTcPjvH08XCDyRuMidvhEBv6RddLUXkrGp0Ir3n/mL560b4h6aZbrROuzbnHlnODdv3rtEkZhMQXGAXeTXQ1pYp/BQ=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.17) by
 AM5PR1001MB1187.EURPRD10.PROD.OUTLOOK.COM (10.169.155.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Wed, 12 Dec 2018 10:15:33 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::915f:2c34:17a1:da64]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::915f:2c34:17a1:da64%10]) with mapi id 15.20.1425.016; Wed, 12 Dec
 2018 10:15:33 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Kyle Tso <kyletso@google.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: typec: tcpm: Extend the matching rules on PPS APDO
 selection
Thread-Topic: [PATCH] usb: typec: tcpm: Extend the matching rules on PPS APDO
 selection
Thread-Index: AQHUjRA9iR+V8w1vUkO6AmQvwyOQdaV3soBQgAAnBDCAApY3gIAAcAxQ
Date:   Wed, 12 Dec 2018 10:15:32 +0000
Message-ID: <AM5PR1001MB099418665806CE9FF06D138780A70@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20181206030227.9507-1-kyletso@google.com>
 <AM5PR1001MB0994F844103F31DBD373AAB880A50@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <AM5PR1001MB099433159E3519D8F534E38F80A50@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <CAGZ6i=3+8OOafaY8B5qRkDg1pzpTu0XRw-GAenubY74DM=85Pw@mail.gmail.com>
In-Reply-To: <CAGZ6i=3+8OOafaY8B5qRkDg1pzpTu0XRw-GAenubY74DM=85Pw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.56]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR1001MB1187;6:7OregDOeqX2AAJELWFaF7GAqhkfYng1BwssB9EYVbE5zta6BUxXWrOHezKHyCvyWc/wPmjdWTfa4XZTeNPKowa1M85tLKcqB9pDxcEWXWTZQIAQS4ghJhmZl/7YdHVykKwp/JYYjRz2HaQOZ1V5wVLAc2ZaHUq4NRih81NzNyPD7VjpJGVyQo++u65JbA9BNlNynkzMiCU0qT3g2X647FIdRZKCDUn0w0m4eKUjXfKFHiCGHXFie0AS0OvSx3w/tfu+bBZnxJUu5aBO9r7BchxI0bqaMdhkfL+5im9JScBwk5UmwMhpf9NMBb88FMkw2u1OqLyHLZgkvczgyqM6Mcndc7I3zsh3B4CvW95LlVtDK1zecy+XZRoCUSiI15G24wI0J9Wno02IifAd9de/zk3ooKoPVPwTu9z0wd1iNFIFjGtQNRf00zFp+wD1/P6ogP51dP3CGMhXDXip0K+70nQ==;5:+BNKEYICNc6BFKCiMG9t0tKtxeQQNbp8n12TTJ4TOoDFPDmOd/zuY9q4kDm++6jG9dMpDew8fz8/JBe0iiyCjhWILGv2v09TGKzTs4yoKJOvn5/RpSv/hnfAAjVEG8mjbZ9iuIFsHnqLyzxcaCSdi0lxlAZAzqn/cECWFLCJgtw=;7:uH9Hk5ihizxkO9ik4dsKfjcVRXjIOiAx3Jvwlai7le807p0ofDKZR3z1uJlb9CUEGTjLpUuWtDWx/9w5WVzrjNTbrsFlwD7QvT8tbZEKZYF9yrNLbDvVZUfNKB+7SisFojHofsUI/vxHd/pUma6Isw==
x-ms-office365-filtering-correlation-id: fa723000-9304-48bc-c5b5-08d6601ac059
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR1001MB1187;
x-ms-traffictypediagnostic: AM5PR1001MB1187:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <AM5PR1001MB118725261605F0DEAFFC187BA7A70@AM5PR1001MB1187.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231472)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM5PR1001MB1187;BCL:0;PCL:0;RULEID:;SRVR:AM5PR1001MB1187;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(136003)(376002)(396003)(199004)(189003)(316002)(26005)(8936002)(476003)(217873002)(6246003)(14444005)(71200400001)(14454004)(486006)(7736002)(53936002)(71190400001)(5660300001)(186003)(74316002)(72206003)(99286004)(3846002)(97736004)(305945005)(2906002)(81166006)(106356001)(11346002)(256004)(6116002)(66066001)(55016002)(8676002)(81156014)(9686003)(446003)(110136005)(25786009)(93886005)(55236004)(53546011)(7696005)(102836004)(86362001)(6436002)(6506007)(54906003)(478600001)(68736007)(105586002)(33656002)(4326008)(76176011)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1187;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EBf/lYuM8dG0CeOyAFbnbLwlf8JmTU0JNWDLO2c3ZGw2qwSyf6w5FPxbjv8WyFWD893VPWz5zcgJwL0QN7zPEXT4gI4JfZy3JumB5G+DWZN1rN8BYWvav0DOHuTliry9SaZLT51zWX+ztX3D7H7eWsqaSsksF8RUtRNvfGcNlRao/WeBWASajALZa4wOOUZ8lA9Gv7ECNahdtyb+TxysT8vlWpDiwKT2ScUE8oXB81f1GUy6QSMMqfVHBONd3fShvYQRv9rE9etClCYuwVO6AN3VSa7/YnkodiOWDUdPL/TCh+Ai4V9LVOVJDcbC+3Fd
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa723000-9304-48bc-c5b5-08d6601ac059
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 10:15:33.0317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIgRGVjZW1iZXIgMjAxOCAwMjo0NywgS3lsZSBUc28gd3JvdGU6DQoNCj4gT24gTW9uLCBE
ZWMgMTAsIDIwMTggYXQgNzozNiBQTSBBZGFtIFRob21zb24NCj4gPEFkYW0uVGhvbXNvbi5PcGVu
c291cmNlQGRpYXNlbWkuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIDEwIERlY2VtYmVyIDIwMTgg
MDk6MDEsIEFkYW0gVGhvbXNvbiB3cm90ZToNCj4gPg0KPiA+ID4gT24gMDYgRGVjZW1iZXIgMjAx
OCAwMzowMiwgS3lsZSBUc28gd3JvdGU6DQo+ID4gPg0KPiA+ID4gPiBDdXJyZW50IG1hdGNoaW5n
IHJ1bGVzIGVuc3VyZSB0aGF0IHRoZSB2b2x0YWdlIHJhbmdlIG9mIHNlbGVjdGVkDQo+ID4gPiA+
IFNvdXJjZSBDYXBhYmlsaXR5IGlzIGVudGlyZWx5IHdpdGhpbiB0aGUgcmFuZ2UgZGVmaW5lZCBp
biBvbmUgb2YNCj4gPiA+ID4gdGhlIFNpbmsgQ2FwYWJpbGl0aWVzLiBUaGlzIGlzIHJlYXNvbmFi
bGUgYnV0IG5vdCBwcmFjdGljYWwNCj4gPiA+ID4gYmVjYXVzZSBTaW5rIG1heSBub3Qgc3VwcG9y
dCB3aWRlIHJhbmdlIG9mIHZvbHRhZ2Ugd2hlbiBzaW5raW5nDQo+ID4gPiA+IHBvd2VyIHdoaWxl
IFNvdXJjZSBjb3VsZCBhZHZlcnRpc2UgaXRzIGNhcGFiaWxpdGllcyBpbiByYWxldGl2ZWx5DQo+
ID4gPiA+IHdpZGVyIHJhbmdlLiBGb3IgZXhhbXBsZSwgYSBTb3VyY2UgUERPIGFkdmVydGlzaW5n
IDMuM1YtMTFWQDNBICg5Vg0KPiA+ID4gPiBQcm9nIG9mIEZpeGVkIE5vbWluYWwgVm9sdGFnZSkg
d2lsbCBub3QgYmUgc2VsZWN0ZWQgaWYgdGhlIFNpbmsNCj4gPiA+ID4gcmVxdWlyZXMgNVYtIDEy
VkAzQSBQUFMgcG93ZXIuIEhvd2V2ZXIsIHRoZSBTaW5rIGNvdWxkIHdvcmsgd2VsbA0KPiA+ID4g
PiBpZiB0aGUgcmVxdWVzdGVkIHZvbHRhZ2UgcmFuZ2UgaW4NCj4gPiA+IFJET3MgaXMgNVYtMTFW
QDNBLg0KPiA+ID4NCj4gPiA+IElzIHRoZXJlIGEgcmVhbCB3b3JsZCBleGFtcGxlIG9mIGEgc2lu
ayByZXF1aXJpbmcgdGhlIDVWIC0gMTJWDQo+ID4gPiByYW5nZT8gSW4gdGhhdCBzY2VuYXJpbyBj
b3VsZCB3ZSBub3QgYWRkIGFuIGFkZGl0aW9uYWwgc2luaw0KPiA+ID4gY2FwYWJpbGl0eSB3aGlj
aCBhbGxvd3MgZm9yIHRoaXMgcmFuZ2UgdG8gYmUgc3VwcG9ydGVkLCBhbmQgdGhlIGN1cnJlbnQN
Cj4gaW1wbGVtZW50YXRpb24gc2hvdWxkIHdvcmsganVzdCBmaW5lPw0KPiA+DQo+ID4gT2ssIEkg
bWF5YmUgc2hvdWxkIGhhdmUgd2FpdGVkIHVudGlsIGFmdGVyIG15IG1vcm5pbmcgY29mZmVlIHRv
DQo+ID4gcmVzcG9uZC4gU28gYmVjYXVzZSB0aGUgbG93ZXIgbGltaXQgb24gdGhlIHNpbmsgc2lk
ZSwgaXMgaGlnaGVyIHRoYW4NCj4gPiB0aGUgYWR2ZXJ0aXNlZCBzb3VyY2UncyBQUFMgbWluaW11
bSB2b2x0YWdlIGl0IG5ldmVyIGdldHMgc2VsZWN0ZWQ/DQo+ID4gUGVyc29uYWxseSBJJ2QgcHJl
ZmVyIHRvIGtlZXAgdGhlIHVwcGVyIGxpbWl0IGNoZWNraW5nIGFzIGlzIGFzIEkNCj4gPiB0aGlu
ayB0aGF0J3MgYW4gYWRkaXRpb25hbCBzYWZldHkgYmVuZWZpdCBoZWxwaW5nIHRvIHByZXZlbnQN
Cj4gPiBvdmVyLXZvbHRhZ2Ugc2NlbmFyaW9zLiBJIHRoaW5rIGlmIGEgUFBTIEFQRE8gY2FuIHN1
cHBseSB1cCB0byAxMVYNCj4gPiB0aGVuIHRoZSBzeXN0ZW0gc2hvdWxkIGJlIGNhcGFibGUgb2Yg
aGFuZGxpbmcgdGhhdCB2b2x0YWdlLCBvdGhlcndpc2UNCj4gPiBpdCBzaG91bGRuJ3QgYmUgY29u
c2lkZXJlZCBhdCBhbGwuIFRoZSBTb3VyY2UgcHJvdmlkZXMgbGltaXRzIGNoZWNraW5nDQo+ID4g
YXMgd2VsbCB0byBtYWtlIHN1cmUgdGhlIFNpbmsgZG9lc24ndCByZXF1ZXN0IGEgdmFsdWUgYWJv
dmUgdGhlIG1heGltdW0NCj4gdm9sdGFnZSBsaW1pdCBmb3IgdGhhdCBzZWxlY3RlZCBBUERPLg0K
PiA+DQo+IA0KPiBJZiB0aGUgb3Zlci12b2x0YWdlIG9jY3VycywgaXQgbWVhbnM6DQo+IDEuIHRo
ZSBhZGFwdGVyIG1hbGZ1bmN0aW9uZWQuIG9yDQo+IDIuIHRoZSBjb2RlIG9uIHRoZSBTaW5rIGFj
Y2lkZW50YWxseSByZXF1ZXN0cyBhIHZvbHRhZ2UgbGV2ZWwgd2hpY2ggaXMgb3ZlciB0aGUgbGlt
aXQNCj4gb2YgdGhlIFNpbmsuDQo+IA0KPiBGb3IgMS4sIGl0IGlzIGRpZmZpY3VsdCB0byBwcmVk
aWN0IHRoZSBiZWhhdmlvcnMgb2YgYSBtYWxmdW5jdGlvbmVkIGFkYXB0ZXIuIFRoZSBvdmVyLQ0K
PiB2b2x0YWdlIGV2ZW50IG1heSBoYXBwZW4gZXZlbiBpZiB0aGUgU2luayBkb2Vzbid0IHNlbGVj
dCB0aGUgQVBETyBmcm9tIHRoaXMNCj4gYnJva2VuIGFkYXB0ZXIuDQoNClllcywgSSBhZ3JlZSBp
dCdzIGFsbW9zdCBpbXBvc3NpYmxlIHRvIGRvIGFueXRoaW5nIGZyb20gc29mdHdhcmUgdG8gbWl0
aWdhdGUNCnRoaXMgd2hpY2ggaXMgd2h5IHRoZSBIVyBkZXNpZ24gaGFzIHRvIGhhdmUgcHJvdGVj
dGlvbiBmb3IgdGhpcy4NCg0KPiBGb3IgMi4sIGl0IGlzIGRpZmZpY3VsdCB0byBwcmVkaWN0IHRo
ZSBiZWhhdmlvcnMgZnJvbSB0aGUgY2FyZWxlc3MgY29kZSBhcyB3ZWxsLg0KDQpZZXMsIHRoYXQn
cyBhbHNvIHRydWUsIGJ1dCBpZiBpdCdzIGNvZGVkIHdpdGggdGhlIGludGVudGlvbiBub3QgdG8g
c2VsZWN0IGFuDQpvcHRpb24gdGhhdCdzIHBvdGVudGlhbGx5IGhpZ2hlciB0aGFuIHRoZSBzeXN0
ZW0gY2FuIGhhbmRsZSB0aGVuIHdlJ3JlIGxlc3MNCmxpa2VseSB0byBmYWxsIGZvdWwgb2Ygb3Zl
ci12b2x0YWdlIHNjZW5hcmlvcyBpbiBteSBvcGluaW9uLiBCeSBzZWxlY3RpbmcgYQ0KUFBTIEFQ
RE8gd2l0aCBhbiB1cHBlciB0aHJlc2hvbGQgd2hpY2ggZmFsbHMgd2l0aGluIHRoZSBib2FyZCBs
aW1pdHMsIGFzc3VtaW5nDQp0aGUgY29kZSB3ZXJlIHRvIGFjY2lkZW50YWxseSByZXF1ZXN0IHNv
bWV0aGluZyBoaWdoZXIgdGhhbiB0aGUgUFBTIEFQRE8gbWF4aW11bQ0KdGhlbiB0aGUgU291cmNl
IHNob3VsZCByZWplY3QgdGhpcy4gSnVzdCBmZWVscyBhIGxpdHRsZSBzYWZlciBhcyB3ZSdyZSB0
YWxraW5nDQphYm91dCBjb250cm9sbGluZyBhbiBleHRlcm5hbCBwb3dlciBzb3VyY2UuIEF0IHRo
ZSBlbmQgb2YgdGhlIGRheSB0aG91Z2ggdGhlDQpkZWNpc2lvbiBsaWVzIHdpdGggdGhlIG1haW50
YWluZXJzIG9uIHRoaXMuDQoNCj4gPiBGb3IgdGhlIGxvd2VyIGxpbWl0IEknbSBtb3JlIGluY2xp
bmVkIHRvIGFncmVlIHdpdGggYWxsb3dpbmcgYSBoaWdoZXINCj4gPiBtaW5pbXVtIG9uIHRoZSBz
aW5rIHNpZGUgYXMgdGhhdCdzIGxlc3Mgb2YgYSBzYWZldHkvZGFtYWdlIGlzc3VlIGFzIEkNCj4g
dW5kZXJzdGFuZCBpdC4NCj4gPiBGV0lXLCB3aGF0IGlzIHRoZSByZWFsIHdvcmxkIHNjZW5hcmlv
PyBXaGF0IGhhcHBlbnMgaWYgdm9sdGFnZSBkcm9wcyBiZWxvdw0KPiA1Vj8NCj4gPg0KPiANCj4g
U29tZSBwcm9kdWN0cyAoaW4gU2luayBtb2RlKSBoYXZlIHVuZGVyLXZvbHRhZ2UgcHJvdGVjdGlv
biAodGhlIGxvd2VyIGJvdW5kDQo+IG1pZ2h0IGJlIGFyb3VuZCAzLjhWIC0gNFYgYmVmb3JlIHRo
ZSBjYWxjdWxhdGlvbiBvZiBJUi1kcm9wKSB0aGF0IHdpbGwgY2F1c2UgdGhlDQo+IGRpc2Nvbm5l
Y3Rpb24uDQoNCk9rLCBzbyB0aGUgc3lzdGVtIHdvdWxkIGp1c3Qgc3RvcCBjaGFyZ2luZywgY29y
cmVjdD8gSSBndWVzcyB0aGUgY2FsbGluZyBjb2RlDQp0byBjb250cm9sIHRoZSBTb3VyY2UvYWRh
cHRlciwgdmlhIFRDUE0sIHdvdWxkbid0IHNlbGVjdCBhIHZhbHVlIGJlbG93IDRWIGluIHRoYXQN
CnNjZW5hcmlvIGFueXdheT8NCg0KPiANCj4gdGhhbmtzLA0KPiBLeWxlDQo=
