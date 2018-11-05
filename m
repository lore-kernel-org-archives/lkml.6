Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6A8ECDE46
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE132081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toshibaap.onmicrosoft.com header.i=@toshibaap.onmicrosoft.com header.b="eFZnkmz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE132081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbeKEQAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 11:00:51 -0500
Received: from mo-csw1115.securemx.jp ([210.130.202.157]:46812 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728985AbeKEQAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 11:00:50 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id wA56gR8n020358; Mon, 5 Nov 2018 15:42:27 +0900
X-Iguazu-Qid: 2wGqgdxobBXb1eWsOz
X-Iguazu-QSIG: v=1; s=0; t=1541400146; q=2wGqgdxobBXb1eWsOz; m=5LGyPxBNYSakKmiwBmFm8fgW1byt4G92126/3pTVPF8=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1113) id wA56gNVC002368;
        Mon, 5 Nov 2018 15:42:24 +0900
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by imx2.toshiba.co.jp  with ESMTP id wA56gMJF020738;
        Mon, 5 Nov 2018 15:42:23 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toshibaap.onmicrosoft.com; s=selector1-toshiba-co-jp;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LVKloioimydCqPtjsFBH1YYY1aZRZjNGMPHJh1p1ZQ=;
 b=eFZnkmz4UjPaTreC3sQrrbHwCwjWkxzWnojR5hoXhZkfBiaD9of9uieHKHonAz6k58tnFIbKI1zgTDOH+RXsnsKLYIKstw/rHhyGWqd1UsmKYQohUvOGkRaDF5CokQixOqVnEv2HccdZuELbOcfzPJ+Q4fKzi87hOB30m2QB3zE=
From:   <shinya1.takumi@toshiba.co.jp>
To:     <steve.backup.kemp@gmail.com>
CC:     <jmorris@namei.org>, <serge@hallyn.com>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [RFC v4 0/2] WhiteEgret LSM module
Thread-Topic: [RFC v4 0/2] WhiteEgret LSM module
Thread-Index: AQHUZ2nmDaroCCknwEGAnxnKChJqHKUpnpSAgBc0NzA=
Date:   Mon, 5 Nov 2018 06:42:05 +0000
X-TSB-HOP: ON
Message-ID: <KAWPR01MB1444923FD32B82555FC8924392CA0@KAWPR01MB1444.jpnprd01.prod.outlook.com>
References: <1539925672-16744-1-git-send-email-shinya1.takumi@toshiba.co.jp>
 <CABxV-EV0jYWufjEKsBw9X5AsBT5N8OQjOb2kB_QP_LYvgh-gQg@mail.gmail.com>
