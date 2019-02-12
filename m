Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9F5C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35025217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=criteo.com header.i=@criteo.com header.b="xrOyiztj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfBLHMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:12:16 -0500
Received: from mx07-00287e01.pphosted.com ([91.207.212.151]:57752 "EHLO
        mx08-00287e01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725916AbfBLHMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:12:16 -0500
X-Greylist: delayed 872 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Feb 2019 02:12:13 EST
Received: from pps.filterd (m0111314.ppops.net [127.0.0.1])
        by mx08-00287e01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1C6u1ic023563;
        Tue, 12 Feb 2019 07:57:17 +0100
Received: from eur01-db5-obe.outbound.protection.outlook.com (mail-db5eur01lp2055.outbound.protection.outlook.com [104.47.2.55])
        by mx08-00287e01.pphosted.com with ESMTP id 2qhnyfbpuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Feb 2019 07:57:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cj1PdR2dcTH2VeCU0CECk71P0b7aMDAYU0fCujbmYU=;
 b=xrOyiztjVt4o9GLlGXllxodqt70j/eUlBbgKEMpknmvIOxZJu04YTJd4rfNMVxecFRzb/IPIL6jhEwEIe7WDXjV/hL8/96mINGhcglQv0HQwIXRCd7wuRPoUW12k7cgnCbhjpSVX5C0fntWO1Lf3EgFifDFeKROZ+uAR7SZeKO0=
Received: from VI1PR04MB5629.eurprd04.prod.outlook.com (20.178.125.158) by
 VI1PR04MB5648.eurprd04.prod.outlook.com (20.178.125.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Tue, 12 Feb 2019 06:57:15 +0000
Received: from VI1PR04MB5629.eurprd04.prod.outlook.com
 ([fe80::9851:8b8c:f61c:6045]) by VI1PR04MB5629.eurprd04.prod.outlook.com
 ([fe80::9851:8b8c:f61c:6045%4]) with mapi id 15.20.1622.016; Tue, 12 Feb 2019
 06:57:15 +0000
From:   Erwan Velu <e.velu@criteo.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Erwan Velu <erwanaliasr1@gmail.com>
CC:     "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:INTEL PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] cpufreq: intel_pstate: Reporting reasons why driver
 prematurely exit
Thread-Topic: [PATCH v3] cpufreq: intel_pstate: Reporting reasons why driver
 prematurely exit
Thread-Index: AQHUweyeHazU1uSAlk+MEi+yjK80saXbHLqAgAACkACAABy8AIAAgH2A
Date:   Tue, 12 Feb 2019 06:57:15 +0000
Message-ID: <a806a805-92a6-1b23-65f9-6ccd76a56f65@criteo.com>
References: <20190211093140.23608-1-e.velu@criteo.com>
 <eaf4286b0836444e00ec2e92178b5f31957c9a7a.camel@linux.intel.com>
 <CAL2Jzuwz3gYmYwiP-6mRN5HS65oXMKR1V7997d92K_n+fJt7QQ@mail.gmail.com>
 <754cbb153e6c215db9771b05a735afaf7eb1120f.camel@linux.intel.com>
In-Reply-To: <754cbb153e6c215db9771b05a735afaf7eb1120f.camel@linux.intel.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0502CA0061.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::38) To VI1PR04MB5629.eurprd04.prod.outlook.com
 (2603:10a6:803:de::30)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [82.252.136.188]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5648;6:O1Sh30k8rIbjuDBbPr9xC3+kf6cRHJfiiJ78/eBePiBWbrwFi0/OmvikHtyO0ODxF+T26zkz+5DnvmpJvcezO3yW4OLK52QxEj/fqoaN+uheUr7zV2mkdwO87UjkcQVND9By9IM1q9FaHyscdnwOMHJUYIN9+cmq9h7svoLKvTYTMe1gNSZRZO6KgBUulgd5TCA+O6wZZqyOMXu+IpbsdDFf3nMJHfXfGctBSxcLuppybC6rmZVSq+oeplqaz924FAwcEAdFjb+PrFSZNkYKflBf8h6jkmi1AgrrgogWDowkAh04ULeZkn/fdSvlempcSli5L6fK3WkMwrkLBdeT7sBzPhDrG0gNqlk57xj8NqTnkce6l3IqHlwnpG63A4iD9mb4p1QBTGVuIhPvjp3bhaeJtsqsv+cMF5ESVPTh1i2TdiS5jxPjzFG9awaSrX/FOIQpCmoeW4ph8xYNVGzxUQ==;5:jehB365dsZMkzk/QxfmirehPfqqPvhTXh573D/SLFlZUTLDl0Mrf26SRER6rIe3O10rmx1BOtOW2YZiz9x7dTWbydxbKWs0iuda5afY7c3B1HL5kBUhKlyZiqHSb2JYOyJNJgl2a/d+8oqWWlS+IV+378t3Y3+eEOJHmF5LPysHP5Dj+mMRRjKVwzkcUSBuK0NcfAgO/eqHEECuNk4dlvw==;7:xsO8//5docVBjmQLXdzWuFCyv/4CjZka50+fTR7oLdPoeEItKaRfOrGvcS5IbAcXsm96EHsYGnOmE6RRZ7wioUfMUJmrF+fX6+KBuz8jDGBFXJxjf0NFTL5ZOY+HBu1rDTLh6828xDMTu2CRcn3BIQ==
x-ms-office365-filtering-correlation-id: 65c750c0-9c91-413e-6490-08d690b75220
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5648;
x-ms-traffictypediagnostic: VI1PR04MB5648:
x-microsoft-antispam-prvs: <VI1PR04MB5648896AE616ED12FB851493F2650@VI1PR04MB5648.eurprd04.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(346002)(136003)(366004)(396003)(376002)(199004)(189003)(51914003)(446003)(8676002)(86362001)(31696002)(25786009)(8936002)(81166006)(81156014)(6512007)(478600001)(68736007)(110136005)(71190400001)(71200400001)(53936002)(6116002)(3846002)(36756003)(14454004)(93886005)(4326008)(256004)(6246003)(26005)(6506007)(386003)(186003)(102836004)(316002)(66574012)(229853002)(6486002)(52116002)(97736004)(486006)(105586002)(106356001)(6436002)(2906002)(2616005)(99286004)(305945005)(76176011)(54906003)(7736002)(31686004)(476003)(66066001)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR04MB5648;H:VI1PR04MB5629.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: criteo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0RXMiyaPNhhEZK0ZQUYd92ufH9WLChE2Ptb07/S9QKTVI6bCA3cJaS5LoMMFBaDftjcCIcA5RTs1sEdj31UkSFucjbX7yOKAHcn/qTx1CQ3XLCa/g+jWHaydYe8388lyaEugXch3hfrO3S+RtpS4KV04MAaGWElv21f2XMvBZ0ztF7JAaDh3sKRUem74GUCpA1fWAOMmx28DIiqibBwneTagiJ+LVAjGImg36rjM1ekc4pHA57cjbWd1tgZemHoGLZi6Ra7izmhjd/DNTf7XLaV0ignE2JKphCZPecr06RLYcYJJUlTG3BhAjB3td7XxtV1eURhh5+ohbjcKPbTLbYkAsQNQYa1Kz4G7xAC6J1rxtR+b0wZtw0FgDCEERLJ8LSGqZ9uBiEdlN9ct2f35yuCO+xc/H9uwgpVofutwLoQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFB32A258DFF0B45A918D88D66AC3C1B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c750c0-9c91-413e-6490-08d690b75220
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 06:57:14.5719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5648
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpMZSAxMi8wMi8yMDE5IMOgIDAwOjE3LCBTcmluaXZhcyBQYW5kcnV2YWRhIGEgw6ljcml0wqA6
DQo+IFsuLi5dDQo+IFRvIGtub3cgaWYgdGhlIGludGVsX3BzdGF0ZSBpbiBjb250cm9sLCB5b3Ug
Y2FuIGxvb2sgYXQ6DQo+ICNjYXQgL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1ZnJlcS9wb2xp
Y3kwL3NjYWxpbmdfZHJpdmVyDQo+DQo+IFNvIGlmIGl0IGlzIG5vdCBsb2FkZWQgYW5kIEludGVs
IGludGVuZCB0byBzdXBwb3J0IGEgcHJvY2Vzc29yIG1vZGVsDQo+IHdpdGggaW50ZWxfcHN0YXRl
LCB0aGVuIE9FTSdzIHBsYXRmb3JtX3Bvd2VyX21hbmFnZW1lbnQgcG9saWN5IGNhbg0KPiBvdmVy
cmlkZS4gU28gd2UgY2FuIGFkZCBvbmUgcHJfaW5mbyB0byBzaG93IHRoYXQgZHJpdmVyIGNhbid0
IGJlIGxvYWRlZA0KPiBiZWNhdXNlIG9mIHBsYXRmb3JtDQo+IGludGVsX3BzdGF0ZV9wbGF0Zm9y
bV9wd3JfbWdtdF9leGlzdHMoKSwgcmV0dXJuIHRydWUuDQoNCkFncmVlZC4NCg0KQnV0IEkgZG8g
dGhpbmsgdGhlIGludGVsX3BzdGF0ZV9tc3JzX25vdF92YWxpZCgpIGNhc2UgYWxzbyBkZXNlcnZl
cyBhIA0KcHJfd2FybigpIGFzIHRoaXMgaXMgYSBwcmVtYXR1cmUgZXhpdCBiZWNhdXNlIG9mIHNv
bWUgaGFyZHdhcmUgc2V0dGluZ3MuDQoNCj4gSWYgSFdQIGlzIHVzZWQgd2UgYWxyZWFkeSBoYXZl
IGEgcHJfaW5mby4gSWYgSFdQIGlzIHByZXNlbnQgaXQgd2lsbA0KPiBhbHdheXMgYmUgdXNlZCB1
bmxlc3MgdXNlciBvdmVycmlkZXMuDQo+DQo+IFRoZSBjYXNlcyB3aGVyZSBhIG1lbW9yeSBhbGxv
Y2F0aW9uIGZhaWxzIHlvdSB3aWxsIHNlZSBvdGhlciB3YXJuaW5ncw0KPiBpbiB0aGUgc3lzdGVt
LCBzbyBkb24ndCBuZWVkIHRvIGFkZCBpbiBkcml2ZXIuIEFsc28gaWYgc29tZW9uZQ0KPiBleHBs
Y2l0bHkgdXNpbmcga2VybmVsIGNvbW1hbmQgbGluZSB0byBlaXRoZXIgZGlzYWJsZSBvciBjb250
cm9sDQo+IGZlYXR1cmVzLCB1c2VyIGtub3dzIHdoYXQgaGUgaXMgZG9pbmcuDQo+DQo+IFNvIG5v
IG5lZWQgb2YgcHJfd2FybiBvciBwcl9pbmZvIGV4Y2VwdCBvbmUgY2FzZSBmb3IgcGxhdGZvcm0g
bW93ZXINCj4gbWFuYWdlbWVudC4gVGhlIG90aGVycyBhcmUgZGVidWcgbWVzc2FnZXMgb25seS4N
Cg0KQWNrLg0KDQpJJ20gc2VuZGluZyBhIHY0IHRoaXMgd2F5Lg0KDQpUaGFua3MgZm9yIHRoZSBy
ZXZpZXcgJiBkaXNjdXNzaW9ucy4NCg0KRXJ3YW4sDQoNCg==
