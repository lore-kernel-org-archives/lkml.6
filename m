Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D449C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3688E2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K0BPN59H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfBVA5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:57:16 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35053 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfBVA5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 19:57:16 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so282577pgs.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 16:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/JBr39IHozT6VTj980ITZxX+RN+G33DmdearHzM4GEI=;
        b=K0BPN59HFCPhaDqTbkwetb4Ry3p6DPHgSsfth1HlmR1tvrWBxKx3zrJLx0UzrzJ2Bo
         TTI34iRX6dGg4uEnSk9NdYGSXzTXVNQg6UFt1hq5uk9RTswI0OAcieX+m6UZ+wwGWHjZ
         tsac/UrwcA1I7mA1EDaHtigvWq7yExoDySazigFO2JmPVCykORoO/jji786EiijpdpyK
         vuIGjMzXMJfahNbdIurOO33UWytFXWNDO+VUQuUvgDV9utz+wLzxRKfu9q2iUoPeOZV2
         CKbqIy5JSTONI8aabCNGRUSOhKniaBX4XlFxUJyWrdHkUAOGfif/NIeCMW4vg86m+wkx
         q9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/JBr39IHozT6VTj980ITZxX+RN+G33DmdearHzM4GEI=;
        b=qe0fWwPOu/OIyRvVzkp2Xo/BtIjavJIpqBTvXZJvr3MqC09VxWnQSkDOH0yEtW90eO
         tPgn+M48R1BvUBBdwmGIooySi6lJL9lxG6GVAs3uQXOFCJSKysdFMOxegQh8Z7XOPbq2
         xHgFbUd8lAPWjJ5P5wt+6nsXAgjBmGo9byPujKcMcOng+7vhYIYWWhucqtR/Ss5LglF8
         ntZciuCbf9/EJf7ByqqCvcaagWCbx5ewU34mFE4YVGLcT1L7QPYkwskguFthliC/qStF
         Rw2fX3hcxvdS93DK5VF3zXRqa1wt0QHOPTtlI0AD2digaG0pJmTqsKAtyKlUtfCRvfv1
         1+gA==
X-Gm-Message-State: AHQUAuagmAk3CVqiO97uVj3aUGvvwjb0NRZwMG3p56NsBa0uEhCLzUkB
        Mf86rf34tCwIO8WVfO3fwyv7nvZIOrBGpfOziwsj0w==
X-Google-Smtp-Source: AHgI3IbnOwIjjSOjDdEWGZ2p4k683XNSGEYLRtzK/Hg8viQP4IoTmJjUq1R5m6iiQsItMo9b5TNI2yYlUSVIR9dcY/8=
X-Received: by 2002:a62:e704:: with SMTP id s4mr1418213pfh.94.1550797035170;
 Thu, 21 Feb 2019 16:57:15 -0800 (PST)
MIME-Version: 1.0
References: <20190122233749.42220-1-trong@android.com> <CAKwvOdm1+P-8YqtgZV65EAMnVN-n1mkpOOX0yp-qEbuCH5F9Rw@mail.gmail.com>
In-Reply-To: <CAKwvOdm1+P-8YqtgZV65EAMnVN-n1mkpOOX0yp-qEbuCH5F9Rw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 21 Feb 2019 16:57:03 -0800
Message-ID: <CAKwvOdnkTBw26Nq4TpN1=jepLriKUZ4bJVTi0PR9Rwmx97_3Mg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] gcov: add Clang support
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Greg Hackmann <ghackmann@android.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Tri Vo <trong@android.com>, Mark Brown <mark.brown@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 4:52 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Tue, Jan 22, 2019 at 3:38 PM Tri Vo <trong@android.com> wrote:
> >
> > This patch series adds Clang supoprt for gcov.
> >
> > Patch 1 refactors existing code in preparation for Clang support.
> > Patch 2 implements necessary LLVM runtime hooks and gcov kernel interfaces.
> > Patch 3 updates documentation.
> >
> > Greg Hackmann (2):
> >   gcov: Clang: move common GCC code into gcc_base.c
> >   gcov: Clang support
> >
> > Tri Vo (1):
> >   gcov: docs: add a note on GCC vs Clang differences
> >
> >  Documentation/dev-tools/gcov.rst |  18 +-
> >  kernel/gcov/Kconfig              |   3 +-
> >  kernel/gcov/Makefile             |   5 +-
> >  kernel/gcov/base.c               |  84 +----
> >  kernel/gcov/clang.c              | 555 +++++++++++++++++++++++++++++++
> >  kernel/gcov/gcc_base.c           |  86 +++++
> >  kernel/gcov/gcov.h               |   3 +
> >  7 files changed, 665 insertions(+), 89 deletions(-)
> >  create mode 100644 kernel/gcov/clang.c
> >  create mode 100644 kernel/gcov/gcc_base.c
> >
> > v2:
> > - Reorganized config dependencies, as per Masahiro.
> >
> > v3:
> > - Squashed patches 2-4 of v2, as per Nick, Masahiro, and Peter.
> > Addressed comments by Peter:
> > - Moved __gcov_exit() to gcc_base.c
> > - Added missing header to gcc_base.c
> > - Removed unnecessary boundary checks in gcov_info_add().
> > - Changed counters' allocation to use vmalloc().
> > - Added check for failed allocation of filename.
> > - Changed list_for_each_entry_safe to list_for_each_entry when traversing
> >   without modifying.
> > - Updated Documentation/dev-tools/gcov.rst
> >
> > --
> > 2.20.1.321.g9e740568ce-goog
> >
>
> Bumping this thread for review.
>
> --
> Thanks,
> ~Nick Desaulniers

Bumping for review; KernelCI is ready to enable clang builds.  This is
the final build error for arm64 allyesconfig + clang.

-- 
Thanks,
~Nick Desaulniers
