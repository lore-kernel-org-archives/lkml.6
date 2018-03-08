Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520492883-2-11203550358074937029
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520492882; b=J+hlGf39VrgTD6Xg4nuGQ3hWPwelwYb0+z7G53jMky9GRMb
    c5+rwuc7nSz/9p8MaEivi19wtFP47ITLMqnSV7BYFyPi3eProdwWzRoM1ZQEhFE/
    bdXj8VurhoSdb69gOKUkTwS8fFs12MGw0Xrx4BU/BldFMvuLZocZAgKI7g2Ao2p3
    q9U4UHlcpRUtcHoGhk9vNobZeBn19/QtEOytrgxDuUJ7eOoldszWc3w5waWM13ft
    hWV4bCAMR4zc7IN2kg1+C0+zmFKdjnmVsABSnHvLP8jkvimzZeuWKbCAQwyWUnai
    3M3YCEMYnkS3tnHW8VtGxWMUyZ7E+2WUz6l095A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492882; bh=m5pojg
    L9M2+PwoJvQhTNV4IJ39CYbtW+1AL5LdV0N08=; b=WA1XXztbleM78vOtdN5lbT
    T0fAZ3qfsAdkO1iVF2MUTdL/ol/+NsvXRhwa1rNvYIparxAkvMbMI8uCPF5PaD65
    qZAi/iGxuqu9iexaiWzGOscnYKOf71up9EB7uLRrS2BvbFmv6XmHJNfeHewL52wQ
    MRY87/vQ2cCxWBJ5JN0uAe9uuVSuC8EPAohbTOxlTzPmWUdKyRySdz5YIrfhaDF1
    0p9jiNZB+/UHrP+JtZPYfM+PXgOgwbeF8LqGvjwpBpjp94/GLdaEBGVn2JYxLgEg
    OaIBm4RKowbk0PkpWhj//IZA+cIfpw9VWm3pkaz56o2wx/Hpbpad4ItbLZ8mt/mw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PdiSGQg5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PdiSGQg5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933533AbeCHE4a (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:56:30 -0500
Received: from mail-bn3nam01on0138.outbound.protection.outlook.com ([104.47.33.138]:1475
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755242AbeCHE42 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:56:28 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Nicolas Iooss <nicolas.iooss_linux@m4x.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 20/78] rtlwifi: always initialize variables
 given to RT_TRACE()
Thread-Topic: [PATCH AUTOSEL for 4.15 20/78] rtlwifi: always initialize
 variables given to RT_TRACE()
