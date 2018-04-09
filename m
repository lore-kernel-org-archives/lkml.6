Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237819-2-7723923318794532429
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
    1523237818; b=nKViGOwJthjUMHOFsi+fnq0puW1K65kVgoGJ0FWfCeYFQ1erMC
    ZNi8809hlRHcx2+iPMCCBgunP2srn8FBCvTmE1qUWPKyg/220KMR8KA9sPq/e8ws
    QQ/BBU5xjUudG3kqoJpmVrTZjv0B3WJypW8Uq1wSmIynElmZjLRxOoZU3FvmFefH
    G+m0NB0z3rfcr32mK11kXhHbSk25gshAvtR34OaXtOBub8K1XoOEd24GiyIaRKE8
    n0HnW3ttoCm076MpieMFRKArJnBNmTo8XbjJWcKi+8LwWkeBW6HUlDm6up0fSVSS
    +0dD1NY/fEPmYEsi9wAcF7tnJf2RFwWUg1FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523237818; bh=ukkXRJyPLyOU4LbhI0rDWzk3x8zHMAirUjgi6g/Bcyk=; b=
    VC7iGtYZZwmZHnaMYlzOi5IKKXQ0Z/J0gFABeGHzjY0X0rbhqPiXfL/kCSI+vJET
    MrfDA/vdbt7YjBkOOjmCMr0+dH/2K/+rejBn42I0iR5SGFcusVlTtIHLzjGOPwag
    lB8+9XXLVX38uhGKj0/9ujssOJ6BgTdfAn4yE+ccD3IK78Qs8LDBy32nE0Um8Np9
    k8IzvWRuMtwKep2UP0woywpGIYCmlpD0is0bWPlV2FWWd7c7sfqqVBSvjNfxZjGk
    I90W8BfSCeK7DymyBBBILmCe6gAe8nzIOkNE3YAldajeIraabTwp74aO2UVRhcr4
    KzutMOeuNzEOUDBaiS2/lw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mLkC+v3k x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mLkC+v3k x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC/wYZkutrTa4G+7Wex4+sfEydVOeQRwe2gLL+cLDulBybUr+th97iHTajIIxLqfr2PPJQxvvNCK1oXhP6AGLRWnQbbprapan50bA7BMoToyK79Rzdy/
    I9NexapuTfTWVzXAMErcbJRqyBLGrSxHNvzwuRobCbPn6IwoSTRVrGBtLbVzsUHnDpuF4t7eDhZUAhGQI3AIBMlwpyzsrC7waeT+rZe1EpfZ1FyJV8F606BZ
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8 a=cSqfOzabbhpC313mq-UA:9
    a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756645AbeDIBgp (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:36:45 -0400
Received: from mail-sn1nam02on0123.outbound.protection.outlook.com ([104.47.36.123]:10752
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755926AbeDIAfF (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:05 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: =?utf-8?B?SmFuIEjDtnBwbmVy?= <hoeppner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 020/162] s390/dasd: Display read-only
 attribute correctly
Thread-Topic: [PATCH AUTOSEL for 4.4 020/162] s390/dasd: Display read-only
 attribute correctly
Thread-Index: AQHTz5mbsOJpvgqlcEm+qQKQzCH7Sw==
Date: Mon, 9 Apr 2018 00:27:57 +0000
Message-ID: <20180409002738.163941-20-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:VCaecFQbL8kL4IUunePM+H+62rYArZtK1LrZsG+OLKOTQRgiE9kfzEY/uC2bPl6MeQh/aiPHypfrTAeN2AJt5vv746B7BwVI5F2G7DHE2Hn99074fJ5JZyIHF4bU2+XGNZcKzWSdC1FVBROvwj15yA5AzZF1xeYFa2MZoa2RZabdgQ7gzmx5Zc0WCki3h9lgO+UH8jtho5tsY82ORLANXHkvVXGXXMN2kK6N0HF4y8lrpZloVAZXVTJgq74Zsbiq;20:er3GnKJmKO8TsimESZe63w1t7aohBpJ+JAZUMi7DVzYkfuY49rlPiVrtcCr0Sceyhg1baNS4idLKNlfRvcFNmBqEMMac/zwSvPNmTurYX0jU0KM5r/Qqg5ItGCKeIxtbgBqb6PwLXlCF0Cesn/zcy9jJ44Z48IZuE9KOzQGBJKo=
X-MS-Office365-Filtering-Correlation-Id: 2699ad12-2ca4-44b4-003d-08d59db1bbca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013FD58F38D94B09422C117FBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(346002)(366004)(376002)(189003)(199004)(478600001)(10290500003)(6436002)(5250100002)(2501003)(5890100001)(14454004)(305945005)(4326008)(66066001)(99286004)(10090500001)(6506007)(36756003)(102836004)(54906003)(486006)(107886003)(76176011)(59450400001)(2900100001)(22452003)(316002)(110136005)(575784001)(86362001)(3660700001)(2906002)(81166006)(186003)(86612001)(81156014)(2616005)(8936002)(3280700002)(11346002)(53936002)(7736002)(476003)(446003)(72206003)(68736007)(6116002)(5660300001)(106356001)(6666003)(6486002)(8676002)(1076002)(105586002)(26005)(6512007)(3846002)(97736004)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: GF/A1ZdpfWf/x4gQJr7WGYm0utwxEYOXFRuHklLBxMrLWkB46O8LBOldgWIp0PrSFZ+gJtoFSRPEt+gO+IAdFTsfYs5IHHu9pOblaE82K72UHDmPzN5lcUz4lO60Npan9CiOTumCEpm7odUoH+Q2FF9W17B81CIIgOXxyAgaOjZJw65XcSqIhAyYYxzH+V8tjHE1RcyuA0d8mxEYR4lWzfsb/y44ZDwbjohW7LwHxTfqMm+QJ9pKzYiyWPulJgswLVAdoW7C0iCqudRPSXkUuWE01d+nmlIENkSIayZ7RWK7KCoGLc//rjPuVca14LhpXkezzKwGoMAss7cjNqPifjj9kg+qe8kcoZA+X1mQcdQGQvcmEN37wsCh/woeQf9VWh1CN+yLcZejBNBGxNYo10Rje9MuAc9tnx5I/qZda5E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <145E117941A48644AF2F126048E6573E@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2699ad12-2ca4-44b4-003d-08d59db1bbca
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:27:57.3485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogSmFuIEjDtnBwbmVyIDxob2VwcG5lckBsaW51eC52bmV0LmlibS5jb20+DQoNClsgVXBz
dHJlYW0gY29tbWl0IGI0ODdhOTE0Zjg1MzU0NTg0MmEwODk5MzI5YjZiNzJmZTU2YzQwODEgXQ0K
DQpXZSBoYXZlIHR3byBmbGFncywgREFTRF9GTEFHX0RFVklDRV9STyBhbmQgREFTRF9GRUFUVVJF
X1JFQURPTkxZLCB0aGF0DQp0ZWxsIHVzIHdoZXRoZXIgYSBkZXZpY2UgaXMgcmVhZC1vbmx5LiBE
QVNEX0ZMQUdfREVWSUNFX1JPIGlzIHNldCB3aGVuIGENCmRldmljZSBpcyBhdHRhY2hlZCBhcyBy
ZWFkLW9ubHkgdG8gei9WTSBhbmQgREFTRF9GRUFUVVJFX1JFQURPTkxZIGlzIHNldA0Kd2hlbiBl
aXRoZXIgdGhlIGNvcnJlc3BvbmRpbmcga2VybmVsIHBhcmFtZXRlciBpcyBjb25maWd1cmVkLCBv
ciB0aGUNCnJlYWQtb25seSBzdGF0ZSBpcyBjaGFuZ2VkIHZpYSBzeXNmcy4NClRoaXMgaXMgdmFs
dWFibGUgaW5mb3JtYXRpb24gaW4gYW55IGNhc2UuIEhvd2V2ZXIsIG9ubHkgdGhlIGZlYXR1cmUg
ZmxhZw0KaXMgYmVpbmcgY2hlY2tlZCBhdCB0aGUgbW9tZW50IHdoZW4gd2UgZGlzcGxheSB0aGUg
Y3VycmVudCBzdGF0ZS4NCg0KRml4IHRoaXMgYnkgY2hlY2tpbmcgYm90aCBmbGFncy4NCg0KUmV2
aWV3ZWQtYnk6IFN0ZWZhbiBIYWJlcmxhbmQgPHN0aEBsaW51eC52bmV0LmlibS5jb20+DQpTaWdu
ZWQtb2ZmLWJ5OiBKYW4gSMO2cHBuZXIgPGhvZXBwbmVyQGxpbnV4LnZuZXQuaWJtLmNvbT4NClNp
Z25lZC1vZmYtYnk6IE1hcnRpbiBTY2h3aWRlZnNreSA8c2Nod2lkZWZza3lAZGUuaWJtLmNvbT4N
ClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5AbWljcm9zb2Z0LmNv
bT4NCi0tLQ0KIGRyaXZlcnMvczM5MC9ibG9jay9kYXNkX2Rldm1hcC5jIHwgMTkgKysrKysrKysr
KysrKystLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zMzkwL2Jsb2NrL2Rhc2RfZGV2bWFwLmMgYi9k
cml2ZXJzL3MzOTAvYmxvY2svZGFzZF9kZXZtYXAuYw0KaW5kZXggODI4NmY3NDI0MzZiLi5mNjFh
OGUwYWU3YzggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3MzOTAvYmxvY2svZGFzZF9kZXZtYXAuYw0K
KysrIGIvZHJpdmVycy9zMzkwL2Jsb2NrL2Rhc2RfZGV2bWFwLmMNCkBAIC03NTgsMTMgKzc1OCwy
MiBAQCBzdGF0aWMgc3NpemVfdA0KIGRhc2Rfcm9fc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0
cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpDQogew0KIAlzdHJ1Y3QgZGFz
ZF9kZXZtYXAgKmRldm1hcDsNCi0JaW50IHJvX2ZsYWc7DQorCXN0cnVjdCBkYXNkX2RldmljZSAq
ZGV2aWNlOw0KKwlpbnQgcm9fZmxhZyA9IDA7DQogDQogCWRldm1hcCA9IGRhc2RfZmluZF9idXNp
ZChkZXZfbmFtZShkZXYpKTsNCi0JaWYgKCFJU19FUlIoZGV2bWFwKSkNCi0JCXJvX2ZsYWcgPSAo
ZGV2bWFwLT5mZWF0dXJlcyAmIERBU0RfRkVBVFVSRV9SRUFET05MWSkgIT0gMDsNCi0JZWxzZQ0K
LQkJcm9fZmxhZyA9IChEQVNEX0ZFQVRVUkVfREVGQVVMVCAmIERBU0RfRkVBVFVSRV9SRUFET05M
WSkgIT0gMDsNCisJaWYgKElTX0VSUihkZXZtYXApKQ0KKwkJZ290byBvdXQ7DQorDQorCXJvX2Zs
YWcgPSAhIShkZXZtYXAtPmZlYXR1cmVzICYgREFTRF9GRUFUVVJFX1JFQURPTkxZKTsNCisNCisJ
c3Bpbl9sb2NrKCZkYXNkX2Rldm1hcF9sb2NrKTsNCisJZGV2aWNlID0gZGV2bWFwLT5kZXZpY2U7
DQorCWlmIChkZXZpY2UpDQorCQlyb19mbGFnIHw9IHRlc3RfYml0KERBU0RfRkxBR19ERVZJQ0Vf
Uk8sICZkZXZpY2UtPmZsYWdzKTsNCisJc3Bpbl91bmxvY2soJmRhc2RfZGV2bWFwX2xvY2spOw0K
Kw0KK291dDoNCiAJcmV0dXJuIHNucHJpbnRmKGJ1ZiwgUEFHRV9TSVpFLCByb19mbGFnID8gIjFc
biIgOiAiMFxuIik7DQogfQ0KIA0KLS0gDQoyLjE1LjENCg==
