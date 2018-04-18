Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-901495-1524074069-2-11504721354359854901
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524074068; b=Yh2luvjDHy0zuCNxqf7hDpICPrJDo/1Ika0EugDsWBcLthJ6mw
    r4ge1oPLZlgSskJg88Hdq7qU66y/XzNtvCe2ker+iHkKnLHCo8hU4z4IhD44SUqC
    pMYGwFyTfL0Uv7tFBXBUW+nkLQCCqscux7ImUi6s4A8mkm96iog8aR1AWJ4gH/p3
    1J6OsSTZKsD360ZPqQ0BHe3KlyKPL8xWZ0vsukK21synG508Y93sqlCBlpt9p947
    Tef/2lLLi7CrIsixnEePKJu2KUgzjnNd1JLZR9jIzJcXvV5OuU8BiCaBTGrbENV6
    hJhJi3QnryqHChcJsrW8cd/MuS+QEA74+crg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1524074068; bh=fl/b72mFQFwPVdgyD/EDJYVMEZsRKYUjwgoegjv8Otk=; b=
    JbJjWKl+qZniD7Zi7H32AgSJ09N7XoCQty0Ypa2au8Imm85YseB+aDVvpa3z7vfP
    PSdbS+u7275F7vZswV80L4ZxJFKxsuAcJ4wJVlWa/MsVV5vQXREyRjxb9A7AfMig
    pcEWgPIYQkOE4UWcWWRcfoVv+585UMmBJNh/+RNi8aZpDR/JU1IFKmc+El5ez2GH
    MFzb0yEsdVDMXaOIOa6XzO+oApg5Uzp3V6sJfJK4eMN11igBrpIjvmGaDyuUWSoF
    2TPHyynJUYoKGCs4iaFIhBhly4bYOwWr8Vnf+/dvFBabDWBx05ngiD/qG4goVxHq
    zSQwRzj4TbM+Ou8ZYZWBQA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=onevmw.onmicrosoft.com header.i=@onevmw.onmicrosoft.com header.b=Sf/Us/eG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-vmware-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=vmware.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=vmware.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=onevmw.onmicrosoft.com header.i=@onevmw.onmicrosoft.com header.b=Sf/Us/eG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-vmware-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=vmware.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=vmware.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJv5/YflWV1g60SKbjN+ufJupiBUMgnqF/BVjJk9sv9YaQiNmompOVE9yn8gA3CZWODQIXlbOBYEdp2EZzOjibTJQr8SQIFdNBW3nV6ulG8CrHIDXJwl
    Nn9KhFAmbGhJAYtqlwzW5Ex4VGIPsUg7b38C0fWjmXjJRbqREeUtjqBnTWFx98slUE1ucT223UeSLrVO2Qer2rj7nQae9E9gJn2ZB4GKVChu+QSschQwRtpL
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=vHgnHrlTdrAA:10 a=0LR3lYp3nzMA:10
    a=ejqztYjC2d8A:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=5RTpqG2m6HgA:10 a=20KFwNOVAAAA:8 a=j1rgVpbU0JGhMz1IAs4A:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeDRRyZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 13:54:25 -0400
