Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521482241-2-14057790717759887517
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
    t=1521482240; b=RAVDd2usH0a2J4oucrqEkGVw7glWkKKLn/gq9Rx8fawt12s
    aKlu2zW3GbzqoCq6XXrq+6BbxSoXLHWYPh8lLOcNOV7gQQBc+HCGv4f6vm/AJPjI
    1kJWExS6jUiF0BNGHromSmDkr222ShUfxD4Lsz9+soZRp2C2zl6O3lIUzjVlklff
    GPuQ+vCKoAoOCpVzglEPK+Rz0GeCoJIiJtFyfZnIXL36gMC7JssKUjLKe/ADpstG
    xznqc7rOTR02eh68m8Fw48HZiWTEw9T3aBWLKwj4zi0d8QJqueW95PR74yMFlp+x
    FAyhrYsv1GCkf2CN2OdwXSX459rURS90TB1MNig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521482240; bh=AwO4aJ8hDMfrbFqkBT6t+mMoQyWewljMSxR3cX
    w9U80=; b=KcZ3OFz77ozdNWuCCk0tWeecgNqQ2bGgXO6nj8UBS3Xqo0oq2rWkqV
    PJHlz/rDTy16WzbuxbM/NJubydBQBnNYIpVuLQqlrc59WdO4Pj27BBjnDVlrPRlp
    javixBJRo1Zvl6DMSrRUO6/yGvOIkyoXVxfsFzAKEVt6aXcKqnvrIG/QGas1LHoR
    IIvN/GdkbKPN8MlAanC45/W+aYpxyqk7Wp8SXGUpC+L12QwwRMYDyF0wMj5QibV8
    8AjAB+g9SHOmupJjIh/tYmRufTEhiiEWfzNRcfNjPxdRgxZmBobiXyzNt6pKemRA
    q31aKZoEe76WhAwY3YrTpu6l3JiCoEWA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fVJgbRyW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejledtheenucevlhhushhtvghrufhiiigvpeej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fVJgbRyW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejledtheenucevlhhushhtvghrufhiiigvpeej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965697AbeCSRzC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:55:02 -0400
