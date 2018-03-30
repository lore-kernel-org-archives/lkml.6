Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2920516-1522393798-2-15177872113167129460
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522393797; b=ZOfQ/NujTmJ7yPnRQVd0KYCVlBHiaDZ6A1HEiOaJWZ6sriABzU
    w89aR3tkQ4wToktemLnKKQ+nFu7ImYt+Iwg9DStDz1xckTHxg+xf93Ern0Lr56g8
    auNShiuxv1DJY+WHVp4YzpD6XeEv42Dw20yqGhUcDLlsYYGhrslqiCY1GYOcsYf+
    PntswjzM7YJ7rcYHgIG7XU6H+pQVsETFHzp0mvPpOghrLaTvxTFZQXmRCQaEl36w
    8pGoSgidn/35G8kWefzF7e1Y1nQr8Pl6AqZ9JnLbJA0OBDTt9W6M8/0VUgbZODoF
    k0jMm8Sl/b5INLjI6Rwk9FadXDT8ZlK4ZdMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522393797; bh=A9ZPN
    Xt1dJNyKROWpZWglZcNtOIU9hucTapfOqqv0bc=; b=LvUMoxWWGpBct2kkpwiTG
    CasT3AOlnSdZ9G/Al00yhpRHJYs1/3sP334PuMvjvzUmeig866yvgd1BG1KCXJUt
    TE1HBoNaAx19Rfnpo7xsbp2QjzQRuHi3VAF3NwHML+WGbqKwfhpOMBgFpNy2XeUX
    6E7vNzJ+VO/e3VUMydqCq8KfIf0p5jYJuclwOlBOnjLtmFpmPu6pHY3v4Ysewd6J
    cihGtVFRup8kGNxDZuGg8FKjv6Ue7iYewXnLZ287dN95fnm4MAkr1f+pjOEeY1pt
    RbUQcCjXhExjduEabYnKJCZ9qd/IYH8QWvaapKIZ5ghr9eTSVqWTD0YF3Jft0OWl
    Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOhXLk7OkFJcGWbeNllc5zxwc9cntg20wWlRAlMzJpMdJ+UhWCagT5PZhS/T0+/UrHEh2FxR8HO2FoiRejOC3XuUDFRT/flk/xMZdkDWYA6s7bkHJKPh
    Svy45TTXKaKybAZ6kj3zGjkU7GXma0aURSn9UAVJ65BmYC/y+7M3D6+nhNIILsUnA2quYr42/0wg22kQ50s8YsLuIltcrwBcUvW/wiNxJLoP6ExR6avJLwjc
    3NzNfhA37wOoxPhLytbH7Q==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=hi4vKJZ1_tbQI8ndI8sA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 17/76] staging: ks7010: Remove trailing _t from 'struct
 ssid_t'.
Date: Fri, 30 Mar 2018 00:07:40 -0700
Message-Id: <20180330070842.25224-17-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:0LSypAW6J8GSVEhLiFksmvg00UCe6nYt4Z7bxLjL5hiN/5ta2SQ
 c28RlEpcB1bjFfj2M6W77h16KvFx/3fkdjiUCYDtqjXQkyE4Pnav+qcCdwqF5nzcmcJZRPu
 6CqRqinqKaE5tb/pkRWlRXOxiJjlII4i8HBYqGnhX3e9tT8vWtKN8tZr5uJxPXVvCqa9uVb
 Sv57zemE6/iClR/S1TBjA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2DUSZXiyVM4=:4AzGc6QT7RBdZ1bSxrUxrH
 DmBQqeVslKJxutzvedqG2jLzmp6R2rAt943WhmBaX7OaUKS0ktY1Irs2yETWiTrBdLh7GQC03
 Hc9QewJr6/JgSRPwCHFFAzydfTkFzpchGMktDrsNIj30O7T1NbKRJB+sPvAH8C7LVjqrDgLG0
 xnOnk8+KBaYEyBc7QUzR36r3v5+P57BcIoGSVTXsKXdj55uUqqNDQsRdfjXS/gbWpqd0uOhm/
 pQT8w4LfDselQAuQ5rUNIV6aRDwuQc81pjhxxAaOdAGSL5HJl6EtW1o2HJ615KPYbTVDScQ6u
 XPtM7/T0HsfSGHGA2qVoud4yxK8AN7FKOAXVfF2DGujg/5RoyAo5A0V4W3w4Crv8PyqlTIr5o
 pQrzeuesz+s/3YQqwBB+sma+cnSVJ7juaZgsRXeD8I6KG2ibtuOXpA70x5fVp1xA5eThk9ojh
 3QaepgOhEndGSqCHcT5D0L8uXs8ieq1TJChY8c8jw7VzERjU/ctkhVjPdKA3yp/AOOAKzoSmT
 LVALloQAqW3GDN1v0iFKPIlnguzNaGWyF/C8D2MDHG/Jm3qph+a/YBTa3Wd3XJ+gUsWklNGXy
 ddqZftBGejso2vWVGo1TMQCg1Z5UfX7daRH/jnOMriYbGu4FaMZR6UDXOnCb0kOfEkPBkSBGO
 PE9bT/ZEITMIxRN7Y0iT9a2+rL1QbavwTwk+fG5qj32Nn7b6XJffk/AmzuGZhbjWgMdsHHrV4
 xTxjmRPUMyu5G6ykkCK5wiyJhGfvT8xirM5GMA==
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Quytelda Kahja <quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct ssid_t' with 'struct ssid'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index fe85e22c4a5e..e87153786d61 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -225,7 +225,7 @@ struct hostif_start_confirm {
 	__le16 result_code;
 } __packed;
 
-struct ssid_t {
+struct ssid {
 	u8 size;
 	u8 body[IEEE80211_MAX_SSID_LEN];
 	u8 ssid_pad;
@@ -382,7 +382,7 @@ struct hostif_ps_adhoc_set_confirm_t {
 struct hostif_infrastructure_set_request_t {
 	struct hostif_hdr header;
 	struct hostif_request_t request;
-	struct ssid_t ssid;
+	struct ssid ssid;
 	__le16 beacon_lost_count;
 	__le16 auth_type;
 	struct channel_list channel_list;
@@ -404,7 +404,7 @@ struct hostif_infrastructure_set_confirm_t {
 struct hostif_adhoc_set_request_t {
 	struct hostif_hdr header;
 	struct hostif_request_t request;
-	struct ssid_t ssid;
+	struct ssid ssid;
 	__le16 channel;
 } __packed;
 
@@ -419,7 +419,7 @@ struct hostif_adhoc_set2_request_t {
 	struct hostif_hdr header;
 	struct hostif_request_t request;
 	__le16 reserved;
-	struct ssid_t ssid;
+	struct ssid ssid;
 	struct channel_list channel_list;
 	u8 bssid[ETH_ALEN];
 } __packed;
@@ -469,7 +469,7 @@ struct hostif_bss_scan_request_t {
 	__le32 ch_time_min;
 	__le32 ch_time_max;
 	struct channel_list channel_list;
-	struct ssid_t ssid;
+	struct ssid ssid;
 } __packed;
 
 struct hostif_bss_scan_confirm_t {
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
