Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4B3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589A12075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwwQgEiz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589A12075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbeGRBWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 21:22:11 -0400
Received: from mail-pl0-f54.google.com ([209.85.160.54]:38816 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730731AbeGRBWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 21:22:11 -0400
Received: by mail-pl0-f54.google.com with SMTP id b1-v6so1197120pls.5;
        Tue, 17 Jul 2018 17:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JrzGtihrXg9m/GzAN6ahdCyeBGwkiYP0OXywZlaL17Q=;
        b=iwwQgEizYpCcVurCfg70lWlmjtrF2EkOg/wQK96AVkO5tQ42IIJCcYq75xww5H3iGH
         LlC7nIIbAo7D9BX8ijWplsy8nJR92fSihkHlnDjnt0eGFD1Am9NjO6oRHaD/H9zNy/Mg
         5rqYukKB5K6IIB1k7H4UC/fSVE7lmjV5nqEtPR97AveYxs4gXV+0t+HGaasuNnmLirth
         H277SjTsKQowdwlcbVacEwkogVzw6sQwA8/C9R1x419qPltcTmD95CmwdSJthGMgvgKZ
         m7P4nonJw19a5oBqZ+vhEVxhSn9BM/7r/uS7nU0OW09aUSSF5DBv1HI/ZKqZTBICiaUD
         Z5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JrzGtihrXg9m/GzAN6ahdCyeBGwkiYP0OXywZlaL17Q=;
        b=NPDtLk/FNxmVvsCrdPiO2tTIQ64VOmMw+pH3dGNPNFVvdnHAPp0RExcQRhBx/qZCtE
         hUiEVTiGvJhT8PVlGhiA1GfEDP0DWBEhr/B1RC1gRxLpOwfMzWfXDWHTQWtSBrE3efJK
         SDXVuqicqg2jUzeOoQcutLwmJmFg6+Be96r6ccjCG7KhcWzf22jRJ4w5zCMmrCUlz2Yp
         /uXVwCJjV4VId/Gmj+90jd8Vp/0vUrmdSlNCTI24Q37wWL4zc9VYZ2b/Dv72ZouGT4Ry
         gQN7XBF/FCIuq8IaU4fgbFafk0XKU09tJB94BJ/I39Mo1UzBEOH44nTOHnL4rO4AxP7n
         R44w==
X-Gm-Message-State: AOUpUlG6NMB81uEauKtNu4rql6BmIG3O1544OoCI5wr2AZcNvMsX+Auf
        I9/jbwmWPXItmNWxrcOvL+g=
X-Google-Smtp-Source: AAOMgpcZoIpz6hAUHXPNSzeX+QJz6GPRzMoc1DEZy/ITwfPdt6CCH+muXHk+OwvQq3Hih2OlfadR+w==
X-Received: by 2002:a17:902:bb05:: with SMTP id l5-v6mr3710374pls.246.1531874820447;
        Tue, 17 Jul 2018 17:47:00 -0700 (PDT)
Received: from 192-168-1-101.tpgi.com.com ([61.68.123.183])
        by smtp.gmail.com with ESMTPSA id b62-v6sm9190775pfm.97.2018.07.17.17.46.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 17:46:59 -0700 (PDT)
From:   Jon Maxwell <jmaxwell37@gmail.com>
To:     davem@davemloft.net
Cc:     edumazet@google.com, eric.dumazet@gmail.com, ncardwell@google.com,
        David.Laight@aculab.com, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmaxwell@redhat.com
Subject: [PATCH net-next 0/3] tcp: improve setsockopt() TCP_USER_TIMEOUT accuracy
Date:   Wed, 18 Jul 2018 10:46:36 +1000
Message-Id: <20180718004639.30154-1-jmaxwell37@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on:

https://patchwork.kernel.org/patch/10516195/

Every time the TCP retransmission timer fires. It checks to see if 
there is a timeout before scheduling the next retransmit timer. The 
retransmit interval between each retransmission increases 
exponentially. The issue is that in order for the timeout to occur the
retransmit timer needs to fire again. If the user timeout check happens 
after the 9th retransmit for example. It needs to wait for the 10th 
retransmit timer to fire in order to evaluate whether a timeout has 
occurred or not. If the interval is large enough then the timeout will 
be inaccurate.

For example with a TCP_USER_TIMEOUT of 10 seconds without patch:

1st retransmit:

22:25:18.973488 IP host1.49310 > host2.search-agent: Flags [.]

Last retransmit:

22:25:26.205499 IP host1.49310 > host2.search-agent: Flags [.]

Timeout:

send: Connection timed out
Sun Jul  1 22:25:34 EDT 2018

We can see that last retransmit took ~7 seconds. Which pushed the total 
timeout to ~15 seconds instead of the expected 10 seconds. This gets 
more inaccurate the larger the TCP_USER_TIMEOUT value. As the interval 
increases.

Add tcp_clamp_rto_to_user_timeout() to determine if the user rto has 
expired. Or whether the rto interval needs to be recalculated. Use the 
original interval if user rto is not set. 

Test results with the patch is the expected 10 second timeout:

1st retransmit:

01:37:59.022555 IP host1.49310 > host2.search-agent: Flags [.]

Last retransmit:

01:38:06.486558 IP host1.49310 > host2.search-agent: Flags [.]

Timeout:

send: Connection timed out
Mon Jul  2 01:38:09 EDT 2018

Jon Maxwell (3):
  tcp: convert icsk_user_timeout from jiffies to msecs
  tcp: Add tcp_retransmit_time() helper routine
  tcp: Add tcp_clamp_rto_to_user_timeout() helper to improve accuracy

 net/ipv4/tcp.c       |  4 ++--
 net/ipv4/tcp_timer.c | 51 ++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 40 insertions(+), 15 deletions(-)

-- 
2.13.6

