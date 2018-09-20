Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C698C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1621C21533
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTyw7jMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1621C21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387971AbeIUEXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:23:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36784 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeIUEXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:23:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id j192-v6so1167104wmj.1;
        Thu, 20 Sep 2018 15:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ucbHqs/wXy5FO2mbWJmC/Tw8FM+YjaW9oEkVJcEfVsw=;
        b=gTyw7jMGZSGFM6+3VjuI7umYV4ysXAIT0gH3WITH0R5nG4JiPUET7oXOnUROYIdtSM
         hNWcu+yhkRsPi2/YiGC4YH/Yv6mSU98aTnIDbuU50YgsVnR5bclt7zDz+bVUlEBF3a4b
         8dKnAcO5OeGu3V1RxH8osi+th1p/2DaisRzlu156DFpRm3VHbdx8D33QFOqAQF2SksXz
         bwnP7+Vv3kkD2dkzNPYdA43PajBBo1XxRz8AimseXLoaDUeG2MuPxGqI3s4EFDz09Wli
         qKKgQp+GSyQbnLckdSkz9qvq8Vkkp+B9xiiOlnxJ9SuCiBymnYjolCRFJyxM0NezYmZ/
         m61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ucbHqs/wXy5FO2mbWJmC/Tw8FM+YjaW9oEkVJcEfVsw=;
        b=XgHOMCmoWG+RB2w6ZG1YzVGVvXo0kzR27wX93x90OF80q6vUNL+n+7oSW0846tPhYd
         DYeaZX2YfwElm9WviutKFjECMK2hY7Uu0bBtXKe35qhrFkEDIwA32enwgWqDYabD//wH
         uPeTTNMhbXfF8n0cUuo6qXYHQPSK52Fpeoz62yweBC0Xi0zivktEnphoAqB0ArtadLp7
         Cn+Z3Qk4bjyrW90v0CWEthIQr2+RFI8I96z1e3Dy1/qvcBOK+dJ+X+rk9kpOGcaRtJbh
         5XbkW9+dMxflI3QYb3n1i7K+qYwhVC0dFZxGRdimjyXr/bFktkyRRpXKAB7gSVtcKyWr
         BDCQ==
X-Gm-Message-State: APzg51A5kiFqYezDomhTeYENn83VqXcqY3MoAgqsc1g559QS2VCKirji
        g36udW0SFoo7ZDePk9G68n8=
X-Google-Smtp-Source: ANB0VdZNJiR7Cxmmy7xSHH5Wm60deuxZN4LOTByj3NFKHoE3LnDJ0wxmFJnz2ue/DHwx6JVG/wR8Kg==
X-Received: by 2002:a1c:98a:: with SMTP id 132-v6mr610556wmj.86.1537483086843;
        Thu, 20 Sep 2018 15:38:06 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id c19-v6sm29093999wre.86.2018.09.20.15.38.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 15:38:06 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] net: fddi: skfp: Remove unused function
Date:   Thu, 20 Sep 2018 15:36:33 -0700
Message-Id: <20180920223632.14113-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when a variable is assigned to itself.

drivers/net/fddi/skfp/pcmplc.c:1257:6: warning: explicitly assigning
value of variable of type 'int' to itself [-Wself-assign]
        phy = phy ; on_off = on_off ;
        ~~~ ^ ~~~
drivers/net/fddi/skfp/pcmplc.c:1257:21: warning: explicitly assigning
value of variable of type 'int' to itself [-Wself-assign]
        phy = phy ; on_off = on_off ;
                    ~~~~~~ ^ ~~~~~~
2 warnings generated.

Turns out this entire function doesn't actually do anything since
SK_UNUSED is just casting the pointer to void. Remove it to silence
this Clang warning.

Link: https://github.com/ClangBuiltLinux/linux/issues/128
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/fddi/skfp/ecm.c      |  3 ---
 drivers/net/fddi/skfp/h/cmtdef.h |  1 -
 drivers/net/fddi/skfp/pcmplc.c   | 11 -----------
 3 files changed, 15 deletions(-)

diff --git a/drivers/net/fddi/skfp/ecm.c b/drivers/net/fddi/skfp/ecm.c
index eee9ba91346a..c813e462183d 100644
--- a/drivers/net/fddi/skfp/ecm.c
+++ b/drivers/net/fddi/skfp/ecm.c
@@ -30,7 +30,6 @@
  *
  * 	The following external HW dependent functions are referenced :
  * 		sm_pm_bypass_req()
- * 		sm_pm_ls_latch()
  * 		sm_pm_get_ls()
  * 
  * 	The following HW dependent events are required :
@@ -356,8 +355,6 @@ static void ecm_fsm(struct s_smc *smc, int cmd)
 		 */
 		start_ecm_timer(smc,smc->s.ecm_check_poll,0) ;
 		smc->e.ecm_line_state = TRUE ;	/* flag to pcm: report Q/HLS */
-		(void) sm_pm_ls_latch(smc,PA,1) ; /* enable line state latch */
-		(void) sm_pm_ls_latch(smc,PB,1) ; /* enable line state latch */
 		ACTIONS_DONE() ;
 		break ;
 	case EC6_CHECK :
diff --git a/drivers/net/fddi/skfp/h/cmtdef.h b/drivers/net/fddi/skfp/h/cmtdef.h
index 5d6891154367..a12f464941ed 100644
--- a/drivers/net/fddi/skfp/h/cmtdef.h
+++ b/drivers/net/fddi/skfp/h/cmtdef.h
@@ -513,7 +513,6 @@ void pcm_status_state(struct s_smc *smc, int np, int *type, int *state,
 void plc_config_mux(struct s_smc *smc, int mux);
 void sm_lem_evaluate(struct s_smc *smc);
 void mac_update_counter(struct s_smc *smc);
-void sm_pm_ls_latch(struct s_smc *smc, int phy, int on_off);
 void sm_ma_control(struct s_smc *smc, int mode);
 void sm_mac_check_beacon_claim(struct s_smc *smc);
 void config_mux(struct s_smc *smc, int mux);
diff --git a/drivers/net/fddi/skfp/pcmplc.c b/drivers/net/fddi/skfp/pcmplc.c
index a9ecf923f63d..6ef44c480bd5 100644
--- a/drivers/net/fddi/skfp/pcmplc.c
+++ b/drivers/net/fddi/skfp/pcmplc.c
@@ -30,7 +30,6 @@
  * 	The following external HW dependent functions are referenced :
  * 		sm_pm_control()
  *		sm_ph_linestate()
- *		sm_pm_ls_latch()
  *
  * 	The following HW dependent events are required :
  *		PC_QLS
@@ -1248,16 +1247,6 @@ static void sm_ph_lem_stop(struct s_smc *smc, int np)
 	CLEAR(PLC(np,PL_INTR_MASK),PL_LE_CTR) ;
 }
 
-/* ARGSUSED */
-void sm_pm_ls_latch(struct s_smc *smc, int phy, int on_off)
-/* int on_off;	en- or disable ident. ls */
-{
-	SK_UNUSED(smc) ;
-
-	phy = phy ; on_off = on_off ;
-}
-
-
 /*
  * PCM pseudo code
  * receive actions are called AFTER the bit n is received,
-- 
2.19.0

