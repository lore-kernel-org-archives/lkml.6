Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3734C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 09:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E2020665
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 09:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0EX6bwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E2020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbeJ0RvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 13:51:03 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39283 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeJ0RvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 13:51:02 -0400
Received: by mail-ot1-f67.google.com with SMTP id d5so3284626oti.6
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 02:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=shLWQupJ6k219v4fX+tZHn2CcxSnWDddNSlw9jXYVL4=;
        b=p0EX6bwLYTsobmc5bsQ0xnVBRnm8Y/rGOBrjCxsmZNjEOUV9gBghMwF8VtUWjTLUrb
         RaPpauVhHVNISrXKfljhlRVDFEZf6D81zkYQx1Btiw3M/XMCw7COrqi8MgOrM3osW59a
         TToK++1MRrHrLB5wVIKvTFCv01D6RNX7ibS/DSwAtQWa7CmaS7Cb0vZU052C71TKPsaf
         fIpO+AMw8wDzNolVNUXvXBF9WKoI5r2+ksYERDI8pDBItA240/evVpmDTVYCeGtGVqxo
         W/IjI341sy0UJ6RQjJfZ8/BuGdPqpsjFqpCkz5XxzFDT9PC9PbZVFlTm+KzFanuF3jrt
         KIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=shLWQupJ6k219v4fX+tZHn2CcxSnWDddNSlw9jXYVL4=;
        b=UMk3ecvpK8xHwliAD/7Np0f0yjE7AOdu/BO+4eOHOAi6sB+gkmBndLWaUrJvVfD/3Y
         aND9P9AcdjjcgykhXxr2o3nw2JQ88VwHIGOOMIAjzkg1jsL7BaHW7Z+JXEP6GDvztbPp
         /pMgq9RvG58Wp55PW2RYfP1dSxzdt/456LGPhSF7HiY5dOMOqTmVtQxjOXOIYgeBdxNs
         IzjQs8iRjQPhXn6BAKrawZ/HDTfelJJI7sO1fEREGTke+x0hnDNVHPFbgGuzgSEOAEiG
         XQBvNqrR4ESdE+4M86pCGHhjT+OaQPrWo78aJJ9yaB579U/HVzVjNpdQMIFT4FmGSfBQ
         0NEA==
X-Gm-Message-State: AGRZ1gJPERKaL/krk68+5bgO4ka/5TiyUHS4urz5mx3N53IUN0IuvoGS
        idAFGV/UIs7bYyfTaX/jYRlNAH7+yM/S69t7esw=
X-Google-Smtp-Source: AJdET5doNGyP5Zzj2XjDI4OGuGSyQOweGk7NtpKogeYCNaKuQa8wLDRMeh2uD/xNjr3hweMWJ2/pcD5KazvOJHTb80I=
X-Received: by 2002:a9d:7383:: with SMTP id j3mr610274otk.117.1540631445622;
 Sat, 27 Oct 2018 02:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAEn-LTqbEmWovu4t7Rs4C211+GRRU4V3B=+WmW0SOhX_b8db5Q@mail.gmail.com>
 <20181024204036.8799-1-palmer@sifive.com> <20181024204036.8799-2-palmer@sifive.com>
 <20181027074613.GA7868@infradead.org>
In-Reply-To: <20181027074613.GA7868@infradead.org>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Sat, 27 Oct 2018 11:10:34 +0200
Message-ID: <CAEn-LTq8i4FFU15Gn_zm_mwUzgp6i5dGCgKmbXju9qwBny+QhQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Move EM_RISCV into elf-em.h
To:     hch@infradead.org
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        aou@eecs.berkeley.edu, Will Drewry <wad@chromium.org>,
        Paul Moore <paul@paul-moore.com>, gregkh@linuxfoundation.org,
        wesley@sifive.com, linux-kernel@vger.kernel.org, eparis@redhat.com,
        luto@amacapital.net, dhowells@redhat.com, linux-audit@redhat.com,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-riscv@lists.infradead.org, tglx@linutronix.de,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2018 at 9:46 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Oct 24, 2018 at 01:40:35PM -0700, Palmer Dabbelt wrote:
> > This should never have been inside our arch port to begin with, it's
> > just a relic from when we were maintaining out of tree patches.
> >
> > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>
> Looks good, and probably harmless enought that we should pick it up
> for this merge window:

That would be nice. The audit parts I am working on depends on this patch.

Tested-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
