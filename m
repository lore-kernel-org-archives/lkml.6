Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3746462-1523363126-2-10933309421093433775
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
    1523363125; b=Rcm4dVutqIzS2YMfPoK721EXVfXHgXo/QvTHD93FKY0zZiLFeb
    CPSDWviL86i2e3q6qIQ6tFRDaASdQ4kmb+hYsWVIS6w0jBl/EWj77WJgC1su3noZ
    e5/jyBkfBiSHCPS2aTuhmrMcuyoMQ2BrCl6skpvg/q7w7P/abRHYQ73yh8NZzOr3
    ko6x0qCwFHh/RfoGccNFkfA1C+Wc9Jora2nSPqpudYAKtUE66INzSPbleojESzrY
    DBL87fg1yI9tQyuBRaFNMnOgAj1uqPG7NlnakW78CfoSfWFtZZbkTB5P9Day05CG
    FlFcBZL49kOifUndgc2YF/S1jHYnPYLjZLlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523363125; bh=CsbM+
    JgYPUB9p6tcS4yRyCw/OTeWkx3pTLNpUOT8gDo=; b=HA9KhPhDo8BneFdH/2xEg
    pMPvPA43xa3fSdy4Rpd1UYDZ3GKpM33UV6OBP6d2dk3t9lFLgq2saPy68VMsnlmC
    ozXE6iBL0IvafM0WCQuuUg5qFPb030synroEiwNe0w4q5F48G8sO6KHBvu5L4BDC
    f2trnBCM+EuWwY0H3pH7dTa1YpWQZg+1YvGxuLGooIpL2KN5kYS9HkTDg/z7QYMp
    EqbopSb0CHxkCrSD7JIk4TBplhjHjU8PM0x3evoVld0i9Gqna1pwMucwmeZAP7Cb
    ZDxVsPWFNMmrMuxH9u0AndGwTcDYY8lKlU3Z2wXHUlj2ZRcEUPQao7ZszF2e5KIO
    w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PbiiStuD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FBdmAhAL;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PbiiStuD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FBdmAhAL;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEl30J2bnu6UWa96fJ7mIFLdNWPqNVm+w5KdblREm4RoG7UpAwGLQMMucP7A+sEqlhgp0VPtfXUukHETxLXeVhLNcM/dSOvA5awfib5AuhQx0sBvM196
    aVBKYwEdE4ITF4ryjuDf+1PCSpHexm4LNrJRDP7R6t6ab7x9S+SYxieYRbhkF1Wp0EFQApr2KrdNKE+GE2ALIdaFKhnuf6DGoMUG9ym/kSsuw9d/hh8txv0N
    9kFM6UWpHqngzTJxeQNYVQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=tmjX-nCzVX8A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=Zdyt7FnlE9szmpPpO2wA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx49NCdVsVhltE7PV2dN3W+nsefMP+EGWY0x+x/LW0dvG4Mxy7Q60/2qc2K7STe7V4/B0oBoUJg==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: gregkh@linuxfoundation.org, szekelyszilv@gmail.com,
 shreeya.patel23498@gmail.com, colin.king@canonical.com
Subject: [PATCH 5/6] staging: rtl8192u: Replace mdelay with usleep_range in
 rtl8192_usb_disconnect
Date: Tue, 10 Apr 2018 20:25:09 +0800
Message-Id: <1523363109-30998-1-git-send-email-baijiaju1990@gmail.com>
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

rtl8192_usb_disconnect() is never called in atomic context.

rtl8192_usb_disconnect() is only set as ".disconnect" in 
struct usb_driver.

Despite never getting called from atomic context, 
rtl8192_usb_disconnect() calls mdelay() to busily wait.
This is not necessary and can be replaced with usleep_range() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 46b3f19..04ed34a 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -5033,7 +5033,7 @@ static void rtl8192_usb_disconnect(struct usb_interface *intf)
 		kfree(priv->pFirmware);
 		priv->pFirmware = NULL;
 		rtl8192_usb_deleteendpoints(dev);
-		mdelay(10);
+		usleep_range(10000, 11000);
 	}
 	free_ieee80211(dev);
 	RT_TRACE(COMP_DOWN, "wlan driver removed\n");
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
