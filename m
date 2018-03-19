Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521477631-2-2653449428421118788
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
    t=1521477630; b=ZyjcYjBwnuj0OpzJo2FS3imXw6Vt3VOPanprhTiOap/AYtd
    x3IbRX30jBLkvtHEptnC7SU9M7CASSd0NwfIDEaV7bcUq1Z8f5IBc4mPA0guvxWS
    pj4RXwo7vrCXxZ/I/T8O38r+d5vr1Bn6RzJbBInm2fS2iPt0PWFv/xbn50kCrepo
    uHpS/Q6RCgrMuSfiY+pe5U6nnWy6/GYlpJixMyg/k/DqrB8X1g5rO4+HLKyry8+9
    ch1d4YDrZkrtqwLyFurc7ThAIzmTLXsis/kjK+TQHYUQdZx+oLIwqDvcTCzReAMc
    GcDBAh/sNahqdmrT7SvDxy1h+wOsaMx1o2Ev2xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521477630; bh=UfvrsR3HKlhLaEXJr3jKveJD9dTCp5mul1EyaX
    dqDPM=; b=kKCicmTEfNSR6oxqtuIQtRa8Wilc1eXFOQ7Cpij5xt+s6TDRPU6C0Y
    k1tA+w0aG5dWSGYmJ8rt5WiXNhd/jvAVWGEt3Ykwskf8IfxYbuLi4zMiX2DyiIVg
    5rG2RezZQ9wNqKDd7jT3Umqse+rA0HmawW3EC6vDej8XMri8Xr0V3+48Bt8o9vSO
    Mx3mAmDZgQ/f8yEHETIWnZ13Qfq0BumPzWuMHGJETOv2W/QOTbe+GR5PeVd9bnfP
    RqLjUPfpnP7GWAMm5mkEJ68UTkf+Qflc2EC8Zzc6BM8Bs6HwwTPK0kfBeCs398qW
    B/sQ6Po2PrlCl+CQVrv97ALpvy/cGQtA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dMJ5WNAh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthgsredttddtjeenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepledukedunecuvehluhhsthgvrhfuihiivgepud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dMJ5WNAh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthgsredttddtjeenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepledukedunecuvehluhhsthgvrhfuihiivgepud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966858AbeCSQkH (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:40:07 -0400
Received: from mail-cys01nam02on0101.outbound.protection.outlook.com ([104.47.37.101]:1938
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966855AbeCSQND (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:13:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?SmFuIEguIFNjaMO2bmhlcnI=?= <jschoenh@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 048/102] KVM: nVMX: Fix handling of lmsw
 instruction
Thread-Topic: [PATCH AUTOSEL for 3.18 048/102] KVM: nVMX: Fix handling of lmsw
 instruction
Thread-Index: AQHTv50VmAJra6XUSEOzKTOyvkGxdA==
Date: Mon, 19 Mar 2018 16:12:31 +0000
Message-ID: <20180319161117.17833-48-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:bHczq229AiAivN2sJGJ8ESdfimiv7aQ0PIbVmxylU5Z1QMiXNfkqIbYkU2d56uBgJk7faRv3z4aUlpzUoSSigAcaPpGiHSLa7XYA9YCiWKskywaevCRonLA+Qz1AgCPj5crqJ60X4nIgXGXvf+u+2V643sb/Q8WZO8u27LFE9UTTJkTiEKpeZ0so/EeTc+K94AQM3cHcLCnK8BTHe96NEjpScWB7RzVfU1yD1/OBI4mf6/UXtkLHMrjveBXQ5hsR;20:q3nHjsoHqQ6vHxf/SebourK1xpX/Tl6V4PlN2WLW4Vnfoqh7/JRTGaUEpvqThStA1RcUsvPAnwSilL+2hPUCwHon6GbBnGpeKlb6iV2Rp0L9lw5bFDlm/C6SUCzxi1Sidnyucj4+yZbWPy7uPVoAkmxs4oVVDVzpj1R9s9xJdbw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e2eef9fc-b219-42b1-393b-08d58db44619
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10484F1DCE7212343527A6C3FBD40@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130873036417446)(194151415913766);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(376002)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(3846002)(6116002)(305945005)(6436002)(36756003)(54906003)(110136005)(53936002)(14454004)(97736004)(3660700001)(99286004)(76176011)(22452003)(7736002)(6512007)(316002)(6486002)(186003)(86362001)(2950100002)(575784001)(6666003)(5250100002)(66066001)(3280700002)(102836004)(107886003)(10090500001)(106356001)(25786009)(6506007)(26005)(8936002)(2906002)(81156014)(81166006)(2900100001)(8676002)(86612001)(2501003)(478600001)(105586002)(1076002)(68736007)(4326008)(72206003)(5660300001)(10290500003)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: OYNghcycn1nk5HBe94HhNTEpJEpDKttvY5GF3WJnzgpu2QDk2FFXrlD6bLH7nr/StIY3Wncx687BDzY6VNrCSZmBKvmUn5VgOxuGm9E0Y4MCpm8cwmh4UHq2rZI0txqBdk7JhRV8Zx7wRSkjiO9DnVlzuV3xjtcSLcdk9KcGSETICX9/i2GuGTuqJJZl6Jx0JcYL4dRieowaKUCbts9brjh+R198sx0htqYtdXw3CHviSY1/4n7kmvPYttpM5JoY2zrwtYzunkFilCuYtWOqNkLkdow1KLR1XrVbudzGMpCOGTxMranPfMebsklh7bO76AvNLOR5r4KSCXywssqO8w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EB48E71664B154FB9FB9B808A75A4D7@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2eef9fc-b219-42b1-393b-08d58db44619
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:31.3342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
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
ZXggOWIwMmJhNDBmZWQwLi42NmVkOGQ0M2NiMTYgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9rdm0v
dm14LmMNCisrKyBiL2FyY2gveDg2L2t2bS92bXguYw0KQEAgLTY5MjgsMTEgKzY5MjgsMTMgQEAg
c3RhdGljIGJvb2wgbmVzdGVkX3ZteF9leGl0X2hhbmRsZWRfY3Ioc3RydWN0IGt2bV92Y3B1ICp2
Y3B1LA0KIHsNCiAJdW5zaWduZWQgbG9uZyBleGl0X3F1YWxpZmljYXRpb24gPSB2bWNzX3JlYWRs
KEVYSVRfUVVBTElGSUNBVElPTik7DQogCWludCBjciA9IGV4aXRfcXVhbGlmaWNhdGlvbiAmIDE1
Ow0KLQlpbnQgcmVnID0gKGV4aXRfcXVhbGlmaWNhdGlvbiA+PiA4KSAmIDE1Ow0KLQl1bnNpZ25l
ZCBsb25nIHZhbCA9IGt2bV9yZWdpc3Rlcl9yZWFkbCh2Y3B1LCByZWcpOw0KKwlpbnQgcmVnOw0K
Kwl1bnNpZ25lZCBsb25nIHZhbDsNCiANCiAJc3dpdGNoICgoZXhpdF9xdWFsaWZpY2F0aW9uID4+
IDQpICYgMykgew0KIAljYXNlIDA6IC8qIG1vdiB0byBjciAqLw0KKwkJcmVnID0gKGV4aXRfcXVh
bGlmaWNhdGlvbiA+PiA4KSAmIDE1Ow0KKwkJdmFsID0ga3ZtX3JlZ2lzdGVyX3JlYWRsKHZjcHUs
IHJlZyk7DQogCQlzd2l0Y2ggKGNyKSB7DQogCQljYXNlIDA6DQogCQkJaWYgKHZtY3MxMi0+Y3Iw
X2d1ZXN0X2hvc3RfbWFzayAmDQpAQCAtNjk4Nyw2ICs2OTg5LDcgQEAgc3RhdGljIGJvb2wgbmVz
dGVkX3ZteF9leGl0X2hhbmRsZWRfY3Ioc3RydWN0IGt2bV92Y3B1ICp2Y3B1LA0KIAkJICogbG1z
dyBjYW4gY2hhbmdlIGJpdHMgMS4uMyBvZiBjcjAsIGFuZCBvbmx5IHNldCBiaXQgMCBvZg0KIAkJ
ICogY3IwLiBPdGhlciBhdHRlbXB0ZWQgY2hhbmdlcyBhcmUgaWdub3JlZCwgd2l0aCBubyBleGl0
Lg0KIAkJICovDQorCQl2YWwgPSAoZXhpdF9xdWFsaWZpY2F0aW9uID4+IExNU1dfU09VUkNFX0RB
VEFfU0hJRlQpICYgMHgwZjsNCiAJCWlmICh2bWNzMTItPmNyMF9ndWVzdF9ob3N0X21hc2sgJiAw
eGUgJg0KIAkJICAgICh2YWwgXiB2bWNzMTItPmNyMF9yZWFkX3NoYWRvdykpDQogCQkJcmV0dXJu
IDE7DQotLSANCjIuMTQuMQ0K
