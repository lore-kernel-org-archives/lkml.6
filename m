Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id VWe1EN+SGVtkPQAAmS7hNA
	; Thu, 07 Jun 2018 20:17:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 20615608FF; Thu,  7 Jun 2018 20:17:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 311CD606FA;
	Thu,  7 Jun 2018 20:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 311CD606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932399AbeFGURa (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:17:30 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:39796 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753023AbeFGUR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:17:28 -0400
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w57KHRLI001012
        for <linux-kernel@vger.kernel.org>; Thu, 7 Jun 2018 16:17:27 -0400
Received: from mail-qt0-f197.google.com (mail-qt0-f197.google.com [209.85.216.197])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w57KHM4h012585
        for <linux-kernel@vger.kernel.org>; Thu, 7 Jun 2018 16:17:27 -0400
Received: by mail-qt0-f197.google.com with SMTP id m20-v6so9886983qtm.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 13:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:mime-version
         :content-transfer-encoding:date:message-id;
        bh=CochqnUpAa8VPJ0tIg1rhMMOWdQvKF8RVoRMw2/77XM=;
        b=pR4q4tjk0JcYfNUIszbcnUcbM0UuTvngOHPQeNCSxj4iqJTZQyP+0YXJ7ec/ehXwmC
         uHzasS5+tZjwc+nixyKa+tVaOFRs4GPWtZPsuiRWGwzTI7V5oHIBC9/aW09hvJeN1Nrv
         eI2kG+vRKZLIcYjGCiXWLxYSXHfR6/WmBjUXYaJTwCS/1atBIznD1dUg1YB4cov1tKDp
         P/modFnHLuaQVdik0FM+j8JGkq4eE0L6PDsOVQ5jjkHOfUl9dOJgNOWg7PpSNL1cjd5J
         01jrxDFg7S398K+mOzIRHR8vxt6nGCvkwJUHRyMYIEpTNzFPSLIn+7MjAEl/2Ys/RQsb
         yBqA==
X-Gm-Message-State: APt69E2/nIPUgreyMnF3Kl0ONbYO2xXtxIms4xDNNxRUICZCEZxyKaPW
        +NpIsFrX/4xPw57Su3a7m7Nhft9mEm/Um5dXcYx+Kk4fvBMjagclKW2HQREXvW/u4gt6UpIaGUq
        0z+IqiJJxfSovWMKpTXdqoSE492WpmBiCTnI=
X-Received: by 2002:ac8:191d:: with SMTP id t29-v6mr3402589qtj.264.1528402642345;
        Thu, 07 Jun 2018 13:17:22 -0700 (PDT)
X-Google-Smtp-Source: ADUXVKKkNrqHc/d84UN2VTgbFQ17TVPADdEnI675gGDC3p02LFe5aqLrM5p+4Uv3svjD4lFKJHymyA==
X-Received: by 2002:ac8:191d:: with SMTP id t29-v6mr3402570qtj.264.1528402642065;
        Thu, 07 Jun 2018 13:17:22 -0700 (PDT)
Received: from turing-police.cc.vt.edu ([2607:b400:24:0:5dba:c103:941e:4ee3])
        by smtp.gmail.com with ESMTPSA id i85-v6sm24757987qke.27.2018.06.07.13.17.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 13:17:20 -0700 (PDT)
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
From: valdis.kletnieks@vt.edu
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: next-20180605 - BUG in ipv6_add_addr
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1528402643_2539P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 07 Jun 2018 16:17:23 -0400
Message-ID: <15599.1528402643@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1528402643_2539P
Content-Type: text/plain; charset=us-ascii

Hit the following, after which my network connection was pretty much hosed

This ring any bells? I don't have a reproducer for this, so bisecting is problematic....

[ 1820.832682] BUG: unable to handle kernel NULL pointer dereference at 0000000000000209
[ 1820.832728] RIP: 0010:ipv6_add_addr+0x280/0xd10
[ 1820.832732] Code: 49 8b 1f 0f 84 6a 0a 00 00 48 85 db 0f 84 4e 0a 00 00 48 8b 03 48 8b 53 08 49 89 45 00 49 8b 47 10
49 89 55 08 48 85 c0 74 15 <48> 8b 50 08 48 8b 00 49 89 95 b8 01 00 00 49 89 85 b0 01 00 00 4c
[ 1820.832847] RSP: 0018:ffffaa07c2fd7880 EFLAGS: 00010202
[ 1820.832853] RAX: 0000000000000201 RBX: ffffaa07c2fd79b0 RCX: 0000000000000000
[ 1820.832858] RDX: a4cfbfba2cbfa64c RSI: 0000000000000000 RDI: ffffffff8a8e9fa0
[ 1820.832862] RBP: ffffaa07c2fd7920 R08: 000000000000017a R09: ffffffff8a555300
[ 1820.832866] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888d18e71c00
[ 1820.832871] R13: ffff888d0a9b1200 R14: 0000000000000000 R15: ffffaa07c2fd7980
[ 1820.832876] FS:  00007faa51bdb800(0000) GS:ffff888d1d400000(0000) knlGS:0000000000000000
[ 1820.832880] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1820.832885] CR2: 0000000000000209 CR3: 000000021e8f8001 CR4: 00000000001606e0
[ 1820.832888] Call Trace:
[ 1820.832898]  ? __local_bh_enable_ip+0x119/0x260
[ 1820.832904]  ? ipv6_create_tempaddr+0x259/0x5a0
[ 1820.832912]  ? __local_bh_enable_ip+0x139/0x260
[ 1820.832921]  ipv6_create_tempaddr+0x2da/0x5a0
[ 1820.832926]  ? ipv6_create_tempaddr+0x2da/0x5a0
[ 1820.832941]  manage_tempaddrs+0x1a5/0x240
[ 1820.832951]  inet6_addr_del+0x20b/0x3b0
[ 1820.832959]  ? nla_parse+0xce/0x1e0
[ 1820.832968]  inet6_rtm_deladdr+0xd9/0x210
[ 1820.832981]  rtnetlink_rcv_msg+0x1d4/0x5f0
[ 1820.832989]  ? netlink_deliver_tap+0xe2/0x7a0
[ 1820.832996]  ? rtnetlink_put_metrics+0x290/0x290
[ 1820.833003]  netlink_rcv_skb+0x4d/0x140
[ 1820.833012]  rtnetlink_rcv+0x15/0x20
[ 1820.833018]  netlink_unicast+0x215/0x340
[ 1820.833027]  netlink_sendmsg+0x2e3/0x6a0
[ 1820.833040]  sock_sendmsg+0x6a/0xf0
[ 1820.833047]  __sys_sendto+0x15d/0x220
[ 1820.833059]  ? __sys_recvmsg+0x51/0x90
[ 1820.833068]  ? do_syscall_64+0x30/0xee7
[ 1820.833076]  __x64_sys_sendto+0x2f/0x50
[ 1820.833082]  do_syscall_64+0x98/0xee7
[ 1820.833089]  ? trace_hardirqs_off_caller+0x1f/0xd0
[ 1820.833096]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[ 1820.833107]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 1820.833113] RIP: 0033:0x7faa50ed831d


--==_Exmh_1528402643_2539P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWxmS040DS38y7CIcAQJ4QQf+KNa4d8PnSJOgSpBLgCLlDl7jX44LRa5G
Yg1vdlKzqvdMSEk+ug0Nj6VYz7TMEhDVcGZzCI7/mHhyDdysONJXSgQ07yyBdSKa
/a7MZKn4JV52zJOIQklnbIHyYfe0JiN3GS2s2TxQIEJrmEVOTnKEpSRajuJiPb8Q
H6e2jhM92tH/dzMmmaqLyzPn48wTOe0J2pKgX4fkXqU6dX5OhjxQeK0v0eMSCCgo
pauoj3EWDkxRIW6mCVI8zYfS2bVJZzgWGJGY+5H9oYVdWY3mUAdQa4CnpfJBNiHk
7Ql9vgcbEKTOLk64VEAHUKXPF+6VceCxz5Kfs/3GbL8qq1+ZYbngrA==
=g1qN
-----END PGP SIGNATURE-----

--==_Exmh_1528402643_2539P--
