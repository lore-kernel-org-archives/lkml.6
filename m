Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-354822-1526479568-2-3321903990333966171
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526479567; b=QjADhdzeMHQlSBVA37pUtooT/89nzD3FrxwkRtCKwOHbfX/EuI
    1PfaFwlei5SgUyt24Tuovju4YOiB+P+SWHMQLeMnhvMz+OXLp7r5fS3nCgDMpxxT
    VpIvXHqnqw+8Lt+Jd3/vBcfO9haLltP2vr6cPYCJSUBLRpBIS+K5Ywe3KQ4QcP6z
    3lRMVXy/chDA9P8ABNsnppselQ76Epoa7q2Ox9zKP1cZouSRBU8nXFxs+9tTq9fD
    05XdgPZO/fdbLvfMOzQs+8cjLfiySvQGSvO6szMcelbhQAwlm+ufn0mhCC8s6nTm
    4yFZh/lMM1qPs2lLfhTWbDpdgUrx7myaO3Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1526479567; bh=A4ApRbg22/0hQGP8fzOzwDWlBOeLmsMKjzAe0sJS8OU=; b=
    UG5zKw4hubS6/ylkNfl+KEGjEUnBXIpUAyfEmaKyymoLHCOk9EUk4BVLjJhNcndF
    nRQiZPDiltdk65shCkkm4vVqbYwu8ypOURIW6jsNuYuC2c+jULAkBd6dmoj9zpK6
    yj5FOBXi7G9qG0/adCkRo67NPyU2EiyL89xesmPPAs3N6HYdwRx0ZEMlVBsxq0DU
    zMESEGvs7hQYo1u/l1NB8houjnZRm/cj3htTkx1jp71rk2sFhwUaOugNlfsiUgz/
    A/tKqAKuM4H3qEE1CEOWI5JujDvo4lMYz4HXxl3aPLbYnn93EqLC0Hnel984Caba
    WZb7+JEffMy6W9FZPBLQ3g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHjMJH1MakXt/qiW5/jR8Dd5N2KxqrdlijK8inqfkEDPhUXHN+8RYpeoXA2y8YsIZoeU9qWBfCmvgM/roM0/oSstCpoAgtfMbpqTnBHD2jOG0MnrqR5d
    zy737+ghTBpdlJLhIprGC5u6W3G0ACY6QiXTf8XKLII8MSyAN6X352UiW9GZqnMs4NKhA5PQoHsG3c+SMN7OiGOBk2EE2UOhKtr4hgn1B3FvSRiO5WlY4GnZ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=83mnZcsAwEAA:10 a=-kPIvCItjiMA:10
    a=wpK5vPxRY0gA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=QDZ4HvhdkI4A:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=aHQm_FWpLlQksgCCiwUA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbeEPOFx (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 10:05:53 -0400
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:30365 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbeEPOFu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 16 May 2018 10:05:50 -0400
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "lkp@intel.com" <lkp@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        "Hocko, Michal" <MHocko@suse.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/3] x86/mm: disable ioremap free page handling on
 x86-PAE
Thread-Topic: [PATCH v2 1/3] x86/mm: disable ioremap free page handling on
 x86-PAE
Thread-Index: AQHT7JVn9raisUDnA0umtOpxxopNxaQyMSWAgAAzUgA=
Date: Wed, 16 May 2018 14:05:45 +0000
Message-ID: <1526479474.2693.607.camel@hpe.com>
References: <20180515213931.23885-2-toshi.kani@hpe.com>
         <201805161819.uT7J37yy%fengguang.wu@intel.com>
