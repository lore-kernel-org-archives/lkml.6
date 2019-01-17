Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC9DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3070820855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wD0BBTiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbfAQVar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:30:47 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37256 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfAQVar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 16:30:47 -0500
Received: by mail-pf1-f195.google.com with SMTP id y126so5453722pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 13:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KD0cIMypRNFWGhod3QICd/CALDbA8g2R453skt9CpHE=;
        b=wD0BBTiyT+I660LGZbYLe551jrp+KtoszUFtEITbuLcfy92kQm9XR/mLa5RE4pS95V
         dINoObgv390GO9ayLzNFEIMH8n292G6MqITabFKQSu15xjvdhExK6TPH+mglaK0KQZOs
         qWeGKDMU+xy7J41KPgyZXkMYK3sqbnGqBGBSg4R4NvhI8TnoFUzFEm3wqw8qo9Ip6Amt
         IT4gh3FFXIZ7CY0+grvkMT1CCH+333BpVwhOeKFA9kI9NZrzHW6GuVCxcDx5c0nY6qdi
         Y7gQndwsf2DaY3X1AjUOx6G2UDzV8Lq2jncxbjA7T0HHj77+HP2ea2sFLfrdILbIvfAl
         Gr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KD0cIMypRNFWGhod3QICd/CALDbA8g2R453skt9CpHE=;
        b=JRMwYQUlzK3ZjnqtXuRgYhI0bFwfC6V3EqD3D3ERkIok84K0Bk5edv9d4u4FkXU35y
         +1Sxr+5v4Cd6h1gwSOf90QBs4NBO1CkSebuU+KP8qxzno0Vq7vPwX+1PEnAaHZv//SMo
         5n9zuvJAPx3qdvM5v2qI2rPTrcJIl4vRtXxl8hmeXPKIVnxvGw83axgqLRVQsT9HB1CT
         DzsYzcibkc0tw73ojQNG4pC0U8UUhBdTM33ltGF4m2mR5xfEja0WVYKBC79OFKvxyW9s
         HmkpRzyi1KxoA9xafdqqmCw8TjCIK8ofk5L/T65FGhS4ZV16yTRHq7r9l+3BXs1b6PLj
         dUeA==
X-Gm-Message-State: AJcUukees3vzgWFp3+ESKhfH926nuRfVE4DichxIH4nQbAv9m0zpPSwt
        Wo92U6DQ7oWm/iaaQnJ2Ip5CDmkSTjp/9NQTgNoWdg==
X-Google-Smtp-Source: ALg8bN6Jir/WJnCb/hEMi0FtIWFaE6P5N6MiVjBwgxQ+HRqReRJqjRb9tl9/JDdHIiIfTc61j5jnpunlMFSy6470nxA=
X-Received: by 2002:a63:bf0b:: with SMTP id v11mr15258421pgf.302.1547760646048;
 Thu, 17 Jan 2019 13:30:46 -0800 (PST)
MIME-Version: 1.0
References: <20190115183643.120619-1-trong@google.com> <65bb2ab8-4929-db7c-9d54-491d87ec23ae@linux.ibm.com>
In-Reply-To: <65bb2ab8-4929-db7c-9d54-491d87ec23ae@linux.ibm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 17 Jan 2019 13:30:34 -0800
Message-ID: <CAKwvOdnkmnuNNVRx4cTUca7J7aFwzqH---+vmP8Cr3j55qaC6g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] gcov: add Clang support
To:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Tri Vo <trong@android.com>
Cc:     Greg Hackmann <ghackmann@android.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 7:17 AM Peter Oberparleiter
<oberpar@linux.ibm.com> wrote:
>
> On 15.01.2019 19:36, Tri Vo wrote:
> > From: Tri Vo <trong@android.com>
> >
> > This patch series adds Clang supoprt for gcov.
> >
> > Patch 1 refactors existing code in preparation for Clang support. Patches
> > 2-3 implement necessary LLVM runtime hooks and gcov kernel interfaces.
> > Patch 4 simplifies config selection.
> >
> > Greg Hackmann (2):
> >   gcov: clang: move common gcc code into gcc_base.c
> >   gcov: clang support
> >
> > Nick Desaulniers (1):
> >   gcov: clang: link/unlink profiling data set.
> >
> > Tri Vo (1):
> >   gcov: clang: pick GCC vs Clang format depending on compiler
>
> Overall this patch set looks good to me. It introduces a clean way for
> GCC and Clang specific implementation details to coexist.
>
> A quick test compile using GCC on s390 with the patch set applied was
> successful, so it seems like the existing support is unaffected.
>
> There are some detail suggestions on patch improvements that I'll post
> in separate e-mails.

Peter,
Thank you so much for the valuable code review and feedback.  We'll prep a v3.

Tri,
I think you should change the authorship for the patches to yourself,
and add a "Co-authored-by: " tag to the commit messages.  Can probably
squash this series into 2 patches; the one that separates out the
shared code; and the new llvm additions.  WDYT?
-- 
Thanks,
~Nick Desaulniers
