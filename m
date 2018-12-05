Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897B7C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448272082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="zQTeY4zL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448272082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeLELGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:06:42 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:26302 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbeLELGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:06:40 -0500
X-IronPort-AV: E=Sophos;i="5.56,317,1539673200"; 
   d="scan'208";a="21903059"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 05 Dec 2018 04:06:40 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 5 Dec 2018 04:06:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPBdRql75CH395/UTzjZTRHFpueECjci6BBtUUGiy3o=;
 b=zQTeY4zLIaMD01F4eN2PJH3ndjdWBndLi/trDSGSjYGYZ/pfH3wo5HP2n9s/fX576EKOhnORhh/+CExWF9ZrpV6SxMuRyv2loFtNezzctZx+XDTEp8P+1DsbQSpGah0t7Xwk1bXhuBWn9np49MOz+aSOnOJ2J8+DIx0PlU/S48c=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2180.namprd11.prod.outlook.com (10.174.112.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Wed, 5 Dec 2018 11:06:36 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1%5]) with mapi id 15.20.1404.019; Wed, 5 Dec 2018
 11:06:36 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <robh@kernel.org>
CC:     <linus.walleij@linaro.org>, <gregkh@linuxfoundation.org>,
        <Nicolas.Ferre@microchip.com>, <mark.rutland@arm.com>,
        <Ludovic.Desroches@microchip.com>, <Cristian.Birsan@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: gpio: add SAMA5D2 PIOBU support
Thread-Topic: [PATCH v2 1/2] dt-bindings: gpio: add SAMA5D2 PIOBU support
Thread-Index: AQHUgKg8JYSs1TI8IUy9lTCXxs8No6VvTyuAgADEn4A=
Date:   Wed, 5 Dec 2018 11:06:35 +0000
Message-ID: <2600b55c-f8fd-ab82-6372-a75f22e382f8@microchip.com>
References: <1542701330-23466-1-git-send-email-andrei.stefanescu@microchip.com>
 <1542701330-23466-2-git-send-email-andrei.stefanescu@microchip.com>
 <20181204232237.GA16883@bogus>
