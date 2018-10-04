Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F5CC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5EED213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="O6hNj+5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5EED213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeJDQds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:33:48 -0400
Received: from mail-eopbgr730041.outbound.protection.outlook.com ([40.107.73.41]:58496
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727046AbeJDQds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDCltGPrIiGXz/x8aTDTa2jBlxreZao1ARQVwJYutYw=;
 b=O6hNj+5HKxUim+qLoOOwuYTohEWnX2I6/Gz0qEX5U5cYdf2y10f3I1UmXIvgY+ONZ4BuvBbPjqyQlA6Ick9qq6D5DPaqsN1ewgKD40dPzh2Ul1msenw30Z9S6WlaoV0fh8KRiPl1BsR5v3VcaQLr7P5cd041gI5pCydDXVEciiA=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4693.namprd05.prod.outlook.com (52.135.233.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.11; Thu, 4 Oct 2018 09:41:16 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%3]) with mapi id 15.20.1207.018; Thu, 4 Oct 2018
 09:41:16 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC] x86/cpu_entry_area: move part of it back to fixmap
Thread-Topic: [RFC] x86/cpu_entry_area: move part of it back to fixmap
Thread-Index: AQHUW5+DYNLMbTMpOU+l0vSyUa8/DKUOsumAgAAinQA=
Date:   Thu, 4 Oct 2018 09:41:15 +0000
Message-ID: <6C089922-C70D-4FF3-9B80-1F21FA80B175@vmware.com>
References: <20181004045948.129142-1-namit@vmware.com>
 <20181004073719.GD19272@hirez.programming.kicks-ass.net>
In-Reply-To: <20181004073719.GD19272@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4693;20:qpOSj3CjDEO/gDsYqEoycFfrbdbQh6cjWLMn8gapAGl21yxxM+CuyyJZrq5LUeJ17BwzvwdLs5u1Rxls8joJ/6Rk7o7UAD5Q9iBI4G+pJXXpyQ0kPgWDTzApirWulXOLBTwsPDXXkgCV05lSoYzxKrIHbfl5uP6EwCLIwwedSD0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0dcf135d-2a42-4ccc-f43d-08d629dd87b4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4693;
x-ms-traffictypediagnostic: BYAPR05MB4693:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB46930B613647A7553CA8DC29D0EA0@BYAPR05MB4693.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051);SRVR:BYAPR05MB4693;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4693;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(376002)(346002)(39860400002)(189003)(199004)(256004)(81156014)(25786009)(4326008)(5660300001)(186003)(5250100002)(54906003)(68736007)(6916009)(76176011)(486006)(7736002)(83716004)(6116002)(305945005)(14454004)(99286004)(2616005)(33656002)(476003)(11346002)(8936002)(446003)(478600001)(82746002)(2900100001)(81166006)(316002)(6506007)(8676002)(71190400001)(53936002)(6246003)(26005)(6486002)(36756003)(86362001)(3846002)(102836004)(6512007)(106356001)(97736004)(105586002)(229853002)(6436002)(71200400001)(2906002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4693;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Bv93JcmL58i1AotX/ZDeLnCf3xEzZ8/PN1bKmgJpPjUVX/B2hOZTKgnqgR/OxsvYGjlKUHIoMzaj1DBlnuLd/BkYZi4XBBGytmYBG8XwP3efuw25VGQurVeFBHXOl5vtRAnXzFAKTp7eSvmwBxmviqequKYjPLfkM+ugilA4GTP6xxaAcGjN3gn5i+Xf9lg32fBSOB/Ajph14NHhYyPP81c+r6D2wc1lrJF1jOqm1AfwFlLufEPptgqs9qt6pv1w6lBFL/YqBphDyIuWouuZE8CpWTEz12QX00txmS8JkqukK0AT3cS3ZqXp8IqCGnBp59ZdjUGDAr8HS2KG3NNelEPOqVX9N/u7g8WPdopvv6U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B43753AAF002F9449908A2C081D53A73@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcf135d-2a42-4ccc-f43d-08d629dd87b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 09:41:15.8766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4693
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgMTI6MzcgQU0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4gd3JvdGU6
DQoNCj4gT24gV2VkLCBPY3QgMDMsIDIwMTggYXQgMDk6NTk6NDhQTSAtMDcwMCwgTmFkYXYgQW1p
dCB3cm90ZToNCj4+IFRoaXMgcGF0Y2ggcHJvcG9zZXMgdG8gZG8gc29tZXRoaW5nIGRpZmZlcmVu
dDogYnJlYWsNCj4+IGl0IGludG8gdHdvLiBPbmUgcGFydCBob2xkcyBjb2RlK2RhdGEgdGhhdCBp
cyBuZWVkZWQgZm9yIHRoZSBlbnRyeQ0KPj4gKHRyYW1wb2xpbmUgY29kZSwgZW50cnkgc3RhY2sg
YW5kIFRTUyksIHdoaWNoIGlzIG1hcHBlZCBpbiB0aGUgZml4bWFwLg0KPiANCj4+IFRoZSBvdGhl
ciBwYXJ0IGhvbGRzIHRoZSBleGNlcHRpb25fc3RhY2tzLCBkZWJ1ZyBzdG9yZSBhbmQgYnVmZmVy
cywgYW5kDQo+PiBpcyBsZWZ0IGluIGl0cyBjdXJyZW50IChuZXcpIHBvc2l0aW9uLg0KPiANCj4+
IFRoZSBuYW1lDQo+PiAiY3B1X2VudHJ5X2FyZWFfYXV4IiBmb3IgdGhlIHNlY29uZCBhcmVhIGlz
IGF3ZnVsIChpZGVhcyBhcmUgd2VsY29tZWQpLA0KPiANCj4gSG93IGFib3V0OiBjcHVfZGF0YV9h
cmVhID8gU2luY2Ugbm9uZSBvZiB0aGF0IGlzIHJlcXVpcmVkIGZvciB0aGUgZW50cnksDQo+IHRo
YXQgc2hvdWxkIGFsc28gbm90IGJlIHBhcnQgb2YgaXRzIG5hbWUuDQoNCknigJltIGZpbmUgd2l0
aCB5b3VyIG5hbWUuIEJ1dCBJIHdhbnQgdG8ga25vdyB3aGV0aGVyIHRoZSBzb2x1dGlvbiBpbiBn
ZW5lcmFsDQppcyBhY2NlcHRhYmxlLg0KDQo=
