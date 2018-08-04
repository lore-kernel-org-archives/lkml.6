Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A26AC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 17:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F7D217CD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 17:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ip1EfzWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F7D217CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbeHDTGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 15:06:17 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36788 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbeHDTGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 15:06:17 -0400
Received: by mail-io0-f194.google.com with SMTP id r15-v6so7637418ioa.3;
        Sat, 04 Aug 2018 10:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kqEkWxb2wqOUCpWcv9SEaeFlHR8Dtwpujde8DX+Eykc=;
        b=Ip1EfzWZa6WCT01CoEYotPvQoA/Ja32qXjRSFeYZmkoHTEJ4QBJOXvNGtsI9tJO17Q
         guP8xzePgP6azuXP3nhzU3c/gtmsVGlrynqMz+OTi/aUBav2+K3xySuwA5b7hw1N1Zb7
         uUm9aWNFGAreGp4kG4D/Ie3dmMcb4bmo2pX4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kqEkWxb2wqOUCpWcv9SEaeFlHR8Dtwpujde8DX+Eykc=;
        b=YhlEr4fa8EvdBnB84rPl8DNlXug1dYi2R9zW4LrdZUucQgR9jACnq9afXE1ErgXvHC
         BbZYdg1eBkqwnAjopyL24Ds0Kzx1l0BQ7r91NlmA0+hjiL4pnmdbzpaoeWXVij8RnxDB
         DBZr0S0GDjqK7LAh6+aClxtiy/b6KlYVgQ79hkYJbVyGfz3EjCrkGUqD8/KBxk5NUsQq
         32ZbScfwkvOjWKytyMDmYuewbFf6Y80Sj8cubqTp6KRj7Xp2S4CNJhiyfYUmhawHILDS
         35p9IyPb0rJj9vBSo+1MhuUmqizHLHEYgJL99Sc5bS22Xrxuvh14HwhkWVsaHZui/TuJ
         Jtgg==
X-Gm-Message-State: AOUpUlHlh4b1mRcgsFQF+Re6FBkygMk3jiBGCCbj5OWE7ICaOQUDyETX
        N3a/LfRCZ4dm+7zDKcZEnwzSAiIPqEQDbmoGwLU=
X-Google-Smtp-Source: AAOMgpfqCnWFPqXcu4dJpBqmT8nWs6Hwxhx8dLtnzfCpVGcM1v371Nn3WBsBAvUssAP4iKF71C694mj4z8FlzBc3CG4=
X-Received: by 2002:a6b:fc0c:: with SMTP id r12-v6mr10502824ioh.203.1533402299023;
 Sat, 04 Aug 2018 10:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFyAox9BTDpRsqLXiROhHOX60aa45LEZ7Azteaumdu11Fw@mail.gmail.com>
 <CAOi1vP-SJO4AMK=XD3Lmja++2dQqoiw6Zn8Vgxf8OfvYgnuC6Q@mail.gmail.com>
 <CA+55aFy2DR9fxHhmGq+azSjX9D71YtLsuFKmoEuYW3uTAUYtJg@mail.gmail.com>
 <d76415de-2056-c7d6-cc88-b896deaa8ead@torlan.ru> <1ec0a220-d5b0-1c27-e63b-c4d3f4ce9d77@torlan.ru>
 <CA+55aFyPVQ5-gA93irsaxPC9BNQxnGWrDDHPMUYai2kxKiaKWQ@mail.gmail.com>
 <20180803133102.GA3092@redhat.com> <20180803152034.GD32066@thunk.org>
 <20180803183932.GA3258@redhat.com> <CA+55aFwGGjs_imFFkEPJ4g99Kseam=4Qppv4G6Q=ZfZXdzF7Vw@mail.gmail.com>
 <20180803190617.GA4498@redhat.com> <CA+55aFzSM6qhZpM4CCpRNR_LWNCbLyRtQQ3hnPwnRrBdDkwWUw@mail.gmail.com>
 <a5feeaa7-e043-3987-cf23-4090e3eeec4a@torlan.ru>
In-Reply-To: <a5feeaa7-e043-3987-cf23-4090e3eeec4a@torlan.ru>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Aug 2018 10:04:47 -0700
Message-ID: <CA+55aFza3_+poqmw34ev+a_jZ1Tz0rxjTu7YfnU4HX-SU52abQ@mail.gmail.com>
Subject: Re: LVM snapshot broke between 4.14 and 4.16
To:     wgh@torlan.ru
Cc:     Mike Snitzer <snitzer@redhat.com>, "Theodore Ts'o" <tytso@mit.edu>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, dm-devel@redhat.com,
        Ilya Dryomov <idryomov@gmail.com>,
        Zdenek Kabelac <zkabelac@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 4, 2018 at 3:03 AM WGH <wgh@torlan.ru> wrote:
>
> >
> The patch works for me.
>
> However, there's no text messsage in the kernel log, just a traceback. I
> think that's because WARN_ONCE is supposed to take condition as a first
> argument.

Duh.

It needs to be WARN_ONCE(1, ...);

I obviously didn't test that patch, but I _did_ compile it. I wonder
why I didn't get a compiler warning for it...

[ Goes off and looks ]

Oh, because the "bio_devname(bio, b)" argument ended up being
interpreted as the format string, and since it was a dynamic string
the compiler felt it was all fine. Just bad luck.

Anyway, just out of curiosity, what was the traceback?

I'm not entirely happy with that patch either (even after the obvious
fix to add the "1" argument), but it does seem like the minimal
temporary workaround for now.

              Linus
