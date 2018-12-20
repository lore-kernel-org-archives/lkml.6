Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319B9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA5F218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="OkvkbBPa";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="eMKeqwVo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388559AbeLTSGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:06:32 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37398 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730541AbeLTSGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:06:30 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id wBKHsMmS002204;
        Thu, 20 Dec 2018 10:06:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=dVSRtrZVNsfLNnCVNL6bgUEgLQwhZIkAPE5lLG5a9ZY=;
 b=OkvkbBPaqgJd4VpYuQEX8TVJcZyut3hdcr76z+yL9MNUrstf9dGnGATBavlVaQinCAJq
 MCKkc21APwZu1ssdlLWb1sHg4s7OltMQEtbgvshX1OfaWsyQYB8xAUOfZbVzngI5aNnJ
 /OKp2AgZ0Qvq+4h9tYQbH9LDyAmHEcTsw0U= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2pgevq09nc-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 20 Dec 2018 10:05:59 -0800
Received: from frc-mbx03.TheFacebook.com (2620:10d:c0a1:f82::27) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 20 Dec 2018 10:05:43 -0800
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-mbx03.TheFacebook.com (2620:10d:c0a1:f82::27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 20 Dec 2018 10:05:43 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 20 Dec 2018 10:05:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVSRtrZVNsfLNnCVNL6bgUEgLQwhZIkAPE5lLG5a9ZY=;
 b=eMKeqwVoEbPM5ocUV2UFH20CJ153h96aYy3iPQTktCRyuf4XNzzTBdkR6dyooyA4/SJQ+uB3vZDuj9Od7MnNFP0NuWPVKppENuszWpfuIOohqzeqRB5Tfc6DbxxJsYFWjo5IEFhSHu8LBmUWatWWJ6xBQWY7TQeRgTeiPQMl+70=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.180.139) by
 CY4PR15MB1173.namprd15.prod.outlook.com (10.172.177.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Thu, 20 Dec 2018 18:05:42 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::1bd:fa86:857:9b04]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::1bd:fa86:857:9b04%10]) with mapi id 15.20.1446.018; Thu, 20 Dec 2018
 18:05:41 +0000
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
Subject: Re: [PATCH v2 4/4] ARM: dts: aspeed: Add lpc ctrl for Facebook
Thread-Topic: [PATCH v2 4/4] ARM: dts: aspeed: Add lpc ctrl for Facebook
Thread-Index: AQHUlkO6p1obtPptykC2AH1z2EHxEqWHapcA
Date:   Thu, 20 Dec 2018 18:05:41 +0000
Message-ID: <F23E6426-F6FE-4F10-A88A-D5862D5407B4@fb.com>
References: <20181217200405.2904551-1-vijaykhemka@fb.com>
 <20181217200405.2904551-4-vijaykhemka@fb.com>
