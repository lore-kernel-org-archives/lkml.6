Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520120543-2-6555752583852332163
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120543; b=BXPpNbuJEJQFIHNCRBCFuRMlZapaJbh/uAQe743D3jJX9QK
    LmGGZnl7+ZnPBjXeATdj/Rj86UonJoP7t+zOPJL57kBHcRvI/y+kFxDLPs345Qs6
    sHp/gna1P+AfDEc+KK7dDeJEdFNp9lpQ+vHFoHSdKy/vOhBVplHt9EZ59JBNXR3A
    2mD4k9nInXXnnOVnCU63M0xjXTEXGRGpPN7xkLQQpSw5RRIvdDApm9mwQisyQZU1
    Vb/tpcdtzybi8p+cpYA0tQyqgPYfFTi/yzyaMECw53YVDqE37f+a4OWxa9n/nVky
    xoTyb86QaQl680uERkUIRm7JQk4O/AZ6bzw9aCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520120543; bh=wnWBywLxTYIDyxjg9UmdGrOxq28G/id3oPiqT4
    0fWdo=; b=jebtvV+5nO9mXVxyvHURlz+wp51pRODr78DHj9L99LtPaLco23GHqv
    vbl6yP/HOcEEBixWPhzrWdAc76xdcbu2n8YKfTPMCiLT0J/E9hwcbaubjI0Qq6Yn
    Hlc5+MURyD0puF3yQROHoyC924bdrbFC+njfDrB6nwu9t9gn4L7o/cORBzpV3exQ
    QpBm9Kqg1+WPQUBNbX/tKAZQPet3TPWIAkmQuJ7CQ9kTJzqE2kqABHy1NEAPQb/w
    Q6vYwdacKQuRfFo6JbmPL256BJqwYwGv18KPwG4mdkK4f2JtSd/rEw9zRqWbEDV/
    Lc7VAlFBc9CHUM0srRxQNO0EsNDKgE+A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V/jOq0p+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V/jOq0p+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934066AbeCCWez (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:34:55 -0500
Received: from mail-by2nam03on0119.outbound.protection.outlook.com ([104.47.42.119]:12016
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933998AbeCCWew (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:34:52 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Borislav Petkov <bp@suse.de>, Joerg Roedel <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 125/219] kvm/svm: Setup MCG_CAP on AMD
 properly
Thread-Topic: [PATCH AUTOSEL for 4.9 125/219] kvm/svm: Setup MCG_CAP on AMD
 properly
Thread-Index: AQHTsz8LQQZjLhtHr0WWuxcbv11Ppg==
Date: Sat, 3 Mar 2018 22:29:08 +0000
Message-ID: <20180303222716.26640-125-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1068;6:zDwmRsFwsy5KPyW1bNubvm24YhNm5yFHV3HYRUGsi8H7cNY9tgDGPG8WHUGXp0nSD2/NxU588T7qXVwJWEqpEkROsyGlHX8ZOtmodLE5iODjeoi4Zp0y1CmncCGfbh6irVqt7jtFpuv7mNy9VMTjsfZ6AqPr2p9ctdYgJBIkRczBqYfUMqt7KEST1mxqq/t1bqDYMlrXuD2SZ2LWS71SwmSyOG76ojG3UGxvCp9k/M8dOFPXye0it6Cel7bysbkosAN5sQvvL36vICLqVqDcSAJeu6Z0m+G2Hg51nF1/uUS4ZcjH4fdOshmYMSwLmM7CdbW6eXjDdaszPIkGrXdQo22p78FXgckpZ9hfgc5Wdry4hsgCf+aP5085opN+X3lc;5:KpywJ/xcegdHdy1SYPotZ5LAaHwaLPn3lEQ/jvg60KdZEF9/sx7J8UHG3HKtF6cwc1CGVAfxgTdUHlCBm81ymPaSiCw47sd/G93PALvxrDO0RHai+bjIiYJqnlZ83nKecNiVdrLFM3tOYt1FbiDRZYkFjDjKi/bSaQbkqvYj4iw=;24:/UsS2TLsz8vJ7xwFMUvC9mzqLSNw5ehjUH8x1lvC3K5LTmndrZP26J7/FjnaioLFsnRaCHKxAZSAATdLHQdTlB4ZKV+BOAUBZwgWqh25ABE=;7:PesfcI450a7GtlOt2EsxVskQYe/p7lT9IBIbYtQ7+tJqDX+kslvQf2VJm2lrzgcrNJKKaJ6zX/fiuQdUYeUcfkbHz7AwqvgR7Yr1U2P6YZhqAPWWKf7Jrv97dz5nn3FRvxcxoO40ZdcJxBAI4dVODqDvprmUMCNs0JEPxXGfbsasnNT6VulSC0raK4CapxSSvg2LPiuHYuzfwL6Te/1eOyxSl4s/q5jgrcL1yMk8LnJNJd4KjKphT0Y2CrQrQhzV
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d75876ad-54bc-423a-4f5f-08d58156f6c6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1068;
x-ms-traffictypediagnostic: MW2PR2101MB1068:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1068E7A5046A6DE65FD44B02FBC40@MW2PR2101MB1068.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1068;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1068;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(376002)(39860400002)(346002)(199004)(189003)(102836004)(59450400001)(6506007)(26005)(66066001)(4326008)(1076002)(105586002)(10290500003)(478600001)(72206003)(86612001)(14454004)(186003)(2906002)(2501003)(305945005)(7736002)(36756003)(3660700001)(5250100002)(25786009)(2950100002)(5660300001)(3846002)(2900100001)(3280700002)(6116002)(106356001)(22452003)(97736004)(316002)(81166006)(10090500001)(81156014)(8936002)(8676002)(76176011)(6436002)(110136005)(53936002)(6486002)(54906003)(6512007)(86362001)(107886003)(68736007)(99286004)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1068;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: URcufzZn9n0dTXxkOjIybbGOdQ1iraxJ1whxvZxUHNPpT52AI4eKT8wa/sv6IjBJTIdR3SlnsStyyiZ2ofOFhCZ1KJ1LgUiofCsJucAy/E3FZxgBCre1bRUh/1tGsYyRo4kvQuQi4zTgBCVrES63hpR/3wpUr6gjKCKRSjcjdKg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0268BB6D2870F64190ECFCB69035DE35@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d75876ad-54bc-423a-4f5f-08d58156f6c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:08.7444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1068
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPg0KDQpbIFVwc3RyZWFtIGNvbW1pdCA3
NGYxNjkwOTBiNmYzNmI4NjdjOWRmMDQ1NDM2NmRkOWFmNmY2MmQxIF0NCg0KTUNHX0NBUFs2Mzo5
XSBiaXRzIGFyZSByZXNlcnZlZCBvbiBBTUQuIEhvd2V2ZXIsIG9uIGFuIEFNRCBndWVzdCwgdGhp
cw0KTVNSIHJldHVybnMgMHgxMDAwMTBhLiBNb3JlIHNwZWNpZmljYWxseSwgYml0IDI0IGlzIHNl
dCwgd2hpY2ggaXMgc2ltcGx5DQp3cm9uZy4gVGhhdCBiaXQgaXMgTUNHX1NFUl9QIGFuZCBpcyBw
cmVzZW50IG9ubHkgb24gSW50ZWwuIFRodXMsIGNsZWFuDQp1cCB0aGUgcmVzZXJ2ZWQgYml0cyBp
biBvcmRlciBub3QgdG8gY29uZnVzZSBndWVzdHMuDQoNClNpZ25lZC1vZmYtYnk6IEJvcmlzbGF2
IFBldGtvdiA8YnBAc3VzZS5kZT4NCkNjOiBKb2VyZyBSb2VkZWwgPGpvcm9AOGJ5dGVzLm9yZz4N
CkNjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0KQ2M6IFJhZGltIEtyxI1t
w6HFmSA8cmtyY21hckByZWRoYXQuY29tPg0KU2lnbmVkLW9mZi1ieTogUGFvbG8gQm9uemluaSA8
cGJvbnppbmlAcmVkaGF0LmNvbT4NClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5k
ZXIubGV2aW5AbWljcm9zb2Z0LmNvbT4NCi0tLQ0KIGFyY2gveDg2L2t2bS9zdm0uYyB8IDcgKysr
KysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L2t2bS9zdm0uYyBiL2FyY2gveDg2L2t2bS9zdm0uYw0KaW5kZXggYmU2NDRhZmFiMWJi
Li42ODM4MTgyNGM1NjUgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9rdm0vc3ZtLmMNCisrKyBiL2Fy
Y2gveDg2L2t2bS9zdm0uYw0KQEAgLTU0NDgsNiArNTQ0OCwxMiBAQCBzdGF0aWMgaW5saW5lIHZv
aWQgYXZpY19wb3N0X3N0YXRlX3Jlc3RvcmUoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQ0KIAlhdmlj
X2hhbmRsZV9sZHJfdXBkYXRlKHZjcHUpOw0KIH0NCiANCitzdGF0aWMgdm9pZCBzdm1fc2V0dXBf
bWNlKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCit7DQorCS8qIFs2Mzo5XSBhcmUgcmVzZXJ2ZWQu
ICovDQorCXZjcHUtPmFyY2gubWNnX2NhcCAmPSAweDFmZjsNCit9DQorDQogc3RhdGljIHN0cnVj
dCBrdm1feDg2X29wcyBzdm1feDg2X29wcyBfX3JvX2FmdGVyX2luaXQgPSB7DQogCS5jcHVfaGFz
X2t2bV9zdXBwb3J0ID0gaGFzX3N2bSwNCiAJLmRpc2FibGVkX2J5X2Jpb3MgPSBpc19kaXNhYmxl
ZCwNCkBAIC01NTYzLDYgKzU1NjksNyBAQCBzdGF0aWMgc3RydWN0IGt2bV94ODZfb3BzIHN2bV94
ODZfb3BzIF9fcm9fYWZ0ZXJfaW5pdCA9IHsNCiAJLnBtdV9vcHMgPSAmYW1kX3BtdV9vcHMsDQog
CS5kZWxpdmVyX3Bvc3RlZF9pbnRlcnJ1cHQgPSBzdm1fZGVsaXZlcl9hdmljX2ludHIsDQogCS51
cGRhdGVfcGlfaXJ0ZSA9IHN2bV91cGRhdGVfcGlfaXJ0ZSwNCisJLnNldHVwX21jZSA9IHN2bV9z
ZXR1cF9tY2UsDQogfTsNCiANCiBzdGF0aWMgaW50IF9faW5pdCBzdm1faW5pdCh2b2lkKQ0KLS0g
DQoyLjE0LjENCg==
