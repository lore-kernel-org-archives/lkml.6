Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B63C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 21:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151F1222EA
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 21:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="NGwx/2cb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfAEVox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 16:44:53 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35785 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfAEVox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 16:44:53 -0500
Received: by mail-it1-f196.google.com with SMTP id p197so5822551itp.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 13:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bOtXwBBxRuMhAOTWiVo9hQYk3eLuvVikh59aEu2MWNM=;
        b=NGwx/2cbZW+2qz9k2U7PEbjDjsCaHPo9YbnkIDNBVkpUV1IqzaHFEKJxM5Bs/dSLTN
         7CrADXcusuLR2PqM+B6NMoZpBg9XXCJrgkVB4hRDSnQKpwdD9G56UWBZpLQH8JfdGZ3L
         WIl3XnWxagkVPHZkjdSrbURlCfL9wBCzLy0wW91o5c0SZVGhOikYZQ7/lwpRJb7QN++z
         o5l/6v1jUQ4wGYEpEnPB3i5YGEdlz3GoIwO/PMsVxl8M6OdcMPjXu2XpuYjOdPxGTr+O
         dBHmVCPgSlVf4cdYrYGY1YLEQOi9m/Bbp69sdBvsRZyRTzlLXnqgXgE43XsbPxdjLvYV
         18gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bOtXwBBxRuMhAOTWiVo9hQYk3eLuvVikh59aEu2MWNM=;
        b=XG1WOI1Gz2l0FlFckaSP7F3kDg0LvC+VShlIe12N3f02Q+l6yYnCUeSVGAJixilsuj
         I/0YSfJcL5Xt8I5ANTd9a4lSmLZpIxSy8Bme6YnBDpSPBbXrqBP8Y71Mh7Y214gEoPIN
         zovVGnymTBsjgHZQe5cEGAZ7DqZ9eQZtPaldyidXsy9xZBXDXIwQUO6I7hDZ51qL2SWe
         wBDzX7CVk2WLwkUCH2Q6EUWtMIEBroUe+uc33PWVtVzX41L+DNTaW6guBeG2qNeF+Ncy
         Pq+3kCCvztc3+hNYqo90tL0fxuE7lZhePICsYtrYy4lHQpp05OAn8AR3Bz58tAQem3Rf
         j3Yg==
X-Gm-Message-State: AJcUukfA8CNGmIJWHXnQNPBI2gZRUMUg4yNUYDKJf+2C/X6OVbM1cvsb
        K76K9sL897N+rcPMptZlob7PJZkUvacweblfu9Qwng==
X-Google-Smtp-Source: ALg8bN4UjGgpHmzhVyFTA90cafWI7RP8tqzexYYEF5Her9ee2/dEZq/9jHB3Hr5VlxZ3EGNZvYhIm4dIh1v0AMgKLkU=
X-Received: by 2002:a24:ce42:: with SMTP id v63mr4024709itg.136.1546724692038;
 Sat, 05 Jan 2019 13:44:52 -0800 (PST)
MIME-Version: 1.0
References: <20190105212118.61022-1-olof@lixom.net> <CAHk-=wiwLK8uPuzh3OABUHHi9D4PO5+fPaizRnviGno5oGevbA@mail.gmail.com>
In-Reply-To: <CAHk-=wiwLK8uPuzh3OABUHHi9D4PO5+fPaizRnviGno5oGevbA@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Sat, 5 Jan 2019 13:44:41 -0800
Message-ID: <CAOesGMiwwzmPmbraG5WHjN8kek-3K4GSkrQCh-4Kq-orG-NXaw@mail.gmail.com>
Subject: Re: [PATCH] lib/genalloc.c: include vmalloc.h
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Huang Shijie <sjhuang@iluvatar.ai>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Skidanov <alexey.skidanov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 5, 2019 at 1:35 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Jan 5, 2019 at 1:21 PM Olof Johansson <olof@lixom.net> wrote:
> >
> > Fixes build break on most ARM/ARM64 defconfigs:
>
> Interesting.
>
> Andrew, I thought ARM was one of the platforms that your tree compiled
> against? Or was some other change just hiding this?
>
> Anyway, I'll apply as soon as the previous build test finishes.

Looks like the patch might have been queued pretty recently, I don't
see it in the Jan 3 linux-next tree.

I'm not familiar with Andrew's patch queues, but it seems to be there
in the 'mmots' (Jan 4), but not in 'mmotm' (Dec 22).


-Olof



-Olof
