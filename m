Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F4BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D6D208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="H9HiXQri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D6D208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbeH1DHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 23:07:32 -0400
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:20160
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727230AbeH1DHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 23:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUUQsbnMmTvYiESFM2gwDYOfHmjS89mHb2NZQupi8SM=;
 b=H9HiXQriD44b7VqYq6lTi4RTO2s2pwgiVwJjpiSfJ2b5aQypa5XPnS4JUlgg1XBMmR/JYB+t2QcD/a1afJ4kGEI3KsSKtCuXYFBpgE1virRJsOXuJ/AZVCFbAddPhy5foNjARV1CAdKdpi9XzG2NDqO5B4G4GT1hzeymFoQldIo=
Received: from CY4PR21MB0503.namprd21.prod.outlook.com (10.172.122.13) by
 CY4PR21MB0277.namprd21.prod.outlook.com (10.173.193.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Mon, 27 Aug 2018 23:18:43 +0000
Received: from CY4PR21MB0503.namprd21.prod.outlook.com
 ([fe80::113a:f97e:d360:4aee]) by CY4PR21MB0503.namprd21.prod.outlook.com
 ([fe80::113a:f97e:d360:4aee%11]) with mapi id 15.20.1122.000; Mon, 27 Aug
 2018 23:18:43 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
CC:     Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 1/2] Revert "x86/e820: put !E820_TYPE_RAM regions into
 memblock.reserved"
Thread-Topic: [PATCH 1/2] Revert "x86/e820: put !E820_TYPE_RAM regions into
 memblock.reserved"
