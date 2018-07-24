Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE9DC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03A820671
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WbpsbuX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03A820671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388726AbeGXVYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:24:52 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:54307 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388476AbeGXVYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:24:51 -0400
Received: by mail-it0-f50.google.com with SMTP id s7-v6so5559095itb.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 13:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ls1obJ+u7TpgxF0Be8ATXEP9ZVhQbgBX2YqYvGoR4s8=;
        b=WbpsbuX/j6JOOGm+AEeIL4XZVagJibUoeAK4MjiBBfjgW51BKjGG/8N6zDDgYlG75p
         GDzb/hG4jjZHbI+pKWenfEVzD7ja2cEXAUkx2ocXX8qb2AV+Y2jhlz+dNcqz3A45uHHH
         HTXAZ3MSRjcYOW8VqQxLAztP7Cm6SZqeKQqyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ls1obJ+u7TpgxF0Be8ATXEP9ZVhQbgBX2YqYvGoR4s8=;
        b=eal/mnoPovpN75O1+jWV3JF/OR9Q1I8o4XIZJHLXgKzhRXTtoUtljaduyh1o21+xev
         BaEVNlPaZKxjZXr1VQRuzqoxtIGQzaP0zCGXMARrAX/Ei7F4dpoNvDn4O+zSc2d3FUMz
         /ntVaohPQqFcQtzDRqj0zotFixyZrLuu3Njf8u2VBCmfYq7KRnWN9yfnNNGXbfrd5Geb
         l6xP1MxrkSX5xR07MyG6+cSwnlkhrw8qKHz/eoFxPYBYhsDJJ0Nh24ySGNFqrKdnuLRM
         hQm5H3vQO7wXvUsgPndSeV9aAU5yUcgi7nq8MdfHGMIpdSSZMefs1+X+MG0uUMlqcbnt
         hRmw==
X-Gm-Message-State: AOUpUlHjtpvLFStliN1PBjrn7cstP6F7WBuQhbcMcHIconjgWxWBYtyD
        VeIW+6chI9uOfvGFbVq7tWh5XCqmN+WG41s38LFXy4ng
X-Google-Smtp-Source: AAOMgpeoRVM5aGiGZme39TZdavybmH2yH68NGE2hnASr2rXE1V06rQeBv/AcMS40smZtvJfPIKuz7G7wg0mr9pzZqWY=
X-Received: by 2002:a24:94f:: with SMTP id 76-v6mr3876602itm.113.1532463404041;
 Tue, 24 Jul 2018 13:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180724121139.62570-1-kirill.shutemov@linux.intel.com>
 <20180724121139.62570-2-kirill.shutemov@linux.intel.com> <20180724130308.bbd46afc3703af4c5e1d6868@linux-foundation.org>
In-Reply-To: <20180724130308.bbd46afc3703af4c5e1d6868@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Jul 2018 13:16:33 -0700
Message-ID: <CA+55aFz1Vj3b2w-nOBdV5=WwsCYhSBprjPjGog6=_=q75Z5Z-w@mail.gmail.com>
Subject: Re: [PATCHv3 1/3] mm: Introduce vma_init()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 1:03 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
>
> I'd sleep better if this became a kmem_cache_alloc() and the memset
> was moved into vma_init().

Yeah, with the vma_init(), I guess the advantage of using
kmem_cache_zalloc() is pretty dubious.

Make it so.

        Linus
