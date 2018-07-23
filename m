Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503CDECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090F120880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcQ6N8Zn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090F120880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388339AbeGWVyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:54:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39797 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387981AbeGWVyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:54:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id h10-v6so1993888wre.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 13:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MXUGY1kuyA7t1nbZc0vd3rPlQK+LiFy3Urh3wSsjqJc=;
        b=GcQ6N8ZnB+DcwoPT23tLKE52BgMCv3Y/QEsTOrkKYj1PaDlw6bOAzYdHVZBmXE2lLv
         YmvcqornX4cj7kZjVupwOJcGOtUwdy95XjcESDfbcdtCT/6PJ8S52HWuEGfqvfG0gCoq
         ae+uhV5s50EReqliRL71xBOBfopF0agjPHfS7cOE9UEYju2tMpnxMMHb4dXqrVh3aCOc
         lE5jK0w4JrkuAHSSWNZy+dDmfojh4uck2riIJ4qk7j/bshL2JROLD6ZCXQEvmRucNSTM
         uErOjLKGP6pdPQwVUlNw2bR8FPW5afx/1Hk/Wjh3AleZEXK9KO4PzgcFDDK9n392C7O9
         5vOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MXUGY1kuyA7t1nbZc0vd3rPlQK+LiFy3Urh3wSsjqJc=;
        b=BN6q8tLKHAjNX2PMD59GCDlhz9HSAv0ZpT36hIgT1X60IHn0o0XOcaqHI4H7xgQNZv
         ayUz7l7kd8fAxsRMZo4ZJOqVKQngUPMt7ZMY0nkKTSXDJJ03B9gbMfUyIzRx0p6iNaaB
         tfeNeDcXRIuzrPoM1MN5jmSgkajjBUTJNTKU7E95qB2qeFBGwVnkEsEyvNX3NyhY6Z5i
         ddvpp4SgUFp+3M76JQEUyrBYUsWGGugbehPI+x6TQEBFvlBgR8mq1etJ2jfAlxKbSAfR
         C0FUmmTzjr5+ZcAIMlwRHdg3SNurTZIIGgv0oUHTKeq6p8M4fCj9em3u6BYoWFTvWGM6
         3MJA==
X-Gm-Message-State: AOUpUlGy+Rs1Qq6ALwx6qqfWR4irle8i1In3YRFavbsaI4zgTEHMmrXy
        bNIkVE+h3UxscPycE7odq8Ei4ok/
X-Google-Smtp-Source: AAOMgpcBAPyVp2QHs4ukZXd19hd8buNCRtbF1QfsjOK4TO4vgRX9AblRH5/AnfFfm5hKzZC0pG1AVQ==
X-Received: by 2002:adf:afd3:: with SMTP id y19-v6mr10477360wrd.176.1532379063986;
        Mon, 23 Jul 2018 13:51:03 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id b123-v6sm14921874wma.24.2018.07.23.13.51.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 13:51:03 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 13/15] staging:rtl8192u: Remove unused structure ACM - Style
Date:   Mon, 23 Jul 2018 21:50:29 +0100
Message-Id: <20180723205031.19816-14-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723205031.19816-1-johnfwhitmore@gmail.com>
References: <20180723205031.19816-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the structure ACM as it is unused in code. This change is a coding
style change and should have no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 49d9184f22ec..878c467e7b89 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -112,13 +112,6 @@ typedef union _TSPEC_BODY {
 	} f;	// Field
 } TSPEC_BODY, *PTSPEC_BODY;
 
-typedef struct _ACM {
-//	u8		RegEnableACM;
-	u64		UsedTime;
-	u64		MediumTime;
-	u8		HwAcmCtl;	// TRUE: UsedTime exceed => Do NOT USE this AC. It wll be written to ACM_CONTROL(0xBF BIT 0/1/2 in 8185B).
-} ACM, *PACM;
-
 typedef	u8		AC_UAPSD, *PAC_UAPSD;
 
 #define	GET_VO_UAPSD(_apsd) ((_apsd) & BIT(0))
-- 
2.18.0

