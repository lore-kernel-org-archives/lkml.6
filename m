Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521496227-2-14207505128851823278
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521496226; b=KTtnIAVceLR6NrnVrN8i70iUlUFpTOZLFme4u4n0PHWTasY
    8LR4KxHNgXuXUbV2kTJSI0A1ZQjtoQyMpH35/aRPWkO6ix1Td7xL3hYTel/EM5TG
    Zh1ETtsRloyY6egmSnCx03Qexn7CRTwOm/ShNhUot9eNlbsE6QALr0kqgf/Fwseh
    8ZWBOOrTE/oLtkY59hdy7jgk5Dc8qqU8je3tjyay2c7fLfTE14BclnR6gcm5Rkbs
    8hM/HGkSj3TWWr6Tj6WyBCth5ZqkkorM/Op3TzHg7NIN6pmBP4uZhozVznMNqrgA
    i8ThwHO4f6BDYOhv559kGkzxlr0M52JCZ3Lysnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521496226; bh=DwADBzTfDHZJv/JXays35+gaI9Om8pX0yL4sKn
    I1hbY=; b=ACB1KINpEdtEtMdOA1jeg/rjS33NqQ3Kuw8S0F7xrB3+7fUHdH0RGF
    D7NqkEiasZ4cBqXjehDpOVEmmbM/Tg2EeP2mrD6AYwNrPLXDP0NVq6kdMcK1xScv
    Aad+qDzCbcnhcmFK3dN6oAwT8fxzF0+fDpSzpi4zMQHywNerzQMNNdEsgWgUsOcg
    iAgyEWRf+vA2WogPlfsrvU1LUbA4i84e9l9JcuekrTBtIPPyRLrdFR3rTxiTxaG1
    B6mxwXE3ak21TjDwpq4o08qd5PUFLmvvorDYqBRPN3iag+jdBzZZyG281KfN3lrl
    RnkGjvzfJeiozQMxdAqjsNw7uchQtcnQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fEOYw9AG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeegkeefnecuvehluhhsthgvrhfuihiivgepvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fEOYw9AG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeegkeefnecuvehluhhsthgvrhfuihiivgepvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964927AbeCSVt6 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:49:58 -0400
