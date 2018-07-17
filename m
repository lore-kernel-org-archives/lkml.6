Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC1DECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BDA020877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjtqa9Id"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BDA020877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeGQErG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:47:06 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:45853 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbeGQErG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:47:06 -0400
Received: by mail-pg1-f177.google.com with SMTP id f1-v6so181689pgq.12;
        Mon, 16 Jul 2018 21:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4xuxePlKrDsvoZ9vn8x9U4NknfnlCzvsDwjRn3FLYMs=;
        b=sjtqa9IdueaA+s5t4wR+EqS3JBOelwuc49Jjo0IXY2GHwodMvr05K5boNVA6O/g/c9
         PWGpUzGxLpYvkoy6OjYCSBvBbUeW63YYq9wkg+SOo9NvTGGOFefF3HhDRrkqyQELOkI2
         3wouBZ7HF76G6SEPZwys0Q893G41IK6xNT9HmjDUjKLR6A5mAyvWF8nwFd9pknia9IY9
         V0cDtTJ0uDIZfSYsUb3JdVF6/3qGKgUUeR1WWt9nduuyNBZ3iMJash4ydAoOT3E8jr1X
         XuAjnqW0ovMTcQpuhS3X3/I9k3mT2Q+VGYC7L12iWUF/wz7kaW2OCa5VapgsskhnIVN8
         BMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4xuxePlKrDsvoZ9vn8x9U4NknfnlCzvsDwjRn3FLYMs=;
        b=gYYLcCa76vXAyAtrmr8H8sBHN77g5INm5jDKrU72whzFKrCPkczC0LAxensY/jhO3a
         v2OOOlkyXHjNgxziCnnhMkCh5pGeHK6HTpTUAbNanG2cbNH4pMenbIpSm7vUyEL5qm8n
         af08MnlxGnOIVRAuDJXEam9GSNaj7pXful4PHplXu7O08KnbPXEp1qIjgsCARc0LK6mr
         99RqH457AoO5xOpTEhcPPqW3kxjVeopeILaxpf4+GWEU9j3vQZVfUy+AbIce0ZjjNwDS
         KkPUfT3gpKr/y8FCXMJhFLbdJOAbb28vkKM/w6HyHSUoNXNOcb8ZDpDTpxYsmm5HRTHu
         zHCA==
X-Gm-Message-State: AOUpUlG2M07+km7lfE9fSptRMeDX4b4uvlYMCCNg2U9nX89S7anO3VAR
        Ay8spgOWtahwitpgWxjBlXn9KcjS
X-Google-Smtp-Source: AAOMgpeUKNFrnpvQlDdjMZgWVRckIPz8IWy847qpHE2c/2f7hFlMKuKZj+X3mSArdmhE4qbLCz3oDA==
X-Received: by 2002:a63:5106:: with SMTP id f6-v6mr17445845pgb.95.1531800992276;
        Mon, 16 Jul 2018 21:16:32 -0700 (PDT)
Received: from 192-168-1-101.tpgi.com.com (14-202-218-81.tpgi.com.au. [14.202.218.81])
        by smtp.gmail.com with ESMTPSA id v30-v6sm72135915pgn.80.2018.07.16.21.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 21:16:31 -0700 (PDT)
From:   Jon Maxwell <jmaxwell37@gmail.com>
To:     davem@davemloft.net
Cc:     edumazet@google.com, ncardwell@google.com, David.Laight@aculab.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmaxwell@redhat.com
Subject: [PATCH net-next 0/3] Series to improve setsockopt() TCP_USER_TIMEOUT accuracy
Date:   Tue, 17 Jul 2018 14:15:59 +1000
Message-Id: <20180717041602.31100-1-jmaxwell37@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series based on:

https://patchwork.kernel.org/patch/10516195/

Every time the TCP retransmission timer fires. It checks to see if there is a 
timeout before scheduling the next retransmit timer. The retransmit interval 
between each retransmission increases exponentially. The issue is that in order 
for the timeout to occur the retransmit timer needs to fire again. If the user 
timeout check happens after the 9th retransmit for example. It needs to wait for 
the 10th retransmit timer to fire in order to evaluate whether a timeout has 
occurred or not. If the interval is large enough then the timeout will be 
inaccurate.

For example with a TCP_USER_TIMEOUT of 10 seconds without patch:

1st retransmit:

22:25:18.973488 IP host1.49310 > host2.search-agent: Flags [.]

Last retransmit:

22:25:26.205499 IP host1.49310 > host2.search-agent: Flags [.]

Timeout:

send: Connection timed out
Sun Jul  1 22:25:34 EDT 2018

We can see that last retransmit took ~7 seconds. Which pushed the total 
timeout to ~15 seconds instead of the expected 10 seconds. This gets more 
inaccurate the larger the TCP_USER_TIMEOUT value. As the interval increases.

Add tcp_clamp_rto_to_user_timeout() to determine if the user rto has expired.
Or whether the rto interval needs to be recalculated. Use the original interval
if user rto is not set. 

Test results with the patch is the expected 10 second timeout:

1st retransmit:

01:37:59.022555 IP host1.49310 > host2.search-agent: Flags [.]

Last retransmit:

01:38:06.486558 IP host1.49310 > host2.search-agent: Flags [.]

Timeout:

send: Connection timed out
Mon Jul  2 01:38:09 EDT 2018

Jon Maxwell (3):
  [PATCH net-next 1/3] tcp: convert icsk_user_timeout from jiffies to msecs
  [PATCH net-next v1 2/3] tcp: convert icsk_user_timeout from jiffies to msecs
  [PATCH net-next v1 3/3] tcp: convert icsk_user_timeout from jiffies to msecs

 net/ipv4/tcp.c       |  4 ++--
 net/ipv4/tcp_timer.c | 51 ++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 40 insertions(+), 15 deletions(-)

-- 
2.13.6

