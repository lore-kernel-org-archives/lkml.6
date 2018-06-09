Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UdRPOnaHG1tgXAAAmS7hNA
	; Sat, 09 Jun 2018 07:55:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B3279607E7; Sat,  9 Jun 2018 07:55:18 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRQSGEAt"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 172A2601D3;
	Sat,  9 Jun 2018 07:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 172A2601D3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753224AbeFIHzP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 03:55:15 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41814 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753139AbeFIHzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 03:55:13 -0400
Received: by mail-pl0-f68.google.com with SMTP id az12-v6so9518806plb.8
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 00:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=isc/BmYFKF2RSAtcHIu03IWIJ7uT3/QQalrio6EOy5s=;
        b=ZRQSGEAtVEh5zgZ9ZPgLlP3jUQZbcjBLcUcNlb1fEbihECKCFiKCxBLgIIM3i2rHh9
         11GEyFAKtaHeTLqN5VWhxvSMc43L+m56IBhZvaW6QM4fE0aQVdX2q60WkV60IP6ivNGg
         v3RJxpZPqRc3gyTbB3FhuqxYb/eB4C7R6CRBLVWKIdDQzdttcM4mH/1qgwyazCflOQfB
         vBJkRzPRUT8bVAqHbEH5mQP3sIbi+CIDry5XnXfX2vi1WmRpASs+JXYoyWPN/sF2o2Xb
         dkd0AEKYlaPDrdVB/mSCUkY1QqBH21bg4xYsSEluxjE0ry8J/aw97AHuFZyjtIe4trpP
         WWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=isc/BmYFKF2RSAtcHIu03IWIJ7uT3/QQalrio6EOy5s=;
        b=XZEf7XwJQ8/jbx6ajSPoMhTkk6o7xm34Ai9jiB5SPYQy9B+ShZSwl9QjEDUspKQRK2
         9GJKEPjQ+EpGNN6A1fQRxnskIWbbvioNiMAcqu/gOBvFEb2wNkEgWV3xfbKfCdyqb5f5
         9qWQKZxb8JdzdkCWvWBHEBeSEVH623myDLS1JHKBMS7AZvxHe7d9W7SKAZ8cvMgEaLyL
         RDiC6fJI25Q2+jdS8Vrw/s1TZn6Fxb3azK2YzQWUid+CJY5YF2k9j+wpa9iW7e96TkC5
         du4Q17VJ5w2/LoqpsVkb6pYZ6twkr1/3cqATujcEr7u0F9q+d1na9TMh73P1tNSGKw5i
         U3Jg==
X-Gm-Message-State: APt69E2SSBsUDIMmIZ/AxgnjkJaJQfXvDnV1Uv2OjoS0HlIglTEtQWYi
        EWP/fH7LFDM3coxkNmmTIOeLqG1D
X-Google-Smtp-Source: ADUXVKJS19IPhS/sFX7OaGLEQwhgih7qx9yqR2I3+oCnciLiNSpYd+c6UFT853ZAmJZtD2LULKEdkg==
X-Received: by 2002:a17:902:5488:: with SMTP id e8-v6mr4822104pli.137.1528530913354;
        Sat, 09 Jun 2018 00:55:13 -0700 (PDT)
Received: from [192.168.1.101] (222-154-41-72-adsl.bb.spark.co.nz. [222.154.41.72])
        by smtp.gmail.com with ESMTPSA id b4-v6sm2140756pgq.51.2018.06.09.00.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jun 2018 00:55:12 -0700 (PDT)
Subject: Re: [PATCH v2 08/12] macintosh/via-pmu68k: Don't load driver on
 unsupported hardware
To: Andreas Schwab <schwab@linux-m68k.org>
References: <cover.1528423341.git.fthain@telegraphics.com.au>
 <d9d626ca4e7ac9c7e81b24a34f5fbcae9d1d5046.1528423341.git.fthain@telegraphics.com.au>
 <9f015684-4d91-70e4-d2a4-89fe167ff8ab@gmail.com>
 <m2h8mc4ejw.fsf@linux-m68k.org>
Cc: Finn Thain <fthain@telegraphics.com.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <e1006b0a-a429-4744-7525-203cb91f1d5f@gmail.com>
Date: Sat, 9 Jun 2018 19:55:05 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <m2h8mc4ejw.fsf@linux-m68k.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

Am 09.06.2018 um 19:14 schrieb Andreas Schwab:
> On Jun 09 2018, Michael Schmitz <schmitzmic@gmail.com> wrote:
>
>> Hi Finn,
>>
>> Am 08.06.2018 um 14:24 schrieb Finn Thain:
>>> Don't load the via-pmu68k driver on early PowerBooks. The M50753 PMU
>>> device found in those models was never supported by this driver.
>>> Attempting to load the driver usually causes a boot hang.
>>>
>>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>>> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
>>> ---
>>>  arch/m68k/mac/misc.c           | 6 ++----
>>>  drivers/macintosh/via-pmu68k.c | 4 ----
>>>  include/uapi/linux/pmu.h       | 1 -
>>>  3 files changed, 2 insertions(+), 9 deletions(-)
>> ...
>>> diff --git a/include/uapi/linux/pmu.h b/include/uapi/linux/pmu.h
>>> index 89cb1acea93a..30f64d46f5db 100644
>>> --- a/include/uapi/linux/pmu.h
>>> +++ b/include/uapi/linux/pmu.h
>>> @@ -93,7 +93,6 @@ enum {
>>>  	PMU_HEATHROW_BASED,	/* PowerBook G3 series */
>>>  	PMU_PADDINGTON_BASED,	/* 1999 PowerBook G3 */
>>>  	PMU_KEYLARGO_BASED,	/* Core99 motherboard (PMU99) */
>>> -	PMU_68K_V1,		/* 68K PMU, version 1 */
>>>  	PMU_68K_V2, 		/* 68K PMU, version 2 */
>>>  };
>>
>> Is this enum used by any user space code? If so, perhaps rather leave the
>> PMU_68K_V1 in there to avoid upsetting that?
>
> It also changes the value of PMU_68K_V2, which is an ABI break.

Yes, that's what I worry about - but do we know of any users of that 
particular interface?

Cheers,

	Michael

>
> Andreas.
>
