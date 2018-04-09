Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234982-3-6759295161639942097
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523234982; b=O/iZGcANXfNJOiQbh/iB5DJBieNMSWdE3HJj7HmOX4T3k5fuiC
    dLk+WYw2BfYemLxYbogrXTJD4imDIwElW/6QQw7InV0h1HgzWACBnMxlHvSkiYdM
    suCdKrp/CgMt2CvgbnfS5a6lt5AaDohZJG7xWFO+G6oLlFiaUDbo8S8lYKfAbQ4R
    O3GTkG3To3tO/JmhVFM7b+m17/xYnXRJs/hJs4yQcUbp5hzngS78rthWKMzRvew8
    MlLo8m7kIP8SMgD/4KnwNeYOO/xyUA/t/whwz60bq9Ht1O5pf5y4oTl2l9yOWhSj
    0DnSn0m4MaVPU6lJ2u5Zt+52twiAoRxaN6uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523234982; bh=CBfVUhuBXqkLydBPHnGIReP/POc57JMAQycQSi5gNpU=; b=
    WRJJztrIVqEszO+0doPoOVqGgwd7PNTp3+u852vD6X3tbkQhm1pfa/UvFOTbfU16
    dFVE5odnDpJS6QNDRmEQaBoRSLj4nuc1yG4mfFXb1uSr7H/XDw6YqNHeVpZAyqh5
    Q1gmGF46G5NfSKWOz5ls4IKWtP9ayYyo4+UR/PEnCcseguOA6VtwHgx7ksYXuDzw
    jIJD84lPg3bq5uk/ErrwCb9tOEopxJg4pb7+wrsc+VYrXtIq7syfkrTNBoAk3S9m
    mzU8NFcIfOBvUjZhb9gvR3TQ+oI33m0qDAAz1hUpV/xFQZHlixOdwb9nc3O9I7Hs
    1skgndIc+Ber+yiwGfhvDQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X/3J4DWo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X/3J4DWo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFltDqttul6uFLqzug8YThfBhDUP/OmPST+C3ElEpD6LQxMz3FKnFa5q1/JxIfgibKUGBgHsp+qIQlbbqUNM4G+erpXLsSFxH3L8Mt0kIzXehOQbrM0v
    SI/unjmj/t3LXd2Qv/aSZSQsXCQaV3dOYrEGPfXVsNHnuXD7Uk0xwGGOMs4ZJYwLkqz4zqjNmZZpZwq1eyteheS34ZM8kMKTRp0c/F+B8zDsmxGI+OPM+LZ5
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=XkRKQH6RAAAA:8 a=cm27Pg_UAAAA:8
    a=yMhMjlubAAAA:8 a=7TMZ7IPSw7-ybUbJCQsA:9 a=QEXdDO2ut3YA:10
    a=1gUyE30hU_ULiMxJiLUW:22 a=xmb-EsYY8bH0VWELuYED:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933437AbeDIAlf (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:41:35 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:24363
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933430AbeDIAld (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:41:33 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>,
        "kernel-hardening@lists.openwall.com"
        <kernel-hardening@lists.openwall.com>,
        Kees Cook <keescook@chromium.org>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 066/101] kvm: x86: fix KVM_XEN_HVM_CONFIG
 ioctl
Thread-Topic: [PATCH AUTOSEL for 3.18 066/101] kvm: x86: fix
 KVM_XEN_HVM_CONFIG ioctl
Thread-Index: AQHTz5t/wQ15JJmn9UmyphWgsSA0+g==
Date: Mon, 9 Apr 2018 00:41:28 +0000
Message-ID: <20180409004042.164920-16-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:Ofr1RQczws9Eid900EOQ2moxs1rDNQFP/wlPh4V2qVIUlr8Joun/lg6y4m9Npctomz5ASVr0GT0DEGaS3V6uw/UlegGjg8bTjhxzB0wGF9+mcl1WKxxhRCGOgiLaq6d72xNLqqxIksF/yr4pCnKEx++Sd1RNSzZrAQ0Jmm2xs0uXzccXePe7XtAe1HYTtl4tgfR0nACiYUBCuAJHR3wTJJzriQHMHdWrVl07pB7zwcpvGGd5Wm4322awKwXvcoKo;20:yzVFQArnLtBqPVKHCAIckWvmdYasOwFs5My6dFQ8+ERepzrPryNYpkU68PHUoSRlfa298kJBY1KmbcEtxJtIZuOVxW5heq+gffamPYBpQZBT2YclThBNrFdSRCtu5pcnefo9tPB/O3uh2iXSViL5ShHJKVZHKF/b/CsVQHVUcv0=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9d041c08-9fe6-4d0e-70af-08d59db2a1f2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0901516A87CC5246DB96271DFBBF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(99286004)(68736007)(10290500003)(25786009)(86612001)(6116002)(66066001)(97736004)(3846002)(76176011)(6512007)(54906003)(6436002)(4326008)(53936002)(105586002)(110136005)(6486002)(3280700002)(1076002)(107886003)(8676002)(10090500001)(2501003)(81156014)(81166006)(5660300001)(14454004)(186003)(3660700001)(102836004)(7736002)(2906002)(26005)(5250100002)(36756003)(478600001)(446003)(316002)(6506007)(2616005)(106356001)(8936002)(11346002)(575784001)(22452003)(2900100001)(86362001)(486006)(476003)(305945005)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 9UddJGTitEqP+TpEvfL+4t7E4hx0CnvPewGW0DLkiHIdFPmeuR8gSg8ztYlyetc5M6CTW8IZe+9+wgmnfnMftlIcGlIpxmblSsoRY1g5JMQDuS7Pc0iM9AdIxS31iixs9n0wKIhgrOWWjpqlJ4Z1Hpt/8JiIZT7/QzRrG3njWCwB+AYIE1LEpSXq/wobA/VMcZ9sK8t/ylX7J5eC38KTFuLLQ8Ch71kwM5dIYfLS3lTS7WnNY4tXcomnpArpUsKFXJ3sX+W70xyQ1dZI2aj0hegrE5e6+E5IyrStRTuvg+zkiF+Qo3NGNhAfdpaoAAXG24z/bnXLxMvgZ1ahaE/L6KA3XDhPA02SASe22VOWamAmlnhxb7bJV7M3/2woFvxifjA8/oKr7MYHHMd0qd0kdG3LjXZy+Yn9KnmZrl3yugA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8E6478831FCA84A9A911B19530CF65B@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d041c08-9fe6-4d0e-70af-08d59db2a1f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:28.2834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
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
eDg2LmMgYi9hcmNoL3g4Ni9rdm0veDg2LmMNCmluZGV4IGYwNmZkMjAxODY1MS4uNGRlMjM5Nzlk
MGZmIDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva3ZtL3g4Ni5jDQorKysgYi9hcmNoL3g4Ni9rdm0v
eDg2LmMNCkBAIC00MDI1LDEzICs0MDI1LDE0IEBAIGxvbmcga3ZtX2FyY2hfdm1faW9jdGwoc3Ry
dWN0IGZpbGUgKmZpbHAsDQogCQlicmVhazsNCiAJfQ0KIAljYXNlIEtWTV9YRU5fSFZNX0NPTkZJ
Rzogew0KKwkJc3RydWN0IGt2bV94ZW5faHZtX2NvbmZpZyB4aGM7DQogCQlyID0gLUVGQVVMVDsN
Ci0JCWlmIChjb3B5X2Zyb21fdXNlcigma3ZtLT5hcmNoLnhlbl9odm1fY29uZmlnLCBhcmdwLA0K
LQkJCQkgICBzaXplb2Yoc3RydWN0IGt2bV94ZW5faHZtX2NvbmZpZykpKQ0KKwkJaWYgKGNvcHlf
ZnJvbV91c2VyKCZ4aGMsIGFyZ3AsIHNpemVvZih4aGMpKSkNCiAJCQlnb3RvIG91dDsNCiAJCXIg
PSAtRUlOVkFMOw0KLQkJaWYgKGt2bS0+YXJjaC54ZW5faHZtX2NvbmZpZy5mbGFncykNCisJCWlm
ICh4aGMuZmxhZ3MpDQogCQkJZ290byBvdXQ7DQorCQltZW1jcHkoJmt2bS0+YXJjaC54ZW5faHZt
X2NvbmZpZywgJnhoYywgc2l6ZW9mKHhoYykpOw0KIAkJciA9IDA7DQogCQlicmVhazsNCiAJfQ0K
LS0gDQoyLjE1LjENCg==
