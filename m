Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605B6C5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB7420863
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="an+k4g/e";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N/F3wA6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB7420863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933482AbeGJBER (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 21:04:17 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:44754 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933129AbeGJBEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 21:04:13 -0400
Received: by mail-yw0-f195.google.com with SMTP id k18-v6so7236720ywm.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 18:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jHvddHImHXaEVl4L7K9ntGP8IX103T7ufZ2k4qJpwow=;
        b=an+k4g/es846HJhW6QdER96cLYDMPjkjP2NKTP6giNigOLbGpFoBXnM5vKS/RN2opk
         z2/vlmPDu4JmQ3ns5DdmOJHe0zX2hFHVUcK72C+9dmB5f+NoR0YsGFOGknsd3TgFzqw7
         KOE/tvrmGoH1PIrUU/5y5i6IZtvoHOJpWDEpj/gzEIwqoPgNC/8NxMEApjvcOda5mUAL
         V9F+n0guGHcyK15+yL1c/X9rTD0P/AMMfvlRYyk3joaN4wXbXSGof9oJPYte0cqJourt
         3RF+0pjOj/tlLSvnAfYBU/F5eFWsw82nkEgmJWc2tGKdvbC0byUOq75upglwUDEsVSIW
         u0GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jHvddHImHXaEVl4L7K9ntGP8IX103T7ufZ2k4qJpwow=;
        b=N/F3wA6ahUeD3eaVOMyXjHa0+3YlB2QOQMqKiwP3n7iiBeYF77w+K+tJ7j3aghHsjN
         M33Ut6akJIdYOJ7ou7v6nD/7uS2fKYwqPmpQA1rtiM8nMp8QwP6c7Em92AXrWnTenpnD
         ksi0mSjnN4oq6GD2u5BzJ5Ph0zIGbLfogqa5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=jHvddHImHXaEVl4L7K9ntGP8IX103T7ufZ2k4qJpwow=;
        b=Y4xtZZZC3lojkEYGkkBZD+mYM/b8Mti/kCv7lO2gqy0ASx4ipPj+edpMEFmNLpV8AW
         wYo3DJvZ4Hg8n9bJSWg40tZH/E02t75gzthWyz2Z13vnRq3YPa7+PBt/vn3mUeqCefnB
         AzI7C9Tkpt47udugNQ0Q9zi6uYMmE3lOSCCi2Fx44kAhNDJ4z3BbqDsqGOf6PwCEixSN
         8a3A1q03xRO2IqbNrYPwq/wqa+mzfOWw9jt49nO0Gdxm2YHLrBT8B/bArodIp4W3+Lhf
         3/aD8uexaOCEc7R8PwNsCKEUJ9NrbZPl1XcrYn9J8xi4qsHQ7O6AGkMklh2fFx9YOWvi
         QrOA==
X-Gm-Message-State: APt69E1UPxbNj1fOuksNLyJBwULL5kaGj0OO/QKAnA2CK/7vhybHJ96J
        u0T+alkLuOKeLq7lK7pheTkPeFiTm0ahPsyDpALlUw==
X-Google-Smtp-Source: AAOMgpf/YWIfK8OalcNrVC4mx/CApoeuEoUfT0U3aE3DKuFcJwrlXAK1mtMRaPh8NWnAj+/LnS+sXMSUjTGK3UOB1o8=
X-Received: by 2002:a81:8742:: with SMTP id x63-v6mr5845994ywf.129.1531184652459;
 Mon, 09 Jul 2018 18:04:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 18:04:11 -0700 (PDT)
In-Reply-To: <CAK8P3a1r41cbLmWrd3fLfYfX4NRekDSS2P1N7xV-zYQ-2P0x0w@mail.gmail.com>
References: <20180626172909.41453-1-keescook@chromium.org> <20180626172909.41453-2-keescook@chromium.org>
 <CAK8P3a1r41cbLmWrd3fLfYfX4NRekDSS2P1N7xV-zYQ-2P0x0w@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 9 Jul 2018 18:04:11 -0700
X-Google-Sender-Auth: ZWIHExEZKUTAWetXT6lQVQZL8rU
Message-ID: <CAGXu5jL+Lmq=Wp_O2Lfw=rpYTUst98BVrURvS0m3bD8KCR6K-g@mail.gmail.com>
Subject: Re: [PATCH 1/3] NTFS: aops: Remove VLA usage
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 1:44 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Jun 26, 2018 at 7:29 PM, Kees Cook <keescook@chromium.org> wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> uses the maximum size needed on the stack and adds a sanity check for
>> robustness: index.block_size cannot be larger than PAGE_SIZE nor less
>> than NTFS_BLOCK_SIZE.
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>
>> Cc: Anton Altaparmakov <anton@tuxera.com>
>> Cc: linux-ntfs-dev@lists.sourceforge.net
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  fs/ntfs/aops.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
>> index 3a2e509c77c5..58dadff3e0e0 100644
>> --- a/fs/ntfs/aops.c
>> +++ b/fs/ntfs/aops.c
>> @@ -926,7 +926,7 @@ static int ntfs_write_mst_block(struct page *page,
>>         ntfs_volume *vol = ni->vol;
>>         u8 *kaddr;
>>         unsigned int rec_size = ni->itype.index.block_size;
>> -       ntfs_inode *locked_nis[PAGE_SIZE / rec_size];
>> +       ntfs_inode *locked_nis[PAGE_SIZE / NTFS_BLOCK_SIZE];
>>         struct buffer_head *bh, *head, *tbh, *rec_start_bh;
>>         struct buffer_head *bhs[MAX_BUF_PER_PAGE];
>>         runlist_element *rl;
>
> This has uncovered what looks like a preexisting bug on architectures
> with large page size, this is what I get with 64K pages on arm64:
>
> fs/ntfs/aops.c: In function 'ntfs_write_mst_block':
> fs/ntfs/aops.c:1328:1: error: the frame size of 2432 bytes is larger
> than 2048 bytes [-Werror=frame-larger-than=]
>
> Since both ntfs and 64k pages are fairly obscure features, we might
> get away with just disabling the combination of the two in Kconfig.
>
> Using dynamic allocation might be tricky here, since I assume this
> could be called during writeback in order to free memory, and I can't
> immediately see any better fix.

I'm open to whatever. In crypto, my series uses specifically 4096 for
PAGE_SIZE instead of using PAGE_SIZE, since it wasn't really related.
Here, though, I can't tell if it really IS a page size issue.

-Kees

-- 
Kees Cook
Pixel Security
