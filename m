Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697E7ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18ABF20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TAw11a2f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18ABF20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbeGSNYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:24:48 -0400
Received: from mail-sg2apc01on0104.outbound.protection.outlook.com ([104.47.125.104]:48603
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727242AbeGSNYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYjMG/s2RD5npWkGefM/Y93mbCD2M2zdP69ZrfzPHOM=;
 b=TAw11a2fMcMHO5GXr3LhwZSh7Ovfk7TKD+bIyjGEfuNcWLIX6NOAFyVaT533RRrVh/bxPyyB8Ogi3whIHtX3/dbUvoERDY/HYwzjRWYl4H4aFlOeW9a2FEcLZ4hZgf89Jn1cDZFnUN8T60rNrFhfJ7SPjaxg3UENi1r9capAHy8=
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM (10.170.136.145) by
 SG2P15301MB0046.APCP153.PROD.OUTLOOK.COM (10.170.136.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.10; Thu, 19 Jul 2018 12:41:37 +0000
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25]) by SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25%4]) with mapi id 15.20.0995.008; Thu, 19 Jul 2018
 12:41:37 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: Re: [PATCH V3 1/4] X86/Hyper-V: Add flush
 HvFlushGuestPhysicalAddressSpace hypercall support
Thread-Topic: [PATCH V3 1/4] X86/Hyper-V: Add flush
 HvFlushGuestPhysicalAddressSpace hypercall support
