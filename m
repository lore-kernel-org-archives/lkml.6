Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EB2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0439F206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="lUW/a870"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0439F206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbeIENCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:02:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44803 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeIENCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:02:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id v16-v6so6634015wro.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 01:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9kK749RISeQorgRDsLhpAah28I7dobUTxNmOlBW9+W4=;
        b=lUW/a870V7+AFr7SkkwCbAVq8aQ8qv6zH22JRt7dfuhWaRPjh/LtuNY+2nQyt3Gq/I
         sn5Zh+2AYFDE1XL6SC7+sLovNsq8g16txnZU72pPUGJ8HkUZ2YDBqN2K/2pxpsa17uDp
         A2DoVt0P+1+cbWDAXMYu2/BLPUIZBFcoQEHdEHvHQGcRDh5Im2+YlRRhY03qA4sbF61H
         e18y5r1wD4XzBJTemqaXGR4uHFXtxs+azJdg2lTYv8yVf+4l49qZZvQKAI5Jv+RgXCMZ
         oYeMMl4BhxP59zGv6WJXQcAA1NcPudUK2CVNRIYXc+TV9B+dJLXZVY5Qub6KYfD0G95o
         qihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=9kK749RISeQorgRDsLhpAah28I7dobUTxNmOlBW9+W4=;
        b=KSlwMebkY08Zt5RonW9ueYO6nXxyJ9kM1en8y9pGEBAfej3kAyS2Ss0JPks6Uu3Bhg
         /YxSI5gKWnNJyJa1KV2zN7OsJtEeN8YRmalzJaAevOEdxGUQFilQBzLOXmR64ypgzSuC
         SgEyF5QbRTpB7FGhzTXDBf8jEmfvA5nkP6pF2i14hpeFtICkMgsxmRIKQYat+j/OJzjZ
         dFguxNfKFZW9QNUwr5eUu5Jck8xs5C/cIjwxQxX3quJzhS4pj3aXOksOYjLj9gbRJckt
         4YxpVnJxq2HuFrgZdMdftlKRzRZ2oitikLB0lZvR+QCLqFnHNqiTvYjAzrQZGJJ9VBKB
         YsYA==
X-Gm-Message-State: APzg51DlfmiBjnX2CTjYC5N68BUFTZe/1fn3lENn7BNU4NWHe6kK3RT+
        KVzwQ4kH2u1t7U53b/nr7Dyeiw==
X-Google-Smtp-Source: ANB0VdZ72cq2Qocn9N8w2RA+oLzBeUMEHF9j9lc51asV/V5Lmfqrn4ERkuhMju8Mn62+lg5lhJgchw==
X-Received: by 2002:a05:6000:10d0:: with SMTP id b16mr8625940wrx.226.1536136402475;
        Wed, 05 Sep 2018 01:33:22 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at. [212.186.191.219])
        by smtp.gmail.com with ESMTPSA id 69-v6sm1183590wmb.27.2018.09.05.01.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 01:33:21 -0700 (PDT)
Date:   Wed, 5 Sep 2018 10:33:20 +0200
From:   Lars Ellenberg <lars.ellenberg@linbit.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block <linux-block@vger.kernel.org>,
        drbd-dev@lists.linbit.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7] drbd: Convert from ahash to shash
Message-ID: <20180905083320.GA28462@soda.linbit>
Mail-Followup-To: Kees Cook <keescook@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block <linux-block@vger.kernel.org>,
        drbd-dev@lists.linbit.com, LKML <linux-kernel@vger.kernel.org>
References: <20180806233216.GA6037@beast>
 <CAGXu5jKA6_aZpDXB2UurmW5cEGEC7aMcq=qvJGPVAifjnk17ug@mail.gmail.com>
 <CAGXu5jLyynGbnuhwabbViwzvRFzn-Vj5ktYOrypRGj_qk8UvQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLyynGbnuhwabbViwzvRFzn-Vj5ktYOrypRGj_qk8UvQw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 08:04:18PM -0700, Kees Cook wrote:
> On Mon, Sep 3, 2018 at 11:04 PM, Kees Cook <keescook@chromium.org> wrote:
> > On Mon, Aug 6, 2018 at 4:32 PM, Kees Cook <keescook@chromium.org> wrote:
> >> In preparing to remove all stack VLA usage from the kernel[1], this
> >> removes the discouraged use of AHASH_REQUEST_ON_STACK in favor of
> >> the smaller SHASH_DESC_ON_STACK by converting from ahash-wrapped-shash
> >> to direct shash. By removing a layer of indirection this both improves
> >> performance and reduces stack usage. The stack allocation will be made
> >> a fixed size in a later patch to the crypto subsystem.
> >>
> >> The bulk of the lines in this change are simple s/ahash/shash/, but the
> >> main logic differences are in drbd_csum_ee() and drbd_csum_bio(), which
> >> externalizes the page walking with k(un)map_atomic() instead of using
> >> scattergather.
> >
> > Hi Lars! How does this look to you? If you can Ack I assume Jens would
> > be able to take this.

Sure, I should have ACKed it a month ago already.  As I said, I believe
you the crypto. And you added the kmap_atomic as I pointed out.
All good.

> FWIW I've tested a simple drbd configuration before/after this change
> and things seem to be working correctly.

You'd need "data-integrity-alg" set (or "verify-alg", and then have it
do an online-verify) to excercise the crypto stuff,
and you'd need a highmem system (are these still out there?)
to have the kmap not be a no-op.  But I don't see any potential problem.

Thanks!

    Lars
