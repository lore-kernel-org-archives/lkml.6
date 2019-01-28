Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3332C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A134E20989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kfKH+nma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfA1TAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:00:32 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:37958 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfA1TAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:00:31 -0500
Received: by mail-vk1-f194.google.com with SMTP id w72so3914469vkd.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HW28ls7Wx+igmjl+yu70fqcBEBBFWWC4XR6jh21UZYg=;
        b=kfKH+nmaemVN1YLHaFgCdpR8oIM1Il/wC44Xsc3dCbL7K7GWHY/x23uRnB+zY2JwO9
         0goxzN28D1fXTVU7AgBKBinIv1rd824L7tNtIe/DlAN6O4P8Sil7cwq77F0jP6G83wJ7
         6/t4SE/k8w1Hl1+2IJGM1jRzyCkgua/nCMkPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HW28ls7Wx+igmjl+yu70fqcBEBBFWWC4XR6jh21UZYg=;
        b=gC23AxRXPcF+lkbzEDk7GdRIo1jQIEqu69jxvuXB/4ewcVpK7Dg6F3fBEMXVZuFoi1
         BTf671U1HAYTWqYHet5RpYMXovVAEDkOzcBNx/+LXAHYt56a7s7fBVb7WeUyG+KcdAJR
         ySgJsqC1OsEuzYDjX8A7HViShsCXwAZhsEsmHAxzfpxHJHpG7BdKkUJdl7kdRJNn3CPn
         8YMnEGk75R3yhcPAkZVg892T1cPiLDtwMshhfU5kteW0l2sHAEkJRRBujCRX4D4RzH8C
         lI2mQTSNo7HfNHsZOaoTr7YlgdeDHXOaASBhM0I+EpSGbvf7ETUQMhSYpsZNIu6eAnYa
         gigQ==
X-Gm-Message-State: AJcUukf1wJBdp0c2Hv/PRT3HDteLaEYPpVLh0ecv4wyKCtFj4Lt3mUn+
        vXm9Y8IrpsaAbbDJ/x/Eh/Z8jozpwcc=
X-Google-Smtp-Source: ALg8bN7F4r3zsttfF3aFXO3YOSO/dLOfZrLFVcC1OLwG16JPdZSOidSpl0eZsq7lYBf12BnlMCnbUA==
X-Received: by 2002:a1f:2d89:: with SMTP id t131mr8843622vkt.27.1548702030160;
        Mon, 28 Jan 2019 11:00:30 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id t133sm35056961vsc.8.2019.01.28.11.00.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 11:00:27 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id t8so6002853uap.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:00:26 -0800 (PST)
X-Received: by 2002:ab0:740a:: with SMTP id r10mr9002232uap.14.1548702026118;
 Mon, 28 Jan 2019 11:00:26 -0800 (PST)
MIME-Version: 1.0
References: <20190125173827.2658-1-willy@infradead.org> <20190128102055.5b0790549542891c4dca47a3@linux-foundation.org>
In-Reply-To: <20190128102055.5b0790549542891c4dca47a3@linux-foundation.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 29 Jan 2019 08:00:14 +1300
X-Gmail-Original-Message-ID: <CAGXu5jJkf4pKr0WVUcFitZnnUbq3annautZxzYPC0TQaB5HaGA@mail.gmail.com>
Message-ID: <CAGXu5jJkf4pKr0WVUcFitZnnUbq3annautZxzYPC0TQaB5HaGA@mail.gmail.com>
Subject: Re: [PATCH] mm: Prevent mapping slab pages to userspace
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 7:21 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 25 Jan 2019 09:38:27 -0800 Matthew Wilcox <willy@infradead.org> wrote:
>
> > It's never appropriate to map a page allocated by SLAB into userspace.
> > A buggy device driver might try this, or an attacker might be able to
> > find a way to make it happen.
>
> It wouldn't surprise me if someone somewhere is doing this.  Rather
> than mysteriously breaking their code, how about we emit a warning and
> still permit it to proceed, for a while?

It seems like a fatal condition to me? There's nothing to check that
such a page wouldn't get freed by the slab while still mapped to
userspace, right?

But I'll take warning over not checking. :)

-- 
Kees Cook
