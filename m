Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517682865-2-5281235817853218053
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682864; b=dcI94Nq3lcDGNyQ0fU4cGa7Un3+ikTNO4AeHbFfkV03Rgts
    H6F0XvAstBfJ4wILCEVEW80LQAjgXQTKw/SW6GNo047N0ihau+dK4mMqG5vl7k6i
    xnV3hioXTSX8VkR+lhL/2fW1n8Ju6q6fLdsCVXflg6jELKE81QWHYznDA0VAOrQI
    Dxx0q53qCzZMO7T4bMTeA62+OS/P0NiH2Y6x6XWEn1IyrbzcIKuailp1gD0X1Yv6
    FRRjjN3RTUCRXtenjiVBO1UrS6RDoHRld0etJvCfyHR5/2RlBypW7NAmiTbFnyU4
    21/MvQ0eS82RMqzqapU2iBq7JsD5keMXs/+aHQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682864; bh=PreZyq
    pZiEzIF05CwckKGlikLTOqhmVHmJN1qFOcrks=; b=faxXAH+epWxy3avGkiQGmV
    pCbospI2CQRgwMycx9OR7zGw+9ntUfs2LkUw/KLkXnRfuDiEKkE0iRCNftKfGsIl
    pOzazOicYZ/nGb5S/5YONe7mdv9TulzNMTL8R0tQISIhPQ2hr1ejCNICl3oTQ+o7
    eOaPTtOPIS7vCNvUeLKkQ9j58ajgZMANPLciNSxSM/+5EEEl2uklSrNFNDN64+O4
    r/2pDd8GNxCbNTna4nL5Sllmz/wr6LCmJJZTv7HdwWcvqPjLU0ODLICY6hkkWyzm
    pJrF4hux0bumWoxkP1nOpJV69QMTclegaKhFxhy9DPuBvEQ34sRl23bkakV4iZtg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Inzqh1Cd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Inzqh1Cd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752884AbeBCSeV (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:34:21 -0500
Received: from mail-bl2nam02on0109.outbound.protection.outlook.com ([104.47.38.109]:45293
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752839AbeBCSEX (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:04:23 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Loic Poulain <loic.poulain@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 090/110] wcn36xx: Fix dynamic power saving
Thread-Topic: [PATCH AUTOSEL for 4.14 090/110] wcn36xx: Fix dynamic power
 saving
Thread-Index: AQHTnRkCMuk4TolW7kKOkryyGwevHg==
Date: Sat, 3 Feb 2018 18:01:26 +0000
Message-ID: <20180203180015.29073-90-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1041;6:e+w10NlXxhzRr1izK9lGvTCnQoxEVBkagEsFZi4o2lHYWbJopl5eeX/J/J5U+nCPgKWTzmbR5jg98QBel0Op+ugVb9nt7Gf6R/lt+trKuTbiKyyFox69L8EpnNy3AvIy8fVckwZ6ywK+5HQZdKG0/njXPiBgB2M5q0+QmBen4QuEZo+1ajC8Obbv6/VMMv89/wTwsz6d4+TXxnPqjCyx4n245KigaxQLFoc1z89V0YHLsoQ4+3lATlitDdrJbJSKRK8uwFXzvWbPmzjGaZX8CA5+PmhQnNgoreBgWpMTtqiTzxThEsdhi6CigZSvJO0/2FkJ7XzKxzv+EEBR+CQuPR+6IPkW37z7pwAfPxyTssZZabzZQqkt9TWyeueEmVUs;5:CT1dEREZ/pbxuKif293n4CPWlfdN3t9davswjDrjoPgxy4ZDT67pDSX7eptTnglzahm2hxVw+bHlMkyXb9ntmAWcrDKmw2Rgi7WYdGlD1PwpozlHOiYAmASSw2OeqkH49S1S+8uBqcyUTNJurKfA8p09GllBU7/9sxF5RZaJVz8=;24:eowqquIhaRcCM08q9PDP8K3Uw7fbOtB3Gqt9E7VwDDvEy7NSdABdtVUT9VTuuT45D2scO65cXiXi/jpza+5TFrWp98rfoohcXJHbR8DcnuY=;7:NCEUsEbnh1KzLzwypX6bHyEyRQylEyxWh6NVaSgXOfRyj5OP4maXL7qitVX+cF9kT5v2nCQZ9Hln4Mh52p7U0EOpHESO8vdiCJdiItwvXo/DZhcu+B/1qz080g2g/ajojr3QDIAfee7083byZOHFQcdLTzLQUK/QHPn8nZg/Cvr5FOEUmDN9ThSocKsIctFeAUYIpzNXmm3Nh5ItORHKKEo+H37fLn86CHN3XLjr/jESqELRDp3WKc3tw6pYt1YM
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 15a7cb43-b265-4e0a-af51-08d56b304280
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1041;
x-ms-traffictypediagnostic: BL0PR2101MB1041:
x-microsoft-antispam-prvs: <BL0PR2101MB104186AE3B5D1DE781566FDDFBF80@BL0PR2101MB1041.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1041;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1041;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(2501003)(305945005)(3660700001)(5250100002)(81156014)(99286004)(81166006)(36756003)(7736002)(10290500003)(106356001)(53936002)(5660300001)(316002)(22452003)(8936002)(54906003)(110136005)(3280700002)(478600001)(72206003)(4326008)(25786009)(107886003)(102836004)(97736004)(76176011)(6666003)(66066001)(6506007)(2950100002)(2900100001)(68736007)(8676002)(6116002)(3846002)(186003)(1076002)(6346003)(105586002)(26005)(10090500001)(2906002)(6512007)(86612001)(14454004)(86362001)(6436002)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1041;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: z4quOP2W9MaPWRMBwnW9Pm8BLl6cf4s8z7H9S3sswLWpTstdinL6sOWYw+a4T/Rxq+B9VPwf0k32gWTtFaRZ7w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a7cb43-b265-4e0a-af51-08d56b304280
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:26.0503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1041
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Loic Poulain <loic.poulain@linaro.org>

[ Upstream commit 0856655a25476d4431005e39d606e349050066b0 ]

Since driver does not report hardware dynamic power saving cap,
this is up to the mac80211 to manage power saving timeout and
state machine, using the ieee80211 config callback to report
PS changes. This patch enables/disables PS mode according to
the new configuration.

Remove old behaviour enabling PS mode in a static way, this make
the device unusable when power save is enabled since device is
forced to PS regardless RX/TX traffic.

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 23 ++++++++++++-----------
 drivers/net/wireless/ath/wcn36xx/pmc.c  |  6 ++++--
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless=
/ath/wcn36xx/main.c
index b83f01d6e3dd..af37c19dbfd7 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -384,6 +384,18 @@ static int wcn36xx_config(struct ieee80211_hw *hw, u32=
 changed)
 		}
 	}
