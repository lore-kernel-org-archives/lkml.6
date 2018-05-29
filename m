Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033248AbeE2BsX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 21:48:23 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52537 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935149AbeE2BsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 21:48:21 -0400
X-Google-Smtp-Source: AB8JxZpj042dHx0Tbn1axYDYMyisNwy151y7n022sShDFyGZBbQUrFVAqTfHgSVlaDKOSrqCOUWJ6AZ8K8AoU/b0QXw=
MIME-Version: 1.0
In-Reply-To: <20180526055601.GA26155@kmo-pixel>
References: <20180523011821.12165-1-kent.overstreet@gmail.com>
 <CANQeFDCLc56thuuGYBMdb_qvw_O=t7sLkJiP-LNYfKwgz74H_w@mail.gmail.com> <20180526055601.GA26155@kmo-pixel>
From: Liu Bo <obuil.liubo@gmail.com>
Date: Tue, 29 May 2018 09:48:20 +0800
Message-ID: <CANQeFDBGzxF0r-+dxp5jcRnOCe8NgEzRgmc-84bGRBqiYg5KhA@mail.gmail.com>
Subject: Re: [PATCH 1/6] Generic radix trees
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, willy@infradead.org,
        gregkh@linuxfoundation.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, dev@openvswitch.org, shli@kernel.org,
        linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2018 at 1:56 PM, Kent Overstreet
<kent.overstreet@gmail.com> wrote:
> On Sat, May 26, 2018 at 11:16:42AM +0800, Liu Bo wrote:
>> > +/*
>> > + * Returns pointer to the specified byte @offset within @radix, allocating it if
>> > + * necessary - newly allocated slots are always zeroed out:
>> > + */
>> > +void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
>> > +                          gfp_t gfp_mask)
>> > +{
>> > +       struct genradix_node **n;
>>
>> Any reason that " struct genradix_node ** " is used here instead of "
>> struct genradix_node * "?
>>
>> Looks like this function only manipulates *n, am I missing something?
>
> It stores to *n, when it has to allocate a node (including the root)

I see, thanks for the explanation.

thanks,
liubo
