Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3852358-1525644195-2-17275008633137556046
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525644194; b=aqAoh0Tp//GYk2KBWS0rlO9bhgEkgGvk52j1grCJW24nxxD9m/
    HrR3cWDKTxTnShNbUsJcKg5SpCtFvK/W2WDnYlyjbkafSSc+ZyRoZMCMEvajU3JR
    Bn0jm+18bis3j1mO+V4DzpJOLpga9oBNj282ELKXkFl2XN0ra1KT7JRbVmsrM/ff
    TWLZziomBGHWmNOmeE8I1xMwiNAH2tl7OabeEWJaeC/kkO03t48mU4k3f69woDAy
    VThB7lg2+BC31XIjL/L4Xp0DrI1UHtKrd5/H8np9zN6IgXHv1MWCKMfrT/lDub9H
    1RMOX0/knOastNkzDph0CRboSL9Ieg1E+49A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525644194; bh=/Kuui
    Fppy5FbgZgwp0Cf7n4MQrFyVPJeMuH1rbRpouM=; b=KWiUkZmIuM4wJnzPuyNuZ
    AHugxWcxuASJ8EXTkntRJYIb4xQSoXw8BC5C0uyIjkslXD0pEref4BIYp4MDe9eU
    1UJ9nq4cFlIqEBl9/iSG9pRhY9YIDoXA5ZKtTNQEZRPedhWRGpG8fhO7Fg71TjIf
    Lzhzxg5FJ6j608urMiyJL4rSZIbSELgUXXRLGJGyXaA3c+V9donck+AmY/so/L6I
    Q+NY/TAKd+a80djDbZ+agco8viKn8qC6uu504iQczpTuQ2CZpctU6iP5MkrQKse3
    7emyNS/kLLENP5zMYCjkzZ81iQBkt4+lbckLzdqWJYGTlvAbL+sEpgo/JzF23tBo
    g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=Gh5LZxhe x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=SFb88Pax;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=Gh5LZxhe x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=SFb88Pax;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAiFB5zOGYbyPo8+Q5eq24/QQld2H9qU3s0CaAKgEhqxGbFtF82aD9gXFAGiOHo4oPQAljZsRhYj4Wa6xPgxid8DSLGmjgbtr5HGuZUNdhjLVsey4Ppo
    dSYKuIn/KwKOhdJ3RX5bV574cngF/sHMDoPXRgdil6HcaF2Eteb5uNz1drHKtrg/3Blf+1cZE4HxGRzBftLinAddSJLE+AIMEYPvI7JrG7GVLfvsltmcBrcd
    HAvGrfp0EZjar8YN0F4XtQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=TpujumX0jH7REod0KhDaHZOp9kI=:19
    a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=vY_346TuTMEA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8
    a=DDOyTI_5AAAA:8 a=gwzNNryNW8B0C65ZW-kA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZpQdslSeaFU7b/sVr5oQjwBXyBmTL2s9diAheE5Jga5dmIrM8jzuRSWjNaWAQgyguqiJTEqwQ==
From: Nathan Chancellor <natechancellor@gmail.com>
To: devel@driverdev.osuosl.org
Subject: [PATCH 5/7] staging: ks7010: Remove unnecessary parentheses
Date: Sun,  6 May 2018 15:03:02 -0700
Message-Id: <20180506220304.13040-5-natechancellor@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180506220304.13040-1-natechancellor@gmail.com>
References: <20180506220304.13040-1-natechancellor@gmail.com>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Chancellor <natechancellor@gmail.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixes checkpatch.pl warnings.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/ks7010/ks_hostif.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index a2833707e0bf..094f8c11b4ab 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -35,7 +35,7 @@ static inline u8 get_byte(struct ks_wlan_private *priv)
 {
 	u8 data;
 
-	data = *(priv->rxp)++;
+	data = *priv->rxp++;
 	/* length check in advance ! */
 	--(priv->rx_size);
 	return data;
@@ -171,7 +171,7 @@ int get_current_ap(struct ks_wlan_private *priv, struct link_ap_info *ap_info)
 		   "- rate_set_size=%d\n",
 		   ap->bssid[0], ap->bssid[1], ap->bssid[2],
 		   ap->bssid[3], ap->bssid[4], ap->bssid[5],
-		   &(ap->ssid.body[0]),
+		   &ap->ssid.body[0],
 		   ap->rate_set.body[0], ap->rate_set.body[1],
 		   ap->rate_set.body[2], ap->rate_set.body[3],
 		   ap->rate_set.body[4], ap->rate_set.body[5],
@@ -734,7 +734,7 @@ void hostif_scan_indication(struct ks_wlan_private *priv)
 		netdev_dbg(priv->net_dev, " scan_ind_count=%d :: aplist.size=%d\n",
 			priv->scan_ind_count, priv->aplist.size);
 		get_ap_information(priv, (struct ap_info *)(priv->rxp),
-				   &(priv->aplist.ap[priv->scan_ind_count - 1]));
+				   &priv->aplist.ap[priv->scan_ind_count - 1]);
 		priv->aplist.size = priv->scan_ind_count;
 	} else {
 		netdev_dbg(priv->net_dev, " count over :: scan_ind_count=%d\n",
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