In-Reply-To: <20181217200405.2904551-4-vijaykhemka@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::7:c50e]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1173;20:5ENWW2OF6DQYDGKuQdYS5G6kC36ANYrHYjaGI97ZR7tqOryB+1A9YOIf2O/XOQcsdyIFHFjktPATlmv1Nq8wnIsx5RW6JCdd8ElFA6ItGsRo8uUv4rLF93GqOeT3VUkM+zoErQb93niuw0MYC7mzaLALciOblcbgDJoXvZu/42U=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 863b8bdb-a1f1-4541-d479-08d666a5c167
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1173;
x-ms-traffictypediagnostic: CY4PR15MB1173:
x-microsoft-antispam-prvs: <CY4PR15MB11732DEE07257EB376CF29EADDBF0@CY4PR15MB1173.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(11241501185)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:CY4PR15MB1173;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1173;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(136003)(346002)(39860400002)(47680400002)(189003)(199004)(43544003)(81166006)(81156014)(8676002)(2201001)(97736004)(102836004)(6506007)(186003)(305945005)(33656002)(76176011)(476003)(7736002)(86362001)(14454004)(105586002)(256004)(68736007)(6116002)(106356001)(486006)(2501003)(8936002)(71200400001)(71190400001)(99286004)(83716004)(478600001)(36756003)(11346002)(6246003)(316002)(6486002)(110136005)(53936002)(6512007)(2616005)(446003)(82746002)(25786009)(5660300001)(4326008)(2906002)(6436002)(46003)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1173;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yHgkjH9+I78MxDvnI645o3aKDhnp3dhNF0ixuBpp/Z9phO3YXLes7DKpihjTKfRAA0NjMkx7ErNiCRMgElaGFHRe07TZbqU9pKfKn3SsO0LPrZOstwt+y8SXZVjFN+Vt6iVAUKOgvegqpI1b/vQ4vCJLu/zq9+Riitcts1Kd7zwzI0oKut0TFBT2g3yHjzK44/UASNFi+z13/2naxZ4YcWP1wco22asgQt2lbvyJc4FHZNIbY3VVz9LkerBXSHVePeShx2nrXavgxjV3ZegsZj5szaocuhi+30PUQDkdU53+zoIcgdkT9chMTkwpIwHJ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E63902F63E2064EB2DB2D7E516CF5C1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 863b8bdb-a1f1-4541-d479-08d666a5c167
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 18:05:41.8817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1173
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-20_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sm9lbCwgQ2FuIHlvdSBwbGVhc2UgdGFrZSBjYXJlIG9mIHRoZXNlIHBhdGNoZXMgbWVyZ2UuDQoN
Cu+7v09uIDEyLzE3LzE4LCAxMjowNCBQTSwgIlZpamF5IEtoZW1rYSIgPHZpamF5a2hlbWthQGZi
LmNvbT4gd3JvdGU6DQoNCiAgICBBZGRlZCBscGMgY3RybCBkZXZpY2UgdG8gZW5hYmxlIExQQyBj
bG9jayBpbiBGYWNlYm9vaw0KICAgIFRpb2dhcGFzcyBkZXZpY2UgdHJlZS4NCiAgICANCiAgICBT
aWduZWQtb2ZmLWJ5OiBWaWpheSBLaGVta2EgPHZpamF5a2hlbWthQGZiLmNvbT4NCiAgICAtLS0N
CiAgICAgLi4uL2Jvb3QvZHRzL2FzcGVlZC1ibWMtZmFjZWJvb2stdGlvZ2FwYXNzLmR0cyAgfCAx
NyArKysrKysrKysrKysrKysrKw0KICAgICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygr
KQ0KICAgIA0KICAgIGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQtYm1jLWZh
Y2Vib29rLXRpb2dhcGFzcy5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQtYm1jLWZhY2Vi
b29rLXRpb2dhcGFzcy5kdHMNCiAgICBpbmRleCA3M2U1OGE4MjE2MTMuLmVmNzg3NWI1NDU2MiAx
MDA2NDQNCiAgICAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQtYm1jLWZhY2Vib29rLXRp
b2dhcGFzcy5kdHMNCiAgICArKysgYi9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQtYm1jLWZhY2Vi
b29rLXRpb2dhcGFzcy5kdHMNCiAgICBAQCAtMjIsNiArMjIsMTcgQEANCiAgICAgCQlyZWcgPSA8
MHg4MDAwMDAwMCAweDIwMDAwMDAwPjsNCiAgICAgCX07DQogICAgIA0KICAgICsJcmVzZXJ2ZWQt
bWVtb3J5IHsNCiAgICArCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCiAgICArCQkjc2l6ZS1jZWxs
cyA9IDwxPjsNCiAgICArCQlyYW5nZXM7DQogICAgKw0KICAgICsJCWZsYXNoX21lbW9yeTogcmVn
aW9uQDk4MDAwMDAwIHsNCiAgICArCQkJbm8tbWFwOw0KICAgICsJCQlyZWcgPSA8MHg5ODAwMDAw
MCAweDAwMDAxMDAwPjsgLyogNEsgKi8NCiAgICArCQl9Ow0KICAgICsJfTsNCiAgICArDQogICAg
IAlpaW8taHdtb24gew0KICAgICAJCWNvbXBhdGlibGUgPSAiaWlvLWh3bW9uIjsNCiAgICAgCQlp
by1jaGFubmVscyA9IDwmYWRjIDA+LCA8JmFkYyAxPiwgPCZhZGMgMj4sIDwmYWRjIDM+LA0KICAg
IEBAIC01NCw2ICs2NSwxMiBAQA0KICAgICAJfTsNCiAgICAgfTsNCiAgICAgDQogICAgKyZscGNf
Y3RybCB7DQogICAgKwlzdGF0dXMgPSAib2theSI7DQogICAgKwltZW1vcnktcmVnaW9uID0gPCZm
bGFzaF9tZW1vcnk+Ow0KICAgICsJZmxhc2ggPSA8JnNwaTE+Ow0KICAgICt9Ow0KICAgICsNCiAg
ICAgJnVhcnQxIHsNCiAgICAgCS8vIEhvc3QgQ29uc29sZQ0KICAgICAJc3RhdHVzID0gIm9rYXki
Ow0KICAgIC0tIA0KICAgIDIuMTcuMQ0KICAgIA0KICAgIA0KDQo=
