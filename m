Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523235670-2-7450737089407527252
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
    1523235670; b=gYdfepBbGdjdUmTxykSxLXS9LBxmZ1/dd9yADRY0g3Y5pdx8aH
    CfNDUXZNuUmi09B8NIRTEzIgtd/sQl4YWd0xGe4H2FfSLESZLdLkrrsdpVK7qEKq
    yxnDrVXZdiuTO9JMfBYoENuWFapPr5JeP6zbNjfN7/EtTL9JPgi1wZ42psEY2VxW
    qMHsQ45zitqdrvPuFhh2Esi95iX/HzqSA6cpyPb9fABx4Xpr4IA0bpXbSp+I4mGy
    L33D5g2O6wdfuQjDptkbsCbdNQv2HQbf6l26ewmqcxdpi8BEmf5QMgKU+p6H48Dc
    R4WgU/Wt2HE5dFu4lfPrRAEoOUC34/VGKSsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523235670; bh=ukkXRJyPLyOU4LbhI0rDWzk3x8zHMAirUjgi6g/Bcyk=; b=
    mY1WC7iezEmdwT7tXIuuJDnjPew8wdZiDewUH9CpwlmrrgoOVKst/S5C2tx+KJRX
    a0L9OJ/8L318BIx6+NQgQI+6u5KBCGTbJYnG5RBN0m20fQE8IRAEla4IrGxYVGR0
    EHmr5luWfdQPhnwiKp/tMvZ+E8A0ZI/crVVi3XwzJmeM6tqxviNjw91wIUFldpEg
    wCMfzNuxuRAGAMdB+uQ7Z80LWIL2MwRzGRDyc9H9T/09CnwBWo5RR4rGEKShi65+
    dF3gLlk+UTfufFUtg3V7yDwEBRvoFP79flJErvTxMOW8YLDG+xoCjQOgoJaDTjl5
    eXDcmAy9w5ytFkqAF+am3g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eiDno0HM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eiDno0HM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPmdi7cawzvf7ZE3J+MTZf5qyNjHCnghmdt9p6KNbboze1kOOoGcEd8WT/kB4Q6h+ur2i1Hkr9kT6DmkHtRJV9+IhHE3SIXbe6dKaP1lDbx+YJByHCnS
    q7+TBgnkKJYzwSJVK5M/z5gJKdWWbQeCj5IPjdtgPAyuMyL3thVnLW1U/QrCfHCaorMHstrlbq0Bi84IAhq3dn8Ne55HyiatlzjpiuGmAZ7EGFTpDAD2sMgm
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8 a=cSqfOzabbhpC313mq-UA:9
    a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933298AbeDIBAy (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:00:54 -0400
Received: from mail-co1nam03on0103.outbound.protection.outlook.com ([104.47.40.103]:45124
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933177AbeDIAjk (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:40 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: =?utf-8?B?SmFuIEjDtnBwbmVy?= <hoeppner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 017/101] s390/dasd: Display read-only
 attribute correctly
Thread-Topic: [PATCH AUTOSEL for 3.18 017/101] s390/dasd: Display read-only
 attribute correctly
Thread-Index: AQHTz5qlnGl6lOBfBkyfBD5Uur3j1w==
Date: Mon, 9 Apr 2018 00:35:23 +0000
Message-ID: <20180409003505.164715-17-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1047;7:dtHmQy6TD2RN5EosoxJhUxRIZ/euJJmkbDp+8u5V1WHkzYqvblBwo7zlLjigyUZaB1fKMGB/8MH60ptZMl5IqEC+un9FF6XsPkJ44vXRVVLcYjn+w5sdJPz7fw2PSB3xNzVvJI1ah4UvJiHsDlM4Z4te+fhk+MDYEvt1BwKURyyndnr1+cziE1uyKliL7OuR/xNA9AoMU2rqQOXe4rhXz5+jqw7ojks0N/3jFLgfKBMF+YPMgehjcTEiCIumE/xg;20:tjz4D9YtifeJ+5E41DBCHAQreUB4g9a30PQQoD+z5MEN1od+tPgLU4RFsyxGNG+BOkU5ts7OXMQSx1UGlDzZxm6PeDjQhC+FFxJRP1qkbfe22R4xxK/Zg+9yxOn57U2jhhRIJ/3IaKJ1uCBMV30MMai0kBStUaNMQHWU+wM1RbI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 05f5cbcc-0ea7-4342-cc7b-08d59db25ece
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1047;
x-ms-traffictypediagnostic: DM5PR2101MB1047:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1047B2E53A09F0331CE391CAFBBF0@DM5PR2101MB1047.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1047;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1047;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(39380400002)(189003)(199004)(97736004)(3660700001)(2900100001)(2906002)(8936002)(11346002)(3280700002)(106356001)(446003)(68736007)(72206003)(1076002)(86612001)(25786009)(3846002)(36756003)(107886003)(6116002)(81166006)(4326008)(486006)(81156014)(6512007)(6436002)(53936002)(14454004)(8676002)(26005)(575784001)(5250100002)(86362001)(105586002)(6666003)(305945005)(186003)(10290500003)(7736002)(10090500001)(102836004)(6486002)(2616005)(5660300001)(316002)(2501003)(66066001)(5890100001)(22452003)(54906003)(99286004)(110136005)(478600001)(59450400001)(476003)(76176011)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1047;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Qn3/u7fe7wH+dxfHvm23Ek6+Xgn72TRUtzNDSG9ZrbOXVEnUqSe/FMARaiPBB2DhXc6aVJmfbsVUq1AAe/oKr9TzzhmXiENvXQ55yG+lV6tsVi4qZj7OqogPsdnAet1JLq8eJBhk8kp+pgNksITlbjmWWMv+T57XDoS/kuBFJ717g+CtPXmGpDGrQFUWVej4MCSkG5A2RbGxiKKHvTkbUKl4MIJn0NpkDQJFPeIFhNQQWWGBO73uPTjB3OFtRsMcqvxPWsFjnpF6mQ3/eUc3tOqybwCsZfryZWlmETbrm+fvv8RlNnOyJqyDC86O17WHUE78qZeMY0FBXC5+3Rmh/VIVV+3F/lFwuLmvoL8dDbP3YaytRPobDBpPN1Vd1kL7wcGFIf36GIM2GDpUd3psrkgIbBzx3m2FIPt2N4BPRng=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7725AC8BB78A8145A1FC7FAE8995D2D5@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f5cbcc-0ea7-4342-cc7b-08d59db25ece
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:23.6579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1047
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