Received: from mail-dm3nam03on0105.outbound.protection.outlook.com ([104.47.41.105]:45007
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965696AbeCSQEs (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:48 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jim Mattson <jmattson@google.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 219/281] KVM: nVMX: Update
 vmcs12->guest_linear_address on nested VM-exit
Thread-Topic: [PATCH AUTOSEL for 4.9 219/281] KVM: nVMX: Update
 vmcs12->guest_linear_address on nested VM-exit
Thread-Index: AQHTv5ukWKvomOye4EuZqS4jHqMScw==
Date: Mon, 19 Mar 2018 16:02:12 +0000
Message-ID: <20180319155742.13731-219-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:JLPPSw/BU6YmDnW+d8z88z6mgpfbpucvcxuud04msPs2Xl3szkmaeBpnWMbJ9yUKycKF3KRJiKAFPFTMpOFqwOOR8OlaBU4LJHamuiAZ9vQ38XlyWQYSVWKonLq7CHig3ddLHfar3/21TJ7cxmivEbBv5HcUcSSNYuOPrTHudydImrgVPYv9GDtcXknNk+qmccXfhx0yjt3xkN9RGtyBW4hE9nq0MzFY46VPU01k9NQNDQAUjFhRujEv+xzxXjjW;20:Om4Nsub7vGJQkWaopJkFz3KyciQyOvf9CnzNuv5pzkAjeka0txdrNOxKV8heOYOVV7HndrKk5EWDNGaocmlaBaTS6YreUUbuD2XN6D5K5rlH74MRO+UYfE5ku3s50N2rJvJfQjcuzbmIr1CnrCZvasacaU1IAaPbe8vqLV4nRZE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b8a2c9ed-791c-4dd1-8765-08d58db32069
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08050F4898441905858B0218FBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(199004)(189003)(54906003)(3280700002)(316002)(66066001)(22452003)(10290500003)(4326008)(6512007)(72206003)(478600001)(25786009)(107886003)(53936002)(2501003)(5250100002)(36756003)(76176011)(106356001)(110136005)(97736004)(99286004)(26005)(1076002)(8936002)(3846002)(2950100002)(86362001)(186003)(305945005)(575784001)(3660700001)(5660300001)(6116002)(6666003)(6506007)(102836004)(81156014)(81166006)(10090500001)(105586002)(8676002)(14454004)(6436002)(2900100001)(6486002)(7736002)(68736007)(86612001)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: R0A7P7Vyn5Kx42w87TdEQCKA4hhgwS8WBvdSl3NRakC1tx+iRO7NsZh6bunOIUme2Hw9UH/UU6R9lJa7dFfoCf00zwbxGM/5+Hyy9A9NYssEcxD8nWB6oI0d8mHYR9ixJFPJlhmsYYeMYQDjRf7oK9fKhMq314N5XsSg1iSr+reRlWcE1HpE/+BXwsTmHzBgrWuWJwQeqdndX87D9C6MYKLmy1gwPQ8lNOmhB/eOIU/JMy6sr5IIxvdK6kANtX1T0h2+Q7fDS74Hd/FR0KHj4IynM1b+UmzGJy5mYunnfV4dT7FHvnakCa7BLBN9XT/tjzYuDbdHbVpnGI6kpkP5Ug==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7ACB74CE9F1F52488FC8DDECCF690ED4@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a2c9ed-791c-4dd1-8765-08d58db32069
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:12.2816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogSmltIE1hdHRzb24gPGptYXR0c29uQGdvb2dsZS5jb20+DQoNClsgVXBzdHJlYW0gY29t
bWl0IGQyODFlMTNiMGJmZTc0NWEyMTA2MWExOTRlMzg2YTk0OTc4NDM5M2YgXQ0KDQpUaGUgZ3Vl
c3QtbGluZWFyIGFkZHJlc3MgZmllbGQgaXMgc2V0IGZvciBWTSBleGl0cyBkdWUgdG8gYXR0ZW1w
dHMgdG8NCmV4ZWN1dGUgTE1TVyB3aXRoIGEgbWVtb3J5IG9wZXJhbmQgYW5kIFZNIGV4aXRzIGR1
ZSB0byBhdHRlbXB0cyB0bw0KZXhlY3V0ZSBJTlMgb3IgT1VUUyBmb3Igd2hpY2ggdGhlIHJlbGV2
YW50IHNlZ21lbnQgaXMgdXNhYmxlLA0KcmVnYXJkbGVzcyBvZiB3aGV0aGVyIG9yIG5vdCBFUFQg
aXMgaW4gdXNlLg0KDQpGaXhlczogMTE5YTljMDFhNTkyMiAoIktWTTogblZNWDogcGFzcyB2YWxp
ZCBndWVzdCBsaW5lYXItYWRkcmVzcyB0byB0aGUgTDEiKQ0KU2lnbmVkLW9mZi1ieTogSmltIE1h
dHRzb24gPGptYXR0c29uQGdvb2dsZS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBSYWRpbSBLcsSNbcOh
xZkgPHJrcmNtYXJAcmVkaGF0LmNvbT4NClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4
YW5kZXIubGV2aW5AbWljcm9zb2Z0LmNvbT4NCi0tLQ0KIGFyY2gveDg2L2t2bS92bXguYyB8IDMg
Ky0tDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3ZteC5jIGIvYXJjaC94ODYva3ZtL3ZteC5jDQppbmRl
eCBkZjdiZjU4MGM4OTkuLmI0NmFiODg4NmM0NSAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2t2bS92
bXguYw0KKysrIGIvYXJjaC94ODYva3ZtL3ZteC5jDQpAQCAtMTA2NTcsOCArMTA2NTcsNyBAQCBz
dGF0aWMgdm9pZCBwcmVwYXJlX3ZtY3MxMihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHN0cnVjdCB2
bWNzMTIgKnZtY3MxMiwNCiAJCXZtY3MxMi0+Z3Vlc3RfcGRwdHIzID0gdm1jc19yZWFkNjQoR1VF
U1RfUERQVFIzKTsNCiAJfQ0KIA0KLQlpZiAobmVzdGVkX2NwdV9oYXNfZXB0KHZtY3MxMikpDQot
CQl2bWNzMTItPmd1ZXN0X2xpbmVhcl9hZGRyZXNzID0gdm1jc19yZWFkbChHVUVTVF9MSU5FQVJf
QUREUkVTUyk7DQorCXZtY3MxMi0+Z3Vlc3RfbGluZWFyX2FkZHJlc3MgPSB2bWNzX3JlYWRsKEdV
RVNUX0xJTkVBUl9BRERSRVNTKTsNCiANCiAJaWYgKG5lc3RlZF9jcHVfaGFzX3ZpZCh2bWNzMTIp
KQ0KIAkJdm1jczEyLT5ndWVzdF9pbnRyX3N0YXR1cyA9IHZtY3NfcmVhZDE2KEdVRVNUX0lOVFJf
U1RBVFVTKTsNCi0tIA0KMi4xNC4xDQo=
