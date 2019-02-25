Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CF3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040482084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DZgohXM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfBYJoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 04:44:18 -0500
Received: from mail-eopbgr60059.outbound.protection.outlook.com ([40.107.6.59]:33312
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbfBYJoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 04:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNz8nVe3UgHAeASa9+tGUDEs9VP6SfCvuSFzt5jLSlI=;
 b=DZgohXM22y7+mlIiIxIsotTlD6JSSNcgSutC4wueTwQmBBf8FUdwqzXGOI/lCSi7r/B9CDjrncyuM5p0kO1HgVzcXkwC/MjSYlrcjMkuhPHZspMUsEnZK0AorQN3PI2Rzd3BgQbuByU7EDJVfe57lygN6zhqWNvRFCzEl1yZ2Ps=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3853.eurprd04.prod.outlook.com (52.134.16.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Mon, 25 Feb 2019 09:43:34 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477%5]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 09:43:34 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:DPAA2 ETHERNET SWITCH DRIVER" 
        <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>
Subject: RE: [PATCH net] staging: fsl-dpaa2: ethsw: Add missing netdevice
 check
Thread-Topic: [PATCH net] staging: fsl-dpaa2: ethsw: Add missing netdevice
 check
Thread-Index: AQHUyvpLtz/9Xsbtsku40mZJ5Ia3d6XtEOgggAIR9ACAASJjYA==
Date:   Mon, 25 Feb 2019 09:43:33 +0000
Message-ID: <VI1PR0402MB2800B7E183F5C0A809ABE78CE07A0@VI1PR0402MB2800.eurprd04.prod.outlook.com>
References: <20190222220214.25401-1-f.fainelli@gmail.com>
 <VI1PR0402MB28009A8333F247A753F44F94E0780@VI1PR0402MB2800.eurprd04.prod.outlook.com>
 <c9bd0756-2824-a2c2-24ad-a69dc41d9ac3@gmail.com>
In-Reply-To: <c9bd0756-2824-a2c2-24ad-a69dc41d9ac3@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8eda10fb-6c17-4c76-e097-08d69b05b566
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3853;
x-ms-traffictypediagnostic: VI1PR0402MB3853:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0MDJNQjM4NTM7MjM6QXIwRUhhSzhTcGhTbnorT2laV1ZSdXU0?=
 =?utf-8?B?UnFGMlFpOEE5VkZkdFBmOFBUczNoQWNmMkFVeU9mbjhKbkJEL2w0R3dHQkIw?=
 =?utf-8?B?OVFjOEMrK08wbnVYeFB0L3FLdGd2dzVmTmxYSXQ0T29mSUNtNHFla2FDSmJm?=
 =?utf-8?B?cS9mZVQrcDZQMlpHbjZBK3dYQ2w0LzJ1NnUyOWllQWdyam9GSGwydjRkdEVB?=
 =?utf-8?B?aFNSaThBN1lhV0xPOHM2MXhiR25kamVaNW9XZ0dIK01ZSWwzRVFkTU5pMlV5?=
 =?utf-8?B?cFJHYlQ1eHZUSWY3MktFOVRwVlNVNGdFYmVtcHRtWEVUTTJoZXJaSUgzRWo0?=
 =?utf-8?B?NnZ6TllQbk9Qd3lyMWJHaUJ6OHZGZGk3bEt3cVM2VkVZalV0SXRrUWxIREo2?=
 =?utf-8?B?aDNDNHVIU3grWnpxQWNyYVhvVVVBM1ZuY1R1WDBaaUcveDVVNjFXS3NjUmJk?=
 =?utf-8?B?M2tRS1JRZTFtajBobHlFcGZqdllwZDJDTFJRdGdxNXhvbUlYV3pxU3NqM0R6?=
 =?utf-8?B?SmtURzJSSVFDeDVFL0N6SXNaczN1bzNSQjBac2hibHMxTUdVS3pCN3M4Z1Mz?=
 =?utf-8?B?WWhEQnhTTXF6L1FwdGtFTmh1SVhpc05Xa3o3c2U2c0N3NHNHY0g4VndMa2k4?=
 =?utf-8?B?REE5YnVWR2ViS3FkYzVTS1RMTGp5aExJWFE0T1pVT0xLc1JnM3ZlaThRQWUx?=
 =?utf-8?B?UmN5TEtiNDRmUlhsZllLTnNoU3ZWMjdMM3h3Y1cwZ3l0a28zODZVRnRtOVlV?=
 =?utf-8?B?K0hzSWMxSmJFWnY5ZjRSVU5qemEwM2hiS010WGhUVytoNHpUSHNjVFdFYUJG?=
 =?utf-8?B?RUlTYzFvYmk2NUtnN0pGUTFTbWp4STMwT1JOUDNmY1BSZG5GaEFVZ28xS0dL?=
 =?utf-8?B?Qk1PVjhSUDc1TVJidytoZW1yRlZCTlRkaCtPTlI2R1pVcVBSWWdxRkc3VU91?=
 =?utf-8?B?NDNUanpQdWtKcGNOMVNCd0JpcktnL1NRZjk0eWx4by8xeEdUNmJVdDd0K0FN?=
 =?utf-8?B?a2piOFQxSm5oaWw3YUVaQ1J6Z2pYTnB6enFhT000dytvMUJQSDNpc2NsdDhy?=
 =?utf-8?B?NFEwbUVnNXVpUjJoVzREeHVJWnJ1bUhKSjFaeEF4Z096MU5QenlvNEdOS2or?=
 =?utf-8?B?QUtFZ1E5M2oxZTJPQTdUalAyOUtZL0QydTZxYkowd3Y5Zmh1ZnJkRDkyRS9Z?=
 =?utf-8?B?N0kxOUxHeDBvdldRTU85aHZZT2dEekdGckVNQjRSQmlMRm9sdlU2cXlIYXd2?=
 =?utf-8?B?a094OFBRZE50MU5pUnZVSWswMXJmSWQ2QXgrS3ZqNVV3ei8zQnlBcFk0MFNH?=
 =?utf-8?B?Y0lHRVB0WjRUZjV1MXhWSGxzS01ZT3VxMlMyYmJ6SFdWTDJUNWk1bGxodFZ1?=
 =?utf-8?B?azJxOVh6Skc1MkdhM0RwNk94cUl6QjRSRWpFMmJVVnpucHRsY0RnYnVSSUZk?=
 =?utf-8?B?cmljeVJkQ2RlZ1NxWDFGcHI3OG9DY0xFcmFWcC9sWHVjQlF5bkY1cEEyZWdC?=
 =?utf-8?B?Z0V2YTBXMTExMUo5VTgrVS84cnlVVnlHN1FDNldhZW5Ib0FpQUh4ZzNtMWhT?=
 =?utf-8?B?NXd4THNYMUJFWWhaMEZXeUl2eVZzKzJCc2x0OWNwRTJ3U0VIaUhNSkJMeDNT?=
 =?utf-8?B?d3ROakpyRnh4YnEzNUJWeWRmeXFITnZybHdtaG16OWc3cEhMZlVodndjbUpH?=
 =?utf-8?B?NkczV3hsSG1MbVNEbGVOWUdmbTZEaHlMTXpyZEltWlFQREFLMzJsdzkyY1RT?=
 =?utf-8?B?b0FsenoyUjlTaDBFaGk5SDh3PT0=?=
x-microsoft-antispam-prvs: <VI1PR0402MB385371B86F0722B1F551850EE07A0@VI1PR0402MB3853.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(346002)(376002)(199004)(189003)(316002)(53936002)(110136005)(54906003)(2906002)(97736004)(25786009)(2501003)(6246003)(86362001)(256004)(5660300002)(52536013)(478600001)(66066001)(14454004)(966005)(106356001)(105586002)(71200400001)(71190400001)(6506007)(44832011)(7696005)(33656002)(99286004)(186003)(486006)(11346002)(476003)(446003)(76176011)(3846002)(4326008)(6116002)(229853002)(6306002)(6436002)(55016002)(26005)(102836004)(81156014)(7736002)(74316002)(305945005)(8676002)(8936002)(81166006)(68736007)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3853;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +rzQajkwGNWLDhMD7Cp7QYDmF1YskezOcMhh8ciu/QqzbCRfJLup9lOGHKlmYDMQCv8Ht4jRw/m3kb9dxwPfEsgoVMwb5oOEQiBiI62Cppvzesenk3TNuygT0oz1aQBZ9aL/XIs4iQmjK+xWMsTi6JI7H3vIEbJRM/zDXjWzrHoj+WPnW5a3/N28GU4yzEJ2Nz4rKwutywLIWNFdaN5MT1ZkON0AJYlNtGep9Fq652R/6+Nh1DPizzaE1n/YzFMti59XEkmvbwoCXYLn+0LQWRX3+jWEkocY1adtemyGBgzPnUsyIeBn4XrwCiNXO8bv4AkAp8cwIeHPmn4uE9PyVP4MWzdHbSdfpJ3TmGkhlXU7DiStjye/YPOG1W+Kwo20mbHlFP57d1lt4ab9wosl31zXXty3qQVEsA9oorg+0Rc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eda10fb-6c17-4c76-e097-08d69b05b566
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 09:43:33.8452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3853
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0XSBzdGFnaW5nOiBmc2wtZHBhYTI6IGV0aHN3OiBB
ZGQgbWlzc2luZyBuZXRkZXZpY2UgY2hlY2sNCj4gDQo+IExlIDIvMjMvMTkgw6AgMTI6NDUgQU0s
IElvYW5hIENpb3JuZWkgYSDDqWNyaXTCoDoNCj4gPg0KPiA+PiBTdWJqZWN0OiBbUEFUQ0ggbmV0
XSBzdGFnaW5nOiBmc2wtZHBhYTI6IGV0aHN3OiBBZGQgbWlzc2luZyBuZXRkZXZpY2UNCj4gPj4g
Y2hlY2sNCj4gPj4NCj4gPj4gcG9ydF9zd2l0Y2hkZXZfZXZlbnQoKSBkb2VzIG5vdCBjaGVjayB0
aGF0IHRoZSB0YXJnZXQgbmV0d29yayBkZXZpY2UNCj4gPj4gaXMgYWN0dWFsbHkgYmFja2VkIGJ5
IHRoZSBldGhzdyBkcml2ZXIsIHRoaXMgY291bGQgYmUgcHJvYmxlbWF0aWMgaW4NCj4gPj4gYSBz
dGFja2VkIGVudmlyb25tZW50IGNhc2UuDQo+ID4+DQo+ID4NCj4gPiBKdXN0IEZZSSwgSSBzZW50
IGEgcGF0Y2ggc2V0IGNvbnRhaW5pbmcgYSBzaW1pbGFyIHBhdGNoIHZlcmlmeWluZyBpZiB0aGUg
bmV0ZGV2IGlzDQo+IGJhY2tlZCBieSB0aGUgZXRoc3c6DQo+ID4gaHR0cHM6Ly9sa21sLm9yZy9s
a21sLzIwMTkvMi82LzIxNg0KPiA+DQo+ID4gSSBzZW50IHRoZSBlbnRpcmUgcGF0Y2ggc2V0IGFn
YWluc3QgdGhlIHN0YWdpbmcgdHJlZS4NCj4gDQo+IFRoYW5rIHlvdS4gQlRXIGRvIHlvdSBoYXZl
IGFueSBwbGFucyBmb3IgbW92aW5nIHRoaXMgZHJpdmVyIG91dCBvZiBzdGFnaW5nPyBJdA0KPiBs
b29rcyBwcmV0dHkgZ29vZCB0byBtZSB0byBnZXQgcHJvbW90ZWQgaW4gdHJlZSwgcHJvdmlkZWQg
dGhhdCB5b3UgYWxzbyBoYXZlIGFsbA0KPiB0aGUgZGVwZW5kZW5jaWVzIGluIHBsYWNlIGV0Yy4N
Cg0KRHJpdmVyIGRlcGVuZGVuY2llcyBzdWNoIGFzIHRoZSBmc2wtbWMgYnVzIG9yIHRoZSBkcGlv
IGRyaXZlciBhcmUgb3V0IG9mIHN0YWdpbmcgYnV0IG5vdCBhbGwgdGhlIFRPRE8gaXRlbXMgYXJl
IHlldCBpbXBsZW1lbnRlZCAobW9zdCBub3RhYmx5IHN1cHBvcnQgZm9yIGNvbnRyb2wgdHJhZmZp
YykuDQpEbyB5b3UgdGhpbmsgbWF5YmUgd2UgY2FuIG1vdmUgaXQgbm93IGFuZCBzdWJtaXQgZGly
ZWN0bHkgdG8gdGhlIG5ldGRldiB0cmVlIHRoZSBvdGhlciBmZWF0dXJlcz8NCg0KSW9hbmEgQw0K
