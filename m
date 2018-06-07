Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 8wmWGHvnGFtPFAAAmS7hNA
	; Thu, 07 Jun 2018 08:06:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9ABD86089E; Thu,  7 Jun 2018 08:06:39 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="pjIK+knG"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0D8FC605A2;
	Thu,  7 Jun 2018 08:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D8FC605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=de.bosch.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932251AbeFGIGf (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:06:35 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:52856 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751681AbeFGIGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:06:25 -0400
Received: from fe0vm1649.rbesz01.com (unknown [139.15.230.188])
        by fe0vms0187.rbdmz01.com (Postfix) with ESMTPS id 411dR33k1Bz1XLFZP;
        Thu,  7 Jun 2018 10:06:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=2015-01-21; t=1528358783;
        bh=mfXQHpY21BjtIVf5TQNAWz0DIs0mogTmW9TByj0+HqU=; l=10;
        h=From:From:Reply-To:Sender;
        b=pjIK+knGl0XXjVNLt7TNIZgc1FpK91Ql31PQ0IsijkhAF3k2TL8YtaGjzmfYLHafD
         v9AJNnMCw+f9xZjifxxqq8F54ioiPhgWYIM5aTHglyDC6Zq/DhVqLq78D/Ervi7TLP
         Zx+/jTuMLwEStChyfO0lAL6NW5GhMojiFeoS7EqQ=
Received: from si0vm2082.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1649.rbesz01.com (Postfix) with ESMTP id 411dR33DDnz25;
        Thu,  7 Jun 2018 10:06:23 +0200 (CEST)
X-AuditID: 0a3aad16-bcfff70000000413-59-5b18e77a8b2b
Received: from si0vm1950.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by si0vm2082.rbesz01.com (SMG Outbound) with SMTP id 5C.65.01043.A77E81B5; Thu,  7 Jun 2018 10:06:18 +0200 (CEST)
Received: from FE-MBX2041.de.bosch.com (fe-mbx2041.de.bosch.com [10.3.231.51])
        by si0vm1950.rbesz01.com (Postfix) with ESMTPS id 411dR30tjGzCpP4;
        Thu,  7 Jun 2018 10:06:23 +0200 (CEST)
Received: from SGPMBX2027.APAC.bosch.com (10.187.56.91) by
 FE-MBX2041.de.bosch.com (10.3.231.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1466.3; Thu, 7 Jun 2018 10:06:22 +0200
Received: from FE-MBX2051.de.bosch.com (10.3.231.61) by
 SGPMBX2027.APAC.bosch.com (10.187.56.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1466.3; Thu, 7 Jun 2018 16:06:19 +0800
Received: from FE-MBX2051.de.bosch.com ([fe80::d5b5:44fa:ef15:153e]) by
 FE-MBX2051.de.bosch.com ([fe80::d5b5:44fa:ef15:153e%6]) with mapi id
 15.01.1466.008; Thu, 7 Jun 2018 10:06:17 +0200
From: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hs@denx.de" <hs@denx.de>,
        "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
Subject: Re: [PATCH 0/5] can: enable multi-queue for SocketCAN devices
Thread-Topic: [PATCH 0/5] can: enable multi-queue for SocketCAN devices
Thread-Index: AdP+Nlk2yTJ2ZZYkTkCGsiGJDRAw4g==
Date: Thu, 7 Jun 2018 08:06:17 +0000
Message-ID: <e8c47bca2ea64b5ab900f4f1e98bb405@de.bosch.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.142.147]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA21Tf0wbZRjm6x30WrjuOEZ5V2Rmp4m/MlbQmQbULG7RziyL0SyO8Ye72hOa
        wRV7BQf/jB/7FehEKhgoiIww1OpaYEwrbDQUM4cSMdQZfoyBUrZJ2DplyzqjzCsHtH/43/s+
        z/s8z/e93x2B0V8TGsLEWzkLzxYwcUpcmXU2bWvZDcjV3voVdJ6rM5jOeb8B0/n7WuJ07vZ6
        XHepTa0bX1iW685c+zZ2h1zf6riM6/8cm0L6qoffyfW1/2r1Sz2bX489oHzByBWYSjjLtpcO
        KvN7v7yBFY0/f7hhqlNWjjq2VyMFAdRzcKmyWV6NlARNNcpgKBiUSc0FBPVjFbjUBBGE5h9g
        603r7DiSGi8C/8JFFDaLo7LgROeP8nC9kToCx3qHVxQYVSGDqvHbeJhIol4B7+gnMmnoVZg/
        0YSkOh2mQ41YuMapx2HolGvFiKSyoTzUvDKDqDTo6hpdmcGoFOi5fj9WugUFHRckHKhk+GNu
        WcQJsd4CLY0vh0uMegrcfdsk5Raor/lt1T0RhpsC+IdI7YgydUQUjiiFI0rRhnAnShZM2pLC
        TK0uM91i4IQybUb6O+bCHiQ9o9qDqgaNPkQRiEkg0Qzk0rFsiVBa6EPbCRmTTLY/JkIqg9lY
        ms8K+W9bigs4gdGQKCYmhk5ah4ViQ6FJEExm3oeAwJiNJDumzqVJI1taxlnMksyHUgmcSSED
        O+4coKk81sod4rgizrLGZhMEA6ThuhiYaOHyuMPvmgqsazSTJmWqo5noWBmh8KFniQQx2xi2
        IIUitlAw5a3KN0lyeg2NSH9Au4nF4zYbRgT8H9swGufNPKdJIfeFXajwfH4xv34OzSPkE4Mi
        kRxFRLwW0BUkbjKJHJwXZxLEfyZyAiA9SS05dOIqGBFlnhY1lE0Fda0M/FOXBQPHc6C10gKe
        gB2Bd8Ivfsueewjqjv6OgXv5FgaToaM4hMo/wsE1No2Dt7syFsb6HHKo8Q4RcNn+vQJuXhtV
        wL3yXiXYa2aVcG6gJh66zwzEw8O5YAJ4m+0q+LupYQOErrQlwqdztTSMzv+lhp6GyU1wt9+Z
        KmZ0pcLSzfNpMDLV/+iCuFqZuNoePiW8Witr/Z/VrqKRm2nKUYxm19kjJ/eeH6kIzr42KO/o
        3vzgYFf31hxUcvqzjEOjUx/EnfsicMylynAb1b2d0+/1L9VOqpuc/K6vJmzxZb8odJnWvbxA
        uLKxz98Ytu+3VwfdRYvqkWa23X3Ksjjx1u2c9w0/7Xvx5JM/z3xzdb+fd7oudu68a9+zU6t6
        05PxzB0GF/LZjKcxi8D+B/PJzWjJBAAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgT2xpdmVyLA0KDQo+ID4gVGhlIGRyaXZlciBzdWl0ZSBjb25zaXN0cyBvZiB0aHJlZSBzZXBh
cmF0ZSBkcml2ZXJzLiBUaGUgZm9sbG93aW5nDQo+ID4gZGlhZ3JhbSBpbGx1c3RyYXRlcyB0aGUg
ZGVwZW5kZW5jaWVzIGluIGxheWVycy4NCj4gPg0KPiA+ICAgICAgICAgICAgIC9kZXYvY29tcGFu
aW9uICAgICAgIFNvY2tldENBTiAgICAgICAgICAgICAgICBVc2VyIFNwYWNlDQo+ID4gLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KPiA+ICAgICAgICAgICArLS0tLS0tLS0tLS0tLS0tLSsgKy0tLS0tLS0tLS0tLS0tLSsN
Cj4gPiAgICAgICAgICAgfCBjb21wYW5pb24tY2hhciB8IHwgY29tcGFuaW9uLWNhbiB8DQo+ID4g
ICAgICAgICAgICstLS0tLS0tLS0tLS0tLS0tKyArLS0tLS0tLS0tLS0tLS0tKw0KPiA+ICAgICAg
ICAgICArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCj4gPiAgICAgICAgICAg
fCAgICAgICAgICBjb21wYW5pb24tc3BpICAgICAgICAgICB8DQo+ID4gICAgICAgICAgICstLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KPiA+ICAgICAgICAgICArLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCj4gPiAgICAgICAgICAgfCAgICAgc3RhbmRhcmQg
U1BJIHN1YnN5c3RlbSAgICAgICB8DQo+ID4gICAgICAgICAgICstLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tKyAgICAgICAgICBMaW51eCBLZXJuZWwNCj4gPiAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+
ID4gICAgICAgICAgICAgICAgIHwgfCB8IHwgICAgICB8IHwgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgSGFyZHdhcmUNCj4gPiAgICAgICAgICAgICAgQ1MtKyB8IHwgfCAgICAgIHwgKy1CVVNZ
DQo+ID4gICAgICAgICAgICAgIENMSy0tKyB8IHwgICAgICArLS0tUkVRVUVTVA0KPiA+ICAgICAg
ICAgICAgICBNT1NJLS0tKyB8DQo+ID4gICAgICAgICAgICAgIE1JU08tLS0tLSsNCj4gPg0KPiA+
IGNvbXBhbmlvbi1zcGkNCj4gPiAgICAgY29yZS5jOiBoYW5kbGVzIFNQSSwgc3lzZnMgZW50cnkg
YW5kIGludGVyZmFjZSB0byB1cHBlciBsYXllcg0KPiA+ICAgICBwcm90b2NvbC1tYW5hZ2VyLmM6
IGhhbmRsZXMgcHJvdG9jb2wgd2l0aCB0aGUgU1BJIEhXDQo+ID4gICAgIHF1ZXVlLW1hbmFnZXIu
YzogaGFuZGxlcyBidWZmZXJpbmcgYW5kIHBhY2tldHMgc2NoZWR1bGluZw0KPiA+DQo+ID4gY29t
cGFuaW9uLWNhbg0KPiA+ICAgICBtYWtlcyB1c2Ugb2YgbXVsdGktcXVldWUgc3VwcG9ydCBhbmQg
YWxsb3dzIHRvIHVzZSB0YyB0byBjb25maWd1cmUNCj4gPiAgICAgdGhlIHF1ZXVpbmcgZGlzY2lw
bGluZSAoZS5nLiBtcXByaW8pLiBUb2dldGhlciB3aXRoIHRoZSBTT19QUklPUklUWQ0KPiA+ICAg
ICBzb2NrZXQgb3B0aW9uIHRoaXMgYWxsb3dzIHRvIHNwZWNpZnkgdGhlIEZJRk8gYSBDQU4gZnJh
bWUgc2hhbGwgYmUNCj4gPiAgICAgc2VudCB0by4NCj4gPg0KPiA+IGNvbXBhbmlvbi1jaGFyDQo+
ID4gICAgIGhhbmRsZXMgbWVzc2FnZXMgdG8gb3RoZXIgdW5kaXNjbG9zZWQgZnVuY3Rpb25hbGl0
eSBiZXlvbmQgQ0FOLg0KDQo+ID4gICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvYm9zY2gs
Y29tcGFuaW9uLnR4dCAgICB8ICAgODIgKysNCj4gPiAgIGRyaXZlcnMvY2hhci9LY29uZmlnICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgNyArDQo+ID4gICBkcml2ZXJzL2NoYXIv
TWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDIgKw0KPiA+ICAgZHJp
dmVycy9jaGFyL2NvbXBhbmlvbi1jaGFyLmMgICAgICAgICAgICAgICAgICAgICAgfCAgMzY3ICsr
KysrKw0KPiA+ICAgZHJpdmVycy9uZXQvY2FuL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgICA4ICsNCj4gPiAgIGRyaXZlcnMvbmV0L2Nhbi9NYWtlZmlsZSAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICAgMSArDQo+ID4gICBkcml2ZXJzL25ldC9jYW4vY29tcGFuaW9u
LWNhbi5jICAgICAgICAgICAgICAgICAgICB8ICA2OTQgKysrKysrKysrKysrDQo+IA0KPiBQbGVh
c2UgcGxhY2UgdGhlIGNvbXBhbmlvbiBkcml2ZXIgaW4NCj4gDQo+IGRyaXZlcnMvbmV0L2Nhbi9z
cGkvY29tcGFuaW9uLmMNCj4gDQo+IEl0IGFsc28gbWFrZXMgbW9yZSBzZW5zZSBpbiB0aGUgS2Nv
bmZpZyBzdHJ1Y3R1cmUuDQo+IA0KPiBQcm9iYWJseSB0aGlzIG5hbWluZyBzY2hlbWUgYWxzbyBt
YWtlcyBzZW5zZSBmb3INCj4gDQo+IGxpbnV4L2RyaXZlcnMvY2hhci9zcGkvY29tcGFuaW9uLmMN
Cj4gDQo+IHRoZW4gLi4uDQo+IA0KPiBJZiBub3QgaXQgc2hvdWxkIGJlIG5hbWVkIGF0IGxlYXN0
DQo+IA0KPiBkcml2ZXJzL2NoYXIvY29tcGFuaW9uLXNwaS5jDQo+IA0KPiBvcg0KPiANCj4gZHJp
dmVycy9jaGFyL3NwaS1jb21wYW5pb24uYw0KDQpXZSBpbnRlbnRpb25hbGx5IGxlZnQgb3V0IHRo
ZSBzcGkgaW4gdGhlIGRyaXZlciBwYXRoIC8gbmFtZSBiZWNhdXNlDQpvbmx5IHRoZSBkcml2ZXJz
L3NwaS9jb21wYW5pb24vKiBkcml2ZXIga25vd3MgdGhhdCB0aGF0IGl0IGlzIGNvbm5lY3RlZA0K
dG8gU1BJLiBUaGUgb3RoZXJzIChkcml2ZXJzL25ldC9jYW4vY29tcGFuaW9uLWNhbi5jIGFuZA0K
ZHJpdmVycy9jaGFyL2NvbXBhbmlvbi1jaGFyLmMpIG9ubHkga25vdyB0aGUgQVBJLiBUaGlzIGNv
dWxkIGFsc28gYmUNCnN1cHBsaWVkIGJ5IGEgZHJpdmVyIHdoaWNoIHRhbGtzIHRvIHRoZSBDb21w
YW5pb24gdmlhIGEgZGlmZmVyZW50DQppbnRlcmZhY2UuIEFjdHVhbGx5LCB3ZSBzdGFydGVkIHdp
dGggYSBVQVJUIGNvbm5lY3Rpb24gYnV0IHN3aXRjaGVkIHRvDQpTUEkgZHVlIHRvIGxhdGVuY3kg
aXNzdWVzLg0KDQpTaG91bGQgd2Ugc3RpbGwgY2hhbmdlIGl0Pw0KDQo+ID4gICBkcml2ZXJzL25l
dC9jYW4vZGV2LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDggKy0NCj4gPiAg
IGRyaXZlcnMvc3BpL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAg
MiArDQo+ID4gICBkcml2ZXJzL3NwaS9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgIDIgKw0KPiA+ICAgZHJpdmVycy9zcGkvY29tcGFuaW9uL0tjb25maWcgICAgICAg
ICAgICAgICAgICAgICAgfCAgICA1ICsNCj4gPiAgIGRyaXZlcnMvc3BpL2NvbXBhbmlvbi9NYWtl
ZmlsZSAgICAgICAgICAgICAgICAgICAgIHwgICAgMiArDQo+ID4gICBkcml2ZXJzL3NwaS9jb21w
YW5pb24vY29yZS5jICAgICAgICAgICAgICAgICAgICAgICB8IDExODkgKysrKysrKysrKysrKysr
KysrKysNCj4gPiAgIGRyaXZlcnMvc3BpL2NvbXBhbmlvbi9wcm90b2NvbC1tYW5hZ2VyLmMgICAg
ICAgICAgIHwgMTAzNSArKysrKysrKysrKysrKysrKw0KPiA+ICAgZHJpdmVycy9zcGkvY29tcGFu
aW9uL3Byb3RvY29sLW1hbmFnZXIuaCAgICAgICAgICAgfCAgMzQ4ICsrKysrKw0KPiA+ICAgZHJp
dmVycy9zcGkvY29tcGFuaW9uL3Byb3RvY29sLmggICAgICAgICAgICAgICAgICAgfCAgMjczICsr
KysrDQo+ID4gICBkcml2ZXJzL3NwaS9jb21wYW5pb24vcXVldWUtbWFuYWdlci5jICAgICAgICAg
ICAgICB8ICAxNDYgKysrDQo+ID4gICBkcml2ZXJzL3NwaS9jb21wYW5pb24vcXVldWUtbWFuYWdl
ci5oICAgICAgICAgICAgICB8ICAyNDUgKysrKw0KPiA+ICAgaW5jbHVkZS9saW51eC9jYW4vZGV2
LmggICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICA3ICstDQo+ID4gICBpbmNsdWRlL2xp
bnV4L2NvbXBhbmlvbi5oICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyNTggKysrKysNCj4g
PiAgIDIwIGZpbGVzIGNoYW5nZWQsIDQ2NzcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkN
Cj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc3BpL2Jvc2NoLGNvbXBhbmlvbi50eHQNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL2NoYXIvY29tcGFuaW9uLWNoYXIuYw0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvbmV0L2Nhbi9jb21wYW5pb24tY2FuLmMNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL3NwaS9jb21wYW5pb24vS2NvbmZpZw0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvc3BpL2NvbXBhbmlvbi9NYWtlZmlsZQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvc3BpL2NvbXBhbmlvbi9jb3JlLmMNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL3NwaS9jb21wYW5pb24vcHJvdG9jb2wtbWFuYWdlci5jDQo+ID4gICBjcmVhdGUgbW9kZSAx
MDA2NDQgZHJpdmVycy9zcGkvY29tcGFuaW9uL3Byb3RvY29sLW1hbmFnZXIuaA0KPiA+ICAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc3BpL2NvbXBhbmlvbi9wcm90b2NvbC5oDQo+ID4gICBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zcGkvY29tcGFuaW9uL3F1ZXVlLW1hbmFnZXIuYw0K
PiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc3BpL2NvbXBhbmlvbi9xdWV1ZS1tYW5h
Z2VyLmgNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2xpbnV4L2NvbXBhbmlvbi5o
DQoNCkdyZWV0aW5ncywNCk1hcmsNCg0KQnVpbGRpbmcgVGVjaG5vbG9naWVzLCBQYW5lbCBTb2Z0
d2FyZSBGaXJlIChCVC1GSVIvRU5HMSkgDQpCb3NjaCBTaWNoZXJoZWl0c3N5c3RlbWUgR21iSCB8
IFBvc3RmYWNoIDExIDExIHwgODU2MjYgR3Jhc2JydW5uIHwgR0VSTUFOWSB8IHd3dy5ib3NjaHNl
Y3VyaXR5LmNvbQ0KDQpTaXR6OiBTdHV0dGdhcnQsIFJlZ2lzdGVyZ2VyaWNodDogQW10c2dlcmlj
aHQgU3R1dHRnYXJ0IEhSQiAyMzExOCANCkF1ZnNpY2h0c3JhdHN2b3JzaXR6ZW5kZXI6IFN0ZWZh
biBIYXJ0dW5nOyBHZXNjaMOkZnRzZsO8aHJ1bmc6IEdlcnQgdmFuIElwZXJlbiwgQW5kcmVhcyBC
YXJ0eiwgVGhvbWFzIFF1YW50ZSwgQmVybmhhcmQgU2NodXN0ZXINCg==