Thread-Index: AQHUPlxKyfREGSGwLUKbn3BaQRBC4w==
Date:   Mon, 27 Aug 2018 23:18:42 +0000
Message-ID: <f3f1b835-8762-5644-a9aa-fac11ba07b14@microsoft.com>
References: <20180823182513.8801-1-msys.mizuma@gmail.com>
In-Reply-To: <20180823182513.8801-1-msys.mizuma@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0277;6:GPEH9okpG89SsHlfp0xtbMYoGjIyYBZu+LOcQQ7a3+6pVp2HyEPU40bv8GHRpp5WTE+7EuomTt+tygaG47Y7kz8dFzBGczR4RwjjW1FcbWLyOMjL4G/+tLPfFCrl14YbCR3OKR52RDBE1IgkPGCn2xNIbJwncpi9byGASinqvjjac+BwP9nNIG1Qu92sge3oDBShSZ7+qcaNGas0AnpI4gQdrbMWNIJbwmntp8QWcIoNLg/q3xuCXIclcrQrZJw464Sk8By9ECroAoDvwbeHJOeTasMYYys7cE1cqXSk5+uDnK3vN24mY3vPM3YKReJgO9wirGfJrKXD3ylrPM/UCdYCe2+mFF3DaxsKdra6mcZkOBf2IiM2Pky+/GUOjOntowDQrOJQP4tBXfZLic8EwlbzIla3QWcr4hOW1SVyGRID9eB6nUCQZ8KC7I8iGotvyUQCJ1Eh0VkbqN/m2iawnQ==;5:cMQ4lboUCN4+XfAhkK6O3DZVrYdBHuGaU1xWYksM0SqvIx4kkSlmjDU5i/dv2pPYRVJMSBute6V5RuaIIsA0KxJpo5dirhMZMyUOPinuJy4u5gYV6Pz6e8te9A43YwOTiQCRevBMguHW3RMUM34kvbDyDjflWmXW8QwuCjZ3iiU=;7:5n03NwT/27FyiTqkFVIGTQvGj/hDtBfspQufse4+qquu1Cak+T6ASY7ZYzP+ozvmYipYZs9qiwIq0eUfNXjju2UVCLJWlO9jYQlSR5K3AODMZHTKtHYBdqVCB9hARUggAWMuUgnlQhyDncsSAZ1XJzvHVUb5xifehk8xaAnAMC/32pGOVf3qQIqhA5DX9zi0UtNstgP1onF1nhhdktlTdktD1L5K5x4UoRMkWoNaEt+1Nn2eI0UZvSnmjFK+/gu7
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7335ea28-0af7-4e8d-02a3-08d60c736e4a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0277;
x-ms-traffictypediagnostic: CY4PR21MB0277:
x-microsoft-antispam-prvs: <CY4PR21MB0277B4495E21F20E9238E3209D0B0@CY4PR21MB0277.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(170618885588394)(268935105599563);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231336)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0277;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0277;
x-forefront-prvs: 07778E4001
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(305945005)(2906002)(39060400002)(25786009)(7736002)(99286004)(53546011)(6506007)(256004)(102836004)(31686004)(6116002)(229853002)(3846002)(97736004)(81166006)(105586002)(8676002)(81156014)(106356001)(2501003)(5250100002)(6246003)(4326008)(2900100001)(14454004)(86612001)(31696002)(72206003)(966005)(575784001)(86362001)(54906003)(478600001)(53936002)(110136005)(6512007)(6306002)(22452003)(8936002)(316002)(6436002)(10290500003)(36756003)(476003)(5660300001)(6486002)(76176011)(66066001)(446003)(26005)(10090500001)(68736007)(486006)(186003)(11346002)(2616005)(6346003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0277;H:CY4PR21MB0503.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: oeWtT65Q6A1KF8h4SwiOjhR3e23hQbZ9DMFksyR9zzyySXmaXKT4ivcEScwmDfanavihaNTA55xkZM494hyGKYe1d9Lu9o5E/Go+GjrU1guPPgINhdjcRcX71sKnl2+DVbkSM3KkYjOfVHVFedYB3YSVVPtzm21rCLnvtrfn1kl840kwi1+7zgb98DBAJ8agVnnr6e9UVwH8ihJ5cD9T22pc3XwRiX6rnxjK4+ss7CiMYkzThX4vo5cufK8q9U8p/kZiPXXa70OztssE6bMNBTKGVeGFoyW5JJ0w6SjUuRMfevYXKBufSUebeHYdUbGKEI1tIeo5BM+bXjpu3R+Ye6XMLqASBJXMneCinFzT3ko=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7E6988B164F9E46B69C06C89B833C19@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7335ea28-0af7-4e8d-02a3-08d60c736e4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2018 23:18:42.8668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0277
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8yMy8xOCAyOjI1IFBNLCBNYXNheW9zaGkgTWl6dW1hIHdyb3RlOg0KPiBGcm9tOiBNYXNh
eW9zaGkgTWl6dW1hIDxtLm1penVtYUBqcC5mdWppdHN1LmNvbT4NCj4gDQo+IGNvbW1pdCAxMjQw
NDlkZWNiYjEgKCJ4ODYvZTgyMDogcHV0ICFFODIwX1RZUEVfUkFNIHJlZ2lvbnMgaW50bw0KPiBt
ZW1ibG9jay5yZXNlcnZlZCIpIGJyZWFrcyBtb3ZhYmxlX25vZGUga2VybmVsIG9wdGlvbiBiZWNh
dXNlIGl0DQo+IGNoYW5nZWQgdGhlIG1lbW9yeSBnYXAgcmFuZ2UgdG8gcmVzZXJ2ZWQgbWVtYmxv
Y2suIFNvLCB0aGUgbm9kZQ0KPiBpcyBtYXJrZWQgYXMgTm9ybWFsIHpvbmUgZXZlbiBpZiB0aGUg
U1JBVCBoYXMgSG90IHBsYWdnYWJsZSBhZmZpbml0eS4NCj4gDQo+ICAgICA9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0N
Cj4gICAgIGtlcm5lbDogQklPUy1lODIwOiBbbWVtIDB4MDAwMDE4MDAwMDAwMDAwMC0weDAwMDAx
ODBmZmZmZmZmZmZdIHVzYWJsZQ0KPiAgICAga2VybmVsOiBCSU9TLWU4MjA6IFttZW0gMHgwMDAw
MWMwMDAwMDAwMDAwLTB4MDAwMDFjMGZmZmZmZmZmZl0gdXNhYmxlDQo+ICAgICAuLi4NCj4gICAg
IGtlcm5lbDogcmVzZXJ2ZWRbMHgxMl0jMDExWzB4MDAwMDE4MTAwMDAwMDAwMC0weDAwMDAxYmZm
ZmZmZmZmZmZdLCAweDAwMDAwM2YwMDAwMDAwMDAgYnl0ZXMgZmxhZ3M6IDB4MA0KPiAgICAgLi4u
DQo+ICAgICBrZXJuZWw6IEFDUEk6IFNSQVQ6IE5vZGUgMiBQWE0gNiBbbWVtIDB4MTgwMDAwMDAw
MDAwLTB4MWJmZmZmZmZmZmZmXSBob3RwbHVnDQo+ICAgICBrZXJuZWw6IEFDUEk6IFNSQVQ6IE5v
ZGUgMyBQWE0gNyBbbWVtIDB4MWMwMDAwMDAwMDAwLTB4MWZmZmZmZmZmZmZmXSBob3RwbHVnDQo+
ICAgICAuLi4NCj4gICAgIGtlcm5lbDogTW92YWJsZSB6b25lIHN0YXJ0IGZvciBlYWNoIG5vZGUN
Cj4gICAgIGtlcm5lbDogIE5vZGUgMzogMHgwMDAwMWMwMDAwMDAwMDAwDQo+ICAgICBrZXJuZWw6
IEVhcmx5IG1lbW9yeSBub2RlIHJhbmdlcw0KPiAgICAgLi4uDQo+ICAgICA9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0N
Cj4gDQo+IE5hb3lhJ3MgdjEgcGF0Y2ggWypdIGZpeGVzIHRoZSBvcmlnaW5hbCBpc3N1ZSBhbmQg
dGhpcyBtb3ZhYmxlX25vZGUNCj4gaXNzdWUgZG9lc24ndCBvY2N1ci4NCj4gTGV0J3MgcmV2ZXJ0
IGNvbW1pdCAxMjQwNDlkZWNiYjEgKCJ4ODYvZTgyMDogcHV0ICFFODIwX1RZUEVfUkFNDQo+IHJl
Z2lvbnMgaW50byBtZW1ibG9jay5yZXNlcnZlZCIpIGFuZCBhcHBseSB0aGUgdjEgcGF0Y2guDQo+
IA0KPiBbKl0gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTgvNi8xMy8yNw0KPiANCj4gU2lnbmVk
LW9mZi1ieTogTWFzYXlvc2hpIE1penVtYSA8bS5taXp1bWFAanAuZnVqaXRzdS5jb20+DQoNClJl
dmlld2VkLWJ5OiBQYXZlbCBUYXRhc2hpbiA8cGF2ZWwudGF0YXNoaW5AbWljcm9zb2Z0LmNvbT4=
