Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2A3C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E77E21872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IodDgUPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfADRyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:54:25 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39695 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfADRyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:54:24 -0500
Received: by mail-lf1-f65.google.com with SMTP id n18so25972969lfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 09:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XsVK1WRl7sYn7ta04iAyntHqwbf6VtSYGr1Ly5n6GNU=;
        b=IodDgUPX5dda1krHX6/lVuNBp/uDtyBokKCNh+lxSTZvP6zPoqyGOLxgUYF1UhskPO
         9G9g2vktSyeimEDKVHNnwNg3c7KauAA+po+wxydEQyDwOMhP6DuSrF+Rxj6Ag/q3fvKK
         OwW7Pun5DbkAIuHthvbbURLNLdpWlZiT1ctn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XsVK1WRl7sYn7ta04iAyntHqwbf6VtSYGr1Ly5n6GNU=;
        b=ndXlH0jO+zSn9U4zMEFihAxeTqUgFjwhecN8bo6za7N8g9M5bBvXcAqyTnoHObsdwq
         v1TlEKYzkGU6++mJFXjsh80Q+xMnkXF01OyGY2t6LFxoDTrP4Uq+6Itn1DzmOh+Lva69
         thNUONfYvAxHUARGwPcI6pcZtWj3T+3UvLVqmz0dJjhSaDXzX62owAwy1G6cGdQ1YbtH
         AnLd19+RAetbnAMEY6+nZiQgEJNnxovsuMrCsXZTFZATW7J+9jLba8pTfTzDZ9Ul4w5T
         Zf+HWY7p9BqHR+3kXC3g6sXB96HaEIWVU+OCRA3juFd8TNG3EOY8JjP9Fh3Uq8r4kDLg
         xUFQ==
X-Gm-Message-State: AA+aEWYu4jAvjYYibd/qdYEViLREB7zES2887ayb/pjINuUTuueGM1tc
        UZIRTM1ilG5ZqhmLeDdYl6iHUhJKZ/M=
X-Google-Smtp-Source: AFSGD/XGngCjrVghGwqw/IZlNzgMDZ/6JG1YjBS7xwWVUeFd3slZjts5gml/bnhti642aVDmi36MNw==
X-Received: by 2002:a19:a302:: with SMTP id m2mr28129000lfe.108.1546624461835;
        Fri, 04 Jan 2019 09:54:21 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 12-v6sm12380678ljf.96.2019.01.04.09.54.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 09:54:21 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id i26so26006013lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 09:54:20 -0800 (PST)
X-Received: by 2002:a19:4287:: with SMTP id p129mr27660722lfa.135.1546624460449;
 Fri, 04 Jan 2019 09:54:20 -0800 (PST)
MIME-Version: 1.0
References: <20190104092758.4378-1-malat@debian.org>
In-Reply-To: <20190104092758.4378-1-malat@debian.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Jan 2019 09:54:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi0zJk-1manLvbFCuCduYj0JF6EWWjs_9t8M+MVMSuMTQ@mail.gmail.com>
Message-ID: <CAHk-=wi0zJk-1manLvbFCuCduYj0JF6EWWjs_9t8M+MVMSuMTQ@mail.gmail.com>
Subject: Re: [PATCH] Remove 'type' argument from access_ok() function
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 1:28 AM Mathieu Malaterre <malat@debian.org> wrote:
>
> Revert commit 05a4ab823983 ("powerpc/uaccess: fix warning/error with
> access_ok()") to fix the following compilation error:

Gaah. I even *looked* at the powerpc use of 'type', but then when I
was actually going through my manual editing I forgot all about it.

So this wasn't a case of "the powerpc change was recent and clashed".
This was purely a case of "Linus screwed up".

Sorry.

              Linus
