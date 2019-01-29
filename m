Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24129C282D0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B432147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="HAnohHg0";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Vn8ktr1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbfA2XAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:00:39 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48202 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727488AbfA2XAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:00:38 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0TMt2KC022721;
        Tue, 29 Jan 2019 15:00:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=uooQxjN8/atJFc3aEL4pzYDP4FYhwQDkL5vYSrH8vWo=;
 b=HAnohHg0los1/bAm26UHmuH0vd8NOZ/wPgSD2p+zLm5/jVllFgRf75Y/lD4I/ccP3fWn
 9LKrAf1gXDz/iDW2bG5SOkkK7QKhD7ampXjbuYL8ukaDk3cu0mjaK4vhdegZ0qBIyb9U
 Z0BiBuW1aGFFVpQMWeV40AQXW1+4f/i1sfg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qavr8gpxa-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 29 Jan 2019 15:00:16 -0800
Received: from frc-mbx02.TheFacebook.com (2620:10d:c0a1:f82::26) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 29 Jan 2019 15:00:14 -0800
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-mbx02.TheFacebook.com (2620:10d:c0a1:f82::26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 29 Jan 2019 15:00:13 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 29 Jan 2019 15:00:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uooQxjN8/atJFc3aEL4pzYDP4FYhwQDkL5vYSrH8vWo=;
 b=Vn8ktr1kv21St+3SlkD9Czljgt4ofnUiO1cVcN+VprZM+ePpUzJVlH39b9RqveFMc9dWqLaBp/0eVMxYexsaHiFMPDdu35EZnK7MVQrUEOlicuhWuIk5XhGVIW33n+SJIUdKtl+gziYHBal49SyOW31tro6nJDZC6E4tKjk47ic=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.180.139) by
 CY4PR15MB1351.namprd15.prod.outlook.com (10.172.158.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Tue, 29 Jan 2019 23:00:12 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::b4e4:1e1f:8c5d:9a8c]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::b4e4:1e1f:8c5d:9a8c%4]) with mapi id 15.20.1537.031; Tue, 29 Jan 2019
 23:00:12 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH v2] dt-bindings: aspeed-lpc: Make parameter optional
Thread-Topic: [PATCH v2] dt-bindings: aspeed-lpc: Make parameter optional
Thread-Index: AQHUr2qjb3N/GePovUiM68RLzMkX8aXGPegAgAAp7IA=
Date:   Tue, 29 Jan 2019 23:00:11 +0000
Message-ID: <A29B3BAA-8FA1-4FED-AB8D-C6DA2C2F785C@fb.com>
References: <20190118201547.640173-1-vijaykhemka@fb.com>
 <20190129123008.GC24070@dell>
