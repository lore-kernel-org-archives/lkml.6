Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id AE7tLwbVG1shGQAAmS7hNA
	; Sat, 09 Jun 2018 13:24:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AF790608B8; Sat,  9 Jun 2018 13:24:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 19DB8600D0;
	Sat,  9 Jun 2018 13:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19DB8600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753355AbeFINYU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 09:24:20 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:46842 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753216AbeFINYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 09:24:18 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4130Nv4dhDz1qtHZ;
        Sat,  9 Jun 2018 15:24:15 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4130Nv3zYCz1qsM0;
        Sat,  9 Jun 2018 15:24:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id KXl1NNzGQfTE; Sat,  9 Jun 2018 15:24:14 +0200 (CEST)
X-Auth-Info: 42KY0/EE2aPl6b9VVfluJkOWDGpRLkeBSM3hHqh0c0PE7oRBJvS8oUamly40OzSu
Received: from igel.home (ppp-188-174-144-94.dynamic.mnet-online.de [188.174.144.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat,  9 Jun 2018 15:24:14 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 218602C4D47; Sat,  9 Jun 2018 15:24:14 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Michael Schmitz <schmitzmic@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 08/12] macintosh/via-pmu68k: Don't load driver on unsupported hardware
References: <cover.1528423341.git.fthain@telegraphics.com.au>
        <d9d626ca4e7ac9c7e81b24a34f5fbcae9d1d5046.1528423341.git.fthain@telegraphics.com.au>
        <9f015684-4d91-70e4-d2a4-89fe167ff8ab@gmail.com>
        <m2h8mc4ejw.fsf@linux-m68k.org>
        <e1006b0a-a429-4744-7525-203cb91f1d5f@gmail.com>
        <alpine.LNX.2.21.1806092140410.26@nippy.intranet>
X-Yow: The FALAFEL SANDWICH lands on my HEAD and I become a VEGETARIAN...
Date: Sat, 09 Jun 2018 15:24:14 +0200
In-Reply-To: <alpine.LNX.2.21.1806092140410.26@nippy.intranet> (Finn Thain's
        message of "Sat, 9 Jun 2018 22:21:06 +1000 (AEST)")
Message-ID: <87a7s4854x.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 09 2018, Finn Thain <fthain@telegraphics.com.au> wrote:

> There is no ABI issue AFAIK. The value of pmu_kind is visible to userland 
> only on powerpc. /dev/pmu and /proc/pmu/* do not exist on m68k.

Then why are PMU_68K_V1 and PMU_68K_V2 defined in the first place?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
