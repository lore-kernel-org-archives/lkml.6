Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF710C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 21:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB1E20869
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 21:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UlE4B7+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeL2VdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 16:33:05 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42853 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeL2VdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 16:33:05 -0500
Received: by mail-yw1-f67.google.com with SMTP id x2so9480481ywc.9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 13:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IYFvICSJkCQtftzZlZjdaG+P5ndvp4JYx4OmGQFlpEk=;
        b=UlE4B7+FiIiMBKb3LEHrxeyseaMIlTqJrh/POxLF2jVXJLe80F0OZep8hAz8GMy9m+
         BAmArypN4990a8PK/Plt4jlecmt5oTcIU6wX3G0GFK4bEtgdG1l3/zBURqY+LEGtvYr2
         HvXY1s2eqBM44LdZW85DiTOfMveSvrXUwkW5qJko19AaG+0lcPBPKoccgpgJTkJdk0mj
         BpKzLkrBWMiR4fnCkXfzd88D0TQWNjtHmrTxxU8ClS5OMBZ6sxNeduzoL+r6zc/PislS
         JYoUjVhtP66I9pt15Fasip3PvIvqd3WE+lgpMQGjf8tAAXuEEvTow9W8dOirN43KZAKk
         ijZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IYFvICSJkCQtftzZlZjdaG+P5ndvp4JYx4OmGQFlpEk=;
        b=rJSMT6QwEBvdv2ems5Wr90GsejHpH4EPV4STe7LfDbZrgX2mBJnC34lXhIS54P9q8w
         ff+3XWkAcQYiOzy6bQJyn5Uz7oA3MH6Fqvj6aWgJ8TnLmMo/oHbb4KXm0/Ywf49o33cy
         CCo1cL0Q8tYWYoCc/zEX62dWmRBZ8O7XFNdUQ6L2AGVysRm/KAb0tnf3ObUd3P+5IHMS
         kNxwYsXPQAQQ4vzofe003jqT8U+H42J8W2wOjH2msVAqjo7gFSp5Ka65IFrZG252k+L9
         fBRk8WuCgPSV5DpKtxfFQ3Rss7PcFKiDrE6gVgKDBa/6Nqq139gsiY0P/PmuOk0Mo/sk
         ybrA==
X-Gm-Message-State: AA+aEWZGm8O4xuY67HG1iPzavblJJvY62cF+vujE02e417LMLJbgZcNZ
        fCHR+wq953maFFXz+R0odNgpBZkO8zaR/wNM+fdcBS3ptss=
X-Google-Smtp-Source: AFSGD/UpJWc5KqV55JRDLH8Ip/Q/CegVG7mhQ75txjoDgXsGHPFBGvKlqCmlh9dH/QJ9C62pyi9ux0/zsKlj/DJ0fMM=
X-Received: by 2002:a81:29d5:: with SMTP id p204mr32577434ywp.285.1546119184209;
 Sat, 29 Dec 2018 13:33:04 -0800 (PST)
MIME-Version: 1.0
References: <20181229013147.211079-1-shakeelb@google.com> <20181229130352.8a1075da5b7583d5e0e4aa9a@linux-foundation.org>
 <20181229212619.GB73871@dennisz-mbp>
In-Reply-To: <20181229212619.GB73871@dennisz-mbp>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 29 Dec 2018 13:32:53 -0800
Message-ID: <CALvZod6SPOUA-kx8g6s+HXXGQ3gJ5FPc=hjpWs7ZBpJi472xbQ@mail.gmail.com>
Subject: Re: [PATCH] percpu: plumb gfp flag to pcpu_get_pages
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dennis,

On Sat, Dec 29, 2018 at 1:26 PM Dennis Zhou <dennis@kernel.org> wrote:
>
> Hi Andrew,
>
> On Sat, Dec 29, 2018 at 01:03:52PM -0800, Andrew Morton wrote:
> > On Fri, 28 Dec 2018 17:31:47 -0800 Shakeel Butt <shakeelb@google.com> wrote:
> >
> > > __alloc_percpu_gfp() can be called from atomic context, so, make
> > > pcpu_get_pages use the gfp provided to the higher layer.
> >
> > Does this fix any user-visible issues?
>
> Sorry for not getting to this earlier. I'm currently traveling. I
> respoeded on the patch itself. Do you mind unqueuing? I explain in more
> detail on the patch, but __alloc_percpu_gfp() will never call
> pcpu_get_pages() when called as not GFP_KERNEL.
>

Thanks for the explanation. Andrew, please ignore/drop this patch.

thanks,
Shakeel
