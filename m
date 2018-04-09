Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237234-2-14600351836412280781
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523237233; b=FN4tGGSUgPzKEnMoSuNLWlai/ycZz40X39VDVqy/RsE3vIyK/Q
    XC1qowoLeooOMlfIoELk0FegPxtuyJGxHQT4x6ZFiXzFO6TXTdfqiy7F70Mcae/m
    3a6GviwYx5ADGqlp8c8KBGfd8/aeu0TCElM7O3vcnFAfArWwr+tGb5yqykQ7pcbh
    Wf6bK6zI6d3J/U95KUJuxBb7BxueDsA0bOY7MYlDN8wr2zGhcGVXJ7XXbNKONB53
    9FZk9h6bZb/fQh3IoL3bbe2BHA+ymwamqpng8PsDfgo+YdapqtrCl/5mw4I3S/dV
    ymYCVVGTa/4sYJic2S1/ANBomTVJKTIDrkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237233; bh=H9P1AJnN6A
    KuagnpL82hJC+Q910bbhE5VU4lZYXcRJc=; b=qMATqHu6u52neoAiolYnRdcaZb
    +9HGeeDLNukZJOFiT9h3FWiPkKF86k2TD2a+ajZzNDIZhuZtWAPGPmBHztQ41c/L
    HOWqfq0NzAWqqmPbTD9dVV9RY7edPYPyors3ypWBwGqeOv0PPNA7GvkkilHRBZR9
    +0WU2r7e+HXtPizNrgoSxFWJDJrlfkZweX+CWJrgSw2R820REj4FNWda1uRUQ+bp
    wKbiLxGP3MRezRywsk1qilEs25y9k5EQSWBJ2DS6q0A9cw+2ORomCYZVfawVPnUg
    7H9X136D4IdIvljeRzmWY12FEmdQLP7K9/YOHVgl/qGEYof+xpJKkpqSNq5w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HBZDDebg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HBZDDebg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFeLCl1JYhpY0ZlWR/EKzCp5W87q1ceaShg5SU5TTPdzwNEFVljgmaMRZJSj8l30K0DuO63vBGE5lYgMnxHRXW1DOcrINAu1H8IC1qBY8ZyhZLK6s1su
    Lvr1BAGAhJncq1ZbQyVZwUySWhoJrEKeMjx/CsnYnCpAPKKxhUFTfIE0reNSdIAbZkFqV3KDJ8s/ew8UOVf5dXJnVLVarhU7dVjuKRHnIF5Kl9OihpQWLueh
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=n9Sqmae0AAAA:8 a=yQdBAQUQAAAA:8 a=LpQP-O61AAAA:8
    a=yMhMjlubAAAA:8 a=6zHJMjm7uORcIOeF1SQA:9 a=ZZ0aO6WOizlg4XrA:21
    a=ItB-JHMyhEP90P-I:21 a=wPNLvfGTeEIA:10 a=UmAUUZEt6-oIqEbegvw9:22
    a=SzazLyfi1tnkUD6oumHU:22 a=pioyyrs4ZptJ924tMmac:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755760AbeDIB1K (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:27:10 -0400
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:1992
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756704AbeDIAgQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:36:16 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Birming Chiu <birming@realtek.com>,
        Shaofu <shaofu@realtek.com>,
        Steven Ting <steventing@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 060/162] rtlwifi: btcoex: rtl8723be: fix
 ant_sel not work
Thread-Topic: [PATCH AUTOSEL for 4.4 060/162] rtlwifi: btcoex: rtl8723be: fix
 ant_sel not work
