Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F10C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F552086C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F552086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbeIDPVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:21:31 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46319 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbeIDPVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:21:30 -0400
Received: by mail-yb1-f195.google.com with SMTP id y20-v6so1096469ybi.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 03:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OprbpS3vhusD9yY8I6Dv1ZZO0fM3KLRhcUIMBCLFvQo=;
        b=fAeelqIH3bTMyoZ5oJ2IjJAOnSgYVbHYDsZIMFrRZPx/+EQbonh+gE30MJx5CUss/U
         GC2L1BGJ0qHsta96x+TRNtKiw65UBDchc5ORXUb5ei/5JxH6PKWURS4vuG5MUO/ZqR2p
         yovEiIRSQVjyvAMfVhzm3PrTt8Pe55CtkV8G0NcyL4QGPJDZX/A6Bz6B3fNf1Pp6Kymp
         8BOl+hSEuAQOQlhCk870UkOHMiPJ6pXvUihesZnVMTq1e3eJa3RAkpamzzeWWFXZNEMj
         0m5QkQJKvnY2laA66pL2vDKhzyIk6h1f4Myb2Vt4sUK+SWLag2yN5zZ3OYtQfc9RoNzl
         3OuA==
X-Gm-Message-State: APzg51AUlQyT4DN3r1JriGhFho252xjIj/YcuDZa4EQpdlYEak20NSqV
        ahSnY4vXnQm3OpnhbXpvj1DNJw==
X-Google-Smtp-Source: ANB0Vdbxgiqu0+FoAfpjCYtVEK5cOx4Ca8PWljxXJGYFfp0Fap8bvLnJGJNVzb9wbhvF/diKH5p2JA==
X-Received: by 2002:a5b:749:: with SMTP id s9-v6mr10144281ybq.79.1536058614925;
        Tue, 04 Sep 2018 03:56:54 -0700 (PDT)
Received: from tleilax.poochiereds.net (cpe-2606-A000-1100-DB-0-0-0-161.dyn6.twc.com. [2606:a000:1100:db::161])
        by smtp.gmail.com with ESMTPSA id t10-v6sm9253434ywg.74.2018.09.04.03.56.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 03:56:54 -0700 (PDT)
Message-ID: <486f6105fd4076c1af67dae7fdfe6826019f7ff4.camel@redhat.com>
Subject: Re: POSIX violation by writeback error
From:   Jeff Layton <jlayton@redhat.com>
To:     =?UTF-8?Q?=E7=84=A6=E6=99=93=E5=86=AC?= <milestonejxd@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Rogier Wolff <R.E.Wolff@BitWizard.nl>
Date:   Tue, 04 Sep 2018 06:56:53 -0400
In-Reply-To: <CAJDTihx2yaR-_-9Ks1PoFcrKNZgUOoLdN-wRTTMV76Jg_dCLrw@mail.gmail.com>
References: <CAJDTihx2yaR-_-9Ks1PoFcrKNZgUOoLdN-wRTTMV76Jg_dCLrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-04 at 13:42 +0800, 焦晓冬 wrote:
> Hi,
> 
> After reading several writeback error handling articles from LWN, I
> begin to be upset about writeback error handling.
> 
> Jlayton's patch is simple but wonderful idea towards correct error
> reporting. It seems one crucial thing is still here to be fixed. Does
> anyone have some idea?
> 
> The crucial thing may be that a read() after a successful open()-
> write()-close() may return old data. 
> That may happen where an async writeback error occurs after close()
> and the inode/mapping get evicted before read().
>
> That violate POSIX as POSIX requires that a read() that can be proved
> to occur after a write() has returned will return the new data.

That can happen even before a close(), and it varies by filesystem. Most
filesystems just pretend the page is clean after writeback failure. It's
quite possible to do:

write()
kernel attempts to write back page and fails
page is marked clean and evicted from the cache
read()

Now your write is gone and there were no calls between the write and
read.

The question we still need to answer is this:

When we attempt to write back some data from the cache and that fails,
what should happen to the dirty pages?

Unfortunately, there are no good answers given the write/fsync/read
model for I/O. I tend to think that in the long run we may need new
interfaces to handle this better.
-- 
Jeff Layton <jlayton@redhat.com>

