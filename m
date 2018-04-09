Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523240437-2-10517681023328704688
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523240437; b=WE9833hpFmzbYSwebg0Edn3t7DAha1Su+/dREpZV5vK3fyHAME
    gF2uBNTN81UIzSe4QVweJ2y8KYDsSUkgI/2Wx5O4du1ojGvHt8iDuCuTJqBmQTB3
    wqKxsb1bWOd5SKR0xdTRVF5OIQ3FhUF+m7TWm8y2q2dEfTP6X6tRUH3Sq75liWSu
    icARs66oqGxglJIVFQ+Sa1DLe0tIFR5evwjXDE5ADLtPAg18mPMJONEjfbFxHovc
    yiapKSVOQwLVPm7nXmZzEH4FrPZklpVsoxFm7PfQ6wDxieTtfaMMcTc4y62RfzMv
    d9L2qE8dAAPb8syunqIXOTCwWqVQ0RIDWEEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240437; bh=ZiMVd79+KA
    tuFJr4xSpT3bECMHSHXp8KH1ZwBr9oENs=; b=cMQrhtBxKrv3ElhSKSzrszyAKV
    DV4564pMGWe5CLoA82HkEs3haY+vl4+LrhoKI78zqJ25FTORumxMNshycVHtjFHS
    7ax4ZTwwf++noVhnaaCR/ZjVCKPESFdQOg9ebe78zy3/6lPx+GzosFlL9U0vQCCS
    MsfGwqpgjqYikveUIO7lu9zO7OxdOrG6jGgJ1OsZy8Pk3Z6PFJEGVBMfWQPWqkgZ
    MNXHfaQ8NgZm57Rvzss3LiaOE9Op1B68zHik5oqT5N2OHnUCQeSJnKaKsXEmOjsV
    iTnNyhYbt6B98Ri3mgPRpXhhUF81IUFj8jHYex8UtjT0sLEDO2gFNc0Pe/UQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O/AZ8hol x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O/AZ8hol x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK7Bmy8SUkXR3vj59q9fOb4vYjmgIs2Rj8KyIHQRJ/PMvwMtW6EuEdm2C6zJD9TQgpEpOtSp7hemoV3pueQyAvzNYJ5bmPUG8bfhgYpawirvXXGyg43o
    x1fqG34QdV67pkLIwuNzFZmtoJgRt1prpf+ATJZLLxna7BpPg+LSUQ0wAxHovVOTa51fWs1NaOzMkyx2wMjauwLWH4DBnnVu3U6SVL3SytU+9s1JrHqLOi+a
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=n9Sqmae0AAAA:8 a=yQdBAQUQAAAA:8 a=LpQP-O61AAAA:8
    a=yMhMjlubAAAA:8 a=6zHJMjm7uORcIOeF1SQA:9 a=ZZ0aO6WOizlg4XrA:21
    a=ItB-JHMyhEP90P-I:21 a=wPNLvfGTeEIA:10 a=UmAUUZEt6-oIqEbegvw9:22
    a=SzazLyfi1tnkUD6oumHU:22 a=pioyyrs4ZptJ924tMmac:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756055AbeDIA3q (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:29:46 -0400
Received: from mail-sn1nam02on0106.outbound.protection.outlook.com ([104.47.36.106]:7529
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756049AbeDIA3n (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:29:43 -0400
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
Subject: [PATCH AUTOSEL for 4.9 115/293] rtlwifi: btcoex: rtl8723be: fix
 ant_sel not work
Thread-Topic: [PATCH AUTOSEL for 4.9 115/293] rtlwifi: btcoex: rtl8723be: fix
 ant_sel not work
Thread-Index: AQHTz5kcEIxx9h9cR0iaawAuPJHafA==
Date: Mon, 9 Apr 2018 00:24:23 +0000
Message-ID: <20180409002239.163177-115-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:tsyAWNciICxSm40JCi8vzjiYVOSaRe7Wlnzh2JGa6Pi/vQQf663jxGuz6WH2ljM1vYCUH4PmsDClrlj09uj3HYKKRG+f88D1t18dnG0dqSKiv5b2xF6ec4+C1YpEBqIsfs3yqnlgR8jS9Knr86C25IM/zkEpl4c1lXABx5TdAZtO9bgGDYlB4SMvkBVvYhxyE8Ux1KrfcdNFfQdZQA+uDB/7SbGWMIatfK+IuZUutuwMxJtiHrNWEUpR4WrGLKtM;20:560dyHXazun/N73ZWaXp3CffHLcbYHptnPSXnLbXjchCjkLrLOsX/PrGnZni3AgzLrmRi40zOrXuqUVI7xLquV4YD02VYNgYyEFfV+0XkcHTqFeuc6nlhXAROX3dKvILFjIZPM/PAy3yvLv+/o9Jqa0GSyfpXK5Jly31q8f8A1E=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 65d3d3b9-c794-4f72-076c-08d59db0fb34
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1032C1F87EA100899308EFE8FBBF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(39860400002)(376002)(366004)(189003)(199004)(5660300001)(76176011)(99286004)(10090500001)(2900100001)(105586002)(305945005)(7736002)(107886003)(2501003)(5250100002)(14454004)(53936002)(4326008)(8936002)(68736007)(25786009)(86612001)(3846002)(66066001)(1076002)(486006)(316002)(72206003)(22452003)(106356001)(186003)(97736004)(6436002)(6116002)(476003)(2616005)(478600001)(6486002)(10290500003)(2906002)(110136005)(54906003)(6512007)(81156014)(81166006)(8676002)(36756003)(11346002)(3660700001)(446003)(6666003)(86362001)(26005)(102836004)(575784001)(3280700002)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: jW6qWlTnz7d6s60CvwM2FYdAVVYfNSj19clGOKspju9gaK0Qd9V+LTv+xutUFr+rMFo/Bvf4DY2Q7gZhcvtuXxyzNgYCHGwSdim6lN3ClWeGHQULuawn5kHT+0e85HuWzNkQu/dRuuw6hp6b1gaVa/3GMjwHHIpCKpJX7lZtxVWpkU9KTAyRaNcoZXcKrHV8SLKrPLsbtRQzIcydPVnkpUZi7GN5/lToLjiGH6gXzTZjbhiaZYRmAikHL/gCv/KDYh5Bfpizg4CRN167dGkfO2zIQy+7XngiQoeDQmPTLfUQz1F4qoSsR+OVbxDcnO16jtnKIRfuKQ/JuylDVsc8nMUYQ10F915zbQeTgNHlEVKqUSIDFr9ZPwc6JZmzyPRehtTpbsQAVti29T6OniXeGQAvcgnEhQiaKlaB/RVmjXo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d3d3b9-c794-4f72-076c-08d59db0fb34
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:23.3156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
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
index 618e509e75d6..402977745aa7 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
@@ -848,6 +848,9 @@ static bool _rtl8723be_init_mac(struct ieee80211_hw *hw=
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
index 340e7b324ef8..7c0fd17dbcca 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -2525,6 +2525,7 @@ struct bt_coexist_info {
 struct rtl_btc_ops {
 	void (*btc_init_variables) (struct rtl_priv *rtlpriv);
 	void (*btc_init_hal_vars) (struct rtl_priv *rtlpriv);
+	void (*btc_power_on_setting)(struct rtl_priv *rtlpriv);
 	void (*btc_init_hw_config) (struct rtl_priv *rtlpriv);
 	void (*btc_ips_notify) (struct rtl_priv *rtlpriv, u8 type);
 	void (*btc_lps_notify)(struct rtl_priv *rtlpriv, u8 type);
--=20
2.15.1
