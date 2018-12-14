Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263B5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609502080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="RiJO8Rxy";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="GOgwKEyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbeLNUmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:42:03 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47844 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730713AbeLNUmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:42:02 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id wBEKdH59011357;
        Fri, 14 Dec 2018 12:41:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=+crnIHY7uo1fs4z8eJzKHfE190XpazemFGfBojiGJuo=;
 b=RiJO8RxydEGgstAcVGq+hhEt3zwCXSK0xkV3YulRVYEtBiV2z9UZeaT1xucYN4YZpkFx
 jH+IdK2QAL+i2fhbn5dwG9ReCnG8qaRPbCHhVXzQkeqQb4vzEnHvf91/ZvX61xw9Xv2+
 /XWXufy4C6hxo5y4ViMyasWCvUQV75Rdh9s= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2pck9ug3j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 14 Dec 2018 12:41:30 -0800
Received: from prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 14 Dec 2018 12:41:29 -0800
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 14 Dec 2018 12:41:28 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 14 Dec 2018 12:41:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+crnIHY7uo1fs4z8eJzKHfE190XpazemFGfBojiGJuo=;
 b=GOgwKEyP8NvepUHIfNJvjwmylaw0B9iUrAj3HJYcjMVyx3g6tUGC1uCLsqAGeeaY0yu97inuqLU+1wBAlGvdx7tQY0rTiW4nPW649f9AuAdspRXCpPpzT8Ou7kA5Dea2OdRb/EPgVIebXjum0Kqx9c9YXiLaQSOmZvkqF+ECH/Q=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.180.139) by
 CY4PR15MB1143.namprd15.prod.outlook.com (10.172.175.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.24; Fri, 14 Dec 2018 20:41:26 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::1bd:fa86:857:9b04]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::1bd:fa86:857:9b04%10]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 20:41:26 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "james.feist@linux.intel.com" <james.feist@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/4] ARM: dts: aspeed: Add sensors devices for Facebook
Thread-Topic: [PATCH 1/4] ARM: dts: aspeed: Add sensors devices for Facebook
Thread-Index: AQHUkx2FLuLFnaparUSSS8WntKzruKV9R9KAgAC8q4CAAJi+AP//kTEA
Date:   Fri, 14 Dec 2018 20:41:26 +0000
Message-ID: <C3FBCA5F-210A-4817-AA08-331E82319909@fb.com>
References: <20181213195319.1333402-1-vijaykhemka@fb.com>
 <CACPK8XfAXDHqWcD=OKm4UhCh-+-7GBxL02Fi9_jgdmo2ZQZSjg@mail.gmail.com>
 <B6C3C92D-1F9E-4425-ABF5-718D1A6755EB@fb.com>
 <c1e35845-cb07-048f-bcf7-d7239a387027@linux.intel.com>
