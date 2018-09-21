Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6CEECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C6921550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="G5cCn6GF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C6921550
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391359AbeIVBWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:22:43 -0400
Received: from mail-sn1nam02on0097.outbound.protection.outlook.com ([104.47.36.97]:51744
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391251AbeIVBWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2/xb7s8LeGX0f4wtcjDddRnsZiu7OloRf0sI+usyxc=;
 b=G5cCn6GFXYMDeErrVc2mXZYJzBOrLxhillGmJgvxvmjrdYfZo3fHYdS6ncShNVnwKbv+YAbQX4JcIX5yzW/9KasyTHD9eSE8rRd/ZtAF+QUWWhXklh4NlpTVWAsBTrLTbu3SJgmtlYQuXwfCLtCU2qQ9vn59NKwS2TLa9WTr/kM=
Received: from BYAPR08MB4934.namprd08.prod.outlook.com (20.176.255.143) by
 BYAPR08MB5368.namprd08.prod.outlook.com (52.135.241.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.14; Fri, 21 Sep 2018 19:32:18 +0000
Received: from BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981]) by BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981%5]) with mapi id 15.20.1143.017; Fri, 21 Sep 2018
 19:32:18 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Arnd Bergmann <arnd@arndb.de>, Firoz Khan <firoz.khan@linaro.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: Re: [PATCH 0/3] System call table generation support
Thread-Topic: [PATCH 0/3] System call table generation support
Thread-Index: AQHUTAZndJ66Nr5INkGiO2D9iPvZmKT0vIcAgASOZ4CAAGObgIAAnMiAgADgPQA=
Date:   Fri, 21 Sep 2018 19:32:18 +0000
Message-ID: <20180921193216.wta4bvmmbp2jyasl@pburton-laptop>
References: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org>
 <20180917171720.wda5qrl7hyyacmwl@pburton-laptop>
 <CAK8P3a1=BriZ7hgzgK4QpAT00MBEtXaKOSU+vdHN1=5owB9i4A@mail.gmail.com>
 <20180920204833.gpypjjxcmxjupls6@pburton-laptop>
 <20180921060941.GB13865@infradead.org>
In-Reply-To: <20180921060941.GB13865@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR1101CA0022.namprd11.prod.outlook.com
 (2603:10b6:910:15::32) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB5368;6:59P6iCW50Aarssbs9kibHx5oCq8hRKC70GaQtUjsz8HWqKmFxDELSMu+f2hAVO5kdKSHToeWt16MJaXMn3H3/eGH3qO7Qbcc0Kx+eFxD6wv1H14EkIoaN710GVzH5Q0gUDcfd7PoqDZLden1z8+xIvJvB/fiQZMKJBw/yw2YFMbPhaE0HHdVMFYOU/NvMJagSNTq5xJltDRKc55TAnKVNz8X+yW91pbOa1DTWemoW0jA4Tx2utF4OYHPzQfZGT896lliZU60XxiYko9y75lxFUgxgl/1hhuSMdmOxTDZR+Q721wRVSm7MNh0yZOUHuDx+FSCCj/cnwWL5Hbk8wXDdc/BJ+OSK/XTtvKlUIzkOgNNl/VVIQUGbdRivBLF9FKHcBfdULNPpoLBnrnU5Cj3m9tNAX4Ag6gbIXv3Hh3wAvByxQ9c90XOldyjLutzs6genRBrYnaTbJqAB9SBKv2Jaw==;5:1pUKLVZPjDReulnEwgKU4vI9O3uzdDuJVKb5CCcjML/cpU3lv6C/oziFkO3HUrsF14bXYCw7pw7T5+0gKm5qxXyeHSmrmhuttm1wfkBPSipkMkcex1FiSCzw///iZapAwewVeN4GXvfoi3qko2WUJILdGR7YfT+/xj7dcdOFvCU=;7:wuifRsvTgrAYrVjIA0SjCgQb75eXZER3C2VonlFANYdpPWxAnzbP/Iklq2qVqQjhr4qFc/DZHVgn/grGCgKV0eV5StNddxHm6SrKhfr6rkvuG2hDCVB/1qc2WyPQQhvpVKdv87Dk7rVLGx5uKWwjO8gamkmnlN9jsV1u1LLRwhpOfROYkhogm81eGFJAUN/69xH+JeIPyte0owuT4fRfxmpS+vjICBpFAAUIz7BlcI91/7y1Bp5kMNkKWeYxsUxW
