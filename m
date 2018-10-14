Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BF4C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 04:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE99020843
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 04:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZDbUk1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE99020843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbeJNL7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 07:59:13 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34098 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbeJNL7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 07:59:13 -0400
Received: by mail-pl1-f193.google.com with SMTP id f18-v6so7702446plr.1;
        Sat, 13 Oct 2018 21:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZOgEKp7eMC3ZrigqRh8AbVefXULR1cZWtDm/xPURl2M=;
        b=pZDbUk1IhM+vGLqAKMAF3d8NOdBNOx30PISkbZdbxfskPp1fUL+NnxmkJwCZYmFxYy
         II/22Fl11Fg33DBc/nrx/ygc2pDsD8HBfwWo7xflVyoWHJ72vM3RdEGS6r0KeCd90hPR
         v54HBu1s093Y3weIuUT3RGoOqK0c2Yu2m8OppRS2y5MCbQDieeEqlfL4MhvORwBCOIuM
         neAZhjUmkBg7xVOhfRyFUuYpK/Q9y8PPiDcMoE6oTrzAm82rqfids/vuTcY8eARFzOAH
         6JShd2tiECxjnKFKy9cugUbPqIEn3nqOz4rZ7GXLZOj1szs+TWrBAq9ZCQS3oF7IyfQi
         Ubdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZOgEKp7eMC3ZrigqRh8AbVefXULR1cZWtDm/xPURl2M=;
        b=NfoMxZOz7QIoPhumdJf1FL2vO1dJconhJP9VyjaM4PPIthpbqwrdiTwpuIDR6TOIBO
         +DrqFbpgDhPIR3EXXxtTGme3GJmQrdtzFvRVNxY1QEueTVqdZ+zKwfdEtE8WwpIuiu2s
         wpf+M24hyRrpthLY9aKoF8yxEZmv72OZwXZtKKSQPjgSQxKV7KgtA4xC9wjv1HrYXpGD
         oyBxVPOyJ2u41hbP2Iumc/Mkv3tITsX54VdMA1squgX02rzsVAUa0o188s4OjJs89gaK
         ne8NNZyrKml4VdyIBlOR5Lrla2QBhc/mv/NzSolWa85NqLUlYX1VoeTgclFNngHSwwuJ
         2GNQ==
X-Gm-Message-State: ABuFfojcVASbHTpolIUw+vVhB21qWF8mY36IjxZPIr31kRcUAS8k9O3s
        0d4xGfV1MAdrhehLYpff8ynTT2gA
X-Google-Smtp-Source: ACcGV62tg7dndcyxKkJWpps6RpgNLd0PW8s+ZBR5zP6w/jPPsCZkbsCQ4/J55XX7422oXpLddsNSHA==
X-Received: by 2002:a17:902:9a07:: with SMTP id v7-v6mr11681324plp.14.1539490776474;
        Sat, 13 Oct 2018 21:19:36 -0700 (PDT)
Received: from icarus ([2001:268:c0a3:6768:14f8:df52:b210:ea19])
        by smtp.gmail.com with ESMTPSA id f68-v6sm8612776pfe.143.2018.10.13.21.19.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Oct 2018 21:19:35 -0700 (PDT)
Date:   Sun, 14 Oct 2018 13:19:33 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linus.walleij@linaro.org, akpm@linux-foundation.org,
        linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Subject: Re: [RESEND PATCH v4 3/8] gpio: 104-dio-48e: Utilize
 for_each_set_clump macro
Message-ID: <20181014041933.GA7335@icarus>
References: <cover.1538441919.git.vilhelm.gray@gmail.com>
 <5906381114b14d5b0359510a1d23accbd239eaa5.1538441919.git.vilhelm.gray@gmail.com>
 <822be05b-092b-41c2-3c31-8981acd5cb9e@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <822be05b-092b-41c2-3c31-8981acd5cb9e@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 09:00:45AM +0200, Rasmus Villemoes wrote:
> On 2018-10-02 03:14, William Breathitt Gray wrote:
> >  	/* clear bits array to a clean slate */
> >  	bitmap_zero(bits, chip->ngpio);
> >  
> > -	/* get bits are evaluated a gpio port register at a time */
> > -	for (i = 0; i < ARRAY_SIZE(ports); i++) {
> > -		/* gpio offset in bits array */
> > -		bits_offset = i * gpio_reg_size;
> > -
> > -		/* word index for bits array */
> > -		word_index = BIT_WORD(bits_offset);
> > -
> > -		/* gpio offset within current word of bits array */
> > -		word_offset = bits_offset % BITS_PER_LONG;
> > -
> > -		/* mask of get bits for current gpio within current word */
> > -		word_mask = mask[word_index] & (port_mask << word_offset);
> > -		if (!word_mask) {
> > -			/* no get bits in this port so skip to next one */
> > -			continue;
> > -		}
> > -
> > -		/* read bits from current gpio port */
> > +	for_each_set_clump(i, word, offset, mask, ARRAY_SIZE(ports), 8) {
> >  		port_state = inb(dio48egpio->base + ports[i]);
> > -
> > -		/* store acquired bits at respective bits array offset */
> > -		bits[word_index] |= port_state << word_offset;
> > +		bits[word] |= port_state << offset;
> 
> Somewhat unrelated to this series, but is the existing code correct? I'd
> expect the RHS to be masked by word_mask; otherwise we might set bits in
> bits[] that were not requested? And if one does that, the !word_mask
> test is merely an optimization to avoid reading the gpios when the
> result would be ignored anyway. Perhaps no caller cares.
> 
> Rasmus

I don't think the caller cares in this case. Take a look at the
gpiod_get_array_value_complex function: the desired inputs are collected
before gpio_chip_get_multiple is called and then looped through after --
unrequested bits are simply ignored.

This caller behavior also makes sense because a bit value of 0 in the
bits array does not necessarily mean the input was not requested, but
may instead mean that the value at the input is 0; therefore, the caller
must keep track of the requested inputs rather than try to deduce them
from the values in the bits array.

William Breathitt Gray
