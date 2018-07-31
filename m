Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F51AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D465A208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EGpOBEgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D465A208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732223AbeGaUoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 16:44:38 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:51409 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731659AbeGaUoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 16:44:38 -0400
Received: by mail-it0-f45.google.com with SMTP id e14-v6so6083313itf.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 12:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ceho5vLdE9wvkgDTCbh4n3Y/OylVzwRSaoaDeZv7MeY=;
        b=EGpOBEgI2j/ZwyP2L0Z0JP+iCGBNhPAurDfq11ppk34/WqqXH/JAb7UzszomA5UK4K
         z2ZD7nGM9OHXsVGdJ409FVdMVPBEbOjcZXsnWV0t2DEbnZpgbGUEZ/xyVmVG3cPH6Bgq
         mablzoI4B5RR8c/ht391+JivkxkjL0VbQ0i8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ceho5vLdE9wvkgDTCbh4n3Y/OylVzwRSaoaDeZv7MeY=;
        b=LlLbL4p+Ogo3WJLlDHgo4o23L9xiXOP5cAm/NuAF+gU0ROoAxBHi4miGq4zfIZrXcf
         cpK6GMBh7Sjml73E4621jyL1goz+Ga8xHJQpT6RTCkNpm8BEz5XawnOm/fa/FImp5LaX
         NLi8F1y6XdbaxgPMAnRsJPgWPsYUJv32h2szSePwckJwuKdwsKDflyB08B+RFRYAKyG8
         D7LCasEvSgYkuU1JdxhCTbauvga5rvl2dRaYo6IBNfRkLFE/kFhpFLNbtnuZoRGi72LI
         rqAzjWhRMIHnbf40nInzeZQHoKPj84jvII6hGSSUhquWgUGyjx3g+0ZRLiQsJavjEZfV
         URYQ==
X-Gm-Message-State: AOUpUlH1r4SNvcFMsgTVvzVcBKm8Iaf2byWr2qTSiBQMZOXUxZfRDLx3
        vVgbIQfVJZByR4+9HpgIP6SRcqKRgKDXl0UmkSE=
X-Google-Smtp-Source: AAOMgpem150MCwsIH2K7goxkq4ucDCDelz0zAdb/z/RsinXwYWBv5NQX5g1IURbuCEHYJ1o0Gd5QbDqS4qMBR7rcEF8=
X-Received: by 2002:a24:94f:: with SMTP id 76-v6mr799261itm.113.1533063776917;
 Tue, 31 Jul 2018 12:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAMi1Hd0fJuAgP09_KkbjyGwszOXmxcPybKyBxP3U1y5JUqxxSw@mail.gmail.com>
 <20180730130134.yvn5tcmoavuxtwt5@kshutemo-mobl1> <CA+55aFwxwCPZs=h5wy-5PELwfBVuTETm+wuZB5cM2SDoXJi68g@mail.gmail.com>
 <alpine.LSU.2.11.1807301410470.4805@eggly.anvils> <CA+55aFx3qR1FW0T3na25NrwLZAvpOdUEUJa879CnaJT2ZPfhkg@mail.gmail.com>
 <alpine.LSU.2.11.1807301940460.5904@eggly.anvils> <CALAqxLU3cmu4g+HaB6A7=VhY-hW=d9e68EZ=_4JiwX_BigzjPQ@mail.gmail.com>
 <CAMi1Hd0-2eDod4HiBifKCxY0cUUEW_A-yv7sZ7GRgL0whWQt+w@mail.gmail.com>
 <CA+55aFx=-tHXjv3gv4W=xYwM+VOHJQE5q5VyihkPK7s560x-vQ@mail.gmail.com>
 <20180731170328.ocb5oikwhwtkyzrj@kshutemo-mobl1> <20180731174349.GA12944@agluck-desk>
In-Reply-To: <20180731174349.GA12944@agluck-desk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 31 Jul 2018 12:02:45 -0700
Message-ID: <CA+55aFzHRaNMHxLCEa5Zke-1FgbQ4rtHf8-HOu0zBzo4Liz88A@mail.gmail.com>
Subject: Re: Linux 4.18-rc7
To:     Tony Luck <tony.luck@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Amit Pundir <amit.pundir@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        youling 257 <youling257@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Colin Cross <ccross@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 10:43 AM Luck, Tony <tony.luck@intel.com> wrote:
>
> If I just revert bfd40eaff5ab ("mm: fix vma_is_anonymous() false-positives")
> then ia64 boots again.

Ok, so it's not just the ashmem thing.

I think I'll do an rc8 with the revert, just so that we'll have some
time to figure this out. It's only Tuesday, but I already have 90
commits since rc7, so this isn't the only issue we're having.

I _prefer_ just the regular cadence of releases, but when I have a
reason to delay, I'll delay.

                 Linus
