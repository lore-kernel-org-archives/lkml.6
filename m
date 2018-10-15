Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B206C7113E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BA120881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3eZc5Yy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4BA120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeJPDoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 23:44:07 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:34616 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbeJPDoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 23:44:07 -0400
Received: by mail-yb1-f196.google.com with SMTP id 184-v6so7986590ybg.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 12:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ia87BMO7Tk4oGx0o9vhKwhAGRv/D6/B4WnW16aF+wvw=;
        b=T3eZc5YyKDK4LZy9apxYFhK1lI0CsuzTdERmHqJF7ctgT6bLyX7/TZxRItrMKfFmwi
         D+DgaFZx4sgwl3+U+b3l6TZpGJDoY2NTPE2S3zixsppvzaB6LqWjnsfn7NAnqb1VY9QM
         Vn0pEUMtJ4KdMVEgYVVRTH3AoIELPShv+AeQCut8XT3xPh6RmUVF0b3pbw2OCRbTc1gd
         t6RCK+z7EpQFm5UdJ9JZJaheNlU2PjHHVbDF5Bxib9C0/lfIx1MqO/Ttb8sWSoIsUhxa
         x9Bn6w8OYKA59EKCXbSiOOjDs4VK4U8fCu0o5dXyfuIyPnNDMusMCW/HlmdeaQbcWPYO
         AwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ia87BMO7Tk4oGx0o9vhKwhAGRv/D6/B4WnW16aF+wvw=;
        b=PAJT2mHa/TI/NaKgE7Gvm+kIb1ZHOb07jCe2LxkV8FCfo5Q7gUw8d8a4V6qlqoskKB
         iOcW6TK8Sy0R2kJvil7fnMU5JzoNUfXTNtgeI+BJwIRmmwcBsI2uJHi+gcW0gTvuggUU
         1NBk1HSbdpTpEJMFdf0l6zceWlV1wve67NsxhJC8l6JUCbyZP9EugDKcSuHKjQwLABtP
         T9OkUKfEgo+9i0EBIYhl2L+zaYK4yhRjLrF380cK4ruTqwD1GleBg0cyjSCXhtnHN8Cm
         su2iYOe6AeS995bfGOkqg1o3xdaU/1ACvPvKz/LeDRA4ySa+2Ii7rR+cvzAsB2/ZjB5u
         cxmQ==
X-Gm-Message-State: ABuFfojJETsg7n5wxPEFVEsuCPleoKVMOVFIn7mIfBbta1d5qCGxnZWV
        aBJ+4lCcEFWPYjUBDWD4YDSMZCP3ZKmVtjQmZ0JnNg==
X-Google-Smtp-Source: ACcGV61cb2BkHE167d5ZLkQJPDywK8yv27I8ekmYqV+FZEOioISYZK90H7glyt4GFX4Rnv54MyVGjzVZgAiQKWcgsPs=
X-Received: by 2002:a25:bcc4:: with SMTP id l4-v6mr9608075ybm.452.1539633444102;
 Mon, 15 Oct 2018 12:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20181014181304.22250-1-hch@lst.de>
In-Reply-To: <20181014181304.22250-1-hch@lst.de>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 15 Oct 2018 12:57:16 -0700
Message-ID: <CAMo8Bf+=fsNWP8iOH-mFt86s3J=oENYJqwpfH4Yyi0LUZcShyg@mail.gmail.com>
Subject: Re: [PATCH] xtensa: remove ZONE_DMA
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 11:13 AM Christoph Hellwig <hch@lst.de> wrote:
>
> ZONE_DMA is intended for magic < 32-bit pools (usually ISA DMA), which
> isn't required on xtensa.  Move all the non-highmem memory into
> ZONE_NORMAL instead to match other architectures.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/xtensa/Kconfig   | 3 ---
>  arch/xtensa/mm/init.c | 2 +-
>  2 files changed, 1 insertion(+), 4 deletions(-)

Applied to my xtensa tree.

-- 
Thanks.
-- Max
