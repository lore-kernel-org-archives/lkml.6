Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523244597-2-12484465997455825360
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
    1523244596; b=oZ01WaO4DGAB6bMCGs562QiA3eHYdcJ1WOrHkOEcTqtszNdwxt
    WTU1UEci3sNqyw/0bygt9l1X6cTn3wm5TpwdQrjon2vI9IXn2gUezUN7nMD70VIt
    3U2JJte80ivViX/KhhtiPdbEpjQBLh13MnUh3aw0QBBUR/NmvrsWst6k0QLUYKoP
    nFvmNeCU+HJAwyITjO9C9P9DRIqCblXHLR2r2qKZcv9sA9K4b0YnCB++XCsW/OVr
    jefwZ7Du0jKGSOcoZLtnP6GrsDAcwSqXnNcr6EbbAL3hAoRGemdlJubzyWs1L6CP
    LOLkjb2vAfWIpzF0jcGN1dyg8t4nuuP/TRaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523244596; bh=Jc6j803jtHdLdEZ3tGd62vAsujMIKceynTxriJL/DVU=; b=
    qVNtXfPA5GAtC7xrnJyO+eE98+rz/z1UaPKZ0pZHYICuvUQb0fqwuSXRoQ5fZQbb
    p3FnZJWbeKkWD7Hv0iFe+vZLNK8AbO4jfNfjaA6NLeSQLIAyrs6Tcauz41QRdTVI
    7Jwp38RwqoxNLm7qUAwkPuC+Dq+lkcz8/d7EgSeDCt2TPeukhel1CJV0/XgAaLEF
    1unXeiaMQZ+slItLc43Q2iPmGJDZ5BrZTGpPtLm7sPpU3j1Cfl2GOTYxBArm8pvA
    P/OuoL+vzoy0Q0BjpQoaXnPU9cIel8vQvnCqyZxgHBDVVQsGt2Xn7yrABTYLLUnd
    yleOZlFQhCsRL6GGCkuyiQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=osAR+CXu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=osAR+CXu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAI6LlTVOwgsj9ZbLoJuOj3mlTHt2bZfs8YLvAfkxl2OxoW7bHX7aypVRsLVfplGA6gok0yFWXLz4pKU12Lgqx6+FtZ9XvcvfUgfalBUM3wLhO7b6kPr
    9hABWwh7xwbOQYWovYpATMgtLM8aSoH82YpY8m+D6BLOaoaRvK1dCvtSV7qLHE/kaXihZ0x0ucEMbeMcmF5seh40qbFyosbnUqWCKly0S/8CbIan7BCg0MbM
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=XkRKQH6RAAAA:8 a=cm27Pg_UAAAA:8
    a=yMhMjlubAAAA:8 a=7TMZ7IPSw7-ybUbJCQsA:9 a=QEXdDO2ut3YA:10
    a=1gUyE30hU_ULiMxJiLUW:22 a=xmb-EsYY8bH0VWELuYED:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbeDID3n (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:29:43 -0400
Received: from mail-sn1nam02on0111.outbound.protection.outlook.com ([104.47.36.111]:52845
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754592AbeDIAWD (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>,
        "kernel-hardening@lists.openwall.com"
        <kernel-hardening@lists.openwall.com>,
        Kees Cook <keescook@chromium.org>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 007/161] kvm: x86: fix KVM_XEN_HVM_CONFIG
 ioctl
Thread-Topic: [PATCH AUTOSEL for 4.14 007/161] kvm: x86: fix
 KVM_XEN_HVM_CONFIG ioctl
Thread-Index: AQHTz5h3OEccfGEqck+DbQntLmIxJA==
Date: Mon, 9 Apr 2018 00:19:46 +0000
Message-ID: <20180409001936.162706-7-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:6g/tZIqlwbQhkoWVUkGfBW5PfkrCFg6XrE3pChj2HPiVQLyMDECFDXFo2VgQas7MmVy5uIU/hN8OLocXkV9/MaNknlIKjWE2PqXazvXilUE3z7d7DOktWsOUTBgKvHWupm/SQDrOQvjEJcHrvM81sujUJzJ255QQh1Jc431xbdCEXt62B8K2hL7Bntx3ZjWjkjcI5z3j418dvkMuviB8O5Prxj2Mcgom47m0KH+uPhnqJAWk6em03ZL/3HPW0v7E;20:f7Dt9jEM2Ic1QWBJ63/hIYj49KPh9tkf8KEL7DuxKXBzQvO9nXf5oOzYG4hGcG0QHuDcqQzic/ac0xptcz5tnB+4Azi7w8TMORTls/lBIXuxK8MnMZncT6kMncWhSdOZLtY3AqkhNIrt8vo9TWen3CJ1YpipRg1ajkp+uHTieB4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3e702149-fb89-4029-e9b8-08d59dafe7df
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0936E9EBAF9A436A77EF2778FBBF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(396003)(376002)(366004)(199004)(189003)(3660700001)(36756003)(2501003)(76176011)(10290500003)(2616005)(5250100002)(3280700002)(478600001)(1076002)(72206003)(6436002)(53936002)(486006)(476003)(4326008)(6486002)(107886003)(5660300001)(54906003)(110136005)(102836004)(2906002)(6116002)(3846002)(86612001)(81156014)(81166006)(6666003)(8936002)(305945005)(8676002)(2900100001)(6506007)(68736007)(14454004)(106356001)(105586002)(25786009)(6512007)(86362001)(99286004)(446003)(59450400001)(10090500001)(11346002)(316002)(26005)(7736002)(66066001)(186003)(22452003)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: teXxyBudHD0HPpKF6AQJcHz4cd0h55RWl2CBi6NeTMtwOcIQDHwBTGUjxr5Os7SYwx9vhqc8cX8GDODKpKeUJ0mA+aiauG5/8gavhdlX1AWU8iwmmQ8/TZXzZXpSyzF106rQlAMR6jfb+MLYUJzTnhwvripJ8fm/rxsmNdBkwY1PgNJCKjEixPRuuqklF/ZmQME8Tg2EG9rdEgpHzYcQy5fDli2JrZtV6Y+LmPFa3R4OoHq0puyPALySgWVszTKYuzAx4vpXIpJ+MwgYCMRImnDIolToFFjCWKUdqOCSPXDkaVHquXsgrhtCfOGi54A50x/bNgAxlpceWWD/yGtn1YHG+MqJBDE2FEQfygiqY2vHtFqOelc+TfF+mb4JvDFq68N5GOoXo6gPWvkBbM0GOPwm+CfQ0+XHBZyzd9Fe6iA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <16FAA9AC9E2A324FA5E4BC2FC9E59BCC@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e702149-fb89-4029-e9b8-08d59dafe7df
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:46.6921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
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
eDg2LmMgYi9hcmNoL3g4Ni9rdm0veDg2LmMNCmluZGV4IGI5YWZiNDc4NGQxMi4uZDc3MjhiY2Q5
YTNjIDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva3ZtL3g4Ni5jDQorKysgYi9hcmNoL3g4Ni9rdm0v
eDg2LmMNCkBAIC00MjI1LDEzICs0MjI1LDE0IEBAIGxvbmcga3ZtX2FyY2hfdm1faW9jdGwoc3Ry
dWN0IGZpbGUgKmZpbHAsDQogCQltdXRleF91bmxvY2soJmt2bS0+bG9jayk7DQogCQlicmVhazsN
CiAJY2FzZSBLVk1fWEVOX0hWTV9DT05GSUc6IHsNCisJCXN0cnVjdCBrdm1feGVuX2h2bV9jb25m
aWcgeGhjOw0KIAkJciA9IC1FRkFVTFQ7DQotCQlpZiAoY29weV9mcm9tX3VzZXIoJmt2bS0+YXJj
aC54ZW5faHZtX2NvbmZpZywgYXJncCwNCi0JCQkJICAgc2l6ZW9mKHN0cnVjdCBrdm1feGVuX2h2
bV9jb25maWcpKSkNCisJCWlmIChjb3B5X2Zyb21fdXNlcigmeGhjLCBhcmdwLCBzaXplb2YoeGhj
KSkpDQogCQkJZ290byBvdXQ7DQogCQlyID0gLUVJTlZBTDsNCi0JCWlmIChrdm0tPmFyY2gueGVu
X2h2bV9jb25maWcuZmxhZ3MpDQorCQlpZiAoeGhjLmZsYWdzKQ0KIAkJCWdvdG8gb3V0Ow0KKwkJ
bWVtY3B5KCZrdm0tPmFyY2gueGVuX2h2bV9jb25maWcsICZ4aGMsIHNpemVvZih4aGMpKTsNCiAJ
CXIgPSAwOw0KIAkJYnJlYWs7DQogCX0NCi0tIA0KMi4xNS4xDQo=