In-Reply-To: <CABxV-EV0jYWufjEKsBw9X5AsBT5N8OQjOb2kB_QP_LYvgh-gQg@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinya1.takumi@toshiba.co.jp; 
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KAWPR01MB1393;6:EZXw8oT7Pw2WDcd/VW73MNkw9cVnK9flW89YNItYo9vVQqbCyRKXl5IcvQmgedUbaAscZvglAI/m0MrxkkvacIdHYlyfTTbjKlwCdgD5LgCjA+4Gu/tIGXi31yGJ0KDiZbTxjQosRzNlm1WI1nd/mVfb4mPEZUA4QIfaSGvTzu9QCvseDgPheWr9Duhp3Xyir038axjUTsmhCyMZ/xRpP8tRu9594/fmvl2Df7MP8nrqOwQHMZ5xx+duxwFCRjHNdBDKoZwK082qqYmlFBAqw+o7gOMKA5iVtkWM9xTo9lMnWd5F3sd3IVNVmTUrrbevdwbSjcYXmxrLORrUXdSMkbL/9mQWC8U0iqY4+z+zquLyrAg5tyrRhWDo9kKs5i8PSHzb0bV7F/Vcp8TYMqAxPccQ0dVrKQ4rwmtFhA6Txtvx9HmAL64FVSF81JSJheZisPJA7kF3Um1vT4oi4YdrcQ==;5:gl42Yh9OpxGK1JdhDbdd02saXy9yp8IoLwQxBJCYya85rZCxvDcmbV220cZ8zhesL41L7b08Oe+5/1An7aLP6rfRHrcLaY7oOZAUg+Ml0HXHByqucXYS6k9lkD9+R6p5BqK8xAvLOamFVv7W6jmMgcg8a1wx0QD1XRTs1UeKhac=;7:OlR+Dd2x6odYT2jz5HwY9Biio3JeaErBB5KEfVxIFH6yInJXVKbZyUmsXM+d1kCaaR/5Ig30gKpMqp01HCGskfmeGYo/dMC5vX8Qe75D+PIWrP9SOwDSRw74KFDJPZ3WK1G8h2oecpy0IDsda6BKLQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fe59ef3a-df08-431f-a3ff-08d642e9cd17
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:KAWPR01MB1393;
x-ms-traffictypediagnostic: KAWPR01MB1393:
x-microsoft-antispam-prvs: <KAWPR01MB1393E1D636AE996ADB4C543B92CA0@KAWPR01MB1393.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(65766998875637)(166708455590820)(192374486261705);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:KAWPR01MB1393;BCL:0;PCL:0;RULEID:;SRVR:KAWPR01MB1393;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(39860400002)(366004)(376002)(189003)(199004)(25786009)(2906002)(14454004)(2900100001)(86362001)(68736007)(4326008)(8936002)(229853002)(8676002)(6506007)(81166006)(39060400002)(81156014)(6916009)(6246003)(305945005)(7736002)(71190400001)(71200400001)(6116002)(3846002)(106356001)(105586002)(7696005)(76176011)(966005)(74316002)(478600001)(102836004)(256004)(446003)(66066001)(11346002)(486006)(316002)(476003)(14444005)(74482002)(33656002)(99286004)(55016002)(6436002)(97736004)(6306002)(186003)(26005)(9686003)(5660300001)(54906003)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:KAWPR01MB1393;H:KAWPR01MB1444.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toshiba.co.jp does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vvIwhUzZ9ZJArWGeBDHMFBE3GUFWItl0Z0tPDc8liuADeQLHWp6j+S7RAATjsK6Z9veDX+GUY6DkyB73BuyRkVH+NmInpthqPNc8A9GuhliGn+PuH86EBUkvH1ZebZCSHjULpk9qxUKphIMijw/TqYCkRBf/hghWzk3a570RTrBnwzn6PZ9eVkHczmA7HeNsUHHdkW6hb6Mv0vVk7xC/akvA55m5W59sYHZ/+l6WA2QZZoHRaW8EI6H5Q4c3cc5mVx+SvobMsOzZtlYigvspMUoGQphzesvAWzsZuipsZvg78Y/RHYnKUbwE/chAbtbfNsn+wUAwEFuYSb2fGiPGo4xCDFeDIttdm+m2mXv05ac=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fe59ef3a-df08-431f-a3ff-08d642e9cd17
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 06:42:05.4214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KAWPR01MB1393
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3RldmUgS2VtcCB3cm90ZToNCj4gVGhpcyBpcyBhbiBpbnRlcmVzdGluZyBpZGVhLCBhbmQgYW4g
ZXZvbHV0aW9uIHNpbmNlIHRoZSBpbml0aWFsIA0KPiBhcHByb2FjaCB3aGljaCB3YXMgc3VibWl0
dGVkIGJhc2VkIHVwb24geGF0dHIgYXR0cmlidXRlcy4gIEkgc3RpbGwgDQo+IGZpbmQgdGhlIGlk
ZWEgb2YgdXNpbmcgYXR0cmlidXRlcyBzaW1wbGVyIHRvIG1hbmFnZSB0aG91Z2gsIHNpbmNlIA0K
PiB0aGV5J3JlIGVhc3kgdG8gYWRkLCBhbmQgYXVkaXQgZm9yLg0KPiANCj4gSSBzdXNwZWN0IHRo
ZSBiaWdnZXN0IG9iamVjdGlvbiB0byB0aGlzIG1vZHVsZSBpcyB0aGF0IG1haW50YWluaW5nIGEg
DQo+IHdoaXRlbGlzdCBhdCBhbGwgaXMgb2Z0ZW4gaW1wcmFjdGljYWwuDQpXZSBhbHNvIGNvbnNp
ZGVyIHRoYXQgaXQgaXMgYW4gaW1wb3J0YW50IHBvaW50IG9mIHZpZXcuDQpXZSBzZWVtIHRoYXQg
aXQgaXMgZWFzeSB0byBjb250cm9sIG9mIGV4ZWN1dGlvbnMgYnkgZmlsZSBwYXRoIHJhdGhlciB0
aGFuIHhhdHRyIGF0dHJpYnV0ZXMuDQpCZWNhdXNlIHRoZSBXRVVBIGNhbiBlYXNpbHkgZ2V0IGZp
bGUgaW5mb3JtYXRpb24gYnkgZmlsZSBwYXRoIGluIHVzZXIgc3BhY2UuDQoNCkZvciBleGFtcGxl
LCBpbiBpbmR1c3RyaWFsIGNvbnRyb2wgc3lzdGVtcyAoSUNTKSwgdGhlIGZyZXF1ZW5jeSBvZiBz
b2Z0d2FyZSB1cGRhdGVzIGFyZSByYXJlciB0aGFuIGluZm9ybWF0aW9uIHN5c3RlbXMuDQpUaGUg
bWFpbnRlbmFuY2UgY29zdCBvZiB3aGl0ZWxpc3QgaXMgbG93IGluIHN1Y2ggc3lzdGVtcy4gDQpG
b2xsb3dpbmcgdGhlIE5JU1QgZ3VpZGVsaW5lIGRlc2NyaWJlcyBpbXBvcnRhbmNlIG9mIHRoZSB3
aGl0ZWxpc3QgZXhlY3V0aW9uIGNvbnRyb2wgdGVjaG5vbG9neSBmb3IgSUNTLg0KaHR0cHM6Ly9u
dmxwdWJzLm5pc3QuZ292L25pc3RwdWJzL3NwZWNpYWxwdWJsaWNhdGlvbnMvbmlzdC5zcC44MDAt
MTY3LnBkZg0KDQpNb3Jlb3ZlciwgdGhlcmUgYXJlIHZhcmlvdXMgcmVxdWlyZW1lbnRzIGRlcGVu
ZGluZyBvbiBJQ1MuDQpXaGl0ZUVncmV0IHVzZXJzIGNhbiBpbXBsZW1lbnQgdGhlIFdFVUEgd2hp
Y2ggaXMgc3BlY2lhbGl6ZWQgZm9yIHRoZWlyIG93biBJQ1MuDQpJIGd1ZXNzIHRoYXQgbWFpbnRl
bmFuY2UgY29zdCBvZiB3aGl0ZWxpc3QgY2FuIGJlIGRlY3JlYXNlZCBpbiBJQ1MuDQoNCj4gDQo+
IE15ICh0cml2aWFsL3RveS9zaWxseSkgbW9kdWxlIHdlbnQgdGhlIGF0dHJpYnV0ZS1yZWFkaW5n
IHdheToNCj4gDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9za3gvbGludXgtc2VjdXJpdHktbW9kdWxl
cy90cmVlL21hc3Rlci9zZWN1cml0eS93aGkNCj4gdGVsaXN0DQo+IA0KPiBGb3IgYSBjb21wbGV0
ZWx5IGNyYXp5IHRha2UgdXBvbiB0aGUgaWRlYSBvZiB1c2Vyc3BhY2UgZGVjaXNpb25zIA0KPiB0
aG91Z2ggeW91IGNhbiBsYXVnaCBhdCBteSBhdHRlbXB0IGhlcmU6DQo+IA0KPiBodHRwczovL2dp
dGh1Yi5jb20vc2t4L2xpbnV4LXNlY3VyaXR5LW1vZHVsZXMvdHJlZS9tYXN0ZXIvc2VjdXJpdHkv
Y2FuDQo+IC1leGVjDQo+IA0KPiBJIGNhbGxiYWNrIHRvIHVzZXJzcGFjZSBmb3IgZXZlcnkgZGVj
aXNpb24sIHZpYSANCj4gY2FsbF91c2VybW9kZWhlbHBlcl9zZXR1cC4gIFRoZSBjcmF6eSBwYXJ0
IGlzIHRoYXQgaXQgYWN0dWFsbHkgd29ya3MgDQo+IGF0IGFsbCENCj4gDQo+IFN0ZXZlDQoNClRh
a3VtaSBTaGlueWENCg==
