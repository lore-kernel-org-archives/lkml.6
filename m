Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D476C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18CCE21473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gtr57hr3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18CCE21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeJDQ4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:56:22 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46666 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbeJDQ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:56:22 -0400
Received: by mail-pl1-f194.google.com with SMTP id v5-v6so4921732plz.13;
        Thu, 04 Oct 2018 03:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TbaeXp97kNsAXG7UJzI9bv2msdUt9DI7gTBnvKWbGgY=;
        b=Gtr57hr3+keRdlJljB1BW70SbvB2XcHpc3NP5dVUdb53dgrLKjsLFwPKGq19U1r6bj
         7qyLh3zei+XqIlKybQtBVRyZinYHMZ6uNYxs2jDIeTkso+wfKxbMmVdA0l10gIKfpXSV
         4AnIJ9WJKFuyNuc7ysNyF31gW7oa7GD7o5KZHbg9zGABDYCaA/QIACswr7gPySzbhpC1
         Oue0r22W2KM635Ks8nLgK66EUiMPnpB9ouHqYERHzpfc5aV07blJjpkoxokTTOjMxu+e
         WC7bKxZghpk/KpWCAinbyeagn5mXkw6mMxZUxknT4ATOpGAIOsciy2hdb76jSNnfMMkr
         nRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TbaeXp97kNsAXG7UJzI9bv2msdUt9DI7gTBnvKWbGgY=;
        b=TURTTT30XFJWBb3Egyl1EZQjNMK4a3BxYZNJL8mTDVC9zZEn8P6UnCzCTsHl8hJjA7
         Xqp/quRppXnZTOLvV6QGNWjcs+RGWG+LRLuVfVx759B1p6lWvN7xrZB1rKDUClOTUaAm
         U9QFGUIkIzEAjFoWwMMuD7F/3Jw7ouF7iKV0DFCiIUiHtkwF16lEIH8lwTX8ny4p80Dg
         mY6aVqbzvIV+OEBijchR4z/mUXqCoZeigX87q0ssVzBvtKsHZ+iD/6CooOl9MhtG3WgJ
         aCtTNMXLRCKLSg4a0OxmqlwViI/oWhOZuPqmEbXzewwk+pzKeQNZO0qkcois5Xn/rjcU
         46Tg==
X-Gm-Message-State: ABuFfojLWYIxDPtZlzU6v/ctsTCKFJK1b9tja2C37BCU3ORUZWeU3Sa9
        3O6At2lr3mmttVpqvcL8vxM=
X-Google-Smtp-Source: ACcGV61l0N/87fxu6B7vaTcYGWdes/N7woCj4Cov5HiZDKFZINVnf+3G4OSjAVPcoz2moRm70Y6AOA==
X-Received: by 2002:a17:902:6e17:: with SMTP id u23-v6mr6048758plk.28.1538647430379;
        Thu, 04 Oct 2018 03:03:50 -0700 (PDT)
Received: from icarus (122-223-50-245.fukuoka.fdn.vectant.ne.jp. [122.223.50.245])
        by smtp.gmail.com with ESMTPSA id z14-v6sm7894282pfi.4.2018.10.04.03.03.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 03:03:49 -0700 (PDT)
Date:   Thu, 4 Oct 2018 19:03:27 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linus.walleij@linaro.org, akpm@linux-foundation.org,
        linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND PATCH v4 1/8] bitops: Introduce the for_each_set_clump
 macro
Message-ID: <20181004100327.GA4079@icarus>
References: <cover.1538441919.git.vilhelm.gray@gmail.com>
 <f5250b9c78377e476667be1b616c86cf573b57dc.1538441919.git.vilhelm.gray@gmail.com>
 <40ecad49-2797-0d30-b52d-a2e6838dc1ab@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40ecad49-2797-0d30-b52d-a2e6838dc1ab@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 09:42:48AM +0200, Rasmus Villemoes wrote:
> On 2018-10-02 03:13, William Breathitt Gray wrote:
> > This macro iterates for each group of bits (clump) with set bits, within
> > a bitmap memory region. For each iteration, "clump" is set to the found
> > clump index, "index" is set to the word index of the bitmap containing
> > the found clump, and "offset" is set to the bit offset of the found
> > clump within the respective bitmap word.
> 
> I can't say I'm a fan. It seems rather clumsy and ad-hoc - though I do
> see how it matches the code you replace in drivers/gpio/. When I
> initially read the cover letter, I assumed that one would get a sequence
> of 4-bit values, but one has to dig the actual value out of the bitmap
> afterwards using all of index, offset and a mask computed from clump_size.

Yes, that is because this macro is as you noted primarily a replacement
for the repetitive code used in the GPIO drivers; the GPIO drivers
require the index and offset in order to modify and store the requested
bit values and perform port I/O.