Thread-Index: AQHTtpnG88Yq68WoeUypllzn+ma7Ww==
Date: Thu, 8 Mar 2018 04:56:09 +0000
Message-ID: <20180308045525.7662-20-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1111;7:XrCHVYbRf6EZ4JpHlM8atdg/nOsM4FAdJxhR8Of/JgykMLJghxcDdz2ZSdR5SUFUTIEOsmyT6XlQlTXc0esgEfxhgI6mmkEZpXKozQuWN64jSdV/rJ73TSWiGJ4cdVdLfGekCVpiUSIVixTGq+JvE51X43NysXUwQ9VErqYoicQY6FdiYnqME8FxHDBBVlfRTBiFYMr1MaKjlXy0HpS6IXJEQNeTd7Mf2tlWR6pH3ODJjP7Be1xdXQsL/x+abQTK;20:M69qLglrrQv4a5MH+WQ/FScMWJbYLkF2RbQfWgUXBkPdc+VzjpLJNS5tmWrmb/dBGbRrss369jBXB267/5DELoYh4h7GSVblEkG98lO2yOmc02RXPHrg5ajCa9VjUEcKssSkkwsrB1g8sqon+EiPVjXNE4bWRfX8xdszX+AJi0c=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a7b9213e-9693-4d4d-0940-08d584b0eba6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1111;
x-ms-traffictypediagnostic: DM5PR2101MB1111:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1111D6D6972058E1BD05AEB9FBDF0@DM5PR2101MB1111.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1111;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1111;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(376002)(39860400002)(366004)(199004)(189003)(86612001)(22452003)(99286004)(7736002)(54906003)(305945005)(86362001)(5660300001)(66066001)(6512007)(81156014)(14454004)(53936002)(2900100001)(10090500001)(1076002)(110136005)(107886003)(6116002)(6436002)(3846002)(72206003)(36756003)(102836004)(316002)(3280700002)(3660700001)(478600001)(106356001)(6486002)(76176011)(6666003)(81166006)(10290500003)(4326008)(2950100002)(97736004)(25786009)(59450400001)(105586002)(8676002)(26005)(2501003)(2906002)(5250100002)(8936002)(186003)(68736007)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1111;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: RRmA4Sz+EgCheOMGoHM7Vlp6dJSpjsEdmr/f1+tx1cqV+q5btaViMedLLsT/kGQRr6VeMKLOTrVbPRNAst8ews6FuGWPQCwy2LCnqbfKMJc2xX4bgBm9phlohSyHXi3RO1a87VFy6N+uaCzqpAWuVhUW8HfmzFjVo7h9b1tP+AZfujZdjh7XWx7fMlfmGv8Hn0ASsEyXNTdjVgqCjwXAmag1IdsAE1A1dWI3gK8CgF6rmh4nIQkJu7Phe6doYHWW9YXfteRxaX7urXC/tSBds+xm5ZKA7GM28nNztL+uBb9aA4uD2JKhv7OhCwG2MgmXM6JDzV2a1cLbC9Tn7RVGdw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b9213e-9693-4d4d-0940-08d584b0eba6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:09.9989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1111
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>

[ Upstream commit e4779162f7377baa9fb9a044555ecaae22c3f125 ]

In rtl_rx_ampdu_apply(), when rtlpriv->cfg->ops->get_btc_status()
returns false, RT_TRACE() is called with the values of variables
reject_agg and agg_size, which have not been initialized.

Always initialize these variables in order to prevent using
uninitialized values.

This issue has been found with clang. The compiler reported:

    drivers/net/wireless/realtek/rtlwifi/base.c:1665:6: error: variable
    'agg_size' is used uninitialized whenever 'if' condition is false
    [-Werror,-Wsometimes-uninitialized]
            if (rtlpriv->cfg->ops->get_btc_status())
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    drivers/net/wireless/realtek/rtlwifi/base.c:1671:31: note:
    uninitialized use occurs here
                     reject_agg, ctrl_agg_size, agg_size);
                                                ^~~~~~~~

    drivers/net/wireless/realtek/rtlwifi/base.c:1665:6: error: variable
    'reject_agg' is used uninitialized whenever 'if' condition
          is false [-Werror,-Wsometimes-uninitialized]
            if (rtlpriv->cfg->ops->get_btc_status())
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    drivers/net/wireless/realtek/rtlwifi/base.c:1671:4: note:
    uninitialized use occurs here
                     reject_agg, ctrl_agg_size, agg_size);
                     ^~~~~~~~~~

Fixes: 2635664e6e4a ("rtlwifi: Add rx ampdu cfg for btcoexist.")
Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/realtek/rtlwifi/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wire=
less/realtek/rtlwifi/base.c
index cad2272ae21b..704741d6f495 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -1726,7 +1726,7 @@ int rtl_tx_agg_oper(struct ieee80211_hw *hw,
 void rtl_rx_ampdu_apply(struct rtl_priv *rtlpriv)
 {
 	struct rtl_btc_ops *btc_ops =3D rtlpriv->btcoexist.btc_ops;
-	u8 reject_agg, ctrl_agg_size =3D 0, agg_size;
+	u8 reject_agg =3D 0, ctrl_agg_size =3D 0, agg_size =3D 0;
=20
 	if (rtlpriv->cfg->ops->get_btc_status())
 		btc_ops->btc_get_ampdu_cfg(rtlpriv, &reject_agg,
--=20
2.14.1