In-Reply-To: <20190129123008.GC24070@dell>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::6:afcf]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1351;20:gptrMWokAR4nhPvs4znoMSAEgN+UskRMpFeoQsCzZWXwXG0orG9olEmYzYio6XsRFLCRu2C+e68Ir4jSzXSIGLtrKyLI/2n40D2kYKjJMSl5c3tQquOeG79EexcHgjTMkdbnjGC7RtClSBehXDPoapPOxrKUfiquIH3k2fw2yhs=
x-ms-office365-filtering-correlation-id: a4eb8c19-0937-43de-1ec6-08d6863d8616
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1351;
x-ms-traffictypediagnostic: CY4PR15MB1351:
x-microsoft-antispam-prvs: <CY4PR15MB13515765546795B8B07B91EDDD970@CY4PR15MB1351.namprd15.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(376002)(396003)(346002)(366004)(199004)(189003)(76176011)(46003)(7416002)(86362001)(486006)(476003)(186003)(446003)(11346002)(305945005)(102836004)(2616005)(6116002)(6506007)(99286004)(256004)(53936002)(6512007)(2906002)(83716004)(7736002)(6916009)(6246003)(71190400001)(71200400001)(316002)(478600001)(105586002)(33656002)(14454004)(97736004)(54906003)(6436002)(8676002)(229853002)(106356001)(81166006)(82746002)(81156014)(68736007)(8936002)(25786009)(36756003)(6486002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1351;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: l67BybvluVM/hlgx1XVb7kzAPKJfDb+xsmKwGtL+n01/qqJsYwTtWIliETk7M8o03GfgwfM46265IS2d96CfsLK67HhnaMWE7rFp2MIy/xHMblOaaLtn6UrQPz0/bWXSM+ihFDTQblo6wbB7C4DXK72tidUFZiRdqTz4KOrhxGAx1WPxUkMJYFNffdwbLIu2K7ZFNAG1UA82XftDqzV/Y6zcVGFURYTmFHTjsi+mOAiiZqoBt1o4YTBsOJ9XYH6V19jUP0WrVK0PVpu3huaKXRB0KDcHJcZptCClunieHNRuDC9WgyOEHvhrzPJyWBS0gOny9nDvE19637lobvuB79Mz3ud0ok2gGnQT/5HgBoxGaCO/ZnSb4gNpxtFSEQDvcnuUS+yuquRqD/DiJU+JFMDFWkdpMD3oc/gM+b6QJnQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF1F6947D459C44888696407724BBA09@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a4eb8c19-0937-43de-1ec6-08d6863d8616
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 23:00:11.9290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1351
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_18:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIExlZSwNCg0K77u/T24gMS8yOS8xOSwgNDozMCBBTSwgIkxlZSBKb25lcyIgPGxlZS5q
b25lc0BsaW5hcm8ub3JnPiB3cm90ZToNCg0KICAgIE9uIEZyaSwgMTggSmFuIDIwMTksIFZpamF5
IEtoZW1rYSB3cm90ZToNCiAgICANCiAgICA+IE1lbW9yeS1yZWdpb24gYW5kIGZsYXNoIHBoYW5k
bGUgaXMgbm90IGEgcmVxdWlyZWQgcGFyYW1ldGVyLCBpdCBpcw0KICAgID4gb3B0aW9uYWwgdG8g
ZGVzY3JpYmUgaW4gZGV2aWNlIHRyZWUgYW5kIG5lZWRlZCBvbmx5IHVzZSBiYXNpcy4NCiAgICA+
IA0KICAgID4gU2lnbmVkLW9mZi1ieTogVmlqYXkgS2hlbWthIDx2aWpheWtoZW1rYUBmYi5jb20+
DQogICAgPiAtLS0NCiAgICA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZk
L2FzcGVlZC1scGMudHh0IHwgMyArKysNCiAgICA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspDQogICAgPiANCiAgICA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbWZkL2FzcGVlZC1scGMudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21mZC9hc3BlZWQtbHBjLnR4dA0KICAgID4gaW5kZXggMzRkZDg5MDg3Y2ZmLi5k
MjhjNGUxMTc2MTEgMTAwNjQ0DQogICAgPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbWZkL2FzcGVlZC1scGMudHh0DQogICAgPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbWZkL2FzcGVlZC1scGMudHh0DQogICAgPiBAQCAtMTM1LDYgKzEz
NSw5IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQogICAgPiAgLSBjbG9ja3M6CWNvbnRhaW5zIGEg
cGhhbmRsZSB0byB0aGUgc3lzY29uIG5vZGUgZGVzY3JpYmluZyB0aGUgY2xvY2tzLg0KICAgID4g
IAkJVGhlcmUgc2hvdWxkIHRoZW4gYmUgb25lIGNlbGwgcmVwcmVzZW50aW5nIHRoZSBjbG9jayB0
byB1c2UNCiAgICA+ICANCiAgICA+ICtPcHRpb25hbCBwcm9wZXJ0aWVzOg0KICAgID4gK1RoZXNl
IGJlbG93IHByb3BlcnRpZXMgYXJlIG9wdGlvbmFsIHRvIGRlZmluZS4NCiAgICANCiAgICBUaGlz
IGxpbmUgaXMgc3VwZXJmbHVvdXMuICBQbGVhc2UgcmVtb3ZlIGl0Lg0KSSB3aWxsIHJlbW92ZSBp
dC4gSSBhbSBhc3N1bWluZyBvbmx5IDEgbGluZSB0byByZW1vdmUuDQogICAgDQogICAgPiArDQog
ICAgPiAgLSBtZW1vcnktcmVnaW9uOiBBIHBoYW5kbGUgdG8gYSByZXNlcnZlZF9tZW1vcnkgcmVn
aW9uIHRvIGJlIHVzZWQgZm9yIHRoZSBMUEMNCiAgICA+ICAJCXRvIEFIQiBtYXBwaW5nDQogICAg
PiAgDQogICAgDQogICAgLS0gDQogICAgTGVlIEpvbmVzIFvmnY7nkLzmlq9dDQogICAgTGluYXJv
IFNlcnZpY2VzIFRlY2huaWNhbCBMZWFkDQogICAgTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ug
c29mdHdhcmUgZm9yIEFSTSBTb0NzDQogICAgRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0
dGVyIHwgQmxvZw0KICAgIA0KDQo=