x-ms-office365-filtering-correlation-id: defa9bc6-c8ad-48aa-30d2-08d61ff8f162
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB5368;
x-ms-traffictypediagnostic: BYAPR08MB5368:
x-microsoft-antispam-prvs: <BYAPR08MB5368CA1D1F5B8BD7966D4661C1120@BYAPR08MB5368.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3231355)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051);SRVR:BYAPR08MB5368;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB5368;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39840400004)(396003)(366004)(346002)(136003)(376002)(189003)(199004)(76176011)(316002)(53936002)(66066001)(6436002)(58126008)(52116002)(42882007)(446003)(6916009)(14454004)(106356001)(11346002)(4326008)(33716001)(476003)(25786009)(6246003)(6486002)(2900100001)(39060400002)(44832011)(9686003)(54906003)(2906002)(93886005)(71190400001)(71200400001)(486006)(81156014)(6506007)(386003)(8936002)(8676002)(102836004)(6512007)(68736007)(5660300001)(256004)(7736002)(14444005)(99286004)(5250100002)(1076002)(3846002)(6116002)(33896004)(305945005)(186003)(229853002)(26005)(7416002)(97736004)(105586002)(478600001)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB5368;H:BYAPR08MB4934.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bW+d6PiCqVDiinxGSz3Dj9PQK4gP52lMWlHdVurXnqiODu+KgJyGMDVtczgHUVEB7KBNEc/IAYjCWOS/C06oNHtNHWSi5VXNUN8pnDjZ3pxfGQ/4vAnw92H8yym9caN4LTfbrT+gEgX7AmdWS8bw0peLfXPIieyMsJilKCYItJC6+qAocpyl/vG8o1W0gQ7GSl3Q6WSvh42wsV54McTT3soMYL6bbhRJU+bK8yCddKRGIMdLtXf1Ibwx4IW3xJVBu+SkMlmfwmH2uOXQZDtJTtruC3wDAEx4Uclc5AytBsUXRsIZ6z6wViYDgIAhvbBJBXoNiP2VyGyN90S09JJLzJAUAR9KojpIyTFldr+fq4Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <68F2D21C2AB6864B8A20E470BD24A6B1@namprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: defa9bc6-c8ad-48aa-30d2-08d61ff8f162
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 19:32:18.7822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB5368
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hyaXN0b3BoLA0KDQpPbiBUaHUsIFNlcCAyMCwgMjAxOCBhdCAxMTowOTo0MVBNIC0wNzAw
LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gVGh1LCBTZXAgMjAsIDIwMTggYXQgMDg6
NDg6MzdQTSArMDAwMCwgUGF1bCBCdXJ0b24gd3JvdGU6DQo+ID4gPiBTcGVha2luZyBvZiBuYW5v
TUlQUywgd2hhdCBpcyB5b3VyIHBsYW4gZm9yIHRoZSBzeXNjYWxsIEFCSSB0aGVyZT8NCj4gPiA+
IEkgY2FuIHNlZSB0d28gd2F5cyBvZiBhcHByb2FjaGluZyBpdDoNCj4gPiA+IA0KPiA+ID4gYSkg
a2VlcCBhbGwgdGhlIE1JUFNpc21zIGluIHRoZSBkYXRhIHN0cnVjdHVyZXMsIGFuZCBqdXN0IHVz
ZSBhIHN1YnNldCBvZg0KPiA+ID4gICAgIG8zMiB0aGF0IGRyb3BzIGFsbCB0aGUgb2Jzb2xldGUg
ZW50cnkgcG9pbnRzDQo+ID4gPiBiKSBzdGFydCBvdmVyIGFuZCBzdGF5IGFzIGNsb3NlIGFzIHBv
c3NpYmxlIHRvIHRoZSBnZW5lcmljIEFCSSwgdXNpbmcgdGhlDQo+ID4gPiAgICAgYXNtLWdlbmVy
aWMgdmVyc2lvbnMgb2YgYm90aCB0aGUgc3lzY2FsbCB0YWJsZSBhbmQgdGhlIHVhcGkgaGVhZGVy
DQo+ID4gPiAgICAgZmlsZXMgaW5zdGVhZCBvZiB0aGUgdHJhZGl0aW9uYWwgdmVyc2lvbi4NCj4g
PiANCj4gPiBXZSd2ZSB0YWtlbiBvcHRpb24gYiBpbiBvdXIgY3VycmVudCBkb3duc3RyZWFtIGtl
cm5lbCAmIHRoYXQncyB3aGF0IEkNCj4gPiBob3BlIHdlJ2xsIGdldCB1cHN0cmVhbSB0b28uIFRo
ZXJlJ3Mgbm8gZXhwZWN0YXRpb24gdGhhdCB3ZSdsbCBldmVyIG5lZWQNCj4gPiB0byBtaXggcHJl
LW5hbm9NSVBTICYgbmFub01JUFMgSVNBcyBvciB0aGVpciBhc3NvY2lhdGVkIEFCSXMgYWNyb3Nz
IHRoZQ0KPiA+IGtlcm5lbC91c2VyIGJvdW5kYXJ5IHNvIGl0J3MgZmVsdCBsaWtlIGEgZ3JlYXQg
b3Bwb3J0dW5pdHkgdG8gY2xlYW4gdXAgJg0KPiA+IHN0YW5kYXJkaXNlLg0KPiA+IA0KPiA+IEdl
dHRpbmcgbmFub01JUFMvcDMyIHN1cHBvcnQgc3VibWl0dGVkIHVwc3RyZWFtIGlzIG9uIG15IHRv
LWRvIGxpc3QsIGJ1dA0KPiA+IHRoZXJlJ3MgYSBidW5jaCBvZiBwcmVwIHdvcmsgdG8gZ2V0IGlu
IGZpcnN0ICYgb2YgY291cnNlIHRoYXQgdG8tZG8gbGlzdA0KPiA+IGlzIGZvcmV2ZXIgZ3Jvd2lu
Zy4gSG9wZWZ1bGx5IGluIHRoZSBuZXh0IGNvdXBsZSBvZiBjeWNsZXMuDQo+IA0KPiBwMzIgaXMg
anVzdCB0aGUgQUJJIG5hbWUgZm9yIG5hbm9NSVBTIG9yIHlldCBhbm90aGVyIE1JUFMgQUJJPw0K
DQpwMzIgaXMgdGhlIEFCSSBmb3IgbmFub01JUFMgLSBpZS4gaXQgaXMgYSBuZXcgQUJJLCBidXQg
aXQncyBub3QgZm9yIHVzZQ0Kd2l0aCBwcmUtbmFub01JUFMgSVNBcyAmIG5hbm9NSVBTIGlzbid0
IHVzZWQgd2l0aCBvMzIvbjMyL242NC4NCg0KU29tZSBvZiB0aGUgY29kZSBkZW5zaXR5IGltcHJv
dmVtZW50cyBuYW5vTUlQUyBicmluZ3MgYXJlIGR1ZSB0byB0aGUgSVNBDQomIHAzMiBBQkkgYmVp
bmcgZGV2ZWxvcGVkIHRvZ2V0aGVyIC0gZWcuIHRoZSBsb2FkL3N0b3JlIG11bHRpcGxlICYNCnNh
dmUvcmVzdG9yZSBpbnN0cnVjdGlvbnMgbWFrZSBpdCBlYXN5IHRvIHNhdmUgc2VxdWVuY2VzIG9m
ICRzcCwgJGZwLA0KJHJhICYgc29tZSBudW1iZXIgb2YgdGhlICRzTiBjYWxsZWUtc2F2ZWQgcmVn
aXN0ZXJzLiBDb21wcmVzc2VkIHJlZ2lzdGVyDQpudW1iZXIgZW5jb2RpbmdzIGdlbmVyYWxseSBp
bmNsdWRlIHJlZ2lzdGVycyB0aGF0IG1ha2Ugc2Vuc2UgZm9yIHRoZSBwMzINCkFCSSwgYW5kIEkn
bSBzdXJlIHRoZXJlIHdlcmUgb3RoZXIgdGhpbmdzIEkndmUgZm9yZ290dGVuLg0KDQo+IEVpdGhl
ciB3YXksINCGIHRoaW5rIGlmIHRoZXJlIGlzIHlldCBhbm90aGVyIEFCSSBldmVuIG9uIGFuIGV4
aXN0aW5nIHBvcnQNCj4gd2Ugc2hvdWxkIGFsd2F5cyBhaW0gZm9yIHRoZSBhc20tZ2VuZXJpYyBz
eXNjYWxsIHRhYmxlIGluZGVlZC4NCj4gDQo+IEVzcGVjaWFsbHkgZm9yIG1pcHMgd2hlcmUgbzMy
IGhhcyBhIHJhdGhlciBhd2t3YXJkIEFCSSBvbmx5IGV4cGxhaW5lZCBieQ0KPiBvZGQgZGVjaXNp
b25zIG1vcmUgdGhhbiAyMCB5ZWFycyBhZ28uDQoNCkdsYWQgdG8gaGVhciB3ZSdyZSBvbiB0aGUg
c2FtZSBwYWdlIDopDQoNCkknbSBhbGwgZm9yIGJlaW5nIGxlc3MgInNwZWNpYWwiICYgY291bGRu
J3QgY2FyZSBsZXNzIGlmIG91ciBuYW5vTUlQUw0Kc3VwcG9ydCBpc24ndCBjb21wYXRpYmxlIHdp
dGggSVJJWC4NCg0KVGhhbmtzLA0KICAgIFBhdWwNCg==
