Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7BDC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625D820870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfAVLnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:43:02 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35376 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbfAVLnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:43:02 -0500
Received: by mail-qt1-f194.google.com with SMTP id v11so27212548qtc.2;
        Tue, 22 Jan 2019 03:43:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=603TK/Rcsmu8wH6Cor+UA5ZV19dGC8OrsQGD6QPXhSw=;
        b=lS++DeUM1puS1nw0R34OC4CCKZGFN6/aUXQEUHWJqsEIM4iEQoVUQf1JfnKSP0OoE5
         PGjxoEMU59r0QCsPP4pNSXbaTD3xo0ktzcga9YLcp5D+7AKFT9Hr6RaA4yUbYxXZqGi9
         41OuE1xu/xCV1+WtCWmhfH6JArJwAkwFvS3TFMJ2mKSrooVhqwNRs3W0rfWfezUrbI58
         coVELWrC75PXC0TfQ/WZzLTMJyoWT9vcfmWeQOLwDFJOOR0zPALasRbqe6LVUcmG58ZQ
         ZJnxthAe+btpRzdE5HjdiM4M7T2GgwsaTzBSZ8cPt+BsARdP2Zz24RaWZ5ZgIMlMmThM
         TZKQ==
X-Gm-Message-State: AJcUukeU8fMLIGULlxSoIKjN2NabPE7U1zhwzFnear7YP3IdgBOo5a6Z
        ypGoXmh+dfzS2VrxFVeb6Br2bbzbYMlfoCNB/6PaPypb
X-Google-Smtp-Source: ALg8bN5TEN5ljKuIMJKPVPgiC3HhXIVYNV5rzXnwDx7h3CBSWzQmCbSLyaWwKgOLu7CUwsDDXNc0Fw9hLFpBVK4UM9o=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr30181803qtr.319.1548157381066;
 Tue, 22 Jan 2019 03:43:01 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a0Yth+f8AANE6g8c_zE0Zt1CvCdzMDFK=pr8eNqmrBV0Q@mail.gmail.com>
 <20190121191306.ifga5aw5atu2vvb7@brauner.io> <CAK8P3a2CkXJ=giXQgxEcQAeH1Wt8jKc_P+YTOLJpUPVKYU8m9g@mail.gmail.com>
 <20190121202328.rgrv54lybilsvitu@brauner.io> <da262bd9-1de0-eabb-ee44-e0ee152d15bb@kernel.dk>
 <20190121224811.gbvg22vg4kgg4kbs@brauner.io> <CAK8P3a0ej9NcJM8wXNPbcGUyOUZYX+VLoDFdbenW3s3114oQZw@mail.gmail.com>
 <20190122093146.kmckcgdbvo2e7v3c@brauner.io> <20190122103009.vu2a67kviqhcb3cn@brauner.io>
 <CAK8P3a0EW6ZSMoo6FsRQ=XvyhJe50SR7YtpCtuHcPr=JO3fCtA@mail.gmail.com> <20190122105747.6gxvghn7n5dxa65w@brauner.io>
In-Reply-To: <20190122105747.6gxvghn7n5dxa65w@brauner.io>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 22 Jan 2019 12:42:44 +0100
Message-ID: <CAK8P3a0HJX6+1vks=ZCqNymLwWFS+Wt5PPuYnLedpMo=aVSwKA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the pidfd tree with the y2038 tree
To:     Christian Brauner <christian@brauner.io>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 11:57 AM Christian Brauner <christian@brauner.io> wrote:
> On Tue, Jan 22, 2019 at 11:48:12AM +0100, Arnd Bergmann wrote:

> > Do you mean the asm-generic uapi header? In my current series, I do that:
>
> Yes. My idea was to only change pidfd_send_signal's entry to 424 and
> leave the other ones untouched:
>
>  #
>  # x32-specific system call numbers start at 512 to avoid cache impact
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index b77538af7aca..4d86d0787d99 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -740,7 +740,7 @@ __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
>  __SYSCALL(__NR_rseq, sys_rseq)
>  #define __NR_kexec_file_load 294
>  __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
> -#define __NR_pidfd_send_signal 295
> +#define __NR_pidfd_send_signal 424
>  __SYSCALL(__NR_pidfd_send_signal, sys_pidfd_send_signal)
>
> and also leave

Yes, that looks good.

> #undef __NR_syscalls
> #define __NR_syscalls 296
>
> Does that work to avoid the merge conflict or do you need something
> more?

You need to change __NR_syscalls to 425 as well. This will
clearly create a conflict, but then the resolution will be to pick
the correct (a.k.a. highest) number, rather than remembering
to update it manually.

      Arnd
