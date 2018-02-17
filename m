Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2544280-1518861421-2-3283310832028855317
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518861420; b=MqhuDkcYdjZxxi+2ygsDvRG2DmzAON9pz+6gsPCX/n3Tawb
    3lUMvtl/YskRcFzO7bECJxwZqUC/jRk0ixC3KFPr4zVLPPEKydRHLVLhPZ6BoPTm
    2D240ZOyXU9+/HzHftOhrcS5djfWPdjeVJeu04uKeeN/96gu2LtPhbNubZrCceTO
    kPo5iNa5O8urW9g4l+ets4AjyGUwxlG5eAEQV1ToKYHC4DltqbRsuny0WOgPsQ0u
    PvJMFotQvacQVTHGY+TJZG1Z5pmy/1L2rLs1fj0+wFor9ay0XbAK3SARVNFeHciX
    pmswLTkNtXfjLwLkysvd/BP6KZk5H12x9oPpDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518861420; bh=z
    IIhWxOjv5wlt4CGKorWnMdSTHfvnQuCQPss3fHHZp4=; b=S4kthRP6kAL5M+rLA
    ptwFHeu6IALr+W+oG/a4wyk8rpPZMoqxHY8BZr3XGfeIw0PZc6UZoil4J+MJM/6p
    z+EHfGHegQ5MlWzku+oJI9k2xP0hdhZHrM9xRG81cjDd5BbQv63vXZ+eikTDyuKZ
    NCqob0EOo6WZEWxi/29sP3PAahJIwxAzJaqv/zieRP13eUqbLGqHgUKSv2pdCpH7
    CKHkP9f2gq9+X6pDgpngacNCGrplrBHcLmeln5eWBL7tjfWaAzZvfEQVgNBoptpz
    TrVZQjh9i8hfNWaOSZEsw16iU4ZOSPfDCHc8Gqwn/pphznce71v+3JrOlFTV3cQc
    FmmRQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PvXXzgAF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IJjzBEqV;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PvXXzgAF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IJjzBEqV;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x224x1vbqzTf24JZy8ECBF1/ElKS+OIw4C3Ir2hGn3jPJTSVjJHndJuyZiGnqRgklwVqE4667AA==
From: Yash Omer <yashomer0007@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH] Staging: ks7010: fix unnecessary parentheses in ks_hostif.c
Date: Sat, 17 Feb 2018 15:26:45 +0530
Message-Id: <20180217095645.22946-1-yashomer0007@gmail.com>
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
Cc: devel@driverdev.osuosl.org, florian.c.schilhabel@googlemail.com,
 driverdev-devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch fixes up unncessary parentheses warning found by checkpatch.pl script

Signed-off-by: Yash Omer<yashomer0007@gmail.com>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 7bd567e233d7..36055652842d 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -36,7 +36,7 @@ inline u8 get_BYTE(struct ks_wlan_private *priv)
 {
 	u8 data;
 
-	data = *(priv->rxp)++;
+	data = *priv->rxp++;
 	/* length check in advance ! */
 	--(priv->rx_size);
 	return data;
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
