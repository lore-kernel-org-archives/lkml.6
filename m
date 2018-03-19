Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521480113-2-14568057269369989164
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521480112; b=NyfOrfQZrqNK8RWvQR4IyoHcDjddUE1Q9oF1e8cUIed3u5Z
    IZM3s9s1HcJ4jHvdpineGU51xOlTemiOckanQ9k5rgP27GftUxmnO3Jk2ye8oP+k
    fp6pUNjZiqA+KwVoEhN9iNhYPReQPJyVr9jFGEXfVbV7d56+ps/kTRhdHSBGQY8s
    xC9oCYp7/wAHtWVAGGw1Fp2ejAUtCumv7j7oj6tGjlC+fcRyO0rsRcE203i//Lhh
    OHeg8j7BUjx0TT6YJZAWWDl6qs3pHuG1mbQFV9/OfnXffcwnZ5ScQfZL+3AGa+Lg
    q0zzz69IOU+iEMY2l0qnkytO/59y5sxypZp+G9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521480112; bh=jJWlPHMtgODdVH5yBEC8O/4XyqtpnQjeIFB6vR
    /+/84=; b=rdVkdKxynnDTAr4u61WbaZ6+mHgP76HAZ5l6OwgJKkO71c04IG1CBW
    hwVPgNvNTKgwghm12WibtMmChq/MVvt1kmdix3WuihjWpFr1692qOjCSswtlF03g
    lNCpSI3mj2eMuKtD9lF89PHfcwJ9xF6mJZd4Vr14hA4DwEmXntVonppGQnWDpwXx
    x96jgHbIOGt/KHAoRaBRbQoN5F6JcrTLOuqKWQjnGgbOKxZBxTFSdTY86oIp6raM
    MvMWydjpMUTW8TbGqk8Y6gQgI2SJM2cFo2GUKV+er6ws9otB0D3v0zUetlq3n387
    pbhKOAnhagqCUA2dlul06Cynt3tpc3CQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bqsiQNSx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeluddvtdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bqsiQNSx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeluddvtdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968037AbeCSRVr (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:21:47 -0400
Received: from mail-bn3nam01on0106.outbound.protection.outlook.com ([104.47.33.106]:7584
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966391AbeCSQJG (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:06 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?SmFuIEguIFNjaMO2bmhlcnI=?= <jschoenh@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 080/167] KVM: nVMX: Fix handling of lmsw
 instruction
Thread-Topic: [PATCH AUTOSEL for 4.4 080/167] KVM: nVMX: Fix handling of lmsw
 instruction
Thread-Index: AQHTv5xRKW4ytHzpHU23v0Xzc6Mz5A==
Date: Mon, 19 Mar 2018 16:07:02 +0000
Message-ID: <20180319160513.16384-80-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:4b1XC7PAEArhsCTzB7HYxNa323o9V2bMJm0jU4V982bFmbwq+JJAWRH5tlcX8TcmIk46o3adHpnfe3Yos+YGoKQNPA4w/T/NvJuGgQAy0gramQ63iPKayBhpRe12wwlgPK6hZFeVRHnuCZPfp++tly/C40RyMFPuvLFLbOzsOI08Q4rHRSTCiTgCAvQIHVTX1pmDosPkLQ65Ic352PF0AaS4hiOL2T/8QNxhdjZxOU2pe9FzIDg6d8EaPCa01fp2;20:Za5gDlQIP8+pFtSjkhw8ZnKG2oeNrfnwBJN3t0ptEYYsdvfcw1PCo51MJOfZxIT07dVfK6CsJ5byE2PuqWi0s0DEMKyn5OTYEQhoAwTsLCmcdC1KuNPJrmmxnbu3YHtVVUSzYtBkvTYb5uS5mhJb3UmqiP2Z5thTRSfEDYhzdz8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7f4c744d-fc0e-4b95-4951-08d58db3bc68
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1095F1A039E99D7650E429B9FBD40@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130873036417446)(194151415913766);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(189003)(199004)(305945005)(316002)(1076002)(7736002)(14454004)(86612001)(25786009)(8936002)(2950100002)(110136005)(66066001)(186003)(10090500001)(5250100002)(2501003)(99286004)(76176011)(86362001)(575784001)(4326008)(68736007)(3660700001)(105586002)(8676002)(81166006)(81156014)(106356001)(3280700002)(72206003)(10290500003)(478600001)(2900100001)(97736004)(54906003)(6512007)(53936002)(6506007)(102836004)(6436002)(5660300001)(6486002)(107886003)(26005)(2906002)(22452003)(6116002)(3846002)(36756003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 3B7khFaPgemgmJTnZkOLagxwopYttgEerdWjCDmdW37MubtT02bD4qMdx3xmzBAG/iTKsAs+Hogc+8kjVmYqZ3Rh9X8yohdzoNu311VxvfQbRhUKwXxJ+I9P8YiuspZmRvEA7XyydEUuBSQcvpOnt1woneZofVVEQVYLeiEJOI0T0rdYacVbrabgB92zkIiUpagbsnbIX3/kVvkSlPwAZzvrO9aRQgUrVbvA7UKfTOC9HCIwLsEUaUQ4CFmeDQZHRog5b3MuaCeRdeMUxsgElUem7L0ROMxTlHfz65cYKmKbSJLVoXoq6ryP4DPom2Eyg9YzkJiTc/ldZNP32qBDig==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CB6757C75CE734093E01C6D0036AE22@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4c744d-fc0e-4b95-4951-08d58db3bc68
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:02.7606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogSmFuIEguIFNjaMO2bmhlcnIgPGpzY2hvZW5oQGFtYXpvbi5kZT4NCg0KWyBVcHN0cmVh
bSBjb21taXQgZTFkMzliMTdlMDQ0ZThhZTgxOTgyNzgxMGQ4N2Q4MDliYTVmNThjMCBdDQoNClRo
ZSBkZWNpc2lvbiB3aGV0aGVyIG9yIG5vdCB0byBleGl0IGZyb20gTDIgdG8gTDEgb24gYW4gbG1z
dyBpbnN0cnVjdGlvbiBpcw0KYmFzZWQgb24gYm9ndXMgdmFsdWVzOiBpbnN0ZWFkIG9mIHVzaW5n
IHRoZSBpbmZvcm1hdGlvbiBlbmNvZGVkIHdpdGhpbiB0aGUNCmV4aXQgcXVhbGlmaWNhdGlvbiwg
aXQgdXNlcyB0aGUgZGF0YSBhbHNvIHVzZWQgZm9yIHRoZSBtb3YtdG8tY3INCmluc3RydWN0aW9u
LCB3aGljaCBib2lscyBkb3duIHRvIHVzaW5nIHdoYXRldmVyIGlzIGluICVlYXggYXQgdGhhdCBw
b2ludC4NCg0KVXNlIHRoZSBjb3JyZWN0IHZhbHVlcyBpbnN0ZWFkLg0KDQpXaXRob3V0IHRoaXMg
Zml4LCBhbiBMMSBtYXkgbm90IGdldCBub3RpZmllZCB3aGVuIGEgMzItYml0IExpbnV4IEwyDQpz
d2l0Y2hlcyBpdHMgc2Vjb25kYXJ5IENQVXMgdG8gcHJvdGVjdGVkIG1vZGU7IHRoZSBMMSBpcyBv
bmx5IG5vdGlmaWVkIG9uDQp0aGUgbmV4dCBtb2RpZmljYXRpb24gb2YgQ1IwLiBUaGlzIHNob3J0
IHRpbWUgd2luZG93IHBvc2VzIGEgcHJvYmxlbSwgd2hlbg0KdGhlcmUgaXMgc29tZSBvdGhlciBy
ZWFzb24gdG8gZXhpdCB0byBMMSBpbiBiZXR3ZWVuLiBUaGVuLCBMMiB3aWxsIGJlDQpyZXN1bWVk
IGluIHJlYWwgbW9kZSBhbmQgY2hhb3MgZW5zdWVzLg0KDQpTaWduZWQtb2ZmLWJ5OiBKYW4gSC4g
U2Now7ZuaGVyciA8anNjaG9lbmhAYW1hem9uLmRlPg0KUmV2aWV3ZWQtYnk6IFdhbnBlbmcgTGkg
PHdhbnBlbmcubGlAaG90bWFpbC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBQYW9sbyBCb256aW5pIDxw
Ym9uemluaUByZWRoYXQuY29tPg0KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRl
ci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogYXJjaC94ODYva3ZtL3ZteC5jIHwgNyArKysr
Ky0tDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS92bXguYyBiL2FyY2gveDg2L2t2bS92bXguYw0KaW5k
ZXggODQ5NTE3ODA1ZWVmLi44ZGRhNGU4OGFmYzQgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9rdm0v
dm14LmMNCisrKyBiL2FyY2gveDg2L2t2bS92bXguYw0KQEAgLTc2NTAsMTEgKzc2NTAsMTMgQEAg
c3RhdGljIGJvb2wgbmVzdGVkX3ZteF9leGl0X2hhbmRsZWRfY3Ioc3RydWN0IGt2bV92Y3B1ICp2
Y3B1LA0KIHsNCiAJdW5zaWduZWQgbG9uZyBleGl0X3F1YWxpZmljYXRpb24gPSB2bWNzX3JlYWRs
KEVYSVRfUVVBTElGSUNBVElPTik7DQogCWludCBjciA9IGV4aXRfcXVhbGlmaWNhdGlvbiAmIDE1
Ow0KLQlpbnQgcmVnID0gKGV4aXRfcXVhbGlmaWNhdGlvbiA+PiA4KSAmIDE1Ow0KLQl1bnNpZ25l
ZCBsb25nIHZhbCA9IGt2bV9yZWdpc3Rlcl9yZWFkbCh2Y3B1LCByZWcpOw0KKwlpbnQgcmVnOw0K
Kwl1bnNpZ25lZCBsb25nIHZhbDsNCiANCiAJc3dpdGNoICgoZXhpdF9xdWFsaWZpY2F0aW9uID4+
IDQpICYgMykgew0KIAljYXNlIDA6IC8qIG1vdiB0byBjciAqLw0KKwkJcmVnID0gKGV4aXRfcXVh
bGlmaWNhdGlvbiA+PiA4KSAmIDE1Ow0KKwkJdmFsID0ga3ZtX3JlZ2lzdGVyX3JlYWRsKHZjcHUs
IHJlZyk7DQogCQlzd2l0Y2ggKGNyKSB7DQogCQljYXNlIDA6DQogCQkJaWYgKHZtY3MxMi0+Y3Iw
X2d1ZXN0X2hvc3RfbWFzayAmDQpAQCAtNzcwOSw2ICs3NzExLDcgQEAgc3RhdGljIGJvb2wgbmVz
dGVkX3ZteF9leGl0X2hhbmRsZWRfY3Ioc3RydWN0IGt2bV92Y3B1ICp2Y3B1LA0KIAkJICogbG1z
dyBjYW4gY2hhbmdlIGJpdHMgMS4uMyBvZiBjcjAsIGFuZCBvbmx5IHNldCBiaXQgMCBvZg0KIAkJ
ICogY3IwLiBPdGhlciBhdHRlbXB0ZWQgY2hhbmdlcyBhcmUgaWdub3JlZCwgd2l0aCBubyBleGl0
Lg0KIAkJICovDQorCQl2YWwgPSAoZXhpdF9xdWFsaWZpY2F0aW9uID4+IExNU1dfU09VUkNFX0RB
VEFfU0hJRlQpICYgMHgwZjsNCiAJCWlmICh2bWNzMTItPmNyMF9ndWVzdF9ob3N0X21hc2sgJiAw
eGUgJg0KIAkJICAgICh2YWwgXiB2bWNzMTItPmNyMF9yZWFkX3NoYWRvdykpDQogCQkJcmV0dXJu
IHRydWU7DQotLSANCjIuMTQuMQ0K