In-Reply-To: <c1e35845-cb07-048f-bcf7-d7239a387027@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::5:32a]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1143;20:YY3vHdorL6aoVj7zKZA76xBj0QJD3ff3gxkqFLTqyltqg94K8t3iYURk7K9tqP6bhhTrUAGf2Y2v3eRVRx0YXHyykbC54RJxFH8ioZK6t4/MJOD4q00IjeA0sd3yZRe7H8zvcrQPj0YiooMNuz3tdL+rAZw5VDY6RKKlkBAI7S8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4637c157-42d2-4bd4-460d-08d6620484ce
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1143;
x-ms-traffictypediagnostic: CY4PR15MB1143:
x-microsoft-antispam-prvs: <CY4PR15MB1143FD3D17CB00B8A0A81E20DDA10@CY4PR15MB1143.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(11241501185)(6040522)(2401047)(8121501046)(5005006)(3231475)(944501520)(52105112)(10201501046)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:CY4PR15MB1143;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1143;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(366004)(396003)(39860400002)(47680400002)(189003)(199004)(446003)(11346002)(2906002)(6246003)(71200400001)(6512007)(99286004)(486006)(476003)(6436002)(256004)(86362001)(76176011)(6486002)(105586002)(46003)(4326008)(68736007)(83716004)(82746002)(25786009)(102836004)(71190400001)(81156014)(5660300001)(478600001)(53936002)(2616005)(186003)(81166006)(106356001)(8676002)(97736004)(7736002)(36756003)(54906003)(229853002)(6116002)(305945005)(14454004)(7416002)(8936002)(6506007)(110136005)(316002)(53546011)(33656002)(93886005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1143;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TyWJjmZVCMs3m5srhxENQs1k4SLNdBsBeJks4v9aPgTpiT9HY8oJzxKrr6VGGH5DnQ1wojhMucarSGeK0vSW01q2LzeGQorOHxJvCyaB2obzr+T9kTmTlaLpNH6zQqRnlx34S1rQuWeCPm5II0MFAgK1CHCahyiPqYNWllgbFzIszscT0qmcrQ8v3jq9VmW3a1clJN43ThUZKnN1ex6Yx7UUuLl5NJdBo9ViJ/W3oqH0iXbvtDyMVeqRp23HclwrIqEQw4H9bVeuee0VBJAKLoROLylPxs6de+i+/WZZ2xPHEupfC/yF5SYhLnfLA7Fn
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BEB78C03C0C90A43A0A00F481080B3C5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4637c157-42d2-4bd4-460d-08d6620484ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 20:41:26.6115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1143
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-14_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDEyLzE0LzE4LCAxMToyMiBBTSwgIm9wZW5ibWMgb24gYmVoYWxmIG9mIEphZSBI
eXVuIFlvbyIgPG9wZW5ibWMtYm91bmNlcyt2aWpheWtoZW1rYT1mYi5jb21AbGlzdHMub3psYWJz
Lm9yZyBvbiBiZWhhbGYgb2YgamFlLmh5dW4ueW9vQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQoN
CiAgICBIaSBWaWpheSwNCiAgICANCiAgICBPbiAxMi8xNC8yMDE4IDEwOjExIEFNLCBWaWpheSBL
aGVta2Egd3JvdGU6DQogICAgPiBPbiAxMi8xMy8xOCwgMjo1NiBQTSwgIkpvZWwgU3RhbmxleSIg
PGpvZWxAam1zLmlkLmF1PiB3cm90ZToNCiAgICANCiAgICA8c25pcD4NCiAgICANCiAgICA+ICAg
ICAgPiArICAgICAgICAgICAgICAgb2VtbmFtZTAgPSAiTUJfUDNWMyI7DQogICAgPiAgICAgID4g
KyAgICAgICAgICAgICAgIG9lbW5hbWUxID0gIk1CX1A1ViI7DQogICAgPiAgICAgID4gKyAgICAg
ICAgICAgICAgIG9lbW5hbWUyID0gIk1CX1AxMlYiOw0KICAgID4gICAgICA+ICsgICAgICAgICAg
ICAgICBvZW1uYW1lMyA9ICJNQl9QMVYwNSI7DQogICAgPiAgICAgID4gKyAgICAgICAgICAgICAg
IG9lbW5hbWU0ID0gIk1CX1BWTk5fUENIX1NUQlkiOw0KICAgID4gICAgICA+ICsgICAgICAgICAg
ICAgICBvZW1uYW1lNSA9ICJNQl9QM1YzX1NUQlkiOw0KICAgID4gICAgICA+ICsgICAgICAgICAg
ICAgICBvZW1uYW1lNiA9ICJNQl9QNVZfU1RCWSI7DQogICAgPiAgICAgIA0KICAgID4gICAgICAi
b2VtbmFtZSIgaXNuJ3QgcGFydCBvZiB0aGUgdXBzdHJlYW0gYmluZGluZ3MuIElzIHRoaXMgc29t
ZXRoaW5nIHlvdQ0KICAgID4gICAgICBoYXZlIHBhdGNoZXMgZm9yPw0KICAgID4gVGhpcyBpcyBh
IHdvcmthcm91bmQgZmllbGQgdXNlZCBieSBkYnVzLXNlbnNvcnMgYXBwbGljYXRpb24gdG8gYXZv
aWQgb3ZlcmxheSBmb3IgZHluYW1pYyBkZXRlY3Rpb24gb2YgZGV2aWNlcyBiYXNlZCBvbiBqc29u
IGZpbGUgZGVmaW5pdGlvbi4NCiAgICA+IA0KICAgID4gQ2FuIHlvdSBwbGVhc2UgYWxzbyByZXZp
ZXcgb3RoZXIgMyBwYXRjaGVzIGluIHRoaXMgc2VyaWVzLg0KICAgID4gICAgICANCiAgICA+IA0K
ICAgIA0KICAgIFRoZXNlIG9lbW5hbWUgc2V0dGluZ3Mgc2hvdWxkIG5vdCBiZSBhZGRlZCBpbnRv
IGhlcmUuIFlvdSBjYW4gYWRkIHRoZXNlDQogICAgaW5mb3JtYXRpb24gaW50byBjb25maWd1cmF0
aW9uIG9mIGVudGl0eSBtYW5hZ2VyIHdoaWNoIHVzZXMgb3ZlcmxheQ0KICAgIHRlbXBsYXRlcyBm
b3IgZGJ1cy1zZW5zb3JzLiBBbHNvLCBhcyBKb2VsIHNhaWQsICJvZW1uYW1lIiBpc24ndCBwYXJ0
IG9mDQogICAgdGhlIHVwc3RyZWFtIGJpbmRpbmdzLg0KDQpPdmVybGF5IHRlbXBsYXRlcyBmcm9t
IGVudGl0eSBtYW5hZ2VyIGlzIG5vdCB3b3JraW5nIGZvciBmYW4gYW5kIGFkYyBzZW5zb3JzIHRo
YXQncyB3aHkgaXQgaXMgYSB3b3JrYXJvdW5kIHN1Z2dlc3RlZCBieSBKYW1lcyBGZWlzdCAoQXV0
aG9yIG9mIGRidXMtc2Vuc29ycykuDQogICAgDQogICAgQ2hlZXJzLA0KICAgIEphZQ0KICAgIA0K
DQo=
