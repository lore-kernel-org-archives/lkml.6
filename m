Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2328261-1522109259-2-1784258708322168050
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522109258; b=kt/n3NNKEbLBXdazgXZnkP9jP43L3csFO/RBGR3xxt2k67t
    vPznXbaQkEBoM2lE92qKBYJE5ZVeCot/DEqAcLdeVqHebB6MzHMw/7nbjQugukyi
    ynLzdcUFldhtssqe5PjJbX8npCQfjIKggdbOV4X6j0T0AIFVt1aJ6dvUBSLdCBx6
    rgE2LtEEcfhZcAfQurI10FlhFZOYe1+GmwYvYfDeuSkGFo0QqUVVxL1yCatZQXTU
    G9THG8FxtSBrVP7yTNzcUo1m5k4DrUJfycr8Cy6X3ftGFHEUHJWIT/Jj/zCJ742B
    cZRkmFNzHJrmPKudcIhGwbSwTyy5HZXA9y9Vt/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1522109258; bh=od38CEyBidKoUgNEH3vldmrsFYVqQ/3GRnssjq
    SvzC4=; b=EMczV4XmK/IyzUWL2UKV2AT4G/yw31ENhT2lGU1q7T3SLYdXg6fgBJ
    VeUem/yweuEI5H3E3GAB2xlP1b1PE1LjcxRYILKjOpH2ar9eVrmx85Igz958YGn4
    rFNRdRBi0A4lxjGAQe2L0Z5JQIlkT4diUY2nethog2URC7kysLYaIVSlBBpsQsqa
    6iVT/dUrqlSx3pq+pkD+6dvP4pkHRf8hz6jJ0TlCIYqXh9fnZjdNeeZbAVN/9zgh
    AihhkVk3XPe6l/z43Y/NSFziFrSRsgxqxgKli/ZF9yq5010ABdpGlPcXkJ+i2jc3
    FtVSLn8BhiXJnffs33I/uhmWo2AV5jCw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=ViOoFl/t x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=pass (1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=S8c08RhK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=ViOoFl/t x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=pass (1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=S8c08RhK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBJUYJA7mOtHj3C5OfOz5mY0fX2Yo+tDsyAyubgq66emhTdIEHYZ5Mb10O85jcV3K5nOfZ0hNTuZdZNB3PSf9NRvE7XKwB4KoOyQFgSgbvCOxNCbvMmD
    OcF2TCLx0Sc/S5CUAOP12f4O4eMTYn2lMA7pUBbhvkewe9ANPS7yhi5qnIr+FsOBgFqmfrOKIUe1fHBDW0V4snTWilKIQKij8U3JvyhPTwEcOqbCg9iTuUEW
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=A7nYOoY3jUMA:10 a=WS3rvhOas08A:10
    a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=v2DPQv5-lfwA:10 a=jF-tZZ44EvIA:10
    a=QyXUC8HyAAAA:8 a=FOH2dFAWAAAA:8 a=d8_2M26_hdMwGkVOlYkA:9 a=QEXdDO2ut3YA:10
    a=i3VuKzQdj-NEYjvDI-p3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeC0AH2 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Mar 2018 20:07:28 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43290 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751160AbeC0AH0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Mar 2018 20:07:26 -0400
From: Sahil Rihan <srihan@fb.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: allow TCPA log area to be empty
Thread-Topic: [PATCH] tpm: allow TCPA log area to be empty
Thread-Index: AQHTuItC/RRm9Hus7E2B3o7PByJEg6PMtTQAgAYlz4CABAOdgIABQaUAgAEvBACAAxFgAIAARd2A
Date: Tue, 27 Mar 2018 00:07:14 +0000
Message-ID: <49C2A39F-C9ED-4620-82C9-C0919DA3F2CD@fb.com>
References: <20180310161637.7723-1-jarkko.sakkinen@linux.intel.com>
 <20180312150231.GA24717@ziepe.ca> <20180316125525.GB5035@linux.intel.com>
 <20180319021323.GD27186@ziepe.ca> <20180319212436.GD14364@linux.intel.com>
 <A799BB0A-C44B-41AB-9C38-4B974A50210D@fb.com>
 <edcff887ff133df486812bb5ecadcc101bc1d227.camel@linux.intel.com>
In-Reply-To: <edcff887ff133df486812bb5ecadcc101bc1d227.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:180::1:294e]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1776;7:pSw0GSiWVabqs6RFuFImsamhG73aqHTKE+LX0SMlzrgh4cktD64LRQYrnyDv3N7+DxbULy3Ym8JGF+ZY/v38ZPdFEPEzDLW1rlJr4GvCVIZL0u393yaM7i7smH21Bcx1d+bH2QlzDPoNaErRJtZLpQryTTSzepMWKBvjzq/MkKqvIOjXSEhipkAE/svNZPXwTeW5oTEnWOcB7lltUAjtNA+F9kSNFBjdU7rgd9+By1bJRXPfFLFFzZTpyw6Vm+LG;20:9YFS57xguFlUHtss5AltylwuDCtGECb0r9wKNpN5i1pGTkZUEb/eKq17I1oJjCSIF+I+W6NsGyIOICt09m7w/DGZvlnWzJgxppHZwYFUpqZCxRKPm20oAu94wNI+e9HCBpMwudKLY/p5BvcS0v4bWhjuf1C36Y3IMUqgXh7LJo4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(376002)(346002)(39860400002)(189003)(199004)(377424004)(6486002)(81156014)(81166006)(8676002)(229853002)(46003)(33656002)(97736004)(186003)(14454004)(478600001)(106356001)(316002)(54906003)(5250100002)(110136005)(486005)(486005)(93886005)(6116002)(105586002)(102836004)(3280700002)(3660700001)(25786009)(4326008)(36756003)(68736007)(2906002)(6436002)(8666007)(76176011)(2900100001)(83716003)(446003)(99286004)(5660300001)(86362001)(305945005)(6506007)(53546011)(82746002)(6512007)(7736002)(6246003)(53936002)(11346002)(2616005)(59450400001)(8936002)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1776;H:MWHPR15MB1149.namprd15.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-correlation-id: 9cb962d7-6e87-44f3-3343-08d59376b218
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1776;
x-ms-traffictypediagnostic: MWHPR15MB1776:
x-microsoft-antispam-prvs: <MWHPR15MB17764B51CC8B72B7AAFA62A4BEAC0@MWHPR15MB1776.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(11241501184)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR15MB1776;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1776;
x-forefront-prvs: 0624A2429E
x-microsoft-antispam-message-info: rsCLvkzQKdwrQWCg9tIKvM8gVod5/mqME2SRJIca2e+yJp1JLVb1LpvPougA25ReQCy7JgTF8s0RT7vzIk49K4rLqoUbpAjHmqFs21eJ8TRb3TQzgN12Krl4JS854bwi7YBMHxOsrozOVqxX8VwEOWHFhvyYt8wUVkPAqsopc4JTY18O8rL42z0Kwuoe9m7COSD2MZ6EJF47uEherCZJk0dN0trh0qgNGIQopMR3W/mAMinw0KNl2IAcmwgqM9Mqa5sYlhKb1uotbdfeJ5UVxXvKWAo6YM43gJwcdb+Ux08rhxjaXytRJYslHHHFHFr1abh5qqHPc8wD2z+YGYygVw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A8D56E8DD3F474E9388D6E478FC00B2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb962d7-6e87-44f3-3343-08d59376b218
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2018 00:07:14.4428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1776
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-26_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PiBPbiAzLzIyLzE4LCA3OjIwIEFNLCAiSmFya2tvIFNha2tpbmVuIiA8amFya2tvLnNha2tpbmVu
QGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQo+DQo+ICAgT24gVHVlLCAyMDE4LTAzLTIwIGF0IDIy
OjI5ICswMDAwLCBTYWhpbCBSaWhhbiB3cm90ZToNCj4gICA+ID4gT24gMy8xOS8xOCwgMjoyNSBQ
TSwgIkphcmtrbyBTYWtraW5lbiIgPGphcmtrby5zYWtraW5lbkBsaW51eC5pbnRlbC5jb20+DQo+
ICAgPiA+IHdyb3RlOg0KPiAgID4gPiAgICAgDQo+ICAgPiA+ICAgIFNhaGlsLCB3b3VsZCB5b3Ug
Y2FyZSB0byB0cnkgaWYgdGhpcyBmaXhlcyB0aGUgaXNzdWUgdGhhdCB5b3UgYXJlDQo+ICAgPiA+
ICAgIGhhdmluZyBvciBub3Q/DQo+ICAgPiANCj4gICA+IFllcywgd2UgY2FuIHRlc3QgdGhpcyBv
dXQuIE1pZ2h0IHRha2UgYSBkYXkgb3IgdHdvLg0KPiAgICANCj4gICBBd2Vzb21lLCB0aGFuayB5
b3UuIEknbGwgYWRkDQo+ICAgIA0KPiAgIFJlcG9ydGVkLWJ5OiBTYWhpbCBSaWhhbiA8c3JpaGFu
QGZiLmNvbT4NCj4gICAgDQo+ICAgaWYgdGhhdCBpcyBPSyBmb3IgeW91Pw0KDQpKYXJra28sIA0K
DQpXZSBhcHBsaWVkIHlvdXIgcGF0Y2ggdG8gYSA0LjExIGtlcm5lbCAodW5mb3J0dW5hdGVseSBu
b3QgdGhlIGxhdGVzdCB1cHN0cmVhbSkgYW5kIHdlcmUgYWJsZSB0byBjb25maXJtIHRoYXQgdGhl
IGNoYXIgZGV2aWNlIGlzIG5vdyBiZWluZyBjcmVhdGVkIGNvcnJlY3RseS4gVGhlIHN5c2ZzIGVu
YWJsZWQgbm9kZSBpcyBhbHNvIHByZXNlbnQuDQoNCkFuZCB5ZXMsIHBsZWFzZSBhZGQgdGhlICJS
ZXBvcnRlZC1ieSIgbGluZS4NCg0KVGhhbmtzLA0KU2FoaWwNCiANCg0KDQo=
