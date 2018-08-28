Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA9BC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EB320867
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSwW+PMx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51EB320867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeH1TZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:25:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34666 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeH1TZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:25:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id d19-v6so924337pgv.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 08:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=934Jsb870T3CKC5XjYNOOvYgbhzEhvgi6pt//qVRJ1g=;
        b=hSwW+PMx0WpLn/oYrQahaLahfKfPL1v2cytfnr2NXZDnbFIQbb71wjfBmxkmHaZOK+
         POKDnUvVh2D49fSUpMn7IYOrYTpGybT0PUYTCRfdWMR2pTASMtXTjsy/JwQGXCZeUGz8
         Hayl7Z4VaMbnPnbp5YwIB9Owrnp28yXL840Uo43M0cvuxY5EDtqBUe7BwmxxZH6Ottjh
         Zq+wQNsW9/kNgSEKM6IL8MWUkcJzdcATb++3ac+Xu5PGnkMXpeb0pEjPPXG5OfBmy5tw
         GyiC2IdfqQzQCkV/4cni8PGE08Sqri6jCwgIHUQ9ht7bUTsORnlq4QgKfSGjq3kQURIX
         QFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=934Jsb870T3CKC5XjYNOOvYgbhzEhvgi6pt//qVRJ1g=;
        b=kj6T9++uxK0NYo84eT6RDmO15FhxPO10HMLrYniYrJbEoFa44sGfSnrA8/6Fa+0iDA
         MxzqqfFuYnSiP+eyAm7yMWgzcM+/vr9a+K0I52VYGVu9Dm19hdulTaaLl6A+8ngpacAb
         3UGnryyCUQwOnrQmRwd4Cwpa/1/hO4I9CAcfP5I90FTmNQug3Gb1WUprVuX6irxEbWQC
         xSMgNOyAxws82KHn/47gKbqtCMQWFdUphkSGOMUTbfSW6elqmKy8R5iSkQ3+OjzQQo8L
         8sFm7Q+emCl1VWQzCMW9gfekZZTwvk9aUDVYa8Oc35kPj8C0YHGGsCe9J1riw0pFEhBX
         //Kw==
X-Gm-Message-State: APzg51D1TsblvrPPrjFH0/6z77rzLPW674ve6jXIuVP1gBPuoaiLu4F5
        v1EPW4xG7L+IZYqN5zE95bM=
X-Google-Smtp-Source: ANB0VdYi/SzX8n+0pb1Fg6qrbfYtqFINrvd36KC8sE1WSZgk79gC1SPiHKReHnZHqPWHA4T85gywnA==
X-Received: by 2002:a62:571b:: with SMTP id l27-v6mr2136511pfb.29.1535470423445;
        Tue, 28 Aug 2018 08:33:43 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-81-67.tpgi.com.au. [59.102.81.67])
        by smtp.gmail.com with ESMTPSA id w13-v6sm2178722pgs.89.2018.08.28.08.33.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 08:33:42 -0700 (PDT)
Date:   Wed, 29 Aug 2018 01:33:36 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Subject: Re: VirtIO console hangs
Message-ID: <20180829013336.42692195@roar.ozlabs.ibm.com>
In-Reply-To: <CAGnkfhxhV_4JNhCm2s=XP15sp3bKax9O1R+nFwA+oRJXQ53xsg@mail.gmail.com>
References: <CAGnkfhzjeYU_jmhNkLEayL1FSq5rWkT7T+Nm1ky9QS-vWHUhyw@mail.gmail.com>
        <20180829003539.668e514c@roar.ozlabs.ibm.com>
        <CAGnkfhxhV_4JNhCm2s=XP15sp3bKax9O1R+nFwA+oRJXQ53xsg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 15:00:14 +0000
Matteo Croce <mcroce@redhat.com> wrote:

> On Tue, Aug 28, 2018 at 2:35 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > On Tue, 28 Aug 2018 12:54:08 +0000
> > Matteo Croce <mcroce@redhat.com> wrote:
> >  
> > > With kernel 4.19.0-rc1 virtio_console hangs very often.
> > > I can always trigger the bug by pasting some characters in the
> > > terminal window, the console will stop receiving keypresses, but I can
> > > still see output from the console.
> > > Stangely, logging in the VM via SSH and sending lot of data to hvc0,
> > > like 'dmesg >/dev/hvc0' will fix the issue until the next paste.
> > >
> > > I did a git bisect and I've found that this is the offending commit,
> > > reverting it fixes it.
> > >
> > > Cheers,
> > >
> > > commit ec97eaad1383ab2500fcf9a07ade6044fbcc67f5
> > > Author: Nicholas Piggin <npiggin@gmail.com>
> > > Date:   Tue May 1 00:55:54 2018 +1000
> > >
> > >     tty: hvc: hvc_poll() break hv read loop  
> >
> > Thanks for the report. I can't immediately see what the problem
> > is. Can you try get a stack trace of where it is stuck?
> >  
> 
> I tried but didn't get one.
> 
> > Perhaps try this patch if you have time (it's a bit of a shot
> > in the dark).
> >  
> 
> Yes it seems to fix. Thanks!

Great thanks for testing it so quickly.

I would have thought the return code should cause another poll to
trigger. I'll have to read the code again and try to find out what
I missed.

Thanks,
Nick
