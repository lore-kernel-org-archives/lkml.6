Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9239FC169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B572217F9
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PB8rm1Ht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfBGAxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 19:53:11 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44616 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfBGAxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 19:53:10 -0500
Received: by mail-pl1-f193.google.com with SMTP id p4so3949176plq.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 16:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1gX5DWBQE0VrtFnTcpfav0a1htXROoYyWvirJBXeojg=;
        b=PB8rm1HtKJ6kJUE+ft+hqKaiIl8VDIsjqYNswocEba8eHRpl9VzqgdkNWREgrW9LZl
         4Dob8ZCEeQ3gTr3mtk+Xfr8NUmDeeiGwjnSddyd/yvnr+oSYtRMfSX8JubMtQ83my3/3
         l/L4Q93JpPkiUN5uUxpXNdylrWENwUGcTsU2nu3u59khpTlR5rUjoYIFHxlDdPsU2nsH
         LPJAk4+ajtSIONJ+3KC9Y4yErZXUhV3WsopIEVu7owZm7R+BAl0HY/sQaGasgbLkZhLp
         jiKlWVdOxuVSXyEnrwoIOiPunuEHxM1YMqSPaUzPnmZ+URtljtxlzrJ5fCLx5o0U16UH
         DyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1gX5DWBQE0VrtFnTcpfav0a1htXROoYyWvirJBXeojg=;
        b=CyaGJp/1GFIQG9U6u1OaKVWqf7KjEmGW+sts/vpMXki0zLsqSuIBrVFD6L397HeMFX
         PJgk27/Pvexmms9Nv1JzaauA6cbZqhouoVNtsNDe7L5r6/WC8JT08NYr4TH5beUBHS2G
         jhDoz5pYv02CA7CQX6Da3ZNhjsaXKaC/9AZ1Vr2OqJg3EJLWboVFa46r1eXpMvj+IYV+
         KJGtXA4LTfTpi/HxrJBNiJZMacFMlIlKeeRjcqvlBfqDnKboLXwGkg7hzpUmUWjHX9S+
         S0UGtued4vvN4t+qOW63i7irgpbTlSeS7OUNE3Tl/2KwuflgM81vmDrGavyjitheObet
         RQTw==
X-Gm-Message-State: AHQUAuYrZfkev/CWFce+q51gUHeAt6OXFnYgLWC6ktOfhayprzgxtIRM
        WWvKumcjSjiBYrxBCkhlLqE15K8ZEEwtsBV6oFFbnA==
X-Google-Smtp-Source: AHgI3IbhGJaLaRguSzWT4yuVONPO/oxyLUSy7WnDME8fW10p6mjsMhqvPyU4MC0jyQrK6Eyt9rlBtsrDyWK9Sx6kWdo=
X-Received: by 2002:a17:902:29ab:: with SMTP id h40mr13616022plb.238.1549500789630;
 Wed, 06 Feb 2019 16:53:09 -0800 (PST)
MIME-Version: 1.0
References: <20190122233749.42220-1-trong@android.com>
In-Reply-To: <20190122233749.42220-1-trong@android.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 6 Feb 2019 16:52:58 -0800
Message-ID: <CAKwvOdm1+P-8YqtgZV65EAMnVN-n1mkpOOX0yp-qEbuCH5F9Rw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] gcov: add Clang support
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Greg Hackmann <ghackmann@android.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Tri Vo <trong@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 3:38 PM Tri Vo <trong@android.com> wrote:
>
> This patch series adds Clang supoprt for gcov.
>
> Patch 1 refactors existing code in preparation for Clang support.
> Patch 2 implements necessary LLVM runtime hooks and gcov kernel interfaces.
> Patch 3 updates documentation.
>
> Greg Hackmann (2):
>   gcov: Clang: move common GCC code into gcc_base.c
>   gcov: Clang support
>
> Tri Vo (1):
>   gcov: docs: add a note on GCC vs Clang differences
>
>  Documentation/dev-tools/gcov.rst |  18 +-
>  kernel/gcov/Kconfig              |   3 +-
>  kernel/gcov/Makefile             |   5 +-
>  kernel/gcov/base.c               |  84 +----
>  kernel/gcov/clang.c              | 555 +++++++++++++++++++++++++++++++
>  kernel/gcov/gcc_base.c           |  86 +++++
>  kernel/gcov/gcov.h               |   3 +
>  7 files changed, 665 insertions(+), 89 deletions(-)
>  create mode 100644 kernel/gcov/clang.c
>  create mode 100644 kernel/gcov/gcc_base.c
>
> v2:
> - Reorganized config dependencies, as per Masahiro.
>
> v3:
> - Squashed patches 2-4 of v2, as per Nick, Masahiro, and Peter.
> Addressed comments by Peter:
> - Moved __gcov_exit() to gcc_base.c
> - Added missing header to gcc_base.c
> - Removed unnecessary boundary checks in gcov_info_add().
> - Changed counters' allocation to use vmalloc().
> - Added check for failed allocation of filename.
> - Changed list_for_each_entry_safe to list_for_each_entry when traversing
>   without modifying.
> - Updated Documentation/dev-tools/gcov.rst
>
> --
> 2.20.1.321.g9e740568ce-goog
>

Bumping this thread for review.

-- 
Thanks,
~Nick Desaulniers