=20
+	if (changed & IEEE80211_CONF_CHANGE_PS) {
+		list_for_each_entry(tmp, &wcn->vif_list, list) {
+			vif =3D wcn36xx_priv_to_vif(tmp);
+			if (hw->conf.flags & IEEE80211_CONF_PS) {
+				if (vif->bss_conf.ps) /* ps allowed ? */
+					wcn36xx_pmc_enter_bmps_state(wcn, vif);
+			} else {
+				wcn36xx_pmc_exit_bmps_state(wcn, vif);
+			}
+		}
+	}
+
 	mutex_unlock(&wcn->conf_mutex);
=20
 	return 0;
@@ -747,17 +759,6 @@ static void wcn36xx_bss_info_changed(struct ieee80211_=
hw *hw,
 		vif_priv->dtim_period =3D bss_conf->dtim_period;
 	}
=20
-	if (changed & BSS_CHANGED_PS) {
-		wcn36xx_dbg(WCN36XX_DBG_MAC,
-			    "mac bss PS set %d\n",
-			    bss_conf->ps);
-		if (bss_conf->ps) {
-			wcn36xx_pmc_enter_bmps_state(wcn, vif);
-		} else {
-			wcn36xx_pmc_exit_bmps_state(wcn, vif);
-		}
-	}
-
 	if (changed & BSS_CHANGED_BSSID) {
 		wcn36xx_dbg(WCN36XX_DBG_MAC, "mac bss changed_bssid %pM\n",
 			    bss_conf->bssid);
diff --git a/drivers/net/wireless/ath/wcn36xx/pmc.c b/drivers/net/wireless/=
ath/wcn36xx/pmc.c
index 589fe5f70971..1976b80c235f 100644
--- a/drivers/net/wireless/ath/wcn36xx/pmc.c
+++ b/drivers/net/wireless/ath/wcn36xx/pmc.c
@@ -45,8 +45,10 @@ int wcn36xx_pmc_exit_bmps_state(struct wcn36xx *wcn,
 	struct wcn36xx_vif *vif_priv =3D wcn36xx_vif_to_priv(vif);
=20
 	if (WCN36XX_BMPS !=3D vif_priv->pw_state) {
-		wcn36xx_err("Not in BMPS mode, no need to exit from BMPS mode!\n");
-		return -EINVAL;
+		/* Unbalanced call or last BMPS enter failed */
+		wcn36xx_dbg(WCN36XX_DBG_PMC,
+			    "Not in BMPS mode, no need to exit\n");
+		return -EALREADY;
 	}
 	wcn36xx_smd_exit_bmps(wcn, vif);
 	vif_priv->pw_state =3D WCN36XX_FULL_POWER;
--=20
2.11.0
