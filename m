Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E46AC46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 11:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3561A217B4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 11:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVt/9+uQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3561A217B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbeHENeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 09:34:17 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38655 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbeHENeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 09:34:17 -0400
Received: by mail-pl0-f65.google.com with SMTP id u11-v6so4438445plq.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 04:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=BVkBApd5G5Moc32b/kOk/x8xpCJ4paLnsG5j0MXNmmc=;
        b=rVt/9+uQDCzjEO9AymZ/MptCarKiRMI16Maa0bSCswVtGnZYI6bXw5Yovg5vXTe2Xb
         GNISWJULYCUXhNhAS8g07BHo7H2voXPGCzj7UILTS09S0+uRsuxMbpDeHZqnWzQgP5C/
         JzDzzYM1jBsLXcf+hWxD40iMbrOqrt5dfqIhXsE1POVyYVPhxtjGSA33ZCgzrl8bF6GU
         NWCpdgWGVXHKQx+r8STixQoCrTs/8xxgmrh5uAl69e8ITuLejLrtkA02wk7f9oqehE7x
         pAMepF8kS4SWLlez8zG3gD3riflQPzePyarp+4kzMmFLHy8+dIGtjFz0q2IzgV6z3TmS
         iVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=BVkBApd5G5Moc32b/kOk/x8xpCJ4paLnsG5j0MXNmmc=;
        b=UUAXKe9O5ajO7X7H5xPKMBFPAD9HLexMbLRu3vStj56wjki3h8NQCTgC4A0qu/jvmM
         eIvseYRjHDu41ayOSSsbpqieSewjW26iWxOd2Yl903lHRmg2c9Ma4zQ2Envz5plyW887
         7ZNmQGbP2izQ99MvSIPbi0okpgP9bAaKUPLUex368UwSAsAoGWvUiFd/G6lvWsG/Mn/X
         9qFGHrDNBKJIE2OF+Qj2XtxZZ5qiQkESzmsbVCz2nFrR9uDt3S2dQQb3rxUZtXbny9/U
         xdC0XPXD0C/tm8zMpI8Wo+pvpJxQlQ0XkeIYnT5BbR1DM8CVM0Y8xuO9T8fBzrZNCc+v
         uAgQ==
X-Gm-Message-State: AOUpUlGOeOLZJ/rs2n4ln+cE27947zAlzhOjhm3DIaUDNgFy3JOQ/e6C
        aSHlFyVwr0T+8JBkEFeuWYk=
X-Google-Smtp-Source: AAOMgpf9eoTCETFeIu0GHRqDoIb9j6fW0t6ECy6pVUtuILr5aMX/hfhokZFYRWHzzZ5l4Pj0HuOoMQ==
X-Received: by 2002:a17:902:bcc6:: with SMTP id o6-v6mr10135127pls.117.1533468601773;
        Sun, 05 Aug 2018 04:30:01 -0700 (PDT)
Received: from zenus ([106.51.26.178])
        by smtp.gmail.com with ESMTPSA id e73-v6sm19546102pfb.153.2018.08.05.04.29.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Aug 2018 04:30:00 -0700 (PDT)
Date:   Sun, 5 Aug 2018 16:59:55 +0530
From:   Sohil Ladhani <supertakumi86@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Kees Cook <keescook@chromium.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Arushi Singhal <arushisinghal19971997@gmail.com>
Cc:     "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Sohil Ladhani <supertakumi86@gmail.com>
Subject: [PATCH v2] Staging: rtlwifi: base: Modified the line ending with a
 parenthesis
Message-ID: <20180805112950.GA13740@zenus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the "Lines should not end with a '('" warning reported by
checkpatch.pl script. The line containing 'rtl_mrate_idx_to_arfr_id' function
previously ended with '(', which did not conform to the linux kernel
coding style.

Signed-off-by: Sohil Ladhani <supertakumi86@gmail.com>
---

Changes in v2:
	- Made the commit message more clearer

 drivers/staging/rtlwifi/base.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtlwifi/base.c b/drivers/staging/rtlwifi/base.c
index 094827c1879a..654aa4e068ba 100644
--- a/drivers/staging/rtlwifi/base.c
+++ b/drivers/staging/rtlwifi/base.c
@@ -685,9 +685,8 @@ static void _rtl_query_protection_mode(struct ieee80211_hw *hw,
 	}
 }
 
-u8 rtl_mrate_idx_to_arfr_id(
-	struct ieee80211_hw *hw, u8 rate_index,
-	enum wireless_mode wirelessmode)
+u8 rtl_mrate_idx_to_arfr_id(struct ieee80211_hw *hw, u8 rate_index,
+			    enum wireless_mode wirelessmode)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
-- 
2.18.0

