Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495A2C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADDB242A1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzwsL/rs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EADDB242A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbeFVNYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 09:24:54 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35616 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbeFVNYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 09:24:51 -0400
Received: by mail-lf0-f66.google.com with SMTP id i15-v6so8867462lfc.2;
        Fri, 22 Jun 2018 06:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=c6RFhdx24gHjaHZ+lf0qUUpUPEvHeiAwmAcU+tUxyBo=;
        b=YzwsL/rsqos6nQ0xUVw3Qxn5ECJo7wfEQsFhcZ2lAnJ+FWoTqdjnaOvxsMEd18UVnp
         1+35IrY913G8kuiveZ6xWnZ3OpNdQBDpIcVC0Iqj1+LIBl1QPIkG9LOhbhreD8DHxsz3
         qv5hg/a97of7T3wfjFU9Rtl/+FgIjJZo+0CZSl/g71FIWx8pUTZEIOIf+uUxGiOlfo34
         35+2sqZ8dnCgQAKuxKyBIhlEUXOI3v4vhxYToeakqW722K8U+5CE0r/2wRzJFXNEgU3a
         hexM/76C5CUg2c60MdWWW1rTSbqKWwz1oxzG6MHLSyvn8UtAsRMpnc+5uXfV1U0U9ora
         965g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=c6RFhdx24gHjaHZ+lf0qUUpUPEvHeiAwmAcU+tUxyBo=;
        b=qYxgAhizZLgTiuGmF00LdPLDBGoNNTaMDAwAMhXLeqt4XHDWsuVRulo/sVJNgi0RAe
         XMev9EPS0vM8Se2rhXKkvpgIkn3j7kIs83EA66b12/W8FP7YXFiRR9OqT+wfxCv7q1b0
         bBksFeQ8LentD/FhSo3TzvCmBP9FYQ+MizI+aGWxk3S3ljbB+iosG4NUD2x8WKzmC8jp
         qppzGtQEE6haxD3AYQo5ejNo57GzpPI9dxWRJHbX1NDHRyjX+j5jGRbwwa70tuTs3HbI
         Sa7YaRGPm/ujlBx6Ja8ubbP7emNPmBjCTfjiDo0IqWf2+nC3TaWdXbewqyC5sMYCD+9m
         Zd7Q==
X-Gm-Message-State: APt69E0U/WX9/riu4jTTQ54tJHkMKK11R7/4YXq5UZafySPygXM0pZhp
        gx17nP7cn+Is2znh+2obCZsnLAk1YDcaO8MjA4U=
X-Google-Smtp-Source: ADUXVKJUCOEAwgLkTFTWnWO1SH3/dkA9kejRAuJpWbujpBNV43E8Wqaz2hRZPtshd0o5PmFcIw3rPQiwInCBbyH9XIo=
X-Received: by 2002:a2e:804c:: with SMTP id p12-v6mr1255181ljg.22.1529673890091;
 Fri, 22 Jun 2018 06:24:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 06:24:48
 -0700 (PDT)
In-Reply-To: <20180621202339.GC13748@dastard>
References: <20180620150138.49380-1-arnd@arndb.de> <20180621202339.GC13748@dastard>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Jun 2018 15:24:48 +0200
X-Google-Sender-Auth: RMDJeYxh2Yes9zjhh1Y-BGUHxbA
Message-ID: <CAK8P3a0C4hgu9apX8vE6BrqnrU76dHhafY8J-ppPBdhPbxq26Q@mail.gmail.com>
Subject: Re: [PATCH] vfs: replace current_kernel_time64 with ktime equivalent
To:     Dave Chinner <david@fromorbit.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Andi Kleen <andi.kleen@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jeff Layton <jlayton@redhat.com>, Jan Kara <jack@suse.cz>,
        Brian Foster <bfoster@redhat.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 10:23 PM, Dave Chinner <david@fromorbit.com> wrote:
> On Wed, Jun 20, 2018 at 05:01:24PM +0200, Arnd Bergmann wrote:

>> diff --git a/fs/inode.c b/fs/inode.c
>> index 2c300e981796..e27bd9334939 100644
>> --- a/fs/inode.c
>> +++ b/fs/inode.c
>> @@ -2133,7 +2133,9 @@ EXPORT_SYMBOL(timespec64_trunc);
>>   */
>>  struct timespec64 current_time(struct inode *inode)
>>  {
>> -     struct timespec64 now = current_kernel_time64();
>> +     struct timespec64 now;
>> +
>> +     ktime_get_coarse_real_ts64(&now);
>
> Can I just say as a filesystem dev who has no idea at all about
> kernel timer implementations: this is an awful API change.  There
> are hundreds of callers of current_time(), so I'm not going to be
> the only person looking at this function who has no clue about WTF
> "ktime_get_coarse_real" actually means or does. Further, this
> function is not documented, and jumps straight into internal time
> implementation stuff, so I'm lost straight away if somebody asks me
> "what does that function do"?. i.e. I have *no clue* what this
> function returns or why this code uses it.

You definitely have a point about the documentation. I meant to
fix that as part of the recent rework of the timekeeping.h header
but haven't finished it, partly because the header is still being
changed as we get rid of the older interfaces.

> i.e. the function goes from an obvious self documenting name that
> has been blessed as the current kernel timestamp to something that
> only people who work on the time subsystem understand and know when
> to use. It might make sense to you, but it sucks for everyone
> else....
>
> Keep the wrapper, please. Change it to ktime_get_current(), if you
> really must change the function namespace...

The thing about current_kernel_time/current_kernel_time64/
ktime_get_coarse_real_ts64 is that it hasn't been a good choice
as a default time accessor for a long time, pretty much everything
outside of current_time() has a better option:

- For measuring time intervals, you want a monotonic time source,
  not a 'real' one, to prevent time from going backwards during leap
  seconds or settimeofday() adjustments.
- For getting a timestamp as fast as possible, using a timespec64
  based interface adds extra overhead compared to 'jiffies' or
  ktime_t (64-bit nanoseconds), especially when passing the
  struct as the return value.
- As mentioned before, almost all machines these days have a
  fast clocksource device, so getting a 'coarse' timestamp is
  barely faster than an accurate one.
- Having an interface with (at best) millisecond precsision but
  nanosecond resolution can be confusing, as it suggests a much
  more precision than we can give (the 'coarse' in the name is
  meant to clarify that).

While changing over all device drivers from the old-style interfaces
with 32-bit time_t (current_kernel_time, get_seconds,
do_getimeofday and getnstimeofday, getrawmonotonic,
get_monotonic_coarse, get_monotonic_boottime), we tried to
also address those problems, using ktime_get() as the preferred
interface, or an interface with a longer name where we had
specific reasons.

Outside of file system timestamps, there are only two other
files left that ask for a timestamp that is both 'coarse' and
'realtime', and both only do that when user space specifically
asks for that combination.

       Arnd
