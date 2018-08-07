Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23727C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5DE21723
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxGd4hu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD5DE21723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbeHGX3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:29:21 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53383 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeHGX3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:29:20 -0400
Received: by mail-wm0-f65.google.com with SMTP id s9-v6so506254wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hgKmHDTtsqmPUB+PoQ9/ln1Q4bu7ZiK/SB2CLRcUiPk=;
        b=nxGd4hu98PVIhcpJO9KZGNndwTjBUbRzwOjP0HnFTb3aWQ7Eq11PyBO5Je/I+qXwGl
         gOe51Xoe2uDKmuxP8VZ2x9drUpXEjFEDZQpRuSjRHL8I8BB3WnMNET+WOmUzs9SCxPj7
         Kqe4BA44rli4E4yz6LfAxwD1dqNu21SngJSeaDFZSj284/wrmqpuirEs0PI7XUC1JM0a
         oLsXaUhHDBhnRPW1ez6leIfIT5+VealQscZmDOaQZ/4ji9WewcdYAChuAx9EqT8HaD37
         0qsFD6Zqw/dwAlFwAySYYJYzm20YIaGsLCYMU9/zJW3E+sE2iydyTcywatjk844WMhTT
         eGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hgKmHDTtsqmPUB+PoQ9/ln1Q4bu7ZiK/SB2CLRcUiPk=;
        b=Wbef5lPDmhgyIVugMgV/9e7oPMoWSv0ZM0N8FhSHq4vNuSGmm4LJaHcZ1KMny9htK6
         OclzPfiIWDgk14e01meKXH2XxR/H2wNy9nnNQkxe4CPl9SevywGppFXZx80lkGKbet/J
         Xt/IaThBEOGV5MVyEdVONeMLgQFl5wCg0EmK1GnFESYqPexhUIftbbNSa5QHW1a9BZNf
         /xP3Z1t54LODqDofWC3OOBgvy6bQFreZZkp54Q2BWcpNwhVcuojS4BlwWG8qaUNMJR1i
         LqbQQRC+I6L6NORhq51LcUcygqN8lKKECM8W7Nxpmn1WHeNaM9TBB924m4PlZOIWnpwb
         HFKQ==
X-Gm-Message-State: AOUpUlGb9+YQ2kCX5JzdKrEhM4vNblfAfSP0BZv4yrIYbBI2z3/evpPt
        6rMBzPPKFlFLuFq6ZaOAW+SJLSV3
X-Google-Smtp-Source: AA+uWPzbz+DACz6aFOJg3jfS9gmPmPD53bAjkSBsaxx5WNE/0TcuaH1DqQ51WRY9jlioQ9UTZ/vq5Q==
X-Received: by 2002:a1c:3646:: with SMTP id d67-v6mr41624wma.15.1533676381480;
        Tue, 07 Aug 2018 14:13:01 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o3-v6sm3375985wrj.31.2018.08.07.14.13.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 14:13:00 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 01/17] staging:rtl8192u: Remove stale comment - Style
Date:   Tue,  7 Aug 2018 22:12:39 +0100
Message-Id: <20180807211255.29343-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807211255.29343-1-johnfwhitmore@gmail.com>
References: <20180807211255.29343-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a comment which appears to be from a previous version of code.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 5639bb498865..d4c8c28190ff 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -17,8 +17,6 @@ enum dot11d_state {
 };
 
 struct rt_dot11d_info {
-	/* DECLARE_RT_OBJECT(rt_dot11d_info); */
-
 	bool enabled; /* dot11MultiDomainCapabilityEnabled */
 
 	u16 country_ie_len; /* > 0 if country_ie_buf[] contains valid country information element. */
-- 
2.18.0

