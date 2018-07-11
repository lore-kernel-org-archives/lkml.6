Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F21C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C8320C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WZW4aIFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C8320C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389247AbeGKUHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:07:08 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36133 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389156AbeGKUHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:07:07 -0400
Received: by mail-pl0-f68.google.com with SMTP id a7-v6so9618336plp.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 13:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UwfGoly37vOCMD2GS3x1U3p435ibCuyuVdvBfvi/Tog=;
        b=WZW4aIFeM0EXK7S7FsS5OwGx+eZvTSi9c61Ux1+mLAI3HFD1pKqOoX/zKSZwPmqxDi
         MrUt6y/pNTH0aErhXmhAE9MbYQNetpTeaeXskGIpc+hMiCxpdjTzF3dk1JwevwfGEti9
         7BUL75njyhATyYLz1Hr5fkR2RVWvn81aLt9nZu6gP3bYZsy6jTlAvZ4fnIS1sL1RQFsE
         1a98Sxe6loWMR6ZMWXrxCCbsZAp2X+7gxsg9kObduINGHTVETQ1mL9cNPEp1lFnSDyV/
         S9rtYq/55uDFuXvgFAhDJ3wm4lj+Q1ZSjW/eDVivXikHsb8CB7i9+s7LsTNXDR4L6nqn
         I+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UwfGoly37vOCMD2GS3x1U3p435ibCuyuVdvBfvi/Tog=;
        b=G0222Rd/UyqYSS9Lh63TB0TNbdwMoufz8dOEPdjKsNbaRboIv4vPc1csgbJmHTlkOD
         7oMLpPFx0zqxVrlYO03Gw8WuYrE+APFSB6zWdNdbEcxP3vLEFTNW0UVg0JDl+oyl3v3j
         vs77XpuA833Gzd0HjKSZVzqLImdSpXc30hYBd7OmignZQ9aEdIzMUB/npzlwevjUpNzJ
         60GfWX+iPk6lls1m98lTuDusjHVbF85ANonwtxpN7lIaFfZYpXVlUIiucM7SkYkNJrnw
         6SxhvZ+wk5JCILbBo38YQeVG/68KpsQMvlRvit0icPUDXH76GWAJyRuvD/LX06np/aKR
         mreg==
X-Gm-Message-State: AOUpUlGe7H+XUmNto0By7QOCy7CoGxsJQJuAtPVaSqjKU3sDXg/D3z+e
        fMtiR7qGwHdh8Sk5oLgCDY6I2+ZTm3mheN350GPD6XxPilU=
X-Google-Smtp-Source: AAOMgpckc6WM9p9AWz1Dx8fjem0f9Knbkge7iHAqdTZsnRHh45qUtNW+2vQEB1t9c3qDFq6Bn2EIBeZVrwBGko4ZcV4=
X-Received: by 2002:a17:902:740b:: with SMTP id g11-v6mr36620pll.85.1531339272629;
 Wed, 11 Jul 2018 13:01:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:950a:0:0:0:0 with HTTP; Wed, 11 Jul 2018 13:00:52
 -0700 (PDT)
In-Reply-To: <20180711195245.7lavjauhy4dclfwm@linux-r8p5>
References: <20180709151019.1336-1-manfred@colorfullife.com>
 <20180709151019.1336-8-manfred@colorfullife.com> <20180711195245.7lavjauhy4dclfwm@linux-r8p5>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 11 Jul 2018 22:00:52 +0200
Message-ID: <CACT4Y+bohJFTUOnZRGks40ZxDwkc2qBRYXi7PMZXoNjj-wXqWQ@mail.gmail.com>
Subject: Re: [PATCH 07/12] ipc_idr_alloc refactoring
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Manfred Spraul <manfred@colorfullife.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 9:52 PM, Davidlohr Bueso <dave@stgolabs.net> wrote:
> On Mon, 09 Jul 2018, Manfred Spraul wrote:
>
>> From: Dmitry Vyukov <dvyukov@google.com>
>>
>> ipc_idr_alloc refactoring
>
> ENOCHANGELOG


Manfred, could you please squash this into your commit? This was meant
to be a code review comment rather than a full-fledged patch.
As far as I remember, there are now 3 patches that can be squashed:
your original change, my refactoring on top, and your fix to my
refactoring.
