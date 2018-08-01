Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B178C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183CA20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KHht/Elp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183CA20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732279AbeHAXyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:54:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36969 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731342AbeHAXyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:54:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id n7-v6so76475pgq.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 15:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JRs246u5c4CebvXA2UubQST7aEBl17QCYMV2kzXEQY4=;
        b=KHht/Elp4/Av7Unmr2xIRrEMnR9locrCLdZjeSnk9UWur0eZIfb4R8rQaOfFQcwF4i
         Qlv8bMisgr2uM0W5RG9+HlGjT4w7ihzq+Q2ZUbnoO3eGvf3eVc0TqPDYOTMRgBuMa9Qj
         8bqTFFRkARGjkJ/NV6a7BADijacC0FQZeQcAIS/huvZmYwRKBXk95Bk67e3o7wGnnYhQ
         Untilhk3kp7zlnNSORSl0vrMIktMTzHlp85umO2I5sD1UgleulhQYd/KUUleOWGxeZ1j
         ysTQ+qfuNOCT/BiSRHcNq8GHGSEnDQnGGkXjFEcPOK07DtwRrNFayWQKsENENpecjsyu
         6djw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JRs246u5c4CebvXA2UubQST7aEBl17QCYMV2kzXEQY4=;
        b=BWCYHw9JQyzMmJ0rtea95GFLO1M0BIElTYn8nh5wyBSnTKB8QOvWS76q07tnTnUeNx
         Yw0yxDWA3flEINobxfmZ79RUbdKbf2leiThqDFtxW98gI+YktDhBupJvOJ7Q9sw3Icir
         Z3BIznqz114c7PnKeP6KhYE8nCdhEOXmcNOCzyMy0QY8pR4x1Fc3KkAyM1wzAvq/k8V/
         KB3nHb5izirqUbcicEp9gjnJwxJN2dyNye+UFPJ7PqOXa+j2RsF4J69uSwG/W2vISJH7
         H0eRIQXsIIPkZwHUoA1H8gbCk5AxTowPBxvU7M1q1K1rcYDAmfV0cIhAsOoqjYBH3CVE
         QO6A==
X-Gm-Message-State: AOUpUlF2C/OvtQSXD93Xwx1nQq6wmLGKDQvQeBel3qnigzdVses7m6kl
        vDUF6hjjWHtK2f83sH0qTRjLh9SKpeijHICrfuT9zg==
X-Google-Smtp-Source: AAOMgpdvbai6/BDRpaZV50fVD4v0Itk4wc+Xh+BjhBReDFM0WhRd+2YCZxGle2CfxB+cpUeup3vM0uR4gRQQn/9XFkg=
X-Received: by 2002:a63:e914:: with SMTP id i20-v6mr176102pgh.10.1533161204875;
 Wed, 01 Aug 2018 15:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOd=DnrfVcuO8Pg=FBrub1M4A8LzarZbtv6m=JO_r6Ea6aQ@mail.gmail.com>
 <20180801185331.39535-1-ndesaulniers@google.com> <20180801145530.185dab6b47a61842923fc02d@linux-foundation.org>
In-Reply-To: <20180801145530.185dab6b47a61842923fc02d@linux-foundation.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 1 Aug 2018 15:06:33 -0700
Message-ID: <CAKwvOdmHadWqZSLT2DM4D9Kt-EwVHrjuiKy6vYJpVw7Dk=bTKQ@mail.gmail.com>
Subject: Re: [PATCH v2] sh: prefer _THIS_IP_ to current_text_addr
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>, dalias@libc.org,
        linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 2:55 PM Andrew Morton <akpm@linux-foundation.org> wr=
ote:
>
> On Wed,  1 Aug 2018 11:53:31 -0700 Nick Desaulniers <ndesaulniers@google.=
com> wrote:
>
> > As part of the effort to reduce the code duplication between _THIS_IP_
> > and current_text_addr(), let's consolidate callers of
> > current_text_addr() to use _THIS_IP_.
>
> Why not switch everything to current_text_addr()?  _THIS_IP_ is ugly ;)
>
> Several architectures (s390, sparc, sh, ...) do funky things in their
> current_text_addr().  Does the generic kernel.h implementation of
> current_text_addr() work OK on those architectures?

Good question, one I've been mulling over for a few days.  That's
definitely something that I've considered.  Mostly, it comes down to
there being fewer call sites of current_text_addr() than _THIS_IP_, so
it's IMO a smaller change that doesn't require coordinating tree-wide
changes.

What's interesting about current_text_addr() is that while there are
many arch specific definitions, there are only 5 call sites in the
whole kernel (and 4 of them are arch specific).  So unless there's an
arch specific reason to prefer inline assembly over higher level C
(yes, returning the address of a label in a statement expression is
ugly), (it looks like parisc might have a reason, at its lone call
site, see: https://lkml.org/lkml/2018/8/1/1678, TBD), then I don't
think that current_text_addr() has a raison d'=C3=AAtre.  I suspect that
its use predates the GNU C extensions needed for the current generic C
implementation (statement expressions + addr of label) and has just
been reimplemented in every new arch's arch/*/include/asm/processor.h
simply because the other archs had it.

So the plan is to replace the 5 call sites of current_text_addr() with
_THIS_IP_ (if possible), then delete all definitions of the arch
specific current_text_addr()'s.  This can be done on a per tree basis,
rather than a treewide patch for converting _THIS_IP_ (who has many
more call sites) to current_text_addr().  What do you think?

--=20
Thanks,
~Nick Desaulniers
