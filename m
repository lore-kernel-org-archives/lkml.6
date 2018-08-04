Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18178C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 07:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3344217B7
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 07:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/Qf/0vL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3344217B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbeHDJFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 05:05:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41576 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbeHDJFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 05:05:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id z8-v6so3859474pgu.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 00:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Kli2Ab0RWy6x5ZYlmofKwerNyjLhERBcgFZSgiS8Fqk=;
        b=g/Qf/0vL+QiNy2aJZ7MIWd/S35WApZjJABRnCmkqgtQcfQs3+xWj8jzUUedYwXIEmg
         Pm90Yhs5xki+6XOeMTNMpu6k/WCjXcevM72hHOxuoghD+7YnUJT7ca/S61KfRaREmfZ5
         /XCKJaWRZRJJxYka7W3e40P2/nRK+uNkJkDkaDmAXPj98UR6E9YHYBMZHr31rntCHUCO
         JD7mPtTfRSWBqO+2wgfNlfg2lieV5ecaG1VDpViX7m912H9CVuRd6L0TkyL3jsQ606QR
         6M0DEJ335zB3oLnSjt7wqt9CS1vqoZOptGV7MpLzSRt8xOQXw45mNKnZKQv4zPg4fNnY
         ygiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Kli2Ab0RWy6x5ZYlmofKwerNyjLhERBcgFZSgiS8Fqk=;
        b=iC8NvoU7JiIJZzCYJItBI+sbQTgN4P1gj2AKSvWHREQrWBnBXxSIJYQM/6ly4GXCC6
         qiKhRCuyjerEKgweV3BnQe1kPEMmZ8GoF8rOk/wT772hm0ZfEgCDga66sYNwk9QHwWTO
         9sXkuwBfGF2ZprYcAK7nb/jzVHYfWOKc8iXPlW1Iy7hN9o3MHXfYMRVca1iU0ZBjh9L7
         hn/OX+pD59sKniP3id5p1aYBoPFU7AZlSbZ8hIsZYrUXuNhCmQavaYjc1Sd7oa5bInm7
         ICqvEoKQP2tLInUs0aduhUObsLZFEx0RHDt8mPjEwFhnPIq7WDHNVElc2Qbcl1fHbOhP
         9PJg==
X-Gm-Message-State: AOUpUlEtnzTxNW2S0pp5O0AfK/EcrqByxiD9S6FaXXeCIoBPyy4r4vvM
        zR3aqm2L+42uE2Z8Er4K5xjyUP2DMMI=
X-Google-Smtp-Source: AAOMgpddkWU1tTKdIkwDNTWhio/6ROYBcbeQd7AhHxtaRADRWOCSZi5MvQ0rhW1gbDtPJcIeDvhauA==
X-Received: by 2002:a63:6b86:: with SMTP id g128-v6mr6792896pgc.344.1533366356344;
        Sat, 04 Aug 2018 00:05:56 -0700 (PDT)
Received: from zenus ([106.51.26.178])
        by smtp.gmail.com with ESMTPSA id r87-v6sm11032347pfb.1.2018.08.04.00.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 00:05:55 -0700 (PDT)
Date:   Sat, 4 Aug 2018 12:35:49 +0530
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
Subject: [PATCH] Staging: rtlwifi: base: fixed a brace coding style issue
Message-ID: <20180804070540.GA8867@zenus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue

Signed-off-by: Sohil Ladhani <supertakumi86@gmail.com>
---
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

