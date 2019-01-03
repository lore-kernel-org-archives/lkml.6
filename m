Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537A4C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270F2217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfACUqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 15:46:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42028 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfACUqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 15:46:18 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 46F4E11532;
        Thu,  3 Jan 2019 20:46:18 +0000 (UTC)
Received: from epycfail.redhat.com (ovpn-200-16.brq.redhat.com [10.40.200.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E406608DD;
        Thu,  3 Jan 2019 20:46:14 +0000 (UTC)
From:   Stefano Brivio <sbrivio@redhat.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     syzbot <syzbot+4ad25edc7a33e4ab91e0@syzkaller.appspotmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH net 0/2] Fix two further potential unbounded recursions in GUE error handlers
Date:   Thu,  3 Jan 2019 21:43:33 +0100
Message-Id: <cover.1546547862.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 03 Jan 2019 20:46:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1/2 takes care of preventing the issue fixed by commit 11789039da53
("fou: Prevent unbounded recursion in GUE error handler") also with
UDP-Lite payloads -- I just realised this might happen from a syzbot
report.

Patch 2/2 fixes the issue for both UDP and UDP-Lite on IPv6, which I also
forgot to deal with in that same commit.

Stefano Brivio (2):
  fou: Prevent unbounded recursion in GUE error handler also with
    UDP-Lite
  fou6: Prevent unbounded recursion in GUE error handler

 net/ipv4/fou.c  | 3 ++-
 net/ipv6/fou6.c | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.20.1

