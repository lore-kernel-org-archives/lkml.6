Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2EDC10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D51C20823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfBVIRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:17:38 -0500
Received: from mout.gmx.net ([212.227.17.21]:44359 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfBVIRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:17:38 -0500
Received: from ls3530.dellerweb.de ([92.116.178.166]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LbyUS-1hMEAu1qvE-00jFqG; Fri, 22 Feb 2019 09:17:28 +0100
Date:   Fri, 22 Feb 2019 09:17:25 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [GIT PULL] parisc architecture fixes for kernel v5.0
Message-ID: <20190222081725.GA10558@ls3530.dellerweb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:4YK1OEAXa1vD4ONhsIzhhyICdfEk+V+M4VTFj5QzAuDO+OcO+9d
 hEAmwuLg0f8eaIEjxYfyvUGWN0UlLZ9Cikbaj7CLplCCZHh5mOyi8pstqpE+gl6Ra5k6PlT
 zgQg2sh/4lueui8lf1AMvZR7yjxugmhfKS8B6bey1TfTBSZM8w6Loitcb+C8GsfWl/OgkvN
 KK7ppe8dEAVOL+Bxn61bw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CUEVvBBlDHE=:tDAsDkA6ibOZEDDBLnamBF
 nlDMkBVrJh2xx1frMwz6dLjo4qNLsGxb//kAQ2j9YYJQNwj1+R5KJuCqcTPX4jKvr0ciMixD3
 /WhTMKRDVlTzI0N3b4Y/YbnzD//rBKHHe2+Ngg6nH7H6IMCCAmk+0nZ0BEpa1xThJmp/+lmqN
 TiScr5LCVVn8dhcUS8rrKnPe10ID6QGKgOjg6TB1NajECe96zvqbrpau6IbJ3yhO6h5VT7Nfn
 lOr9p3pmxqBqM//NcS05SR8GHQSI24l0dDZ0YKLY8wP2ljwwDrx3QcWamrxJo2jiRw3xrsaVg
 gzNMNb3xFJoUKtRrCgkNY0lFwGoXErgTGCt4F8AyQaWwWQF7rZqDjzMXkTZdpwNsTCVha2EbN
 Kp6fEi4u2PYliPUqyciYtHXx2QARGcvgNyt1aJkRimq0XGJmsi3RJAXgZaA/Yd+meB0q4EwDK
 ei4a6C2I2Man+euHttQSelkVvNtIrRaAf4njAFCxFWHyWm4753dMEOL7yB2K1Bcj6SGo3lv9C
 01/H44xlXB8IIPG27It3QOu1t8xTZvee3gg93AV9N/UYXeuXY87N7BCToumbfE6DImFRKTq8Q
 wZ9H7vkaV2PzD5IDkyiflTNj6dnEJOWmrK8v5TjcIs31pqloIsL7W+w3Qwb4hrU19IpKlnqqS
 OLk685Vo2CzDhUwzjS3YPuCi1ToVvaJIIiL4OYMRRus6KmqCIAgokbCFy+ytAKn2gQB4vIbBm
 a7lq3KgTtBxSHgC7GuvxFE2Ug1TXZqJ986uC4UrUx7Q26oPSnL5A61mxCkbMLfc+uFE2jB8BU
 XS8gzy/HofQCgD+jYeHRKB5tMaz4HfScVxv7+kUVOtgUkxtUQA78pCgDrQu2IemH3odCtdHmP
 H4aX8VyqFf6WDlZak6I7EA7hQUiVmCqLeT6k41rb7RV51k+FYheUBvm+d58QI9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

can you please pull one fix and one documentation update for parisc for kernel 5.0:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.0-1

Fix ptrace syscall number modification which has been broken since kernel v4.5
and provide alternative email addresses for the remaining users of the retired
parisc-linux.org email domain.

Thanks,
Helge

----------------------------------------------------------------
Dmitry V. Levin (1):
      parisc: Fix ptrace syscall number modification

Helge Deller (1):
      CREDITS/MAINTAINERS: Retire parisc-linux.org email domain

 CREDITS                     | 20 +++++++++-----------
 MAINTAINERS                 |  5 ++---
 arch/parisc/kernel/ptrace.c | 29 +++++++++++++++++++++--------
 3 files changed, 32 insertions(+), 22 deletions(-)
