Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D598C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46C4219CF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="md3KhLzo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A46C4219CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeHFGEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 02:04:30 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41889 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbeHFGEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 02:04:30 -0400
Received: by mail-pl0-f66.google.com with SMTP id w19-v6so3399409ply.8;
        Sun, 05 Aug 2018 20:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AIR8xJ6fQZo2twUMLmgBkz2Y7uzQaPhZO6PIr17xNQM=;
        b=md3KhLzo/f3IIUg0vKXK2c6ZIYBG7ePe4bYhi2SiPKEDDnVTQfQPk0EM/NUkJsZsxY
         USh09klGTYtXE/2yZ/n9HhfiCUqArkMP18LY9lHDYShvrvBxvxgh+S6G937/albQc+g5
         lJcSEDvGpqvgWAqvXtkBiIVnM3r4RCbOgHuMgww5g6L19yCmjQaxpOCdG/FREssR9hYL
         CZU+KqPpnlpCFpYlq6Uw7DDGJmTIeuUHXk9jDzUPz4WM/BXN8f68yPEKZ3gzbY41CNN+
         HQb9bWjoTCWHWWhRbH/LA6eBhRIA9tzg0GAOifA/F3gR9HdIUYHTpfpAQ5vfe8empcRg
         8ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AIR8xJ6fQZo2twUMLmgBkz2Y7uzQaPhZO6PIr17xNQM=;
        b=gUaRbACy4sDnLUBCTEhpxAj12UgsRPr+6aAmKEPJMsncPxtLSgj8a60oDTIIQvvpms
         AW018hxxxePvdplGAByIfpk+/AcxDOI9xz6PrveNgJM8E+IGkSyvpULBXT5d0dHxLtI2
         7PqdnPW7ctSlWsRmuXXhpn2ah3OCVE14xD3C0Qhbqm7asLpr5A6+ZkWTFJVTc2339DRo
         P9VBqriLyX/lbpihqPQKhI7C1SjCWysES43XKYr3inkv98km4P9ee+pVcpWamJb9czDZ
         WUs+gPIdF6DTcSPuYZoX7bVgsohoueDqjjTwXmUM+iG3YLAJerNR0/0c/XTE/Q2OtUhA
         TmHQ==
X-Gm-Message-State: AOUpUlGbXqLb78y/bzlFPzVXmDL5EsYlpPNkTdgMQfTmM7pzImiShnOg
        ocouf/ITyow/X5A3Wlv9hBSpVonjAbk=
X-Google-Smtp-Source: AAOMgpd3mLH5LyJhlD+3IH2LQGA0949alRM7ypCg2c4D1ngD/LVb2owoB+x8ulYO7lFGt5EwZpaJ4Q==
X-Received: by 2002:a17:902:5617:: with SMTP id h23-v6mr12254712pli.324.1533527843124;
        Sun, 05 Aug 2018 20:57:23 -0700 (PDT)
Received: from bogon.didichuxing.com ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id g15-v6sm17548360pfg.98.2018.08.05.20.57.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 20:57:22 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH net-next] net: avoid unnecessary sock_flag() check when enable timestamp
Date:   Mon,  6 Aug 2018 11:57:02 +0800
Message-Id: <1533527822-3324-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sock_flag() check is alreay inside sock_enable_timestamp(), so it is
unnecessary checking it in the caller.

    void sock_enable_timestamp(struct sock *sk, int flag)
    {
        if (!sock_flag(sk, flag)) {
            ...
        }
    }

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 net/compat.c    | 6 ++----
 net/core/sock.c | 8 ++++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/compat.c b/net/compat.c
index 7242cce..3b2105f 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -466,8 +466,7 @@ int compat_sock_get_timestamp(struct sock *sk, struct timeval __user *userstamp)
 
 	ctv = (struct compat_timeval __user *) userstamp;
 	err = -ENOENT;
-	if (!sock_flag(sk, SOCK_TIMESTAMP))
-		sock_enable_timestamp(sk, SOCK_TIMESTAMP);
+	sock_enable_timestamp(sk, SOCK_TIMESTAMP);
 	tv = ktime_to_timeval(sk->sk_stamp);
 	if (tv.tv_sec == -1)
 		return err;
@@ -494,8 +493,7 @@ int compat_sock_get_timestampns(struct sock *sk, struct timespec __user *usersta
 
 	ctv = (struct compat_timespec __user *) userstamp;
 	err = -ENOENT;
-	if (!sock_flag(sk, SOCK_TIMESTAMP))
-		sock_enable_timestamp(sk, SOCK_TIMESTAMP);
+	sock_enable_timestamp(sk, SOCK_TIMESTAMP);
 	ts = ktime_to_timespec(sk->sk_stamp);
 	if (ts.tv_sec == -1)
 		return err;
diff --git a/net/core/sock.c b/net/core/sock.c
index e31233f..3730eb8 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2900,8 +2900,8 @@ bool lock_sock_fast(struct sock *sk)
 int sock_get_timestamp(struct sock *sk, struct timeval __user *userstamp)
 {
 	struct timeval tv;
-	if (!sock_flag(sk, SOCK_TIMESTAMP))
-		sock_enable_timestamp(sk, SOCK_TIMESTAMP);
+
+	sock_enable_timestamp(sk, SOCK_TIMESTAMP);
 	tv = ktime_to_timeval(sk->sk_stamp);
 	if (tv.tv_sec == -1)
 		return -ENOENT;
@@ -2916,8 +2916,8 @@ int sock_get_timestamp(struct sock *sk, struct timeval __user *userstamp)
 int sock_get_timestampns(struct sock *sk, struct timespec __user *userstamp)
 {
 	struct timespec ts;
-	if (!sock_flag(sk, SOCK_TIMESTAMP))
-		sock_enable_timestamp(sk, SOCK_TIMESTAMP);
+
+	sock_enable_timestamp(sk, SOCK_TIMESTAMP);
 	ts = ktime_to_timespec(sk->sk_stamp);
 	if (ts.tv_sec == -1)
 		return -ENOENT;
-- 
1.8.3.1

