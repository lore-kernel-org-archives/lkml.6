Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521496644-2-2353937405049090157
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
    t=1521496644; b=CyReH6EphqjJzCbwm1uIZ1u+4G0WbLm1671PLakrtCupe8G
    zs18nxArffS4OW7lRSAhGrN8dbyhU+BSsbkJkOeTTGIbI+AMKeyel6yxMptaVtQI
    ErG9uMxWor8CBuOr5IOF6GQBJg27vxRnsum0AQgblsFDNIH7bKXkUgq9hl6t3otF
    65qkFsubCKcWSCSX9GjoQevdr0fc4MQFL1NvNGmCQSsTPNxanIc5H2CRG6BtbPtK
    voU0rhIhIT13JkDLpoZ7fpPnh3ravvaZMRjh+CjMEd1SqahBPXwR5T2WqwoCOhrw
    6ljZMNO+xQSzI4b00S9GnNuAX2cmzaakDbkgASg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521496644; bh=lP2+1JTv3hRcacjAquh492UERePxfateFV/k+a
    pieqc=; b=NRJ0+yd9eFZ+e23bj71sg6ftQCjPzLJ2Ef7DFBxHvL4GK3xy2/zYu4
    /6+0kdrWyf+shMkFiBicVJ7tSz3zIWcQSG4ffaXquqhQwicFOM7DRpDHOkNJsMJc
    VFSZDbuvuWmJWQmv3cPtQd/GH57iAAxllLjgQGABdLYvbPguO48t4V+PYgF38frP
    fxd0kzBacRYVAY8pmKFM1DhI4bbgD39JPCBExF1IwMa08+rKdB4vvSWaFkCyK3Vj
    obJWnIsRRijFTKDTNEnwmB0GBjgQYw0J9DkFkOpkdocBu06KUIYAiXOL6PTElueO
    AetqbDX65ZAFo93J0RNFuACNwRAqmflQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LWyY7EK6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelgeeltdenucevlhhushhtvghrufhiiigvpeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LWyY7EK6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelgeeltdenucevlhhushhtvghrufhiiigvpeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964909AbeCSV4j (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:56:39 -0400
Received: from mail-by2nam01on0117.outbound.protection.outlook.com ([104.47.34.117]:58464
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934578AbeCSP4m (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:42 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Paolo Valente <paolo.valente@linaro.org>,
        Davide Ferrari <davideferrari8@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 73/97] block, bfq: put async queues for root
 bfq groups too
Thread-Topic: [PATCH AUTOSEL for 4.14 73/97] block, bfq: put async queues for
 root bfq groups too
Thread-Index: AQHTv5rK/0MSJyfMokSyZfQj+ha28A==
Date: Mon, 19 Mar 2018 15:56:07 +0000
Message-ID: <20180319155411.12348-73-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:ResibTq1zWSMaKeJJxb2mX9aDgi6NU5rgZgPaFYHrwdqmbRikjJdMwtwD7xiitnyWkWpuXRd/nhjInfkuIDsZuXOLMNBS+RCxn03qVkhHtEuEc1eXQiBpsd0Tj1BsdXPFFn4DlTNKyIN0Sz6bEUT8zzq/PMhyDraFpcI3TMVwSYPeYKKcSOIl626mHW3TLnd97bAWVorzMJKxHcERvFMyApNEqXCmi1b5bU+xlVAVEX21+3ZvcAhMz6Bw0bqxRoj;20:ILYIjLPyJlTvLbB6SytCWwtLQ0FmHjL0LZ4jpWSxyp8kcy1GbZ2nrNYb1rVDnWA6VKMmz8bDBY5v84wVecH+MxzSx0xlgpSie9ZMXwwSvC4VLZRrjBVZvvCWIUmzqa7oq879NeN/w/8GP3BwwUuag2b/hvTdK5PC6mTUKmLuII4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3db20565-1bbf-4b55-af22-08d58db1feec
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB103148661DF1FFDD0094F8B8FBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(25786009)(6506007)(59450400001)(66066001)(99286004)(76176011)(10290500003)(54906003)(68736007)(3660700001)(97736004)(22452003)(107886003)(53936002)(86362001)(110136005)(2501003)(5250100002)(86612001)(14454004)(478600001)(72206003)(316002)(102836004)(26005)(186003)(6116002)(3846002)(7736002)(39060400002)(2950100002)(10090500001)(6436002)(3280700002)(6512007)(6666003)(2900100001)(8676002)(8936002)(36756003)(106356001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(6486002)(81166006)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: JenArAywIeZBV9cNkpoJZoKjWt5L1BsL6JTkda1qkiXuO/jC0zYyP4De/3H3wFhrU7ORtG47MfppHO6uEntEFCF19wJ4TvfAvODdkJNbGCAh+3Cenc9bMzymkFyglMsvHCJ0SvPsJ/yruZMgMoKT9rkkZOs5bHHjppqHmgHeoxU75wSZgEdLV2oGQD0dRrUXVx7S40iBG4OgaLD8EoF4XDhFsjtwL8o2SiBqX4fpGyyOPIhJtBiABbjqPLSOr8Syhog27JLXqtPEBre6q9/huEZKVZOcPnNMK81r6FfdMExzoi1lL4FtZZTwW4s2/oz4Pq94TbBZHgaBNtOskpL9yQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1F202EC52DEBE468C5E35ECC06DAC25@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db20565-1bbf-4b55-af22-08d58db1feec
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:56:07.0495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogUGFvbG8gVmFsZW50ZSA8cGFvbG8udmFsZW50ZUBsaW5hcm8ub3JnPg0KDQpbIFVwc3Ry
ZWFtIGNvbW1pdCA1MjI1N2ZmYmZjYWY1OGQyNDdiMTNmYjE0OGUyN2VkMTdjMzNlNTI2IF0NCg0K
Rm9yIGVhY2ggcGFpciBbZGV2aWNlIGZvciB3aGljaCBiZnEgaXMgc2VsZWN0ZWQgYXMgSS9PIHNj
aGVkdWxlciwNCmdyb3VwIGluIGJsa2lvL2lvXSwgYmZxIG1haW50YWlucyBhIGNvcnJlc3BvbmRp
bmcgYmZxIGdyb3VwLiBFYWNoIHN1Y2gNCmJmcSBncm91cCBjb250YWlucyBhIHNldCBvZiBhc3lu
YyBxdWV1ZXMsIHdpdGggZWFjaCBhc3luYyBxdWV1ZQ0KY3JlYXRlZCBvbiBkZW1hbmQsIGkuZS4s
IHdoZW4gc29tZSBJL08gcmVxdWVzdCBhcnJpdmVzIGZvciBpdC4gIE9uDQpjcmVhdGlvbiwgYW4g
YXN5bmMgcXVldWUgZ2V0cyBhbiBleHRyYSByZWZlcmVuY2UsIHRvIG1ha2Ugc3VyZSB0aGF0DQp0
aGUgcXVldWUgaXMgbm90IGZyZWVkIGFzIGxvbmcgYXMgaXRzIGJmcSBncm91cCBleGlzdHMuICBB
Y2NvcmRpbmdseSwNCnRvIGFsbG93IHRoZSBxdWV1ZSB0byBiZSBmcmVlZCBhZnRlciB0aGUgZ3Jv
dXAgZXhpdGVkLCB0aGlzIGV4dHJhDQpyZWZlcmVuY2UgbXVzdCByZWxlYXNlZCBvbiBncm91cCBl
eGl0Lg0KDQpUaGUgYWJvdmUgaG9sZHMgYWxzbyBmb3IgYSBiZnEgcm9vdCBncm91cCwgaS5lLiwg
Zm9yIHRoZSBiZnEgZ3JvdXANCmNvcnJlc3BvbmRpbmcgdG8gdGhlIHJvb3QgYmxraW8vaW8gcm9v
dCBmb3IgYSBnaXZlbiBkZXZpY2UuIFlldCwgYnkNCm1pc3Rha2UsIHRoZSByZWZlcmVuY2VzIHRv
IHRoZSBleGlzdGluZyBhc3luYyBxdWV1ZXMgb2YgYSByb290IGdyb3VwDQphcmUgbm90IHJlbGVh
c2VkIHdoZW4gdGhlIGxhdHRlciBleGl0cy4gVGhpcyBjYXVzZXMgYSBtZW1vcnkgbGVhayB3aGVu
DQp0aGUgaW5zdGFuY2Ugb2YgYmZxIGZvciBhIGdpdmVuIGRldmljZSBleGl0cy4gSW4gYSBzaW1p
bGFyIHZlaW4sDQpiZnFnX3N0YXRzX3hmZXJfZGVhZCBpcyBub3QgZXhlY3V0ZWQgZm9yIGEgcm9v
dCBncm91cC4NCg0KVGhpcyBjb21taXQgZml4ZXMgYmZxX3BkX29mZmxpbmUgc28gdGhhdCB0aGUg
bGF0dGVyIGV4ZWN1dGVzIHRoZSBhYm92ZQ0KbWlzc2luZyBvcGVyYXRpb25zIGZvciBhIHJvb3Qg
Z3JvdXAgdG9vLg0KDQpSZXBvcnRlZC1ieTogSG9sZ2VyIEhvZmZzdMOkdHRlIDxob2xnZXJAYXBw
bGllZC1hc3luY2hyb255LmNvbT4NClJlcG9ydGVkLWJ5OiBHdW9xaW5nIEppYW5nIDxncWppYW5n
QHN1c2UuY29tPg0KVGVzdGVkLWJ5OiBIb2xnZXIgSG9mZnN0w6R0dGUgPGhvbGdlckBhcHBsaWVk
LWFzeW5jaHJvbnkuY29tPg0KU2lnbmVkLW9mZi1ieTogRGF2aWRlIEZlcnJhcmkgPGRhdmlkZWZl
cnJhcmk4QGdtYWlsLmNvbT4NClNpZ25lZC1vZmYtYnk6IFBhb2xvIFZhbGVudGUgPHBhb2xvLnZh
bGVudGVAbGluYXJvLm9yZz4NClNpZ25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5l
bC5kaz4NClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5AbWljcm9z
b2Z0LmNvbT4NCi0tLQ0KIGJsb2NrL2JmcS1jZ3JvdXAuYyB8IDcgKysrKystLQ0KIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9i
bG9jay9iZnEtY2dyb3VwLmMgYi9ibG9jay9iZnEtY2dyb3VwLmMNCmluZGV4IGNlZWZiOWE3MDZk
Ni4uNWQ1M2U1MDRhY2FlIDEwMDY0NA0KLS0tIGEvYmxvY2svYmZxLWNncm91cC5jDQorKysgYi9i
bG9jay9iZnEtY2dyb3VwLmMNCkBAIC03NDksMTAgKzc0OSwxMSBAQCBzdGF0aWMgdm9pZCBiZnFf
cGRfb2ZmbGluZShzdHJ1Y3QgYmxrZ19wb2xpY3lfZGF0YSAqcGQpDQogCXVuc2lnbmVkIGxvbmcg
ZmxhZ3M7DQogCWludCBpOw0KIA0KKwlzcGluX2xvY2tfaXJxc2F2ZSgmYmZxZC0+bG9jaywgZmxh
Z3MpOw0KKw0KIAlpZiAoIWVudGl0eSkgLyogcm9vdCBncm91cCAqLw0KLQkJcmV0dXJuOw0KKwkJ
Z290byBwdXRfYXN5bmNfcXVldWVzOw0KIA0KLQlzcGluX2xvY2tfaXJxc2F2ZSgmYmZxZC0+bG9j
aywgZmxhZ3MpOw0KIAkvKg0KIAkgKiBFbXB0eSBhbGwgc2VydmljZV90cmVlcyBiZWxvbmdpbmcg
dG8gdGhpcyBncm91cCBiZWZvcmUNCiAJICogZGVhY3RpdmF0aW5nIHRoZSBncm91cCBpdHNlbGYu
DQpAQCAtNzgzLDYgKzc4NCw4IEBAIHN0YXRpYyB2b2lkIGJmcV9wZF9vZmZsaW5lKHN0cnVjdCBi
bGtnX3BvbGljeV9kYXRhICpwZCkNCiAJfQ0KIA0KIAlfX2JmcV9kZWFjdGl2YXRlX2VudGl0eShl
bnRpdHksIGZhbHNlKTsNCisNCitwdXRfYXN5bmNfcXVldWVzOg0KIAliZnFfcHV0X2FzeW5jX3F1
ZXVlcyhiZnFkLCBiZnFnKTsNCiANCiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmYmZxZC0+bG9j
aywgZmxhZ3MpOw0KLS0gDQoyLjE0LjENCg==
