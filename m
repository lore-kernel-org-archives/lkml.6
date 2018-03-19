Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3764808-1521494179-2-12187499944901315649
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
    t=1521494178; b=Hp0yANsYP7x3A7ZrEHJyxpcs4pThIAVpcaGDUGBATLx+3M5
    xRzz+c1tv3LMeZO5Wo6TkhtOI2w5RwVQ++3Bs+84KGh6Go2EK9eCKoOOrzFtUurI
    n/HzUsm9PpqFb9tNdlw3IMuQBjYs+5le91dG8dbsOcdTEtv8ABstE0uWh34G7P90
    JWyRTybtDMQKY5NPlnDoqWqh+oVf78xCQCPz5BaqHheaSXOej1O3VB4HkzKedBGY
    i074RtWPnOgLdm83uQmmfBn18CZQiWjJepJInV/CLuiEf3CS+IgusYauPMYy4kFV
    37JKRL1WxwoRyS2waebpjDcy4tI7ToRnHzERNAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521494178; bh=6bzF7HiFJQW4d7pE6WU0ZiodC9BHvldIdjVelo
    9E340=; b=dfCHRz+fHzMZ1VWJvylz9I20er1m9aCpzflCXeDyZdSW9ZMG9gVNQr
    uPxF8SARs/ZchM0NFOBZnZSx25ndnCGXHW3RNJcSl6K7HL2g0iYxigxtEDRt9RJ1
    D3DfsW/CjkVaJZ/LHf3xJvCgyZMuZhPKNuscuGWf8ZuGv74vBZ9KfK2HxO1VGH2D
    eHfvnjBCCUhhJL/3Z/DLJ03ujgjoL/HUQim0D/TjMu98hA8gTIDpbL8nzS7zFf0I
    bAiP6mquJE0FKJIQud297oUyrBQzm81i3y4+hYMbp0Sstp03gXf8TxNXtZ0MrSvS
    b5a3jxC3lnlsbm6pYuYXQcUS23IcxS7A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FxjTkZ8K x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeludeftdenucevlhhushhtvghrufhiiigvpeej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FxjTkZ8K x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeludeftdenucevlhhushhtvghrufhiiigvpeej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934948AbeCSVQD (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:16:03 -0400
Received: from mail-dm3nam03on0109.outbound.protection.outlook.com ([104.47.41.109]:6335
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965116AbeCSQBP (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:01:15 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?SmFuIEguIFNjaMO2bmhlcnI=?= <jschoenh@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 117/281] KVM: nVMX: Fix handling of lmsw
 instruction
Thread-Topic: [PATCH AUTOSEL for 4.9 117/281] KVM: nVMX: Fix handling of lmsw
 instruction
Thread-Index: AQHTv5tdxv3nH8jl9EyBbtDqlWjyWA==
Date: Mon, 19 Mar 2018 16:00:12 +0000
Message-ID: <20180319155742.13731-117-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:HWL5HGxiTAL5Cdxu0yY/DoOqAbszzP6YChfE5y+KwdClhKu74WGgXedGg3ZpZeF84CWmRIbw6aseodb8T/QOwJ7EUTkP3VItr0IP7uGw+/YaMt0Z1N3xbqvwPKu5tUqlFCdLhad1Y2KlWcJudCglwitc/TQmvZkHoYcmhiAxZe9LwvCVHISXptdPKZpsgqqFxHREqSbcLDr2jh3nC7UUmMCHoMaDYD44Mg/vBY4pG5xz3TNs6TFWFADYiUdpZ3KS;20:R7otx0FRkuQ+zS2uL5r2RT/xm4BdWY2nUGWxj3lG3MTdZSYiqJAb3mwmdQ9xfmuEKvpo4YA+Se+RoYpPkmF8kJXrcmEgkT5bc0PSDv3//t5j8vdJ0S7nz2S2SEIgitrkMRLRS++DLijgG6nGuIUa7xRBIdoUlsSwP0Vhn/e1O/c=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 73b2353d-d72c-45c9-8314-08d58db29df0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10158040280FDA8B7E706870FBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130873036417446)(194151415913766);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39380400002)(39860400002)(366004)(189003)(199004)(97736004)(72206003)(4326008)(99286004)(2900100001)(1076002)(186003)(10290500003)(36756003)(25786009)(66066001)(86612001)(102836004)(54906003)(110136005)(575784001)(26005)(86362001)(53936002)(5660300001)(6512007)(14454004)(478600001)(106356001)(107886003)(316002)(2950100002)(6666003)(22452003)(6506007)(7736002)(3280700002)(3660700001)(305945005)(8936002)(2906002)(6116002)(3846002)(6436002)(68736007)(2501003)(5250100002)(6486002)(10090500001)(76176011)(8676002)(81156014)(105586002)(81166006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: qE21gX2n1B/1ACeeNwr4D/XRX8GuK4DdgFHeS13nPUm/rUdrRtPYa4Z6rChWWEqhMVFK6hXrXW0ybYGPbn/z7Yg+4f7pctiqMsVpZPIgFrYH+PD46ZTcyQY3hezv0VaiaH+YPMxT5111v1fKOwrpDjmhgp4wg6TOvTRkqQsq3/ZJZpvoh4CnCCaZEcEzgnCZUC1YZ0wtr6ur4UqH22D5Xu0X6Bh+EnB08AWi6IqrXaxsGlu1+xGgaYXupeCAS7f/wunsO9p43NsM559HZtS0FFlMMdNPoXl6Otg2mvX1/0vJTvFGP3Q/iipWGe7wI+3U7Y6aITjXu1KGPT+CvvkhsA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5EC12684329DF4298109A09BB5D11F4@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b2353d-d72c-45c9-8314-08d58db29df0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:12.9039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
ZXggMGYzYmI0NjMyMzEwLi5kZjdiZjU4MGM4OTkgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9rdm0v
dm14LmMNCisrKyBiL2FyY2gveDg2L2t2bS92bXguYw0KQEAgLTc5MTcsMTEgKzc5MTcsMTMgQEAg
c3RhdGljIGJvb2wgbmVzdGVkX3ZteF9leGl0X2hhbmRsZWRfY3Ioc3RydWN0IGt2bV92Y3B1ICp2
Y3B1LA0KIHsNCiAJdW5zaWduZWQgbG9uZyBleGl0X3F1YWxpZmljYXRpb24gPSB2bWNzX3JlYWRs
KEVYSVRfUVVBTElGSUNBVElPTik7DQogCWludCBjciA9IGV4aXRfcXVhbGlmaWNhdGlvbiAmIDE1
Ow0KLQlpbnQgcmVnID0gKGV4aXRfcXVhbGlmaWNhdGlvbiA+PiA4KSAmIDE1Ow0KLQl1bnNpZ25l
ZCBsb25nIHZhbCA9IGt2bV9yZWdpc3Rlcl9yZWFkbCh2Y3B1LCByZWcpOw0KKwlpbnQgcmVnOw0K
Kwl1bnNpZ25lZCBsb25nIHZhbDsNCiANCiAJc3dpdGNoICgoZXhpdF9xdWFsaWZpY2F0aW9uID4+
IDQpICYgMykgew0KIAljYXNlIDA6IC8qIG1vdiB0byBjciAqLw0KKwkJcmVnID0gKGV4aXRfcXVh
bGlmaWNhdGlvbiA+PiA4KSAmIDE1Ow0KKwkJdmFsID0ga3ZtX3JlZ2lzdGVyX3JlYWRsKHZjcHUs
IHJlZyk7DQogCQlzd2l0Y2ggKGNyKSB7DQogCQljYXNlIDA6DQogCQkJaWYgKHZtY3MxMi0+Y3Iw
X2d1ZXN0X2hvc3RfbWFzayAmDQpAQCAtNzk3Niw2ICs3OTc4LDcgQEAgc3RhdGljIGJvb2wgbmVz
dGVkX3ZteF9leGl0X2hhbmRsZWRfY3Ioc3RydWN0IGt2bV92Y3B1ICp2Y3B1LA0KIAkJICogbG1z
dyBjYW4gY2hhbmdlIGJpdHMgMS4uMyBvZiBjcjAsIGFuZCBvbmx5IHNldCBiaXQgMCBvZg0KIAkJ
ICogY3IwLiBPdGhlciBhdHRlbXB0ZWQgY2hhbmdlcyBhcmUgaWdub3JlZCwgd2l0aCBubyBleGl0
Lg0KIAkJICovDQorCQl2YWwgPSAoZXhpdF9xdWFsaWZpY2F0aW9uID4+IExNU1dfU09VUkNFX0RB
VEFfU0hJRlQpICYgMHgwZjsNCiAJCWlmICh2bWNzMTItPmNyMF9ndWVzdF9ob3N0X21hc2sgJiAw
eGUgJg0KIAkJICAgICh2YWwgXiB2bWNzMTItPmNyMF9yZWFkX3NoYWRvdykpDQogCQkJcmV0dXJu
IHRydWU7DQotLSANCjIuMTQuMQ0K
