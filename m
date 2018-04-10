Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3765319-1523363155-2-5023555715959258961
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523363153; b=bo7ZiLPwQ8MbO8Mez3oEbO2nK7PjqisYSD0/mDT/07XpRt12Vb
    zAVeVhano2WZXWRj4RZnCpwXxT9g1l3JBxP0bUL1cZObwfgZ6Lqv0pFrYBNdgOEp
    on/EPaLzhAFFxs+/tFvyyKcIY/zKvPIRjDwNApOhOkAPHVfrHZm6GMiAHQxOJkc+
    9ZjgtwwHReR+BWxjulw6trW44OaJswreHjzfdFhecMLcG++1kBvjJ2lcJ655AwUi
    MeHITm9oy4hw5+wh8FynNXewy0pIoLZq5itxfELu9f9FLuFN5ewI95iaiPaXlOy5
    GDlC5X36EQw6zwCRdLmvKnP6tRrgRGyXqTZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523363153; bh=I7YVk
    G2tU4rP4XVrYYltB9Atbn8RwEfoKWMkhp61URw=; b=NoKxLs03A0L/iK8yfQKsv
    fp1uNiTy4/eBkvpnPv/YXmyDM1Bk/TYX3wQ+YVZaI6LCtLHVJHGZ0Bj957iyKjWu
    L+JuwlmGvte9zWrgHfXFWLv+FO2U64XCICnn7ACcDvj+7xJTODaVnNNNS61r3l6/
    /cyEyFOZA4TBM7dvRPnoLEkpglqC7Q6UMRHikneLQByaDi0tBP8Ys0BiHO6keSP3
    2opZEY8lkIzg8kAMVtMNJ3s2eU2g1Gnam63M8r/84O6tvfpMbx8p1Y++3oiIvoUr
    +r4HpPKZRtc5aXz4AgSBU4kIy7p7SBTq19AEbwKM8xCxegrPp+cBn96MDzOZdYm7
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=NYb5f8st x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mhS5dBHF;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=NYb5f8st x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mhS5dBHF;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAFSRXXygpg4fUL3Zy5tidHAqzsR75YmfEFc61aCTxjydzFE4mze5mZT5kwsp/UKPFD6/w8fQOIxHYEvqkxStpS2Swrom3L6cRJqOAnDhpT49aiWTD7A
    g3KQoMi44bpm5d8YgKpm1cUFEg2qFItkW9uL2/LjG8NhmofX+8FKmfEsOBqyg17z6z9scRCtSi0Reqj2t8VthFFBTsooTO6EbI6h0rhtnvCILON2iKbCh9ku
    9jdQnGm9YQc/YvUSuHBD/w==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=tmjX-nCzVX8A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=ykJZhTjF-P-Cxblh2zIA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+2+TF52ExXap+aAi3bdKuAnl6KjTkxxZSoO/T+mYDEC3rNd1pyDaau67O5r5vGupNEZ4TfjQ==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: gregkh@linuxfoundation.org, tuomo.rinne@gmail.com, colin.king@canonical.com
Subject: [PATCH 6/6] staging: rtl8192u: Replace mdelay with usleep_range in
 dm_TXPowerTrackingCallback_TSSI
Date: Tue, 10 Apr 2018 20:25:34 +0800
Message-Id: <1523363134-31050-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
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
Cc: devel@driverdev.osuosl.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

dm_TXPowerTrackingCallback_TSSI() is never called in atomic context.

dm_TXPowerTrackingCallback_TSSI() is only called by 
dm_txpower_trackingcallback(), which is set a parameter of 
INIT_DELAYED_WORK() in rtl8192_init_priv_task().

Despite never getting called from atomic context,
dm_TXPowerTrackingCallback_TSSI() calls mdelay() to busily wait.
This is not necessary and can be replaced with usleep_range() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index e6f8d1d..51b2516 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -538,13 +538,13 @@ static void dm_TXPowerTrackingCallback_TSSI(struct net_device *dev)
 		rtStatus = SendTxCommandPacket(dev, &tx_cmd, 12);
 		if (rtStatus == RT_STATUS_FAILURE)
 			RT_TRACE(COMP_POWER_TRACKING, "Set configuration with tx cmd queue fail!\n");
-		mdelay(1);
+		usleep_range(1000, 2000);
 		/*DbgPrint("hi, vivi, strange\n");*/
 		for (i = 0; i <= 30; i++) {
 			read_nic_byte(dev, 0x1ba, &Pwr_Flag);
 
 			if (Pwr_Flag == 0) {
-				mdelay(1);
+				usleep_range(1000, 2000);
 				continue;
 			}
 			read_nic_word(dev, 0x13c, &Avg_TSSI_Meas);
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
