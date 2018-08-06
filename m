Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9C2C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF40B20897
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="zDY/gUbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF40B20897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbeHFQHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:07:49 -0400
Received: from mail-co1nam03on0079.outbound.protection.outlook.com ([104.47.40.79]:17834
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727582AbeHFQHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXRIq7Zwxf88ZyE3IChnUEJPVA6U7hgRPu0UsTho3Cg=;
 b=zDY/gUbJ9nwh/pVumOtin5Li/PoSPlRm4vkygoMNni92L4EhR7n0U6dzZJEWVPD1az1GbRZyewaW5iUDxRDMfP09nRvb7Nl+L7F3ANRguzOz5FM4wili9BsQQPbGvfkehfILAMbCnLUjXlh6Sq61F7STxmA5xm8lm+NtqpZ7ySk=
Received: from SN6PR02MB4959.namprd02.prod.outlook.com (52.135.116.89) by
 SN6PR02MB4302.namprd02.prod.outlook.com (52.135.119.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 13:58:27 +0000
Received: from SN6PR02MB4959.namprd02.prod.outlook.com
 ([fe80::fda4:6729:248f:71c7]) by SN6PR02MB4959.namprd02.prod.outlook.com
 ([fe80::fda4:6729:248f:71c7%5]) with mapi id 15.20.1017.019; Mon, 6 Aug 2018
 13:58:27 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Michal Simek <michals@xilinx.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        Edgar Iglesias <edgari@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        "stefan.krsmanovic@aggios.com" <stefan.krsmanovic@aggios.com>,
        Srinivas Goud <sgoud@xilinx.com>,
        Anirudha Sarangi <anirudh@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH v4 0/4] EDAC: Enhancements to Synopsys EDAC driver
Thread-Topic: [PATCH v4 0/4] EDAC: Enhancements to Synopsys EDAC driver
Thread-Index: AQHUK9UqHWFNAXIO8kCgNLu95vNLj6Svyc8AgAL4ejA=
Date:   Mon, 6 Aug 2018 13:58:27 +0000
Message-ID: <SN6PR02MB4959577EB1CE589F980E6A43C1200@SN6PR02MB4959.namprd02.prod.outlook.com>
References: <1533374735-16662-1-git-send-email-manish.narani@xilinx.com>
 <20180804163230.GA8157@nazgul.tnic>
In-Reply-To: <20180804163230.GA8157@nazgul.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR02MB4302;6:Y80Hnhl67qmr7rf7e0VhWo7AuxxsqhOlUPfXqTHQpGXZT0tUKa1o4aS96QcNok/c8+OsW1FSK7bHkQYcChKnW1gyn2mGkVycvGiKznEcVjja8AknRs6Vr5mQ5oyobY0+McUKAyXCJW/x9vG5HPvSJvGq6FdCOduKk9WECovNLWyHcefCxH8VIM1sTi2Tu6t4TDsa3065czMV4YHSoeZpBRYM/ejBCYN3GLRX+FKUuzuRlyLzH885ZUmYgPcsnrVPnpFWvdDdxr9yG1laEPPx9Pdk2ilZ6dj3z3dgw+2FYpMv2sj+cYNs7Fi8dguEGf11ZZ5hRHIdaQSBwAe2qzQj+GiMjP5tP8tFPy5c9Ik/EkvlDCYbVxB2QfIJuYkyzidVMym+OUjhM+oH9oLJL7PwKqC8Fad/w9aI/tRS1Z4B1AbIhfHpoJCMFFXr2cxIwloNPnZYTVH8sUXINKcPOTNHyQ==;5:96R2F7+Kg6VjTlb++nnm2osddt3uKCzMGd3Z07BEcxKP/1EJDIaUXH60O10kTKwC0YoVqAbBeOEjFIsftH0Oo48C/bZLZE5n0g2eGlBR9O6kkQBO1mv3PFpU/Q5GXln38SNS6IZ4KOuFoe204V+wzXV1cGYs8lERFHsQkwRTdZM=;7:ufvMVeyvGLmlnzXsvH81SEfJrn++eooCI9tU3S0nEmOXj7DPd2EfnBrKUjtbkKo3QLqBztnFvh+Kr7GLYZPfAHkDBkhRJjrItEhpIXVA2MYVelDFWayZ6ZdwDB1d/16LvZudCHXjGsEUyUnNk6ocVNUgp103OfCnCe08V7OD0GERecbFFqYAETdet1I77q2GsQaC+4KTiMyG/qp8M7dWv5AC369xseK+zJNDz8N0P11lEOLry0PxGr8m44jZV+zr
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: ca083b8d-1e09-4cfc-b8b1-08d5fba4af5b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR02MB4302;
x-ms-traffictypediagnostic: SN6PR02MB4302:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SN6PR02MB4302108237023640389B02D5C1200@SN6PR02MB4302.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:SN6PR02MB4302;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4302;
x-forefront-prvs: 07562C22DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(13464003)(51914003)(305945005)(486006)(76176011)(6246003)(74316002)(7736002)(14454004)(86362001)(2906002)(6116002)(81156014)(81166006)(3846002)(478600001)(8676002)(106356001)(7416002)(476003)(316002)(7696005)(54906003)(97736004)(5250100002)(9686003)(229853002)(53936002)(68736007)(4326008)(105586002)(256004)(11346002)(8936002)(26005)(186003)(66066001)(5660300001)(6916009)(72206003)(99286004)(102836004)(53546011)(6506007)(6436002)(55016002)(33656002)(2900100001)(446003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4302;H:SN6PR02MB4959.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4d2tJ5ZpskPsh838RUPnteYdIbTm7x5c0j04lg/kuBM9VwOva9HZDqdkM1j1vBRHz68kuAFpHwu9zAsOblDclqM9nHWd3jMmw6SXAtnJmNRc2TPkBgcDqaVgHUjAUxSEMkTcZYPdBH7iI18j2GzyVN5tGcP8YCAdJOOmNupBmozjEUUoXJ+EH19qN1I1UgNYK6km3Tv+kkeL/0eNvdRnIwINWaxb/u5XQGhHAWmg1vHnVAl/8v7YroOhQu6HhqNgLHdakR8JRyG7Qn1yUUQ3TUa3NbyYpTi1i8rTFbegcHnjS1vogW4MqJY0LJu4CnnSAk3RvMpYAr48cXTbNb4i1Rr4r0qW0hZ3rrUHWm86PCg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca083b8d-1e09-4cfc-b8b1-08d5fba4af5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2018 13:58:27.6104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4302
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXMsDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jp
c2xhdiBQZXRrb3YgW21haWx0bzpicEBhbGllbjguZGVdDQo+IFNlbnQ6IFNhdHVyZGF5LCBBdWd1
c3QgNCwgMjAxOCAxMDowMyBQTQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDAvNF0gRURBQzog
RW5oYW5jZW1lbnRzIHRvIFN5bm9wc3lzIEVEQUMgZHJpdmVyDQo+IA0KPiBPbiBTYXQsIEF1ZyAw
NCwgMjAxOCBhdCAwMjo1NTozMVBNICswNTMwLCBNYW5pc2ggTmFyYW5pIHdyb3RlOg0KPiA+IFRo
aXMgcGF0Y2ggc2VyaWVzIGVuaGFuY2VzIHRoZSBjdXJyZW50IEVEQUMgZHJpdmVyIHRvIHN1cHBv
cnQNCj4gPiBkaWZmZXJlbnQNCj4gDQo+IFRoaXMgb25lLCB5b3VyIDIvNCBhbmQgNC80IHN0aWxs
IHNheXMgInRoaXMgcGF0Y2giLiBIdXJyaWVkIHRvbyBtdWNoPw0KPiBIb3cgYWJvdXQgc2xvd2lu
ZyBkb3duIGFuZCBsb29raW5nIGF0IHRoZW0gd2l0aCBhIGNyaXRpY2FsIGV5ZT8NCj4gDQo+IEFs
c28sIGhvdyBhYm91dCB3YWl0aW5nIGZvciBhIHdlZWsgYmVmb3JlIHJlc2VuZGluZyB5b3VyIHBh
dGNoZXMgc28gdGhhdCB5b3UNCj4gZ2l2ZSBwZW9wbGUgY2hhbmNlIHRvIHJldmlldyB0aGVtIHRv
bz8NCj4gDQo+IFdoaWxlIHlvdSB3YWl0LCBwbGVhc2UgcmVhZCBEb2N1bWVudGF0aW9uL3Byb2Nl
c3Mvc3VibWl0dGluZy1wYXRjaGVzLnJzdA0KPiAtIGl0J2xsIGhlbHAgeW91IHdpdGggdGhlIHN1
Ym1pc3Npb24gbW9kYWxpdGllcy4NCg0KWWVzLCBJIG1pc3NlZCBpdC4gU29ycnkgZm9yIHRoYXQu
IEkgd2lsbCBzdXJlbHkgd2FpdCBmb3IgYXJvdW5kIGEgd2VlayBmb3Igb3RoZXJzIHRvIHJldmll
dy4NClRoYW5rcyBmb3IgdGhlIGd1aWRhbmNlLg0KDQpUaGFua3MsDQpNYW5pc2ggTmFyYW5pDQo=