Received: from mail-sn1nam02on0049.outbound.protection.outlook.com ([104.47.36.49]:42240
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751878AbeDRRyY (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 18 Apr 2018 13:54:24 -0400
From: Nadav Amit <namit@vmware.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Arnd Bergmann <arnd@arndb.de>,
        Xavier Deguillard <xdeguillard@vmware.com>,
        pv-drivers <pv-drivers@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Gil Kupfer <gilkup@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "ldu@redhat.com" <ldu@redhat.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>
Subject: Re: [PATCH v2] vmw_balloon: fixing double free when batching mode is
 off
Thread-Topic: [PATCH v2] vmw_balloon: fixing double free when batching mode is
 off
Thread-Index: AQHTujhdSIiXJAlj90GNO4oOVtEcZaPPHhoAgAjUbYCAANEfgIAD+VyAgADUVYCAJeh/AIADjkiA
Date: Wed, 18 Apr 2018 17:54:21 +0000
Message-ID: <A518FF77-554C-40E0-8656-5BEFA57C7A8E@vmware.com>
References: <20180312191917.21381-1-namit@vmware.com>
 <20180312192848.22104-1-namit@vmware.com>
 <E63288C3-BE4F-4D41-A074-1CB86C74414E@vmware.com>
 <BB21DC03-9168-4E5E-B5CA-D446E07BE52F@vmware.com>
 <CAHcwAbSijSmeU3WnznAC+ZaF9iCmYkizqiJNuvLcrYm-YCWxRg@mail.gmail.com>
 <219A03D6-7375-4577-90BA-45DCF2A29289@vmware.com>
 <CAHcwAbQ4y3vWp7p7GayfdbzbomLrqLKMfu0egEoEODJ3LN5qOw@mail.gmail.com>
 <CAHcwAbTEjs6+oPYRJ1HTj--Xh6tORygYUL6aU9tMOJ1KHP_eKQ@mail.gmail.com>
In-Reply-To: <CAHcwAbTEjs6+oPYRJ1HTj--Xh6tORygYUL6aU9tMOJ1KHP_eKQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2767;7:Wy+TTtTg2YQz7bFvhv27uBWn3eBQHmEwu0VjCPiO78lzUYno42iWjCUR0V4EhL1mg76YBRE15rFXSjMouZwd33sYw77lSwmk0PYRAK2zjDPhMQSspTVyABTNkDDO+zyrf+GIX34xaCoC4j5afDUC2Gf4wcKB92Z/UGAv1wVeh31gm60FRX129zIHmMR3xIpsLXa+cij/Jq52ONjQOahuYn7/Kg3ajAQhu6BZ245Iyx57E63EIelrwHsgNNLRAg48;20:kZKSKoDCaSfojSFGa6skMnGJtd0XRRS0PZIVxWux8DLc4HOycBs4nzVEyrF+U7m6azYZvw4rIwDwCcrow8nZSSShRoIn/OwK9wjQLyDyTdKsmJ62HxsxGlFvMNmzZjdltfaKbnBddJD45nNTpbu974b6LPUH1NoSVtNZBlleOIA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2767;
x-ms-traffictypediagnostic: SN2PR05MB2767:
authentication-results: outbound.protection.outlook.com; spf=skipped
 (originating message); dkim=none (message not signed) header.d=none;
 dmarc=none action=none header.from=vmware.com;
x-microsoft-antispam-prvs: <SN2PR05MB276744382B3618971FAA6476D0B60@SN2PR05MB2767.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501368)(52105095)(10201501046)(93006095)(93001095)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:SN2PR05MB2767;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2767;
x-forefront-prvs: 06469BCC91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39380400002)(366004)(39860400002)(199004)(189003)(7736002)(54906003)(3280700002)(25786009)(81156014)(59450400001)(316002)(2906002)(6916009)(81166006)(8676002)(476003)(53546011)(99286004)(3660700001)(2616005)(93886005)(11346002)(76176011)(6506007)(26005)(5250100002)(102836004)(6512007)(6436002)(5660300001)(6116002)(2900100001)(8936002)(3846002)(36756003)(446003)(4326008)(86362001)(14454004)(39060400002)(6486002)(575784001)(82746002)(33656002)(478600001)(229853002)(186003)(53936002)(66066001)(305945005)(6246003)(83716003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2767;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;A:1;MX:1;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <954EDA97D7EBB149B222D9C9D542D9A5@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e282f2fb-8c44-464f-b30b-08d5a5556a8f
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e282f2fb-8c44-464f-b30b-08d5a5556a8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2018 17:54:21.9156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2767
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T2xla3NhbmRyIE5hdGFsZW5rbyA8b2xla3NhbmRyQHJlZGhhdC5jb20+IHdyb3RlOg0KDQo+IEhl
bGxvLg0KPiANCj4gT24gRnJpLCBNYXIgMjMsIDIwMTggYXQgOTo0MiBBTSwgT2xla3NhbmRyIE5h
dGFsZW5rbw0KPiA8b2xla3NhbmRyQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4+IEFjdHVhbGx5LCBy
ZWNoZWNraW5nIHRoZSBidWcgZGVzY3JpcHRpb24sIEkgbWlnaHQgaGF2ZSBydXNoZWQuIFRoZSBi
dWcgdGhhdA0KPj4+IEkgZW5jb3VudGVyZWQgaXMgcmVsYXRlZCB0byB0aGUgdnVubWFwKCkgYnV0
IGl0IGlzIG9ubHkgY2F1c2VkIHdoZW4gYmF0Y2hpbmcNCj4+PiBpcyBvZmYsIHdoaWxlIHRoZSBi
dWcgeW91IHJlcG9ydGVkIGhhcyBiYXRjaGluZyBvbi4NCj4+PiANCj4+PiBJdCBzZWVtcyB0aGF0
IHlvdXIgc291cmNlcyBzdXBwb3J0IGJhdGNoaW5nIGJ1dCBkbyBub3QgaW5jbHVkZSBiOTFmMTA4
YTNkNTQNCj4+PiAo4oCcVk13YXJlIGJhbGxvb246IFRyZWF0IGluaXQgbGlrZSByZXNldOKAnSks
IHdoaWNoIEkgdGhpbmsgd291bGQgaGF2ZSBzb2x2ZWQNCj4+PiB0aGUgcHJvYmxlbS4gSSBkb27i
gJl0IHNlZSBhIG1haW5saW5lIGtlcm5lbCB0aGF0IHN1cHBvcnRzIGJhdGNoaW5nIGFuZCBkb2Vz
DQo+Pj4gbm90IGhhdmUgdGhpcyBwYXRjaCwgc28gaXQgd291bGQgYmUgaGVscGZ1bCB0byBzZWUg
dGhlIGV4YWN0IG1vZHVsZSB0aGF0IHlvdQ0KPj4+IHVzZS4NCj4+IA0KPj4gQ29ycmVjdC4gVGhl
IGhhc2ggaXMgZDc1NjhjMTMwZDBkMGZmMWZjNWIzNjRmYzg3OWI5MWYxMDhhM2Q1NCwgYWN0dWFs
bHksIHRob3VnaC4NCj4+IFllcywgd2UgbWlzcyB0aGlzIGNvbW1pdCBpbiBvdXIgY29kZSBiYXNl
LCBidXQgYWxzbyB3ZSd2ZSBhbHJlYWR5DQo+PiBwcm92aWRlZCBhIHRlc3Qga2VybmVsDQo+PiB3
aXRoIHRoaXMgY29tbWl0IGluY2x1ZGVkIHRvIHRoZSBjdXN0b21lci4gVW5mb3J0dW5hdGVseSwg
d2UgaGF2ZSBubyBhbnN3ZXIgeWV0Lg0KPiANCj4gQXQgbGVhc3QgZm9yIG9uZSBjdXN0b21lciBJ
IGNhbiBjb25maXJtIHRoYXQgdGhlIGtlcm5lbCBidWlsdCB3aXRoDQo+IGJvdGggZDc1NjhjMTMw
IGFuZCB0aGUgcHJvcG9zZWQgcGF0Y2ggZml4ZXMgdGhlIGlzc3VlLg0KDQpHcmVnLA0KDQpDYW4g
eW91IGNvbW1pdCBwbGVhc2UgdGhpcyBwYXRjaD8gUHJlZmVyYWJseSBmb3IgNC4xNz8NCg0KVGhl
cmUgaXMgb25lIG1pbm9yIG1pc3Rha2UgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIC0gdGhpcyBwYXRj
aCBmaXhlcw0KZjIyMGE4MGYwYzJlIGFuZCBub3QgYXMgd3JpdHRlbi4gUGxlYXNlIGxldCBtZSBr
bm93IGlmIHlvdSB3YW50IGEgdjMgb3IgY2FuDQphbWVuZCBpdCB3aGlsZSBjb21taXR0aW5nLg0K
DQpUaGFua3MsDQpOYWRhdg0KDQo=