Thread-Index: AQHTz5msrXyvUexaQEuow82cW2PICg==
Date: Mon, 9 Apr 2018 00:28:26 +0000
Message-ID: <20180409002738.163941-60-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:AxhHS1knzcwCn0E6EusAljA8z6+Z+Pj3ewArjgFMbq7KBwdZbVmJvcQ6t+6kT3f7yV5em3zBVUBysDVNIt7WmOhCQa0WxNnjTvkcA7SeX4QaFV2pbIlt7KDHckVLlDHwzkODhTU/3zGt4H7WCNA4wyfEvV+zd+9b8PlAf9Nu7ADew+EUy8zpMYn9+9r92dGMXJX/h6l7JnJ4zl+OcertvlhorcyKE4Kltbf0Y/9ulPcRv5FTUARnAhNQROCaBuoy;20:z+1dHgJsklSK1Rt837DHTwnmQzPTyxpCbFd3d8NLuhkkG4suJ1Q8hQCcMkUsuFMVyaK3YX2z0TlmlLFh4mClbwBMd36FDlTrWCzk8wUdip9QK1pRZofglb6EIciAybsMH9NSQiMBOK6/OP9iSYVKDQlstyocSfbg3dPvYXz+Mt4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c281509-4092-40a8-e0f8-08d59db1e587
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015EA81C5FDAADD0E0EEC2FFBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(575784001)(476003)(6666003)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: v4cVizKEhNFC7oBgOVdi4wZ8y5fBpCSf356UlrUrqM17oey+6k6F3+XviIl0OJyR+cBXXFspDDcXdYU4/82UBIg6iKJXS17+DxLkQLoawICBcxpl+XmleSMDvip9pppTqU1TdsGnyg4MJmTXRFNSCIi0SKjF/XYwmHob/opDSKwicm1otCg5NDuGB1HCnTeNaP9o7whA7e8cxPyO47lq2th5WnnqT58b+e3qRIFZV4aHL6pk2v6gybNi/mEcvdggZ7nToTZDwUeg04mIaN0WFG8eOC9+uZsVgpzpd1TJUWGHEXLakUgy2Zz7lmD/Z+PLB2lf4mItZn6aIFuAstXiTtUs/Fbqt6t6Z/YwDfg5JWu5MgxULu2O/umEjXBWUYuks3obzLu4bUJrDY/KzNUUKg6veTOwKQWHfvzIJ/SQLeY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c281509-4092-40a8-e0f8-08d59db1e587
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:26.2550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit f95d95a7cd5514549dcf6ba754f0ee834cce3e1f ]

To make ant_sel work, we should call power_on_setting to set antenna
correctly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Yan-Hsuan Chuang <yhchuang@realtek.com>
Cc: Birming Chiu <birming@realtek.com>
Cc: Shaofu <shaofu@realtek.com>
Cc: Steven Ting <steventing@realtek.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c | 3 +++
 drivers/net/wireless/realtek/rtlwifi/wifi.h         | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c b/drivers/=
net/wireless/realtek/rtlwifi/rtl8723be/hw.c
index 89515f02c353..d2ae9c4a3665 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
@@ -846,6 +846,9 @@ static bool _rtl8723be_init_mac(struct ieee80211_hw *hw=
)
 		return false;
 	}
=20
+	if (rtlpriv->cfg->ops->get_btc_status())
+		rtlpriv->btcoexist.btc_ops->btc_power_on_setting(rtlpriv);
+
 	bytetmp =3D rtl_read_byte(rtlpriv, REG_MULTI_FUNC_CTRL);
 	rtl_write_byte(rtlpriv, REG_MULTI_FUNC_CTRL, bytetmp | BIT(3));
=20
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wire=
less/realtek/rtlwifi/wifi.h
index d676d055feda..cf48f014d640 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -2533,6 +2533,7 @@ struct bt_coexist_info {
 struct rtl_btc_ops {
 	void (*btc_init_variables) (struct rtl_priv *rtlpriv);
 	void (*btc_init_hal_vars) (struct rtl_priv *rtlpriv);
+	void (*btc_power_on_setting)(struct rtl_priv *rtlpriv);
 	void (*btc_init_hw_config) (struct rtl_priv *rtlpriv);
 	void (*btc_ips_notify) (struct rtl_priv *rtlpriv, u8 type);
 	void (*btc_lps_notify)(struct rtl_priv *rtlpriv, u8 type);
--=20
2.15.1
