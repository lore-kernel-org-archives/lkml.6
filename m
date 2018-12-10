Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8D3C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A642081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VyJ32+Ka";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ApUsNP4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A642081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbeLJWkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:40:20 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41336 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727405AbeLJWkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:40:20 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBAMbiN9024904;
        Mon, 10 Dec 2018 14:39:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=uX/Qmb3CpZIDEVR3blfyWxqckonZ/CB4GxWKeSLXO3c=;
 b=VyJ32+Kao8QZ7N8vfz80LkIUL7uL65gEKcrJjfNf/K71wvjelM0dP9e50gGwx7G9CO11
 6Nkkv3EsxFv2jw42GfYnLouN70UWCxNDKEk5xIIyAg9iHXe0EUA3u1T+eDE8bjmHpvqr
 zTPzwPIa5qWu+6gioDabEcg3mYmA0ThUJhM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pa11t80mv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 10 Dec 2018 14:39:53 -0800
Received: from frc-mbx03.TheFacebook.com (2620:10d:c0a1:f82::27) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 10 Dec 2018 14:39:52 -0800
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-mbx03.TheFacebook.com (2620:10d:c0a1:f82::27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 10 Dec 2018 14:39:51 -0800
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 10 Dec 2018 14:39:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uX/Qmb3CpZIDEVR3blfyWxqckonZ/CB4GxWKeSLXO3c=;
 b=ApUsNP4g9zlTNHddDWtSUjKe19OFB5I+Bwh3VPXd/en2IPirjoV7vWHhxoFMlWd3OA1roGFzy3KnfsAs7hvyNPQV60aDAXdhBWad+12bXFqZbR4/WtSJ0thxvJjlf+LAsirvWOyniN8JpmxU+vFlSkddcp4DCoOGIFDxbP7Ht84=
Received: from BN6PR15MB1265.namprd15.prod.outlook.com (10.172.206.15) by
 BN6PR15MB1859.namprd15.prod.outlook.com (10.174.239.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Mon, 10 Dec 2018 22:39:50 +0000
Received: from BN6PR15MB1265.namprd15.prod.outlook.com
 ([fe80::88d6:6e49:6abf:47e0]) by BN6PR15MB1265.namprd15.prod.outlook.com
 ([fe80::88d6:6e49:6abf:47e0%7]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 22:39:50 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH] ARM: dts: aspeed: Add KCS support for LPC BMC
Thread-Topic: [PATCH] ARM: dts: aspeed: Add KCS support for LPC BMC
Thread-Index: AQHUkMQe94oM5xm5Q0Ws+1qTnQnG1qV4CuSA
Date:   Mon, 10 Dec 2018 22:39:50 +0000
Message-ID: <6061E60A-78CD-4C4C-A35C-0AD90BFC4286@fb.com>
References: <20181210200753.3018124-1-vijaykhemka@fb.com>
 <20181210200753.3018124-2-vijaykhemka@fb.com>
In-Reply-To: <20181210200753.3018124-2-vijaykhemka@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::6:be14]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR15MB1859;20:TNaJLJQqtUK7WowA7KA/5dODk4/0o8ZuRkDIKpVbNfgfz674bnU4QPBeHvTwG/me8wUtVB+TLLgQULa5LWJwzSlrVP/MHXaC069IjC1FpmFVFjWyzflI4+BqW7/QSihj3MX8+b69bnPZEAx0M6ur/BLntZ8VXjAK9D5Ihxhxirk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c52bae92-54d5-4bf2-d32c-08d65ef06565
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR15MB1859;
x-ms-traffictypediagnostic: BN6PR15MB1859:
x-microsoft-antispam-prvs: <BN6PR15MB1859B265EC7A404441FD933FDDA50@BN6PR15MB1859.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(11241501185)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231472)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BN6PR15MB1859;BCL:0;PCL:0;RULEID:;SRVR:BN6PR15MB1859;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(136003)(376002)(39860400002)(199004)(189003)(575784001)(7736002)(53936002)(86362001)(2201001)(6246003)(68736007)(82746002)(4326008)(305945005)(11346002)(476003)(229853002)(486006)(8936002)(6116002)(446003)(2906002)(2616005)(14454004)(81166006)(8676002)(81156014)(6436002)(6486002)(106356001)(6506007)(99286004)(105586002)(25786009)(46003)(36756003)(186003)(76176011)(97736004)(102836004)(6512007)(14444005)(256004)(71190400001)(83716004)(71200400001)(2501003)(33656002)(316002)(110136005)(478600001)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR15MB1859;H:BN6PR15MB1265.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: K11XpAk+mm7n7WEjb2Via9uqo9Ex//Eq8ndet6Ljh6FmdJ9HHXUmiNB5+il6AHsyFT8FVjfvuZ21OjEU3mytoyduBM1p3sH44Ma7x9e6IgeyyORgDRUBIUF/9ZvpLN3Roj8if5WiyArauPto44Vo49U7jtZNCK/N2T5p5nYEyvSIcWvtyWizxTfZgmYVGGTOp6olFuxiMsyJVCB1SBnan6Vzi/Box8n/BmsDxVbtJJNZvD46GEYqZt1CBH/R4K57euoLS+3rJ892hwjydl9qOvOTHD7Xj7FP0fX6YfE344VSSkQN5cyJnfh3bzmMoImo
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F4591F69C67AF44A489EAB211C247F5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c52bae92-54d5-4bf2-d32c-08d65ef06565
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 22:39:50.4296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1859
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-10_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGxlYXNlIGlnbm9yZSB0aGlzIHBhdGNoIGFzIGl0IGlzIGR1cGxpY2F0ZS4gSXQgaXMgaW5jbHVk
ZWQgaW4gbGlzdCBvZiAyIHBhdGNoZXMgSSBoYXZlIHNlbnQganVzdCBiZWZvcmUuDQoNCu+7v09u
IDEyLzEwLzE4LCAxMjowOCBQTSwgIlZpamF5IEtoZW1rYSIgPHZpamF5a2hlbWthQGZiLmNvbT4g
d3JvdGU6DQoNCiAgICBBZGRlZCBrY3MgZGV2aWNlIHN1cHBvcnQgZm9yIGxwYyBCTUMuDQogICAg
DQogICAgU2lnbmVkLW9mZi1ieTogVmlqYXkgS2hlbWthIDx2aWpheWtoZW1rYUBmYi5jb20+DQog
ICAgLS0tDQogICAgIGFyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1nNS5kdHNpIHwgMjkgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0NCiAgICAgMSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCiAgICANCiAgICBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9v
dC9kdHMvYXNwZWVkLWc1LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQtZzUuZHRzaQ0K
ICAgIGluZGV4IGQxMDc0NTlmYzBmOC4uMWJkNDg2NTViYWNiIDEwMDY0NA0KICAgIC0tLSBhL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1nNS5kdHNpDQogICAgKysrIGIvYXJjaC9hcm0vYm9vdC9k
dHMvYXNwZWVkLWc1LmR0c2kNCiAgICBAQCAtMzMwLDggKzMzMCwzNSBAQA0KICAgICAJCQkJcmFu
Z2VzID0gPDB4MCAweDFlNzg5MDAwIDB4MTAwMD47DQogICAgIA0KICAgICAJCQkJbHBjX2JtYzog
bHBjLWJtY0AwIHsNCiAgICAtCQkJCQljb21wYXRpYmxlID0gImFzcGVlZCxhc3QyNTAwLWxwYy1i
bWMiOw0KICAgICsJCQkJCWNvbXBhdGlibGUgPSAiYXNwZWVkLGFzdDI1MDAtbHBjLWJtYywgInNp
bXBsZS1tZmQiLCAic3lzY29uIiI7DQogICAgIAkJCQkJcmVnID0gPDB4MCAweDgwPjsNCiAgICAr
CQkJCQlyZWctaW8td2lkdGggPSA8ND47DQogICAgKw0KICAgICsJCQkJCSNhZGRyZXNzLWNlbGxz
ID0gPDE+Ow0KICAgICsJCQkJCSNzaXplLWNlbGxzID0gPDE+Ow0KICAgICsJCQkJCXJhbmdlcyA9
IDwweDAgMHgwIDB4ODA+Ow0KICAgICsNCiAgICArCQkJCQlrY3MxOiBrY3MxQDAgew0KICAgICsJ
CQkJCQljb21wYXRpYmxlID0gImFzcGVlZCxhc3QyNTAwLWtjcy1ibWMiOw0KICAgICsJCQkJCQly
ZWcgPSA8MHgwIDB4ODA+Ow0KICAgICsJCQkJCQlpbnRlcnJ1cHRzID0gPDg+Ow0KICAgICsJCQkJ
CQlrY3NfY2hhbiA9IDwxPjsNCiAgICArCQkJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAgICAr
CQkJCQl9Ow0KICAgICsJCQkJCWtjczI6IGtjczJAMCB7DQogICAgKwkJCQkJCWNvbXBhdGlibGUg
PSAiYXNwZWVkLGFzdDI1MDAta2NzLWJtYyI7DQogICAgKwkJCQkJCXJlZyA9IDwweDAgMHg4MD47
DQogICAgKwkJCQkJCWludGVycnVwdHMgPSA8OD47DQogICAgKwkJCQkJCWtjc19jaGFuID0gPDI+
Ow0KICAgICsJCQkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KICAgICsJCQkJCX07DQogICAgKwkJ
CQkJa2NzMzoga2NzM0AwIHsNCiAgICArCQkJCQkJY29tcGF0aWJsZSA9ICJhc3BlZWQsYXN0MjUw
MC1rY3MtYm1jIjsNCiAgICArCQkJCQkJcmVnID0gPDB4MCAweDgwPjsNCiAgICArCQkJCQkJaW50
ZXJydXB0cyA9IDw4PjsNCiAgICArCQkJCQkJa2NzX2NoYW4gPSA8Mz47DQogICAgKwkJCQkJCXN0
YXR1cyA9ICJkaXNhYmxlZCI7DQogICAgKwkJCQkJfTsNCiAgICAgCQkJCX07DQogICAgIA0KICAg
ICAJCQkJbHBjX2hvc3Q6IGxwYy1ob3N0QDgwIHsNCiAgICAtLSANCiAgICAyLjE3LjENCiAgICAN
CiAgICANCg0K
