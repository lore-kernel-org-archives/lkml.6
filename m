Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3497C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF39217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s41aAhII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfBZAEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 19:04:14 -0500
Received: from mail-eopbgr80084.outbound.protection.outlook.com ([40.107.8.84]:59488
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728910AbfBZAEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 19:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxFG8RQ9hka4RTgxcsh1TzkSvs6PxfxwPqqIkAuNfdA=;
 b=s41aAhIIyeaWKsZeAzIzhQsgod324XA4IOLMcukreJqgij9gUsTkGJ42o+8CoOJ2aFIvzJnYgTFh7b8Du4FZvg1MSXf1TfCbasue9oSYYXiLrs0b6q9bPyNUJgwxya20NmB4KgMKvU6EpHuNMeu0LYNPAlnb0+CGsvW/2MH30mM=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4466.eurprd04.prod.outlook.com (52.135.147.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 00:03:29 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 00:03:29 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "dennis@kernel.org" <dennis@kernel.org>
CC:     "tj@kernel.org" <tj@kernel.org>, "cl@linux.com" <cl@linux.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: RE: [PATCH 2/2] percpu: km: no need to consider pcpu_group_offsets[0]
Thread-Topic: [PATCH 2/2] percpu: km: no need to consider
 pcpu_group_offsets[0]
Thread-Index: AQHUzELI99orDQmet0qADTSfLzpSUaXwoZQAgACSBtA=
Date:   Tue, 26 Feb 2019 00:03:29 +0000
Message-ID: <AM0PR04MB44817CD1D11F83C23A0D1486887B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190224132518.20586-1-peng.fan@nxp.com>
 <20190224132518.20586-2-peng.fan@nxp.com>
 <20190225151616.GB49611@dennisz-mbp.dhcp.thefacebook.com>
In-Reply-To: <20190225151616.GB49611@dennisz-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6b305ad-8528-4b36-0906-08d69b7dd6d9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4466;
x-ms-traffictypediagnostic: AM0PR04MB4466:
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtBTTBQUjA0TUI0NDY2OzIzOnMvSUdGbFNPNjFHQnRQMW1hOG52ODFmcXFy?=
 =?gb2312?B?NVNac001OHBlQ0lydkVmOTBHQnEvMEdpTDFkL3dxL0xYUzMvSEhPMWJ4RjFK?=
 =?gb2312?B?eDZvdC90NG1TTFZGU3lHaENnWEhaTDA1ZXo0a0RWcW9GMDFybmpkS2U4YUFR?=
 =?gb2312?B?ZlpSSFZBMkYycnIvY3dpekpJdUIxaXNDWkZueUh3dlhDam1XNlRyMWx4czBt?=
 =?gb2312?B?RkhvZkpVK0IrOHZNSXFnVEc5UXM0OStsNW81d003clVSb2RTYWkwSVZOcFdi?=
 =?gb2312?B?cGc0aHhZdnZUZU91U2QrVDBUYmduT0w1WWRxNVZCSXJUVGRiN3dRSnY2c3BB?=
 =?gb2312?B?YWpTRmlGQVZRTHdsdHZMajFJS1dQSncvd3gwdHNLUzFlTTBndnBXMytpcXcr?=
 =?gb2312?B?OGlxSDFSUHdxYUFQeCt0SHJFd2swZEdHbjFTbTB0ZUdrc0RtL1l5akpuSkJ2?=
 =?gb2312?B?d0h5WUJGZFNXUWNXWU11YjRhUFJyUzNleHc3Rnk2bWNWdDR0aG8yVlluUHhh?=
 =?gb2312?B?MmJ5S2xyQWRLYkVERjBjVXlQQU12WkNJUmZZQWs0UmxKZzM5aW1DaFpqR1hQ?=
 =?gb2312?B?OTBqMlBiWTRBanJKQ3kySmdqdEExRERGNFVBTW5nT1JMa3lma3Q3RWZTdmZ1?=
 =?gb2312?B?N3l4Nk8zdWhxcmF1b3RzeE9Cbkluemo5NkNmT1JBRjN4VmNrNkwvSk45RTFE?=
 =?gb2312?B?bDgzamgyMzFSVmVGUEpNMkZrTE4rb3BtOUJQU243anJlc0dyMGJReEQ0cnRS?=
 =?gb2312?B?RXB2aVlrWmxXbVNuRUExK0Y0dUw1OERBNm1od1lPNDJac2JyMzN3Slo0c1JF?=
 =?gb2312?B?cVdrKzVsQ0lLbVN2NTB5NXNOaDc3TmhrV2xEa0pYKzlYYnBxWm93K3FMRHhI?=
 =?gb2312?B?OENpQnZiRkxhaStFNlBlNU9OVzAyZkpUcEc4N3hPMldUM1hmUjNvN05NVUtZ?=
 =?gb2312?B?ZkpJOWllUnphTXMwb1pnQ3VvSHFsSVlnMjVidk1nVWFQa0E0bTFVVHp2WFdX?=
 =?gb2312?B?VVVnUzV3RFJ3MHRjUGhSTitndUZCMTBwdUlsNWM5b3BCVExNc1JySGhYWDZN?=
 =?gb2312?B?czBIK0hra21IMEhuQUowbDN4VDJxUkJUVytxL1kwbVg4cnptczk3WHVsS05D?=
 =?gb2312?B?RnUyeWdCMGtnU2FyR1ppVlRlc2h0cVA4d2hFVXdwSitCL0NrMlI1cG0rUGFz?=
 =?gb2312?B?K2V0V0luYlpWMUd4VWpXSksxa0Z5SlRJbW5Id1J6dXFJR2VhVWpZcktsdG85?=
 =?gb2312?B?TlZYd2xVL0JyRlFhSHBSVmFEUlJVSGlZdzR6K2lxZ3JFSk4yTTRBV1NWWHgr?=
 =?gb2312?B?QW5Lbkc0R1YxNi9qWjlpL3hCUGt4WktFOGdNZDBPMmhFVTlRSVQ1SnQrd1hF?=
 =?gb2312?B?K1lXU0Vland2Z0RWNklWZHZ3clRPWEJzSmtucDkya1ErRXEvR09GanZyck9T?=
 =?gb2312?B?RHl4aDdyQ2RFcGZOeDU3Sm90MXErS3FEZlZJTTFDSVAwVk1qa0JMd0JOemFi?=
 =?gb2312?B?WkZpM2o1MlBmOTBGZVhKRHJuS0xsL21pbkIvTmdFbnYzWUJiTWYvdDIyc1Vr?=
 =?gb2312?B?VXFVaUM1cEw2bjFoUkVWekVKenNFc3ArUFFUSktmbURIN25wM0ZoOFRkL2Zp?=
 =?gb2312?B?aEVXaWlLbXlRMEZDMUJlZlBacHJhL3BwZkV2TmMvYllhRndMeHlabEJzN0NR?=
 =?gb2312?B?bm9weFRtQUtpaDB0ckxFS05obTlVTGh0NHlwa2k1NXI0L2UrYmZMRU5oTStm?=
 =?gb2312?B?STZqWFdISWEyalZNNTRLSWw0U01KKzVkdjFJSnc1Um1YMGRnQWJqQ2VaSU42?=
 =?gb2312?B?NFliWnBubFY1WERnSjF5Yi9vRS8yT3Q1TXdDU3FiL3ZwMXd5RjQ0K1p4NHFS?=
 =?gb2312?Q?XFtGs6rFRw4=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB446627766CA9D78467076758887B0@AM0PR04MB4466.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(39860400002)(136003)(13464003)(199004)(189003)(1730700003)(74316002)(81156014)(8676002)(2906002)(33656002)(54906003)(97736004)(26005)(14454004)(55016002)(9686003)(229853002)(106356001)(478600001)(53936002)(105586002)(5640700003)(6436002)(99286004)(256004)(14444005)(305945005)(7736002)(316002)(6916009)(6246003)(71190400001)(71200400001)(81166006)(2501003)(6506007)(66066001)(476003)(68736007)(486006)(446003)(52536013)(76176011)(86362001)(11346002)(186003)(25786009)(5660300002)(7696005)(53546011)(3846002)(2351001)(6116002)(102836004)(44832011)(8936002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4466;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ljtzM3sJkRB7ebWkPl8fyk+GRoV3lgKgLPmkNIF8hCqDO3zjSGCnuejYtw5Y+qh/Xe8stiv0xl7DWQJBW0PaWy1K+U0Av2g+SYd/UvWeMsE4uffOFNV+wdQycaVAwHfaPHUfKEYjjDbTOPM2KSxAcB+eK0aJC9M9oQlOoJKjO5bkRDtqRXMfSC0M7hrRPNrw2QyGNZer04yRVSwTcY9SsET/h8OWwTsqPxYpMLrADdHQS6rCVwoSdpkORkEpYy9QmKluGO2sW4MYxpMtsQomZun1BN7NxVyJ5Wfd9WV/i9vGMguDAaPk3Ce4fBTzuk8ucdPbFnU2VFFlPWFzfBJs+CGVV5GSGW1ZKK5NU+BlSg8nbmve09h9x31v1PLUTiIrUVFSMAgcti0kk4mBQEUOqb9HPEK0NJlBA46dQ3PVKL4=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b305ad-8528-4b36-0906-08d69b7dd6d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 00:03:29.6618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4466
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGVubmlzLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGRlbm5p
c0BrZXJuZWwub3JnIFttYWlsdG86ZGVubmlzQGtlcm5lbC5vcmddDQo+IFNlbnQ6IDIwMTnE6jLU
wjI1yNUgMjM6MTYNCj4gVG86IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiBDYzogdGpA
a2VybmVsLm9yZzsgY2xAbGludXguY29tOyBsaW51eC1tbUBrdmFjay5vcmc7DQo+IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHZhbi5mcmVlbml4QGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIDIvMl0gcGVyY3B1OiBrbTogbm8gbmVlZCB0byBjb25zaWRlcg0KPiBwY3B1X2dy
b3VwX29mZnNldHNbMF0NCj4gDQo+IE9uIFN1biwgRmViIDI0LCAyMDE5IGF0IDAxOjEzOjUwUE0g
KzAwMDAsIFBlbmcgRmFuIHdyb3RlOg0KPiA+IHBlcmNwdS1rbSBpcyB1c2VkIG9uIFVQIHN5c3Rl
bXMgd2hpY2ggb25seSBoYXMgb25lIGdyb3VwLCBzbyB0aGUgZ3JvdXANCj4gPiBvZmZzZXQgd2ls
bCBiZSBhbHdheXMgMCwgdGhlcmUgaXMgbm8gbmVlZCB0byBzdWJ0cmFjdA0KPiA+IHBjcHVfZ3Jv
dXBfb2Zmc2V0c1swXSB3aGVuIGFzc2lnbmluZyBjaHVuay0+YmFzZV9hZGRyDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAg
bW0vcGVyY3B1LWttLmMgfCAyICstDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL21tL3BlcmNwdS1rbS5jIGIv
bW0vcGVyY3B1LWttLmMgaW5kZXgNCj4gPiA2NmU1NTk4YmU4NzYuLjg4NzJjMjFhNDg3YiAxMDA2
NDQNCj4gPiAtLS0gYS9tbS9wZXJjcHUta20uYw0KPiA+ICsrKyBiL21tL3BlcmNwdS1rbS5jDQo+
ID4gQEAgLTY3LDcgKzY3LDcgQEAgc3RhdGljIHN0cnVjdCBwY3B1X2NodW5rICpwY3B1X2NyZWF0
ZV9jaHVuayhnZnBfdA0KPiBnZnApDQo+ID4gIAkJcGNwdV9zZXRfcGFnZV9jaHVuayhudGhfcGFn
ZShwYWdlcywgaSksIGNodW5rKTsNCj4gPg0KPiA+ICAJY2h1bmstPmRhdGEgPSBwYWdlczsNCj4g
PiAtCWNodW5rLT5iYXNlX2FkZHIgPSBwYWdlX2FkZHJlc3MocGFnZXMpIC0gcGNwdV9ncm91cF9v
ZmZzZXRzWzBdOw0KPiA+ICsJY2h1bmstPmJhc2VfYWRkciA9IHBhZ2VfYWRkcmVzcyhwYWdlcyk7
DQo+ID4NCj4gPiAgCXNwaW5fbG9ja19pcnFzYXZlKCZwY3B1X2xvY2ssIGZsYWdzKTsNCj4gPiAg
CXBjcHVfY2h1bmtfcG9wdWxhdGVkKGNodW5rLCAwLCBucl9wYWdlcywgZmFsc2UpOw0KPiA+IC0t
DQo+ID4gMi4xNi40DQo+ID4NCj4gDQo+IFdoaWxlIEkgZG8gdGhpbmsgeW91J3JlIHJpZ2h0LCBj
cmVhdGluZyBhIGNodW5rIGlzIG5vdCBhIHBhcnQgb2YgdGhlDQo+IGNyaXRpY2FsIHBhdGggYW5k
IHN1YnRyYWN0aW5nIDAgaXMgaW5jcmVkaWJseSBtaW5vciBvdmVyaGVhZC4gU28gSSdkDQo+IHJh
dGhlciBrZWVwIHRoZSBjb2RlIGFzIGlzIHRvIG1haW50YWluIGNvbnNpc3RlbmN5IGJldHdlZW4g
cGVyY3B1LXZtLmMNCj4gYW5kIHBlcmNwdS1rbS5jLg0KDQpUaGF0J3Mgb2sgdG8ga2VlcCBjb25z
aXN0ZW5jeSwgc2luY2UgeW91IHByZWZlciB0aGF0Lg0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0K
PiBUaGFua3MsDQo+IERlbm5pcw0K
