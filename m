Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 8tAZEy+/HFtpagAAmS7hNA
	; Sun, 10 Jun 2018 06:55:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 71E6660850; Sun, 10 Jun 2018 06:55:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id ECE6C606DD;
	Sun, 10 Jun 2018 06:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ECE6C606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753765AbeFJGzj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 02:55:39 -0400
Received: from gate.crashing.org ([63.228.1.57]:32981 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753674AbeFJGzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 02:55:38 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5A6tEgZ008713;
        Sun, 10 Jun 2018 01:55:16 -0500
Message-ID: <3490f7d6f45ec2586858e4547e97474d93bd2d4d.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 08/12] macintosh/via-pmu68k: Don't load driver on
 unsupported hardware
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
        linuxppc-dev@lists.ozlabs.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 10 Jun 2018 16:55:14 +1000
In-Reply-To: <alpine.LNX.2.21.1806092140410.26@nippy.intranet>
References: <cover.1528423341.git.fthain@telegraphics.com.au>
         <d9d626ca4e7ac9c7e81b24a34f5fbcae9d1d5046.1528423341.git.fthain@telegraphics.com.au>
         <9f015684-4d91-70e4-d2a4-89fe167ff8ab@gmail.com>
         <m2h8mc4ejw.fsf@linux-m68k.org>
         <e1006b0a-a429-4744-7525-203cb91f1d5f@gmail.com>
         <alpine.LNX.2.21.1806092140410.26@nippy.intranet>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-06-09 at 22:21 +1000, Finn Thain wrote:
> In anycase, the "v1" and "v2" scheme is obviously inadequate when you 
> consider the range of m68k powerbook models. Also, consider the 
> out-of-tree adaptation of via-pmu by the Nubus-PMac project, which has 
> this ABI break:
> 
> diff --git a/include/linux/pmu.h b/include/linux/pmu.h
> index cafe98d9694..9882a185a52 100644
> --- a/include/linux/pmu.h
> +++ b/include/linux/pmu.h
> @@ -90,6 +90,7 @@ enum {
>          PMU_HEATHROW_BASED,     /* PowerBook G3 series */
>          PMU_PADDINGTON_BASED,   /* 1999 PowerBook G3 */
>          PMU_KEYLARGO_BASED,     /* Core99 motherboard (PMU99) */
> +        PMU_NUBUS_BASED,        /* 1400, 2300, 5300 */
>          PMU_68K_V1,             /* 68K PMU, version 1 */
>          PMU_68K_V2,             /* 68K PMU, version 2 */
>  };
> 
> (BTW, these powerbooks are not "nubus based", they are "pre-PCI", so I 
> wouldn't want this to go upstream in this form. It could be that 
> PMU_NUBUS_BASED should be PMU_UNKNOWN too.)

Pre-PCI is basically "NUBUS" based even in absence of an actual NuBus
slot :-) It has to do with the internal HW architecture. The only ones
that aren't are the even older designs (the 68000 based ones).

What's the situation with those NuBus things ? What do they use as a
bootloader ? The old Apple one or BootX ? We should merge that port of
it's maintained.

Cheers,
Ben.
 
