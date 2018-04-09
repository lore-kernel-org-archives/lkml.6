Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239083-2-8028947390652278853
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
    1523239083; b=EGx7veRU6R9Q9hI9zjcNa9X5MkFbKcIfB4RzZ2PUa50xdS2x4h
    WvNnacEaaB9dQTUS3wTXpVIaGd4SyP6Ed6474taxTRmE7D7KhXf3x3BS0bOVkfNW
    h6VNOArn25OZAGBx0IZcNs+b/kXKDOXSovdVFuJ0o/veax0e/Nfm8t8cpAcleXlt
    QMC1IxgrNhf7D3RkH5ofkW10FtxbV8iwuKTv/ZqrPRIakJzSNXxuju2CeS6IWf69
    NqfZW6To2XmiMGAXd0n+NR+AKmyGdGxPRm5xRTb4n9i5g1eySlXaO0eGWY1mwwNj
    6oe0n8MQzh/LdV+qKMo7wDmzUcdbkDwyCnPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523239083; bh=m19RtP4K9mzNhiGu7fmdBRGsAMIhCTbOl6/n+rhR3aM=; b=
    M8w6o4uP+QStT6KmPxS5rTeGGHFsiSZahOwHnSMjnyo4MUjQiQPRHl7NaDiejWAW
    +TPAtsvIakhCZKA984sqnZ8R2dWjDRULdMsYd02p1pP2p/nRNopjzLhJYlKyOT69
    a613QMRubU53rMsCe67TnR9eWaYIwbNnhwPrEuC2VqaePob79mI0mpQei2Y9DrEH
    QGZtYDZRkI6OgDFFtjs0XKw/eDyTywBrpD0MTGehKcrEbOAzEe/qCz4qlCKF9+1C
    6n8NuxP+HxAW25a+dH6GQy41Eb1xJsBfIGwNsqgabYGEMThRPhTZCnD/tG2npStp
    UZXDxRx+3/hfbOJNGT9FHw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WeBHn7gS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WeBHn7gS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIMrXzy/s5G6mBioX8yjaXbJ43OpjuNlf9zb49qIo8i8gE25ghl/dWMCw9eXsCWN6+gl2rAAsDBLS0SObG4oZ9Pne53hxasoNWLljH7uItjHkIApgvWU
    yEjpEK7+8zT+y5PdTck258Vvp97Kwv3I9qlRxND/5bUKsaeoKGiYhOqSNUmk6WBubRIFfW5UaWkOMfy6sMnQGHsjHbR5Zd7HFAr5CoLEQfJuj/vztHoLmVCx
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=XkRKQH6RAAAA:8 a=cm27Pg_UAAAA:8
    a=yMhMjlubAAAA:8 a=7TMZ7IPSw7-ybUbJCQsA:9 a=QEXdDO2ut3YA:10
    a=1gUyE30hU_ULiMxJiLUW:22 a=xmb-EsYY8bH0VWELuYED:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757240AbeDIB6A (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:58:00 -0400
Received: from mail-by2nam01on0124.outbound.protection.outlook.com ([104.47.34.124]:8059
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755618AbeDIAcu (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>,
        "kernel-hardening@lists.openwall.com"
        <kernel-hardening@lists.openwall.com>,
        Kees Cook <keescook@chromium.org>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 215/293] kvm: x86: fix KVM_XEN_HVM_CONFIG
 ioctl
Thread-Topic: [PATCH AUTOSEL for 4.9 215/293] kvm: x86: fix KVM_XEN_HVM_CONFIG
 ioctl
Thread-Index: AQHTz5lL7lbkSmQk5062M9BXOwIO/w==
Date: Mon, 9 Apr 2018 00:25:42 +0000
Message-ID: <20180409002239.163177-215-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:2dWjdTArCSHDdyY4zVQ0v4WEI1dlZ3TNqPyMRSSCY1dw/Ta0hB710soNLG6ZS7QlQk6x9vdcMaFlNYK2eVDSjlaViOmF+a8Gk1j+eYVw2fdzdrioiIcC1ESJwVLpZc2LQQGneLmFz2DOnl5WfpT1vAJtECQlfTKch7avE6XChjun48X+md+eeLjlj/kTZnbSbGqWPrt9zrEe44xzqRu3DN7EyEyGzS1iXDVw7e+HcPpy7BXRVhHX5m7mhP7fzOMP;20:UR8uIZ1qjg24mNnqcMyEe7w5VuS+pqUOmo2L4yF9SyDJBYpqSgV7mi81x5t2NxWWWyhuZKiXUA/xFX/lsyoRd5kZkW/wXC6pq4cH/oXXzjZeB4VhV+A7CM8j4Z7LRV0LikU2IikBfom8aGeZ5rFIHwTmM5I7Y1gFJslHZxZGqr8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: e97b7518-358b-4c92-e299-08d59db16bb2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0998C50FDE1133680440F6A7FBBF0@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(376002)(396003)(366004)(39860400002)(189003)(199004)(25786009)(59450400001)(105586002)(14454004)(76176011)(68736007)(2906002)(316002)(97736004)(8676002)(86612001)(3660700001)(3280700002)(102836004)(6116002)(4326008)(8936002)(36756003)(22452003)(81166006)(81156014)(54906003)(6506007)(10090500001)(2501003)(6512007)(186003)(6666003)(3846002)(486006)(5660300001)(26005)(7736002)(5250100002)(305945005)(99286004)(2900100001)(110136005)(1076002)(6436002)(53936002)(106356001)(107886003)(72206003)(86362001)(476003)(446003)(66066001)(11346002)(478600001)(10290500003)(2616005)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0998;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: B/x9Va+goUNIjvAiL8gmgtfywVx1HkDcqzuWK30aPtt3Jp7WC7SvSqq/TR7oSxV2cKzwbt2tCFLaGVMS6iXEdlNF85Wc5ev7ILWYDVlJePX5xCVIecVPG6yW3LFzGOTG93kD/W7+5Al9cHNx4qK60pKbwS60kLvwTxK+M5r6F0Nm4fpzcH6a+HcmexpcZfaBHPAb1prBr74KmOh+Z+m40W/iOnqQ5trlGA8zGphxliBVJ+z33nk4SHsV3KgOZzlR4vVb1UgOSVlB1l77f2ckDFO+Z1AthotgM+BQYc72jHPkVq/3MiU9yIzW2Zk48QkP4YpyxkCga6ifJYytX3jTmjajU/yK96pgk/OkAdlDls6QW0s4xMzFXEf6hPQcpEkHdR8X10lYc5+pK29LRyWaxA0xFKJT9N6i3BVNKgJCcZI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3EAB4D8B66A8E40A570FD7EFF65CA5E@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e97b7518-358b-4c92-e299-08d59db16bb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:42.2066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0998
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
eDg2LmMgYi9hcmNoL3g4Ni9rdm0veDg2LmMNCmluZGV4IDNhYWFmMzA1NDIwZC4uODAzYmI0NTJh
YWM2IDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva3ZtL3g4Ni5jDQorKysgYi9hcmNoL3g4Ni9rdm0v
eDg2LmMNCkBAIC00MTMwLDEzICs0MTMwLDE0IEBAIGxvbmcga3ZtX2FyY2hfdm1faW9jdGwoc3Ry
dWN0IGZpbGUgKmZpbHAsDQogCQltdXRleF91bmxvY2soJmt2bS0+bG9jayk7DQogCQlicmVhazsN
CiAJY2FzZSBLVk1fWEVOX0hWTV9DT05GSUc6IHsNCisJCXN0cnVjdCBrdm1feGVuX2h2bV9jb25m
aWcgeGhjOw0KIAkJciA9IC1FRkFVTFQ7DQotCQlpZiAoY29weV9mcm9tX3VzZXIoJmt2bS0+YXJj
aC54ZW5faHZtX2NvbmZpZywgYXJncCwNCi0JCQkJICAgc2l6ZW9mKHN0cnVjdCBrdm1feGVuX2h2
bV9jb25maWcpKSkNCisJCWlmIChjb3B5X2Zyb21fdXNlcigmeGhjLCBhcmdwLCBzaXplb2YoeGhj
KSkpDQogCQkJZ290byBvdXQ7DQogCQlyID0gLUVJTlZBTDsNCi0JCWlmIChrdm0tPmFyY2gueGVu
X2h2bV9jb25maWcuZmxhZ3MpDQorCQlpZiAoeGhjLmZsYWdzKQ0KIAkJCWdvdG8gb3V0Ow0KKwkJ
bWVtY3B5KCZrdm0tPmFyY2gueGVuX2h2bV9jb25maWcsICZ4aGMsIHNpemVvZih4aGMpKTsNCiAJ
CXIgPSAwOw0KIAkJYnJlYWs7DQogCX0NCi0tIA0KMi4xNS4xDQo=
