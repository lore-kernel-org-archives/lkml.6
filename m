Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781B9C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302232075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="afk9Kadt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 302232075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeJYVLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 17:11:09 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37836 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbeJYVLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 17:11:09 -0400
Received: by mail-oi1-f196.google.com with SMTP id e17-v6so6478571oib.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 05:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4qkP5+4zUpDexjeahaHUtyRiefJqAjWZn4M453yEJp0=;
        b=afk9KadtDA8pE6+kL8w4ebZqXz3RP/tjGHRwGJPW/bUQgsViAjebd9XkKB6R5GdZdr
         lpe7PBvWbPJCYUHvs9UkeXBZaEv58ugxVQmR1fWsWDvoyRUHjBec0WaKTfoCkNallgr8
         wPeRRW6Ifr94AGAbEFYyP0Pw5p5XLd44KOoFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4qkP5+4zUpDexjeahaHUtyRiefJqAjWZn4M453yEJp0=;
        b=DM6FapEKSLCJZxucliQGmsRV+52B/mvnLUqckgeTnIIMVVfPgt7S9D0MRBb7/sfFNE
         4vL+yXyW/dS2o+Jc1FGI2SaeVuNlM4QbEFP1wh6hrq+3hzBafI210GXcCOwDzpXaeHfJ
         ndR/oEVWZoPJv58VI3eZsOpx0qhP/u2vOd5LcQ24YzPqp6/u7uHUqgjWzmfO649c9tQy
         AwjaNe9lEtLvpSdCV+39+dqSwnKfsmM3eXlPDmfGhbPHaEtfwPzgcoyBYQAARs1gSVeM
         KKPWvwT8yxWkX5HtcW6pqTzQ42/PZT5gaBuaJkMet+lvrd9pMsVFCUxZ3QlKulSR36sg
         Rgkg==
X-Gm-Message-State: AGRZ1gK2lRKula9CQ2u3tLV+UYN8sSpaW7zqjr3z/FG7i4TzgKSHLiI5
        hRkCfT3Ya+rzIfc50yIU3Y2qzetkJNEnDQ==
X-Google-Smtp-Source: AJdET5eAALnyoTNyBzw6JjiYCwJR7MBlcYZslIqdA5hRQOJwP/+h/Hfmkb+0/+kbSxkVrh7kafeNUg==
X-Received: by 2002:aca:5907:: with SMTP id n7-v6mr368669oib.166.1540471112964;
        Thu, 25 Oct 2018 05:38:32 -0700 (PDT)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com. [209.85.167.181])
        by smtp.gmail.com with ESMTPSA id g20sm2683031oth.30.2018.10.25.05.38.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 05:38:31 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id 20-v6so6505652oip.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 05:38:30 -0700 (PDT)
X-Received: by 2002:aca:c593:: with SMTP id v141-v6mr365850oif.113.1540471110165;
 Thu, 25 Oct 2018 05:38:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7915:0:0:0:0:0 with HTTP; Thu, 25 Oct 2018 05:37:59
 -0700 (PDT)
In-Reply-To: <20181025120006.GY30658@n2100.armlinux.org.uk>
References: <20181025012745.20884-1-rafael.tinoco@linaro.org> <20181025120006.GY30658@n2100.armlinux.org.uk>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Date:   Thu, 25 Oct 2018 09:37:59 -0300
X-Gmail-Original-Message-ID: <CABdQkv_cC4ixEFr91zyg-S21O5_7U8FV7=g7ZMRqGcQyhrwzaQ@mail.gmail.com>
Message-ID: <CABdQkv_cC4ixEFr91zyg-S21O5_7U8FV7=g7ZMRqGcQyhrwzaQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/zsmalloc.c: check encoded object value overflow
 for PAE
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Rafael David Tinoco <rafael.tinoco@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, Mark Brown <broonie@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Nitin Gupta <ngupta@vflare.org>,
        Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> MAX_PHYSMEM_BITS is a definition for sparsemem, and is only visible
> when sparsemem is enabled.  When sparsemem is disabled, asm/sparsemem.h
> is not included (and should not be included) which means there is no
> MAX_PHYSMEM_BITS definition.

Missed that part :\, tks.

> I don't think zsmalloc.c should be (ab)using MAX_PHYSMEM_BITS, and
> your description above makes it sound like you expect it to always be
> defined.
>
> If we want to have a definition for this, we shouldn't be playing
> fragile games like:
>
> #ifndef MAX_POSSIBLE_PHYSMEM_BITS
> #ifdef MAX_PHYSMEM_BITS
> #define MAX_POSSIBLE_PHYSMEM_BITS MAX_PHYSMEM_BITS
> #else
> /*
>  * If this definition of MAX_PHYSMEM_BITS is used, OBJ_INDEX_BITS will just
>  * be PAGE_SHIFT
>  */
> #define MAX_POSSIBLE_PHYSMEM_BITS BITS_PER_LONG
> #endif
> #endif
>
> but instead insist that MAX_PHYSMEM_BITS is defined _everywhere_.

Is it okay to propose using only MAX_PHYSMEM_BITS for zsmalloc (like
it was before commit 02390b87) instead, and make sure *at least* ARM
32/64 and x86/x64, for now, have it defined outside sparsemem headers
as well ? This way I can WARN_ONCE(), instead of BUG(), when specific
arch does not define it - enforcing behavior - showing BITS_PER_LONG
is being used instead of MAX_PHYSMEM_BITS (warning, at least once, for
the possibility of an overflow, like the issue showed in here).
