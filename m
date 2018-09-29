Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAD5C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 15:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB3320879
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 15:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB3320879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbeI2ViN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 17:38:13 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2088 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728284AbeI2ViN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 17:38:13 -0400
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id D3C23510DD457;
        Sat, 29 Sep 2018 16:09:23 +0100 (IST)
Received: from FRAEML702-CAH.china.huawei.com (10.206.14.33) by
 lhreml701-cah.china.huawei.com (10.201.108.42) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Sat, 29 Sep 2018 16:09:25 +0100
Received: from FRAEML521-MBX.china.huawei.com ([169.254.1.206]) by
 fraeml702-cah.china.huawei.com ([10.206.14.33]) with mapi id 14.03.0399.000;
 Sat, 29 Sep 2018 17:09:19 +0200
From:   Salil Mehta <salil.mehta@huawei.com>
To:     David Miller <davem@davemloft.net>,
        Eric Dumazet <eric.dumazet@gmail.com>
CC:     "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>,
        "lipeng (Y)" <lipeng321@huawei.com>,
        "mehta.salil@opnsrc.net" <mehta.salil@opnsrc.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH net-next 00/10] Cleanups, minor additions & fixes for
 HNS3 driver
Thread-Topic: [PATCH net-next 00/10] Cleanups, minor additions & fixes for
 HNS3 driver
Thread-Index: AQHUVcbe/TFFIESkxk2NnI752x0jzqUF1woAgAAVu4CAARKbkA==
Date:   Sat, 29 Sep 2018 15:09:18 +0000
Message-ID: <F4CC6FACFEB3C54C9141D49AD221F7F93BF10CA1@FRAEML521-MBX.china.huawei.com>
References: <20180926182840.28392-1-salil.mehta@huawei.com>
 <20180928.103826.486456665561471777.davem@davemloft.net>
 <8cc644da-f6f2-9dd4-8f97-b1fa6d9deae7@gmail.com>
In-Reply-To: <8cc644da-f6f2-9dd4-8f97-b1fa6d9deae7@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.85.66]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGF2aWQvRXJpYywNCkkgbWlzc2VkIHRvIGluY2x1ZGUgYSBwYXRjaCBkdXJpbmcgYSBwYXRj
aC1zZXQgc3VibWlzc2lvbiB3aGljaCBjYXVzZWQgc29tZSBidWlsZCBlcnJvcnMuIA0KSSBoYXZl
IGZpeGVkIHRoYXQgaW4gVjIgdmVyc2lvbiBvZiB0aGlzIHBhdGNoLXNldC4gDQoNClRoZSBvbmx5
IGNoYW5nZSBiZXR3ZWVuIFYxLS0+VjIgaXMgaW4gcGF0Y2g6DQogImhuczM6IEFkZCBzZXJkZXMg
cGFyYWxsZWwgaW5uZXIgIGxvb3BiYWNrIHN1cHBvcnQiDQoNClRoaXMgYWxzbyBmaXhlcyB0aGUg
c3BlbGxpbmcgbWlzdGFrZSBpZGVudGlmaWVkIGJ5IERhdmlkIGFuZCBlcnJvciBzaG93bg0KYnkg
RXJpYyBEdW1hemV0Lg0KDQpTb3JyeSBmb3IgYW55IGluIGNvbnZlbmllbmNlIGNhdXNlZC4NCg0K
VGhhbmtzICYgcmVnYXJkcw0KU2FsaWwNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogRXJpYyBEdW1hemV0IFttYWlsdG86ZXJpYy5kdW1hemV0QGdtYWlsLmNvbV0NCj4gU2Vu
dDogRnJpZGF5LCBTZXB0ZW1iZXIgMjgsIDIwMTggNzo1NiBQTQ0KPiBUbzogRGF2aWQgTWlsbGVy
IDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgU2FsaWwgTWVodGENCj4gPHNhbGlsLm1laHRhQGh1YXdl
aS5jb20+DQo+IENjOiBaaHVhbmd5dXplbmcgKFlpc2VuKSA8eWlzZW4uemh1YW5nQGh1YXdlaS5j
b20+OyBsaXBlbmcgKFkpDQo+IDxsaXBlbmczMjFAaHVhd2VpLmNvbT47IG1laHRhLnNhbGlsQG9w
bnNyYy5uZXQ7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIG5ldC1uZXh0IDAwLzEwXSBDbGVhbnVwcywgbWlub3IgYWRkaXRpb25zICYgZml4ZXMN
Cj4gZm9yIEhOUzMgZHJpdmVyDQo+IA0KPiANCj4gDQo+IE9uIDA5LzI4LzIwMTggMTA6MzggQU0s
IERhdmlkIE1pbGxlciB3cm90ZToNCj4gPiBGcm9tOiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFA
aHVhd2VpLmNvbT4NCj4gPiBEYXRlOiBXZWQsIDI2IFNlcCAyMDE4IDE5OjI4OjMwICswMTAwDQo+
ID4NCj4gPj4gVGhpcyBwYXRjaC1zZXQgY29udGFpbnMgY2xlYW5zLXVwcywgbWlub3IgY2hhbmdl
cyBhbmQgZml4ZXMgdG8gdGhlDQo+IEhOUzMgZHJpdmVyLg0KPiA+DQo+ID4gU2VyaWVzIGFwcGxp
ZWQsIHRoYW5rIHlvdS4NCj4gPg0KPiANCj4gU29tZXRoaW5nIHNlZW1zIHdyb25nDQo+IA0KPiAj
IGdpdCBncmVwIC1uIEhOUzNfU0VMRl9URVNUX1RZUEVfTlVNDQo+IGRyaXZlcnMvbmV0L2V0aGVy
bmV0L2hpc2lsaWNvbi9obnMzL2huczNfZXRodG9vbC5jOjI3ODogaW50DQo+IHN0X3BhcmFtW0hO
UzNfU0VMRl9URVNUX1RZUEVfTlVNXVsyXTsNCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvaGlzaWxp
Y29uL2huczMvaG5zM19ldGh0b29sLmM6MzE2OiBmb3IgKGkgPSAwOyBpIDwNCj4gSE5TM19TRUxG
X1RFU1RfVFlQRV9OVU07IGkrKykgew0KPiANCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvaGlzaWxp
Y29uL2huczMvaG5zM19ldGh0b29sLmM6IEluIGZ1bmN0aW9uDQo+ICdobnMzX3NlbGZfdGVzdCc6
DQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2hpc2lsaWNvbi9obnMzL2huczNfZXRodG9vbC5jOjI3
ODoxNTogZXJyb3I6DQo+ICdITlMzX1NFTEZfVEVTVF9UWVBFX05VTScgdW5kZWNsYXJlZCAoZmly
c3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2hpc2lsaWNv
bi9obnMzL2huczNfZXRodG9vbC5jOjI3ODoxNTogbm90ZTogZWFjaA0KPiB1bmRlY2xhcmVkIGlk
ZW50aWZpZXIgaXMgcmVwb3J0ZWQgb25seSBvbmNlIGZvciBlYWNoIGZ1bmN0aW9uIGl0DQo+IGFw
cGVhcnMgaW4NCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvaGlzaWxpY29uL2huczMvaG5zM19ldGh0
b29sLmM6Mjc4OjY6IGVycm9yOiB1bnVzZWQNCj4gdmFyaWFibGUgJ3N0X3BhcmFtJyBbLVdlcnJv
cj11bnVzZWQtdmFyaWFibGVdDQo=
