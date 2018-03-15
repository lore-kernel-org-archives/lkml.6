Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-426994-1521124065-2-15017246795076619567
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521124064; b=g2jl3PszSjgyK+sgnMXnFW3xcOz1pUPC+Y6UVZpoBHaTvsZ
    oYJZOhSwTdXdbXUxW98DWBOrazQhnXpgQJVyekJ6bNttA6Mn3LyRV3xqJ7bJdgyn
    HOt0lcaj3/XY/T8FXO41LEaXvAr67vrs+V/XesJzgiodzOhU+bk8qsvOgy2dL6Q0
    Ip1THsBgIyVDoOlI2M+nH+Xdgt77OQv7FbJ0/tPfH+MXpnCSAhFaU4OQKVCPMYeq
    D7TEcyieAU2IZlW3JS5GOf1vV6H56pOmpmVv67yfFN/STC1MeGyAsDyhZusjg7Aq
    DpM5a/pWTfuVNl7ExuCuXQa7zW2msAr46rl3ROA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521124064; bh=LlxTs5Kkx1NQS/c1Lr1xxfIK2RV4QRUcZL5cvR
    6fdxQ=; b=W3LTq36mltuhPk4JPdAnl7STH0ad0CRlVwqxv313m9o7OcZhu0iaPU
    FJdQqV+s6R2ZliAz0hiYPesQFBqbWXE/fwBjcb8uLa8xHEKR9UpGGx6CISOrv4lk
    MoVXMTwF2DHVQx28LNDe9lJCQD3oqUDjEeUxuS+Z9dgOZzTTkntROwPA2mhgn7hs
    wLfHBIvC+BhgeMUSgpw36BBHaZtPfI93FUlaTQaKdC44SvbsUIDlhVkF41JE2XNM
    ZFbr1vqu1tdeRMh6VS53ZLzRszWK/5q7mqBBaecm2GxYW1FEZFGAIpQ/S9OanVJy
    PkmtfYt36csc1eqZVn5OG/xUlKb0JVRw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752336AbeCOO1n (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 10:27:43 -0400
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:57697 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751984AbeCOO1a (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Mar 2018 10:27:30 -0400
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] mm/vmalloc: Add interfaces to free unmapped page
 table
Thread-Topic: [PATCH v2 1/2] mm/vmalloc: Add interfaces to free unmapped page
 table
Thread-Index: AQHTu76YsdFTdhyQpUSbYdrryDuYL6PQUuKAgAEJAwA=
Date: Thu, 15 Mar 2018 14:27:10 +0000
Message-ID: <1521124026.2693.141.camel@hpe.com>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
         <20180314180155.19492-2-toshi.kani@hpe.com>
         <20180314153835.68e75da3fdc18b27ad0e290c@linux-foundation.org>
In-Reply-To: <20180314153835.68e75da3fdc18b27ad0e290c@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.219.147.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DF4PR8401MB0971;7:6kTqjVM80yhh+7s5O4Pdk3Ci4C8cYKI6kqtAU679oeAEhRwBduWXVPE6jsPLT8D8uhNspGY4QIhgu/gPPd8BGpSumwlCiHWfdzlnv+NJk4zrNRlRiGKpnZda6y1eiZEc63gHz/PC2kXIf6e4YoNRcfNtaS+GeH4s2nVgzp2ZmN4c5gDc+AtwqnKUEPoYMzGYsprav12eFO3q1kwbqCy35iJM3F/MFIZjruQMfk/v/w2ytd/1/4iKliaK9iN1wGF5
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9ef57805-8de8-4f0c-a6c6-08d58a80d6a9
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:DF4PR8401MB0971;
x-ms-traffictypediagnostic: DF4PR8401MB0971:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <DF4PR8401MB0971425B6CCFB16844939FAC82D00@DF4PR8401MB0971.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(222181515654134);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DF4PR8401MB0971;BCL:0;PCL:0;RULEID:;SRVR:DF4PR8401MB0971;
x-forefront-prvs: 0612E553B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(376002)(366004)(396003)(377424004)(189003)(199004)(106356001)(26005)(14454004)(25786009)(86362001)(6436002)(103116003)(105586002)(6512007)(2900100001)(99286004)(3280700002)(6486002)(5250100002)(186003)(3660700001)(316002)(66066001)(305945005)(5640700003)(5660300001)(6506007)(478600001)(7736002)(2351001)(102836004)(54906003)(7416002)(36756003)(2501003)(76176011)(3846002)(6116002)(4326008)(6916009)(1730700003)(81166006)(2906002)(8676002)(81156014)(2950100002)(53936002)(68736007)(6246003)(97736004)(8936002)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:DF4PR8401MB0971;H:DF4PR8401MB0396.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: RK4myae9IDHx8JirqaWA3SlpHrgrBjLWMSNcBU2gUgWeb2m9G0hJEV5vh/X1cASy2Mu0aEyEiIiWsoRvZFD7dtC6tJuVuBx8ea0YTFIf6YUs9NLasJbTDh0oY3hN4+/SeA8G4bFls7W4Mq+kJr7eqFL/7WwWt6UKCusI2o6h4J2WP8WSIYfm56pyUy2vescWmYQi1/8kcX3NojMd8RjqdAMj9UY/ATvikb1MX6CmDtDybXQH2k2EQvUl1GYXhxHTEGoYRusS8HUDtmm4Fxx3u/fk876jSf8K0cA0DsRybyP8tItaQTiurtFOWJ6Gi7EcIqXmUnbsz9nZP2BJ4LZYOg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4706C1564229854FA532B303D04DE221@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef57805-8de8-4f0c-a6c6-08d58a80d6a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2018 14:27:10.3745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB0971
X-OriginatorOrg: hpe.com
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gV2VkLCAyMDE4LTAzLTE0IGF0IDE1OjM4IC0wNzAwLCBBbmRyZXcgTW9ydG9uIHdyb3RlOg0K
PiBPbiBXZWQsIDE0IE1hciAyMDE4IDEyOjAxOjU0IC0wNjAwIFRvc2hpIEthbmkgPHRvc2hpLmth
bmlAaHBlLmNvbT4gd3JvdGU6DQogOg0KPiANCj4gd2hvb3BzLg0KPiANCj4gLS0tIGEvaW5jbHVk
ZS9hc20tZ2VuZXJpYy9wZ3RhYmxlLmh+bW0tdm1hbGxvYy1hZGQtaW50ZXJmYWNlcy10by1mcmVl
LXVubWFwcGVkLXBhZ2UtdGFibGUtZml4DQo+ICsrKyBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvcGd0
YWJsZS5oDQo+IEBAIC0xMDE0LDcgKzEwMTQsNyBAQCBzdGF0aWMgaW5saW5lIGludCBwdWRfZnJl
ZV9wbWRfcGFnZShwdWRfDQo+ICB7DQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+IC1zdGF0aWMgaW5s
aW5lIGludCBwbWRfZnJlZV9wdGVfcGFnZShwdWRfdCAqcG1kKQ0KPiArc3RhdGljIGlubGluZSBp
bnQgcG1kX2ZyZWVfcHRlX3BhZ2UocG1kX3QgKnBtZCkNCj4gIHsNCj4gIAlyZXR1cm4gMDsNCj4g
IH0NCg0KVGhhbmtzIEFuZHJldyBmb3IgY2F0Y2hpbmcgdGhpcyEhDQotVG9zaGkNCg==
