Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4B0AAC5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B39208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R0gXW4SY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B39208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934057AbeFKREN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:04:13 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:52524 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933584AbeFKREM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:04:12 -0400
Received: by mail-it0-f45.google.com with SMTP id m194-v6so11218869itg.2;
        Mon, 11 Jun 2018 10:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CBfiZIQ2h6iot7lj1eH+doU5GfXUgezmoTQdv3ZUl6k=;
        b=R0gXW4SYi3PfzAozAjGDW3N8gcVsyKwG5XTRDK0frxZnhdzUqdDL/AaUyv1NXLQPhm
         VNdQSHAxgaBy9DyqNVV5ohLmSS96gvY1yKoFuF1u4anmQkljH6hq1Exm8YPT0rGuSMEz
         fLHgZOtobGAgdzNNVTnBWnAGdwETfV1HEVOO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CBfiZIQ2h6iot7lj1eH+doU5GfXUgezmoTQdv3ZUl6k=;
        b=e8Ie/KmuJo0UktzrqPkm32xjG2swuQKe8cvuZKcEbVfZCx1yajHc0HSVm/8oxMOYq0
         nyPTApo/O9mdLhl/CeLaVn2dLzcnKmW8Z82Z541dG5GOeSv1ueB3KSkPk3JR1LnWudrN
         wqgl3OBVtAGCRRtpy2u2QFaByZUDLa5UjpUdtxxuUjecY7q7aWxFNDF05NiiscOJvxyY
         JBL1JGRUfh7FcM2Bl65DGGwt2aWoRH89OPUy/yxG/+2q63fyrHqoei9d7bXey3QwHSaO
         Bl0HrxiKmEEPdxWAqVe3u3PdBgnsKULyzfbf/DppLs2si0R0MiJuG4emjTt0jTGHsHvm
         mC8A==
X-Gm-Message-State: APt69E3b5pT7GHI8ChXXw5OHjnFCCbsdl5VcFxNhY2pQIWXgFBZuFViJ
        sKs/6wKHEQTmRPc34sDUkb1Dp/yOsQqPyIWy+aY=
X-Google-Smtp-Source: ADUXVKKe2/1907cPKFj0EvgxZvMPo2BgDhT1V9El2e4ZueNE8bR/IlPByQZFroZVVukqygKq+VyP8FuS+70Ok9t+Gj4=
X-Received: by 2002:a24:3cd7:: with SMTP id m206-v6mr10779147ita.113.1528736651523;
 Mon, 11 Jun 2018 10:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180608184842.GD30522@ZenIV.linux.org.uk> <CA+55aFz9cS3m=wZxqKbzrCLEjhPoPddKw5U2MDKNqbG79Wx6bw@mail.gmail.com>
 <20180609051051.GF30522@ZenIV.linux.org.uk> <20180609155107.GH30522@ZenIV.linux.org.uk>
 <20180611021028.GT30522@ZenIV.linux.org.uk> <20180611162313.GA6942@infradead.org>
 <20180611164859.GA28292@bombadil.infradead.org>
In-Reply-To: <20180611164859.GA28292@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Jun 2018 10:04:00 -0700
Message-ID: <CA+55aFykGPDTVN=UvrcDvwV3S_sixXREu8D7eK+x695OmA2PNw@mail.gmail.com>
Subject: Re: perfmon trouble
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 9:49 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> The problem is that even oprofile on ia64 depends on perfmon.

Hmm? You can definitely enable ia64 support for oprofile even without perfmon.

Are you saying the end result isn't usable?

Because I'd be inclined to just remove CONFIG_PERFMON support, and see
if anybody even notices..

I'm not expecting a lot of people to do a lot of oprofile on ia64
anyway. It's a bit late to start optimizing things now.

Do people use perfmon still? Maybe. Maybe not. Perhaps we could just
mark it as broken in the Kconfig file for now, and see if somebody
says something?

               Linus
