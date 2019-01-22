Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BAEC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9292E20866
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbfAVXUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 18:20:02 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2078 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726546AbfAVXUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 18:20:01 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 8254F375E08DEB2AA6E0;
        Wed, 23 Jan 2019 07:19:57 +0800 (CST)
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.243]) by
 DGGEMM403-HUB.china.huawei.com ([10.3.20.211]) with mapi id 14.03.0415.000;
 Wed, 23 Jan 2019 07:19:47 +0800
From:   tanhuazhong <tanhuazhong@huawei.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        huangdaode <huangdaode@hisilicon.com>,
        "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Linuxarm <linuxarm@huawei.com>,
        "shenjian (K)" <shenjian15@huawei.com>,
        "lipeng (Y)" <lipeng321@huawei.com>
Subject: RE: [PATCH net-next 02/12] net: hns3: add rx multicast packets
 statistic
Thread-Topic: [PATCH net-next 02/12] net: hns3: add rx multicast packets
 statistic
Thread-Index: AQHUsnEhsTdwcY252Eei7W4riB8KPaW7GJ6AgADUSxA=
Date:   Tue, 22 Jan 2019 23:19:46 +0000
Message-ID: <71BFC6CB37D69B45A6C87FB2E31733AC01CEBC1C@dggemm511-mbx.china.huawei.com>
References: <20190122163940.7876-1-tanhuazhong@huawei.com>
 <20190122163940.7876-3-tanhuazhong@huawei.com>
 <c915dbd7-8a04-9b38-bb5f-a3e8340ce6a2@gmail.com>
