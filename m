Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1C5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CB7222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="YaiZCa5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbfBOT3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:29:19 -0500
Received: from mail-eopbgr80128.outbound.protection.outlook.com ([40.107.8.128]:51777
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726010AbfBOT3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:29:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiV//4IwR4F+wt7RedPOJIClQoACca/kXrQErdLcEs0=;
 b=YaiZCa5zq/StvBlnr0NLR80/02sS2iJ+7FvUcW0XK4+1ynstGWcWsmGge1U41hbuyTf6YfSgX8PjOjKcdHlEBt/BINoYOSJMtvFsSUlGqszjsNEwVPg7vhx01ocP/52cPiTSHb6pJATjKx+lTf6ihWYT3oy5k+quBtBThI6UD6o=
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com (52.133.6.141) by
 HE1PR0702MB3675.eurprd07.prod.outlook.com (52.133.6.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.9; Fri, 15 Feb 2019 19:29:13 +0000
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128]) by HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128%6]) with mapi id 15.20.1622.016; Fri, 15 Feb 2019
 19:29:13 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>
Subject: /proc/sys/kernel/sched_domain/, isolcpus, CONFIG_CPUMASK_OFFSTACK
Thread-Topic: /proc/sys/kernel/sched_domain/, isolcpus,
 CONFIG_CPUMASK_OFFSTACK
Thread-Index: AQHUxWS7MRAshjLOG0SbueLnNFm6EA==
Date:   Fri, 15 Feb 2019 19:29:13 +0000
Message-ID: <68662179f21de176e3d8909ddab6bb15a2e23a09.camel@nokia.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
x-originating-ip: [131.228.2.16]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1881a137-0884-4655-888a-08d6937bde23
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:HE1PR0702MB3675;
x-ms-traffictypediagnostic: HE1PR0702MB3675:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtIRTFQUjA3MDJNQjM2NzU7MjM6OG9JSGxQckkrRkQ0ck1GVlBVejJxeEkw?=
 =?utf-8?B?aXM4cTRqYW1tMzMrak4ycGVHVXFqOUkxbmNpd0lJVFhzRFQ2VTk3RWV0ejFB?=
 =?utf-8?B?N08vTHMwYXVGbEFwRlpzUlRJN3hrVGdZdnFKN2RXbk9JSjZkL1ZOSmoyTkps?=
 =?utf-8?B?cERsMWRmQWQ3cThka2w1NzBidHRDRVJ4RzNUUXBDcHNWQXlQbFVYT1Jwc1Fn?=
 =?utf-8?B?Z1FMMXBMYURWK3E0bGN3RFkvVHFHNDcvTG5VM01ncElqL1l2NEF4Z3NRQVhG?=
 =?utf-8?B?ejgvbWhsYVpUa1cxYzhrM3MyZHdyN1ZDVUVjUk9teVU3WjR2UWtRSmdCK2Fw?=
 =?utf-8?B?ekMzQ2Q4eTdPTmFVNGs4MW1ZWVNnMTJ3Q1pyeC9XMkpDOGl4ZCtGRksyMkQv?=
 =?utf-8?B?RnNsdWdFeGc1MG5LMmhoeWdlSVhMSXBVS05XbDVhUUNSa1NJcmY2ZitNL1FI?=
 =?utf-8?B?akRyVE9wb1dHSWFNallKT01keXVtR2NydlJ3RFV4OW5wTUd0aDlsQ1ptOHdl?=
 =?utf-8?B?THp1NytlOFMzWjJwTDl1QStTYzA1eWttYmUzaHFpRGxTV1NRUUhxS3cxZGJw?=
 =?utf-8?B?WGZHd2lEKzUzMzFuRVFqSWdSUkM0b2JNYStYZWRrOTFIZzVtNzVBSnp2WEdz?=
 =?utf-8?B?R3hmNFlLZVU5Rm9UbEJBNXdrdW5TOVJuWWc0eE84S3Y0Wkh0dDNuTTU5aDlT?=
 =?utf-8?B?Q2tNa3liMjA5Y1F4Y2FZdlNkYW1sb1hUY21sOU1uZ0RJRHpDZGJzNXJNWVFk?=
 =?utf-8?B?RDdLMDNPSzFQR005STRMSHJTUklYMVA5amRyYTF6Nmo5UGd1QjJCVUNvYTJI?=
 =?utf-8?B?aTlDK0YxVzBNSFJka0RqMlI3T213MTV0NjlJcEVoYkRjbnpuUTZTWTM1NTFq?=
 =?utf-8?B?WUhpN2JaaHZ4S1Y1Tis3NjgyNEo2ZTVrRG9RSG9ZWUVleUZIL3VhRnA5Zno4?=
 =?utf-8?B?ZFkzVVFBRWk3VGpLcENzZEJVY1pEQlpNL054YmlnK0c5MkRZTkl1SnpvQWVx?=
 =?utf-8?B?TldySVd2VUpMUmNsUXY4NStsOXhud3pDdlB2MmdEL2hZM2F3T3BsQnRTNy94?=
 =?utf-8?B?OXN5UVVSdDN6cFozbjQ2Y1hQdkI4bGlIajRBUGJNN2VwekxjcW4xbzNvOGZL?=
 =?utf-8?B?bGs1ZHBNa1M2YkwvQkxlaEtQTXNyR1hCSDAybGp3bGZ1djRiZFEyWmlxbkZn?=
 =?utf-8?B?anlUYnl3Rlc1TGR5eHlQcUR2cmFTMERKRDZLdUQvWHhDQlZyMnFqand4bzl6?=
 =?utf-8?B?SWRsdkh6aGVzQ2NZZnhlY24yUjU4bC91TVNlbk9yU2RHVWNOd3EzS3VZMGcx?=
 =?utf-8?B?RmI0dE9UTXl4Nmk1bmdoUXEyZGVrYXVJVkV4MWRzQmJweWFtbFpMV09JN0tx?=
 =?utf-8?B?NUNYOUxjVGE5M1hLS0xOMG1qVlNodldsVDB1V0hLbGZOcDVWUGdZVFl3TmlN?=
 =?utf-8?Q?1RklK0/YVFwt4a4O0lDYywWyRsivC?=
