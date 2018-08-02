Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46731C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEDEC20C09
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hpIYcs0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEDEC20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbeHBItk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:49:40 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:45296 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbeHBItk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:49:40 -0400
Received: by mail-lf1-f46.google.com with SMTP id j143-v6so747527lfj.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 23:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GtNkRNAh6dvtg3WyBMJiLjaBMAgrxfJF3MmKf/gZxFs=;
        b=hpIYcs0uVjiFK3yDPyceIM0WozaydW1JX46xjrkol1nh/uirEpxkgH+GbL5Vgtv+4D
         1/pPFMTZn+Wkz25EX78jh6AeAGDowZrLR+H+zloUHIg7G6NSTmcAaCFevslZthj2NpfI
         meh8zeXHS6meOUZKS7WjNpvdXwcIQOcrQdrM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GtNkRNAh6dvtg3WyBMJiLjaBMAgrxfJF3MmKf/gZxFs=;
        b=FEEFx0dgMOA3XBhk32XEMOIKhdr4ogi1W8wKtQXS24NYmA0Kuq+88Eh3fL4MRet9sK
         +qzk2Rlor3gOKg8bF+vfB7Pw0PcatRvgigxnV35R/N9F8gzEKTdkR1lNOm09cNTdCyLT
         f+AKgYAQVkP0uVxkyug/K8Fa90ObGQfHSsRWFM3u9OIbWYz2lMIiqp+zDUX0hd3qKH8/
         iUYFnZ4yNcCrc/3l1sgLd70zXzAyiJIJebUIv1C/DouV3VN/rioGzkDx7YnbHXF9VGp4
         YDocxR2jzcrAnOXQqKVMU8jCuZ/4Vkv5vkXWO5aFTmZYrNcSMkRd1yQ4anU8BpTGDLAW
         c1Dg==
X-Gm-Message-State: AOUpUlFm8DVMGSGtGTWSk64lhYWBDKiaWIA+N0gtS+UfTizM7Hlz+49F
        u5mKiXES9SfTYOjohABDC5SGTEW1b1xHSmNz9DTxvw==
X-Google-Smtp-Source: AAOMgpdNdUR3Me6sk9Szp/BS4GXcxbZ5owkeqW73zYufC/W4O59U2Kt7tZivT2ryL3mFhI2VoREcj5RSqZ3I6nO29+Q=
X-Received: by 2002:a19:138b:: with SMTP id 11-v6mr955616lft.74.1533193194650;
 Wed, 01 Aug 2018 23:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAMi1Hd0fJuAgP09_KkbjyGwszOXmxcPybKyBxP3U1y5JUqxxSw@mail.gmail.com>
 <20180730130134.yvn5tcmoavuxtwt5@kshutemo-mobl1> <CA+55aFwxwCPZs=h5wy-5PELwfBVuTETm+wuZB5cM2SDoXJi68g@mail.gmail.com>
 <alpine.LSU.2.11.1807301410470.4805@eggly.anvils> <CA+55aFx3qR1FW0T3na25NrwLZAvpOdUEUJa879CnaJT2ZPfhkg@mail.gmail.com>
 <alpine.LSU.2.11.1807301940460.5904@eggly.anvils> <CALAqxLU3cmu4g+HaB6A7=VhY-hW=d9e68EZ=_4JiwX_BigzjPQ@mail.gmail.com>
 <CAMi1Hd0-2eDod4HiBifKCxY0cUUEW_A-yv7sZ7GRgL0whWQt+w@mail.gmail.com>
 <CA+55aFx=-tHXjv3gv4W=xYwM+VOHJQE5q5VyihkPK7s560x-vQ@mail.gmail.com>
 <20180731170328.ocb5oikwhwtkyzrj@kshutemo-mobl1> <20180731174349.GA12944@agluck-desk>
 <CA+55aFxJpJvcYKos-sVTsn9q4wK0-m4up1SXrcqfbXHKxaKxjg@mail.gmail.com>
In-Reply-To: <CA+55aFxJpJvcYKos-sVTsn9q4wK0-m4up1SXrcqfbXHKxaKxjg@mail.gmail.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Thu, 2 Aug 2018 12:29:18 +0530
Message-ID: <CAMi1Hd14yYr+LXTwjexMfFue9=PwoC7L8oscZhGm_eZ_is+v1A@mail.gmail.com>
Subject: Re: Linux 4.18-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     tony.luck@intel.com, kirill@shutemov.name,
        John Stultz <john.stultz@linaro.org>,
        Hugh Dickins <hughd@google.com>, willy@infradead.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>, aarcange@redhat.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, lkml <linux-kernel@vger.kernel.org>,
        youling 257 <youling257@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Colin Cross <ccross@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2018 at 22:45, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'd like to get this sorted out asap, although at this point I still
> think that I'll have to do an rc8 even though I feel like we may have
> caught everything.

No AOSP regressions in my limited smoke testing so far with
current HEAD: 6b4703768268 ("Merge branch 'fixes' of
git://git.armlinux.org.uk/~rmk/linux-arm"). Thanks.

Regards,
Amit Pundir
