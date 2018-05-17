Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2237303-1526567558-2-13385675209793565469
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
    1526567557; b=mW6/aeruHAoSfd25OMnPaypyg5bWRI9b9cW0YlDIbbdOjNpxYM
    PATDLW8c4rCuRLX3GlU9WHmZvOai+36VV4na0sDytGA/SbACFh3KbCxIWb6slAtm
    NkLGdlFpQlE4mOx0OsHP23/ZsxNV+YPKohCcLRQlL56/b3Syjji5EV0oirpRRj03
    qphClR2ZGhTyXK5t/lvg5RfG20pdqLn2wKQKMC+LzVvJazbfGQqgooNflIBNmhWf
    9AlPxPnOQteSQz4I4OdlXhUv4yCcdyyCyeScNXgDpUgcVDFW1l30VCtqN9tIgNcY
    oyuIa2OO85wZ7yVBX7BMICCRnWFJxKFlD2EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1526567557; bh=FK8RhFXp3Ru3yzLHIuZXzTGuX44JyiiojeiKZZ+tPv0=; b=
    WdocX9DNKIekw0iuNyDIqMwOS3GV7v1Jj4w8Lnn7HDgKjBxagUz61/e10t0x6Dlj
    m0R9OliOLHOecqAH1VBm0MAvCtXkFTP0O1dXi0vQumItX6bxyL7qM368GOelZcPY
    0ZAgzpMdf+AVAX0NJpcs93D5Ortc2n1AJlRhijrmD1A7mYtTklqcfW80/YE3ZJvl
    k527X4oYRAXtRisLwwYrxXuwklL4G6qxVG/ifTYsDGVV5iiiZkIItXL208jgBXDc
    am581irY0tWSaAhOkLNNV1kVLiua4qixH0bECtVpACR+lt5jSPMVofkm57izOsqD
    RdXf8q9bxVDZwXdZ++c1AQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJDFI3xMdTcl50ZAQmoRNb70rUFOOkUzeAMLwgqOovi1MduYSxDTozqz7nvst24WOOkAZ7uM/d3afbPv481ZPLtoV8Ik3DZSoGuUWxpwRlMZECfRiIxS
    TlOqg7y6ufG72l1BbGbt5KyP5qb2emlxgGWOiZQlwYskiZ7GMKmNN3bv2vsG2RxJvIZuLGlRjmdONvu6VWxBDx2IF0qXRdW9c4PpKbMOF9hLkWVH6o7EXv0d
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=mGcY1-y8K0sA:10 a=JQGMX7YiA1EA:10
    a=jgdRYvh6jJ0A:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=QDZ4HvhdkI4A:10 a=LpQP-O61AAAA:8 a=VwQbUJbxAAAA:8 a=-JPJ9f5lkuXB304MSBwA:9
    a=QEXdDO2ut3YA:10 a=pioyyrs4ZptJ924tMmac:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752377AbeEQOcI (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 10:32:08 -0400
Received: from g2t2352.austin.hpe.com ([15.233.44.25]:7502 "EHLO
        g2t2352.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751930AbeEQOcF (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 May 2018 10:32:05 -0400
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "mhocko@kernel.org" <mhocko@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>
Subject: Re: [PATCH v3 2/3] ioremap: Update pgtable free interfaces with addr
Thread-Topic: [PATCH v3 2/3] ioremap: Update pgtable free interfaces with addr
Thread-Index: AQHT7W5RnIhzUqd53Eq708d/eUGuN6QzexuAgACBVYA=
Date: Thu, 17 May 2018 14:32:01 +0000
Message-ID: <1526567449.2693.608.camel@hpe.com>
References: <20180516233207.1580-1-toshi.kani@hpe.com>
         <20180516233207.1580-3-toshi.kani@hpe.com>
         <20180517064755.GP12670@dhcp22.suse.cz>
In-Reply-To: <20180517064755.GP12670@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.219.163.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB1041;7:wVRaMq+yH435rgy8P4e5/I/FoPpWtT5vOhTEs/mR1O5RcFsOMwiG0ZaUU1pnyl7uu7t2qNjzcub+/SoIZ/1eLOsjfrSf45np1/TH1kVDyu/HyKwE1yJYmtjBcPZ4vcFT81JOJQd/mMwWlAzi7DHvjII2MUDIyu/K+mkRb67Mkq7UR4jDfVAK5Y5z8HjoaQ3RaJ7QuLbcZ0TOSbvxRKykgOnRxCWNZgrK2biQSWdJAwg0jw0B2plOlBzTbHiOGKU8
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB1041;
x-ms-traffictypediagnostic: AT5PR8401MB1041:
x-microsoft-antispam-prvs: <AT5PR8401MB10415B28F6D2317C495C70A682910@AT5PR8401MB1041.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AT5PR8401MB1041;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB1041;
x-forefront-prvs: 067553F396
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(346002)(366004)(396003)(39380400002)(376002)(377424004)(189003)(54534003)(199004)(76176011)(966005)(6116002)(4326008)(6916009)(3846002)(103116003)(7416002)(6486002)(229853002)(66066001)(5640700003)(6436002)(6506007)(102836004)(478600001)(59450400001)(6246003)(5250100002)(53936002)(6306002)(2501003)(14454004)(54906003)(86362001)(99286004)(6512007)(26005)(316002)(186003)(105586002)(81166006)(25786009)(1730700003)(81156014)(97736004)(68736007)(8676002)(446003)(3280700002)(11346002)(486006)(8936002)(15650500001)(7736002)(2906002)(305945005)(36756003)(2900100001)(5660300001)(476003)(2616005)(106356001)(2351001)(3660700001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB1041;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: sVxH/ZVaqnzoHruJE9lvs02Mq9m7ighTjuMKbVynEeGJxcqIyDXhw4DszFSxjCLuyTZL4UThyD/DhjQsBDA37F2uBBNB7RcLH6MKwnj/YqcIiLa92h7jXvGEwt5C77AEOJuUErpYFK0PzkSXPo/fQWFRDIXO/VCiHN51YKDZe72muLAk77+4dY/u2nZBIVEn
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <26F40FFEB370414CB03568B3AD5A7F9B@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 323019c8-7c72-420d-5dc1-08d5bc02f487
X-MS-Exchange-CrossTenant-Network-Message-Id: 323019c8-7c72-420d-5dc1-08d5bc02f487
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2018 14:32:01.9699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1041
X-OriginatorOrg: hpe.com
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gVGh1LCAyMDE4LTA1LTE3IGF0IDA4OjQ3ICswMjAwLCBNaWNoYWwgSG9ja28gd3JvdGU6DQo+
IE9uIFdlZCAxNi0wNS0xOCAxNzozMjowNiwgS2FuaSBUb3NoaW1pdHN1IHdyb3RlOg0KPiA+IEZy
b206IENoaW50YW4gUGFuZHlhIDxjcGFuZHlhQGNvZGVhdXJvcmEub3JnPg0KPiA+IA0KPiA+IFRo
aXMgcGF0Y2ggKCJtbS92bWFsbG9jOiBBZGQgaW50ZXJmYWNlcyB0byBmcmVlIHVubWFwcGVkDQo+
ID4gcGFnZSB0YWJsZSIpIGFkZHMgZm9sbG93aW5nIDIgaW50ZXJmYWNlcyB0byBmcmVlIHRoZSBw
YWdlDQo+ID4gdGFibGUgaW4gY2FzZSB3ZSBpbXBsZW1lbnQgaHVnZSBtYXBwaW5nLg0KPiA+IA0K
PiA+IHB1ZF9mcmVlX3BtZF9wYWdlKCkgYW5kIHBtZF9mcmVlX3B0ZV9wYWdlKCkNCj4gPiANCj4g
PiBTb21lIGFyY2hpdGVjdHVyZXMgKGxpa2UgYXJtNjQpIG5lZWRzIHRvIGRvIHByb3BlciBUTEIN
Cj4gPiBtYWludGFuYW5jZSBhZnRlciB1cGRhdGluZyBwYWdldGFibGUgZW50cnkgZXZlbiBpbiBt
YXAuDQo+ID4gV2h5ID8gUmVhZCB0aGlzLA0KPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5v
cmcvcGF0Y2gvMTAxMzQ1ODEvDQo+IA0KPiBQbGVhc2UgYWRkIHRoYXQgaW5mb3JtYXRpb24gdG8g
dGhlIGNoYW5nZWxvZy4NCg0KSSB3aWxsIHVwZGF0ZSB0aGUgZGVzY3JpcHRpb24gYW5kIHJlc2Vu
ZCB0aGlzIHBhdGNoLg0KDQpUaGFua3MhDQotVG9zaGkNCg==
