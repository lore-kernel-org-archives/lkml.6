Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id nVcLAGFNGVuVcQAAmS7hNA
	; Thu, 07 Jun 2018 15:21:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D511E6074D; Thu,  7 Jun 2018 15:21:04 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="Bpzgu5ru"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F3FEA6063F;
	Thu,  7 Jun 2018 15:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F3FEA6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=de.bosch.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935747AbeFGPVC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:21:02 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:54334 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933238AbeFGPU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:20:57 -0400
Received: from si0vm1948.rbesz01.com (unknown [139.15.230.188])
        by si0vms0216.rbdmz01.com (Postfix) with ESMTPS id 411q4R6ptXz1XLFt8;
        Thu,  7 Jun 2018 17:20:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=2015-01-21; t=1528384856;
        bh=mfXQHpY21BjtIVf5TQNAWz0DIs0mogTmW9TByj0+HqU=; l=10;
        h=From:From:Reply-To:Sender;
        b=Bpzgu5ru49TMV5PK2wlseI5UBAdtdTKKxBddB37JFahS5nwf3bObhFiFMqPaDHWCU
         BpvHkNq/bwYLGsMnsCA/mRUQ9wVfV2lhL0TohBpuQrrzMDtG9Yll8zt3zkbtELkaCl
         /wjQaB26Z4i3+crNWve3FX+JgelqI4ERnnHntE5M=
Received: from fe0vm1740.rbesz01.com (unknown [10.58.172.176])
        by si0vm1948.rbesz01.com (Postfix) with ESMTPS id 411q4R6ddBz1SD;
        Thu,  7 Jun 2018 17:20:55 +0200 (CEST)
X-AuditID: 0a3aad14-93dff70000003a2f-1d-5b194d648ced
Received: from si0vm1950.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm1740.rbesz01.com (SMG Outbound) with SMTP id 4F.EB.14895.46D491B5; Thu,  7 Jun 2018 17:21:08 +0200 (CEST)
Received: from FE-MBX2039.de.bosch.com (fe-mbx2039.de.bosch.com [10.3.231.49])
        by si0vm1950.rbesz01.com (Postfix) with ESMTPS id 411q4R4m5tzCpP4;
        Thu,  7 Jun 2018 17:20:55 +0200 (CEST)
