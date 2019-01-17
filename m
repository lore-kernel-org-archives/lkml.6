Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11A9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B90920851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="fSId3OlQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbfAQQ1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:27:07 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37049 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfAQQ1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:27:07 -0500
Received: by mail-yw1-f67.google.com with SMTP id h193so4062420ywc.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GCtnuy2wQc7XcEmfgziCX/12VRkWcIepbhLq3+KhvFM=;
        b=fSId3OlQHTmCKz49/xyqPpBsz/GmGASJ+5xDgV+qmAXzVIHTtkbXLXFCl+0/oX8Sac
         gKHWswQ+NtYdjQZVvy8bCJQ7bqZnnYUuud0a6KahxnakdwtrOng+WPaYchoWfqJfcrbZ
         vneD4fRn8bhzEgeQXKuxtymRJv7lupubIxjuaB6/ffdgXW3XYMtWZS19Cq5CqMfPcKjl
         D4FcSLGVtqDpic/0VFFCbG2D2ZwbvFhJoEMaG7+JbgFAq2oBwJvEWbuUR+dFVn615LDz
         Ra+Uxs+tk0uMdYEDhE9x+c5GbzpY2C0cmOi+0A3qaSodBVx39epl3qFa7PJZnBmee902
         510g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GCtnuy2wQc7XcEmfgziCX/12VRkWcIepbhLq3+KhvFM=;
        b=ToFovzACDI3PLgdEnAimpSSiGoiY/pFyak5z7QQD5aP4ciEOYMab3CYf1uN8oyT6PE
         HlnsX0OYwPBPdED8SCCwRC77okDMP/MLa3469SgxkXdaOTYtb/m6Qvw5O72QaknkftTV
         G2i4tgg3hCcVdRni/dBOILLgi69Qa0tyurcRuW1cuKra6ry65RgG2sKqk0Lgv5hbS5SU
         dsJdW/xVagMdr1C9nLmYQmD2tFhu6PL4FlJn8WfF9OuogM2e0nlYMrJ2ieoLgfxB+Tw7
         426KOY0TMn+O6f2BEXLKQbd13X98eGFqH6IIm/ZY9/uuOrhN/h1eithkLDpe1r+wZOZA
         axDw==
X-Gm-Message-State: AJcUukfz8GYR9HE0BirlsrFGOGkuHPSWSgaLg+2mcD1tmioIn6xUzEEd
        6Zh/luUBxgUyPrXT9A2AvP37yA==
X-Google-Smtp-Source: ALg8bN7hSZYLuoGRgXCFBL1QPobHL6DYyq5N7rtdEczNnhn4nm3rrhVPLJSECLnNUu9Ln0XqDhLVuw==
X-Received: by 2002:a81:3016:: with SMTP id w22mr13490074yww.30.1547742426071;
        Thu, 17 Jan 2019 08:27:06 -0800 (PST)
Received: from cisco ([2601:282:901:dd7b:f990:e507:9c40:21df])
        by smtp.gmail.com with ESMTPSA id 137sm1004846ywv.108.2019.01.17.08.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 08:27:05 -0800 (PST)
Date:   Thu, 17 Jan 2019 09:27:03 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     shuah <shuah@kernel.org>, James Morris <jmorris@namei.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: Linux 5.0-rc2 seccomp_bpf user_notification_basic test hangs
Message-ID: <20190117162703.GC17449@cisco>
References: <7cd7d5bc-1d69-57f5-4a98-81b036f81682@kernel.org>
 <CAGXu5jLGqXstRCmM1_fxUxn4djs1YLUun2Fc8ExcaN4-CKyELQ@mail.gmail.com>
 <20190117004416.GA17449@cisco>
 <f665bb74-293b-d627-2605-5b8de7671743@kernel.org>
 <CAGXu5jJ0VK4UiOeKTqv_TZSn5aZAVsXjUZgiXD=KFbZ-Ng_+KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJ0VK4UiOeKTqv_TZSn5aZAVsXjUZgiXD=KFbZ-Ng_+KQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 08:12:50AM -0800, Kees Cook wrote:
> On Wed, Jan 16, 2019 at 5:26 PM shuah <shuah@kernel.org> wrote:
> > I am running Linux 5.0-rc2 and not an older kernel.
> 
> Weird. I couldn't reproduce this on 5.0-rc2, but I did see it on a
> kernel without seccomp user_notif. Does the patch I sent fix it for
> you? (And if so, can you take it in your tree?)

I can reproduce it; you have to run it as non-root. I think your patch
is necessary to get it to at least fail. The question is: what should
we do about these tests that require real root? Skip them if we're not
real-root, I guess?

Tycho
