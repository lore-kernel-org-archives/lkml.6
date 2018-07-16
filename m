Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163BCECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C175420844
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVBBv3XU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C175420844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbeGPMLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:11:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39541 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbeGPMLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:11:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id h10-v6so31569915wre.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 04:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=62tyb+Krn+f8PapbIztRn4JseUByTdzdw3GPF9Lvhmc=;
        b=aVBBv3XUNeiDQdisp8SgcKI+6KN6P9Q81wDc5rWLFyR7PJ+5tAew1PgALxDaJWwJ5o
         sXy9mOkoGtvk2GzrI/5FTlu0h1Dcev/i4xMA/b7Ujj+Sq7lhALG0Z5+SdmLSD1PKdSJw
         /STnfYUUOPbtDUAFZia9apBQh3LAAWcLd2W0rqkpxfhgbhkI+7RCiJqI29H92LXyUZ+E
         KMISTyjYyduolHOjUetMk9snznZK24C6i3d4asFxkjdhTmfqMaXlvPsHiXQGqiI6NVdS
         xJHHgClaoJ6+kDsQTNlkZJqI/TIj2bXhu3mV5IDyI1I2+8EkIcUwh5ij/8a14zp2KTcu
         fJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=62tyb+Krn+f8PapbIztRn4JseUByTdzdw3GPF9Lvhmc=;
        b=KGGs4GT7wk+WGoSh83tSCgO1JI/G9tGefNUuM0+T3QBYOhXFp+7w3JstWCCv8pfLt6
         GmIFYIHmBT9/ncTzq4cziny3zII18sgSv80BMPzq8JGSyyPHp3oOmXWRrWm1RL6rApKp
         EXQidjiTN0tJ5xOVfWGXak+RP87uxjrUmgeF+vYDzP4mE9R3luwPQa6gsVZPWx0J7hu8
         hYByNNOTLKlIEqQjKpEswDRLKt+su8wHKoViexQWpU0pmsGYK6lm1LHX1ZVEF/BEj0Tf
         9fnKKXBEmEGPOuP8Q8M4JHTYOI1OuLL7g6qKym7xt08u4zwZbosvR6iuvn9QWye2L+4R
         TwTg==
X-Gm-Message-State: AOUpUlE+Le3riaDpcKw7PjkJ1ctJP5xm/UQ+KEmuAxcYSOFrw8KxANiy
        cr2Yo6c77cbHnlsnqvU/Wkk=
X-Google-Smtp-Source: AAOMgpe16PyaH6gKnVT4P52LT7wcdHOxFeAxh+kk6HTuGIP0/JXBzWhKD/NITSYiCgbq6pNUSRu9Gw==
X-Received: by 2002:a5d:574d:: with SMTP id q13-v6mr11445147wrw.24.1531741490183;
        Mon, 16 Jul 2018 04:44:50 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u185-v6sm7065153wmg.25.2018.07.16.04.44.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 04:44:49 -0700 (PDT)
Date:   Mon, 16 Jul 2018 13:44:47 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com, bhe@redhat.com,
        keescook@chromium.org, yasu.isimatu@gmail.com,
        indou.takao@jp.fujitsu.com, lcapitulino@redhat.com,
        caoj.fnst@cn.fujitsu.com, douly.fnst@cn.fujitsu.com
Subject: Re: [RFC PATCH v2 3/4] x86/boot/KASLR: Walk srat tables to filter
 immovable memory
Message-ID: <20180716114447.GA7650@gmail.com>
References: <20180716085538.31939-1-fanc.fnst@cn.fujitsu.com>
 <20180716085538.31939-4-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716085538.31939-4-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:

> If 'CONFIG_MEMORY_HOTREMOVE' specified, walk the acpi srat memory
> tables, store the immovable memory regions, so that kaslr can get
> the information abouth where can be selected or not.
> If 'CONFIG_MEMORY_HOTREMOVE' not specified, go on the old code.
> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/compressed/kaslr.c | 55 ++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 531c9876f573..0ec5aab915db 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -31,6 +31,7 @@
>  
>  #include "misc.h"
>  #include "error.h"
> +#include "acpitb.h"
>  #include "../string.h"
>  
>  #include <generated/compile.h>
> @@ -104,6 +105,14 @@ static bool memmap_too_large;
>  /* Store memory limit specified by "mem=nn[KMG]" or "memmap=nn[KMG]" */
>  unsigned long long mem_limit = ULLONG_MAX;
>  
> +#ifdef CONFIG_MEMORY_HOTREMOVE
> +/* Store the movable memory */
> +struct mem_vector immovable_mem[MAX_NUMNODES*2];
> +
> +/* Store the num of movable mem regions */
> +static int num_immovable_mem;
> +#endif

So comment says 'movable', but variables are named 'immovable'??

Thanks,

	Ingo
