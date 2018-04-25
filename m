Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751139AbeDYF1b (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 01:27:31 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33558 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbeDYF12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 01:27:28 -0400
X-Google-Smtp-Source: AB8JxZr1qeIyW/BU4kyAQNV3ZlefPvcf9BkFG+lJ5QOCNWUFOrXxmaM3uoWUEK1g0IrjayH7cOXMjA==
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: [PATCH net-next 0/2] tcp: mmap: rework zerocopy receive
Date: Tue, 24 Apr 2018 22:27:20 -0700
Message-Id: <20180425052722.73022-1-edumazet@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported a lockdep issue caused by tcp mmap() support.

I implemented Andy Lutomirski nice suggestions to resolve the
issue and increase scalability as well.

First patch is adding a new setsockopt() operation and changes mmap()
behavior.

Second patch changes tcp_mmap reference program.

Eric Dumazet (2):
  tcp: add TCP_ZEROCOPY_RECEIVE support for zerocopy receive
  selftests: net: tcp_mmap must use TCP_ZEROCOPY_RECEIVE

 include/uapi/linux/tcp.h               |   8 ++
 net/ipv4/tcp.c                         | 186 +++++++++++++------------
 tools/testing/selftests/net/tcp_mmap.c |  63 +++++----
 3 files changed, 139 insertions(+), 118 deletions(-)

-- 
2.17.0.484.g0c8726318c-goog
