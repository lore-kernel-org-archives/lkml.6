Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B4CC3712F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5AA2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="LeE1A1tO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfAUWsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 17:48:16 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44112 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfAUWsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 17:48:15 -0500
Received: by mail-ed1-f68.google.com with SMTP id y56so17752782edd.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 14:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BU7fy1dmmAth4C8W6P7dcVoWnBTy1HFBATZf0qxGiiQ=;
        b=LeE1A1tO8ypJFkHzQlCd3nD57sqTZuDt7PfwuDpp6NkingXZIIxelX2MlObeRDcWC1
         0baHZh/0ku+P5yz14Svce+I5AV1wjzdfW2AoYoictCS3z6I053NBjQyAQ7/9xot6RTAS
         tD5axHrIkqrwj153qEitTZWISGpY08krcyzg7YGRxLwGHIcvJZlBTRYXS9i6k7XOqP2O
         mgU73vRmvzTvCgzizsQSJA0JtZhkwBNtyunfcXWRbjqKSQHgBVVC1PnuXOxyWZgrReDC
         TbG1GJJt/Z9n6oqEgp7MJu2YCc5/yy7shB8QTs7RwMwnslvsUyhuYeGILxR6fI7fAjRX
         aOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BU7fy1dmmAth4C8W6P7dcVoWnBTy1HFBATZf0qxGiiQ=;
        b=TsPdFbvEju7ypQzJ7ukYO/f62DD9I6Fy1GprzZQ5zjn7tIElOEbhmHnL9xVRV/HcRa
         nPyDC36Id93ulwUyw4NiZonch1sKFqoYx0mZx2ttlZpohGLhRpzm0SE89MZ1Fxf8ebsC
         zyW+xSC6ri4CZqHFgPTbUN9U31QYy5ntFBIXtr5pwU6oJaBk8+qrO2ejE5Cc4sxrN/yD
         Dz1uT3qEhTegj8DXHV5nn02iQxtgW5DKtNDmot55BP2MLoHNbuioy4/K9hF6l9LOVRry
         3rJrE8KdfNxZ2yJ8bHWEfRd2z2r0mDSdyS+m9/zDjGS5nSKD6R4tLmbeMady453u8k0Z
         ZgQA==
X-Gm-Message-State: AJcUukcF47zwHo6uBdGUA3pbnz7E4qtSW9fcoJFfm2J9ySRAH/yEbhJb
        sVdqbHUr5vwxcPdITRCt3CqMlAxJLns7oA==
X-Google-Smtp-Source: ALg8bN5Egv8c/Ox/PtXUHtZweX4lLHMgEIeiIKlx4sN/elGQa6ZpBBGQWaElKiUjyMHC5FSTt6IX5Q==
X-Received: by 2002:a17:906:54d3:: with SMTP id c19-v6mr25459145ejp.116.1548110893848;
        Mon, 21 Jan 2019 14:48:13 -0800 (PST)
Received: from brauner.io ([2a02:8109:b6bf:f9e4:9473:6b39:afaf:14d4])
        by smtp.gmail.com with ESMTPSA id b46sm9299945edd.94.2019.01.21.14.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 14:48:13 -0800 (PST)
Date:   Mon, 21 Jan 2019 23:48:12 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: linux-next: manual merge of the pidfd tree with the y2038 tree
Message-ID: <20190121224811.gbvg22vg4kgg4kbs@brauner.io>
References: <20190121143951.68956db3@canb.auug.org.au>
 <CAK8P3a0Yth+f8AANE6g8c_zE0Zt1CvCdzMDFK=pr8eNqmrBV0Q@mail.gmail.com>
 <20190121191306.ifga5aw5atu2vvb7@brauner.io>
 <CAK8P3a2CkXJ=giXQgxEcQAeH1Wt8jKc_P+YTOLJpUPVKYU8m9g@mail.gmail.com>
 <20190121202328.rgrv54lybilsvitu@brauner.io>
 <da262bd9-1de0-eabb-ee44-e0ee152d15bb@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <da262bd9-1de0-eabb-ee44-e0ee152d15bb@kernel.dk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 03:44:17PM -0700, Jens Axboe wrote:
> On 1/21/19 1:23 PM, Christian Brauner wrote:
> > On Mon, Jan 21, 2019 at 09:15:27PM +0100, Arnd Bergmann wrote:
> >> On Mon, Jan 21, 2019 at 8:13 PM Christian Brauner <christian@brauner.io> wrote:
> >>> On Mon, Jan 21, 2019 at 06:16:22PM +0100, Arnd Bergmann wrote:
> >>>> On Mon, Jan 21, 2019 at 4:40 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >>>
> >>> I plan on sending the pidfd branch with the new pidfd_send_signal()
> >>> syscall for the 5.1 window. Should we somehow coordinate so that our
> >>> branches don't conflict? Any suggestions?
> >>
> >> A conflict can't be avoided, but if you pick system call number 427
> >> for pidfd_send_signal, and Jens picks numbers 424 through 426 for
> > 
> > That sounds good to me. Since it's only one syscall for the pidfd branch
> > is there anything that speaks against me using 424? Given that the other
> > patchset has 4 new syscalls. :)
> > Jens, any objections?
> 
> I'm fine with either one, I'll have to renumber in any case. But it's 3
> new syscalls (424, 425, 426), not 4.
> 
> Arnd, what's the best way to make this switch now, in my tree? Would be

Yeah, I'd like to know that as well.

Christian

> great if I didn't have to change it again once I make the change.
