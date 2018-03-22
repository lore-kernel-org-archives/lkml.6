Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3583411-1521748971-2-8592258696289743555
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521748970; b=WoO4ntGf6jXv6U5ne/Z0yotZ6sLKOcVKFAvsiIyUXJ6wnaq
    VWKPdJ+FE8p6sLizmMIsfulHts2W84j6/S+vX0Chq66T+4cvN5T5TdwRqujptXdh
    VCMBw6zwRfpvumd8WFeMwd0JQ0F/s5T9J7dAl9WJwehOHYpsR4bqGgp3xwsoJrwe
    HDsscL3hoQJlTOaqWRWCq77g0u/8S389jTJaa64VX8drNljAavfDj9WoQS3ZakQ+
    5I5SVmGLCNztemiAM3Y3yKFehQIHdab+q0F3RpFbR8HPtUx+fPgT8vPFAoU8CvZK
    Klg7q8ssJCGEnneUpQxEKOwEADu2iMnqaZuaMUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521748970; bh=uIH/VdoWg6suweJ/e4iEfWSXrKhbdsNE9YHp/L
    eFNxI=; b=GJo57ucHj5VAV3ADpEWpU9PpPZpQDk3BqrfODdl3WOYG+0SF0iOLh/
    xiZllIxqaeIM3VrZO8w2mryzZx5OKd2coj51CEPq9nQefCl7bKb9ivHsykpUThjz
    A7wdqnH1CzjjQIulAxqx0EnYxm0v+WWVlY4fdTVMmIlT+MLcZBG2Wqg1FrnG/OyK
    9j/Y5+kpFDjcVGmMvP8VCQIElZaJZZ1jJVdKplEsY9uzfDtuJsgDdiJKZ5ww9DQT
    yQjyXyPTZuf4TJ6cvzJ7IV7sCi1DCpSdSm9q+NIN/O7dYpedcfV4YNfYHbUM9/9o
    WoVdbADYOBvIoz39sSnbAeBT3Jr5kGjw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=onevmw.onmicrosoft.com header.i=@onevmw.onmicrosoft.com header.b=oEsbT8fs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-vmware-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=vmware.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=vmware.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=onevmw.onmicrosoft.com header.i=@onevmw.onmicrosoft.com header.b=oEsbT8fs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-vmware-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=vmware.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=vmware.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751753AbeCVUCs (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 16:02:48 -0400
Received: from mail-sn1nam02on0086.outbound.protection.outlook.com ([104.47.36.86]:27072
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751600AbeCVUCr (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 22 Mar 2018 16:02:47 -0400
From: Nadav Amit <namit@vmware.com>
To: Oleksandr Natalenko <oleksandr@redhat.com>
CC: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xavier Deguillard <xdeguillard@vmware.com>,
        pv-drivers <pv-drivers@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Gil Kupfer <gilkup@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "ldu@redhat.com" <ldu@redhat.com>
Subject: Re: [PATCH v2] vmw_balloon: fixing double free when batching mode is
 off
Thread-Topic: [PATCH v2] vmw_balloon: fixing double free when batching mode is
 off
Thread-Index: AQHTujhdSIiXJAlj90GNO4oOVtEcZaPPHhoAgAjUbYCAANEfgIAD+VyA
Date: Thu, 22 Mar 2018 20:02:38 +0000
Message-ID: <219A03D6-7375-4577-90BA-45DCF2A29289@vmware.com>
References: <20180312191917.21381-1-namit@vmware.com>
 <20180312192848.22104-1-namit@vmware.com>
 <E63288C3-BE4F-4D41-A074-1CB86C74414E@vmware.com>
 <BB21DC03-9168-4E5E-B5CA-D446E07BE52F@vmware.com>
 <CAHcwAbSijSmeU3WnznAC+ZaF9iCmYkizqiJNuvLcrYm-YCWxRg@mail.gmail.com>
In-Reply-To: <CAHcwAbSijSmeU3WnznAC+ZaF9iCmYkizqiJNuvLcrYm-YCWxRg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR05MB651;7:6HpoYn0M2T4wohrXMP9zv2QpwtgJmBGMJW+FLQk2sUD/S0kijfw8CdOa/zV6HfFPG6z5N63QPKwc/y6louxNSgZGSAAJfIry5mKUpw9cAw+XrkI5H31xOKyGgPUpz+bk52W+3NARqRCNQXrZ4qdrz4Cgn/+yqGmwidkUgNU1CDllI7yyx3bjxwt+Wg6eIyf1zlUoIp0c5aTSfLOU1b8cBHuWwH6JGlLQn6kYEq54+2o4SIyg/T4ydXbv/oAGhYsU;20:mdCmi3YfqrXe2wqrfoo/8SSVGKfv0l6GE5RFpikB0xHClQfIT8B4kjdFmU2cNgmOnVJjW57x7X0lmttNyyPoMT3ngfJI3Cf+ZyfCA/No4lurbpVEzhf7O8NaPYG3xHN8K1EhIizqwvR/vDmzu9mINA249aDgPVtRazYjgza0fwI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d05b5eee-2b43-4c4e-efa9-08d5902fdd11
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO2PR05MB651;
x-ms-traffictypediagnostic: CO2PR05MB651:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <CO2PR05MB651E939C054916827E7BC2ED0A90@CO2PR05MB651.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CO2PR05MB651;BCL:0;PCL:0;RULEID:;SRVR:CO2PR05MB651;
x-forefront-prvs: 0619D53754
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(199004)(189003)(6512007)(6116002)(316002)(3846002)(97736004)(14454004)(3660700001)(2906002)(6436002)(3280700002)(6246003)(53936002)(6486002)(6506007)(76176011)(68736007)(83716003)(11346002)(446003)(26005)(82746002)(53546011)(99286004)(102836004)(77096007)(186003)(59450400001)(86362001)(7736002)(6916009)(105586002)(4326008)(39060400002)(106356001)(5660300001)(305945005)(33656002)(66066001)(36756003)(25786009)(229853002)(93886005)(8676002)(81166006)(2900100001)(54906003)(8936002)(81156014)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR05MB651;H:CO2PR05MB2646.namprd05.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: amGzkXdMiq9vZbmKyEKbhZKffmJSFreLj+PlcMzwzVDuvEvVGRSlqn86yIe58HFgIiEc4/vPXW4ttdube9bepAokNLPkOGVQ1yM/5mC1w/nNoI5O6Tg0uhp392eBnBRlbdpDDwl/v7Xdbzg7DHW0xzqOA/kMQ95Lt6gNjchmoMahWrmm44BhFm+dU8Q+/tgRGX/1R29GviIPn0OLE968zaKIFWmNgZQhEsNMpt8S9yzSjJYZ0wAUO20pX/pyW2KqG4u0ps4bECJDCCMbvY+99Yl8IFyFpU+w/mLOe/5laVKsV0PvFSybk6aUDuGY4yQnG6sYYyWAhkn47vMBO8iGfQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9BBD8D40A87E54F9C87A8C149C35AA8@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d05b5eee-2b43-4c4e-efa9-08d5902fdd11
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2018 20:02:38.7204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR05MB651
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T2xla3NhbmRyIE5hdGFsZW5rbyA8b2xla3NhbmRyQHJlZGhhdC5jb20+IHdyb3RlOg0KDQo+IEhp
Lg0KPiANCj4gT24gTW9uLCBNYXIgMTksIDIwMTggYXQgNzo1MiBQTSwgTmFkYXYgQW1pdCA8bmFt
aXRAdm13YXJlLmNvbT4gd3JvdGU6DQo+Pj4gT2xla3NhbmRyLCBpZiB5b3UgY2FuIGNvbmZpcm0g
dGhhdCBpdCBmaXhlcyB0aGUgYnVnIHlvdSBlbmNvdW50ZXJlZCwgaXQNCj4+PiB3b3VsZCBiZSBn
cmVhdC4NCj4+PiANCj4+PiBHcmVnLCBBcm5kLCBvbiB5b3VyIGZyZWUgdGltZSwgcGxlYXNlIGxl
dCBtZSBrbm93IGlmIHRoZXJlIGlzIGFueSBpc3N1ZQ0KPj4+IHdpdGggdGhlIHBhdGNoLCBhbmQg
d2hldGhlciB5b3UgY2FuIGluY29ycG9yYXRlIGl0LCBwcmVmZXJhYmx5IGluIDQuMTYsDQo+Pj4g
c2luY2UgaXQgaXMgYSBidWctZml4IHRoYXQgd2FzIGVuY291bnRlcmVkIGJ5IFJlZC1IYXQgY3Vz
dG9tZXJzLg0KPj4gDQo+PiBQaW5nPw0KPiANCj4gTm8gbmV3cyBmcm9tIG1lICh5ZXQpLiBXZSBk
ZXBlbmRzIG9uIHRoZSBjdXN0b21lciBoZXJlIHNpbmNlIHdlIGFyZQ0KPiB1bmFibGUgdG8gcmVw
cm9kdWNlIHRoZSBpc3N1ZSBpbi1ob3VzZS4gSWYgeW91IGhhdmUgYSByZWNpcGUgb24gaG93IHRv
DQo+IHRyaWdnZXIgaXQgcmVsaWFibHksIHBsZWFzZSBsZXQgdXMga25vdywgYW5kIHRoaXMgd2ls
bCBzcGVlZCB1cCB0aGUNCj4gdmVyaWZpY2F0aW9uIHByb2Nlc3MuDQoNCkFjdHVhbGx5LCByZWNo
ZWNraW5nIHRoZSBidWcgZGVzY3JpcHRpb24sIEkgbWlnaHQgaGF2ZSBydXNoZWQuIFRoZSBidWcg
dGhhdA0KSSBlbmNvdW50ZXJlZCBpcyByZWxhdGVkIHRvIHRoZSB2dW5tYXAoKSBidXQgaXQgaXMg
b25seSBjYXVzZWQgd2hlbiBiYXRjaGluZw0KaXMgb2ZmLCB3aGlsZSB0aGUgYnVnIHlvdSByZXBv
cnRlZCBoYXMgYmF0Y2hpbmcgb24uDQoNCkl0IHNlZW1zIHRoYXQgeW91ciBzb3VyY2VzIHN1cHBv
cnQgYmF0Y2hpbmcgYnV0IGRvIG5vdCBpbmNsdWRlIGI5MWYxMDhhM2Q1NA0KKOKAnFZNd2FyZSBi
YWxsb29uOiBUcmVhdCBpbml0IGxpa2UgcmVzZXTigJ0pLCB3aGljaCBJIHRoaW5rIHdvdWxkIGhh
dmUgc29sdmVkDQp0aGUgcHJvYmxlbS4gSSBkb27igJl0IHNlZSBhIG1haW5saW5lIGtlcm5lbCB0
aGF0IHN1cHBvcnRzIGJhdGNoaW5nIGFuZCBkb2VzDQpub3QgaGF2ZSB0aGlzIHBhdGNoLCBzbyBp
dCB3b3VsZCBiZSBoZWxwZnVsIHRvIHNlZSB0aGUgZXhhY3QgbW9kdWxlIHRoYXQgeW91DQp1c2Uu
DQoNClJlZ2FyZHMsDQpOYWRhdg==
