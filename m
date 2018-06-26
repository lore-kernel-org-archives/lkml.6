Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7910FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327EB26D98
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWuLAo3b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327EB26D98
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752075AbeFZQIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:08:07 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36094 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751869AbeFZQIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:08:05 -0400
Received: by mail-lj1-f195.google.com with SMTP id o26-v6so9234955ljg.3;
        Tue, 26 Jun 2018 09:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YopPZTP+JGuzNYqSgJzVrvGaTISA4nW/vALmxAfKv7k=;
        b=jWuLAo3bmPqmS4ZRWlxEqbmQt5DlrmWrX3Z8zXGjDbRA9PYKdVjQhQSovzjMkKXtL/
         YH7PdKe6kkFlpDO+iYSFCxFW2MDVeSlgCjkvBbBOiK0liXk1CHPcoO7klSkVOkFDEFuH
         y4mgS3AALhuTbqi9oSlKd5Yn0AciVCZIDFvRXZUjZARI7dg5Io8Lr3uylQ8WB+y5GmTZ
         Ul44Wm9I0/8gNOnJcSwYvq8uBSRfYneHpyERphK/pX5pmEBkvLyQH0PPbq67FUEx9ftJ
         JrswtSHfZeXPmsJqoqudfX+zgdhZnrtMSbMGnP4+10dhrQWEYnmlw//VB2wNicROrahc
         M+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=YopPZTP+JGuzNYqSgJzVrvGaTISA4nW/vALmxAfKv7k=;
        b=cbuUGq+++ZxCYFFcMd65LR011+RvUUxw2dkMLV8hISB0XQPruYRkjFhxdq0TeosYvx
         SaugFl0o2Me6dMDuHzenUNGq44Edhf/tkZCNtE7r/EYC1Qt6z6TBqg3YeXT3d1Wx7bZD
         6a4xiRLoUpydPFC6d/mHH9XrewvJQbBeoZINLcqXnTH6fCxTckzzjjAanEblsz6RpNsm
         8luFy68BuRihItFKVT520MP7CPgThGn2360+ey00xMTrStygfpGBzihJTu2RzJ5A17Gc
         6P0lciAPZjvBpjsJuX9U5PNzyL7H/7JGMDU8ZnKg1uSdfr7RtrQEKF93ZI6OxbG6tF3e
         JI5Q==
X-Gm-Message-State: APt69E2PDsiSPBT9NMvOm8Uxk2vWeIURWQGgbdgvj9s1iX0J6Q78/B24
        mRFZd1qZRktM5hHzKuuwd3yVmYqzKPwosSePQIA=
X-Google-Smtp-Source: AAOMgper0jY3yR3Qm+ZV5wBkmqxbcUzCRzrqwHmAWfCDgJULmsqAXUBgClvdTEOrdKr7pqDAcbuG5BP+kpaJbgKuuvc=
X-Received: by 2002:a2e:545a:: with SMTP id y26-v6mr1567520ljd.19.1530029284128;
 Tue, 26 Jun 2018 09:08:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41cf:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 09:08:01
 -0700 (PDT)
In-Reply-To: <20180626002417.GH13748@dastard>
References: <20180620150138.49380-1-arnd@arndb.de> <20180621202339.GC13748@dastard>
 <CAK8P3a0C4hgu9apX8vE6BrqnrU76dHhafY8J-ppPBdhPbxq26Q@mail.gmail.com> <20180626002417.GH13748@dastard>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 26 Jun 2018 18:08:01 +0200
X-Google-Sender-Auth: 6OdCMazBu2EbvkgbFDvnwBUIA34
Message-ID: <CAK8P3a3VDM33VyH03=QK6fMoC5M1rNOLn3UE+Swgfg_JkKmC=Q@mail.gmail.com>
Subject: Re: [Y2038] [PATCH] vfs: replace current_kernel_time64 with ktime equivalent
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Brian Foster <bfoster@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andi Kleen <andi.kleen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 2:24 AM, Dave Chinner <david@fromorbit.com> wrote:
> On Fri, Jun 22, 2018 at 03:24:48PM +0200, Arnd Bergmann wrote:
>> On Thu, Jun 21, 2018 at 10:23 PM, Dave Chinner <david@fromorbit.com> wrote:
>> > On Wed, Jun 20, 2018 at 05:01:24PM +0200, Arnd Bergmann wrote:

>> You definitely have a point about the documentation. I meant to
>> fix that as part of the recent rework of the timekeeping.h header
>> but haven't finished it, partly because the header is still being
>> changed as we get rid of the older interfaces.
>
> The interface documentation should be introduced with the new
> interfaces, not left for later as that leaves people like me with no
> fucking clue about what the changes actually mean or why they are
> being done.  Perhaps you'd have done better to explain this API as
> an internal implementation of clock_gettime(CLOCK_REALTIME_COARSE),
> which is clearly documented in the man page as:
>
> "Use when you need very fast, but not fine-grained timestamps."
>
> Put that comment on ktime_get_coarse_real_ts64(), and almost all the
> questions about "WTF does this whacky function do?" go away....

I've tried to come up with a coherent documentation now and sent a
patch for that. For this version, I ended up not documenting each of the
ktime_get() functions separately but instead added a new file in the
core-api documentation and a reference to that from the header. This
seemed easier to understand than duplicating the same text for over
30 very similar interfaces.

       Arnd
