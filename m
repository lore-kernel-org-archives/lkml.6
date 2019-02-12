Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB82C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB3B2080F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIeRmYoy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfBLLcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:32:33 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35549 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfBLLcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:32:32 -0500
Received: by mail-pf1-f195.google.com with SMTP id z15so423144pfa.2;
        Tue, 12 Feb 2019 03:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bpbMC4OTSFMZoTtlLgYtSVJtAS0x+r3cgSCpKmv618g=;
        b=lIeRmYoyS0iHyylExh+qYevCyVHA1IL6Z7NlqRydTtR0XYX474nmEva0l3G6vEmMnL
         /TEmRnGCU57BafkIyn/vZ0lm2lzWrAK8Mr6U8e3A9LyCbcpq2DKbBYsORnaW9isXyPpi
         YXGwnzQNd51r9W+jzYqc8d1PupCv4rPHI2Lw23OluAqIZCp/mjD9x+ziAA+PE+hLSUnM
         PCNKSeqGgimEGm/dkOh24FFNanmlInCpNFT+j1wRzU6mtqxDx6rLczrqn1/ZLKooio8r
         RKypyxtUCJpMGgtmWPFqio/Q5oqBjYoBMlG7mL3o5Svqx5IHrmppT2yfWQWCidLGrRiW
         UTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bpbMC4OTSFMZoTtlLgYtSVJtAS0x+r3cgSCpKmv618g=;
        b=QZjCrI5Muvf+gV7Tam/Cw5+4543ACP5rBOvSywEMGbcsvJrEp+65TefPH7tUaZ0cq7
         EvDHX4ubusfMe0oINUyQcdDdnxim/scZGuJlBAgs5zLz9oVVovW01ZKnFn0m7o096IS9
         kMuw1rkdkJlBlaUM1WUr7+FxBFAFUovmaoI0gNBMZsLkdNnWJeS9rAh8q8baWWpdgEr7
         afpHbzLJqa2WYMn12K0PIZW6KZ2P7GtWDQfV+7UCBGu+wsx32wE9k158oXPzrPxHe3bO
         suIFElu8cu+KhTYjFJyQneuELcs7k0DLT0upFkhTY48vPQ0sUE1K7w6KTWUWb5aQUNi8
         B/4g==
X-Gm-Message-State: AHQUAua3Gdc0vzt+j1yw2lZEjmz8ny0UymwRpi2/VgnXyrTf1q3LazcS
        bMnRwMxJi6AJyLdyKKMZQdI=
X-Google-Smtp-Source: AHgI3IYAoNZTzqrpkt9jxHYZh5pEXI8wZWJSCexX1oOURJTvgHdNMH0voPP121gkFf/hSmBhLomAtg==
X-Received: by 2002:a63:2d5:: with SMTP id 204mr1562585pgc.407.1549971151902;
        Tue, 12 Feb 2019 03:32:31 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id q21sm28701034pfq.138.2019.02.12.03.32.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 03:32:31 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     daniel@iogearbox.net, ast@kernel.org
Cc:     yhs@fb.com, brakmo@fb.com, edumazet@google.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, shaoyafang@didiglobal.com,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [bpf-next 0/2] cleanup SOCK_DEBUG() and introduce BPF_SOCK_OPS_STATS_CB
Date:   Tue, 12 Feb 2019 19:31:35 +0800
Message-Id: <1549971097-12627-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SOCK_DEBUG is a very ancient debugging interface, and it's not very useful
for debugging.
This pacthset cleanups SOCK_DEBUG() and replace it with a new methord
based on BPF.

I cleanup SOCK_DEBUG() only for TCP, and other protocols are kept as is.

After this patchset, the SO_DEBUG interface will not take any effect for
TCP, but I still keep it in sock_{s,g}etsockopt() for TCP to avoid breaking
applications.

In the future we may extend tcp_stats() as bellow or something else to
cover all the LINUX_MIB_* and TCP_MIB_* proposaled[0] in the netconf2018.

now:
	tcp_stats(struct sock *sk, int mib_idx)
future:
	tcp_stats(struct sock *sk, int mib_idx, int packets)
	The argument packets can be 1 to indicates this is a event only;
	and skb_shinfo(skb)->gso_segs to indicates the number of packets
	are also concerned.

[0] page 14,
http://vger.kernel.org/netconf2018_files/BrendanGregg_netconf2018.pdf

Yafang Shao (2):
  tcp: replace SOCK_DEBUG() with tcp_stats()
  bpf: add BPF_SOCK_OPS_STATS_CB for tcp_stats()

 include/uapi/linux/bpf.h  |  5 +++++
 include/uapi/linux/snmp.h |  3 +++
 net/ipv4/proc.c           |  3 +++
 net/ipv4/tcp_input.c      | 27 ++++++++++++---------------
 net/ipv6/tcp_ipv6.c       |  2 --
 5 files changed, 23 insertions(+), 17 deletions(-)

-- 
1.8.3.1

