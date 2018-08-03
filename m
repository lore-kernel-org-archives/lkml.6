Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A1EC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C75E2176D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dsqYYzso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C75E2176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbeHCV2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 17:28:40 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37849 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbeHCV2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 17:28:40 -0400
Received: by mail-it0-f65.google.com with SMTP id h20-v6so9934564itf.2;
        Fri, 03 Aug 2018 12:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ExFB/sn3sW6Ob/ZwKRdBweOWaw61q0VpEL1D+bf6qHw=;
        b=dsqYYzso0uRq2XTOwj4bMIJJulhKBzzQATAozHrQ7Eu73+DBDqF9WF22kKxlV2BQCU
         GtKWLC8/rxa6cyfwPMlg9OWVGQ8aXH85oUcedEhqhqrMLtbErCLReW5zyc2Ua2p8A9ua
         s3Ec27j1N4ZobmPv1u+ILIbvmwuwRrdgEeqo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ExFB/sn3sW6Ob/ZwKRdBweOWaw61q0VpEL1D+bf6qHw=;
        b=J2v3zRwlD/UIZPUFFe4QIqqxE2heBH/FEjsZab+rRndVFHMWmIJoFS9IHvc1zEfFdH
         4WnLGONq1KTn19MoELS5F49k4iSRVdEYrEhNg8w9sGrzTooIYl8asNZvUwmNxHVhZQL9
         emJBkRMS9GVvWBjEbCVAd62I5/Q1c8RAoO9odnf6+nEF9ORop3goCb0nBpoiwJpM8xek
         5/RKv9fCbuRvkMHrcoNJt7fJQAiVEYOclyseeexqLMunF4dWD2ZrX8GCXPAJ1wT2g0jx
         t6t5Ru1HukNa2tiL7caREHwlSgaDQlwvPNDinNzHkHSuOMwv6uK3GpHVW/OjXEjlfB26
         ZGgg==
X-Gm-Message-State: AOUpUlGJW7huA3+xoCLO7WhzWiiZu01DrbcR3jYD4PfZ5MPkBxR/nEfq
        FR/4VuyFpjyp8QM7xtu1YEv/cvwr8m2qCp/dFF0=
X-Google-Smtp-Source: AAOMgpcUASLeMCCi9U5uxD12RL+VM35LzRDyPZ3TRw33YoZKnfDJ56dXhiPVdu8rGDNu0VfdPEosbEkwCBAWRLSUmes=
X-Received: by 2002:a24:b211:: with SMTP id u17-v6mr7346003ite.1.1533324660712;
 Fri, 03 Aug 2018 12:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <226835ba-2197-b850-6e5b-8ba14f7fd016@torlan.ru>
 <CAOi1vP_tYG77e71CdDiOcszSSEWrp9Vfi+KB7yFAXVQChkjP5A@mail.gmail.com>
 <93bff248-6897-4867-841b-2dace11597de@torlan.ru> <CA+55aFyAox9BTDpRsqLXiROhHOX60aa45LEZ7Azteaumdu11Fw@mail.gmail.com>
 <CAOi1vP-SJO4AMK=XD3Lmja++2dQqoiw6Zn8Vgxf8OfvYgnuC6Q@mail.gmail.com>
 <CA+55aFy2DR9fxHhmGq+azSjX9D71YtLsuFKmoEuYW3uTAUYtJg@mail.gmail.com>
 <d76415de-2056-c7d6-cc88-b896deaa8ead@torlan.ru> <1ec0a220-d5b0-1c27-e63b-c4d3f4ce9d77@torlan.ru>
 <CA+55aFyPVQ5-gA93irsaxPC9BNQxnGWrDDHPMUYai2kxKiaKWQ@mail.gmail.com>
 <b2bbd8ec-ac5b-fa8a-d3f7-8615d87f73c3@redhat.com> <CA+55aFwWZX=CXmWDTkDGb36kf12XmTehmQjbiMPCqCRG2hi9kw@mail.gmail.com>
 <bc71118d-3003-6260-6ab3-ddcc4277aeed@redhat.com>
In-Reply-To: <bc71118d-3003-6260-6ab3-ddcc4277aeed@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Aug 2018 12:30:49 -0700
Message-ID: <CA+55aFzyNMWfkaWvFuMaLCBjcWvBQgBAe+GY=WDPiGd1YDTs=Q@mail.gmail.com>
Subject: Re: [dm-devel] LVM snapshot broke between 4.14 and 4.16
To:     Zdenek Kabelac <zkabelac@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Mike Snitzer <snitzer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, dm-devel@redhat.com,
        Ilya Dryomov <idryomov@gmail.com>, wgh@torlan.ru
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 12:18 PM Zdenek Kabelac <zkabelac@redhat.com> wrote:
>
>  From my userland POV - leaving kernel write to devices that are supposed to
> be read-only  'just because' it's kernel is wrong - the fact it has NOT been
> discover for so long means - there are not many users and not many testers of
> this combination.

Sure. But at the same time, the "read-only" issue from a _security_
standpoint should never be about some device state.

Why? Because the Unix security rules aren't about "read-only devices".
They are about permissions, and if you don't want your users to have
write permissions to a device, then they shouldn't have those
permissions.

So the "set_disk_ro()" interface is simply not for security. Anybody
who uses it for security is seriously confused.

No, the "set_disk_ro()" interface is so that you can say "you
physically cannot write to this medium". It's meant for things like
CD-ROM devices, or for a floppy device when you notice that the
controller reports that the floppy itself is physically
write-protected.

THAT is what the new code checks for, and that is also why ignoring
the check really shouldn't be a security issue.

Because if it turns out that somebody wrote to it, and the write
succeeded, then obviously the "set_disk_ro()" usage was simply wrong.

Now, I do agree that it 100% makes sense to have a layer like md/lvm
be able to virtually mark volumes read-only. If only exactly to
emulate the "this is like a write-protected floppy or a cd-rom"
behavior.

So the DM_READONLY_FLAG makes conceptual sense.

But at the same time, if the DM_READONLY_FLAG was _wrong_, then it
also makes a ton of sense to just say "oh, it was wrong, we'll ignore
it".

Exactly because it was never supposed to be about security, and it was
about other things.

See?

              Linus
