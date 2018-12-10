Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D0EC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59BCC2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="OP1T5Bg2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59BCC2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbeLJJCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:02:10 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.67]:6865 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726531AbeLJJCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:02:09 -0500
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-west-1.aws.symcld.net id 83/83-12360-B8B2E0C5; Mon, 10 Dec 2018 09:02:03 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSbUxTZxTHee47hcseC46zZqhrYFHGLdQscJs
  sxn3rPjjUfdhCMNsFrrTalqa3THQfhiMstoTJNjADUasWp2BKaMRMwupCsjhEZQO2+YKCaXFR
  kilR4zC47N7e4vTLk98553/enhyONM4xJk5u8Ms+j+QyMwbKUZxuEwJvZVWWLB14VbzRMUqIT
  cf7GTHYd44SYwsRQpwc6mbEYyeaSTFx9BKxkbWHovX2w6Nb7OcPnWbt5540svaH0VWb6Qra6a
  mqa/iEdsRb/2C8XxY2jJ3cSzein9YFkYGjcD8Jvy8FSc0w4nYC/po7oBrpqhFHsNi9VmMGi/D
  tL7OMJsrBVxDE4jO0ZpC4B0F0Ksxqqmz8IfRMHk5yDv4IBp+OEEHEqbweYte3aUjhAjj/ZKum
  4LEE+8NXWL1XKXT0BCiN03EZTLSdRRojnAeP9vYl5yFxLlxPHCE0BowhPDxO6rwS7sb/pXW9D
  KNfXEW6vwgu/5lIsRlOXO2idc6DiSMtKf81BoanWZ03wfTIAKWtBXgSwWzbRXq5UGJuPsUihF
  uaKZ29MNAxlSq0Cnpbb6eSb5LwzeNHtLYw4NdhOlam++dpiLQNpDauhgeHLrNtqKjrheW61BQ
  Sr4P+oWLd/Qa0t9xmu5L/tQJGOxNUCFG9qLTK56x1+N2S0yVYS0oEq3W9YLWVCTaLtEeossj1
  wi5Z8QtWi7RLsSi73dWuGotH9keRelo13p/Tf0DPgrUj6DWOMK/kB+cNlcasqrqa3Q5JcXzsq
  3fJyghay3F4X6L3V2SiPHUe2Qz8TGFWpXGFT66VG7Y7XeqtLkuByzTn8JIW5hWv5FactXroIr
  JxZy8FviO5qeR7IfC4mzQm65ly+e/XqAlYS3DUe56XW77+CZRnyuZRWlqaMdMr+9xO/8vxeyi
  XQ+Zsfo/WNtPp8T/vek8diFAHcp0htIH80v8hUyOq+Dz+WYFxzSvUj1sWMjfc3b4pMm4MZX3Q
  xDS/mz82M/7VcHmMvP/+2OBU6FTkZHnTUFHGhWhf/q3FjKXfDKhz56cL78zkl+d3nlkdcSO+P
  cTeZLcqg2+XvlfcuiMDNuxYjLDdgm324N/7qn0+w9jp4q/Db1ai5oL7d05VbPtn58GAmVIckr
  WQ9CnSf5SeswP4AwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-2.tower-288.messagelabs.com!1544432520!3873063!1
