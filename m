Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4155484-1520330435-2-14625554242818166938
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES daen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520330435; b=FdVTs5vFNyFyAaBhXtmC2zCv9UwXuJ80jYAVBACoClrgvJ8
    4XnFo65P5j8m7oE7wkcjcDWL6L1idavGvBEULpKUzdFFOz55qVmaInDiqX1bTmwO
    7U5XtW4E4ZkLSxjCPjxso10+tDuQItdl5/47trpM2hnf9bfiaJunznPPSnDqfV0k
    e0vX6p2/Ny6A3OfWdiX/hQuBK43vhev9CxYwJKzIblyts8aVYkWrOtCgNG18modH
    XK1SxpArVPqQkRe61Oy4tuRhwoiewec7yrEehizzbGui5SvEeq8UuEdwZV3wrTX0
    YrqLp3U0Hz6IEoXW+Qz+l4PvIdBxsZJaXybSxUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520330435; bh=0
    6mZOnVCRUWkeXCi1RZ+GFO1sBTxstxx8wgSSosm/y8=; b=MQu8bbGPRqLF4mdxp
    1RL/loZHHcsf6JE6epOKW0b8Qgt4Dt5BzQPRJwbmvxB2CppXVMzZMY7kAESoGJF9
    JoVfOucsDFPTwcG9/jjJDrIecOUvWF6SX1189Dj8xuf16TVzjbNqOL/QbwKGmAso
    a/NGnwiT24GO6INmSkieD6bduwl2FnD1pNWE9aL9KxGHXTXdQ57LpB30gFW3OrqX
    vQF2WwhTSaeiOJK+XZgGepgjjdClyWFDSHlyWUTOIcQ1Na8GuDPxp0hmbHJLZahg
    kloekAB5fyTnbgDPK6TkI1UxcjiwKU/kRHtlp8/e2jWDazoWsos2oPeRpoMN6cFf
    g01ZA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH] staging: ks7010: Replace literal with constant.
Date: Tue,  6 Mar 2018 02:00:04 -0800
Message-Id: <20180306100004.19416-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
X-Provags-ID: V03:K0:mgFeca0/v008agY+b35pZOSTZ/L5SePXXPu1h/ar13ppRMNMgA6
 r0nyqawOL6RrGH5SjVn8OhA1+GNmhsndPbbscBOJ/1nT1hZRu5TL9sEGHwEaXKVrSv866c4
 qOUEoxO3G0bLPKzgSFINYzqPkEixO10S/1npqR+M9NjPk0nGfumuBby+0pX086Q1TSwGT3l
 7JU7oVaQTyD0/88pqdP1Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EIS++cdamm4=:SqfyY/MJDLE3RIB2o9KDNO
 lliRcTnH3FAaRcy0RLc8AdfWMQCHL2jM13XCd6zmVKdx2FbACEyUWnQQPSBpc1L6LPRZjjEJR
 zzMPz1v33ss1Ve34tSnz1CbSrQZvqqjw0GRni1Hmz92B2NCfUGgwpdqrhh6b3iQyF6iYTbPgm
 KZKMBuKArIzElPC33Q6ZHgFcQPc0DIM7xlUm5In1iO4NDq3Du5R4DHWFk3suH8Urk4bM8IGWV
 9kzDxw9oMhBZJ4fZNkk8EUzAO/xbstc86++Ake3y5pYV1rfnfVQvNoFjDtIXRP2p/fkD1RSYw
 dl3mLe/uBxZBB4hAwu5u+vwoocIMy2BF8eO72wOMGKg08Fcp3g7MH9O5UTmOghm3jfXK9w8qZ
 f5lT15Dg55p/luxK1dRBEa5Z2SIp0DX47KfsOS7qnAY/U+F+WZFCmXS2py/d3vUzRPHbcVV9C
 +6HluPWckJR1soYidbHtYAYUEDwEUui5P2c4hu/DQBRaVI2JMNzMmfpkPHzwPugWoOzAnGN7N
 RTeurNPcq9JPWNmVjZB0aP57D9O1QkZcKf0EXclF1mCtaSyCwJ/xiYQgszhTyW/JRztZVXO/n
 8dPdcoijsvNA9mV1sLRHp93QYUQw96Vl65/3xJc3m2C2FKqyNMvnJyLTOkBZ2HOnixBtbkEDn
 TIxEOXtFlmuHdRZwFygQmkYYn6jUuZSXRwFUORS6YChIM4n+TPDoSgkQQRjO6+LGmRke/bW2K
 qfp4QeJJsRDf/iVydGTTGAr4srf+tEfKfgKH1A==
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

Replace literal bytestring with CIPHER_ID_WPA_WEP40 constant.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 7935ba56bb1d..05f7be4638fe 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -293,7 +293,7 @@ int get_ap_information(struct ks_wlan_private *priv, struct ap_info_t *ap_info,
 			memcpy(ap->rsn_ie.body, bp + 2, ap->rsn_ie.size);
 			break;
 		case WLAN_EID_VENDOR_SPECIFIC: /* WPA */
-			if (memcmp(bp + 2, "\x00\x50\xf2\x01", 4) == 0) { /* WPA OUI check */
+			if (memcmp(bp + 2, CIPHER_ID_WPA_WEP40, 4) == 0) { /* WPA OUI check */
 				ap->wpa_ie.id = *bp;
 				if (*(bp + 1) <= RSN_IE_BODY_MAX) {
 					ap->wpa_ie.size = *(bp + 1);
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
