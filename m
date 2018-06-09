Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1kOpCGB+G1vQegAAmS7hNA
	; Sat, 09 Jun 2018 07:14:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 13201608B8; Sat,  9 Jun 2018 07:14:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 21C62606FA;
	Sat,  9 Jun 2018 07:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 21C62606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753209AbeFIHOg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 03:14:36 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:52364 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753094AbeFIHOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 03:14:34 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 412rBG6xz3z1qtXt;
        Sat,  9 Jun 2018 09:14:30 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 412rBG6DSPz1qsLM;
        Sat,  9 Jun 2018 09:14:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id sqtrsOnV8Lgs; Sat,  9 Jun 2018 09:14:30 +0200 (CEST)
X-Auth-Info: nmqTsSBidXdt5XXRhG1YURyZ1NC2bgIoP/kSwRavZOflz7p00pWuhNLheQdkZwel
Received: from linux.local (ppp-188-174-144-94.dynamic.mnet-online.de [188.174.144.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat,  9 Jun 2018 09:14:30 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
        id 41AD81E5885; Sat,  9 Jun 2018 09:14:27 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Finn Thain <fthain@telegraphics.com.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 08/12] macintosh/via-pmu68k: Don't load driver on unsupported hardware
References: <cover.1528423341.git.fthain@telegraphics.com.au>
        <d9d626ca4e7ac9c7e81b24a34f5fbcae9d1d5046.1528423341.git.fthain@telegraphics.com.au>
        <9f015684-4d91-70e4-d2a4-89fe167ff8ab@gmail.com>
X-Yow: Should I start with the time I SWITCHED personalities with a BEATNIK
 hair stylist or my failure to refer five TEENAGERS to a good OCULIST?
Date: Sat, 09 Jun 2018 09:14:27 +0200
In-Reply-To: <9f015684-4d91-70e4-d2a4-89fe167ff8ab@gmail.com> (Michael
        Schmitz's message of "Sat, 9 Jun 2018 18:42:25 +1200")
Message-ID: <m2h8mc4ejw.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 09 2018, Michael Schmitz <schmitzmic@gmail.com> wrote:

> Hi Finn,
>
> Am 08.06.2018 um 14:24 schrieb Finn Thain:
>> Don't load the via-pmu68k driver on early PowerBooks. The M50753 PMU
>> device found in those models was never supported by this driver.
>> Attempting to load the driver usually causes a boot hang.
>>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
>> ---
>>  arch/m68k/mac/misc.c           | 6 ++----
>>  drivers/macintosh/via-pmu68k.c | 4 ----
>>  include/uapi/linux/pmu.h       | 1 -
>>  3 files changed, 2 insertions(+), 9 deletions(-)
> ...
>> diff --git a/include/uapi/linux/pmu.h b/include/uapi/linux/pmu.h
>> index 89cb1acea93a..30f64d46f5db 100644
>> --- a/include/uapi/linux/pmu.h
>> +++ b/include/uapi/linux/pmu.h
>> @@ -93,7 +93,6 @@ enum {
>>  	PMU_HEATHROW_BASED,	/* PowerBook G3 series */
>>  	PMU_PADDINGTON_BASED,	/* 1999 PowerBook G3 */
>>  	PMU_KEYLARGO_BASED,	/* Core99 motherboard (PMU99) */
>> -	PMU_68K_V1,		/* 68K PMU, version 1 */
>>  	PMU_68K_V2, 		/* 68K PMU, version 2 */
>>  };
>
> Is this enum used by any user space code? If so, perhaps rather leave the
> PMU_68K_V1 in there to avoid upsetting that?

It also changes the value of PMU_68K_V2, which is an ABI break.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
