Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C864C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 03:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4671322412
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 03:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t0cTeS5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4671322412
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932775AbeGCDay (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 23:30:54 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41431 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932198AbeGCDaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 23:30:52 -0400
Received: by mail-pg0-f65.google.com with SMTP id l65-v6so281824pgl.8;
        Mon, 02 Jul 2018 20:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7/2CQEpXdYXzWD3rY3Dn6+9tXbxWxFQCo6LttwkWi7M=;
        b=t0cTeS5HfSYU8YdMirndOS3w7WxVtqi+93IEfNLl6q1Lt9GG6EbmGRbiPLUJXmQ6xb
         a30qqUeRhVB/96zPwzRnN6uZpKjE6AQYna7gcSyDW6QkMUPKWYa750Xh73FEeUbPXQDf
         5IiAWWMPs5LpSGulzwCpLYY4diEzeS3QnumeoClt10mftwepMZQk/Gfm8ycOGCcHhvKt
         uXrUixhMuOQRwcD9Tg4CHcOzzqa9PlYYcfIQnZOtFsMao+tTIf02i8PjeLeUhgTKfVo3
         e9yzDm0rFEOYvqLcT0RiipBrhFBoXDKHpm6BlAEM4yYaRveYPe/xVNuTC8nnZ6yj7Jl3
         /6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7/2CQEpXdYXzWD3rY3Dn6+9tXbxWxFQCo6LttwkWi7M=;
        b=fYdidJA34i+MXlheY8Tw9n3smOACuurXMpzvTfUxs0Ee7YsGeeJJS+YfLVJ0gPQ/V4
         l1xv2Tbccn3sg8Tn6A6g7mCjuEtCN8VYoDQmxOWCT++UK5jZS8sYI0uJuZlQAANfasWy
         VuTd7sRN+7iwknHMQafSz4hpNNiB/h1xqpw3xW5XZ9/eo4gEsHN0HgA4HUc66xivJH4+
         Gb2/IVHcXA3YcUAv/BBdouaXVEv34gCqtjuE7+86W18pUdl5YdzpNxGUn4RxPK7T2kXs
         43OkcQ6LW1SN3q2KNo/p3KT/LoBtjOo1ttCSn8AwvKWv3RpseQHbBnpli94cUokRZhtt
         IKuQ==
X-Gm-Message-State: APt69E3KdS9GhLbTl25dgRSk9LfirEclB8QiOmvX1BzY/nCaPpsie6nK
        YGlU0nPPR39XGCPDHqXbaJb2sg==
X-Google-Smtp-Source: ADUXVKJi9/zrLdr6R0t/2GC62Oqi7/m1BxtbR4+id9S9lMStvzf2vCEmlx6CYoq1TVHq2DIv8jKFvA==
X-Received: by 2002:a65:5ac9:: with SMTP id d9-v6mr23932131pgt.238.1530588651925;
        Mon, 02 Jul 2018 20:30:51 -0700 (PDT)
Received: from roar.ozlabs.ibm.com ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id 63-v6sm213065pfo.1.2018.07.02.20.30.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 20:30:51 -0700 (PDT)
Date:   Tue, 3 Jul 2018 13:30:45 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        stewart@linux.vnet.ibm.com, benh@kernel.crashing.org,
        svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com,
        mpe@ellerman.id.au
Subject: Re: [PATCH v2 1/2] powernv/cpuidle: Parse dt idle properties into
 global structure
Message-ID: <20180703133045.3ec45faf@roar.ozlabs.ibm.com>
In-Reply-To: <1530541401-19726-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1530541401-19726-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
        <1530541401-19726-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Jul 2018 19:53:20 +0530
Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> wrote:

> Device-tree parsing happens twice, once while deciding idle state to be
> used for hotplug and once during cpuidle init. Hence, parsing the device
> tree and caching it will reduce code duplication. Parsing code has been
> moved to pnv_parse_cpuidle_dt() from pnv_probe_idle_states(). In addition
> to the properties in the device tree the number of available states is
> also required.
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/cpuidle.h    |  11 ++
>  arch/powerpc/platforms/powernv/idle.c | 216 ++++++++++++++++----------
>  drivers/cpuidle/cpuidle-powernv.c     |  11 +-
>  3 files changed, 151 insertions(+), 87 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
> index e210a83eb196..574b0ce1d671 100644
> --- a/arch/powerpc/include/asm/cpuidle.h
> +++ b/arch/powerpc/include/asm/cpuidle.h
> @@ -79,6 +79,17 @@ struct stop_sprs {
>  	u64 mmcra;
>  };
>  
> +#define PNV_IDLE_NAME_LEN    16
> +struct pnv_idle_states_t {
> +	char name[PNV_IDLE_NAME_LEN];
> +	u32 latency_ns;
> +	u32 residency_ns;
> +	u64 psscr_val;
> +	u64 psscr_mask;
> +	u32 flags;
> +	bool valid;
> +};


This is a nice looking cleanup.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