x-microsoft-antispam-prvs: <HE1PR0702MB3675C13BA119D8FDF01C61D8B4600@HE1PR0702MB3675.eurprd07.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(39860400002)(376002)(136003)(189003)(199004)(97736004)(106356001)(105586002)(8936002)(2616005)(2906002)(86362001)(2201001)(6116002)(486006)(476003)(71190400001)(110136005)(68736007)(53936002)(478600001)(316002)(36756003)(3846002)(2501003)(71200400001)(256004)(118296001)(102836004)(7736002)(14454004)(6436002)(6512007)(186003)(81166006)(81156014)(4744005)(25786009)(99286004)(26005)(8676002)(6486002)(66066001)(305945005)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3675;H:HE1PR0702MB3675.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NwWIXRUcdyZoblhahfO+2m9BvbAVuRsFf3a81ezyzkgP3sfzE8AAZSSvZcFwmtmlcFcb6ZriLsSMe1W8uG7jNMv2QI3OXm7x/8Mg0rvB5XcfHT/C4RzE6p4Z5nJNctal10HiEZMwzL+TLuJH2nTeSBvcRsjrDgzL5FBYfLXpUS6oO6fGsOKWnw8Ytyj9d79qd879/Ugw4pPL7+qQxlXHWqNXF7kIjhbgs8ikM1TO/Z8uAR774Q3/0dPexjrUmHjhsovWOInCFRWYsZgHW+AzsWLeV+NF8YTr8V76sXLRalsE0fzOd0tfKLaAaJUZPNBjGBcxEVo7kc/eI7A0o2Q2+OJxt6wKg0S/yAzjly7CgrqCFlfl3aBvoncSZot64H6gJ71cyEiwv836eXiJ1xa5At+aYVJWNhWWct+5J57a4wo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D417B5F8E5844A4283FDE0AEEAAAE4E7@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1881a137-0884-4655-888a-08d6937bde23
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 19:29:13.4603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCi9wcm9jL3N5cy9rZXJuZWwvc2NoZWRfZG9tYWluLyBzZWVtcyB0byBiZSBzb21l
d2hhdCBicm9rZW4gd2hlbiBrZXJuZWwNCmlzIGNvbmZpZ3VyZWQgd2l0aG91dCBDT05GSUdfQ1BV
TUFTS19PRkZTVEFDSyBhbmQgYm9vdGluZyB3aXRoDQppc29sY3B1cz0gb3B0aW9uLg0KDQpFeGFt
cGxlIHdpdGggOHggQ1BVLg0KDQpXaXRoIENPTkZJR19DUFVNQVNLX09GRlNUQUNLPXkgYW5kICJp
c29sY3B1cz0yIjoNCg0KIyB1bmFtZSAtcg0KNS4wLjAtMC5yYzMuZ2l0MC4xLmZjMzAueDg2XzY0
DQoNCiMgbHMgL3Byb2Mvc3lzL2tlcm5lbC9zY2hlZF9kb21haW4vKg0KL3Byb2Mvc3lzL2tlcm5l
bC9zY2hlZF9kb21haW4vY3B1MDoNCmRvbWFpbjANCg0KL3Byb2Mvc3lzL2tlcm5lbC9zY2hlZF9k
b21haW4vY3B1MToNCmRvbWFpbjANCg0KL3Byb2Mvc3lzL2tlcm5lbC9zY2hlZF9kb21haW4vY3B1
MjoNCg0KL3Byb2Mvc3lzL2tlcm5lbC9zY2hlZF9kb21haW4vY3B1MzoNCmRvbWFpbjANCg0KL3By
b2Mvc3lzL2tlcm5lbC9zY2hlZF9kb21haW4vY3B1NDoNCmRvbWFpbjANCg0KL3Byb2Mvc3lzL2tl
cm5lbC9zY2hlZF9kb21haW4vY3B1NToNCmRvbWFpbjANCg0KL3Byb2Mvc3lzL2tlcm5lbC9zY2hl
ZF9kb21haW4vY3B1NjoNCmRvbWFpbjANCg0KL3Byb2Mvc3lzL2tlcm5lbC9zY2hlZF9kb21haW4v
Y3B1NzoNCmRvbWFpbjANCg0KDQpBbm90aGVyIGtlcm5lbCB3aXRob3V0IENPTkZJR19DUFVNQVNL
X09GRlNUQUNLIGFuZCAiaXNvbGNwdXM9MiIsIHNvDQpkaXJlY3RvcmllcyBtaXNzaW5nIGZvciBD
UFVzIDItNzoNCg0KIyBscyAvcHJvYy9zeXMva2VybmVsL3NjaGVkX2RvbWFpbi8NCmNwdTAgIGNw
dTENCg0KIyBscyAvcHJvYy9zeXMva2VybmVsL3NjaGVkX2RvbWFpbi8qDQovcHJvYy9zeXMva2Vy
bmVsL3NjaGVkX2RvbWFpbi9jcHUwOg0KZG9tYWluMA0KDQovcHJvYy9zeXMva2VybmVsL3NjaGVk
X2RvbWFpbi9jcHUxOg0KZG9tYWluMA0KDQoNCi1Ub21taQ0KDQo=
