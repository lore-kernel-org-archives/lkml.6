Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1AEAGct2G1vjeAAAmS7hNA
	; Sat, 09 Jun 2018 06:42:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CA921607E7; Sat,  9 Jun 2018 06:42:40 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dlc3Benq"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 324EB606FA;
	Sat,  9 Jun 2018 06:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 324EB606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753192AbeFIGmi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 02:42:38 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36089 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752272AbeFIGme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 02:42:34 -0400
Received: by mail-pl0-f67.google.com with SMTP id a7-v6so6971889plp.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 23:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=YxC5gqYRRKRy0rCF3xtl136wmSM93TK31fWoubsVfdA=;
        b=Dlc3BenqcjSBg27VU0juvodRr11dHPfhUjmCAj4myhoayYRj3XY/9Sy1kGWFqzmpaN
         d1aFkw6Bf+MeO5NoIjZz78aNjHwwf3v9mN4boSOmlU4lTFaMV06PZMQ6Wm3fhAjsNybK
         fytb5hNYJDeatZEunDj+8KgQ0u9+xvJ/kkfGPwkyhYNESkLZACiWu/xYw99A5iPIPBdJ
         +ZeJa5DTTdHRJM8SOjuVtUZdaTmLeEVuyj88ZUSdWJDg7WOEiquMbBAeu1MoL3BxVCbB
         pNkzOrGWV/yg2EDjtHz1AGPFESOCLnPtv/CPc0weTS5pF7K2L/kZxFJ/OrVn3d9ErNy/
         HuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=YxC5gqYRRKRy0rCF3xtl136wmSM93TK31fWoubsVfdA=;
        b=gJeByA0uT2XrnxER0mIaVy3hSVROqaqJfeiQ1OtDiTbC5mYi1lnW1KjGxOQ5lTM+P4
         Gl076DLOvduZEov0TSWmMOrnYAwHL2n0Wbsuq52uRf/Zw1n1zs42Em5PE8yT/Wrn+C33
         tvNzw88X/CqERI8ex0EvmKTRY+eJP7aVOVOALD275wuBbX4rWtsvECbdteLqm90PThac
         PrwyBTUJqNtCzyAU4Y7Y1k91LDEolopy5x98uQeXz6RWoLp7oYzHXlhagNdux9uSAiO1
         nt4kZsBnH6p6TvWOsWPh04tkahI1Aqf6UOKAh1qaqZovsttUeJH0bVj5r1WyXkbTw1Lz
         AqLg==
X-Gm-Message-State: APt69E3g+VPuE7lQ3iPlbmMyiV3ZXBRtHqx0sVLTOI5T73hhYcF64z1G
        GkQuB0ZkK1HR6uMnloLj+esvGg==
X-Google-Smtp-Source: ADUXVKL3KjfBCFmwLDG58/OXDlZYt/bYPZGRGKfjL2TH51sk91MqoPoe0zfBh+pf66MD1clMvycJSg==
X-Received: by 2002:a17:902:722:: with SMTP id 31-v6mr9901322pli.3.1528526554052;
        Fri, 08 Jun 2018 23:42:34 -0700 (PDT)
Received: from [192.168.1.101] (222-154-41-72-adsl.bb.spark.co.nz. [222.154.41.72])
        by smtp.gmail.com with ESMTPSA id c4-v6sm28027717pgv.86.2018.06.08.23.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 23:42:33 -0700 (PDT)
Subject: Re: [PATCH v2 08/12] macintosh/via-pmu68k: Don't load driver on
 unsupported hardware
To: Finn Thain <fthain@telegraphics.com.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <cover.1528423341.git.fthain@telegraphics.com.au>
 <d9d626ca4e7ac9c7e81b24a34f5fbcae9d1d5046.1528423341.git.fthain@telegraphics.com.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <9f015684-4d91-70e4-d2a4-89fe167ff8ab@gmail.com>
Date: Sat, 9 Jun 2018 18:42:25 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <d9d626ca4e7ac9c7e81b24a34f5fbcae9d1d5046.1528423341.git.fthain@telegraphics.com.au>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

Am 08.06.2018 um 14:24 schrieb Finn Thain:
> Don't load the via-pmu68k driver on early PowerBooks. The M50753 PMU
> device found in those models was never supported by this driver.
> Attempting to load the driver usually causes a boot hang.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
>  arch/m68k/mac/misc.c           | 6 ++----
>  drivers/macintosh/via-pmu68k.c | 4 ----
>  include/uapi/linux/pmu.h       | 1 -
>  3 files changed, 2 insertions(+), 9 deletions(-)
...
> diff --git a/include/uapi/linux/pmu.h b/include/uapi/linux/pmu.h
> index 89cb1acea93a..30f64d46f5db 100644
> --- a/include/uapi/linux/pmu.h
> +++ b/include/uapi/linux/pmu.h
> @@ -93,7 +93,6 @@ enum {
>  	PMU_HEATHROW_BASED,	/* PowerBook G3 series */
>  	PMU_PADDINGTON_BASED,	/* 1999 PowerBook G3 */
>  	PMU_KEYLARGO_BASED,	/* Core99 motherboard (PMU99) */
> -	PMU_68K_V1,		/* 68K PMU, version 1 */
>  	PMU_68K_V2, 		/* 68K PMU, version 2 */
>  };

Is this enum used by any user space code? If so, perhaps rather leave 
the PMU_68K_V1 in there to avoid upsetting that?

Otherwise,

Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>

Cheers,

	Michael