I put this macro up in the bitops code, but perhaps I should have left
it local to the GPIO subsystem since its so specific. This is one aspect
I want to determine: whether to keep this macro here or move it.

> > +
> > +/**
> > + * find_next_clump - find next clump with set bits in a memory region
> > + * @index: location to store bitmap word index of found clump
> > + * @offset: bits offset of the found clump within the respective bitmap word
> > + * @bits: address to base the search on
> > + * @size: bitmap size in number of clumps
> 
> That's a rather inconvenient unit, no? And rather easy to get wrong, I
> can easily see people passing nbits instead.
> 
> I think you could reduce the number of arguments to this helper and the
> macro, while getting rid of some confusion: Drop index and offset, let
> clump_index be start_index and measured in bit positions (like
> find_next_bit et al), and let the return value also be a bit position.
> And instead of index and offset, have another unsigned long* output
> parameter that gives the actual value at [return value:return
> value+clump_size]. IOW, I think the prototype should be close to
> find_next_bit, except that in case of "clumps", there's an extra piece
> of information to return.

There may be benefit to develop a different macro more aligned with the
rest of the bitops code -- one where we do in fact return the direct
4-bit value for example. Essentially all the GPIO drivers need are the
index for the hardware I/O port and the index for the bitmap to store
the bits.

So we may be able to reimplement the for_each_set_clump to utilize a
simplier macro that returns the clump value, and then determine index
and offset up in the for_each_set_clump macro; that way we can keep the
generic clump value return code isolated from the code needed by the
GPIO drivers.
 
> > + * @clump_index: clump index at which to start searching
> > + * @clump_size: clump size in bits
> > + *
> > + * Returns the clump index for the next clump with set bits; the respective
> > + * bitmap word index is stored at the location pointed by @index, and the bits
> > + * offset of the found clump within the respective bitmap word is stored at the
> > + * location pointed by @offset. If no bits are set, returns @size.
> > + */
> > +size_t find_next_clump(size_t *const index, unsigned int *const offset,
> > +		       const unsigned long *const bits, const size_t size,
> > +		       const size_t clump_index, const unsigned int clump_size)
> > +{
> > +	size_t i;
> > +	unsigned int bits_offset;
> > +	unsigned long word_mask;
> > +	const unsigned long clump_mask = GENMASK(clump_size - 1, 0);
> > +
> > +	for (i = clump_index; i < size; i++) {
> > +		bits_offset = i * clump_size;
> > +
> > +		*index = BIT_WORD(bits_offset);
> > +		*offset = bits_offset % BITS_PER_LONG;
> > +
> > +		word_mask = bits[*index] & (clump_mask << *offset);
> > +		if (!word_mask)
> > +			continue;
> 
> The cover letter says
> 
>   The clump_size argument can be an arbitrary number of bits and is not
>   required to be a multiple of 2.
> 
> by which I assume you mean "power of 2", but either way, the above code
> does not seem to take into account the case where bits_offset +
> clump_size straddles a word boundary, so it wouldn't work for a
> clump_size that does not divide BITS_PER_LONG.

Ah, you are correct, if clump_size does not divide evenly into
BITS_PER_LONG then the macro skips the portion of bits that reside
across the boundary. This is an unintentional behavior that will need to
be fixed. I didn't notice this since the GPIO drivers utilizing the
macro so far have all used a clump_size that divides cleanly.

> 
> May I suggest another approach:
> 
> unsigned long bitmap_get_value(const unsigned long *bitmap, unsigned
> start, unsigned width): Get the value of bitmap[start:start+width] for
> 1<=width<=BITS_PER_LONG (it's up to the caller to ensure this is within
> the defined region). That can almost be an inline
> 
> bitmap_get_value(const unsigned long *bitmap, unsigned start, unsigned
> width)
> {
>   unsigned idx = BIT_WORD(start);
>   unsigned offset = start % BITS_PER_LONG;
>   unsigned long lower = bitmap[idx] >> offset;
>   unsigned long upper = offset <= BITS_PER_LONG - width ? 0 :
> bitmap[idx+1] << (BITS_PER_LONG - offset);
>   return (lower | upper) & GENMASK(width-1, 0)
> }
> 
> Then you can implement the for_each_set_clump by a (IMO) more readable
> 
>   for (i = 0, start = 0; i < num_ports; i++, start += gpio_reg_size) {
>     word_mask = bitmap_get_value(mask, start, gpio_reg_size);
>     if (!word_mask)
>       continue;
>     ...
>   }
> 
> Or, if you do want find_next_clump/for_each_set_clump, that can be
> implemented in terms of this.
> 
> Rasmus

This might work. All that would need to change to support the GPIO
drivers is to return BIT_WORD(start) as index and offset as (start %
BITS_PER_LONG). These sets can be performed outside of bitmap_get_value,
thus allowing it to have a simplier interface for code that does not
require index/offset.

William Breathitt Gray