Received: from SGPMBX2025.APAC.bosch.com (10.187.56.84) by
 FE-MBX2039.de.bosch.com (10.3.231.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1466.3; Thu, 7 Jun 2018 17:20:54 +0200
Received: from FE-MBX2051.de.bosch.com (10.3.231.61) by
 SGPMBX2025.APAC.bosch.com (10.187.56.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1466.3; Thu, 7 Jun 2018 23:20:52 +0800
Received: from FE-MBX2051.de.bosch.com ([fe80::d5b5:44fa:ef15:153e]) by
 FE-MBX2051.de.bosch.com ([fe80::d5b5:44fa:ef15:153e%6]) with mapi id
 15.01.1466.008; Thu, 7 Jun 2018 17:20:50 +0200
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
Thread-Index: AdP+cw4wyTJ2ZZYkTkCGsiGJDRAw4g==
Date: Thu, 7 Jun 2018 15:20:50 +0000
Message-ID: <9888a1ecf621453f8316d94b3547f71b@de.bosch.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.142.147]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA21Tf1CTdRjnu/cdexm8+vKObQ/Tpaw8qbtglJ077DqrO5qXVP7TD3f9eHEv
        sItt+L6DE/8RfwQmXAihjUnDECK4CES7JoirVZyUFyBZKIogq9NlLhIORIXe8QLbH/33PJ8f
        z/N8P++9BEZ7CA1hsTlYzsbk6aLluDy9VfukOTPRpJ86pTV4rl7HDC3TRzDDYGdttKGtvho3
        9BxXGYYCczJD48gZ6WaZ0e06jxsnLg4j4/75H2TGiod6492OR16Tbpc/a2bzLIUsl/rce/Lc
        4uohWf7pxF1n+v2yYjQKh1AMAdQGuFM3iB9CcoKmnBKYnR6Qic1ZBL7S3xaZIILvD/TLlht/
        +bBEbLwIaq6VodCwaCodSj//WRaqE6g98MHpXiwkwqi9Etg/dAcPEQoqA7x9n0pE0UvwR2kN
        EusU+OtCCRaqceoxODnesqAnqU0QbJlY0CNKC+3tfQsajFJDx5/TUvEVFDScFXGglHBrfE7A
        CaFOglrnC6ESox6Hts5U0ZkE1WVjMnF6PPTW+PHDSOWKGOoKO1wRDleE4zjCW5Aym9UXWtM2
        btCncFksv1uflrLDbu1A4mdM8KCqMbMPUQTSxZGvZCSaaClTyBdZfegZQqJTkvWPgolekWU3
        F+UyfO67XEEey+s0JIqKiqIVyzBfkGW18LzFbvMhIDBdAslcVJlo0swU7WY5u2jzoVUErlOT
        B7+8tZ2mchgH+z7L5rPcEruJIHRA3n9ZuCGeY3PYXdmWPMcSrdOKO1WRTORaCRHjQ08TccLu
        X0MjSD6fsfKWnEV7ominl9Cw9Se0hbhdUl6OEf7Bo+UYjdvsNlajJptDU6iQPrfAtnyHZjW5
        /jshEmUEEZ4VQL8jIUkF+fxWwRwn/DPhC4D0KGrfouMXwbDpqROCh7oSCw8q08G9jwOPvwqB
        9/Iggra5vzGYvH8Uh47KdjxESMF73R0DN0f6YqCqbFQOp86VxcLJxnOxMD8ejAPvsaoVMFtz
        ZCVM9XTHQ914BQ3ebz6h4bK7SwHz1b1KuNc0uQqcrR+uhrs3v9bCheGuNXD14941UFc5sBa+
        KrmRBO7OH3Vwr21mPcw5B5Lhyszt5IAQrkQI14gthOtgHP8T7iIafpumGL1d9dkbmTeagkyg
        3ts9lv1wj1SdNNWR31PxS2NMsyKKzriW/o+rrXjnBJ91IjVpgFu7z5Tq4Aq+cL+4sXXLO8kY
        6M3bZo6NOEdfVbsaMlOdwZUH29fNNl/au/nfhu7JglLfNj644/X+sqY3LzWlfNsVCNQc6Br7
        aN3WwxUPVEM7U87rcD6XSXsC43jmP7HuikLLBAAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgT2xpdmVyLA0KDQo+ID4+IFBsZWFzZSBwbGFjZSB0aGUgY29tcGFuaW9uIGRyaXZlciBpbg0K
PiA+Pg0KPiA+PiBkcml2ZXJzL25ldC9jYW4vc3BpL2NvbXBhbmlvbi5jDQo+ID4+DQo+ID4+IEl0
IGFsc28gbWFrZXMgbW9yZSBzZW5zZSBpbiB0aGUgS2NvbmZpZyBzdHJ1Y3R1cmUuDQo+ID4+DQo+
ID4+IFByb2JhYmx5IHRoaXMgbmFtaW5nIHNjaGVtZSBhbHNvIG1ha2VzIHNlbnNlIGZvcg0KPiA+
Pg0KPiA+PiBsaW51eC9kcml2ZXJzL2NoYXIvc3BpL2NvbXBhbmlvbi5jDQo+ID4+DQo+ID4+IHRo
ZW4gLi4uDQo+ID4+DQo+ID4+IElmIG5vdCBpdCBzaG91bGQgYmUgbmFtZWQgYXQgbGVhc3QNCj4g
Pj4NCj4gPj4gZHJpdmVycy9jaGFyL2NvbXBhbmlvbi1zcGkuYw0KPiA+Pg0KPiA+PiBvcg0KPiA+
Pg0KPiA+PiBkcml2ZXJzL2NoYXIvc3BpLWNvbXBhbmlvbi5jDQo+ID4NCj4gPiBXZSBpbnRlbnRp
b25hbGx5IGxlZnQgb3V0IHRoZSBzcGkgaW4gdGhlIGRyaXZlciBwYXRoIC8gbmFtZSBiZWNhdXNl
DQo+ID4gb25seSB0aGUgZHJpdmVycy9zcGkvY29tcGFuaW9uLyogZHJpdmVyIGtub3dzIHRoYXQg
dGhhdCBpdCBpcyBjb25uZWN0ZWQNCj4gPiB0byBTUEkuIFRoZSBvdGhlcnMgKGRyaXZlcnMvbmV0
L2Nhbi9jb21wYW5pb24tY2FuLmMgYW5kDQo+ID4gZHJpdmVycy9jaGFyL2NvbXBhbmlvbi1jaGFy
LmMpIG9ubHkga25vdyB0aGUgQVBJLiBUaGlzIGNvdWxkIGFsc28gYmUNCj4gPiBzdXBwbGllZCBi
eSBhIGRyaXZlciB3aGljaCB0YWxrcyB0byB0aGUgQ29tcGFuaW9uIHZpYSBhIGRpZmZlcmVudA0K
PiA+IGludGVyZmFjZS4gQWN0dWFsbHksIHdlIHN0YXJ0ZWQgd2l0aCBhIFVBUlQgY29ubmVjdGlv
biBidXQgc3dpdGNoZWQgdG8NCj4gPiBTUEkgZHVlIHRvIGxhdGVuY3kgaXNzdWVzLg0KPiANCj4g
T2ssIGdvdCBpdC4NCj4gDQo+ID4gU2hvdWxkIHdlIHN0aWxsIGNoYW5nZSBpdD8NCj4gDQo+IEF0
IGxlYXN0IEkgd291bGQgdGhlbiB2b3RlIGZvcg0KPiANCj4gZHJpdmVycy9jaGFyL2NvbXBhbmlv
bi5jDQo+IGRyaXZlcnMvbmV0L2Nhbi9jb21wYW5pb24uYw0KPiANCj4gaW5zdGVhZCBvZg0KPiAN
Cj4gZHJpdmVycy9jaGFyL2NvbXBhbmlvbi1jaGFyLmMNCj4gZHJpdmVycy9uZXQvY2FuL2NvbXBh
bmlvbi1jYW4uYw0KDQpTb3VuZHMgZ29vZCwgd2lsbCBiZSBjaGFuZ2VkLg0KDQo+IGFzIHlvdSB3
b3VsZCBoYXZlIGNvbXBhbmlvbi11c2VycyBpbiBkaWZmZXJlbnQgZHJpdmVyIHN1YnN5c3RlbXMg
dGhhdA0KPiBhcmUgYWxyZWFkeSBjbGVhcmx5IHJlZmVyZW5jZWQgYnkgdGhlaXIgcGF0aC4NCj4g
DQo+IFRoZSBtb2R1bGVzIGl0c2VsZiBzaG91bGQgc3RpbGwgYmUgbmFtZWQgd2l0aCBjb21wYW5p
b24tY2FuIG9mIGNvdXJzZQ0KPiAoYXMtaXMgcmlnaHQgbm93KS4NCj4gDQo+IEJ0dy4NCj4gDQo+
ICsjZGVmaW5lIERSSVZFUl9OQU1FICAgICAiYm9zY2gsY29tcGFuaW9uLWNhbiINCj4gDQo+ICtz
dGF0aWMgY29uc3Qgc3RydWN0IGNhbl9iaXR0aW1pbmdfY29uc3QgY29tcGFuaW9uX2Nhbl9iaXR0
aW1pbmdfY29uc3QgPSB7DQo+ICsJLm5hbWUgICAgICA9ICJib3NjaCxjb21wYW5pb24iLA0KPiAN
Cj4gDQo+IElzIHRoZXJlIGFueSByZWFzb24gd2h5IGl0J3Mgbm90IG9ubHkgImNvbXBhbmlvbi1j
YW4iIG9yICJjb21wYW5pb24iPw0KPiBUaGUgZmFjdCB0aGF0IHRoZSBkcml2ZXIgaXMgcHJvdmlk
ZWQgYnkgQm9zY2ggaXMgdmlzaWJsZSBpbiB0aGUgc291cmNlIGNvZGUuDQoNCkhtbSwgSSBndWVz
cyB3ZSBtaXhlZCB1cCB0aGUgbmFtaW5nIHNjaGVtZSB1c2VkIGluIGRldmljZXRyZWUuIFdlIHdp
bGwNCnNsZWVwIGEgbmlnaHQgb3ZlciBpdCBhbmQgdGhlbiBjbGVhbiBpdCB1cC4gSSB0aGluayB0
aGUgcmVzdWx0IHdpbGwgYmUNCnRoYXQgdGhlIGRldmljZXRyZWUgZW50cnkgaXMgImJvc2NoLGNv
bXBhbmlvbi1jYW4iIGFuZCBhbGwgb3RoZXIgdXNlcw0KYXJlICJjb21wYW5pb24tY2FuIi4NCg0K
R3JlZXRpbmdzLA0KTWFyaw0KDQpCdWlsZGluZyBUZWNobm9sb2dpZXMsIFBhbmVsIFNvZnR3YXJl
IEZpcmUgKEJULUZJUi9FTkcxKSANCkJvc2NoIFNpY2hlcmhlaXRzc3lzdGVtZSBHbWJIIHwgUG9z
dGZhY2ggMTEgMTEgfCA4NTYyNiBHcmFzYnJ1bm4gfCBHRVJNQU5ZIHwgd3d3LmJvc2Noc2VjdXJp
dHkuY29tDQoNClNpdHo6IFN0dXR0Z2FydCwgUmVnaXN0ZXJnZXJpY2h0OiBBbXRzZ2VyaWNodCBT
dHV0dGdhcnQgSFJCIDIzMTE4IA0KQXVmc2ljaHRzcmF0c3ZvcnNpdHplbmRlcjogU3RlZmFuIEhh
cnR1bmc7IEdlc2Now6RmdHNmw7xocnVuZzogR2VydCB2YW4gSXBlcmVuLCBBbmRyZWFzIEJhcnR6
LCBUaG9tYXMgUXVhbnRlLCBCZXJuaGFyZCBTY2h1c3RlciANCg==