Received: from mail-co1nam03on0113.outbound.protection.outlook.com ([104.47.40.113]:13408
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964908AbeCSP6J (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:58:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kees Cook <keescook@chromium.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 009/281] x86/boot: Declare error() as noreturn
Thread-Topic: [PATCH AUTOSEL for 4.9 009/281] x86/boot: Declare error() as
 noreturn
Thread-Index: AQHTv5sO3cYno7GaXEuU4I8IqnGUrw==
Date: Mon, 19 Mar 2018 15:58:00 +0000
Message-ID: <20180319155742.13731-9-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:s0+j4Ejdya/Vfy0u15/nG1PMVuvZUjaueDqXr9Jpt9L9K+M5nY4BiX+I2ZT2kgBENmkjAXI4FymKS+2Kdr+fcWXYIod099z6wC5e1boM+laAh+DS2gbraPeXwsoidFoa3CbKaVRJsB6FrdGCCAHkEeik0tSj2OTasrtbWDJMRoAvPfTRfXcTAuFi2QvqhSxuBP7kIVxdj/tPCtxbVnkFwOA0drbBoXiXMoGeUPAtoBaMFuC4fLkWU+UJBUa9Jqrm;20:O+iiNGmKCI8irfmJKHiXEAYF9TqOUUDjevMOypvIRoUsXMmhkgSSfjjchKxCC6jlf31e232XAa9WgZCy8XSrBv/q+pgo6CbWZv7UAYjuqfLgbd2TWDMyXc5hcg8DNqL3QPjr70/IIs/nTgnML/8YJ6iOVmwzi0dQgrVkQXVgKbw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6cdfac8d-989e-4611-75e6-08d58db230b7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB0933BFE7E9DF1E7538A80207FBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(72206003)(1076002)(66066001)(10290500003)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6346003)(102836004)(22452003)(86612001)(3660700001)(186003)(966005)(2900100001)(25786009)(478600001)(5250100002)(26005)(39060400002)(6486002)(6436002)(6306002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(54906003)(8676002)(107886003)(316002)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: NlqcmWPBrDeKJUwcbbHtwgrVA9S5V195LvQSMH8UEJS1riL/1EehuruqtfiquvPOHF4PLv9Y3yTwbwRRvdRQRA5CrDxCcAJlh9EHBkSwIPr3rG/S4QBAcBQqwVXHovj1rG8uQViwCGX2l/KWwVY9wG4ZBxuw4uGaaBdtX8I7C++8b33Ng1TZEnatqZCfclU3uWJ0uBQBgQrUufXL6NBa4pC3u8u/esJwJypTs0tA27Xt+ZjFndVEXYKVkgwMibsrVG4WY3hXkmjIMJMTG8v3nH+y3XI3mOW8JBfnbtGSi12NYtyCRMBoNQnLQaTAL25UVD1QKsS3VUE9I6ScsCMLTw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E522110095929C41A19FF40B2DABFC35@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cdfac8d-989e-4611-75e6-08d58db230b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:00.2486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+DQoNClsgVXBzdHJlYW0gY29t
bWl0IDYwODU0YTEyZDI4MWUyZmEyNTY2MmZhMzJhYzgwMjJiYmZmMTc0MzIgXQ0KDQpUaGUgY29t
cHJlc3NlZCBib290IGZ1bmN0aW9uIGVycm9yKCkgaXMgdXNlZCB0byBoYWx0IGV4ZWN1dGlvbiwg
YnV0IGl0DQp3YXNuJ3QgbWFya2VkIHdpdGggIm5vcmV0dXJuIi4gVGhpcyBmaXhlcyB0aGF0IGlu
IHByZXBhcmF0aW9uIGZvcg0Kc3VwcG9ydGluZyBrZXJuZWwgRk9SVElGWV9TT1VSQ0UsIHdoaWNo
IHVzZXMgdGhlIG5vcmV0dXJuIGFubm90YXRpb24NCm9uIHBhbmljLCBhbmQgY2FsbHMgZXJyb3Io
KS4gR0NDIHdvdWxkIHdhcm4gYWJvdXQgYSBub3JldHVybiBmdW5jdGlvbg0KY2FsbGluZyBhIG5v
bi1ub3JldHVybiBmdW5jdGlvbjoNCg0KICBhcmNoL3g4Ni9ib290L2NvbXByZXNzZWQvbWlzYy5j
OiBJbiBmdW5jdGlvbiDigJhmb3J0aWZ5X3Bhbmlj4oCZOg0KICBhcmNoL3g4Ni9ib290L2NvbXBy
ZXNzZWQvbWlzYy5jOjQxNjoxOiB3YXJuaW5nOiDigJhub3JldHVybuKAmSBmdW5jdGlvbiBkb2Vz
IHJldHVybg0KICAgfQ0KIF4NCg0KU2lnbmVkLW9mZi1ieTogS2VlcyBDb29rIDxrZWVzY29va0Bj
aHJvbWl1bS5vcmc+DQpDYzogRGFuaWVsIE1pY2F5IDxkYW5pZWxtaWNheUBnbWFpbC5jb20+DQpD
YzogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KQ2M6IFBl
dGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4NCkNjOiBUaG9tYXMgR2xlaXhuZXIg
PHRnbHhAbGludXRyb25peC5kZT4NCkNjOiBILiBQZXRlciBBbnZpbiA8aHBhQHp5dG9yLmNvbT4N
Ckxpbms6IGh0dHA6Ly9sa21sLmtlcm5lbC5vcmcvci8yMDE3MDUwNjA0NTExNi5HQTI4NzlAYmVh
c3QNClNpZ25lZC1vZmYtYnk6IEluZ28gTW9sbmFyIDxtaW5nb0BrZXJuZWwub3JnPg0KU2lnbmVk
LW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0t
DQogYXJjaC94ODYvYm9vdC9jb21wcmVzc2VkL2Vycm9yLmggfCA0ICsrKy0NCiAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9ib290L2NvbXByZXNzZWQvZXJyb3IuaCBiL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9l
cnJvci5oDQppbmRleCAyZTU5ZGFjMDdmOWUuLmQ3MzJlNjA4ZTNhZiAxMDA2NDQNCi0tLSBhL2Fy
Y2gveDg2L2Jvb3QvY29tcHJlc3NlZC9lcnJvci5oDQorKysgYi9hcmNoL3g4Ni9ib290L2NvbXBy
ZXNzZWQvZXJyb3IuaA0KQEAgLTEsNyArMSw5IEBADQogI2lmbmRlZiBCT09UX0NPTVBSRVNTRURf
RVJST1JfSA0KICNkZWZpbmUgQk9PVF9DT01QUkVTU0VEX0VSUk9SX0gNCiANCisjaW5jbHVkZSA8
bGludXgvY29tcGlsZXIuaD4NCisNCiB2b2lkIHdhcm4oY2hhciAqbSk7DQotdm9pZCBlcnJvcihj
aGFyICptKTsNCit2b2lkIGVycm9yKGNoYXIgKm0pIF9fbm9yZXR1cm47DQogDQogI2VuZGlmIC8q
IEJPT1RfQ09NUFJFU1NFRF9FUlJPUl9IICovDQotLSANCjIuMTQuMQ0K