Thread-Index: AQHUHzwXf/C31+VeCkK7DL0Pwyc6l6SWczwAgAAJ6wA=
Date:   Thu, 19 Jul 2018 12:41:37 +0000
Message-ID: <beee6107-0168-e32b-288c-220001a4557b@microsoft.com>
References: <20180719083946.121493-1-Tianyu.Lan@microsoft.com>
 <20180719083946.121493-2-Tianyu.Lan@microsoft.com>
 <alpine.DEB.2.21.1807191404241.1602@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1807191404241.1602@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2P15301MB0046;6:u+i7+nMMnqMEtmxk/NP57qpJZgcKIyEY9zy+SzoQWLdgGeR7GVirBf6+Zq6kfDyAG9qrh2XLhHPudBEh97iJbfNsjfB6jH9u9WX9m/AXuVFQ/wWBRXR6dYmiNcWXo21H62/qhvwIpjslHN4HsmFfImYl/1cp6MKUa4m6HhC5flEQJ950dOhf2sirwAJ9KPkq9kQ43n/egyid8Zuu1XdAagIdYycN3keEKeLPSHde8a2+RB/gtcD8fihKQ80x5Y/tNOTpWJSNM99fyRwMf4K2euNB0Ug52S4nIvX3hxngXdwTxSPCpjn3PWlaVj3EJu3wZntc19pF0EOIWAmzGjdKGiHZkyRvEBitNDvTWfyaSPzIDN/pcD/ABoE4x78JX7Tpz/Lsg0gjJLPRxJ+UhKfNEO0CfGASK9tXr4i6B37s+bnkViqhwQ4aZ1xlUHyiqWrKMQt7LuMePWFLwdjHOLkV8w==;5:x3qsPi7FyLQCA8aEhb6HrotN1TRkGOx744TIDQTxJdK5bkN1QfizRsS/PDvfgKeEvjLnnhclUKpSCe92qfIES5kPB6h4hcO8J8t4jjh46XTdcIZq4jQv9nSKWEg+zvZGnRceSi2zfPUnaHRFHGN5kOD5e2fHWy+3awZdbZJgjwo=;7:PDMkyJQitxWspOu2izynBDynA0R+HdbDxknZURwMHwp6PYNsGMyL1QldXKk438A157RYGAgOLjsfrOA6wcwWhupjFyP547ZYP5VmpL2pPhPBX5F/4hu5lptQpuWowzjei6pPE4K0O2e3p2m9bHyLhOM9PnW5nBF2iPj7ruVyYPeg7VZAWGmTsu3tucELFIqEMKq24RpGiGoAYsZlO+/oLXUJ8kujFf+JqqzTW1nvjZYvF8bY4/Nk3SO97SUGHE8k
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b10382fd-7179-46fa-1516-08d5ed74f82b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7193020);SRVR:SG2P15301MB0046;
x-ms-traffictypediagnostic: SG2P15301MB0046:
x-microsoft-antispam-prvs: <SG2P15301MB00463859691EEC1D7DC5892F92520@SG2P15301MB0046.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SG2P15301MB0046;BCL:0;PCL:0;RULEID:;SRVR:SG2P15301MB0046;
x-forefront-prvs: 0738AF4208
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(366004)(396003)(376002)(39860400002)(136003)(346002)(199004)(189003)(53546011)(6436002)(446003)(8676002)(26005)(11346002)(7416002)(476003)(5660300001)(6512007)(305945005)(7736002)(6506007)(31696002)(86612001)(3846002)(6116002)(68736007)(6246003)(2616005)(99286004)(106356001)(105586002)(186003)(86362001)(229853002)(6486002)(76176011)(102836004)(5250100002)(4326008)(53936002)(25786009)(486006)(22452003)(110136005)(54906003)(2906002)(1511001)(256004)(10090500001)(14444005)(316002)(36756003)(66066001)(31686004)(97736004)(81156014)(81166006)(14454004)(8936002)(10290500003)(2900100001)(72206003)(478600001)(49343001)(213903007)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P15301MB0046;H:SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PQMOfc9q0H0vnAVlnc48on3S5hgs0DEyenmXHGTFeXgQV1gQMetVyQoIsCN1TO2kyIKgFRmoDwNvdv7e1fTNwuBEhd+7rhP41qDqkV2nELLzeyBT+QWjR0OuDAEr03bREHbA+4a4v6x4aHLL9hvG5K5IDl79XGx+W6kq9lQVQRlN9J1vnSerruL7e7Bn7CTTabe4r8enM4lZu/TfyF7/HOd1eAIVZUVcAfjVzgw71WBSsNS0ZImocZ3hAVrX/IjS/8mxD0O2pZNIWYlzncSXmWv+pYXxVf/x5oAlQhiEQeGCXVSbOjWSWjzcgGBJalTKTeSe9BobXnARcaKUcKSsU7XyfK3IcdmJFtvVu2UofEQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A141DED9B7830845A5C2D49B751BF25A@APCP153.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10382fd-7179-46fa-1516-08d5ed74f82b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2018 12:41:37.3020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xOS8yMDE4IDg6MDUgUE0sIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4gT24gVGh1LCAx
OSBKdWwgMjAxOCwgVGlhbnl1IExhbiB3cm90ZToNCj4+IEBAIC0wLDAgKzEsNjQgQEANCj4+ICsv
LyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPj4gKw0KPj4gKy8qDQo+PiArICog
SHlwZXItViBuZXN0ZWQgdmlydHVhbGl6YXRpb24gY29kZS4NCj4+ICsgKg0KPj4gKyAqIENvcHly
aWdodCAoQykgMjAxOCwgTWljcm9zb2Z0LCBJbmMuDQo+PiArICoNCj4+ICsgKiBBdXRob3IgOiBM
YW4gVGlhbnl1IDxUaWFueXUuTGFuQG1pY3Jvc29mdC5jb20+DQo+PiArICoNCj4+ICsgKiBUaGlz
IHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29y
IG1vZGlmeSBpdA0KPj4gKyAqIHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVi
bGljIExpY2Vuc2UgdmVyc2lvbiAyIGFzIHB1Ymxpc2hlZA0KPj4gKyAqIGJ5IHRoZSBGcmVlIFNv
ZnR3YXJlIEZvdW5kYXRpb24uDQo+PiArICoNCj4+ICsgKiBUaGlzIHByb2dyYW0gaXMgZGlzdHJp
YnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwgYnV0DQo+PiArICogV0lU
SE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZg0K
Pj4gKyAqIE1FUkNIQU5UQUJJTElUWSBPUiBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9T
RSwgR09PRCBUSVRMRSBvcg0KPj4gKyAqIE5PTiBJTkZSSU5HRU1FTlQuICBTZWUgdGhlIEdOVSBH
ZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlDQo+PiArICogZGV0YWlscy4NCj4gDQo+IFlv
dSBhbHJlYWR5IGhhdmUgdGhlIFNQRFggaWRlbnRpZmllci4gU28gdGhlIEdQTCBib2lsZXJwbGF0
ZSBpcyBub3QgcmVhbGx5DQo+IHJlcXVpcmVkLCB1bmxlc3MgeW91ciBsZWdhbCBkZXBhcnRlbWVu
dCBpbnNpc3Qgb24gaXQuDQo+IA0KDQpIaSBUaG9tYXM6DQoJVGhhbmtzIGZvciB5b3VyIHJlbWlu
ZGVyLiBIb3cgYWJvdXQgdGhlIGZvbGxvd2luZz8NCg0KDQorLy8gU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEdQTC0yLjANCisNCisvKg0KKyAqIEh5cGVyLVYgbmVzdGVkIHZpcnR1YWxpemF0aW9u
IGNvZGUuDQorICoNCisgKiBDb3B5cmlnaHQgKEMpIDIwMTgsIE1pY3Jvc29mdCwgSW5jLg0KKyAq
DQorICogQXV0aG9yIDogTGFuIFRpYW55dSA8VGlhbnl1LkxhbkBtaWNyb3NvZnQuY29tPg0KKyAq
Lw0KDQo+IFRoYW5rcywNCj4gDQo+IAl0Z2x4DQo+IA==
