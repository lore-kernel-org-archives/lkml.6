Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E653C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99432184B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lout7cyh";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Ff+l7y9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388428AbeLQTkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:40:52 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41592 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388381AbeLQTku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 14:40:50 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBHJWZaw021602;
        Mon, 17 Dec 2018 11:39:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=YGVLgBKVMfa0cLaHPR29atGsHKOjdwB0Bak1p8lLQeo=;
 b=lout7cyhcaaa9MWzh5JeX8voiGn/QZWFRxd4CIT8wni5f4zo3n0TUKvLOIMSS5ewlaqy
 93exmix9F/y8bYuSTG1H8QdBp4hKHhZIq3dvc/ALbXfLS1riytCxxTwHvrlYKBcUu1rD
 hekA8Z5vVBRb+wU6StT1McjS/uTBDQSh/Oo= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pegwurcb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 17 Dec 2018 11:39:51 -0800
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 17 Dec 2018 11:39:50 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 17 Dec 2018 11:39:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGVLgBKVMfa0cLaHPR29atGsHKOjdwB0Bak1p8lLQeo=;
 b=Ff+l7y9jxEtxxrxAkJX5NFgIwq8XlvHix6/5W3LYgfzJL0PYavq/JkxoHuFY2ryXqFcbMp6VGOSw3h0zgMXr9407AswmwKDY4nbubUhLl86dWzNZqaI1mrfYCcnWdvS26fraTuxIZW8vSrPXAW//JCBlgIjZHBNVSjmepXQWp6w=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.180.139) by
 CY4PR15MB1880.namprd15.prod.outlook.com (10.174.54.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Mon, 17 Dec 2018 19:39:39 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::1bd:fa86:857:9b04]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::1bd:fa86:857:9b04%10]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 19:39:39 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        "james.feist@linux.intel.com" <james.feist@linux.intel.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [Potential Spoof] Re: [PATCH 1/4] ARM: dts: aspeed: Add sensors
 devices for Facebook
Thread-Topic: [Potential Spoof] Re: [PATCH 1/4] ARM: dts: aspeed: Add sensors
 devices for Facebook
