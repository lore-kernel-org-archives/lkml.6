Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3785732-1518767675-2-861711864709920675
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518767674; b=PCvabFPMFSFgEe/zgrA66CfJqeHTpayO9IV1TpEq0jsIUKP
    LPJI0cpNgAvqJA2X9juqQtQfpXEmAFuhmEWs5GuOYnaF0+TERjn71truBPvon//S
    57en7hZdfMH5eubOAo+eVLNCMHS3wP/zTEIOUYHLCZQNuU2U97wY/1S8tvFXQrL2
    i324cSonmAVH1rFjLSwX2BOIjvlhqqwytwgPbVepMZCNgKH77exNC1zLWI3rwvpp
    Tj+HvdBwZB55MFtXgTajzyWAuxIyWUnLXSUtmwcr9+P49XqnvdmKjKghpr8YxMH1
    k07dJJ7Rh+I8EgAmD80gO36w9PCO/MhpoNJhMbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518767674; bh=W
    JaCPFVXIsmdsUR1yrmGbYovAQKhZVirwmOKNbLRuQs=; b=BtI82tR2nqP/Z4SMR
    g/HBnt3msGCIqP/ze6bYFmZxNSsNtJ5uzinwsJq6az8KRi1SDgKgSQyhhMxiVUHD
    a9jPEadZtfP4+L7wh9KIRJqFezAR4IrHYEEPx7R3tMnbzi017yvNANuI339JXpXN
    FDOdcfeArnvCUVvT+/NPILP0QrNfPK7pIXJ2FYg0YV5gj2tSnLF2BvoC/p5CTRY+
    b0w00W/cRm9WRIWFJF/tdZmE0Pv5fkcjUoj2ALifrgsyeSrachYnYQ75O0rFGo6/
    Gse3OF+F+zB0aIjZab3Bi6wWrc00oAJ+BlrxZalbAT5p1efP6TqdHfsLvLzRBCAl
    M88ew==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=l13ctAwR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=S7OmM562;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=l13ctAwR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=S7OmM562;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x2276iu9ee3JowXzf3lnl5RQXt9cbG6Pk9V9y1wBX0mmwDRMRog+HyqLBOXuUHUoj8+jMALEEWQ==
From: Yash Omer <yashomer0007@gmail.com>
To: devel@driverdev.osuosl.org
Subject: [PATCH] Staging : wlan-ng: fix unnecessary parentheses in prism2mgmt.c
Date: Fri, 16 Feb 2018 13:24:20 +0530
Message-Id: <20180216075420.19269-1-yashomer0007@gmail.com>
X-Mailer: git-send-email 2.14.3
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
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch fixes up unnecessary parentheses warning found by checkpatch.pl script.

Signed-off-by: Yash Omer <yashomer0007@gmail.com>
---
 drivers/staging/wlan-ng/prism2mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/prism2mgmt.c b/drivers/staging/wlan-ng/prism2mgmt.c
index 236961e3ba0d..90cc6cdaaaa8 100644
--- a/drivers/staging/wlan-ng/prism2mgmt.c
+++ b/drivers/staging/wlan-ng/prism2mgmt.c
@@ -1065,7 +1065,7 @@ int prism2mgmt_autojoin(struct wlandevice *wlandev, void *msgp)
 
 	/* Set the ssid */
 	memset(bytebuf, 0, 256);
-	pstr = (struct p80211pstrd *)&(msg->ssid.data);
+	pstr = (struct p80211pstrd *)&msg->ssid.data;
 	prism2mgmt_pstr2bytestr(p2bytestr, pstr);
 	result = hfa384x_drvr_setconfig(hw, HFA384x_RID_CNFDESIREDSSID,
 					bytebuf,
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
