Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523236604-2-14745793667572986640
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
    1523236603; b=CA9NWhZUvrEl7EHdFzmqNNmlEsRwNP1ztKmiLrszxgqTzC2FAv
    pGtL4afhsmvuEK/ujre7xZ6jNYW2B2THPi2P+VOlVFt687mo00oDv2lNLtrf9NZ+
    3TDDTkPcywCk38bkBxohsVQuAohk8AoNnvDRk00zQGtPHLrdeK5tidjFLRh8ZZln
    K/gjkdgZVUk2F+39m4wtr+DBPXdcRfQJWuPiqhZi7mMaVJDG4HNzLf9MhQ+EV47M
    oW0Ub5XWS1+X3XJPhq0CsdpI5uTn6MVMtySVMGh8sdgeTeqoy7jeJitSKcZ6hi+T
    cv3Uw0TX64YnsvxAw4btHhB5/aOA9m3xnxNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523236603; bh=kzMDKbR14QLtnrrF4vc9iaxgKxDRnd1hnkbNEp05Lbc=; b=
    oiL7d14iCL3O+94X1SekKjEA3T1tXA3/CPU9EGDeOk4o32RIoKR61eg8J4niv9iX
    3uHlLdeCDfyYH75wtmLz5q0sn8nzoIVoEPoR3Bg1LYm7fANwnL8ljBTN8mhqPnSs
    2U2GKRq8pUr41MR5G1noiVB9fQPcWCeUUWaKkSO8VjtDZo+Td3gVq7A6TnOprGRz
    cfycYgZy1CWtBE6ZvJbqlzo9v4f8SIO2qe7koIL0nNs3IgSViMjI1NLezITyDkHG
    Hhx7SXjv7fGs5RHKAF94Mbd/EgAVc+EBWkWAlbqd+rWQGWMN10cVeqGKlvrIKovz
    tFmnCR8ammPCOtfYwNJjUw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BlRcsugX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BlRcsugX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB2FQErChfQmbnOrXPd6wRo9d7SOvpJhbsf/L3JZClPclox/EhYxFi5Y63RG/tei+YBzztdJSsYVg9V8v0ktKS5ricUJQtTSi+dGlmZaiupacoQ12Yl3
    RD1dpifB8cRQ4K6H3rh4BRIC/tT/KKg0Ospmts8szAgjIepImOzLn9qoTbC/JcPVFbhHEZSFlm2im/eScvjIRSKLljJisl8itVGGebAkXx2/+jJaK+WWa/vZ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=XkRKQH6RAAAA:8 a=cm27Pg_UAAAA:8
    a=yMhMjlubAAAA:8 a=7TMZ7IPSw7-ybUbJCQsA:9 a=QEXdDO2ut3YA:10
    a=1gUyE30hU_ULiMxJiLUW:22 a=xmb-EsYY8bH0VWELuYED:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932130AbeDIBQ0 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:16:26 -0400
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:27456
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932865AbeDIAhx (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:53 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>,
        "kernel-hardening@lists.openwall.com"
        <kernel-hardening@lists.openwall.com>,
        Kees Cook <keescook@chromium.org>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 109/162] kvm: x86: fix KVM_XEN_HVM_CONFIG
 ioctl
Thread-Topic: [PATCH AUTOSEL for 4.4 109/162] kvm: x86: fix KVM_XEN_HVM_CONFIG
 ioctl
