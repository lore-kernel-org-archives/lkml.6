Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF3CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6D221841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="D3esyn62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeLRTnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 14:43:42 -0500
Received: from mail-eopbgr730073.outbound.protection.outlook.com ([40.107.73.73]:14731
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726832AbeLRTnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 14:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXmRfDi3L/9rUK/pGDTJ8eV+dKyYvy+2J+16MnC1tQA=;
 b=D3esyn62J6kNSnhLf8UhvaLFk2dR8glakfulYFF9LKmvvizoFA7r2zOK5/arOVjxF5WsalaIYPuBjDbwgbiWJyHMGnVie+NIHsjV9Kif6g8FPy68WcSK/u905YCxY0K5p8vec1p3LHujZiaT9bCSEaO0tpWrAAFM/gMxdDD6nco=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4597.namprd05.prod.outlook.com (52.135.233.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.9; Tue, 18 Dec 2018 19:43:29 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7%4]) with mapi id 15.20.1446.015; Tue, 18 Dec 2018
 19:43:29 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Richard Biener <rguenther@suse.de>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Alok Kataria <akataria@vmware.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jan Beulich <JBeulich@suse.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/12] x86, kbuild: revert macrofying inline assembly
 code
Thread-Topic: [PATCH v3 00/12] x86, kbuild: revert macrofying inline assembly
 code
