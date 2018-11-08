Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92A6C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7D120827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjeJ017R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7D120827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbeKHSEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:04:53 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42836 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeKHSEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:04:53 -0500
Received: by mail-pg1-f195.google.com with SMTP id i4-v6so8546833pgq.9;
        Thu, 08 Nov 2018 00:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1u8wqLq2jfc+Hu+gHhiZiEjFU+PVKToHOLPSYozGJos=;
        b=cjeJ017R3DYhM53ncHaSzpSpxHyuzKHX0EjliJ5geAkIXNx5I282DD9zf+MWBeuQ9G
         pfxFulAT4pwWJReC6YwLoYnHkrMx4UeOdCp5a5/Uvj00H99HZ9+6tdBWLe4h48E/HYKZ
         udllmlIedy2P/4zDtMgAFu4oKnoTUvHbHVcfwbFxrEtvU11s+4nHChd0Vm3Dcm8n4/j0
         bhljTCwuTSX5QkTzpTeptZ1qLHertvglCH8fTMs8yA1bjE0oGOE87kzRwCU5dNRRDiD1
         c8J7yhpCUFU1ao3Rf28k0lT7Cls1V/fUAeLUI2Wxle+kTyncmVUu9lhZGxYXRsVLWotd
         4iPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1u8wqLq2jfc+Hu+gHhiZiEjFU+PVKToHOLPSYozGJos=;
        b=uoLBtpVXD57myNkPt/PvnDv4CXIR0BmEDTuMWOL2SnSPP3fgRqI0FBAe/3TC7F7I/C
         sZ26qg4uawdtwif7z1RObQENYz05Vgd60V4sh6uUiXbYXQfE7ZVavf/1p2tcP/sVelBC
         oXws/2VDRkSTii0+EsE27lA1c92yCEKFCvaVI1xhq8x6U4LEi/NeUgX0b6QD+SY9r9Rb
         tzHHUo2UEgb8poTvFdodWOPLqTMNNv+G6K0JC6sl3q54z6MBpnVJVKCKYFdlkIM/wvXp
         3bdqiWXTSHUEXkRcmxyzIEFAESmmqNkMfMfArSR6rI7tlD50nqW630TEhoVlyiMy7ivb
         qRCQ==
X-Gm-Message-State: AGRZ1gK5ZIoJTxEukN0ORcrBHKOqqshhimZoHzRm/wRzdOjvmiZ4VG3I
        blI8FtXvZ6/4lwM3eyQL2Ft7zenJ5xk=
X-Google-Smtp-Source: AJdET5cm2AtYAyPZHDU571No35fnw6s2qrFVfW8q7QMGBHhsRvJN+YlocMUEioAndrWfFKqw/GodgQ==
X-Received: by 2002:a62:250:: with SMTP id 77-v6mr3773883pfc.16.1541665829307;
        Thu, 08 Nov 2018 00:30:29 -0800 (PST)
Received: from localhost.localdomain ([2405:204:54a3:4742:28e4:be46:8b17:69ab])
        by smtp.gmail.com with ESMTPSA id m10-v6sm5370388pfg.180.2018.11.08.00.30.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 00:30:28 -0800 (PST)
From:   Suraj Singh <suraj1998@gmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        edumazet@google.com, Suraj Singh <suraj1998@gmail.com>
Subject: [PATCH] staging: net: ipv4: tcp_vegas: fixed checks and warnings
Date:   Thu,  8 Nov 2018 13:59:52 +0530
Message-Id: <1541665792-5888-1-git-send-email-suraj1998@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed checks and warnings in TCP Vegas

Signed-off-by: Suraj Singh <suraj1998@gmail.com>
---
 net/ipv4/tcp_vegas.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp_vegas.c b/net/ipv4/tcp_vegas.c
index ee113ff..0f65cbe 100644
--- a/net/ipv4/tcp_vegas.c
+++ b/net/ipv4/tcp_vegas.c
@@ -139,8 +139,7 @@ void tcp_vegas_state(struct sock *sk, u8 ca_state)
 }
 EXPORT_SYMBOL_GPL(tcp_vegas_state);
 
-/*
- * If the connection is idle and we are restarting,
+/* If the connection is idle and we are restarting,
  * then we don't want to do any Vegas calculations
  * until we get fresh RTT samples.  So when we
  * restart, we reset our Vegas state to a clean
@@ -223,7 +222,7 @@ static void tcp_vegas_cong_avoid(struct sock *sk, u32 ack, u32 acked)
 			 * and the window we would like to have. This quantity
 			 * is the "Diff" from the Arizona Vegas papers.
 			 */
-			diff = tp->snd_cwnd * (rtt-vegas->baseRTT) / vegas->baseRTT;
+			diff = tp->snd_cwnd * (rtt - vegas->baseRTT) / vegas->baseRTT;
 
 			if (diff > gamma && tcp_in_slow_start(tp)) {
 				/* Going too fast. Time to slow down
@@ -237,7 +236,7 @@ static void tcp_vegas_cong_avoid(struct sock *sk, u32 ack, u32 acked)
 				 * truncation robs us of full link
 				 * utilization.
 				 */
-				tp->snd_cwnd = min(tp->snd_cwnd, (u32)target_cwnd+1);
+				tp->snd_cwnd = min(tp->snd_cwnd, (u32)target_cwnd + 1);
 				tp->snd_ssthresh = tcp_vegas_ssthresh(tp);
 
 			} else if (tcp_in_slow_start(tp)) {
@@ -254,8 +253,7 @@ static void tcp_vegas_cong_avoid(struct sock *sk, u32 ack, u32 acked)
 					 * we slow down.
 					 */
 					tp->snd_cwnd--;
-					tp->snd_ssthresh
-						= tcp_vegas_ssthresh(tp);
+					tp->snd_ssthresh = tcp_vegas_ssthresh(tp);
 				} else if (diff < alpha) {
 					/* We don't have enough extra packets
 					 * in the network, so speed up.
-- 
2.7.4

