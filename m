Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520491853-2-10190628787634315773
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520491853; b=P010zd3l2xzrCmg0SiFQMbMwvP8MS99S9gHr3eRhn71sEh4
    WzsKdgZi3vLXC09Qee6v8IS0pVMEW+dEA0CwAbgwNiezx2n2ESPe3z0gwhtcVhkG
    sPiUUWP9UV5u5IqgNwZ5SeTPNQ3PTVCKK96vkQOvTrCssdqmpQYVe1kemmg+XwZ/
    6g/37Tg5XeIWd7JMPJr9Q7Yi5GFAE8zOP3cG1M0m535sA04ZDajKyn5tYK/zd1m4
    k/S7SekBQgrw3vUcMzW+AZBktMz4dW38icqnqdiCGrpAHG+8JvApsN/j3VfLJbz3
    q5V+t4rEx05WnhsfLFOHLN/kFiSL6aly+KJSi5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491853; bh=Iu00a8
    ij2t8o1rLxYGvIW8Vy/CKgp6jYCudrHxKiEKQ=; b=fBDh7IEcceyK/PfMyymS0i
    4OoY3Ufxze7/5XnliLhsFGb8H4pE5g2yqVLTRBoQl9FZMuzzbL0t24/lUMz2BLAG
    LyxahMN4qofssa568iS5QucbeWoomnsk3c8dQdemlb6gN82K0KKFNPUslHb2JxsA
    mHxO4+UeVFOPUiqNOaepMBx1JZdP7F8SVI7HqhI1tNjc/NRuQM2//Xes2kf4KSEV
    R4g3c54QZoM0RdiioBIWSpgV6xbI4pY6ttcrX3NL1ThjlEArAGm5BS5F7+rsmJhP
    wG8zuy4gh1FZRkEwxFliXdKuEhjwZPJ6pFOt3zQj5Y26/xBLSrcpC+8s2JCDTa8w
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=j6q/EXCa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=j6q/EXCa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965092AbeCHGuR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:50:17 -0500
Received: from mail-sn1nam01on0120.outbound.protection.outlook.com ([104.47.32.120]:33969
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965058AbeCHE6O (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:14 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Nicolas Iooss <nicolas.iooss_linux@m4x.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 15/67] rtlwifi: always initialize variables
 given to RT_TRACE()
Thread-Topic: [PATCH AUTOSEL for 4.14 15/67] rtlwifi: always initialize
 variables given to RT_TRACE()
Thread-Index: AQHTtpn6TDf0vitX5UyqNi5KSttV5w==
Date: Thu, 8 Mar 2018 04:57:38 +0000
Message-ID: <20180308045641.7814-15-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0888;7:r5k9tkR3XKMleVaGuyIxwF6IOCm1a1fevSrppNVC5pAMzFpNNUOL9Cqd5fVMFLi44PbAv8x4sYw97nUPNSfO/hnnKr4JBhsSZ4OFkLzQtqeKPYKlYrCjyXJQTRZL5Bfo9WCO+TfG5IPUMv6CiFDMjcWPYPvFbIiQLTFCAMZ0VW2T8RimKpilOV2lQt1ZBBErF0HvSvGLwNI+bQ6mPDWaid+MMJwI6iPWVBTFEnBkmeObhL53SioKV5sTXhtuvXGw;20:/ofsc93X7aafDxKn+IidzHj8e2kESQl+auE72weFdfAZpECAzkXoIevpYUJSeHuk6gNliC6/VYKIosRb3W7Aj25NQSh/tksefjcwWLoi++YESJ5eCPgGrX6VwwuYdEuWiKN1yeZgvbiJUC/UlTOMT+OXpw7IsQJ2SLoB3dk0vAI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 94a29229-7c26-43fd-2173-08d584b13152
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0888;
x-ms-traffictypediagnostic: DM5PR2101MB0888:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08886DD3C9BB864FBA2EE7D5FBDF0@DM5PR2101MB0888.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0888;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0888;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(39380400002)(396003)(189003)(199004)(6116002)(99286004)(2950100002)(6512007)(6666003)(10290500003)(36756003)(5660300001)(106356001)(1076002)(22452003)(3846002)(97736004)(316002)(53936002)(68736007)(105586002)(4326008)(25786009)(54906003)(478600001)(2501003)(186003)(66066001)(76176011)(3280700002)(86362001)(575784001)(14454004)(2900100001)(5250100002)(110136005)(305945005)(7736002)(72206003)(3660700001)(6436002)(2906002)(26005)(6486002)(10090500001)(8676002)(81156014)(107886003)(81166006)(86612001)(6506007)(59450400001)(8936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0888;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ur+yiygIkxD+0O4gAd6lnn5r1BhRziSrJPcETk3wmwXSLokH/2PaaOl27dkNiPkICMUwyQ4cGQb/N/PsAcmm0+7qGpZcKIvbksrHIbFOPOJr9MpvXogdQouu2WZGa0jCJkLYEKWcfw+BrBVMaf4Waxe6rgYBIpu5owZr4WlSXFLvQHg0GeDGMfzEyL1Sximsz7I2d/9s/gsmfyhJNUCq9PqoX2JWW2YmwWWxkgvxlBkEVISryFWDVy4amTfU7NSEDfJvyZRLofbKTXfm9U/tKYd30URLwlR8lnEbBh58t5KdDHwkalysF9JJULIngTFiMu3A3wxJjyeWqiyq/LniGQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a29229-7c26-43fd-2173-08d584b13152
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:38.0964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0888
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
index ea18aa7afecb..93256f8bc0b5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -1664,7 +1664,7 @@ int rtl_tx_agg_oper(struct ieee80211_hw *hw,
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
