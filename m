Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39A6ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D762148E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="fHRYTKAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D762148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeJTBtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 21:49:33 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53733 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbeJTBtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 21:49:32 -0400
Received: by mail-it1-f194.google.com with SMTP id q70-v6so5209424itb.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 10:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8JSFsW4o40O8KZj0mDu5Ev8RmkQ3Fw9lxAJE8kguQs4=;
        b=fHRYTKAJyuU6K1PNDU4LDW/ff/BeP81AOrOGSFuu4DUcjaPGdOYt5P4SMw9X/rbe/1
         LzUw1YNFvSoaOlKrc20Wn4HLlx0v5239yBPD0O/zxK/2zlLZk2FPGxQJpdtiTIiqqG1w
         UiYvFG9atqqOrGif/BWp5SmtI/ew0M1YPMdXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8JSFsW4o40O8KZj0mDu5Ev8RmkQ3Fw9lxAJE8kguQs4=;
        b=pdtnwiVNIUPlaB6GZkArdqOghcuG8MRIYuxuFauY9YTxAwDPVIcQbP5ybbtAAV+LO3
         7G/HHKTQB4S/OZ9kXHvThFhfXDFA2QRMZeExXuNLOYMbhAOEBFQ0jWwX138VGEZjW2nI
         bJeCEso+gYnfzC1EwFBPPqRgqLvZ6UTPiVZAnrD0iKk+OHMLJGesufn2zOb0t2xsDOu1
         Ka7VHdeUGn8PVGTYoUjAa55vRgW0490iimenlgM5eyA+BTdZT7MhzJRnsgONM4aZgrcx
         p+cMG/Q2JaVSzNs/II75feQWYX4s8eF8CdmNK6MAZ9njEgGY/P25aa0G7ERDAw8DXnTf
         AmfQ==
X-Gm-Message-State: ABuFfojuLEyWdU7a3ib7fLDHjKAMda9wOMNzYNEQLhdeCWcFOgZU4BZk
        ZNMvCdS+3TBedyCIDavQWYCjpnovCLsaFf3g6RWpUg==
X-Google-Smtp-Source: ACcGV628AVqaTI7toxtM0tR9AISOiLZ5J3ubjgEVzJZxxMh8NxhWhN9voLAb5kqJpE2HRfVW29aX4x6cs7zpnitfohQ=
X-Received: by 2002:a24:75d6:: with SMTP id y205-v6mr3972264itc.1.1539970947827;
 Fri, 19 Oct 2018 10:42:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bf41:0:0:0:0:0 with HTTP; Fri, 19 Oct 2018 10:42:27
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <18142.1539964788@warthog.procyon.org.uk>
References: <20181019143932.6697-1-mszeredi@redhat.com> <18142.1539964788@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 19 Oct 2018 19:42:27 +0200
Message-ID: <CAJfpegtPv4+QxzcqMAGwTt7QALjBaxQtt2Qet98pdmuT1MRUeA@mail.gmail.com>
Subject: Re: [PATCH v2 6/5] statx: add STATX_RESULT_MASK flag
To:     David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Florian Weimer <fw@deneb.enyo.de>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 5:59 PM, David Howells <dhowells@redhat.com> wrote:
> Miklos Szeredi <mszeredi@redhat.com> wrote:
>
>> FUSE needs this, because it uses legacy inode initialization, that doesn't
>> return a result_mask, so needs a refresh when caller asks for it with
>> statx().
>
> Can't you just make it up in fuse?  Presumably, fuse doesn't support any of
> the non-basic statx fields either?

This is very much about the basic statx fields.  I.e. what does
result_mask == STATX_BASIC_STATS means?

 a) this is a legacy stat() implementation that doesn't fill in the
result_mask properly

 b) this is an up-todate stat() implementation that does fill the
result_mask properly and all fields are valid

There's no way to tell which one it is, and no way to request that
filesystem try b) even if it's more costly.

>> It might make sense later to promote this to a proper statx mask flag and
>> return it in stx_mask to userspace.
>
> That sounds kind of recursive - a bit in stx_mask would be saying whether or
> not stx_mask can be used.

Yes.  See above.

>> +#define STATX_RESULT_MASK STATX__RESERVED
>
> Please don't use that bit.

Using it internally is perfectly harmless.   If we'll need to extend
statx in the future and make use of this flag externally, then we can
easily move the internal flag somewhere else (e.g. extend request_mask
to 64bit, which we'll probably need to do anyway in that case).

Thanks,
Miklos
