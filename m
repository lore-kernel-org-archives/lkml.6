Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1EFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9262086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="LAQ4UjRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D9262086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbeJKFqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 01:46:06 -0400
Received: from mail-eopbgr700109.outbound.protection.outlook.com ([40.107.70.109]:58454
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725968AbeJKFqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 01:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBuO4IpcE9ALvtn6NVsyT0xFkdgsWXdNnw4rH3x4oPE=;
 b=LAQ4UjRU7WFlN4ZAO7ZzLP6JS9SZX8jRm9vslV4W39TivftnDPl5/T0njweiot1dAH0kaF/1evG88toQjK6gEeyRDQ5zI6YWJbv/Stk8wnp4TwjW0d63YkLuZB8kxuaUTmqeD3iTvfjq/vw09+P0mq7tSWWXz5DGgD09HLYbsMk=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3723.namprd06.prod.outlook.com (10.167.236.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Wed, 10 Oct 2018 22:21:52 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f4ee:3633:74c0:ab4]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f4ee:3633:74c0:ab4%3]) with mapi id 15.20.1228.020; Wed, 10 Oct 2018
 22:21:51 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "talel@amazon.com" <talel@amazon.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "barakw@amazon.com" <barakw@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>
Subject: Re: [PATCH 1/2] dt-bindings: spi: dw: add cs-override property
Thread-Topic: [PATCH 1/2] dt-bindings: spi: dw: add cs-override property
Thread-Index: AQHUYGgRyN3gGcSYHUSF2EMwZYIPcqUZDniA
Date:   Wed, 10 Oct 2018 22:21:51 +0000
Message-ID: <1539210111.1944.31.camel@impinj.com>
References: <1539155293-21750-1-git-send-email-talel@amazon.com>
In-Reply-To: <1539155293-21750-1-git-send-email-talel@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3723;6:LljaAHtSdYrFK0Xl5iqzz5CZRZEbra/FoMt6Qdh2z+pYzlUuvy5B06d1UCDoETjmtdkpiDGLo0/mSCE+GmcFv77YeXpUvL/d3Kiv3hTC3xUzHgh4o3rRlkW7QmZ7LXk+V8aj5uQgu+Qy2t1sV22YRMzx3/Q1hAx6WaTR/qzM3DjcMZ/TPynj0QXC2kGPlOJcxaTjRqMQA87Wuy+/Fd5fmVCfRXbTVlvwIPUn95XkwSbUmUm3ClUN3sn2E6u9WVb+OJ/V3XMXpf2WUl0GxgWHKMIQoWEwM4/apX5h0u6F12AMXg4iGhEoB9WxBzDyqKK7PtXINfz2aH42lfCW/iVyu7cIQQh5IVxLxV4o5jTYgWubzGEG84q9jNcGLat/EsQSRhMwQhXMgmcnZw53nQxnPY0B2e6KqnzOE/bfUh1fimAoNtYoi1FDUsiZe9X/Q3VIPGpZRJiFgg7cHYXdcVuOCg==;5:cmZfp/A1GT71M6J4+RAnN71A/bx00nN5TjjB6OVeN0qj6kh6aGU9ASjxdt+8yfcTNOuwMNbumMxeIvS5Rv+RWxI6IrIn1+5eCfZAKsKAm7a0knGzjl/b6YipI2jJ6Z9V42+ImF0meZjVWSD9CwVYCh3UFvtru3SXgo7JLX8r8to=;7:ehoqMyQKmpQhVgc3R0tlIgYojYn/2issAw+7m69jaG4VI3XMom6yoBsk1wwxyhFDFV7eWyLuFqShkwavVs2jLMESShxQWupJPqDHaDnh4BN95dRzMEMhYht4xbxPV70Jr/TLrzUE7m2EcLps9GpFG6uOGjSwoOihuXl69XT0yhNAtwaY46MlylMwzyF1kGlNBKRB6K2GhfIAY8GDu5bBfPG6gL7FiVVeIAVSmSrFhInCPzDgPJacxY4pvEN1AMnm
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e8c9de71-3e82-452f-3ab4-08d62efec74b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3723;
x-ms-traffictypediagnostic: MWHPR0601MB3723:
x-microsoft-antispam-prvs: <MWHPR0601MB3723F61A54B1E43178BF14C4D3E00@MWHPR0601MB3723.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051);SRVR:MWHPR0601MB3723;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3723;
x-forefront-prvs: 08213D42D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39850400004)(376002)(346002)(366004)(199004)(189003)(486006)(99286004)(76176011)(71200400001)(71190400001)(81166006)(110136005)(2906002)(8936002)(36756003)(478600001)(66066001)(81156014)(8676002)(26005)(5250100002)(6116002)(102836004)(2616005)(4001150100001)(6506007)(97736004)(11346002)(2501003)(3846002)(476003)(186003)(106356001)(105586002)(446003)(5660300001)(2900100001)(54906003)(7416002)(4326008)(14454004)(316002)(6486002)(6436002)(68736007)(53936002)(6512007)(25786009)(6246003)(86362001)(551934003)(305945005)(229853002)(256004)(7736002)(103116003)(2201001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3723;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6d4Isim0GQRDTZRZzi4EtpP/baY/HgsTS5GdsSNTos5YUxc2lebs+pODuVxWMh8BcXXDuk0UHl4HEZCJlUtVhq2B6h4Lyu9DAgv4wdKL/jt+9xp9gzTc78oJvzfjG/4Pu3f8iErxsH9/ytG05iqiIFVFi2yzar9kx5O1FoJeQU37tMkbdPp8Op1trbGmkNQNva7mLytoBfolbQZHAbFsATtMhlORr/W2nM19aefyWB6koKKpEyjDAtO3Bam/g1rp7IAvK/VDQmsktOVv0eFJcyhQcecnh7DHbpmpqnuytrH3B29qXmEcKXu15qbB9OTGSPxHx9bApoyjBqokyAvF5NjJxldcNfKrEmZ8FEZDMgg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C564B8A5DB5DBB4DB515378484B10B30@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c9de71-3e82-452f-3ab4-08d62efec74b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 22:21:51.8630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3723
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTEwLTEwIGF0IDEwOjA4ICswMzAwLCBUYWxlbCBTaGVuaGFyIHdyb3RlOg0K
PiANCj4gVGhlIGR3IHNwaSBjb250cm9sbGVyIGhhcyBhbiBhdXRvLWRlc2VsZWN0IG9mIENoaXAt
U2VsZWN0LCBpbiBjYXNlIHRoZXJlIGlzDQo+IG5vIGRhdGEgaW5zaWRlIHRoZSBUeCBGSUZPLiBX
aGlsZSB3b3JraW5nIG9uIHBsYXRmb3JtcyB3aXRoIEFscGluZSBjaGlwcywNCj4gYXV0by1kZXNl
bGVjdCBtb2RlIGNhdXNlcyBhbiBpc3N1ZSBmb3Igc29tZSBzcGkgZGV2aWNlcyB0aGF0IGNhbid0
IGhhbmRsZQ0KPiB0aGUgQ2hpcC1TZWxlY3QgZGVzZWxlY3QgaW4gdGhlIG1pZGRsZSBvZiBhIHRy
YW5zYWN0aW9uLiBJdCBpcyBhIG5vcm1hbA0KPiBiZWhhdmlvciBmb3IgYSBUeCBGSUZPIHRvIGJl
IGVtcHR5IGluIHRoZSBtaWRkbGUgb2YgYSB0cmFuc2FjdGlvbiwgZHVlIHRvDQo+IA0KDQpTbyB0
aGF0J3MgdGhlIHByb2JsZW0hICBJLCBsaWtlIGV2ZXJ5b25lIGVsc2UgSSBzdXNwZWN0LCBzd2l0
Y2hlZCB0bw0KdXNpbmcgR1BJTyBjaGlwIHNlbGVjdHMgd2l0aCB0aGlzIGRyaXZlciBiZWNhdXNl
IG9mIHRoaXMuICBJIG5hcnJvd2VkDQppdCBkb3duIHRvIGEgQ1MgZGUtYXNzZXJ0IHdoZW4gdGhl
IGJ1cyBzd2l0Y2hlZCBmcm9tIFRYIHRvIFJYLCB3aGljaCBvZg0KY291cnNlIG1ha2VzIGEgU1BJ
IHJlZ2lzdGVyIHJlYWQgZmFpbCBvbiBtb3N0IGRldmljZXMuICBUaGUgVFggRklGTw0Kd291bGQg
ZW1wdHkgYXQgdGhpcyBwb2ludCwgc28gdGhhdCB3b3VsZCBleHBsYWluIGl0Lg0KDQpEaWQgdGhl
IGRlc2lnbmVycyBvZiB0aGlzIElQIGV2ZXIgcmVhZCBhIFNQSSBkZXZpY2UgZGF0YXNoZWV0Pz8/
DQoNCkdvdCB0byBhZ3JlZSB3aXRoIE1hcmsgQnJvd24sIHdoeSB3b3VsZCBhbnlvbmUgZXZlciB3
YW50IHRvIE5PVCBoYXZlIGl0DQp3b3JrIHByb3Blcmx5PyAgVGhlIHByZXZpb3VzIGJlaGF2aW9y
IGlzIG5vdCAiYWx0ZXJuYXRlIGNvcnJlY3QiLCBpdCdzDQpCcm9rZW4u
