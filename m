Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F96EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8517213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5zdiDki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8517213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbeJBGbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 02:31:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36827 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJBGbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 02:31:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id b7-v6so114821pfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 16:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gplaKC6UEz0A+Uvp0v0Qlnbl2RdlNAz4fdwm9o7AFfc=;
        b=c5zdiDkimz9IRvquk4YGddgRM0jjskHkNMk4Z+mkFxCwErP73SjSvxEU8l5qKcfA1W
         30bfSIoz4Rs14hJJ/M2SAodvL/60T5DLKyNqvPtAz6BKn5x9yhH/Q39ctIgcjA/ZaKFt
         2qQ/c5PS2ClshOQwnIujgXbRjdTICclPdyjEqQ5Vfwm2KQ3gm+Hpf7CDtmMIvKbPdKbM
         pP4zRWvvn+YPu9EL9m0qpLMN1yivR110z3RaZS+6q9GQuxdZF9otP+SPLS29ZHEglN3O
         0wKl5pepvcVxid01rPGYGDHH7WfcM1J/gggkFjfSqEeZTMo/sggxVNJyDxV4LDwc94Jx
         FmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gplaKC6UEz0A+Uvp0v0Qlnbl2RdlNAz4fdwm9o7AFfc=;
        b=ExDqscxSuksa3Dkjwre7J04uYGdrT1AtvI8i7ainP0ynDdvi/OEZV/QxQ//vgbJuWZ
         UcfQkGZ30LUhCn9BhQVuGqTPSHmBTqJGKTlQRWhaZreEBopC3vFOq2CiHg1WpFUNsz4J
         K7cZPlxE1FY4KT4+oIA+nP4lmAMW8mCnPhouFhAlBHJkL0pnL1EWlWPrI60YcT1xtU9Y
         JHk8y8nNPhoc+bc68DbHb8mwfpul0ucUiEUqYv6aUyHxdOpbP768IvaEGNqq2hzd4HOT
         Q45WDsqa6bV2redGTZp9GMgfKWQ7aPvb1rypeX4Z8EFIXzvU6SVxAyBU9CYq7pkrmCLX
         DUrw==
X-Gm-Message-State: ABuFfohPOv70RhSTF5VLzUQMJnYVLNZxcKm8Mhvzk5hEoZcDC7YtUFBa
        iEP1UBfE6c/LXL040ZAesPw=
X-Google-Smtp-Source: ACcGV60RY0EEwZ8PnLMWS7bZ6KBLp9mbnKRO8v1ARfAyC3+Q3G55MVZhvQuVn9gDXL2N5UvpEQi4pA==
X-Received: by 2002:a62:c08b:: with SMTP id g11-v6mr13722746pfk.72.1538437891115;
        Mon, 01 Oct 2018 16:51:31 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-83-213.tpgi.com.au. [59.102.83.213])
        by smtp.gmail.com with ESMTPSA id b81-v6sm34559027pfm.96.2018.10.01.16.51.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 16:51:30 -0700 (PDT)
Date:   Tue, 2 Oct 2018 09:51:21 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: remove leftover code of old GCC version checks
Message-ID: <20181002095121.3f0326f7@roar.ozlabs.ibm.com>
In-Reply-To: <1538374224-3742-1-git-send-email-yamada.masahiro@socionext.com>
References: <1538374224-3742-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Oct 2018 15:10:24 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Clean up the leftover of commit f2910f0e6835 ("powerpc: remove old
> GCC version checks").
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> My patch had been sent earlier, with more clean-ups:
> https://lore.kernel.org/patchwork/patch/977805/

Sorry, I missed or forgot about your patch :(

Thanks for tidying up my mess!

Acked-by: Nicholas Piggin <npiggin@gmail.com>

> 
> Anyway, this cleans up the left-over of the Nicholas' one.
> 
> 
>  arch/powerpc/Makefile | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 2ecd0976..b094375 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -400,10 +400,6 @@ archclean:
>  
>  archprepare: checkbin
>  
> -# Use the file '.tmp_gas_check' for binutils tests, as gas won't output
> -# to stdout and these checks are run even on install targets.
> -TOUT	:= .tmp_gas_check
> -
>  # Check toolchain versions:
>  # - gcc-4.6 is the minimum kernel-wide version so nothing required.
>  checkbin:
> @@ -414,7 +410,3 @@ checkbin:
>  		echo -n '*** Please use a different binutils version.' ; \
>  		false ; \
>  	fi
> -
> -
> -CLEAN_FILES += $(TOUT)
> -
> -- 
> 2.7.4
> 

