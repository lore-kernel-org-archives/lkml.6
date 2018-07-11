Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B346C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB5C20854
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CbcOCNFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB5C20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389081AbeGKVOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:14:54 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38515 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeGKVOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:14:53 -0400
Received: by mail-it0-f68.google.com with SMTP id v71-v6so4429671itb.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 14:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F/z/EDl/Ggr7WximT3e7Y9mnKU8jD+TK/rDSQIW9pwM=;
        b=CbcOCNFPUiekUkicZbz1ruRdh0RYIChMTMbM0ACErfaH0eo+zjo7YC3mVXNp/CewXE
         lzmfjrJlGVZUvPRuTunkAfQac2O1D3c1NKbCtdSvJCBqNqRduP/jTTT/QM9YQE/Krxje
         nTXQJQx9u/mK99zxv6Ypcvjku6iaqQpl1RiDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F/z/EDl/Ggr7WximT3e7Y9mnKU8jD+TK/rDSQIW9pwM=;
        b=FDIIcxHv3xqcgVl3k9Mdit8ltLU15nqzm+nKrqosUCfZm6f07ZWm6O8gPtp8PbdHob
         zdkbAmo4dd5RUf62mnc3Rom1jfzUgY9FnNkN3btz9Q6piVy3T5m8m4egQR0xrLXr+7bR
         DNbw1BBjp8tfFwwYK2Yqs34PGNQNKs7WphPH79jOib+KgVeSvUXvrPxTwnEDPdvZl3j6
         7zLNkpng3PeEjPCkDTQVMwkjcB1C6+lRStDyPg5ccAhCbfaUHclq5A++D9vjVpMEEQ78
         xbQ4yHAoZyI8FfiLvysQ8ZN9xdVqe2jzAuHKS0rQsmu1vwmVMFiC6pHDF9IGLL0QgtLC
         rMCQ==
X-Gm-Message-State: AOUpUlEoffAOewu14z8hEmlxTKkq+3nr6I3t2JzS0hLZWCk4PARxO6bB
        5mfgf2X8XFw7AYnCPP4zdqIzS1tTLjEsdlHEah5++A==
X-Google-Smtp-Source: AAOMgpfAw+8Ke0Fz/RVPh8QnD9uXauqYLCqaLgibysrEPhslWihoClm9oLnzIiFMU8js9jCT3txf4pFLvlorjINgA9s=
X-Received: by 2002:a24:558a:: with SMTP id e132-v6mr115202itb.2.1531343320773;
 Wed, 11 Jul 2018 14:08:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:e492:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 14:08:40
 -0700 (PDT)
X-Originating-IP: [2a02:168:5628:0:496f:7dc5:66d7:a057]
In-Reply-To: <20180711200641.GJ72677@devbig577.frc2.facebook.com>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
 <20180709083650.23549-2-daniel.vetter@ffwll.ch> <20180711164058.GC72677@devbig577.frc2.facebook.com>
 <20180711164536.GD72677@devbig577.frc2.facebook.com> <965184f9-e5ed-3c8b-bfd7-a033a252371b@kernel.dk>
 <CAKMK7uE5aJq-1wd0ZOhwFaTy3iKMAZsfdAf=Tw+eGxtCmfcVQg@mail.gmail.com>
 <85df8c40-dac9-5f97-f81a-6de061cfdfa8@kernel.dk> <20180711200641.GJ72677@devbig577.frc2.facebook.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 11 Jul 2018 23:08:40 +0200
Message-ID: <CAKMK7uGBWwbuSr7k83w0JAQ9bUKYvreYCJpBwpEqcUe3DZVrrQ@mail.gmail.com>
Subject: Re: [PATCH 02/12] blk: use for_each_if
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Shaohua Li <shli@fb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 10:06 PM, Tejun Heo <tj@kernel.org> wrote:
> On Wed, Jul 11, 2018 at 01:31:51PM -0600, Jens Axboe wrote:
>> I don't think there's a git easy way of sending it out outside of
>> just ensuring that everybody is CC'ed on everything. I don't mind
>> that at all. I don't subscribe to lkml, and the patches weren't
>> sent to linux-block. Hence all I see is this stand-alone patch,
>> and logic would dictate that it's stand-alone (but it isn't).

Hm yeah I forgot to add linux-block. But others where there's no
dedicated list (or get_maintainers.pl didn't have one) also complained
about not getting Cc'ed, and I can't Cc everyone for sweeping changes.

> What I sometimes do is including a short blurb on each patch giving
> the overview and action hints (e.g. this is part of patchset doing XYZ
> and should be routed such and such).  It's a bit redundant but has
> worked pretty well for patchsets with dependenat & sweeping changes.

Yeah I guess I can just copypaste/summarize patch 1 to all the
subsequent patches, sounds like the best option.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
