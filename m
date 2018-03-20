Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2173734-1521577610-5-16878213408274622371
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521577609; b=JxTLPEth5d79buhiAsXFzyP1/N6+PzT6Td5n3JJrKOfSoo/
    j43NsGleGO+LmtY1WQU/ZNVPjJGeGtPdKxQzR1n+Bxa+tWMQ0FEis4tUHNFBhq1H
    efQcvG4/Zo0yuBbwlhIjzk0u/wNxmlSOhe5X+jIEdzJps5iKHWeyfq0bJkcuNwIe
    D+rwkcrQXKU7SOjSAMqFUOT5p+V1bOZy4QTNmZcINbyXodiz7ymmOQstsKHT+Gu8
    5Vx2wKRQdiUHCoYOS7Ld0mirwSHJij++Zn/JOiK6VBdGlxY2ZnYDDBsbSkWb2v0w
    fuqwwETeWKAxQPp03bggPafzWtVKI0DbBxN5nlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521577609; bh=x
    h6tH2arO5b/IQenHKcHV7KrTxpnD1eIyS1ElczW+3A=; b=CfdMGuxM45FGqwup2
    Cwkz40Hfkpo/ocCLey1WBNoFg+PTLrKrNjgKtTm/kLtvpet7n9owfPTVCQoy/I/F
    m09b3j0ZvMviD5zHFJ84HgvDacKJJu+x//CFq0jtQXCmuIp3/gL5mOZ2ilyd3Vs/
    lIEa1iosGL1/cozOG+sjWtX9MTWMOLb44J8YK9zL57Aazv7xFBo/XblB13h5Au4f
    3Zc89BL4rXVHnp+UQCcjTHSD+DMWZYXvTWKyV3Pt0XMZPcNMtVeP5+ds9SO7Vcu4
    mY5x5WJtgwaZhd7TO97XPe4XClH5+LKrGqAOJvH+wY3rMuxnO6keSnZkOb3ddpps
    aYLbw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IpvWv2G0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=W8AzpW7r;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=15 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IpvWv2G0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=W8AzpW7r;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=15 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsQqI4YxK8cTvbrh9vjd1OmrSTcmmxe5fR/8ASul1wJYxLrZEPj3ZYJntVuWTcHjXrp2ESIpg==
From: Paul McQuade <paulmcquad@gmail.com>
To: paulmcquad@gmail.com
Subject: [v2 PATCH 2/5] Staging:rtl8723bs clean up spaces
Date: Tue, 20 Mar 2018 20:26:19 +0000
Message-Id: <20180320202622.13339-2-paulmcquad@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320202622.13339-1-paulmcquad@gmail.com>
References: <20180320202622.13339-1-paulmcquad@gmail.com>
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
Cc: devel@driverdev.osuosl.org, keescook@chromium.org, johannes.berg@intel.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Linyu.Yuan@alcatel-sbell.com.cn, hdegoede@redhat.com, arnd@arndb.de,
 arvind.yadav.cs@gmail.com, colin.king@canonical.com, davem@davemloft.net,
 Larry.Finger@lwfinger.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Used checkpatch.pl to clean up spaces around
for statements to make it easier to read

Signed-off-by: Paul McQuade <paulmcquad@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/rtw_proc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/rtw_proc.c b/drivers/staging/rtl8723bs/os_dep/rtw_proc.c
index 37ee8d90709a..49c8684dc25b 100644
--- a/drivers/staging/rtl8723bs/os_dep/rtw_proc.c
+++ b/drivers/staging/rtl8723bs/os_dep/rtw_proc.c
@@ -142,7 +142,7 @@ int rtw_drv_proc_init(void)
 		goto exit;
 	}
 
-	for (i = 0;i<drv_proc_hdls_num;i++) {
+	for (i = 0; i < drv_proc_hdls_num; i++) {
 		entry = rtw_proc_create_entry(drv_proc_hdls[i].name, rtw_proc, &rtw_drv_proc_fops, (void *)i);
 		if (!entry) {
 			rtw_warn_on(1);
@@ -163,7 +163,7 @@ void rtw_drv_proc_deinit(void)
 	if (rtw_proc == NULL)
 		return;
 
-	for (i = 0;i<drv_proc_hdls_num;i++)
+	for (i = 0; i < drv_proc_hdls_num; i++)
 		remove_proc_entry(drv_proc_hdls[i].name, rtw_proc);
 
 	remove_proc_entry(RTW_PROC_NAME, get_proc_net);
@@ -341,7 +341,7 @@ static int proc_get_cam_cache(struct seq_file *m, void *v)
 		/*  "MK", "GK", "MFB", "valid" */
 	);
 
-	for (i = 0;i<32;i++) {
+	for (i = 0; i < 32; i++) {
 		if (dvobj->cam_cache[i].ctrl != 0)
 			DBG_871X_SEL_NL(m, "%2u 0x%04x "MAC_FMT" "KEY_FMT" %3u %-7s"
 				/*  %2u %2u 0x%02x %5u" */
@@ -663,7 +663,7 @@ static struct proc_dir_entry *rtw_odm_proc_init(struct net_device *dev)
 
 	adapter->dir_odm = dir_odm;
 
-	for (i = 0;i<odm_proc_hdls_num;i++) {
+	for (i = 0; i < odm_proc_hdls_num; i++) {
 		entry = rtw_proc_create_entry(odm_proc_hdls[i].name, dir_odm, &rtw_odm_proc_fops, (void *)i);
 		if (!entry) {
 			rtw_warn_on(1);
@@ -687,7 +687,7 @@ static void rtw_odm_proc_deinit(struct adapter	*adapter)
 		return;
 	}
 
-	for (i = 0;i<odm_proc_hdls_num;i++)
+	for (i = 0; i < odm_proc_hdls_num; i++)
 		remove_proc_entry(odm_proc_hdls[i].name, dir_odm);
 
 	remove_proc_entry("odm", adapter->dir_dev);
@@ -721,7 +721,7 @@ struct proc_dir_entry *rtw_adapter_proc_init(struct net_device *dev)
 
 	adapter->dir_dev = dir_dev;
 
-	for (i = 0;i<adapter_proc_hdls_num;i++) {
+	for (i = 0; i < adapter_proc_hdls_num; i++) {
 		entry = rtw_proc_create_entry(adapter_proc_hdls[i].name, dir_dev, &rtw_adapter_proc_fops, (void *)i);
 		if (!entry) {
 			rtw_warn_on(1);
@@ -749,7 +749,7 @@ void rtw_adapter_proc_deinit(struct net_device *dev)
 		return;
 	}
 
-	for (i = 0;i<adapter_proc_hdls_num;i++)
+	for (i = 0; i < adapter_proc_hdls_num; i++)
 		remove_proc_entry(adapter_proc_hdls[i].name, dir_dev);
 
 	rtw_odm_proc_deinit(adapter);
@@ -773,7 +773,7 @@ void rtw_adapter_proc_replace(struct net_device *dev)
 		return;
 	}
 
-	for (i = 0;i<adapter_proc_hdls_num;i++)
+	for (i = 0; i < adapter_proc_hdls_num; i++)
 		remove_proc_entry(adapter_proc_hdls[i].name, dir_dev);
 
 	rtw_odm_proc_deinit(adapter);
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
