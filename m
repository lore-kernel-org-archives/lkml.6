Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C8BC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB0C24599
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="McKbbDT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB0C24599
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934120AbeFVQKr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:10:47 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41199 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751385AbeFVQKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:10:45 -0400
Received: by mail-wr0-f196.google.com with SMTP id h10-v6so7213657wrq.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 09:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ii5G3KnlucUIn9UlNNE+YCO4B8eaXoF8PxtqvdwuOZc=;
        b=McKbbDT1wT4NPdk+8x5dlYAXmASXWOj+tGYBFTdNX7EXaTgmBCTR3fhBoHixNIlB1C
         cS3YDKmn/Xa1V9xDxBh7ZkNM3Le8bmxUSXzjaT9qsvbISUFoMArvKrs03STNTnl6D7zg
         3YNtSeKyTxdK8CbHhrGiDMJYhDicEthtk1Ue/WhYwXroxpcwWWe1Er8U2p4P/6NW9EGo
         ZWDKz+29xwgBq+yNogXUVFr4fpWqL9dCHVViAbc1MkjuH7HV7bJnO6YzeApQKIbBlp80
         wk0SYHtmeolfOCRYDxkMaxt3nDUlE2jhRYHjWttI0FoNHn4Fcl/tBe9dTx9e9uctPTkC
         K7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ii5G3KnlucUIn9UlNNE+YCO4B8eaXoF8PxtqvdwuOZc=;
        b=Olx/nFx6W4e+rt4yde6jzXunHGeZgVKbZ1/0Tm23Q4xmWp3bCTnc3a7kwdsQmOPC64
         s2KACHvrLGi8bIgw1YPGRdpOMMnHQUNtowpPgDP6zIbh1IQJTAMZGeS1OBkMHIwlb6jp
         Qw+jdcE3XvUfElo7T8MOzvKBoNp0PLs65idmMrsEu0eD4VdMOy7W8pA/slXbZZ2GWlJX
         urvoW8zUmibM+gi+MabEyhgC+eL3LKlOu2P/mCDWnC9FIWUJyib67abkH7WLT25U++lS
         P3DADzUfbbqrqiu5wYoTkWKvCqEP4LlJD8VCeCjg71L9kVgeFsWTcUPGDGYWSic+Q/Sn
         iQwA==
X-Gm-Message-State: APt69E0G92U8emWT/EgFY6oRKhJ9m2sUg6DixAhfDIBwEY3baEK57wjk
        85ttqcZThP7+vyfrdXd4aQ8B9V1dhaBVXpohOWz+6Q==
X-Google-Smtp-Source: AAOMgpeb7hFEbUuQXKeX2FazkOK0ds6wD8EUP3CLJwzFo89ZuKx1gcSFRDy+o7uYd6gCmFuufG8DRdIN/J1BcaLDl7I=
X-Received: by 2002:adf:dd03:: with SMTP id a3-v6mr2262594wrm.2.1529683844280;
 Fri, 22 Jun 2018 09:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod7Rf0FZHqYBPd1OTkVuvA5QRrkYQku40QJtS2--g6PrQQ@mail.gmail.com>
 <20180622154623.25388-1-Jason@zx2c4.com>
In-Reply-To: <20180622154623.25388-1-Jason@zx2c4.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 22 Jun 2018 09:10:31 -0700
Message-ID: <CALvZod5Hio2kNqz90Z9_1JGxZHHpF89ax+joCHD4sJ87O_6kuw@mail.gmail.com>
Subject: Re: [PATCH] kasan: depend on CONFIG_SLUB_DEBUG
To:     "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        stable@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 8:46 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> KASAN depends on having access to some of the accounting that SLUB_DEBUG
> does; without it, there are immediate crashes [1]. So, the natural thing
> to do is to make KASAN select SLUB_DEBUG.
>
> [1] http://lkml.kernel.org/r/CAHmME9rtoPwxUSnktxzKso14iuVCWT7BE_-_8PAC=pGw1iJnQg@mail.gmail.com
>
> Fixes: f9e13c0a5a33 ("slab, slub: skip unnecessary kasan_cache_shutdown()")
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: <stable@vger.kernel.org>
> Cc: <linux-mm@kvack.org>
> Cc: <linux-kernel@vger.kernel.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  lib/Kconfig.kasan | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 3d35d062970d..c253c1b46c6b 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -6,6 +6,7 @@ if HAVE_ARCH_KASAN
>  config KASAN
>         bool "KASan: runtime memory debugger"
>         depends on SLUB || (SLAB && !DEBUG_SLAB)
> +       select SLUB_DEBUG if SLUB
>         select CONSTRUCTORS
>         select STACKDEPOT
>         help
> --
> 2.17.1
>
