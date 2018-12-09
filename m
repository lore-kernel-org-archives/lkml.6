Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DA0C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6558020855
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TVZlko1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6558020855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbeLISCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 13:02:13 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35335 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeLISCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 13:02:12 -0500
Received: by mail-lf1-f66.google.com with SMTP id e26so6372458lfc.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 10:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6nqrSh4+r2l2a/wn1yNWw2cZsd4SOVCuulQ6rPOnYvg=;
        b=TVZlko1v7k8BSpJ8+vraqnjdPJH7jQTeQJScdMc7aZ2mqdIEse2CHRTLEJmh9WyoVh
         ysKfbS7A/TllAZ2J7F9eZWlTnOlyRxgX9oOxP11JTW8ZAWw9QwLO0y3ycgeQK5krnRWS
         IwrXsIV4kVQOiwE/Od/z4CbN/hCVfLIxtC0pM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6nqrSh4+r2l2a/wn1yNWw2cZsd4SOVCuulQ6rPOnYvg=;
        b=dlPk+SLbSGiALdRiSqHuYTUfwZ3wZe13L4Ob/Irkeh7R8oHzjp5YX3ecuyce9185Hq
         7lUKPXtOJT3uzKGpvG/U95ZK7r7Eg+++vXFiQIBkEwchLykfiUlA40zkphG88L+JHN8O
         L56189kv8L+5j9zyg1OGz2o4jjst/A1554mJV9oihXUUUHbHR8/4xRPi2ozt/9R9aRhX
         0uU3350OT0Ktda0ohrbz6JUYlwz5OS5RCe1u73medTIHvh2CiakFDy0eUOWNz3lfeGpO
         lvVAxlNo9uyuYX9SZ4oLSDQ+woO+xFYDkGM0+YZXQDrYJbIhthrHYQ9bKmL4WFIQILOo
         CNeA==
X-Gm-Message-State: AA+aEWb492IggEFfUwD5Z5li3ruO6hWCFniCr2n6MhXoSdoeBt16xYgw
        MEuONWYrliBZTwI4nRXwgFtpe8OLWqo=
X-Google-Smtp-Source: AFSGD/UjM/MHwi4u9+14oNxhYrULrgy0w8TGR6EE3sXVI16Zcu76FVkH2p9SxeafsAiW1SBf82Rm1A==
X-Received: by 2002:a19:22c2:: with SMTP id i185mr5562616lfi.2.1544378529982;
        Sun, 09 Dec 2018 10:02:09 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id v11-v6sm1708751ljc.57.2018.12.09.10.02.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 10:02:08 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id i26so6380606lfc.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 10:02:08 -0800 (PST)
X-Received: by 2002:a19:4287:: with SMTP id p129mr5438560lfa.135.1544378527664;
 Sun, 09 Dec 2018 10:02:07 -0800 (PST)
MIME-Version: 1.0
References: <6be0835bf256755375f3b5822bf70d74538d1d6e.camel@intel.com>
In-Reply-To: <6be0835bf256755375f3b5822bf70d74538d1d6e.camel@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 9 Dec 2018 10:01:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgAONwr6pMn+D2OsMZjAB5zNaMWSW5KdTM+L72gGnhV2Q@mail.gmail.com>
Message-ID: <CAHk-=wgAONwr6pMn+D2OsMZjAB5zNaMWSW5KdTM+L72gGnhV2Q@mail.gmail.com>
Subject: Re: [GIT PULL] dax fixes for 4.20-rc6
To:     dan.j.williams@intel.com
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 8, 2018 at 10:26 PM Williams, Dan J
<dan.j.williams@intel.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-fixes-4.20-rc6

What's going on with the odd non-exclusive exclusive wait?

        prepare_to_wait_exclusive(wq, &ewait.wait, TASK_UNINTERRUPTIBLE);
        ...
        /*
         * Entry lock waits are exclusive. Wake up the next waiter since
         * we aren't sure we will acquire the entry lock and thus wake
         * the next waiter up on unlock.
         */
        if (waitqueue_active(wq))
                __wake_up(wq, TASK_NORMAL, 1, &ewait.key);

that seems to make little or no sense.

Why isn't that prepare_to_wait_exclusive() just a regular
prepare_to_wait(), and then the whole "let's wake up anybody else" can
be removed?

I've pulled it, but am awaiting explanation of what looks like some
pretty crazy code. I *suspect* it's a copy-and-paste situation where
you took the exclusive wait from somewhere else.

                Linus
