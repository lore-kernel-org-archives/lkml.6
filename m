Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7556AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 00:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35FF7206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 00:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uDdzQhGg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfAHAnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 19:43:05 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43452 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfAHAnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 19:43:05 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so998356pfk.10;
        Mon, 07 Jan 2019 16:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uh6y++QuNYAwaPfmBzU2d4BBPDSSfTlTmyZselgp4qo=;
        b=uDdzQhGgc/gXXT+6PrSE77KYwE4V8/3wnoml3lG3km0A8CC1+R/En5h4lgHUFIIqP9
         bUP3pD4tSUb91ZAf7u8dapgVWQ5aCHi7W9a/1qQt+VWcp2bGN/tv+9kSEAL4ZELNpOvj
         sY0r/DfS5SSf/G5i/xwdod1YdGhWE6Gx5DRG/1yPBTqpUJKwtkBcVb5cHTuj65g1pSv+
         41Rmr1huydRyvv4utbqAmUbsjzg7C1S8Y3jeKgOYZ7N8oEQQdw6w6c7i73oLL6meC5+y
         ROaIVvmcnc1lTJaHPtYn9MyI28yOoC2Ab9SUKRbAWS+3oTZSwSUrv7F8YA/5yX7H6YKp
         ++6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uh6y++QuNYAwaPfmBzU2d4BBPDSSfTlTmyZselgp4qo=;
        b=J3PsThcg6A8WBh+zITEsexM3rTXDZvoODPrmbidrbtnozT03qQ3HqMEczEUn7PXkp8
         LjRKyx5rMwz6bYIiLuKCQeyFHg0ZXixkXeZSPx4Vr6o8JiaiO5veZgUGpXO0iwr6GaIq
         F3g93vA4EYKRuYOK0d9Kab85yWWyx7qBbpm+1/AYQJUKYccFaF2A/22DKZmqRSAwHKKb
         yu+mdjoWNX20ql35A2BPf6MgcXVMQczKppWZ1CwvepUJ49sZEjtBU72Z2b1024ROh3K4
         4up8KlWL3eGJUVRrKrZ9RSt+zDXqyW/s0o8Bl45/FGOevE2qP0yCDnGDtc46L5aqWn71
         v15g==
X-Gm-Message-State: AJcUukf8htw5X/ydOeNepn6L9jjF0lzsUlsaiA9J94baqLbgjTaFcs+l
        35RKwQMQaMPho46oLcYuF64=
X-Google-Smtp-Source: ALg8bN64PSnqCc1R4s4ZZe86cF3pjja4HOnqcU8P09KcCGzkIzsFYSzihcAO6t3Woi0zTd8aVmSuQQ==
X-Received: by 2002:a63:fa58:: with SMTP id g24mr12495112pgk.390.1546908184267;
        Mon, 07 Jan 2019 16:43:04 -0800 (PST)
Received: from mail.google.com ([207.246.99.41])
        by smtp.gmail.com with ESMTPSA id y5sm122211088pge.49.2019.01.07.16.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 16:43:03 -0800 (PST)
Date:   Tue, 8 Jan 2019 08:42:57 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 2/4] Kbuild updates for v4.21 part2
Message-ID: <20190108004255.tq2fffkbxffrzsv3@mail.google.com>
References: <CAK7LNARQggM3aKEPRKJqa4tunFAfmfErMZuS-rrnRv6UB1VpPQ@mail.gmail.com>
 <CAHk-=wiLt3rgeyM3BWAd5VJrKcnxxuHybwoQiDGMgyspo6oXDg@mail.gmail.com>
 <CAK7LNASpO86yNe4BWBYnfd+r82=d_ofxYybLi_aM+4+dgf46+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASpO86yNe4BWBYnfd+r82=d_ofxYybLi_aM+4+dgf46+A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 01:32:56PM +0900, Masahiro Yamada wrote:
> (+CC Changbin Du, Arnd Bergmann)
> 
> 
> 
[...]
> > This branch already added a couple of extra inline markers just to
> > make code work reasonably. How many tens (or hundreds) got missed just
> > because the build still works, but the lack of inlining means that we
> > generate completely garbage code?
> 
> 
> I do not have the exact number, but
> my impression was "not so many".
> 
> Changbin and Arnd might have better insight.
> They were trying to eliminate potential problems beforehand.
> 
> For example,
> 7e17916b
> 412dd15c
> 08813e0e
> 
Yes, the case is not so many. At the beginning, I also thought this could
require incredible change. But after trying, just found it is not so bad. I have
a couple of patches to fix the remaing warnings which adds 'inline' or '_init'
markers for related functions.

I promise that all warnings get fixed with new version. And since I only have
coressponding setup to fully test x86 and ARM platform, I think we could make
this new option depend on x86 or arm temparaly so untested platforms will
not complain anymore.

Linus, is this good for you? Thank you for revewing.

> 
> 
> 
> > I'm going to skip this pull request.
> >
> > We have basically always required a certain level of competence from
> > the compiler, and this basically says that the compiler can do stupid
> > things and we'd have to fix those stupidities by hand.
> >
> >              Linus
> 
> 
> 
> -- 
> Best Regards
> Masahiro Yamada

-- 
Cheers,
Changbin Du
