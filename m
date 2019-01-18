Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC20C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C211620850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MJdW4DC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfARQXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:23:22 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33965 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfARQXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:23:17 -0500
Received: by mail-ot1-f68.google.com with SMTP id t5so9822403otk.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 08:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NYmAocf0BnEwnPh37EKXz0D4WFm/LnSM1+UNP94iKo8=;
        b=MJdW4DC2Se9FH7yLlU5PlbJZzU1r7UuXn0yRa/U5hmXRMBh/iWoYbv/RhguLKR0wVf
         /GonJfULt0d7uBJawZyXZJNZRjXkZ1o7wklHOrJtt9r+dleaq+zomyeN4sQBaBZsXVCQ
         e96dycDeBIz4XAFgdHR1MWrRPmbVk5C1K76PHMuETWNXME3m4Zvo7dMHgeM+s+LrLZwE
         THk4y3m5rrpvi0QOQSjQnB14FGxfw4JodJgmneTxvRrtQewW6tgdY+DPxJ9FDfT24Cce
         YwinyrkeLolMaK0FRfyZR6zQcing15NQnwNmRcjP9/6+GVRPK1oB/wMEIxkt+o4igLNb
         I0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NYmAocf0BnEwnPh37EKXz0D4WFm/LnSM1+UNP94iKo8=;
        b=Pg8av8MJ2oYxk6pXYEV98fza++wPnH9QWWfrQZ/c1IGSH5dl9OyDP+rL6KJUpzDREe
         lEjOKiTIyfEHtGz0E90+tPSMGhi40+VbYqXKV9AnS/PIIAjLOzGiI4/CRGrlVN7oUnTB
         aaui9084wIur+p0JY4SqmCf9y3HBWMDCmFUDbz/OW8VAEAC9jzbseAUva52ZeYZ7xuxg
         568fDOnzd3zCVaQoL2osFa1vV1h1z38nRgwJCLSRenRbCBnF/4hvTooO1wfJsnysnn2y
         kcwXRM42aWrY3C3geyRvkHkUTBL+1lQIR6icVPpXR6s0JqLNgejt0R04atA+45qFwLz/
         5srQ==
X-Gm-Message-State: AJcUukffSLCyjzjmOrTjhh5Q3AZ8Ea/pHGxaWRf+C09QY8tiTcPgvzjf
        ZhejPVU1ujKxO2JwoT9W7COqe4wxOIFQODa+RejomA==
X-Google-Smtp-Source: ALg8bN7s7otzwm266XA5K00JtEQEXGGMw1SxVQxX/NqxyxS9d2oQRVPBY+pW9G0iTx7MeqZB1uV9IbkXZA5+cxeVtuI=
X-Received: by 2002:a05:6830:1649:: with SMTP id h9mr11510356otr.292.1547828596116;
 Fri, 18 Jan 2019 08:23:16 -0800 (PST)
MIME-Version: 1.0
References: <20190114182318.110443-1-jannh@google.com> <20190115000046.GR27534@dastard>
In-Reply-To: <20190115000046.GR27534@dastard>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 18 Jan 2019 17:22:50 +0100
Message-ID: <CAG48ez22Mc=t7_=WpZdLFJhShk8xMQb=G2dem56NXK2JgXh-Ng@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fs: don't let getdents return bogus names
To:     Dave Chinner <david@fromorbit.com>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-alpha@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 1:01 AM Dave Chinner <david@fromorbit.com> wrote:
> On Mon, Jan 14, 2019 at 07:23:17PM +0100, Jann Horn wrote:
> > When you e.g. run `find` on a directory for which getdents returns
> > "filenames" that contain slashes, `find` passes those "filenames" back to
> > the kernel, which then interprets them as paths. That could conceivably
> > cause userspace to do something bad when accessing something like an
> > untrusted USB stick, but I'm not aware of any specific example.
> >
> > Instead of returning bogus filenames to userspace, return -EUCLEAN.
>
> Please don't use EUCLEAN directly to indicate filesystem corruption
> directly.  If we want to indicate that the filesystem is corrupted,
> please hoist the multiple XFS/ext4 definitions of:
>
> #define EFSCORRUPTED EUCLEAN
>
> up into include/uapi/asm-generic/errno.h and then use EFSCORRUPTED

Alright, I've added a patch that moves EFSCORRUPTED into the uapi
header in front of my series and changed the following patches to use
EFSCORRUPTED instead of EUCLEAN; see the v4 version I just sent out.
