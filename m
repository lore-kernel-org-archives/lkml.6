Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5082AC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C6021726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vDButwXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731806AbfAXT5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:57:21 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37722 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728923AbfAXT5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:57:18 -0500
Received: by mail-lj1-f196.google.com with SMTP id t18-v6so6370736ljd.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 11:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=JD5WRLDcyAIMKxtCkk72zkUgX48bEbI0nw5VReqxjFY=;
        b=vDButwXSbNg6LN2JfKODmPTvWqBUH/hROLPmZT2BObig5V1lfFe1c/EJPhKxcFxz6J
         j7BXF2Ut4zwo4DPt6Vgd89UrUioHHyUMZOfiouBUDVBbXAjjL6Jofy3oAdCaINE8ekm2
         jnJS/Z328QfjfuZ9nZaBfKqNKF28ogtnhnf9NXRYhVxR/VAhtGvKX+WkgUEhCU1MtJBH
         prm5etQ83i5zgeO/rnP8W46R1h4BOxsr7x7RDWnt8Vh78L2Zxx4UtpYu/gOtfozi8L+O
         AdFMXfT8qUeNkECD0FjGANlb4pQ/q1a7AJiTccoc1kAsqBIlKW6LLVHS7y1uu7KPUkbf
         0UFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JD5WRLDcyAIMKxtCkk72zkUgX48bEbI0nw5VReqxjFY=;
        b=WFR7n8/GjzzvE9YsDTbySEutgMOrj7rnqTqwUV9dfsjaj2Ti+uOt6ZVcZ4MGUdR3i2
         y0JGrWefl8rG7ncXif5bxQZjRglPIp67HbOvvuBDYS29cKUviE41OZejWSOMpTDENLUL
         cCzlrOCVfAMnSuLpUQF8UeU9wh3f3QhoShX5aDl0uhZDTHh7iinzGMcUfp6AooI+MCCD
         RicibEeVr8PVeJNU9nJWycFTOQO1bdJg9zhuExVynq5z56ZILbG3OjPgb5PL3Znnmfj/
         pkFxxTY5/BHdtjS9sv2pe4RXZZ/vHwVMj14pKDU726edlJ3BNY0nkar3CIczUanWxAs0
         tvOg==
X-Gm-Message-State: AJcUukcvWGSerCXwproB1A8C+P32Rkxj0Zxn/gHlRDrd/Zsgvj+j3/9a
        9s8XQ0IapE1aMCYVnH+6kG8kUPY8bIg=
X-Google-Smtp-Source: ALg8bN7REACZr8pisrCGjZjVbabj6lu2tvwdUhe7qc0XAOtddAAjC04IRlhfCnerUd3fP4HxzHT9zQ==
X-Received: by 2002:a2e:910d:: with SMTP id m13-v6mr6566399ljg.187.1548359835993;
        Thu, 24 Jan 2019 11:57:15 -0800 (PST)
Received: from localhost ([2a02:a311:825b:e300:2c63:f9e2:fcfa:cc46])
        by smtp.gmail.com with ESMTPSA id q3sm1079583lff.42.2019.01.24.11.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 11:57:15 -0800 (PST)
Date:   Thu, 24 Jan 2019 20:57:19 +0000
From:   Cezary Kierzyk <virdipravum.n008d3v@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] staging: rtlwifi: replace ---help--- with help in Kconfig
Message-ID: <20190124205719.GA10685@pravumPC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:

WARNING: prefer 'help' over '---help---' for new help texts

Signed-off-by: Cezary Kierzyk <virdipravum.n008d3v@gmail.com>
---
 drivers/staging/rtlwifi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtlwifi/Kconfig b/drivers/staging/rtlwifi/Kconfig
index 7b4276f5c41f..28286a87a601 100644
--- a/drivers/staging/rtlwifi/Kconfig
+++ b/drivers/staging/rtlwifi/Kconfig
@@ -2,7 +2,7 @@ config R8822BE
 	tristate "Realtek RTL8822BE Wireless Network Adapter"
 	depends on PCI && MAC80211 && m
 	select FW_LOADER
-	---help---
+	help
 	This is the staging driver for Realtek RTL8822BE 802.11ac PCIe
 	wireless network adapters.
 
-- 
2.20.1

