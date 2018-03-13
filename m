Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2795102-1520934186-2-14603736967716609471
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520934186; b=uiiToJTffw6oZo9Nf/N1/4dBAnrQtuuIiJ8L/b1JAx36YL/
    Z5LiPUPivZ1UtZ3HMDm0bVJLyOzACHjDoCrNaYhAsZtgye/CT8FF5RYPrXYM2Os3
    z2LtpaT+VCN/g2Wb3UkALhg2G9jWpHOZ5p9yw3Eay+75S+gXE1BAj3OC3YdwLOQ9
    sb0vgG6naHxKwwXTWcOK+OxDj3LB6t5zwusy1zCXoBH7NxOVaxzYUFB+J7ciUZUK
    Fq92P7dFS9tdoa9FYQcW+r+KjcgRaAx/28VzF5c3forYU2iMPTMIvBl4K2RUQcGb
    FMerKUFRUAHsECBsaFO3BpEZGTYTflxLsVvf85A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520934186; bh=H
    jbHk3RQBYIhYp8mYUAbArk9TKYf5XN3d7KiG7qiIKo=; b=gpAnVvMSrvXffyiAV
    u0cfFmc4pUvGw5JZaVzOpfUZ836/Z/O7YJzyNbKqNAsShkjx0qUcMW/6Is7tyDSa
    sH8BcScVxdCZ76DRn1HXj9M11mI3jwMQWzfMK/zsMcXEph+PBpsFQDVrppM1iEIY
    KjsS1O/LKrcsKbc4aIFQUdJJK2of9GKaVWFh/Tw3Tnb39cFcF79IUmWyHKmcND8q
    nlOupMXVzpcvNSNedSqz96i2kdp/8OzJCO0MfKs1hFctvA4mY6PrWivmp02rD6l2
    ZmbvMfZufNAz/gzt0/2Q/D/qecTBm14PpqFCa14G/h2yLZEGt5axlipaHfgIX+AE
    HpHUg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HyAJZmw+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tAK7587o;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HyAJZmw+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tAK7587o;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtSiWEFiqUxh30ZRYHwRLjk/TCaNScg8SnjESJ4RqXzJ6ISHchEZNwi3Dp53I93dgD+0L6z/w==
From: hariprasath.elango@gmail.com
To: aditya.shankar@microchip.com,
	ganesh.krishna@microchip.com
Subject: [PATCH] staging: wilc1000: destroy initialized mutex object
Date: Tue, 13 Mar 2018 15:12:10 +0530
Message-Id: <20180313094210.10305-1-hariprasath.elango@gmail.com>
X-Mailer: git-send-email 2.10.0.GIT
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
Cc: devel@driverdev.osuosl.org, vbabu3@visteon.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 hariprasath.elango@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: HariPrasath Elango <hariprasath.elango@gmail.com>

A mutex object that is initialized but not destroyed.This patch destroys
the mutex object

Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>
---
 drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
index 205304c..c901108 100644
--- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
+++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
@@ -2303,6 +2303,7 @@ int wilc_deinit_host_int(struct net_device *net)
 
 	op_ifcs--;
 
+	mutex_destroy(&priv->scan_req_lock);
 	ret = wilc_deinit(vif);
 
 	clear_shadow_scan();
-- 
2.10.0.GIT

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
