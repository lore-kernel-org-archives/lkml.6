Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78746C07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDD52241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BDD52241E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbeKMCkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:40:37 -0500
Received: from mout.gmx.net ([212.227.15.19]:50205 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbeKMCkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:40:37 -0500
Received: from ls3530.dellerweb.de ([92.116.170.42]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MZCQ8-1g3bTc0P7s-00Kuhm; Mon, 12
 Nov 2018 17:46:28 +0100
Date:   Mon, 12 Nov 2018 17:46:24 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fix for kernel v4.20
Message-ID: <20181112164624.GA29362@ls3530.dellerweb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Provags-ID: V03:K1:AqN0CnHMBEX4m3LTiES05w3TDS6aST6PmV4mq3uDUVuYiOhAcYx
 yYTMYAs8IJXvemya/QLRTs41/HUDYdfPdlwxQE+ettt9U1EqzG6Vhrxwlx2CQ+ygTx7qrBP
 NvZ+cCbUZdnDf3fxFtUZKobBN2NCqJjgGelCdSzHQ3xOMFU+Bxx58K+y6DEgXwvud88Uf2r
 6WjfIBfN6YcXCV4LjsLLQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Qt2JqkWZQ+Y=:z80uVIm+rVHOY0+4N879jK
 BQwQMJLjbjn7TrLvBKI91Y4UNupivyibEDDYSHnSFl58p/DFVKPOXW+M6BAAuBI3iwuZIhvvH
 gwetdiP+CRI0o8KBHL3KfEFdyCdXI02SloNe9cS7TCoxoaBJgP3vrq4sojKdc97+PIDQq5yil
 mGUKM0NQsmFf1Hr31jS29fW0gR4hB2OmnoUe16Kdg6jaIp46hEDvVtnWP6Hdlz6myP8qt21bF
 xWOstiqP8RHIlVff5DEnxi+SIsmCUJdhWdPEsgnRmHVy9JNh+oT7ofTAjApptdGCmpI3fYm+N
 6Mi7+Bofqc7enJqSJylWbKYBbUfRDTtMxt5MOPwWegg2ME6jCSn+ksOpOxyiB1h778rjDv5fU
 3wU0oesog4bRZKA44vzVbIUaOzklGFA+GgFclWlMg3x1V9Ww2DfUrdgm1N8o6PTVn/aRq4SLa
 q1kQAGzC8OjfCSM2lLJ904I/CWemAkDJmyiZd/IqADi07J30glasexLiMBDGib6cECq7nrG7w
 Vi0qoYFEdZcoO11v3HitPyYhnbpUaS/6Iqt73+dDR4aHJyzMjpZubspsazc2nM0vDDvVy6M7S
 AlX9OOPgpwPBvSobGULpUfMUov9gJNaoV/KVL4AksqHzfaUoe/zT53asnZu0zdGvRw8clu7H8
 XSGu5GKtsP//gdBHxczecAfgfR7er/7QvaKVF0Ik4FOBWW+N5fg+2M57xxcMi/36v+UsF5fxu
 Z+wgnipMhqq8/QlBI/FLxqVlYfqwOjqYKzMJ2sVOv4kmY+2d0nJ6e7r8HT86IUBOMLrx0RSSP
 48XfyM1gAHrQc+6LSIWJEvlfTo+Pg49ffuGFymae/drdoGEWGQ6FDF0cprNGoLxLhyXoZNjv+
 BjGRANa+LEi1j6T57U1wFCEgmtgJQLYB1ZApVVQbQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull one patch for the parisc architecture for 4.20-rc3 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-4.20-3

Revert one patch which changed how spinlocks get released. It breaks the
rwlock implementation in glibc.

Thanks,
Helge

----------------------------------------------------------------
John David Anglin (1):
      parisc: Revert "Release spinlocks using ordered store"

 arch/parisc/include/asm/spinlock.h |  4 ++--
 arch/parisc/kernel/syscall.S       | 12 ++++++++----
 2 files changed, 10 insertions(+), 6 deletions(-)
