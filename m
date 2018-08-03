Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2BEC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 18:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEEA217A2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 18:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S+y+lcnz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECEEA217A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbeHCUzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 16:55:18 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40606 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbeHCUzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 16:55:17 -0400
Received: by mail-it0-f65.google.com with SMTP id h23-v6so9770649ita.5;
        Fri, 03 Aug 2018 11:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=13qy+dxDgzc11PMhtnRwbhDfHnFyPcN1FSVdS6qh9wc=;
        b=S+y+lcnzKHY9sP+zwlnGst4m3tG+Jx/G+z9zdtFmGPWoe7i9BPSHNGcIgq4ic6xX4U
         ShmLvv6MP2EuqATbo+MK36AkCP0S/jemL74Rw0V0vumFrKn9tL65PR3r4As1bYmmpFUW
         LKiGh4se2Z5ZfW8Vp23h+CYnBMmlJhvfaOAMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=13qy+dxDgzc11PMhtnRwbhDfHnFyPcN1FSVdS6qh9wc=;
        b=oVxZzO74fKSFl4+EpHbLaJFZ9EIy2YSMDwjBYDH4SQzmjNyCRcImuznbU62eSZce4e
         mVCP5Qw0/7F2L9naw6jTcHA72T2a/rulHRufesul6sllXduXXWQAOxwT7kM0TeKYBrRG
         ZY8XrbOh7aHc5er00DwWX2zuT63b1QRsh8vLunQGv9Ox0XB6ALsqbgrzbvvzMgeo+4+N
         YU4xZSHzT5pNWbC2StCumROYvrNXgtwYiaPtgGfxi/Bkn7BTJEH3VSYsDIb5lLYlTX1s
         YQ8bxCVrKMVigzX9/VjdO1jgn+L6y26Q5pkTZnlOAwzweS6NLNW1tpprGb9/yLDft3xt
         HXsw==
X-Gm-Message-State: AOUpUlEuSm47xgDcCPdT653G5FcEFCz8RNd7GA95lkAEwQmJceapeC83
        2ED3hT23p9Qdjw0LGOG7xPydYrpEA8YqkQ2rDyY=
X-Google-Smtp-Source: AAOMgpftH8S1bEbq8LpFJ4VUvJVtwRRaA4Lv7M+ZXz9z+KDG2CoqlmKh/YQn11BQOa2TVFOPtfu3ki+DzIWq7OnJ9WY=
X-Received: by 2002:a24:b211:: with SMTP id u17-v6mr7247336ite.1.1533322665013;
 Fri, 03 Aug 2018 11:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAOi1vP_tYG77e71CdDiOcszSSEWrp9Vfi+KB7yFAXVQChkjP5A@mail.gmail.com>
 <93bff248-6897-4867-841b-2dace11597de@torlan.ru> <CA+55aFyAox9BTDpRsqLXiROhHOX60aa45LEZ7Azteaumdu11Fw@mail.gmail.com>
 <CAOi1vP-SJO4AMK=XD3Lmja++2dQqoiw6Zn8Vgxf8OfvYgnuC6Q@mail.gmail.com>
 <CA+55aFy2DR9fxHhmGq+azSjX9D71YtLsuFKmoEuYW3uTAUYtJg@mail.gmail.com>
 <d76415de-2056-c7d6-cc88-b896deaa8ead@torlan.ru> <1ec0a220-d5b0-1c27-e63b-c4d3f4ce9d77@torlan.ru>
 <CA+55aFyPVQ5-gA93irsaxPC9BNQxnGWrDDHPMUYai2kxKiaKWQ@mail.gmail.com>
 <20180803133102.GA3092@redhat.com> <20180803152034.GD32066@thunk.org> <20180803183932.GA3258@redhat.com>
In-Reply-To: <20180803183932.GA3258@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Aug 2018 11:57:34 -0700
Message-ID: <CA+55aFwGGjs_imFFkEPJ4g99Kseam=4Qppv4G6Q=ZfZXdzF7Vw@mail.gmail.com>
Subject: Re: LVM snapshot broke between 4.14 and 4.16
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, dm-devel@redhat.com,
        Ilya Dryomov <idryomov@gmail.com>, wgh@torlan.ru,
        Zdenek Kabelac <zkabelac@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 11:39 AM Mike Snitzer <snitzer@redhat.com> wrote:
>
> Please stop with the overreaction and making this something it isn't.

It's not an overreaction when people get their scripts broken, and
some developers then argue "that's not a serious bug".

Guys, this needs to be fixed.  With all the stupid and fundamentyally
incorrect excuses, I am now no longer even willing to maintain any
other course of action.

If you develop for the Linux kernel, you need to realize that
"breaking user space" is simply not acceptable. And if you cannot live
with that, then you should stop working on the kernel. Because I will
refuse to continue to pull from you as a developer.

At worst, I'll just revert the original commit entirely. I was hoping
we'd be able to avoid that, partly because the commit looks fine, but
partly because it also doesn't revert cleanly.

Or I'll just do something like this, since it seems like it's the lvm
people who have the hardest time with understanding the simple rules:

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index b810ea77e6b1..fcfab812e025 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1049,7 +1049,12 @@ static int do_resume(struct dm_ioctl *param)
                        return PTR_ERR(old_map);
                }

-               if (dm_table_get_mode(new_map) & FMODE_WRITE)
+               /*
+                * This used to do
+                *    dm_table_get_mode(new_map) & FMODE_WRITE
+                * but the lvm tools got this wrong, and will
+                * continue to write to "read-only" volumes.
+               if (0)
                        set_disk_ro(dm_disk(md), 0);
                else
                        set_disk_ro(dm_disk(md), 1);

which seems to target the actual problem more directly.

              Linus
