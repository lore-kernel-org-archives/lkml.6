Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520119434-1-13422142489507109776
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520119433; b=pdelA05PNyNpfWTqH31Y/BtLxTGDR+V8SAp6COGxKZEAqby
    rhOYeXC0RcbZneuEEhFdFjmccEFPDEKgEXvyiGBpIewmBdyrIcEaF79xefLfut1N
    4AperS8j8CR7dSvfF9WMJj9KQKh/pTTKAOjSfi9+/U2bpQnP0+mLIp/dA3c3na5L
    24e9SThgQrIL68RFQu/esWZ6FLxrfgRpZqrV8NeyNfqhVBUm8Wdi/Xa9L1ipPKSt
    t1PpURpZ39w1RNGekm+f2XjRCZL2tprAEa0Jv1SpCiA8gvMy8vfV4tuJ0WPl+teI
    LY86mDR4SB1yqjkhpwNYO2vGxSQ0TOXdbfjvG/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119433; bh=67Z5vw
    I37sWmW65HHEJ7CaHlIOcex4sEdfJHwjEzkH4=; b=IokZta0XohVdtBxNRMzRfx
    3zRACjyjb8/u6f/BmMXL0FCKw6/r9lRC6X/F6L0+TVQ3d+imIEJuPZO+KLd2pLS8
    AGElvpYj53J1S7rzZBMuPN0Y7/Bjz4O+6LzeChERBCiEwUNgIGVsy7E9AJL10+VH
    DM4sK0VV2MQSBMsok2cwbpj37039XemD8t5fYHQ/ug8sIdsfg9nwjS3Sr9ZFLKwm
    aXYP6VZJ1CrgoHW+A0a6aId+zXSu5icsrQGwQSPVziD4l5imjm+pVnYHB1rE1qWA
    FslDyJsT8wnm5XqlqKIwrtQlKf/6UFAnZOdU0CPAPn9+ZCDILCUoif8ufuqhgpRg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cCyofvK9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cCyofvK9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751743AbeCCXXV (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:23:21 -0500
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:45128
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934689AbeCCWhv (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:37:51 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 214/219] mac80211: remove BUG() when interface
 type is invalid
Thread-Topic: [PATCH AUTOSEL for 4.9 214/219] mac80211: remove BUG() when
 interface type is invalid
Thread-Index: AQHTsz8rpH2H4fAYK06lB0vYTE5Jog==
Date: Sat, 3 Mar 2018 22:30:01 +0000
Message-ID: <20180303222716.26640-214-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1100;6:+WU+TWBGsvcTUerbeJkKQn7fWugn+tUQMxxK2MBoj8/RVrgSKvZMBGoV9f4Kf7DT4IeeP6sQLTAqxY4UOEYJnz6p8pjOZ8hZItA6UyAwDx4ZzeJvlANrSgVwkDns6ASgGEK3ABUGM72XCpn6V/wZTdTxAt0Wrb8kYQwJas6bn6J1XbhCWutRWC7TZIVPAOUb++zCW+zmo+N4hflGEr7EUiMAkLfaV6i83JNsUyZKypGhS57pFSbmxxHCuI41woT9+Lx52fNt1w5xw3pyWLP12ufVnhYtWrYYbX8KVktRczWTfrGDoM1RpdzuwmTUXHf7V33HnHgrD9sHF9mRgUoF1zhecokcHTW+jNUIalhpzvyW7qEO1kDgWvmFjcDLrgFI;5:ocSflg2+3GFip7GOfcZWtPt5akYbfbBE8NQG8aqCat7Z2rrtMpbdtjAIMs+wk0cEaT6JWaalDuS4ikrAX498NU5Ir0pbPE+85SR9VgHyLh4um8gj95ti9unlKX/GWmf+qQtjLM9MVw4P45bc9ZP5gadqrxZQIEokueof2F4P6ok=;24:2wMJXaspP/9IsBGF0eFSz9idB6xDDQ8Xq/BWf2XXZbK8va95d05bku2U8zee68gxRMon0idN3+63CqffIN5CjxFt5w6nynzfd9xkawzXYWw=;7:pdVurfVJ+/Nm7x1tv5tyrqtjhnJ0r0VOAgbjYADWT9M1SsFpaBQD6mfkVJgZ6Y1k8Btktcy2pJU+KjzlU8BP8pnbPo4E/rxE9HPdRWNp+bV9QAGi9+omrqAxajn9EreN5rcoNfVTGYQgX09tWGPKBhw/dfy9NtwFoM2GyeJylBJMltEUgA8mHuMuFX0IoQOw+Sqz1IksACkGVIyjeRkkiqGnouIGFaL60azpKhAzDA4G0v2iqWwEGDVULP73o2C+
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0c3575da-6676-4283-1fc4-08d581576448
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1100;
x-ms-traffictypediagnostic: MW2PR2101MB1100:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB110003AC224AEF32EA85CB6AFBC40@MW2PR2101MB1100.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1100;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1100;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39380400002)(376002)(39860400002)(396003)(366004)(346002)(199004)(189003)(22452003)(97736004)(7736002)(5250100002)(105586002)(2906002)(6506007)(72206003)(66066001)(59450400001)(4326008)(305945005)(10290500003)(186003)(3280700002)(102836004)(2950100002)(6666003)(2501003)(478600001)(26005)(2900100001)(10090500001)(53936002)(8676002)(25786009)(81166006)(81156014)(54906003)(86362001)(6436002)(106356001)(110136005)(68736007)(36756003)(316002)(6512007)(5660300001)(107886003)(8936002)(1076002)(6486002)(3660700001)(99286004)(76176011)(3846002)(86612001)(14454004)(6116002)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1100;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: LPlG+9V6ouTBItmUSXGhTz92FnIpm1rWipMhoHRi9RqZZ9J9AyjgmkqX6bwEun+XbfucM2Wbx/Cswi1om0ZmsBeyINfMZc6nsP9pGgP4cJhOPQEnmrha6pzj4orES/hNcwjI7MnSw11Bw1wqoaiSFgbecEeh5HZJZiu62PbXoX4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3575da-6676-4283-1fc4-08d581576448
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:30:01.0258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1100
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

[ Upstream commit c7976f5272486e4ff406014c4b43e2fa3b70b052 ]

In the ieee80211_setup_sdata() we check if the interface type is valid
and, if not, call BUG().  This should never happen, but if there is
something wrong with the code, it will not be caught until the bug
happens when an interface is being set up.  Calling BUG() is too
extreme for this and a WARN_ON() would be better used instead.  Change
that.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/mac80211/iface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index a7aa54f45e19..fa7d757fef95 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1520,7 +1520,7 @@ static void ieee80211_setup_sdata(struct ieee80211_su=
b_if_data *sdata,
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NUM_NL80211_IFTYPES:
-		BUG();
+		WARN_ON(1);
 		break;
 	}
=20
--=20
2.14.1
