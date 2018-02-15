Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2243538-1518720536-2-18124099681309556610
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720535; b=Q70Bw+T7xfi0z65rMK65a7uO4r75WxtsPewS5U92jzRDaX+
    YjBV5Le3fV6B4IQ5FnPKf72kv6mp5vn6YzhGNS/5fbVQN0H0C8Y+Z0QaP8CqOD5W
    MpT5zeHs90wPQHhYPykqo2dXHEzpY7JcHNS9PDO5WiW2n7/b2DC6yBClSvke4JYe
    hryLqJCCWl+bvGWUZRr6TjQbYibbVFWC9vpFM4ByRhn4AVl+H37Ux8+oGWI5NbkM
    6HWq2AixsAgC+bvd4E5pEMIK6KqmJQTJ1iGp60ax3QBWAs9znVTuJZFdVgLEH86i
    wvSwr2ysSObNXdBxky0HYIHcN0QZYsF3Ny/Kgwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518720535; bh=W
    ZgASSl568oniXkStqDtEBxioTQIrxJZ2G5MAr8VKXw=; b=UDxlju6VFj/17rGAh
    XKW45asN5gydYU1TMBMHJpufjSuykhmXaAWTCXEZTFt3ZHl9ZwVcHM4T+hT20ex5
    fF3VZw1ZJhofMwx5SPB/PTRiX6u6U5AlfjhOTjgr1AGOfpdFU89vTvCbz+csm4fy
    9YAEBJBq73Rh1znabZipdQ1rQU2yGgSdaBRZQ3SA0u/F5uDxJGDpfayMRJHgywO/
    mWSlmlWNHJGf/2jwuQT24PAbplIitg8W/mHBMNxKTbci7y0sXAdOG2lpquQo0XXA
    4lqQy+/xdzxDf87fpnc6lPbmZwQuFe45okADycDODQv4vVYGrZNeFSH4rHc0UrwG
    iRaCw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=d4lp178y x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ehDLcvEU;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=d4lp178y x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ehDLcvEU;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x226GpGXb30R1A1V10TQJ+eUqj5G1AX9+w8PKSKjf0IBA3yoeOoUKYOS4dUHwJXtpaYfpJmjqRg==
From: Yash Omer <yashomer0007@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH] Staging: wlan-ng: Fix Alignment should match open paranthesis
 in prism2mgmt.c
Date: Fri, 16 Feb 2018 00:18:36 +0530
Message-Id: <20180215184836.14897-1-yashomer0007@gmail.com>
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
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, dan.carpenter@oracle.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is patch fixes up a matching paranthesis alignment issue found by checkpatch.pl script.

Signed-off-by: Yash Omer <yashomer0007@gmail.com>
---
 drivers/staging/wlan-ng/prism2mgmt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/wlan-ng/prism2mgmt.c b/drivers/staging/wlan-ng/prism2mgmt.c
index 5be1af20d2d4..974a7572fafc 100644
--- a/drivers/staging/wlan-ng/prism2mgmt.c
+++ b/drivers/staging/wlan-ng/prism2mgmt.c
@@ -264,8 +264,8 @@ int prism2mgmt_scan(struct wlandevice *wlandev, void *msgp)
 			goto exit;
 		}
 		/* ibss options */
-		result = hfa384x_drvr_setconfig16(hw,
-					HFA384x_RID_CREATEIBSS,
+		result = hfa384x_drvr_setconfig16
+					(hw, HFA384x_RID_CREATEIBSS,
 					HFA384x_CREATEIBSS_JOINCREATEIBSS);
 		if (result) {
 			netdev_err(wlandev->netdev,
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