In-Reply-To: <20181204232237.GA16883@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0101CA0068.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::36) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2180;6:2Om1dlN38Bcbw1D1k97JE08m/TiRBz6paymUjTEMwtnOlo4JCzQ5yAz3oXd/O5Sz4BL5WbbOFwCubDwiOA0ofeAXcj8lGIHC10BhCeqh3u/TGpy7+fyy0M6ok4zDVrGvIkOlSCJdMCNu67d26CL6m4qQx9IV9FelvTWsMHsnmtbbqMlaiSgi5rKa9/UYEtCg3dNIDuWaxSi7YXE0MWyZ/4J5MmzHoyxW+0W3ku91uPdq+EXX+trQ98EvAPL5fZuZLJBXEkmNQ7zsq7YOvliUJBn8q4F+SY6CldxCvQC0FXOZgAQQ80qHDjn2xQcXlwfKwXCxxolrb5dOUGCbLQdOC32HoaYx/xX/f8ukSS6dLi6kSBPoLmPHQHd9ibRlcH+/gWwH0wyDPS340xifEfY6HAhaCJZavo5Kkxv9qgaLdGcoB1NKQYDIsURdZkm3VAnEFzuSN3s5ycsnspvLmeAEGQ==;5:xVXWkWkJYmtQjnfBZY97nag9N5t9jUKvUSaK7Q8CxknYWD8tUj7wGpUdj2HMlp7eWHU8fLjYaTjANnKkO7N3kHLlLAcfxCL2cSVsnQwmHdP7CnbrKrDxR1GLctUflLLY47/egImR39ZuRbdn30QtSYs6Q0U5OB/ANpiVh8V8uuM=;7:TC+Rzpn0PB3lsHFjU7QJUfhcUg2it3MTh1EUIkS9hpQxJOZ88teSjbn27byjyS8S09NEWPB60ow6T8tfXBIy3SCxAvKMKAi7p5sYqltZ87VIN3Zb8DGdxYnTX1i3mXK6Vft32yArN7xgPazoJBbmvg==
x-ms-office365-filtering-correlation-id: fd3f2611-6b59-404d-a1c0-08d65aa1b858
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2180;
x-ms-traffictypediagnostic: BN6PR1101MB2180:
x-microsoft-antispam-prvs: <BN6PR1101MB218066E590475B842A826B4BEDA80@BN6PR1101MB2180.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2180;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2180;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(486006)(72206003)(6486002)(97736004)(106356001)(105586002)(6916009)(81156014)(81166006)(54906003)(14444005)(256004)(8676002)(316002)(478600001)(2616005)(476003)(8936002)(11346002)(25786009)(6436002)(71200400001)(71190400001)(229853002)(446003)(14454004)(68736007)(99286004)(76176011)(52116002)(6506007)(386003)(345774005)(7736002)(26005)(53936002)(6246003)(305945005)(186003)(4326008)(6512007)(2906002)(6116002)(3846002)(31696002)(86362001)(66066001)(5660300001)(36756003)(102836004)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2180;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: p45MaIKHkAFvKUBQimpyFDP2en2txVkBv8GR0epyPo5Pggyvt/FCbrCKSqhwpUtu58zedehpNJwEP/fncSNYvCOER2EAGuD5EZ/6Z2mnGzAOmMCQLw9tnAa7I7vI3nYweNZx4PNUZ57r/D++i+IK8fBcy5wRGO/rP4FWXUSyViMLEt/wY42zAPwXXIpJfHiTSsb5prfs73nB9bxAnDRLNPSoUQNfC79myQJaQu+11tCJ+yTvI6FhHCMRK4d7PhQpucnaYwUik6NHiLe8YPOswF81eIK3GqYwIchu5URfECO1FMOxqWWMwVujySAx9aNjkwGa7fWsbT1fxF//GUAlnqF4gXawEZzRMaO/e9ExZYo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8784F2D07FE7FA4895DD596BA0F854A9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3f2611-6b59-404d-a1c0-08d65aa1b858
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 11:06:36.1385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2180
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gUm9iLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgZmVlZGJhY2suDQoNCkkgd2lsbCBhZGQg
YSBiaXQgb2YgY29udGV4dCByZWdhcmRpbmcgdGhlIHNlY3Vtb2QuIFRoZSANCiJhdG1lbCxzYW1h
NWQyLXNlY3Vtb2QiDQpjb21wYXRpYmxlIHN0cmluZyBpcyBub3QgdXNlZCBmb3IgbG9hZGluZyBh
IGRyaXZlci4gSXQgaXMgdXNlZCBieSBhdG1lbCANCnNlY3VyYW0NCmRyaXZlciAoZHJpdmVycy9t
aXNjL3NyYW0uYykgd2hpY2ggaGFzIGFjY2VzcyB0byBzZWN1bW9kJ3MgcmVnaXN0ZXJzIHZpYToN
Cg0KIMKgwqDCoCBzeXNjb25fcmVnbWFwX2xvb2t1cF9ieV9jb21wYXRpYmxlKCJhdG1lbCxzYW1h
NWQyLXNlY3Vtb2QiKQ0KDQpTbyB0aGUgc2VjdW1vZCBleHBvcnRzIG11bHRpcGxlIGhhcmR3YXJl
IGZ1bmN0aW9ucywgZWc6IHRoZSBzZWN1cmFtLCB0aGUgDQpQSU9CVQ0KcGlucyB3aGljaCBjYW4g
YmUgdXNlZCBhcyBHUElPIHBpbnMuDQoNCk15IGluaXRpYWwgcGF0Y2ggaGFkIHRoZSAibWljcm9j
aGlwLHNhbWE1ZDItcGlvYnUiIGNvbXBhdGlibGUgYXBwZW5kZWQgDQp0byB0aGUNCnNlY3Vtb2Qn
cyBjb21wYXRpYmxlIGUuZy46DQoNCnNlY3Vtb2RAZmMwNDAwMDAgew0KIMKgwqDCoCBjb21wYXRp
YmxlID0gInN5c2NvbiIsICJtaWNyb2NoaXAsc2FtYTVkMi1waW9idSI7DQouLi4NCg0KVGFraW5n
IGludG8gY29uc2lkZXJhdGlvbiBMaW51cyBXYWxsZWlqJ3MgYWR2aWNlIEkgYXJyaXZlZCB0byB0
aGUgY3VycmVudA0KdmVyc2lvbi4gSSB0aG91Z2h0IHRoaXMgd2FzIGEgZ29vZCBpZGVhIGJlY2F1
c2UgaXQgc2VwYXJhdGVzIHRoZSBzZWN1bW9kIA0Kbm9kZQ0KZnJvbSB0aGUgR1BJTyBjb250cm9s
bGVyIG5vZGUuIFBsZWFzZSBub3RpY2UgdGhhdCBzZWN1cmFtIG5vZGUgaXMgYWxyZWFkeQ0Kc2Vw
YXJhdGVkIGZyb20gc2VjdW1vZCBub2RlIChpdCBpcyBhIHNlcGFyYXRlIG5vZGUgaW4gdGhlIGRl
dmljZSB0cmVlKS4NCg0KSSBoYXZlIGEgZmV3IHF1ZXN0aW9ucyBiZWNhdXNlIEkgYW0gbm90IHN1
cmUgb2YgdGhlIGJlc3QgYXBwcm9hY2g6DQoNCjEuIElzIGl0IG9rIHRvIGhhdmUgdGhlIEdQSU8g
Y29udHJvbGxlciBhcyBhIGNoaWxkIG5vZGU/DQoyLiBJIHVzZWQgc2ltcGxlLW1mZCBiZWNhdXNl
IGl0IHdhcyB0aGUgb25seSB3YXkgSSBjb3VsZCB0aGluayBvZiBpbiANCm9yZGVyIHRvDQogwqDC
oCBnZXQgdGhlIGRyaXZlciBwcm9iZWQuDQozLiBTaG91bGQgSSBhZGQgYSByZWdpc3RlciByYW5n
ZT8gSSB0aG91Z2h0IHRoYXQgYmVjYXVzZSB0aGUgZHJpdmVyIHVzZXMgDQpzeXNjb24NCiDCoMKg
IGl0IGlzIG5vdCBuZWNlc3NhcnkgdG8gYWRkIHRoZSByZWdpc3RlciByYW5nZS4gQWxzbywgdGhl
IHJlZ2lzdGVyIA0KcmFuZ2Ugd291bGQNCiDCoMKgIGhhdmUgYmVlbiBhIHN1YnNldCBvZiB0aGUg
c2VjdW1vZCdzIHJlZ2lzdGVyIHJhbmdlLg0KDQo=
