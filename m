Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3765319-1523362996-2-16567414012917373039
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523362995; b=ovsyEipsA64IsLFIzVuRsqctwAOjUK26Ycj7f68aWrE2Jzg4Ne
    HYhedgNAwNFpa/dDo0xTXUMGaT4XlZ485wXuP323AajChc5R6Yvq81TuYhzbMXVk
    rwtsqHSF3P/fEqmAfT3nvDor/pKdpCJpPqO3eexaWvDAwC1/50D80fei2TSAyIdT
    iXM5CUv/YLJ2zHFLcKyBUzHJb/upWgeHcNMPzKJDDjdAxdSVydniwSY/E5amvbEX
    SU5yq37HzeUdKhqFAQ0ThusKXM0GWwhoySjzAMTA0b4DG4JMZLh+hCeB4AeKY1St
    5XTbaNdFEpSg/3F5ryFFy9GTbHOfw6h7qBew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523362995; bh=FkXhK
    jxX6dh9UFMxzyn0vXqNLyRi/Mj/9TexjgsUxLM=; b=kHD8SeeLlWurazEpmpRu7
    oQyJGfz0ksvLU0Mfqq9wUaEudAyqd2CrRQDSM45fffFbMoAindd0+bErdxu3RtYG
    bzmhX/bYbxO4E10n6hi3n2b4dcUlqNAOklhPHIAgBONvFoMpgQPGB6Fce/Dgl2fL
    r3RaEazK67DSs0wyzBp0P2nXhD6eXbWMo7NA/VxW2RFcRxI064gmsxSVlq/Q6pEg
    TAdl1qOm3TAQa8m2Dmy4V5BSMTWGlNW5zfHm9P5jjE/4LLHevsFy/RLGjeAIz2wl
    YDM6MO4f5kFTEc5ed5evQkRqI/Xjhst90B7K2/mf2VO/eLAcZdV6Eph3/BOsAzH5
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uE2Hb0qN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PdaHSFfM;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uE2Hb0qN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PdaHSFfM;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJsZfLlhk176vwwZYut47dwdCNGubSxNPFsX+vAamu5GaWU2ngmS6ypn82d4eLpYdSYAhNPIH97kMqVlr4AhDDT7MMk3wS9+neONbgqc04z09AOQtjnQ
    QbOcmWs5aQ4+tJZBoFIkK10sgMsAYO+dLe7pjBaRTEaMBp9D9MFDj9dTkMQ9ckQwoXQU3D5ypHblI3fljPYPvWp3X51syYqsiIf3Xq+Gm0K/qIObV4kSBwRm
    WCTz4gnns4RGn5hzIriraA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=tmjX-nCzVX8A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=KUgp_o9Td9nQKI1mOJsA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx48fW4EVS9gUvNxpNGh+V/sPp0QMBeAzaCLRpfVFQHPSgtRK3XugRrbG42olLEGzostrFTyEbw==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 1/6] staging: rtl8192u: Replace GFP_ATOMIC with GFP_KERNEL in
 ieee80211_ccmp_init
Date: Tue, 10 Apr 2018 20:23:00 +0800
Message-Id: <1523362980-30800-1-git-send-email-baijiaju1990@gmail.com>
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

ieee80211_ccmp_init() is never called in atomic context.

ieee80211_ccmp_init() is only set as ".init" in 
struct ieee80211_crypto_ops.
The call chains ending up at "->init" function are:
[1] ->init() <- ieee80211_wpa_set_encryption() <- 
	ieee80211_wpa_supplicant_ioctl()
[2] ->init() <- ieee80211_wx_set_encode_ext_rsl() <-
	r8192_wx_set_enc_ext()
[3] ->init() <- ieee80211_wx_set_encode_rsl() <-
	r8192_wx_set_enc()

ieee80211_wpa_supplicant_ioctl(), r8192_wx_set_enc_ext() and
r8192_wx_set_enc() call mutex_lock(), which indicates these functions 
are not called in atomic context.

Despite never getting called from atomic context,
ieee80211_ccmp_init() calls kzalloc() with GFP_ATOMIC,
which does not sleep for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
which can sleep and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
index e6648f7..a8d39f1 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
@@ -66,7 +66,7 @@ static void *ieee80211_ccmp_init(int key_idx)
 {
 	struct ieee80211_ccmp_data *priv;
 
-	priv = kzalloc(sizeof(*priv), GFP_ATOMIC);
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		goto fail;
 	priv->key_idx = key_idx;
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