Thread-Index: AQHTz5nF2m1UU3oaVkuVUAGNCPsxTQ==
Date: Mon, 9 Apr 2018 00:29:07 +0000
Message-ID: <20180409002738.163941-109-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:yWaw2wZzTtc5/1eXbsT5601Vp/ULQEWlOz7CO8kZlm2t9aVBN8cxXIrwwFGcjG96SQFDISemp00YN2xqbTsfkb3qxHbFnhc5xwFSpvVVRImbOrMw6NsvEQj+NmxZhGztgXR7oKq0ufq9eIWHoAd1kyv39OgtCprtOCZU2+auiwa6LYK2JMUxY50E+WrwnhLsITu3o3Lvo0JZsSi2e6fcEAVkcmESwx+lNzN1bXm1anCZVJbSG57AzDx+oFIxiSwO;20:6nnB7T9takWWTG+bILaIxhbJOYmg/QmrV3IE0H4suJZ0+E9plGLhJSXmLfvfGoc49X5l4hfxo6Cgu+74lEptB+Axoyyt2goIiCmCgn7H5CQJUzFUWnEbeEzaUzEIH09t5huvkpuNStImhsvxBg83JkOFTyr1WRwzRg2yQZq8AP4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: c46b4106-96d8-4bf1-de0a-08d59db21eaa
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1110F68CE6A0C625BE227AC4FBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(346002)(396003)(376002)(366004)(199004)(189003)(53936002)(186003)(5250100002)(105586002)(11346002)(99286004)(476003)(66066001)(6512007)(86362001)(575784001)(3660700001)(1076002)(54906003)(68736007)(110136005)(3280700002)(316002)(305945005)(4326008)(107886003)(22452003)(14454004)(7736002)(446003)(6666003)(2501003)(10290500003)(3846002)(6116002)(72206003)(106356001)(25786009)(6486002)(6436002)(8936002)(478600001)(5660300001)(86612001)(8676002)(81156014)(59450400001)(2906002)(102836004)(81166006)(6506007)(2900100001)(76176011)(2616005)(486006)(26005)(36756003)(10090500001)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: p+kMo2feeyjaoH0AWwlZzrGVFHwYc7gKFXXmF/+nMOBnl/c2zYuh2vQYuuxK24JSWoUJcI8wSSdSZ80vtc5K2BqicrZ/qRVaQ8WgU9SaSLbc+VbTcGBX01bhGQux7Rsc7z4EjFuMM07LzFK24gm3JhUjIwU7KyQF32Z2016H+xgaa10T+aVU3bcRJcftgEbdbbZ/PZUFGPtCTUhXQ0EFgMbEHW5oGFeQ6mIMnPNNNrdMCcWG/WNmhR6TnZ4RBdmmcMt/4paStMuxbyP0J8L0mYCuWQ32dthS4aVhoEe+gylN+UFZkZeCIloqAQ1Kj/Xc5o2TwrTXU+EsPPf2QJ2gXy2xtFrir/s4roCQfWLwySrPSjH7eDzIF9A/CQCFGXRkH1q7hHaEJ8xfVbJmABoNcen/XwY2BSXFX79gjUESH1c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <69065A9D733C92428F7E0428E1A89B6A@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c46b4106-96d8-4bf1-de0a-08d59db21eaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:07.4117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
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
eDg2LmMgYi9hcmNoL3g4Ni9rdm0veDg2LmMNCmluZGV4IGYzN2YwYzcyYjIyYS4uOWNlYTA5NTk3
ZDY2IDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva3ZtL3g4Ni5jDQorKysgYi9hcmNoL3g4Ni9rdm0v
eDg2LmMNCkBAIC0zOTczLDEzICszOTczLDE0IEBAIGxvbmcga3ZtX2FyY2hfdm1faW9jdGwoc3Ry
dWN0IGZpbGUgKmZpbHAsDQogCQltdXRleF91bmxvY2soJmt2bS0+bG9jayk7DQogCQlicmVhazsN
CiAJY2FzZSBLVk1fWEVOX0hWTV9DT05GSUc6IHsNCisJCXN0cnVjdCBrdm1feGVuX2h2bV9jb25m
aWcgeGhjOw0KIAkJciA9IC1FRkFVTFQ7DQotCQlpZiAoY29weV9mcm9tX3VzZXIoJmt2bS0+YXJj
aC54ZW5faHZtX2NvbmZpZywgYXJncCwNCi0JCQkJICAgc2l6ZW9mKHN0cnVjdCBrdm1feGVuX2h2
bV9jb25maWcpKSkNCisJCWlmIChjb3B5X2Zyb21fdXNlcigmeGhjLCBhcmdwLCBzaXplb2YoeGhj
KSkpDQogCQkJZ290byBvdXQ7DQogCQlyID0gLUVJTlZBTDsNCi0JCWlmIChrdm0tPmFyY2gueGVu
X2h2bV9jb25maWcuZmxhZ3MpDQorCQlpZiAoeGhjLmZsYWdzKQ0KIAkJCWdvdG8gb3V0Ow0KKwkJ
bWVtY3B5KCZrdm0tPmFyY2gueGVuX2h2bV9jb25maWcsICZ4aGMsIHNpemVvZih4aGMpKTsNCiAJ
CXIgPSAwOw0KIAkJYnJlYWs7DQogCX0NCi0tIA0KMi4xNS4xDQo=
