Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpUW9lLphETSbgICuJqSeplvlTwRMkyxvIst+LYHC1bj609tCqqX2Vg45B1DzwnNx71CILY
ARC-Seal: i=1; a=rsa-sha256; t=1525767330; cv=none;
        d=google.com; s=arc-20160816;
        b=TdsnKdMSijdVX1YmD/JGWpDGDWywY8hidOxHfyYCVTQrEkIhGhf8MMaUparMuCgQ05
         2n4Yd1Sxxry3R2Z6OD+L8R39jtgot98S1deJwyh/nGL8HILWMNd+r/QoIXCuuQ9hZMS/
         rxa4wSGmmAZrBD2wTbyZPsmQPYCq2teHkytnvZVtbNDE1ZHPK89S5yCCy3y443ncfUCf
         Uyv2WUHhr+9kFbB/UDxmD6UZQgZ5kBUywNKVl8Zjrk1YJlCb4AyLyi2tV6nbIWTEwqMB
         TSoL2bDMyLLM7xO56ruiC9oRjVYeNV9CQKHE2T3ZU+kg5t//4R4p4VWWnT25TKeNOVei
         Voqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=wd+okw/h2OqBk8nlTTDBGXkY1vmDFdH0vM+4SNDkhhs=;
        b=yckY909LJExX+to0KMWZXlFHQIkanGhjElgKWReD5RE2Ijlh2+JP5vca3sTb5DmWLz
         ao4CfzOh6vhNYnPhDS4/ifIOwRuxHfe8taXKFiT91mswmqJ722/pNeJu1AL0i1Kj4SI5
         KoVV2Uc1suMn1/PWL35flYwp49Y9hfjkfre3EQYQ5FD1bt5bu9mqhyfZdxtDy8X0+1ZE
         3kSZGVa/DO+Gy8L/9cCZmE5t6fGQd63zCHSqQrnkllNgrBttUb/p0XmGDUUwCukw0Cmt
         heT3c89bA8awgcAls62kTdRhq4ar0fkm2Nih2e0mjQDKTbNkf0sKUnhpFxPZ+qf3R8uB
         Df2g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=o5j/0LVE;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=o5j/0LVE;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.14 17/43] rtlwifi: btcoex: Add power_on_setting routine
Date: Tue,  8 May 2018 10:10:36 +0200
Message-Id: <20180508074006.884700959@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599883004150165615?=
X-GMAIL-MSGID: =?utf-8?q?1599883004150165615?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ping-Ke Shih <pkshih@realtek.com>

commit a44709bba70fb9badc44b6a551415b152db13182 upstream.

After mac power-on sequence, wifi will start to work so notify btcoex the
event to configure registers especially related to antenna. This will not
only help to assign antenna but also to yield better user experience.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.h |    1 +
 drivers/net/wireless/realtek/rtlwifi/btcoexist/rtl_btc.c      |    6 ++++++
 drivers/net/wireless/realtek/rtlwifi/btcoexist/rtl_btc.h      |    1 +
 drivers/net/wireless/realtek/rtlwifi/wifi.h                   |    1 +
 4 files changed, 9 insertions(+)

--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.h
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.h
@@ -601,6 +601,7 @@ extern struct btc_coexist gl_bt_coexist;
 
 bool exhalbtc_initlize_variables(void);
 bool exhalbtc_bind_bt_coex_withadapter(void *adapter);
+void exhalbtc_power_on_setting(struct btc_coexist *btcoexist);
 void exhalbtc_init_hw_config(struct btc_coexist *btcoexist, bool wifi_only);
 void exhalbtc_init_coex_dm(struct btc_coexist *btcoexist);
 void exhalbtc_ips_notify(struct btc_coexist *btcoexist, u8 type);
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/rtl_btc.c
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/rtl_btc.c
@@ -32,6 +32,7 @@
 static struct rtl_btc_ops rtl_btc_operation = {
 	.btc_init_variables = rtl_btc_init_variables,
 	.btc_init_hal_vars = rtl_btc_init_hal_vars,
+	.btc_power_on_setting = rtl_btc_power_on_setting,
 	.btc_init_hw_config = rtl_btc_init_hw_config,
 	.btc_ips_notify = rtl_btc_ips_notify,
 	.btc_lps_notify = rtl_btc_lps_notify,
@@ -110,6 +111,11 @@ void rtl_btc_init_hal_vars(struct rtl_pr
 	 */
 }
 
+void rtl_btc_power_on_setting(struct rtl_priv *rtlpriv)
+{
+	exhalbtc_power_on_setting(&gl_bt_coexist);
+}
+
 void rtl_btc_init_hw_config(struct rtl_priv *rtlpriv)
 {
 	u8 bt_exist;
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/rtl_btc.h
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/rtl_btc.h
@@ -29,6 +29,7 @@
 
 void rtl_btc_init_variables(struct rtl_priv *rtlpriv);
 void rtl_btc_init_hal_vars(struct rtl_priv *rtlpriv);
+void rtl_btc_power_on_setting(struct rtl_priv *rtlpriv);
 void rtl_btc_init_hw_config(struct rtl_priv *rtlpriv);
 void rtl_btc_ips_notify(struct rtl_priv *rtlpriv, u8 type);
 void rtl_btc_lps_notify(struct rtl_priv *rtlpriv, u8 type);
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -2545,6 +2545,7 @@ struct bt_coexist_info {
 struct rtl_btc_ops {
 	void (*btc_init_variables) (struct rtl_priv *rtlpriv);
 	void (*btc_init_hal_vars) (struct rtl_priv *rtlpriv);
+	void (*btc_power_on_setting)(struct rtl_priv *rtlpriv);
 	void (*btc_init_hw_config) (struct rtl_priv *rtlpriv);
 	void (*btc_ips_notify) (struct rtl_priv *rtlpriv, u8 type);
 	void (*btc_lps_notify)(struct rtl_priv *rtlpriv, u8 type);
