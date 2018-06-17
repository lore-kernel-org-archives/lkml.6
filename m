Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C03C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 10:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AF820896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 10:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09AF820896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933644AbeFQKJO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 06:09:14 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:41922 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933278AbeFQKJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 06:09:12 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 417qh50h72z1qv3Z;
        Sun, 17 Jun 2018 12:09:08 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 417qh45dtBz1qqkB;
        Sun, 17 Jun 2018 12:09:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id f8xHu_njIAEr; Sun, 17 Jun 2018 12:09:07 +0200 (CEST)
X-Auth-Info: 1z3TkJapRfIQBsdcmFSKDBX4kveEB7wRhPtbl1H/J9ZZu/MDhGbaDN+wHhv41Va7
Received: from linux.local (ppp-188-174-159-255.dynamic.mnet-online.de [188.174.159.255])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 17 Jun 2018 12:09:07 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
        id 2F5B91E5885; Sun, 17 Jun 2018 12:09:03 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     eric.dumazet@gmail.com, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Christophe LEROY <christophe.leroy@c-s.fr>,
        Meelis Roos <mroos@linux.ee>, netdev@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] Revert "net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are friends"
References: <20180615185645.8921-1-malat@debian.org>
        <fbb95c11-240c-1a11-0a62-0483908c577e@gmail.com>
        <CA+7wUsysaip70ARGQ7Byg1Zktfg0Y1esjEc9HxBGU4sKL8crhg@mail.gmail.com>
X-Yow:  ONE:  I will donate my entire ``BABY HUEY'' comic book collection
 to the downtown PLASMA CENTER..
 TWO:  I won't START a BAND called ``KHADAFY & THE HIT SQUAD''..
 THREE:  I won't ever TUMBLE DRY my FOX TERRIER again!!
Date:   Sun, 17 Jun 2018 12:09:03 +0200
In-Reply-To: <CA+7wUsysaip70ARGQ7Byg1Zktfg0Y1esjEc9HxBGU4sKL8crhg@mail.gmail.com>
        (Mathieu Malaterre's message of "Sat, 16 Jun 2018 09:14:42 +0200")
Message-ID: <m2y3fd67y8.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 16 2018, Mathieu Malaterre <malat@debian.org> wrote:

> That's odd since it seems to only affect g4+sungem user. None of the
> ppc64 seems to be having it.

I'm also seeing it on a PowerMac G5.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
