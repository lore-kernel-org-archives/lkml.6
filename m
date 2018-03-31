Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1160787-1522476681-2-7797505768356635655
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522476680; b=gqw4vRcEkOrUIvT8LC99bF1KhtaRrvgStHDaW1v71L4MXo7sTT
    2a34n8+oYJSxc3OJeEjkP5q3J1wBMzywdwT/rXSGjwWXtmqeMnyQeN3ap2r1L6IZ
    DUOtyb0cbNK+7mYO+M34b5hbgrsG7YRn6RYRwa7FszLhrzVWoc73rFImgr+zGWA1
    Kh/358ADrkZYw3qd6A94w8D+JdwyrHz0VSDi1cApeRWUHn8/R1z0f66LVNsQDfg7
    I5W3smOMkhlo3QFRJGSluGRh2DzvF/7xiehrLsq9RC5OeLZWSPY5cwwbYR+es8Dq
    UknsvZdBRGpJ2SdNqlU5s4nHPonKkVzHcSMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522476680; bh=gv3WD
    GH+KrVDXco5ejCz03SuEkYaZ0T1F6F/HFSynT4=; b=QQusOXYoyVUePm1Ky++2X
    BQu1j22FJYEB41aIHjfUfVkn19Y96K5rf0fvShJCE/OW76mJObsvA8Qq713k+Ylz
    zq2q1I++lxPLGp/hsV4NTnTHg5e8z3MMJLWn20x8hE+AANHHyi6wx5jUYLHzhbqc
    Tl+41Uq24LLZ/FSJkH98XKyfOHkhEr3M+C+h1dt7JCeAPTUpZ66Ez9qEtWHP7T1+
    K/TctUTYeb0woXcZ4/dza7PaAVCZrFRweYJzXngoHfSZ2rBHWBJVI7Av1TI93t5M
    6AotEB2CjYnFKx9nOg3Vp/V58Gj16s32wKzaC3amYia/Rj5JuRZoM35ZRlaLzsDe
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCygk/0RpbdupYGi7DbvfeXEIM9zUGvTZCthzdlvtBvfLHZ5cHoQqSjrP5imp9+lt+SiEPznZtxUvjXbDpQQCmro5Lsb77sg+r5RHH0aLRSjRyDxATBH
    FYAvmBdaXSxEvZbdPEXbZylsswFS0tszN4iZyNaDq8lRptb+BsJuB53x8jnpUaaTx5M0kWPDrb404S2SQjDeKz96GASv3zDshEek3fsp1o0zlg5AL0zafD01
    lOBJJMhG9zr+PtpM5jnvDg==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=V_zipIKupC2UuXeJSREA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH v2 45/75] staging: ks7010: Remove trailing _t from 'struct
 hostif_phy_information_request_t'.
Date: Fri, 30 Mar 2018 23:08:25 -0700
Message-Id: <20180331060855.9452-45-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:xiHCalvSe6W0OcmW95DefhtvEP1BxwyILNV9VKoX/y5izeEk6vr
 IVgBBnJGvVvxeK6f6Jg3iQY+Nc14MJWJEPJklHgevl5EUtyL4oe4xIKVjUsKElvybm93pZX
 V+3eyV/Kb5LcdFIiDzi7FTr1Bgz8G+LXE84+cHvuP0dgG3v2FI6S7Xd246QRid9q67idtqt
 Yp0mklmL/GsI/3b2/ahMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sgoyBfa8KoM=:uI/FWM6xNRkHkm47SF8FZW
 CeGSAx246StFtBeOakbnS/GrpUpfqmD1bxKaZ1fqid5WdVdegzoVuUMKETKq0o1NBm1FV3k42
 geSH6J7vITFqTUb1XtB996bNvM6QEJpWCarOx0QPeZ8zOwDE0v0q8gr5g4Ve9NA3naZyD4mIq
 a595tINKLaMcgGEnoxElgpfbiK/VHg5GG2cEQJKHmEKUVcYKFR/+aQQ3b4Sb5cwWmn3BuOsoT
 gzXFB3UimNo0M+tntva74dqzV11XRFtdxYIvH5FQNV0/8jylMyO4o4T2SHX2sQJyX2cvApJfI
 oZVf1uRJEZpDgk847c8gcbanzZ0fo1466befbKPnphL0a4oeOT/ucoft6NFT+vRlZvSztVkZs
 qWw0N/ESINHHCfFqI7i44Fv1BzN5Xx0xGc0zIsXdoAtI8WgQt0ia+RuFu5M5cuL7RQpmVrUZ/
 zBjga6HOTugyqIqA2y73NGpy9ZyLsOcloYQ0ZOWz7dXqo6QHcG7W7sQf7SeYWVI0STb9W9/xh
 S8Bf35O+4e4jSsTYA4ex/ZTt+KTsP4HBf/yE5VeLaX7XflmWMvwSqoF68kuxwrFuBVBDZnqyi
 UmVDden8gVFs/TXbxROKjcYg8RvunE7bOuoFryPJWtGYoamDeNd6eJz0h3sQRfEjZ97ccf0UN
 QdtbPl22XFqqdkU0qgHqxYzP+BldbkWylbJfog+3gHsgpLl2eckD8XwOLipjC19Q4ifVAOB5M
 a6E5c9vs8KRvmdKesrlLCztZADbU2jQ0/yEmgA==
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
all occurences of 'struct hostif_phy_information_request_t' with 'struct
hostif_phy_information_request'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index aa827949db7e..4bd8a285eac5 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1440,7 +1440,7 @@ void hostif_stop_request(struct ks_wlan_private *priv)
 static
 void hostif_phy_information_request(struct ks_wlan_private *priv)
 {
-	struct hostif_phy_information_request_t *pp;
+	struct hostif_phy_information_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_PHY_INFO_REQ);
 	if (!pp)
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 1aa4da0f5403..348fa2844003 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -401,7 +401,7 @@ struct hostif_bss_scan_request {
 	struct ssid ssid;
 } __packed;
 
-struct hostif_phy_information_request_t {
+struct hostif_phy_information_request {
 	struct hostif_hdr header;
 	__le16 type;
 #define NORMAL_TYPE	0
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
