Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7B5C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0212075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlDsf9Zk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0212075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeJIXGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:06:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54581 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbeJIXGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:06:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so2395961wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 08:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HmmTMv1WoawZ2ccWHFL0gEt7hr1J/l6pQYJ4zqSTH0w=;
        b=rlDsf9ZkfxvDcFzVHsnSzLWA8WxLhu+YzefJqOj1TGkjMvlW/jxDA0of3ASJSmK867
         QawhPlWvTJDFR6oBkMk8INnDCQZj9WXTIOTilCv8kYiLWHJO2bMIwOPBqQ5KWctW7AEe
         7PmmQwtdExqcXvt18g9fTKfVi6iIuiDQkXpF7tL3gbPT+KlaykYMtuK8hhsS8fLukULD
         f0UTmwLtgzkIo3mldXdaeYXABxKtPRK6Q3e/tG39gf3zBwMQUPBQHj6MW/sNBaQ+G9DX
         JylDaT3JUNNK4Wqi86Fc16RNQyRcrMr/rF95KH1v98FK5ch1xTEppzFJ689kkR1db6m5
         CYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HmmTMv1WoawZ2ccWHFL0gEt7hr1J/l6pQYJ4zqSTH0w=;
        b=UC9N/Mm+cGEVsnSqB1ogRCf0CEw+5jf7P1uJ4f68EHg2Q2a7AwRsqS02WW8j9qojdo
         aBGgsrIM4SKkYIerd7TeWMJwe1rOi+zqHTVK2nTEV5Nv6ZKOfLsg0fq0jr3vuHkv9pHk
         6mn95Lw+8rrsrYmaAXaRaAcjOpj8XDvpxTS6kFin6Jacg2niU1qh9iUxKaKtr2i/cB4Z
         1YqvCPMcHVXsZva+iru+3R+dP5+2jHV/e2ZGMmIjPRiVDJcRlHFdwxqCANfia2e58bVs
         5vCbbCeDKMjzG3N8bdm5Mf6aGvSVV9ZTShfD6JtSB16tWYoluoVikAPyw8QpxAALkqbh
         /vRg==
X-Gm-Message-State: ABuFfoi0zvu+daOnnhUB88J6KbJbENAcjLi8rUkBxPyqUXTHs9tmRBoR
        lkIjC9sHI8mCS6Oz/nW3Ul8=
X-Google-Smtp-Source: ACcGV6136kH9HIPrtK/bIvafN9YAyrKYvFUULT+6kKX8kie9h23eJ91gFu3SvUjHOW7DkfYgWh0ZFw==
X-Received: by 2002:a1c:dc0a:: with SMTP id t10-v6mr2377957wmg.105.1539100148857;
        Tue, 09 Oct 2018 08:49:08 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fa83.dynamic.kabel-deutschland.de. [31.18.250.131])
        by smtp.gmail.com with ESMTPSA id o130-v6sm10907338wmd.11.2018.10.09.08.49.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 08:49:08 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/4] staging: rtl8188eu: cleanup lines over 80 characters - style
Date:   Tue,  9 Oct 2018 17:48:53 +0200
Message-Id: <20181009154854.9054-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181009154854.9054-1-straube.linux@gmail.com>
References: <20181009154854.9054-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear 'line over 80 characters' checkpatch warnings by adding
appropriate line breaks and moving a comment.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/xmit_linux.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/xmit_linux.c b/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
index 8de0fc53103c..f5041e642bd2 100644
--- a/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
@@ -14,7 +14,8 @@
 #include <xmit_osdep.h>
 #include <osdep_intf.h>
 
-int rtw_os_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *pxmitbuf, u32 alloc_sz)
+int rtw_os_xmit_resource_alloc(struct adapter *padapter,
+			       struct xmit_buf *pxmitbuf, u32 alloc_sz)
 {
 	int i;
 
@@ -89,7 +90,8 @@ void rtw_os_xmit_schedule(struct adapter *padapter)
 	spin_unlock_bh(&pxmitpriv->lock);
 }
 
-static void rtw_check_xmit_resource(struct adapter *padapter, struct sk_buff *pkt)
+static void rtw_check_xmit_resource(struct adapter *padapter,
+				    struct sk_buff *pkt)
 {
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 	u16	queue;
@@ -136,18 +138,24 @@ static int rtw_mlcst2unicst(struct adapter *padapter, struct sk_buff *skb)
 			memcpy(newskb->data, psta->hwaddr, 6);
 			res = rtw_xmit(padapter, &newskb);
 			if (res < 0) {
-				DBG_88E("%s()-%d: rtw_xmit() return error!\n", __func__, __LINE__);
+				DBG_88E("%s()-%d: rtw_xmit() return error!\n",
+					__func__, __LINE__);
 				pxmitpriv->tx_drop++;
 				dev_kfree_skb_any(newskb);
 			} else {
 				pxmitpriv->tx_pkts++;
 			}
 		} else {
-			DBG_88E("%s-%d: skb_copy() failed!\n", __func__, __LINE__);
+			DBG_88E("%s-%d: skb_copy() failed!\n",
+				__func__, __LINE__);
 			pxmitpriv->tx_drop++;
 
 			spin_unlock_bh(&pstapriv->asoc_list_lock);
-			return false;	/*  Caller shall tx this multicast frame via normal way. */
+
+			/* Caller shall tx this multicast frame
+			 * via normal way.
+			 */
+			return false;
 		}
 	}
 
-- 
2.19.1

