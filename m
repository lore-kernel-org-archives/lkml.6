Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F099DC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 18:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EFF208D9
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 18:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QMLV6RBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99EFF208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932769AbeGHSb3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 14:31:29 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:36626 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754282AbeGHSb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 14:31:27 -0400
Received: by mail-it0-f43.google.com with SMTP id j185-v6so23275435ite.1;
        Sun, 08 Jul 2018 11:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b7x7Ua3Y4sER0+2rKMC8IJtkXNr4ziXyAJEg+s2KXec=;
        b=QMLV6RBlBWnTI/0qPgEbvuSpNzeM25mAVHa5OMvDqC5xN7eotWmabIOqPjaMajTjRj
         +ICwHkKP+hbphItN6a+8RPUnmZNJvGIMtMXfH+aOofGzSY8mglyxdFO6m+4Nai5AuHDe
         6ni1AStr4vWAVCiMb0zw41uJaXmyINHkoxT9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b7x7Ua3Y4sER0+2rKMC8IJtkXNr4ziXyAJEg+s2KXec=;
        b=QLHJjXscUO+ZbSb4xjQ1S7DVUj43QeuszrRdd+uGyGRxs9TO9t38zwq7idlKKQ5Ose
         MFZ6l5tWHhKZ6fvzvtj0oueSM7DHlk4vW3E3snc/IVYjNRAxvCAS/iwY7Zxjd9CSc+RE
         Y443myK+8XESqNMG7g5/piIPu7zEp6ZJ3UKIhK6SdA+0ZlBDM5GlMpvuKhE6H5jISnq2
         5bSuqwBUUDKMSIiJsGHLbAzsb7GZg1b1PPAg5ngvuN8g7UdOQTSwxeTknqwdfcKQCEj2
         4QPARHR9Gow46zw3kgJm/tDa3sZ4K5NM5VP3C6UYN5IF9DD/k7y9DoW4rnkZLa3XHZ7/
         ZB2g==
X-Gm-Message-State: APt69E2mls6dK2uuKxaufZlry1OAxntNWuiftoBoNRBT6EvFzY5K/d85
        Tzlcpz0YbIk2B7qvqWHzERKkcCmV+CRm4kLa0GQT2w==
X-Google-Smtp-Source: AAOMgpdA5Km64z8H4Nwcvd3dDe+NzqSgctljK9M1GcYI0oiE0kpIxuLoJtC886SiezpbRZvsyb6xNJQpJvpvNTRs+Sk=
X-Received: by 2002:a02:1bdc:: with SMTP id 89-v6mr14492366jas.72.1531074686852;
 Sun, 08 Jul 2018 11:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20161213132414.GA7898@gondor.apana.org.au> <20170223125141.GA17400@gondor.apana.org.au>
 <20170714141855.GA29426@gondor.apana.org.au> <20170922084401.GA15541@gondor.apana.org.au>
 <20171128230929.GA17783@gondor.apana.org.au> <20171222064931.GA27068@gondor.apana.org.au>
 <20180105073808.GA14405@gondor.apana.org.au> <20180212031702.GA26153@gondor.apana.org.au>
 <20180428080517.haxgpvqrwgotakyo@gondor.apana.org.au> <20180622145403.6ltjip7che227fuo@gondor.apana.org.au>
 <20180708162035.zunfeflnq5hgwq6n@gondor.apana.org.au>
In-Reply-To: <20180708162035.zunfeflnq5hgwq6n@gondor.apana.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Jul 2018 11:31:16 -0700
Message-ID: <CA+55aFwe3HrgMBUhyHC7kAOCvp31S4kpAqDSFQ+BQY6r=WBiiA@mail.gmail.com>
Subject: Re: Crypto Fixes for 4.18
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 8, 2018 at 9:20 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> - Add missing RETs in x86 aegis/morus.

Side note - I queried earlier during the discussion about this: how
was this code taken despite having clearly never tested on _anything_?

That's a serious question. Code that simply has never had any testing
AT ALL should not have gotten in.

The use of 'int3' in padding showed the issue, but I don't believe the
code could possibly have worked with the nops and fallthroughs.

               Linus
