Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4122441-1523247177-2-5590037414233060678
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523247177; b=dG5PaLPhX8/11Ymm8vOla2EonimKnfvt+fSNrrceyMcA+QpMT1
    HLlBBwfFZzgxn+LZ327x1zqFpO7+r1bLcNryh/gi1aizKoOOPZJMkVuhiCtnV6SD
    Pgmc+2OkFDNPbdIwQPSYjA1bE0zrTwoqbKth4ylZQ0zGSlSfgZqIRuof59PAHcG2
    bfGg648yc/BMidFG0uFY0IFRQZbdC6fHPiisw+ZyvyBJU8h95aqIVNCVcCkNzop9
    sQqNz8EKJ8BdCYnEFE1m6vSgc60zD41PsUkR5MgcEvM5zXEE5VUdFMefNjz8LVzd
    sAsjO1t9MQizLsKquH4Gf10Wif+YPXOwbfOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523247177; bh=nmLZ6PICmnkQ7Ak96hMNM8tUc6ILXuATc3JDN89ycc0=; b=
    ZDl2qtrGc8XQ2GfGL/KX+T6p4frIA9tkmjdElD08lX/61TcWEvuJB5jMtqGVYt5I
    Ldp0BwSzTJ5CCcCdyCHF9rWCg0c972dPezV7959Pz5XXXAyGhP+0y+ORbsfLlAqe
    0qru8gqgokE5pHk1TH35u5zkd4iihGUiLjNqmMxKUn5vUoFeCjrl+QTyMD/kp+AU
    ANtDnQPc4UwK68bYxjd8J4mGRqEPf2E6N8mI/ao+mVD/S3i9FmXGXttJsAFkVaGe
    G2WHl0550LnyhYXJJFD+d5DXoIdug5PyhQrVW3p/4bylHXo5U+dsSWd4uotBoFAc
    j4rFOYPEYbAOZAswMyuDeQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mG9l/XYh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mG9l/XYh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKSnZuEKHxn/B+iaWzzMc7280CQhz7GB8QKerHXZP5nyjXoson2j7H2PNgwUP/8DGXecwFlmus9hGL3gWfMZpzDr+ozVzU/v/iHa3MQKPsrtKT+IzCTy
    vVEpCHUehqXJEG4nFgcrqw/5CRBtQ0C6k7PuqapuS4FmR+1rnFGm48wMiqzRGzV1aTncN/rQHjczNn48G7R8igapG98nUsgJb9+aoeR+lbwM2PhhUQvov+aH
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=XkRKQH6RAAAA:8 a=cm27Pg_UAAAA:8
    a=yMhMjlubAAAA:8 a=7TMZ7IPSw7-ybUbJCQsA:9 a=QEXdDO2ut3YA:10
    a=1gUyE30hU_ULiMxJiLUW:22 a=xmb-EsYY8bH0VWELuYED:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751978AbeDIEMm (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:12:42 -0400
Received: from mail-cys01nam02on0097.outbound.protection.outlook.com ([104.47.37.97]:28800
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752896AbeDIAQz (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:16:55 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>,
        "kernel-hardening@lists.openwall.com"
        <kernel-hardening@lists.openwall.com>,
        Kees Cook <keescook@chromium.org>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 010/189] kvm: x86: fix KVM_XEN_HVM_CONFIG
 ioctl
Thread-Topic: [PATCH AUTOSEL for 4.15 010/189] kvm: x86: fix
 KVM_XEN_HVM_CONFIG ioctl
Thread-Index: AQHTz5gOnBzLsCCmoEC2C9zv4twziQ==
Date: Mon, 9 Apr 2018 00:16:51 +0000
Message-ID: <20180409001637.162453-10-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0968;7:faCsU/p/hQzS4ysCGnfy3bh8qDT4fh+FVRJ9fJnnKDNhvlO4NmhDxNnaffmthUAheziaoVLhiXE+/47ZBOCh9AshjsaVQzhD4hnQaYlKTvdqIrQrwsaHzbnME90kHBQHu6EHEaOZTMiqZl4992HXOv48CTjFtuYEWg1GQSyapxK+DxIY/cA3y4gXwvlNLEtge6T6UrJ2UQccrxOTZenymvJs41kHJ6uy69//vCz67zyTSRRxPPlrCmTtbeieChNh;20:YxsM4/EffLtiF76stdR7kzlhqBteUJrOczK7faaPKaDUdxY2/uSgojnRJkw2XN0XUrMGsipzZOA0UnMgF+w++n+ITKL1B5FCe3cbSARuEV2vGpxL2SZnqENibkp/rKj98FKehHqKx9pAm8w7NLdviss0Rlfn28WmZ9djuYgkBPk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
X-MS-Office365-Filtering-Correlation-Id: b6a33908-4ddd-40cf-8c30-08d59daf3190
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0968;
x-ms-traffictypediagnostic: DM5PR2101MB0968:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0968888E7178962FF4F54127FBBF0@DM5PR2101MB0968.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0968;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0968;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(346002)(39380400002)(396003)(189003)(199004)(6486002)(53936002)(107886003)(81156014)(36756003)(10290500003)(6436002)(81166006)(5660300001)(478600001)(8936002)(8676002)(6512007)(106356001)(105586002)(5250100002)(2900100001)(7736002)(305945005)(2501003)(10090500001)(66066001)(25786009)(476003)(3846002)(6116002)(186003)(2616005)(59450400001)(68736007)(6506007)(486006)(14454004)(86362001)(99286004)(26005)(102836004)(22452003)(76176011)(11346002)(2906002)(316002)(3660700001)(110136005)(97736004)(86612001)(3280700002)(1076002)(4326008)(446003)(54906003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0968;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: LYVhuHQiBHUuUs8jZsNHT3+iCEqc/EmesPCH7uhXQNGEXZTtwco6Djbcw9VzZ17Xu2ZlVMAR6YeFCtoH+v3cWcOZl640Rui5Q5Ho+XPBMnt7H54kqugih6y0rU71/4rKs/24x0YWRBCP3rYfxZ+3bvUaKd8DFX1Q2VGKehyTkNp7nGBRG/+YzSJCmfIt8nUbpdqUvBfRpZNTdDZbK1Rh0V5P28PNuviMe+oAx5YWunGEb8Lz7LzzW2/24WtmiD1Iq8n7R62717qVvKVTwhytsKAOVtpX5p3klFDLi8xGC1EkFyakOByFqe1WiHK/5e9fzfnDmbVX+1emEmt4WKXmeMIYfAI52+AthCzH0wGE+fKgxP+jhhoqv1D0zfllMtAjCgboExItCngPO26H6FWwn+cR1FltxWTDADhn2d9WVok=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A27094D6286A0C43AC5FB6945EDBD0B4@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a33908-4ddd-40cf-8c30-08d59daf3190
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:16:51.7937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0968
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCg0KWyBVcHN0cmVhbSBj
b21taXQgNTE3NzYwNDNhZmE0MTU0MzVjN2U0NjM2MjA0ZmJlNGY3ZWRjNDUwMSBdDQoNClRoaXMg
aW9jdGwgaXMgb2Jzb2xldGUgKGl0IHdhcyB1c2VkIGJ5IFhlbm5lciBhcyBmYXIgYXMgSSBrbm93
KSBidXQNCnN0aWxsIGxldCdzIG5vdCBicmVhayBpdCBncmF0dWl0b3VzbHkuLi4gIEl0cyBoYW5k
bGVyIGlzIGNvcHlpbmcNCmRpcmVjdGx5IGludG8gc3RydWN0IGt2bS4gIEdvIHRocm91Z2ggYSBi
b3VuY2UgYnVmZmVyIGluc3RlYWQsIHdpdGgNCnRoZSBhZGRlZCBiZW5lZml0IHRoYXQgd2UgY2Fu
IGFjdHVhbGx5IGRvIHNvbWV0aGluZyB1c2VmdWwgd2l0aCB0aGUNCmZsYWdzIGFyZ3VtZW50LS0t
dGhlIHByZXZpb3VzIGNvZGUgd2FzIGV4aXRpbmcgd2l0aCAtRUlOVkFMIGJ1dCBzdGlsbA0KZG9p
bmcgdGhlIGNvcHkuDQoNClRoaXMgdGVjaG5pY2FsbHkgaXMgYSB1c2Vyc3BhY2UgQUJJIGJyZWFr
YWdlLCBidXQgc2luY2Ugbm8gb25lIHNob3VsZCBiZQ0KdXNpbmcgdGhlIGlvY3RsLCBpdCdzIGEg
Z29vZCBvY2Nhc2lvbiB0byBzZWUgaWYgc29tZW9uZSBhY3R1YWxseQ0KY29tcGxhaW5zLg0KDQpD
Yzoga2VybmVsLWhhcmRlbmluZ0BsaXN0cy5vcGVud2FsbC5jb20NCkNjOiBLZWVzIENvb2sgPGtl
ZXNjb29rQGNocm9taXVtLm9yZz4NCkNjOiBSYWRpbSBLcsSNbcOhxZkgPHJrcmNtYXJAcmVkaGF0
LmNvbT4NClNpZ25lZC1vZmYtYnk6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+
DQpTaWduZWQtb2ZmLWJ5OiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4NClNpZ25l
ZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5AbWljcm9zb2Z0LmNvbT4NCi0t
LQ0KIGFyY2gveDg2L2t2bS94ODYuYyB8IDcgKysrKy0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0v
eDg2LmMgYi9hcmNoL3g4Ni9rdm0veDg2LmMNCmluZGV4IGExMGRhNTA1MjA3Mi4uNDFhOGFjNDRk
NWNjIDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva3ZtL3g4Ni5jDQorKysgYi9hcmNoL3g4Ni9rdm0v
eDg2LmMNCkBAIC00MjQ0LDEzICs0MjQ0LDE0IEBAIHNldF9pZGVudGl0eV91bmxvY2s6DQogCQlt
dXRleF91bmxvY2soJmt2bS0+bG9jayk7DQogCQlicmVhazsNCiAJY2FzZSBLVk1fWEVOX0hWTV9D
T05GSUc6IHsNCisJCXN0cnVjdCBrdm1feGVuX2h2bV9jb25maWcgeGhjOw0KIAkJciA9IC1FRkFV
TFQ7DQotCQlpZiAoY29weV9mcm9tX3VzZXIoJmt2bS0+YXJjaC54ZW5faHZtX2NvbmZpZywgYXJn
cCwNCi0JCQkJICAgc2l6ZW9mKHN0cnVjdCBrdm1feGVuX2h2bV9jb25maWcpKSkNCisJCWlmIChj
b3B5X2Zyb21fdXNlcigmeGhjLCBhcmdwLCBzaXplb2YoeGhjKSkpDQogCQkJZ290byBvdXQ7DQog
CQlyID0gLUVJTlZBTDsNCi0JCWlmIChrdm0tPmFyY2gueGVuX2h2bV9jb25maWcuZmxhZ3MpDQor
CQlpZiAoeGhjLmZsYWdzKQ0KIAkJCWdvdG8gb3V0Ow0KKwkJbWVtY3B5KCZrdm0tPmFyY2gueGVu
X2h2bV9jb25maWcsICZ4aGMsIHNpemVvZih4aGMpKTsNCiAJCXIgPSAwOw0KIAkJYnJlYWs7DQog
CX0NCi0tIA0KMi4xNS4xDQo=