In-Reply-To: <c915dbd7-8a04-9b38-bb5f-a3e8340ce6a2@gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.45.143.16]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBFcmljIER1bWF6ZXQgW21haWx0
bzplcmljLmR1bWF6ZXRAZ21haWwuY29tXSANClNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAyMywg
MjAxOSAyOjM5IEFNDQpUbzogdGFuaHVhemhvbmcgPHRhbmh1YXpob25nQGh1YXdlaS5jb20+OyBk
YXZlbUBkYXZlbWxvZnQubmV0DQpDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgaHVhbmdkYW9kZSA8aHVhbmdkYW9kZUBoaXNpbGljb24uY29t
PjsgWmh1YW5neXV6ZW5nIChZaXNlbikgPHlpc2VuLnpodWFuZ0BodWF3ZWkuY29tPjsgU2FsaWwg
TWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+OyBMaW51eGFybSA8bGludXhhcm1AaHVhd2Vp
LmNvbT47IHNoZW5qaWFuIChLKSA8c2hlbmppYW4xNUBodWF3ZWkuY29tPjsgbGlwZW5nIChZKSA8
bGlwZW5nMzIxQGh1YXdlaS5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0IDAyLzEy
XSBuZXQ6IGhuczM6IGFkZCByeCBtdWx0aWNhc3QgcGFja2V0cyBzdGF0aXN0aWMNCg0KDQoNCk9u
IDAxLzIyLzIwMTkgMDg6MzkgQU0sIEh1YXpob25nIFRhbiB3cm90ZToNCj4gRnJvbTogSmlhbiBT
aGVuIDxzaGVuamlhbjE1QGh1YXdlaS5jb20+DQo+IA0KPiBUaGlzIHBhdGNoIGFkZHMgcnggbXVs
dGljYXN0IHBhY2tldHMgc3RhdGlzdGljIGZvciBlYWNoIHJpbmcuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBKaWFuIFNoZW4gPHNoZW5qaWFuMTVAaHVhd2VpLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTog
UGVuZyBMaSA8bGlwZW5nMzIxQGh1YXdlaS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEh1YXpob25n
IFRhbiA8dGFuaHVhemhvbmdAaHVhd2VpLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhl
cm5ldC9oaXNpbGljb24vaG5zMy9obnMzX2VuZXQuYyAgICB8IDkgKysrKysrKysrDQo+ICBkcml2
ZXJzL25ldC9ldGhlcm5ldC9oaXNpbGljb24vaG5zMy9obnMzX2VuZXQuaCAgICB8IDggKysrKysr
KysNCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2hpc2lsaWNvbi9obnMzL2huczNfZXRodG9vbC5j
IHwgMSArDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9oaXNpbGljb24vaG5zMy9obnMzX2VuZXQuYyBi
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2hpc2lsaWNvbi9obnMzL2huczNfZW5ldC5jDQo+IGluZGV4
IDlkZDg5NDkzODFiYy4uZjFhYjJlNGNhNDllIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9oaXNpbGljb24vaG5zMy9obnMzX2VuZXQuYw0KPiArKysgYi9kcml2ZXJzL25ldC9l
dGhlcm5ldC9oaXNpbGljb24vaG5zMy9obnMzX2VuZXQuYw0KPiBAQCAtMjU3Miw2ICsyNTcyLDcg
QEAgc3RhdGljIGludCBobnMzX2hhbmRsZV9yeF9iZChzdHJ1Y3QgaG5zM19lbmV0X3JpbmcgKnJp
bmcsDQo+ICAJCQkgICAgIHN0cnVjdCBza19idWZmICoqb3V0X3NrYikNCj4gIHsNCj4gIAlzdHJ1
Y3QgbmV0X2RldmljZSAqbmV0ZGV2ID0gcmluZy0+dHFwLT5oYW5kbGUtPmtpbmZvLm5ldGRldjsN
Cj4gKwllbnVtIGhuczNfcGt0X2wydF90eXBlIGwyX2ZyYW1lX3R5cGU7DQo+ICAJc3RydWN0IHNr
X2J1ZmYgKnNrYiA9IHJpbmctPnNrYjsNCj4gIAlzdHJ1Y3QgaG5zM19kZXNjX2NiICpkZXNjX2Ni
Ow0KPiAgCXN0cnVjdCBobnMzX2Rlc2MgKmRlc2M7DQo+IEBAIC0yNjgwLDYgKzI2ODEsMTQgQEAg
c3RhdGljIGludCBobnMzX2hhbmRsZV9yeF9iZChzdHJ1Y3QgaG5zM19lbmV0X3JpbmcgKnJpbmcs
DQo+ICAJCXJldHVybiAtRUZBVUxUOw0KPiAgCX0NCj4gIA0KPiArCWwyX2ZyYW1lX3R5cGUgPSBo
bmFlM19nZXRfZmllbGQobDIzNGluZm8sIEhOUzNfUlhEX0RNQUNfTSwNCj4gKwkJCQkJSE5TM19S
WERfRE1BQ19TKTsNCj4gKwlpZiAobDJfZnJhbWVfdHlwZSA9PSBITlMzX0wyX1RZUEVfTVVMVElD
QVNUKSB7DQo+ICsJCXU2NF9zdGF0c191cGRhdGVfYmVnaW4oJnJpbmctPnN5bmNwKTsNCj4gKwkJ
cmluZy0+c3RhdHMucnhfbXVsdGljYXN0Kys7DQo+ICsJCXU2NF9zdGF0c191cGRhdGVfZW5kKCZy
aW5nLT5zeW5jcCk7DQo+ICsJfQ0KPiArDQo+ICAJdTY0X3N0YXRzX3VwZGF0ZV9iZWdpbigmcmlu
Zy0+c3luY3ApOw0KDQoNClRoaXMgaXMgYSBiaXQgc3Vib3B0aW1hbCB0byBjYWxsIHU2NF9zdGF0
c191cGRhdGVfYmVnaW4oKSB0d2ljZS4NCg0KWW91IGNvdWxkIHJld3JpdGUgdGhlIHRoaW5nIHRv
IGJlIDoNCg0KICAgICAgICB1NjRfc3RhdHNfdXBkYXRlX2JlZ2luKCZyaW5nLT5zeW5jcCk7DQog
ICAgICAgIGlmIChsMl9mcmFtZV90eXBlID09IEhOUzNfTDJfVFlQRV9NVUxUSUNBU1QpDQogICAg
ICAgICAgICAgcmluZy0+c3RhdHMucnhfbXVsdGljYXN0Kys7DQogICAgICAgICAgIA0KCXJpbmct
PnN0YXRzLnJ4X3BrdHMrKzsNCgkuLi4NCg0KT2ssIHRoYW5rcy4NCg0KPiAgCXJpbmctPnN0YXRz
LnJ4X3BrdHMrKzsNCj4gIAlyaW5nLT5zdGF0cy5yeF9ieXRlcyArPSBza2ItPmxlbjsNCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2hpc2lsaWNvbi9obnMzL2huczNfZW5ldC5o
IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaGlzaWxpY29uL2huczMvaG5zM19lbmV0LmgNCj4gaW5k
ZXggZjU5YWI3Mzg3YjFmLi5mM2QyNDg2MjZhYjMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2hpc2lsaWNvbi9obnMzL2huczNfZW5ldC5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2hpc2lsaWNvbi9obnMzL2huczNfZW5ldC5oDQo+IEBAIC0yMDIsNiArMjAyLDEz
IEBAIGVudW0gaG5zM19uaWNfc3RhdGUgew0KPiAgDQo+ICAjZGVmaW5lIEhOUzNfUklOR19FTl9C
CQkJCTANCj4gIA0KPiArZW51bSBobnMzX3BrdF9sMnRfdHlwZSB7DQo+ICsJSE5TM19MMl9UWVBF
X1VOSUNBU1QsDQo+ICsJSE5TM19MMl9UWVBFX01VTFRJQ0FTVCwNCj4gKwlITlMzX0wyX1RZUEVf
QlJPQURDQVNULA0KPiArCUhOUzNfTDJfVFlQRV9JTlZBTElELA0KPiArfTsNCj4gKw0KPiAgZW51
bSBobnMzX3BrdF9sM3RfdHlwZSB7DQo+ICAJSE5TM19MM1RfTk9ORSwNCj4gIAlITlMzX0wzVF9J
UFY2LA0KPiBAQCAtMzc2LDYgKzM4Myw3IEBAIHN0cnVjdCByaW5nX3N0YXRzIHsNCj4gIAkJCXU2
NCBlcnJfYmRfbnVtOw0KPiAgCQkJdTY0IGwyX2VycjsNCj4gIAkJCXU2NCBsM2w0X2NzdW1fZXJy
Ow0KPiArCQkJdTY0IHJ4X211bHRpY2FzdDsNCj4gIAkJfTsNCj4gIAl9Ow0KPiAgfTsNCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2hpc2lsaWNvbi9obnMzL2huczNfZXRodG9v
bC5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaGlzaWxpY29uL2huczMvaG5zM19ldGh0b29sLmMN
Cj4gaW5kZXggZTY3OGI2OTM5ZGEzLi5hYmI3ODY5NmQ3Y2UgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvbmV0L2V0aGVybmV0L2hpc2lsaWNvbi9obnMzL2huczNfZXRodG9vbC5jDQo+ICsrKyBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2hpc2lsaWNvbi9obnMzL2huczNfZXRodG9vbC5jDQo+IEBAIC00
Nyw2ICs0Nyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaG5zM19zdGF0cyBobnMzX3J4cV9zdGF0
c1tdID0gew0KPiAgCUhOUzNfVFFQX1NUQVQoImVycl9iZF9udW0iLCBlcnJfYmRfbnVtKSwNCj4g
IAlITlMzX1RRUF9TVEFUKCJsMl9lcnIiLCBsMl9lcnIpLA0KPiAgCUhOUzNfVFFQX1NUQVQoImwz
bDRfY3N1bV9lcnIiLCBsM2w0X2NzdW1fZXJyKSwNCj4gKwlITlMzX1RRUF9TVEFUKCJtdWx0aWNh
c3QiLCByeF9tdWx0aWNhc3QpLA0KPiAgfTsNCj4gIA0KPiAgI2RlZmluZSBITlMzX1JYUV9TVEFU
U19DT1VOVCBBUlJBWV9TSVpFKGhuczNfcnhxX3N0YXRzKQ0KPiANCg==
