Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E00C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB0420870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UpAgQF5s";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="LotpDaci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB0420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbeLMTTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:19:21 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38082 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726453AbeLMTTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:19:20 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBDJHqnf017317;
        Thu, 13 Dec 2018 11:18:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Y8PpvohgIH1QWj2dCCOAyLAm8+oa8TjstfawXkmYHAE=;
 b=UpAgQF5sf0XblPFyKo9cM+quMA99YS3xI2pj1bVVgL9NJnOyFxDpVmDtqjIce5nTBb+w
 NY+hI4R1yLklziHUjQJZZPUmgnypVAd5WdkQiGp0Tzf4ga62k2SoLetU8Ay1XWGWrdZf
 r+zDnxTOfZSOO5O2hSPtyQ0Okm2o0qwRhgA= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pbt9cgtb0-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 13 Dec 2018 11:18:47 -0800
Received: from frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 13 Dec 2018 11:18:45 -0800
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 13 Dec 2018 11:18:45 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 13 Dec 2018 11:18:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8PpvohgIH1QWj2dCCOAyLAm8+oa8TjstfawXkmYHAE=;
 b=LotpDaciODX4aHqRF2XlAe7XaWgCdsz1H0DJ/zlBMNuEyIiSdfgAkr2Kxxy1Eeiy/O/aaPkkCe7n83/aTpzte4AN5sRiOJiFgJiV0lY9bKZ8FK72Aq1FJxa+YtO3tkQ9Ve0F9s0Chmj+2e9ZOp+BMJ/GkP18iDpGp3jb0DQTW1Q=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.180.139) by
 CY4PR15MB1525.namprd15.prod.outlook.com (10.172.157.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Thu, 13 Dec 2018 19:18:27 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::1bd:fa86:857:9b04]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::1bd:fa86:857:9b04%10]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 19:18:27 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH v4 1/2] ARM: dts: aspeed: Add KCS & lpc ctrl for Facebook
Thread-Topic: [PATCH v4 1/2] ARM: dts: aspeed: Add KCS & lpc ctrl for Facebook
Thread-Index: AQHUkl5ffPyWCA5Nkka8PMpoXyqsg6V72qYAgACrvwA=
Date:   Thu, 13 Dec 2018 19:18:27 +0000
Message-ID: <017219A7-E5A7-41B8-869C-B54FABF401A7@fb.com>
References: <20181212210352.1717617-1-vijaykhemka@fb.com>
 <CACPK8Xea5Q1c9ygvT+WtbwJN9p2Nn-bLo8Ea6U4KuFvFZXvkNg@mail.gmail.com>