Thread-Index: AQHUliMrM8kLo1o5+k2e9WVsj3H1BKWE554A
Date:   Tue, 18 Dec 2018 19:43:29 +0000
Message-ID: <C6D4A9B6-EED6-4DF7-8085-B1D3D221D25A@vmware.com>
References: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4597;20:+6n5PsWTq35SHWd/qtrrs564xjFNfsJxDwJkV3I2N+RrLFlhaNfhk7II1+/mZAH0AWWi5XFFJgNMd1P398V64T3jrIF9c7l/+g5uCNRIrNsGZhqyPu1/Ygtlexwy3/23V9v20KtdB3HTznWOsdlwR7SSu3nTzEW3tDMGNFXi+P0=
x-ms-office365-filtering-correlation-id: 2db6356d-3b35-4a07-3ace-08d66521161d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4597;
x-ms-traffictypediagnostic: BYAPR05MB4597:
x-microsoft-antispam-prvs: <BYAPR05MB45971E2AD289EFBCDC576468D0BD0@BYAPR05MB4597.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4597;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4597;
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(366004)(39860400002)(199004)(189003)(4326008)(45080400002)(53936002)(6246003)(25786009)(2906002)(54906003)(39060400002)(305945005)(7736002)(33656002)(316002)(66066001)(486006)(11346002)(2616005)(476003)(446003)(97736004)(256004)(14444005)(99286004)(8936002)(6512007)(6306002)(68736007)(8676002)(81156014)(81166006)(14454004)(6486002)(966005)(6116002)(186003)(6436002)(83716004)(71200400001)(71190400001)(82746002)(3846002)(7406005)(106356001)(105586002)(6506007)(102836004)(478600001)(6916009)(36756003)(53546011)(86362001)(5660300001)(555904003)(26005)(575784001)(7416002)(76176011)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4597;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IgL2G2Sbvr8AE5USfmRhc6pzo+5QZEhR64LwCBJ3ZSRuN+6MOz4CO5Y3m5U3bXOLGBj5S0CNjQf1SYBvP2dqHnFSDc3fayu8YuMa6Nar1TGoaDyl1kBI3b4pa59XEWqLarppuj7a+3yLG/nRvTYA+xMd8IkjyQ3JpW//GLDRsLEHjbb3gwnmjNA5e1WXfew4td/3B93e52QluCFv7GM9XWky5GC+0EUQ98ZxPX5Zx6davR+P2naXPxOZ2VHpCcPFKfteExLSMxhADYelzc8sxkVy0vM78/pNzbnCV2CvWhordW4ILpgz9qFn4VhS73XF
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <71ABF3FD62F14A44B735806BFEA43BC6@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db6356d-3b35-4a07-3ace-08d66521161d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 19:43:29.5582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4597
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBEZWMgMTcsIDIwMTgsIGF0IDg6MDMgQU0sIE1hc2FoaXJvIFlhbWFkYSA8eWFtYWRhLm1h
c2FoaXJvQHNvY2lvbmV4dC5jb20+IHdyb3RlOg0KPiANCj4gVGhpcyBzZXJpZXMgcmV2ZXJ0cyB0
aGUgaW4ta2VybmVsIHdvcmthcm91bmRzIGZvciBpbmxpbmluZyBpc3N1ZXMuDQo+IA0KPiBUaGUg
Y29tbWl0IGRlc2NyaXB0aW9uIG9mIDc3YjBiZjU1YmM2NyBtZW50aW9uZWQNCj4gIldlIGFsc28g
aG9wZSB0aGF0IEdDQyB3aWxsIGV2ZW50dWFsbHkgZ2V0IGZpeGVkLC4uLiINCj4gDQo+IE5vdywg
R0NDIHByb3ZpZGVzIGEgc29sdXRpb24uDQo+IA0KPiBodHRwczovL25hMDEuc2FmZWxpbmtzLnBy
b3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmdjYy5nbnUub3JnJTJGb25s
aW5lZG9jcyUyRmdjYyUyRkV4dGVuZGVkLUFzbS5odG1sJmFtcDtkYXRhPTAyJTdDMDElN0NuYW1p
dCU0MHZtd2FyZS5jb20lN0NjNDNmNDMzZDhjNjI0NGRlMTVmMTA4ZDY2NDNhNDllNCU3Q2IzOTEz
OGNhM2NlZTRiNGFhNGQ2Y2Q4M2Q5ZGQ2MmYwJTdDMCU3QzAlN0M2MzY4MDY1OTg4OTk5NjI2Njkm
YW1wO3NkYXRhPTg4VUoyNVJvaUhpazl2VENKS1pWNiUyRjd4cHpDR3N2S2I5TEZnMWtmRVlMMCUz
RCZhbXA7cmVzZXJ2ZWQ9MA0KPiBleHBsYWlucyB0aGUgbmV3ICJhc20gaW5saW5lIiBzeW50YXgu
DQo+IA0KPiBUaGUgcGVyZm9ybWFuY2UgaXNzdWUgd2lsbCBiZSBldmVudHVhbGx5IHNvbHZlZC4N
Cj4gDQo+IFtBYm91dCBDb2RlIGNsZWFudXBzXQ0KPiANCj4gSSBrbm93IE5hZGFtIEFtaXQgaXMg
b3Bwb3NlZCB0byB0aGUgZnVsbCByZXZlcnQuDQoNCk15IG5hbWUgaXMgTmFkYXYuDQoNCj4gSGUg
YWxzbyBjbGFpbXMgaGlzIG1vdGl2YXRpb24gZm9yIG1hY3JvZnlpbmcgd2FzIG5vdCBvbmx5DQo+
IHBlcmZvcm1hbmNlLCBidXQgYWxzbyBjbGVhbnVwcy4NCg0KTWFzYWhpcm8sIEkgdW5kZXJzdGFu
ZCB5b3VyIGNvbmNlcm5zIGFuZCBjcml0aWNpc20sIGFuZCBpbmRlZWQgdmFyaW91cw0KYWx0ZXJu
YXRpdmUgc29sdXRpb25zIGV4aXN0LiBJIGRvIGhhdmUgbXkgcmVzZXJ2YXRpb25zIGFib3V0IHRo
ZSBvbmUgeW91DQpwcm9wb3NlLCBzaW5jZSBpdCBtYWtlcyBjb2RpbmcgbW9yZSBjb21wbGljYXRl
ZCB0byBzaW1wbGlmeSB0aGUgTWFrZSBzeXN0ZW0uDQpZZXQsIG1vcmUgaW1wb3J0YW50LCBzdGFy
dGluZyB0aGlzIGRpc2N1c3Npb24gc3VkZGVubHkgbm93IGFmdGVyIFJDNyBpcw0Kc3RyYW5nZS4g
QW55aG93LCBzaW5jZSBpdOKAmXMgb2J2aW91c2x5IG5vdCBteSBjYWxsLCBwbGVhc2UgZG9u4oCZ
dCBtYWtlIGl0DQpzb3VuZCBhcyBpZiBJIGFtIGEgc2lkZSBpbiB0aGUgZGVjaXNpb24uDQoNCg==
