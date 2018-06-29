Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40003C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC3527A86
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ec5BmhFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC3527A86
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936255AbeF2APl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 20:15:41 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45807 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933682AbeF2APk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 20:15:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id g3-v6so5890641ljk.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 17:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l5lIhXn+YcbXhTMyNHVcwsHNlgMtLgqJIEVuvH/OxG4=;
        b=ec5BmhFUfkzg4wCSm8j/ClvKM6UjnE34823GsKSqx6NUFm8Euw+0nzOWSoXjYl3nnh
         8JrmYRyTremLSeNBmbryjEK3Css+Z5xWP9TL0C+YTV1oqYozpYZgO++I59IB5TU65O3q
         zf6qf8PNQER2iiXepBx4Thdxo2lygiHLoVZ7QXRMRQMfXL5JjON+16OohDINDRmYa7sR
         YFAVhe3Cpy5HJMjiVp7nbh9o8c25+2EgpWQ7Wy96vjg3K1G0ot4aQ1we19E1REjW/D1C
         YVndNh//faPeYJocHeUTa0Tjq18OMhyfttJy9+krc14o50SJYX3lllAnxkEu9kSP8ciH
         uwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l5lIhXn+YcbXhTMyNHVcwsHNlgMtLgqJIEVuvH/OxG4=;
        b=nP6dr7v33eSJ7izfTbU3yCs+BtN6oLVfNv5vbDO6ZjNrD4bSGH8wPqyhtMQxwnCDgX
         0ZjiJzLNDpuVnjQyLmv45tee3U52phahrmwpFzhoJLLrEiExRsoNBn6mbJOaMYr3o/as
         XDz0dX0TQgT/DLmEoUe9lIu443zjOJ5nFogmIXNhXQFlFvgzGQF5b+3mAhn5BrOdGqIX
         cCjfmaXdcYLmgkBkQsPEfkdSWOeY/Y7QV0/9UNLo3Cm3PLwbilXmxNVvOReHDgbPwNJ3
         CZHAe5vgjvO+6+lqSe0I9t9GLRBTm8wBA5pi6M/ngjAjVnn2pwKNrX0RGxAI0ELRzfiL
         L8MQ==
X-Gm-Message-State: APt69E2mpL5N51RQMUQueF/v+N71zCcU0DYZYNaYJxYpBWIGKwkfqmEI
        RaSZFo0vtWLL9ENh5rOA0pUPUW4jJNXjoYzZ7c02
X-Google-Smtp-Source: AAOMgpeFK7SYVi40ycQL+i0FQS3fiUCQU/o+EZ1XokfVuWXqMhVjFKj9aEHB/akYf+dROlSJOqFsVUJplzExU1Elbso=
X-Received: by 2002:a2e:29da:: with SMTP id p87-v6mr6861851ljp.12.1530231338880;
 Thu, 28 Jun 2018 17:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180625163425.216965-1-jannh@google.com> <CAHC9VhTipjBx9CF4FdTbc2a8bSqKqWiHfi9Krv=Lu74Yvquyrg@mail.gmail.com>
 <CAG48ez1v3J_VYnrP1RRCf936pvakphGQzvZZWw6tojiHA-BAxw@mail.gmail.com>
In-Reply-To: <CAG48ez1v3J_VYnrP1RRCf936pvakphGQzvZZWw6tojiHA-BAxw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 28 Jun 2018 20:15:27 -0400
Message-ID: <CAHC9VhS0wz5UACSiqyvsKH7SJ+Okz7CUUTmOhmCuj8x_mSOAaw@mail.gmail.com>
Subject: Re: [PATCH] selinux: move user accesses in selinuxfs out of locked regions
To:     jannh@google.com
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        security@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 6:40 PM Jann Horn <jannh@google.com> wrote:
>
> On Tue, Jun 26, 2018 at 12:36 AM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Mon, Jun 25, 2018 at 12:34 PM Jann Horn <jannh@google.com> wrote:
> > > If a user is accessing a file in selinuxfs with a pointer to a userspace
> > > buffer that is backed by e.g. a userfaultfd, the userspace access can
> > > stall indefinitely, which can block fsi->mutex if it is held.
> > >
> > > For sel_read_policy(), remove the locking, since this method doesn't seem
> > > to access anything that requires locking.
> >
> > Forgive me, I'm thinking about this quickly so I could be very wrong
> > here, but isn't the mutex needed to prevent problems in multi-threaded
> > apps hitting the same fd at the same time?
>
> sel_read_policy() operates on a read-only copy of the policy, accessed
> via ->private_data, allocated using vmalloc in sel_open_policy() via
> security_read_policy(). As far as I can tell, nothing can write to
> that read-only copy of the policy. None of the handlers in
> sel_policy_ops write - they just mmap as readonly (in which case
> you're already reading without locks, by the way) or read.

Great, thanks.

-- 
paul moore
www.paul-moore.com
