Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC9EC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F8B2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfA1Okt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:40:49 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39847 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfA1Okt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:40:49 -0500
Received: by mail-qt1-f195.google.com with SMTP id u47so18425323qtj.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 06:40:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+Cg6LHIPRoKPYT+mmxHdwfsTOOMr4ZcNvCpfOK62+g=;
        b=BiQEAgpnHr7dmkb4y2jDeLyfx+SrA5tbFMTRo3OTOYxVHvyNC0FjPhVDHIGtGi1w+O
         6FPwkmfqCzFD9wlnMxlcdeYHVZAB3UwOqe7Tlg4DN8cElBwkySKAZ3sJeEb9ajOpwdic
         i6sI+zir/NwsdtLXb5Nb+NGXrXPJUhjrRVxrnN5qwFCAvONOb+wzbloxLbd27zqgSBwS
         HKY5t8OGbuz6Py3TD+DGsJHF1eLDJcevMNUkjhZCNT1JelM1HB2cDe44f2K3KKiZOkpj
         P5MwGNA2L+U3gRLz3qGUMtiJFPoI7P/II3FcfGE5/ACHrsrK89zSk0ZNG4QBL4ZH5IAb
         uRjg==
X-Gm-Message-State: AJcUukfkHbZv+9bY60oRj/Ax3lEldr5SZMBYjxInIN7G3TnQ1lCBr+vG
        tEfIzoBOKbcDdJARPI/9zVAfJGLvv2r/uFtYogs=
X-Google-Smtp-Source: ALg8bN62mXzF8CreXezvMpsigikFdhs8DpXINcfVx5Zki9GNadMso/9/Y+yCy8ZLPSBrk6ukafj+dPo2se9LlV2Aa1M=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr20661832qtm.96.1548686448016;
 Mon, 28 Jan 2019 06:40:48 -0800 (PST)
MIME-Version: 1.0
References: <20190125104353.2791-1-labbott@redhat.com> <CAK8P3a0xnc7RNbGhG7-hj+ay2keR7dh7MmDiUNKxfewsnatsgA@mail.gmail.com>
 <CANiq72=nMYcohMk29fzs3bMut1PXwfqYLZdbRh_AeTN-Z4FpxQ@mail.gmail.com>
 <AM0PR07MB387404F71D25553702966E27E49B0@AM0PR07MB3874.eurprd07.prod.outlook.com>
 <VI1PR07MB486420A106A8BC85BEE9FB2AE4960@VI1PR07MB4864.eurprd07.prod.outlook.com>
In-Reply-To: <VI1PR07MB486420A106A8BC85BEE9FB2AE4960@VI1PR07MB4864.eurprd07.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 28 Jan 2019 15:40:31 +0100
Message-ID: <CAK8P3a1dLz3so3Z5cypOBeQN3GB-nM-RHNaeYOTEvovMrGhBPQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] Update -Wattribute-alias for gcc9
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Sebor <msebor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 2:28 PM Bernd Edlinger
<bernd.edlinger@hotmail.de> wrote:
>
> On 1/25/19 1:24 PM, Bernd Edlinger wrote:
> > On 1/25/19 12:39 PM, Miguel Ojeda wrote:
> >> On Fri, Jan 25, 2019 at 11:58 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >>>
> >>> On Fri, Jan 25, 2019 at 11:43 AM Laura Abbott <labbott@redhat.com> wrote:
> >
> > I believe it is not intentional to break the old syntax of the
> > pragma.  There will be new -Wattribute-alias=1 and -Wattribute-alias=2
> > and -Wattribute-alias is easy to retain as an alias for -Wattribute-alias=1.
> > That is what my patch will do.
> >
>
> Okay, I committed the -Wattribute-alias patch to gcc trunk, now
> as https://gcc.gnu.org/viewcvs/gcc?view=revision&revision=268336 .
> So there will be no need for a workaround on your side.
>
> Also fixed a few false positive -Waddress-of-packed-member warnings with
> https://gcc.gnu.org/viewcvs/gcc?view=revision&revision=268118 and
> https://gcc.gnu.org/viewcvs/gcc?view=revision&revision=268337 .
>
> However there remain a lot of warnings from -Waddress-of-packed-member,
> that look more or less valid, has anybody an idea how to handle
> these?

The best idea I have is "one at a time", which unfortunately
does mean a lot of work. We can degrade the warning to the
W=1 level in the kernel by disabling it by default and re-enabling
it in scripts/Makefile.extrawarn, but we probably want to address
many of them anyway. Looking at the most common examples
(listed by number of instances in Laura's build log)

     64  warning: taking address of packed member of 'struct
scif_window' may result in an unaligned pointer value
[-Waddress-of-packed-member]

Structure should not be packed at all, it's kernel internal (I hope at least,
since it contains pointers to kernel structures), and packing it does lead to
unaligned accesses.

     71  warning: converting a packed 'struct desc_struct' pointer
(alignment 1) to a 'u32' {aka 'unsigned int'} pointer (alignment 4)
may result in an unaligned pointer value [-Waddress-of-packed-member]

'__packed' does not seem to be required here. This is a structure of bit
fields, which IIRC means the layout is architecture dependent, but
it is fully packed already.

     76  warning: converting a packed 'struct opa_smp' pointer
(alignment 1) to a 'struct ib_mad_hdr' pointer (alignment 8) may
result in an unaligned pointer value [-Waddress-of-packed-member]

We cast the pointers multiple times, from aligned to packed and back to aligned,
so I assume there is no bug, but it's unclear why the structure was ever marked
as packed.

     81  warning: taking address of packed member of 'struct
adf_accel_dev' may result in an unaligned pointer value
[-Waddress-of-packed-member]

Should clearly not be packed.

    122  warning: taking address of packed member of 'struct
fc_els_flogi' may result in an unaligned pointer value
[-Waddress-of-packed-member]

I'd suggest changing it to only mark the unaligned members as packed,
not the structure itself.

    182  warning: taking address of packed member of 'struct
rtl818x_csr' may result in an unaligned pointer value
[-Waddress-of-packed-member]

Cannot be packed, since this is an mmio structure, need to
carefully rework structure layout in case there are some packed
members we never access.

   138  warning: taking address of packed member of 'struct ib_reth'
may result in an unaligned pointer value [-Waddress-of-packed-member]
    414  warning: taking address of packed member of 'struct
ib_atomic_eth' may result in an unaligned pointer value
[-Waddress-of-packed-member]

I suppose ib_u64_get should take a packed argument, it already uses
get_unaligned_be64()
internally to avoid bugs.

       Arnd
