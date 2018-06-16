Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30798C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 20:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69AF20891
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 20:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="uUdtV7s/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69AF20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933099AbeFPUYb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 16:24:31 -0400
Received: from mail.efficios.com ([167.114.142.138]:54102 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932554AbeFPUYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 16:24:30 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id DBBF11AD7B6;
        Sat, 16 Jun 2018 16:24:29 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id RKKPk7KMCkag; Sat, 16 Jun 2018 16:24:29 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 5EB461AD7B2;
        Sat, 16 Jun 2018 16:24:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5EB461AD7B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1529180669;
        bh=tdgF/YaKfS0JtvfhhrbUFXww8Bs4JsXperugGlH2zP8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=uUdtV7s/SoHAhLbP1jKrtVr3HiZAqQ7QM00rtPl5SqhH9CIIVmmATi4Y3y+pgX11X
         INIfjfQVqVVLGRtq/2g+xK2Mux6X/G+ZODEd/p8b3E1+orXfmEcSHRIMvk89feYnLe
         dxeFC1NNoLG2sKN3r5iRXuXB24t2B/DTGxUYQmaptukYAAWTZmfTGY/0DtC2w3Eaeg
         MPPBoUsUnE7aGChJXmmtQ5aVR6sH63a7TXB3smLgoUKC5rlE+7gdIkW18m+NOJELgV
         1uZVhaJATwm99h2kHrM7DMk+ozYx9/qGX94LwOuVJbWoPeLPIYSkgvnBn8YdHjYqIH
         eSxNPb/WwS72g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id JxS1runpx-Zo; Sat, 16 Jun 2018 16:24:29 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 4A5641AD79D;
        Sat, 16 Jun 2018 16:24:29 -0400 (EDT)
Date:   Sat, 16 Jun 2018 16:24:29 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Peter Zijlstra <peterz@infradead.org>,
        James Hogan <jhogan@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Message-ID: <1265723673.16061.1529180669270.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180614235211.31357-1-paul.burton@mips.com>
References: <20180614235211.31357-1-paul.burton@mips.com>
Subject: Re: [PATCH 0/4] MIPS: Restartable sequences (rseq) support
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: MIPS: Restartable sequences (rseq) support
Thread-Index: SIq+dComtRU3KK3IHH2fHjNEax3cmA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 14, 2018, at 7:52 PM, Paul Burton paul.burton@mips.com wrote:

> This series implements MIPS support for restartable sequences, hooks up
> the rseq syscall & implements MIPS support in the rseq selftests.
> 
> Applies atop Linus' master as of 2837461dbe6f ("Merge tag 'scsi-fixes'
> of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi").
> 

For the entire series:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Unless you ask otherwise, I will expect this patchset to be picked
up through the MIPS maintainer tree.

Thanks!

Mathieu

> Thanks,
>    Paul
> 
> Paul Burton (4):
>  MIPS: Add support for restartable sequences
>  MIPS: Add syscall detection for restartable sequences
>  MIPS: Wire up the restartable sequences (rseq) syscall
>  rseq/selftests: Implement MIPS support
> 
> arch/mips/Kconfig                         |   1 +
> arch/mips/include/uapi/asm/unistd.h       |  15 +-
> arch/mips/kernel/entry.S                  |   8 +
> arch/mips/kernel/scall32-o32.S            |   1 +
> arch/mips/kernel/scall64-64.S             |   1 +
> arch/mips/kernel/scall64-n32.S            |   1 +
> arch/mips/kernel/scall64-o32.S            |   1 +
> arch/mips/kernel/signal.c                 |   3 +
> tools/testing/selftests/rseq/param_test.c |  24 +
> tools/testing/selftests/rseq/rseq-mips.h  | 725 ++++++++++++++++++++++
> tools/testing/selftests/rseq/rseq.h       |   2 +
> 11 files changed, 776 insertions(+), 6 deletions(-)
> create mode 100644 tools/testing/selftests/rseq/rseq-mips.h
> 
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