Thread-Index: AQHUlkA/KCVlBQPXcUeYtA4qGz6DaA==
Date:   Mon, 17 Dec 2018 19:39:38 +0000
Message-ID: <E3F1FFD7-1C5A-43DE-BCA6-5B50EEEF577F@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: james.feist@linux.intel.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::7:ddd7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1880;20:jgsyN3QB01wkPAUlCqGCiRozm/O/JcLTTcNbh7zyyTL4/S0NKaN+8NpADXbvCVKiNnX2p+5NUAu8qa9Iz0HSxMMcRVR9rqS4qEnU8GYb7BnAVVpePUxCCMe/jW8B6FEjx+OX+Kh+Dojs8kczj2HLdrrNsJ4k2hiYLFXEmWHv5OE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2366a18e-8370-44a7-db14-08d664576234
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1880;
x-ms-traffictypediagnostic: CY4PR15MB1880:
x-microsoft-antispam-prvs: <CY4PR15MB1880E34EB1C41B0DA2ADDC44DDBC0@CY4PR15MB1880.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(11241501185)(6040522)(2401047)(8121501046)(5005006)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:CY4PR15MB1880;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1880;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(366004)(396003)(376002)(47680400002)(199004)(189003)(256004)(2501003)(229853002)(6486002)(316002)(25786009)(68736007)(486006)(81156014)(8676002)(81166006)(110136005)(7736002)(33656002)(14454004)(478600001)(305945005)(36756003)(99286004)(46003)(2616005)(6116002)(71190400001)(71200400001)(6506007)(5660300001)(105586002)(54906003)(4326008)(476003)(97736004)(102836004)(106356001)(186003)(82746002)(6436002)(86362001)(2906002)(8936002)(6512007)(53936002)(7416002)(53546011)(83716004)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1880;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6tX18/sac+DF/YCjpdrcdzslubYAS0OEuH0mfHJsTFTpu7fzYjD6Ws90vh/jG1pLyyeQaOOz5ht0PJZVclLUp63fNk0X42zkwIfgQn4Qa8Oc/6vovZImBOn3FaGNg8RR2/HF6qFrppFja2aHWmiQ8WLw0THMnfsoODjNexBiV+BtqUZwiQ2AS1cVelXEL2bFPEI4lwJdbg5ICgF0V4I1Lu/VXnFfoszuummeWMJVl0iVL36ikUaTQk6xhLYAeS6cKvRPHEa5SgiBxA0NnWQGw7OGpos554UU+NgEr2Hc6mMP+EdFJis27l/evgi8M2Hg
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D97B750DD6988141A49B7AB571ABA425@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2366a18e-8370-44a7-db14-08d664576234
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 19:39:39.0195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1880
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-17_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDEyLzE0LzE4LCAxMjo0MiBQTSwgIkxpbnV4LWFzcGVlZCBvbiBiZWhhbGYgb2Yg
VmlqYXkgS2hlbWthIiA8bGludXgtYXNwZWVkLWJvdW5jZXMrdmlqYXlraGVta2E9ZmIuY29tQGxp
c3RzLm96bGFicy5vcmcgb24gYmVoYWxmIG9mIHZpamF5a2hlbWthQGZiLmNvbT4gd3JvdGU6DQoN
CiAgICANCiAgICANCiAgICBPbiAxMi8xNC8xOCwgMTE6MjIgQU0sICJvcGVuYm1jIG9uIGJlaGFs
ZiBvZiBKYWUgSHl1biBZb28iIDxvcGVuYm1jLWJvdW5jZXMrdmlqYXlraGVta2E9ZmIuY29tQGxp
c3RzLm96bGFicy5vcmcgb24gYmVoYWxmIG9mIGphZS5oeXVuLnlvb0BsaW51eC5pbnRlbC5jb20+
IHdyb3RlOg0KICAgIA0KICAgICAgICBIaSBWaWpheSwNCiAgICAgICAgDQogICAgICAgIE9uIDEy
LzE0LzIwMTggMTA6MTEgQU0sIFZpamF5IEtoZW1rYSB3cm90ZToNCiAgICAgICAgPiBPbiAxMi8x
My8xOCwgMjo1NiBQTSwgIkpvZWwgU3RhbmxleSIgPGpvZWxAam1zLmlkLmF1PiB3cm90ZToNCiAg
ICAgICAgDQogICAgICAgIDxzbmlwPg0KICAgICAgICANCiAgICAgICAgPiAgICAgID4gKyAgICAg
ICAgICAgICAgIG9lbW5hbWUwID0gIk1CX1AzVjMiOw0KICAgICAgICA+ICAgICAgPiArICAgICAg
ICAgICAgICAgb2VtbmFtZTEgPSAiTUJfUDVWIjsNCiAgICAgICAgPiAgICAgID4gKyAgICAgICAg
ICAgICAgIG9lbW5hbWUyID0gIk1CX1AxMlYiOw0KICAgICAgICA+ICAgICAgPiArICAgICAgICAg
ICAgICAgb2VtbmFtZTMgPSAiTUJfUDFWMDUiOw0KICAgICAgICA+ICAgICAgPiArICAgICAgICAg
ICAgICAgb2VtbmFtZTQgPSAiTUJfUFZOTl9QQ0hfU1RCWSI7DQogICAgICAgID4gICAgICA+ICsg
ICAgICAgICAgICAgICBvZW1uYW1lNSA9ICJNQl9QM1YzX1NUQlkiOw0KICAgICAgICA+ICAgICAg
PiArICAgICAgICAgICAgICAgb2VtbmFtZTYgPSAiTUJfUDVWX1NUQlkiOw0KICAgICAgICA+ICAg
ICAgDQogICAgICAgID4gICAgICAib2VtbmFtZSIgaXNuJ3QgcGFydCBvZiB0aGUgdXBzdHJlYW0g
YmluZGluZ3MuIElzIHRoaXMgc29tZXRoaW5nIHlvdQ0KICAgICAgICA+ICAgICAgaGF2ZSBwYXRj
aGVzIGZvcj8NCiAgICAgICAgPiBUaGlzIGlzIGEgd29ya2Fyb3VuZCBmaWVsZCB1c2VkIGJ5IGRi
dXMtc2Vuc29ycyBhcHBsaWNhdGlvbiB0byBhdm9pZCBvdmVybGF5IGZvciBkeW5hbWljIGRldGVj
dGlvbiBvZiBkZXZpY2VzIGJhc2VkIG9uIGpzb24gZmlsZSBkZWZpbml0aW9uLg0KICAgICAgICA+
IA0KICAgICAgICA+IENhbiB5b3UgcGxlYXNlIGFsc28gcmV2aWV3IG90aGVyIDMgcGF0Y2hlcyBp
biB0aGlzIHNlcmllcy4NCiAgICAgICAgPiAgICAgIA0KICAgICAgICA+IA0KICAgICAgICANCiAg
ICAgICAgVGhlc2Ugb2VtbmFtZSBzZXR0aW5ncyBzaG91bGQgbm90IGJlIGFkZGVkIGludG8gaGVy
ZS4gWW91IGNhbiBhZGQgdGhlc2UNCiAgICAgICAgaW5mb3JtYXRpb24gaW50byBjb25maWd1cmF0
aW9uIG9mIGVudGl0eSBtYW5hZ2VyIHdoaWNoIHVzZXMgb3ZlcmxheQ0KICAgICAgICB0ZW1wbGF0
ZXMgZm9yIGRidXMtc2Vuc29ycy4gQWxzbywgYXMgSm9lbCBzYWlkLCAib2VtbmFtZSIgaXNuJ3Qg
cGFydCBvZg0KICAgICAgICB0aGUgdXBzdHJlYW0gYmluZGluZ3MuDQogICAgDQogICAgT3Zlcmxh
eSB0ZW1wbGF0ZXMgZnJvbSBlbnRpdHkgbWFuYWdlciBpcyBub3Qgd29ya2luZyBmb3IgZmFuIGFu
ZCBhZGMgc2Vuc29ycyB0aGF0J3Mgd2h5IGl0IGlzIGEgd29ya2Fyb3VuZCBzdWdnZXN0ZWQgYnkg
SmFtZXMgRmVpc3QgKEF1dGhvciBvZiBkYnVzLXNlbnNvcnMpLg0KDQpAamFtZXMuZmVpc3RAbGlu
dXguaW50ZWwuY29tLA0KUGxlYXNlIGNvbW1lbnQgb24gYWJvdmUgcGF0Y2gsIHBsZWFzZSBhZHZp
c2UgaWYgSSBuZWVkIHRvIGZpeCB0aGlzLg0KICAgICAgICANCiAgICAgICAgQ2hlZXJzLA0KICAg
ICAgICBKYWUNCiAgICAgICAgDQogICAgDQogICAgDQoNCg==
