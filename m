Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 14353C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD359208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIItbh1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD359208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935892AbeFMO5c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:57:32 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39381 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935694AbeFMO51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:57:27 -0400
Received: by mail-qt0-f194.google.com with SMTP id p23-v6so2626510qtn.6;
        Wed, 13 Jun 2018 07:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JXOqPD9ykRA6j11QZ0bjBZxoKQX7Nu413MAVxDG9n2k=;
        b=EIItbh1kCEIJid+evZq2cWS9kFb2zmRaTfswwu2/GPJjs9vhUVnjE2Fe9U9tAtF+0Z
         MVi2c4ZOv+uQvyVnZ9IfO/eKlYNYcaAemfjyXw0n3vG4KCyEA5sHcQNONCo6TH2WbxcD
         67OZwGNiY7nhu9B5dww0+SGVFO8rKWvq3i/EAfyNVl0eWNhAxtxXfeugvuwI426aFFUz
         DWFIS9UNgvkFpFCOtlkAtGCND1dKEDNdcvw1iSzw0m184wRsu3r/bfmlXwKZbI5iclpb
         MQgaNuVvXQKlrgl7xDjle+Rj6b2Vyyd/QtYx3cdAxE945jK5LgZyHomp/XwvnEr0vDbJ
         kYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JXOqPD9ykRA6j11QZ0bjBZxoKQX7Nu413MAVxDG9n2k=;
        b=McUVzC1gW14co5CEZcUZ3VmxoBZsaoTbTKHe1DTCKLiS03Lt0wqAQGeDsBg8IaHWTX
         lNBarMEvIKLmuEWnGi6yCVOmoaquQ0n3r7gOjKD66RWR6UAXVBXSnAyH3TWJ0mDEYgz7
         8xygh3ATIRVRrXI+i+LQxYr3URGAc5/RmUCWHX9uXe8aXtwL7KxwnpSDoP4mjU8HdHtk
         DwJR0OAFelB5vt5p/grC6wRP91oF05gEB2X9oZS8vX2+2MDB5BIESYNFOZyP9GsUTIm7
         OYqC59/XigaR2hhpo4Dxaeq5XBY0vWb2uRrM8Mn8Ti0OELImmxzvl/zVmwkRkfTs/wo+
         FpDQ==
X-Gm-Message-State: APt69E0+spyYojz2BJCkkMpihg7Y3MTyJ5U8yKxS9ub1LjWkHE5RuPOF
        tkCLHr0je+9ZrddSKWeXzA==
X-Google-Smtp-Source: ADUXVKKsw0OMEr7ndAwicd8e3Ka6BhIzcWkl+eK5vlNakEpNFwBDx49K6pge7heuBeyP9VTsfTdfnA==
X-Received: by 2002:a0c:de13:: with SMTP id t19-v6mr4752154qvk.93.1528901846320;
        Wed, 13 Jun 2018 07:57:26 -0700 (PDT)
Received: from kmo-pixel (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id d11-v6sm2051632qto.41.2018.06.13.07.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 07:57:25 -0700 (PDT)
Date:   Wed, 13 Jun 2018 10:57:22 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Sterba <dsterba@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH V6 12/30] block: introduce bio_chunks()
Message-ID: <20180613145722.GA17340@kmo-pixel>
References: <20180609123014.8861-1-ming.lei@redhat.com>
 <20180609123014.8861-13-ming.lei@redhat.com>
 <20180613144741.GC4693@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613144741.GC4693@infradead.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 07:47:41AM -0700, Christoph Hellwig wrote:
> > +static inline unsigned bio_chunks(struct bio *bio)
> > +{
> > +	unsigned chunks = 0;
> > +	struct bio_vec bv;
> > +	struct bvec_iter iter;
> >  
> > -	return segs;
> > +	/*
> > +	 * We special case discard/write same/write zeroes, because they
> > +	 * interpret bi_size differently:
> > +	 */
> > +	switch (bio_op(bio)) {
> > +	case REQ_OP_DISCARD:
> > +	case REQ_OP_SECURE_ERASE:
> > +	case REQ_OP_WRITE_ZEROES:
> > +		return 0;
> > +	case REQ_OP_WRITE_SAME:
> > +		return 1;
> > +	default:
> > +		bio_for_each_chunk(bv, bio, iter)
> > +			chunks++;
> > +		return chunks;
> 
> Shouldn't this just return bio->bi_vcnt?

No.

bio->bi_vcnt is only for the owner of a bio (the code that originally allocated
it and filled it out) to use, and really the only legit use is
bio_for_each_segment_all() (iterating over segments without using bi_iter
because it's already been iterated to the end), and as a convenience thing for
bio_add_page.

Code that has a bio submitted to it can _not_ use bio->bi_vcnt, it's perfectly
legal for it to be 0 (and it is for e.g. bio splits).