In-Reply-To: <CACPK8Xea5Q1c9ygvT+WtbwJN9p2Nn-bLo8Ea6U4KuFvFZXvkNg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::7:4263]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1525;20:z/spgTNRqfZ1yzx/U2qFfbG0ITo4lrPim8QTgBIw1LJonegwzoeOnu4d1cdhilXwsyn2/jU3MJRaZQRtoTI0fYJTuA1XYAlLB3wLBX6lu70+Ifxm9uSbb+WMFaC3E1z93iOfFSehiaCqzDoRBqafN9ZHXxRVuS7N3JsV4J/jbpA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0c564d99-2c3e-4bb6-7fdd-08d6612fc276
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1525;
x-ms-traffictypediagnostic: CY4PR15MB1525:
x-microsoft-antispam-prvs: <CY4PR15MB15258083BBA274C31CC01FA4DDA00@CY4PR15MB1525.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(11241501185)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:CY4PR15MB1525;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1525;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(136003)(376002)(346002)(47680400002)(189003)(199004)(6246003)(106356001)(256004)(8936002)(105586002)(11346002)(2906002)(110136005)(14454004)(6116002)(54906003)(71190400001)(71200400001)(316002)(4326008)(6486002)(6512007)(6436002)(5660300001)(305945005)(8676002)(81156014)(486006)(446003)(99286004)(36756003)(46003)(25786009)(76176011)(82746002)(478600001)(83716004)(86362001)(476003)(6506007)(2616005)(7736002)(53936002)(186003)(81166006)(68736007)(33656002)(229853002)(102836004)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1525;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ro2vIbxcbL+ACwIGnVogudZwm0mMITL9LtG0E2iyeDUApNsGyTNdwL6vdqWoIGKCIUGYm7EUPSKemgTOWpf6zN6gwG0w8YNxUP4zbN/cb8mM/wfiq6FRPzBiRjGYmG2qQq+I1LhxzNLHEseCcqAVrSF6aDnP0+0EItZanTX2OWq45mW1n2mumyihDR6kFiTu9Nb0ffazWwLsuIQ0355OujpYBbQY06AkJ5t3UMBqkJMYY/GdUYcPs1p/8bBiowf225nxD2yc1JL9Prk4Ixbmh3W2ENG7VNKJ4APiYiY/+0jSIjR1FKUKWUgWuz5SloLv
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <690BA7F6FB40C2469C94E8686D3D5BAD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c564d99-2c3e-4bb6-7fdd-08d6612fc276
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 19:18:27.2265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1525
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-13_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDEyLzEyLzE4LCA1OjA0IFBNLCAiSm9lbCBTdGFubGV5IiA8am9lbEBqbXMuaWQu
YXU+IHdyb3RlOg0KDQogICAgT24gVGh1LCAxMyBEZWMgMjAxOCBhdCAwNzozNCwgVmlqYXkgS2hl
bWthIDx2aWpheWtoZW1rYUBmYi5jb20+IHdyb3RlOg0KICAgID4NCiAgICA+IEFkZGVkIGtjcyBk
ZXZpY2UgYW5kIGxwYyBjdHJsIGRldmljZSB0byBlbmFibGUgTFBDIGNsb2NrIGluIEZhY2Vib29r
DQogICAgPiBUaW9nYXBhc3MgZGV2aWNlIHRyZWUuDQogICAgDQogICAgQXMgd2UncmUgZ29pbmcg
dG8gcmUtc3BpbiwgaXQncyBhIGdvb2QgaWRlYSB0byBoYXZlIHRoZSBLQ1MgYW5kIExQQw0KICAg
IGNoYW5nZXMgaW4gc2VwYXJhdGUgcGF0Y2hlcy4gSSB3aWxsIHRha2UgdGhlIEtDUyBvbmUgc3Ry
YWlnaHQgYXdheSwNCiAgICBidXQgdGhlIExQQyBvbmUgbWlnaHQgbmVlZCBtb3JlIHdvcmsgKHNl
ZSBteSBjb21tZW50cyBiZWxvdykuDQoNClRoYW5rcyBKb2VsLA0KSSB3aWxsIGNyZWF0ZSBkaWZm
ZXJlbnQgcGF0Y2hlcyBhbmQgcmVzdWJtaXQgYWdhaW4uDQogICAgDQogICAgPg0KICAgID4gU2ln
bmVkLW9mZi1ieTogVmlqYXkgS2hlbWthIDx2aWpheWtoZW1rYUBmYi5jb20+DQogICAgPiAtLS0N
CiAgICA+ICAuLi4vZHRzL2FzcGVlZC1ibWMtZmFjZWJvb2stdGlvZ2FwYXNzLmR0cyAgICAgfCAz
MCArKysrKysrKysrKysrKysrKysrDQogICAgPiAgMSBmaWxlIGNoYW5nZWQsIDMwIGluc2VydGlv
bnMoKykNCiAgICA+DQogICAgPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVk
LWJtYy1mYWNlYm9vay10aW9nYXBhc3MuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkLWJt
Yy1mYWNlYm9vay10aW9nYXBhc3MuZHRzDQogICAgPiBpbmRleCBkOWQ3ZjIwODc4OGEuLjk1NDRm
YTJjMTgyMiAxMDA2NDQNCiAgICA+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1ibWMt
ZmFjZWJvb2stdGlvZ2FwYXNzLmR0cw0KICAgID4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNw
ZWVkLWJtYy1mYWNlYm9vay10aW9nYXBhc3MuZHRzDQogICAgPiBAQCAtMjEsNiArMjEsMTggQEAN
CiAgICA+ICAgICAgICAgbWVtb3J5QDgwMDAwMDAwIHsNCiAgICA+ICAgICAgICAgICAgICAgICBy
ZWcgPSA8MHg4MDAwMDAwMCAweDIwMDAwMDAwPjsNCiAgICA+ICAgICAgICAgfTsNCiAgICA+ICsN
CiAgICA+ICsgICAgICAgcmVzZXJ2ZWQtbWVtb3J5IHsNCiAgICA+ICsgICAgICAgICAgICAgICAj
YWRkcmVzcy1jZWxscyA9IDwxPjsNCiAgICA+ICsgICAgICAgICAgICAgICAjc2l6ZS1jZWxscyA9
IDwxPjsNCiAgICA+ICsgICAgICAgICAgICAgICByYW5nZXM7DQogICAgPiArDQogICAgPiArICAg
ICAgICAgICAgICAgZmxhc2hfbWVtb3J5OiByZWdpb25AOTgwMDAwMDAgew0KICAgID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgbm8tbWFwOw0KICAgID4gKyAgICAgICAgICAgICAgICAgICAgICAg
cmVnID0gPDB4OTgwMDAwMDAgMHgwNDAwMDAwMD47IC8qIDY0TSAqLw0KICAgID4gKyAgICAgICAg
ICAgICAgIH07DQogICAgDQogICAgQXJlIHlvdSB1c2luZyB0aGlzIHRvIGV4cG9zZSBzb21lIFJB
TSBvdmVyIExQQz8gSWYgbm90LCB3ZSBkb24ndCB3YW50IHRoaXMgaGVyZS4NCk5vLCB3ZSBhcmUg
bm90IHVzaW5nIGN1cnJlbnRseS4NCiAgICANCiAgICBJdCBpcyBhIGZsYXcgaW4gdGhlIGRlc2ln
biBvZiB0aGUgZHJpdmVyIHRoYXQgdGhlIHJlc2VydmVkIG1lbW9yeQ0KICAgIHJlZ2lvbiBpcyBy
ZXF1aXJlZC4gV2Ugc2hvdWxkIGNoYW5nZSB0aGUgZHJpdmVyIHRvIG1ha2UgaXQgb3B0aW9uYWwu
DQpJIGFncmVlIHdpdGggeW91IHdlIHNob3VsZCBtYWtlIHRoaXMgY2hhbmdlIGluIGRyaXZlci4N
CiAgICANCiAgICBBcyBhIHdvcmthcm91bmQsIHdlIGNvdWxkIGFkZCB0aGlzIHBhdGNoIHRvIHRo
ZSB0aW9nYXBhc3MgZGV2aWNlIHRyZWUNCiAgICBidXQgbWFrZSBpdCBzbWFsbGVyIHNvIHlvdSdy
ZSBub3QgbG9zaW5nIDY0TUIgb2YgUkFNLg0KSSB3aWxsIG1ha2UgaXQgdG8gNEsuDQogICAgDQog
ICAgPiArICAgICAgIH07DQogICAgPiArDQogICAgPiAgICAgICAgIGlpby1od21vbiB7DQogICAg
PiAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJpaW8taHdtb24iOw0KICAgID4gICAgICAg
ICAgICAgICAgIG9lbW5hbWUwID0gIk1CX1AzVjMiOw0KICAgID4gQEAgLTYyLDYgKzc0LDEyIEBA
DQogICAgPiAgICAgICAgIH07DQogICAgPiAgfTsNCiAgICA+DQogICAgPiArJmxwY19jdHJsIHsN
CiAgICA+ICsgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KICAgID4gKyAgICAgICBtZW1vcnktcmVn
aW9uID0gPCZmbGFzaF9tZW1vcnk+Ow0KICAgID4gKyAgICAgICBmbGFzaCA9IDwmc3BpMT47DQog
ICAgPiArfTsNCiAgICA+ICsNCiAgICA+ICAmdWFydDEgew0KICAgID4gICAgICAgICAvLyBIb3N0
IENvbnNvbGUNCiAgICA+ICAgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KICAgID4gQEAgLTc1LDYg
KzkzLDE4IEBADQogICAgPiAgICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCiAgICA+ICB9Ow0KICAg
ID4NCiAgICA+ICsma2NzMiB7DQogICAgPiArICAgICAgIC8vIEJNQyBLQ1MgY2hhbm5lbCAyDQog
ICAgPiArICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCiAgICA+ICsgICAgICAga2NzX2FkZHIgPSA8
MHhjYTg+Ow0KICAgID4gK307DQogICAgPiArDQogICAgPiArJmtjczMgew0KICAgID4gKyAgICAg
ICAvLyBCTUMgS0NTIGNoYW5uZWwgMw0KICAgID4gKyAgICAgICBzdGF0dXMgPSAib2theSI7DQog
ICAgPiArICAgICAgIGtjc19hZGRyID0gPDB4Y2EyPjsNCiAgICA+ICt9Ow0KICAgID4gKw0KICAg
ID4gICZtYWMwIHsNCiAgICA+ICAgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KICAgID4NCiAgICA+
IC0tDQogICAgPiAyLjE3LjENCiAgICA+DQogICAgDQoNCg==