X-Originating-IP: [104.47.9.57]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30532 invoked from network); 10 Dec 2018 09:02:01 -0000
Received: from mail-ve1eur03lp2057.outbound.protection.outlook.com (HELO EUR03-VE1-obe.outbound.protection.outlook.com) (104.47.9.57)
  by server-2.tower-288.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 10 Dec 2018 09:02:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5vQOJGIJqylA3rusDU5Rl7+n097LSJ9SbvNBI4/x6Q=;
 b=OP1T5Bg2zJ/zfRKhZ2IxkZma4f1Br6/qnm7PMKOdkzgLrBybfpr6v5ql9mNzRz5VbkmgmmXH+G2hFYOOFqw5F6DPptfLNHnX1+WeZKEZW91kBUdlWs7jxpYKq0imAv0MTL0z2ln4165XGJz04vjZfCKg62hixNW3UUlYu+kCj3U=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.17) by
 AM5PR1001MB0964.EURPRD10.PROD.OUTLOOK.COM (10.169.154.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Mon, 10 Dec 2018 09:01:26 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::915f:2c34:17a1:da64]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::915f:2c34:17a1:da64%8]) with mapi id 15.20.1404.023; Mon, 10 Dec 2018
 09:01:26 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Kyle Tso <kyletso@google.com>,
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
Thread-Index: AQHUjRA9iR+V8w1vUkO6AmQvwyOQdaV3soBQ
Date:   Mon, 10 Dec 2018 09:01:26 +0000
Message-ID: <AM5PR1001MB0994F844103F31DBD373AAB880A50@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20181206030227.9507-1-kyletso@google.com>
In-Reply-To: <20181206030227.9507-1-kyletso@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR1001MB0964;6:ckLBwvrMz6b30Th609HIcXsT0xF327znTuAhWasI10pye9GO8snFFCdG+p9dCMVItiG4hOg6BOifBlW+lptixPx4FN27t4+L5oWFux1V7pYhIjB+bfmtFHvxegoTaGFK0irRrYAC6LShBib406EpE7YkTaYLZWlpYc2HBgIT5dO0s9g7yBSGlSJoyjRZCDAsyduZPFYwfi4pVKPA5JnbGQmjBivYouN8NfCzIynggVPs3ck5/u0rJYbHsLPcVdxsxfv7I7VXqOKd/YMnQso4FGpNucUzWE6++iFcV2z/pDcvY+GtsQqc62r1ewUEZfiqhaEuvZyQffeU+QJ1NFuPCNgVSKygi4IAQk2Ncdsz0C9Hpt3SxBVAAK70hRr5KDxVdSXZSke0HxQBY288/UjX5DR+j8sfnbVxLbv/XEjJBb/rZZztx3N+dVqPU9AJaHgEU1xwZMnTgxtoqHBGYj1BYQ==;5:locd+WXC9T/NLgbShiEyZXPgiabaWWwAzUkXHntsqDfjXTTSxcz4WnH+XG0ckAqVDzTB4B8K4B/0XV9EGuINwxUksfnJFWxkMmc1mg7oHp0HAc804lLIyatvq9QQb3W9/DqC0WVvvMsii0B9gDFwhJRo11Sa84HOP/SsRApmKyA=;7:OgsXXwt4bRC80um8Ch0YOOJiCijQguGp2EgHXaS8dsg4lETfEaN3ayJghDV+2aRVtUptYHFLW5U8q3/qjwQqVaisRVB+pUWyfLzYj5a1s+6dVxBE5XuU5uLOTSGG9Xk/twMxr5J2vAVGpxxMnjgNPw==
x-ms-office365-filtering-correlation-id: 274aa69b-ed90-45c3-680e-08d65e7e114b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM5PR1001MB0964;
x-ms-traffictypediagnostic: AM5PR1001MB0964:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <AM5PR1001MB09640293524F6E04E013E51BA7A50@AM5PR1001MB0964.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231472)(944501520)(52105112)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM5PR1001MB0964;BCL:0;PCL:0;RULEID:;SRVR:AM5PR1001MB0964;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(396003)(366004)(376002)(346002)(199004)(189003)(486006)(8936002)(316002)(97736004)(99286004)(54906003)(110136005)(14454004)(105586002)(68736007)(2906002)(217873002)(106356001)(2501003)(5660300001)(229853002)(6246003)(53936002)(4326008)(7736002)(33656002)(11346002)(3846002)(446003)(6116002)(476003)(256004)(9686003)(6436002)(2201001)(7696005)(478600001)(76176011)(81156014)(81166006)(86362001)(8676002)(26005)(74316002)(72206003)(186003)(25786009)(102836004)(53546011)(305945005)(71190400001)(66066001)(71200400001)(6506007)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB0964;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Gvo/LxKgGE26lWZfoGR7yZRKnwyUCz3h5U7NfLeQhukFnGSCHn1WgUigvxJp8IgLLrBBMwLl+yEnhoVGscoPtkrXUnB7Zj/offmpYizwEkBhkST2A///sarbdujclPt/tT4inTIYW5B3Ivstbu7TKfSeh0PdvheWxN9gwV7X+clLEI/6UQI10TPJj9l2sTG1iq+2PpMhOUMC1MAkXUmV779TrhZmDUxm7F2smjJL6cnNfd74WrimKmxxe5S/gRQB0SQDGd19zkb4biLS6W6PJVbWJIBNob/dilgJIbskDNWhtKixW8FwsHN7Un/+5XnC
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 274aa69b-ed90-45c3-680e-08d65e7e114b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 09:01:26.7454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB0964
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYgRGVjZW1iZXIgMjAxOCAwMzowMiwgS3lsZSBUc28gd3JvdGU6DQoNCj4gQ3VycmVudCBt
YXRjaGluZyBydWxlcyBlbnN1cmUgdGhhdCB0aGUgdm9sdGFnZSByYW5nZSBvZiBzZWxlY3RlZCBT
b3VyY2UNCj4gQ2FwYWJpbGl0eSBpcyBlbnRpcmVseSB3aXRoaW4gdGhlIHJhbmdlIGRlZmluZWQg
aW4gb25lIG9mIHRoZSBTaW5rIENhcGFiaWxpdGllcy4gVGhpcw0KPiBpcyByZWFzb25hYmxlIGJ1
dCBub3QgcHJhY3RpY2FsIGJlY2F1c2UgU2luayBtYXkgbm90IHN1cHBvcnQgd2lkZSByYW5nZSBv
Zg0KPiB2b2x0YWdlIHdoZW4gc2lua2luZyBwb3dlciB3aGlsZSBTb3VyY2UgY291bGQgYWR2ZXJ0
aXNlIGl0cyBjYXBhYmlsaXRpZXMgaW4NCj4gcmFsZXRpdmVseSB3aWRlciByYW5nZS4gRm9yIGV4
YW1wbGUsIGEgU291cmNlIFBETyBhZHZlcnRpc2luZyAzLjNWLTExVkAzQSAoOVYNCj4gUHJvZyBv
ZiBGaXhlZCBOb21pbmFsIFZvbHRhZ2UpIHdpbGwgbm90IGJlIHNlbGVjdGVkIGlmIHRoZSBTaW5r
IHJlcXVpcmVzIDVWLQ0KPiAxMlZAM0EgUFBTIHBvd2VyLiBIb3dldmVyLCB0aGUgU2luayBjb3Vs
ZCB3b3JrIHdlbGwgaWYgdGhlIHJlcXVlc3RlZCB2b2x0YWdlDQo+IHJhbmdlIGluIFJET3MgaXMg
NVYtMTFWQDNBLg0KDQpJcyB0aGVyZSBhIHJlYWwgd29ybGQgZXhhbXBsZSBvZiBhIHNpbmsgcmVx
dWlyaW5nIHRoZSA1ViAtIDEyViByYW5nZT8gSW4gdGhhdA0Kc2NlbmFyaW8gY291bGQgd2Ugbm90
IGFkZCBhbiBhZGRpdGlvbmFsIHNpbmsgY2FwYWJpbGl0eSB3aGljaCBhbGxvd3MgZm9yIHRoaXMN
CnJhbmdlIHRvIGJlIHN1cHBvcnRlZCwgYW5kIHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIHNo
b3VsZCB3b3JrIGp1c3QgZmluZT8NCg0KPiANCj4gVG8gaW1wcm92ZSB0aGUgdXNhYmlsaXR5LCBj
aGFuZ2UgdGhlIG1hdGNoaW5nIHJ1bGVzIHRvIHdoYXQgbGlzdGVkDQo+IGJlbG93Og0KPiBhLiBU
aGUgU291cmNlIFBETyBpcyBzZWxlY3RhYmxlIGlmIGFueSBwb3J0aW9uIG9mIHRoZSB2b2x0YWdl
IHJhbmdlDQo+ICAgIG92ZXJsYXBzIG9uZSBvZiB0aGUgU2luayBQRE8ncyB2b2x0YWdlIHJhbmdl
Lg0KPiBiLiBUaGUgbWF4aW11bSBvcGVyYXRpb25hbCB2b2x0YWdlIHdpbGwgYmUgdGhlIGxvd2Vy
IG9uZSBiZXR3ZWVuIHRoZQ0KPiAgICBzZWxlY3RlZCBTb3VyY2UgUERPIGFuZCB0aGUgbWF0Y2hp
bmcgU2luayBQRE8uDQo+IGMuIFRoZSBtYXhpbXVtIHBvd2VyIHdpbGwgYmUgdGhlIG1heGltdW0g
b3BlcmF0aW9uYWwgdm9sdGFnZSB0aW1lcyB0aGUNCj4gICAgbWF4aW11bSBjdXJyZW50IGRlZmlu
ZWQgaW4gdGhlIHNlbGVjdGVkIFNvdXJjZSBQRE8gZC4gU2VsZWN0IHRoZSBTb3VyY2UgUERPDQo+
IHdpdGggdGhlIGhpZ2hlc3QgbWF4aW11bSBwb3dlcg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS3ls
ZSBUc28gPGt5bGV0c29AZ29vZ2xlLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi90eXBlYy90
Y3BtL3RjcG0uYyB8IDI5ICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy91c2IvdHlwZWMvdGNwbS90Y3BtLmMgYi9kcml2ZXJzL3VzYi90eXBlYy90
Y3BtL3RjcG0uYw0KPiBpbmRleCAzNjIwZWZlZTI2ODguLjMwMDFkZjdiZDYwMiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy91c2IvdHlwZWMvdGNwbS90Y3BtLmMNCj4gKysrIGIvZHJpdmVycy91c2Iv
dHlwZWMvdGNwbS90Y3BtLmMNCj4gQEAgLTIyMTMsNyArMjIxMyw4IEBAIHN0YXRpYyB1bnNpZ25l
ZCBpbnQgdGNwbV9wZF9zZWxlY3RfcHBzX2FwZG8oc3RydWN0DQo+IHRjcG1fcG9ydCAqcG9ydCkN
Cj4gIAl1bnNpZ25lZCBpbnQgaSwgaiwgbWF4X213ID0gMCwgbWF4X212ID0gMDsNCj4gIAl1bnNp
Z25lZCBpbnQgbWluX3NyY19tdiwgbWF4X3NyY19tdiwgc3JjX21hLCBzcmNfbXc7DQo+ICAJdW5z
aWduZWQgaW50IG1pbl9zbmtfbXYsIG1heF9zbmtfbXY7DQo+IC0JdTMyIHBkbzsNCj4gKwl1bnNp
Z25lZCBpbnQgbWF4X29wX212Ow0KPiArCXUzMiBwZG8sIHNyYywgc25rOw0KPiAgCXVuc2lnbmVk
IGludCBzcmNfcGRvID0gMCwgc25rX3BkbyA9IDA7DQo+IA0KPiAgCS8qDQo+IEBAIC0yMjYzLDE2
ICsyMjY0LDE4IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgdGNwbV9wZF9zZWxlY3RfcHBzX2FwZG8o
c3RydWN0DQo+IHRjcG1fcG9ydCAqcG9ydCkNCj4gIAkJCQkJY29udGludWU7DQo+ICAJCQkJfQ0K
PiANCj4gLQkJCQlpZiAobWF4X3NyY19tdiA8PSBtYXhfc25rX212ICYmDQo+IC0JCQkJICAgIG1p
bl9zcmNfbXYgPj0gbWluX3Nua19tdikgew0KPiArCQkJCWlmIChtaW5fc3JjX212IDw9IG1heF9z
bmtfbXYgJiYNCj4gKwkJCQkgICAgbWF4X3NyY19tdiA+PSBtaW5fc25rX212KSB7DQo+ICsJCQkJ
CW1heF9vcF9tdiA9IG1pbihtYXhfc3JjX212LA0KPiBtYXhfc25rX212KTsNCj4gKwkJCQkJc3Jj
X213ID0gKG1heF9vcF9tdiAqIHNyY19tYSkgLyAxMDAwOw0KPiAgCQkJCQkvKiBQcmVmZXIgaGln
aGVyIHZvbHRhZ2VzIGlmIGF2YWlsYWJsZSAqLw0KPiAgCQkJCQlpZiAoKHNyY19tdyA9PSBtYXhf
bXcgJiYNCj4gLQkJCQkJICAgICBtaW5fc3JjX212ID4gbWF4X212KSB8fA0KPiArCQkJCQkgICAg
IG1heF9vcF9tdiA+IG1heF9tdikgfHwNCj4gIAkJCQkJICAgIHNyY19tdyA+IG1heF9tdykgew0K
PiAgCQkJCQkJc3JjX3BkbyA9IGk7DQo+ICAJCQkJCQlzbmtfcGRvID0gajsNCj4gIAkJCQkJCW1h
eF9tdyA9IHNyY19tdzsNCj4gLQkJCQkJCW1heF9tdiA9IG1heF9zcmNfbXY7DQo+ICsJCQkJCQlt
YXhfbXYgPSBtYXhfb3BfbXY7DQo+ICAJCQkJCX0NCj4gIAkJCQl9DQo+ICAJCQl9DQo+IEBAIC0y
Mjg1LDE0ICsyMjg4LDE2IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgdGNwbV9wZF9zZWxlY3RfcHBz
X2FwZG8oc3RydWN0DQo+IHRjcG1fcG9ydCAqcG9ydCkNCj4gIAl9DQo+IA0KPiAgCWlmIChzcmNf
cGRvKSB7DQo+IC0JCXBkbyA9IHBvcnQtPnNvdXJjZV9jYXBzW3NyY19wZG9dOw0KPiAtDQo+IC0J
CXBvcnQtPnBwc19kYXRhLm1pbl92b2x0ID0gcGRvX3Bwc19hcGRvX21pbl92b2x0YWdlKHBkbyk7
DQo+IC0JCXBvcnQtPnBwc19kYXRhLm1heF92b2x0ID0gcGRvX3Bwc19hcGRvX21heF92b2x0YWdl
KHBkbyk7DQo+IC0JCXBvcnQtPnBwc19kYXRhLm1heF9jdXJyID0NCj4gLQkJCW1pbl9wcHNfYXBk
b19jdXJyZW50KHBkbywgcG9ydC0+c25rX3Bkb1tzbmtfcGRvXSk7DQo+ICsJCXNyYyA9IHBvcnQt
PnNvdXJjZV9jYXBzW3NyY19wZG9dOw0KPiArCQlzbmsgPSBwb3J0LT5zbmtfcGRvW3Nua19wZG9d
Ow0KPiArDQo+ICsJCXBvcnQtPnBwc19kYXRhLm1pbl92b2x0ID0NCj4gbWF4KHBkb19wcHNfYXBk
b19taW5fdm9sdGFnZShzcmMpLA0KPiArCQkJCQkgICAgICBwZG9fcHBzX2FwZG9fbWluX3ZvbHRh
Z2Uoc25rKSk7DQo+ICsJCXBvcnQtPnBwc19kYXRhLm1heF92b2x0ID0NCj4gbWluKHBkb19wcHNf
YXBkb19tYXhfdm9sdGFnZShzcmMpLA0KPiArCQkJCQkgICAgICBwZG9fcHBzX2FwZG9fbWF4X3Zv
bHRhZ2Uoc25rKSk7DQo+ICsJCXBvcnQtPnBwc19kYXRhLm1heF9jdXJyID0gbWluX3Bwc19hcGRv
X2N1cnJlbnQoc3JjLCBzbmspOw0KPiAgCQlwb3J0LT5wcHNfZGF0YS5vdXRfdm9sdCA9DQo+IC0J
CQltaW4ocGRvX3Bwc19hcGRvX21heF92b2x0YWdlKHBkbyksIHBvcnQtDQo+ID5wcHNfZGF0YS5v
dXRfdm9sdCk7DQo+ICsJCQltaW4ocG9ydC0+cHBzX2RhdGEubWF4X3ZvbHQsIHBvcnQtDQo+ID5w
cHNfZGF0YS5vdXRfdm9sdCk7DQo+ICAJCXBvcnQtPnBwc19kYXRhLm9wX2N1cnIgPQ0KPiAgCQkJ
bWluKHBvcnQtPnBwc19kYXRhLm1heF9jdXJyLCBwb3J0LT5wcHNfZGF0YS5vcF9jdXJyKTsNCj4g
IAl9DQo+IC0tDQo+IDIuMjAuMC5yYzIuNDAzLmdkYmMzYjI5ODA1LWdvb2cNCg0KDQo=
