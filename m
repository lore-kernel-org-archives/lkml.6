Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68095C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AA12175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4tt9Xl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfBGSYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:24:32 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:50661 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfBGSYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:24:32 -0500
Received: by mail-it1-f196.google.com with SMTP id z7so2220558iti.0;
        Thu, 07 Feb 2019 10:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GSV2LQG+lWhDx3WuQlPnDqjNLUxiRSIbPBxs0j2pqEQ=;
        b=D4tt9Xl8RMZfEBJUSY1NnDIs/BFYSevDHg2mY+dG9eQ2ZHZgynSrl2XdodGdO9a6x9
         ZA2SjoEJUihrHHlqwhuQKjs28ZBUzveFMQiohWlMm0WQB05bTEI5plEyosoKdeJHrHA+
         zNnFGKEHG06YGJTqAaSokv6je2OqgepcONMQLiZXwUFbFiTcp/UpL3KxDAjHWCnZpr3d
         Tb+tNMmLittJfRFljziWOmEcrtLJHGlsA6vnWT0JAo1QKAT4QjZYpEiXv09Hin+h+Xbl
         IATNItJBzMVO+12ZWpNy23rQ7p2zF3NeaC8fKiuPC8+1MAQABNETPHOoumIULFy8+1CK
         5Rgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GSV2LQG+lWhDx3WuQlPnDqjNLUxiRSIbPBxs0j2pqEQ=;
        b=CRyDKIp5s6hezJnLweNa7969kZylsZG4bA0xonXBOGWrRD8uvg3j7b7m3DNaEScIUL
         4rrgIyhxzeXgV2OtB9dNDIq/HZVjbGh+4qMFYfDlCmbZ9+7Lt+f6B4i2Xepo8EMpkaGA
         k/URna6Nblmde7Atyjo1PjYqH7OSoIFFQehY5glFJGcNmB4ARYsXPbWl4rWQXlhUguCG
         Axz5kNWBKgUU8GuEL9v1gyk707WNMhOgkQuJiEKBtgO8dE8I5r9Qj0o5t6OUSH05kupF
         PoowYwNfjUwK+Q42eMf4J2zopyaNZ9S78GPGSqrHvlxH6E5kXZgoI+93AfOYSFtnlNGs
         umpg==
X-Gm-Message-State: AHQUAuYckx5p+1naw8ncOYTnvjEKOCfU+76iM2EtqhGZFNdsFFxueNNF
        XOVBbilm0nm8z5L6TRX0BaXnDarS0C+evegQUdU=
X-Google-Smtp-Source: AHgI3IbhVhcsA5tOy4lp+8JL804wjqnbOHlGiLL+KGIV+MURGXLU8AxD+/I8grcKYda1dQRoH69YrtnSZ8Djmwi0NyY=
X-Received: by 2002:a02:76d8:: with SMTP id z207mr6504585jab.114.1549563870920;
 Thu, 07 Feb 2019 10:24:30 -0800 (PST)
MIME-Version: 1.0
References: <20190204201854.2328-1-nitesh@redhat.com> <20190204201854.2328-5-nitesh@redhat.com>
 <CAKgT0Ud0-A8MmbSFQTd81X5-ezwtsi67qPLa0uC_MUs4r+bxqw@mail.gmail.com> <97de9a69-fb19-3e9e-d88d-b5b8219b0d9f@redhat.com>
In-Reply-To: <97de9a69-fb19-3e9e-d88d-b5b8219b0d9f@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 7 Feb 2019 10:24:20 -0800
Message-ID: <CAKgT0UeY84gRSK4McRDLzBH6eHP14rOKB9snccbYzx4VFChhJQ@mail.gmail.com>
Subject: Re: [RFC][Patch v8 4/7] KVM: Disabling page poisoning to prevent corruption
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>, riel@surriel.com,
        david@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
        dodgen@google.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 9:56 AM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
>
>
> On 2/7/19 12:23 PM, Alexander Duyck wrote:
> > On Mon, Feb 4, 2019 at 2:11 PM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
> >> This patch disables page poisoning if guest page hinting is enabled.
> >> It is required to avoid possible guest memory corruption errors.
> >> Page Poisoning is a feature in which the page is filled with a specific
> >> pattern of (0x00 or 0xaa) after arch_free_page and the same is verified
> >> before arch_alloc_page to prevent following issues:
> >>     *information leak from the freed data
> >>     *use after free bugs
> >>     *memory corruption
> >> Selection of the pattern depends on the CONFIG_PAGE_POISONING_ZERO
> >> Once the guest pages which are supposed to be freed are sent to the
> >> hypervisor it frees them. After freeing the pages in the global list
> >> following things may happen:
> >>     *Hypervisor reallocates the freed memory back to the guest
> >>     *Hypervisor frees the memory and maps a different physical memory
> >> In order to prevent any information leak hypervisor before allocating
> >> memory to the guest fills it with zeroes.
> >> The issue arises when the pattern used for Page Poisoning is 0xaa while
> >> the newly allocated page received from the hypervisor by the guest is
> >> filled with the pattern 0x00. This will result in memory corruption errors.
> >>
> >> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> > This seems kind of backwards to me. Why disable page poisoning instead
> > of just not hinting about the free pages? There shouldn't be that many
> > instances when page poisoning is enabled, and when it is it would make
> > more sense to leave it enabled rather than silently disable it.
> As I have mentioned in the cover email, I intend to reuse Wei's already
> merged work.
>
> This will enable the guest to communicate the poison value which is in
> use to the host.

That is far from being reliable given that you are having to buffer
the pages for some period of time. I really think it would be better
to just allow page poisoning to function and when you can support
applying poison to a newly allocated page then you could look at
re-enabling it.

What I am getting at is that those that care about poisoning won't
likely care about performance and I would lump the memory hinting in
with other performance features.
