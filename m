Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2920666-1525592024-2-698307732653534584
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525592024; b=LgKdEOEZ5fSzvKzKu0y11k1Qal4RGvCCk46uh1oo6oOggxNv6O
    kei7Ux8u7mI6k/UjFuYItjWytTrXbFwr9mmH46C11wOLktOoYrj326yRBMS20g7/
    1U4rfDaqqZWQaURrixNIfmSGT6DZgx9X8VutY22zMFgMteSyK40K4H0272D9gzEZ
    /D3u4HjUN9vg77aLBSJ1pQ7uXgwCbNxKqqwn+SpyPe6HVnlWzNykhk7cwwrJgsz3
    b8xY+JW7eRLU0cx1yqx3TrsAbcrZxx+RAnWM8dbf6jthkky/Eq/0KD4aji86UWJI
    iywH2MbQJucX0hI7qPi5FYTAgkGJVaM6fnPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525592024; bh=ELnC9
    1MAE56yb+zZ+ZZ6p43xE9iK2T5X0vBPK4tiJks=; b=VW9r52gDGkTjOHll73t4G
    5HaxgMVi4apM5umjDccEVItAkWC5pmiYPt3HpEgyByAR/K2xlvRZqndkzNn3eShA
    xmr/VlzNFtRJOgSQN7lFL7so9trdTpQLnp3ZG/XK3DxZEDldHuBM5wPXuBVd8qdY
    dFwO2QAVNffLg4JZAePn04op8FMyIQba1ZQGxXwx5wsYlq3so8CdECzUGou+KSgf
    XwO4JvFg/X0Z1aBfjoU0Epi/BBUgV6YyPbvGkTjcTuj/J6HIK/tKz7AWSZG7uwYR
    l5tMTV+ksPqIBTwoUYbi1R1N32gH2C3mxjE76O9q9iGeJn4rwU7memqK6r/ZJlRC
    A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=G5df6HMR x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=dyjYGUcG;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=G5df6HMR x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=dyjYGUcG;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKiLR5C9KxbOvxC9RHpeD4bneGzRH50s4rwX6Hmpe+fsjnORyu4ckvO8RdqywPzHqRqCelUAjVQrU+qFaxUMD6NEOh8n7svAyGBuFarmhbVJyGknCa4P
    po3lRHjaxDqf2DbS52gIc3fY1VBGyLWgUYqPdA7CTfBo4x98FDSuiCB9aDTBcWQ+M2PRU586L6j657Q/3ftSFhfrshKAIf9eoR32sT9J/VtH9XBkvN6HgLpR
    y8GCmFu2Sq1f5Q6i91+fnQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=TpujumX0jH7REod0KhDaHZOp9kI=:19
    a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=vY_346TuTMEA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8
    a=DDOyTI_5AAAA:8 a=3JF_WRKwcAzftN6yHtMA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZpzeUw/31x4RXwZcjNU3QpbWT8nC7YOGrpPL9y/Vu6cE3D+WT8S0i1joX3LuTBNfa6zH8Fn+w==
From: Nathan Chancellor <natechancellor@gmail.com>
To: devel@driverdev.osuosl.org
Subject: [PATCH 2/3] staging: wilc1000: Remove useless function
Date: Sun,  6 May 2018 00:33:32 -0700
Message-Id: <20180506073333.3770-2-natechancellor@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180506073333.3770-1-natechancellor@gmail.com>
References: <20180506073333.3770-1-natechancellor@gmail.com>
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
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ganesh Krishna <ganesh.krishna@microchip.com>,
 Aditya Shankar <aditya.shankar@microchip.com>,
 Nathan Chancellor <natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

GCC warns that 'wid' is unused in wilc_remove_key and it's correct; the
variable is only local. Get rid of the function (since it just returns
zero) and shuffle the remaining code into one if statement.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/wilc1000/host_interface.c         | 12 ------------
 drivers/staging/wilc1000/host_interface.h         |  1 -
 drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 14 +++++---------
 3 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/wilc1000/host_interface.c b/drivers/staging/wilc1000/host_interface.c
index 3fd4c8e62da6..b5f3829e9903 100644
--- a/drivers/staging/wilc1000/host_interface.c
+++ b/drivers/staging/wilc1000/host_interface.c
@@ -2606,18 +2606,6 @@ static void timer_connect_cb(struct timer_list *t)
 	wilc_enqueue_cmd(&msg);
 }
 
-s32 wilc_remove_key(struct host_if_drv *hif_drv, const u8 *sta_addr)
-{
-	struct wid wid;
-
-	wid.id = (u16)WID_REMOVE_KEY;
-	wid.type = WID_STR;
-	wid.val = (s8 *)sta_addr;
-	wid.size = 6;
-
-	return 0;
-}
-
 int wilc_remove_wep_key(struct wilc_vif *vif, u8 index)
 {
 	int result = 0;
diff --git a/drivers/staging/wilc1000/host_interface.h b/drivers/staging/wilc1000/host_interface.h
index 7a26f341e0ba..08b3ba7df8b4 100644
--- a/drivers/staging/wilc1000/host_interface.h
+++ b/drivers/staging/wilc1000/host_interface.h
@@ -303,7 +303,6 @@ struct add_sta_param {
 };
 
 struct wilc_vif;
-s32 wilc_remove_key(struct host_if_drv *hif_drv, const u8 *sta_addr);
 int wilc_remove_wep_key(struct wilc_vif *vif, u8 index);
 int wilc_set_wep_default_keyid(struct wilc_vif *vif, u8 index);
 int wilc_add_wep_key_bss_sta(struct wilc_vif *vif, const u8 *key, u8 len,
diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
index 76b4afaef423..b499fb987395 100644
--- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
+++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
@@ -1054,15 +1054,11 @@ static int del_key(struct wiphy *wiphy, struct net_device *netdev,
 		}
 	}
 
-	if (key_index >= 0 && key_index <= 3) {
-		if (priv->wep_key_len[key_index]) {
-			memset(priv->wep_key[key_index], 0,
-			       priv->wep_key_len[key_index]);
-			priv->wep_key_len[key_index] = 0;
-			wilc_remove_wep_key(vif, key_index);
-		}
-	} else {
-		wilc_remove_key(priv->hif_drv, mac_addr);
+	if (key_index >= 0 && key_index <= 3 && priv->wep_key_len[key_index]) {
+		memset(priv->wep_key[key_index], 0,
+		       priv->wep_key_len[key_index]);
+		priv->wep_key_len[key_index] = 0;
+		wilc_remove_wep_key(vif, key_index);
 	}
 
 	return 0;
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