In-Reply-To: <201805161819.uT7J37yy%fengguang.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.211.195.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0818;7:Jh9xFAoLsTWLXKlLNO3pkbxGDQ5JHu8KOsk3ADd6Gs7JkwwN+bfV52fwbOi2+xuAkCzSS6kzXRU2ekSL/pUSzK2QTvz4xfYCPIVuj/2P/sofOSbF3Ba/3yO0+Lw/k++bfGU3xEkLdzigvNzOpu47vWhlbBqd7FD+8IFM3KkWzsx7cKIkUvr3sl0XZWN+wlOfy9guU44EG7onw/CcZ1kK/9X8phVawaJwfKT/F584PrXiA7U9ixV0soROxZ6hS46y
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(5600026)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0818;
x-ms-traffictypediagnostic: AT5PR8401MB0818:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB08184A036544FE86170DE3D482920@AT5PR8401MB0818.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(166708455590820)(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:AT5PR8401MB0818;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0818;
x-forefront-prvs: 0674DC6DD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(39860400002)(39380400002)(199004)(189003)(377424004)(446003)(305945005)(26005)(5640700003)(186003)(25786009)(6436002)(2900100001)(97736004)(6506007)(5890100001)(7736002)(2501003)(102836004)(14454004)(11346002)(6246003)(5250100002)(66066001)(3660700001)(3280700002)(6486002)(103116003)(6116002)(6916009)(229853002)(7416002)(3846002)(53936002)(966005)(99286004)(5660300001)(86362001)(68736007)(4326008)(1730700003)(8676002)(316002)(486006)(54906003)(2906002)(81156014)(81166006)(345774005)(36756003)(6306002)(106356001)(76176011)(8936002)(2616005)(476003)(105586002)(478600001)(6512007)(2351001);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0818;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: s1DjCDYWDKglyfb68mY+lkkjHnhatl2ByZVbu02DyxevQesZlPxRLLLs6r1DkwEoNb1H4pQl0MEWE70TNI1SBslC0Cfjz2SH3tsgLU7CRBsODX7VMnQB2EKiD48AI27UPkUwxwsDyimU1uwtkgkYThAeg1U4PKDU0SjaR5q4KR9VJonsF573eJGEOGG2J0Lc
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCB761AEC2EE8D4AB6F7AA19CE1EB99E@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 25e9ad1e-3b1d-4e7a-bd68-08d5bb361e73
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e9ad1e-3b1d-4e7a-bd68-08d5bb361e73
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2018 14:05:45.5854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0818
X-OriginatorOrg: hpe.com
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gV2VkLCAyMDE4LTA1LTE2IGF0IDE5OjAwICswODAwLCBrYnVpbGQgdGVzdCByb2JvdCB3cm90
ZToNCj4gSGkgVG9zaGksDQo+IA0KPiBUaGFuayB5b3UgZm9yIHRoZSBwYXRjaCEgWWV0IHNvbWV0
aGluZyB0byBpbXByb3ZlOg0KPiANCj4gW2F1dG8gYnVpbGQgdGVzdCBFUlJPUiBvbiBhcm02NC9m
b3ItbmV4dC9jb3JlXQ0KPiBbYWxzbyBidWlsZCB0ZXN0IEVSUk9SIG9uIHY0LjE3LXJjNSBuZXh0
LTIwMTgwNTE1XQ0KPiBbY2Fubm90IGFwcGx5IHRvIHRpcC94ODYvY29yZV0NCj4gW2lmIHlvdXIg
cGF0Y2ggaXMgYXBwbGllZCB0byB0aGUgd3JvbmcgZ2l0IHRyZWUsIHBsZWFzZSBkcm9wIHVzIGEg
bm90ZSB0byBoZWxwIGltcHJvdmUgdGhlIHN5c3RlbV0NCj4gDQo+IHVybDogICAgaHR0cHM6Ly9n
aXRodWIuY29tLzBkYXktY2kvbGludXgvY29tbWl0cy9Ub3NoaS1LYW5pL2ZpeC1mcmVlLXBtZC1w
dGUtcGFnZS1oYW5kbGluZ3Mtb24teDg2LzIwMTgwNTE2LTE4MzMxNw0KPiBiYXNlOiAgIGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2FybTY0L2xpbnV4Lmdp
dCBmb3ItbmV4dC9jb3JlDQo+IGNvbmZpZzogaTM4Ni1yYW5kY29uZmlnLXgwMTMtMjAxODE5IChh
dHRhY2hlZCBhcyAuY29uZmlnKQ0KPiBjb21waWxlcjogZ2NjLTcgKERlYmlhbiA3LjMuMC0xNikg
Ny4zLjANCj4gcmVwcm9kdWNlOg0KPiAgICAgICAgICMgc2F2ZSB0aGUgYXR0YWNoZWQgLmNvbmZp
ZyB0byBsaW51eCBidWlsZCB0cmVlDQo+ICAgICAgICAgbWFrZSBBUkNIPWkzODYgDQo+IA0KPiBO
b3RlOiB0aGUgbGludXgtcmV2aWV3L1Rvc2hpLUthbmkvZml4LWZyZWUtcG1kLXB0ZS1wYWdlLWhh
bmRsaW5ncy1vbi14ODYvMjAxODA1MTYtMTgzMzE3IEhFQUQgOTM5NDQ0MjJmY2VmOWJmYWRmMjJl
MzQ1YzFkN2EzNDcyM2NjMzIwMyBidWlsZHMgZmluZS4NCj4gICAgICAgSXQgb25seSBodXJ0cyBi
aXNlY3RpYmlsaXR5Lg0KPiANCj4gQWxsIGVycm9ycyAobmV3IG9uZXMgcHJlZml4ZWQgYnkgPj4p
Og0KPiANCj4gPiA+IGFyY2gveDg2L21tL3BndGFibGUuYzo3NTc6NTogZXJyb3I6IGNvbmZsaWN0
aW5nIHR5cGVzIGZvciAncHVkX2ZyZWVfcG1kX3BhZ2UnDQo+IA0KPiAgICAgaW50IHB1ZF9mcmVl
X3BtZF9wYWdlKHB1ZF90ICpwdWQsIHVuc2lnbmVkIGxvbmcgYWRkcikNCj4gICAgICAgICBefn5+
fn5+fn5+fn5+fn5+fg0KDQpUaGFua3MgZm9yIGNhdGNoaW5nIHRoaXMhICBQYXRjaCByZW9yZGVy
aW5nIGNhdXNlZCB0aGlzLiAgV2lsbCBmaXguDQotVG9zaGkNCg==
