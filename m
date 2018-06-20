Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01946C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A092D2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="To9Vu6Jy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A092D2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754279AbeFTQOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:14:54 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35364 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754065AbeFTQOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:14:53 -0400
Received: by mail-lf0-f68.google.com with SMTP id i15-v6so183572lfc.2;
        Wed, 20 Jun 2018 09:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=SmDENu7oSmkRq+mSNZwnIUI8z+thKxil9tRStJL+SdU=;
        b=To9Vu6JyWFvoEtIaiucb1J6181QLfGFAt/EqQRDibIwwiLUNBk1WdOXZ3F7gTq4/li
         vctL3qbVdeSfa6ptpnrQV/9r1m/APzwToBg6lOV9BJBYKf5bi54BY1LpTNBK10qs8lDG
         zLleUfZnTSZ1jQGcAOLKlIoF2+VroFOfYWc+g+NdDnSCvcWJ/nbSCbF3q7IcyEAvb90l
         Hv1Jbig9qMnjS5MPcTm3zAO4Cxj+Sq1a00NiF81Xt1RCu0uHE/a6u2Kw+yzBXnrp+Le7
         IsrxMlnuiKcx/tsGquzT88ITd1kpFp3nNHfqeWr/gPw+GWVOgx/MN/LWqnc0P+sSdUaI
         0bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=SmDENu7oSmkRq+mSNZwnIUI8z+thKxil9tRStJL+SdU=;
        b=ha0XWLisJ3Gy8+GqytQmJAHwS2MAVGf4IGUImhduha8eBVsd7Rgarw/XdoK90+ul4N
         5Jq5Awz34c1Y3d5g9rWy+Blrv1DXgObOGVgrXrvOY52pFJEvT+nfY8Nk24y4HRXjweXj
         M65tYnn3YNB12pLcgI9B8hot4CK2rNEOaPxeTQVHzePrMQoqr9N9HrvspuWeC01cPi2V
         IQujqUkrp6iyszP3vsaz7zoosX7Xyc0bMvJcTIBIctp7WtGrqKk/luVlM9GdPX7Z3x/P
         2I6z5vKBclO1hedH+PBYyfWeOHm+TAR150f6Ln5S/cYnL3VCjQZjW0A4gUoIMfWDTyDb
         vRug==
X-Gm-Message-State: APt69E0XCbnjuSwXmR7lS9jFzi2OjuwaPka68Myc/yzK7enyuvWbpxLC
        DoPowBCslVd4a1DG5s3LwwnCjkrElj+sXAX1AsY=
X-Google-Smtp-Source: ADUXVKJv0ihOPYXgN144GQ12DDO5sdO9KUYDsBjXN6h9eOssTy6M5wTYciAstD+KlY5b64ThEd9truaQOfMbB85Az8Q=
X-Received: by 2002:a19:c004:: with SMTP id q4-v6mr12792339lff.16.1529511291275;
 Wed, 20 Jun 2018 09:14:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 09:14:50
 -0700 (PDT)
In-Reply-To: <87r2l1sby0.fsf@linux.intel.com>
References: <20180620150138.49380-1-arnd@arndb.de> <87r2l1sby0.fsf@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Jun 2018 18:14:50 +0200
X-Google-Sender-Auth: TJ5idne_X_TBtZVSBcUf5kwdQ08
Message-ID: <CAK8P3a1J9j7pz-d+otbJweWgOZZePdaMJEb_sU2GJKi3oYq7Xg@mail.gmail.com>
Subject: Re: [PATCH] vfs: replace current_kernel_time64 with ktime equivalent
To:     Andi Kleen <ak@linux.intel.com>
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

On Wed, Jun 20, 2018 at 5:40 PM, Andi Kleen <ak@linux.intel.com> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
>>
>> I traced the original addition of the current_kernel_time() call to set
>> the nanosecond fields back to linux-2.5.48, where Andi Kleen added a
>> patch with subject "nanosecond stat timefields". This adds the original
>> call to current_kernel_time and the truncation to the resolution of the
>> file system, but makes no mention of the intended accuracy.  At the time,
>> we had a do_gettimeofday() interface that on some architectures could
>> return a microsecond-resolution timestamp, but there was no interface
>> for getting an accurate timestamp in nanosecond resolution, neither inside
>> the kernel nor from user space. This makes me suspect that the use of
>> coarse timestamps was never really a conscious decision but instead
>> a result of whatever API was available 16 years ago.
>
> Kind of. VFS/system calls are expensive enough that you need multiple us
> in and out so us resolution was considered good enough.

To clarify: current_kernel_time() uses at most millisecond resolution rather
than microsecond, as tkr_mono.xtime_nsec only gets updated during the
timer tick.

Has that time scale changed over the past 16 years as CPUs got faster
(and system call entry times slower down again with recent changes)?

I tried a simple test on the shell, in tmpfs here and saw:

$ for i in `seq -w 100000` ; do > $i ; done
$ stat * | less | grep Modify | uniq -c | head
    601 Modify: 2018-06-20 18:04:48.794314629 +0200
    920 Modify: 2018-06-20 18:04:48.798314691 +0200
    936 Modify: 2018-06-20 18:04:48.802314753 +0200
    937 Modify: 2018-06-20 18:04:48.806314816 +0200
    901 Modify: 2018-06-20 18:04:48.810314878 +0200
    929 Modify: 2018-06-20 18:04:48.814314940 +0200
    931 Modify: 2018-06-20 18:04:48.818315002 +0200
    894 Modify: 2018-06-20 18:04:48.822315064 +0200
    952 Modify: 2018-06-20 18:04:48.826315128 +0200
    898 Modify: 2018-06-20 18:04:48.830315190 +0200

which indicates that the result of ktime_get_coarse_real_ts64()
gets updated every four milliseconds here (matching the
CONFIG_HZ_250 setting in my running kernel), and that
we can create around 900 files during that time that each
get the same timestamp (strace shows 10 system calls for
each new file). Trying the same on btrfs, I get around 260
files per jiffy.

> Also if you do this change you really need to do some benchmarks,
> especially on setups without lazy atime. This might potentially
> cause a lot more inode flushes.

Good point. On the other hand, there may be some reasons to
do it even if there is a noticeable overhead, in cases where we
actually want hires timestamps, so perhaps this could be
a mount option.

     Arnd
