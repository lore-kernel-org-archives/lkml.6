Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028D5C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 18:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B6E21746
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 18:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hEBIC3RX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B6E21746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbeHRVJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 17:09:03 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:43864 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeHRVJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 17:09:03 -0400
Received: by mail-io0-f193.google.com with SMTP id y10-v6so9436419ioa.10
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 11:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jg0cSf6D6k/sweiUgYs+ppSil1YMNovyfglpwqCS9OI=;
        b=hEBIC3RXW1hYc4G+o5lsIEGKWOQJacD6y94zzNRYYDH2BNn7650use0PYhgiBgza//
         X1+kMRUI/F/q71p726AW5UYz7YNNGbPwgiLVMFPwtNFeyp7q3cr0+di842l8uX6L4hF3
         jOoroeyOlVZHrmbwWljo7ZrgE42hxeqTYkHVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jg0cSf6D6k/sweiUgYs+ppSil1YMNovyfglpwqCS9OI=;
        b=VkIqbhpneMU6H4rJ8QM7l0RxCUjazf7NL6tNSERQl69haMPhd9U2cJfRW/yZHt9xgo
         yH8HZa3cwj77p9ZDU9LZUnyI5eL6qmKdhNSoc6GfVIvayRWNSNPYEkAz1jZoAhS/5CHM
         AnFbrK4hKk+lP9d6i9mcMw1aenqB5OAKS23khZmG9bfS7S4VDmG1goX1Com0bHJVE8PJ
         GAQltcyxQOI1UhnibltQurGjSWmMRilrYM3a+/IWru8znesDuxmRrIMJd8FekQ1gc1cf
         SvUHNYfNVNflTUdLaGZ3XfTRmJtTDihOpU4RzG+8FPTpZvmMBxawfTMSeKbFebAkQuVn
         cggg==
X-Gm-Message-State: AOUpUlFOjyAkUF7PhiBB+2/V9ymCnGQhae9i61UBNEmgNDRWrc9HM9NW
        N2ASKR1NLGOgmsJlRXulUoQntwU/C+npt00nXAE=
X-Google-Smtp-Source: AA+uWPxhmUt9ejguwa4iP5gFPzBH86aAjp1+Xc9Y89RUnpOvXZxZlovBBxxmoSKTMbPziacrf7d82Nq6bvZoPl5mQDg=
X-Received: by 2002:a6b:f609:: with SMTP id n9-v6mr17254403ioh.259.1534615231680;
 Sat, 18 Aug 2018 11:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180818155724.GA22569@kroah.com>
In-Reply-To: <20180818155724.GA22569@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Aug 2018 11:00:20 -0700
Message-ID: <CA+55aFzB8vSuRatQAy=LmLxjeU48dPwW3tOGpZQaBjWRw115aQ@mail.gmail.com>
Subject: Re: [GIT PULL] Staging/IIO driver patches for 4.19-rc1
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Driver Project <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2018 at 8:57 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Note, you will have a merge problem with a device tree IIO file and the
> MAINTAINERS file, both resolutions are easy, just take all changed.

Heh, no. In neither case should I take all changes: the IIO was
"delete both sides"), and in the MAINTAINERS file, which was delete
one side, add another, somebody can't even sort stuff alphabetically.

> There will be a skein file merge issue as well, but that file got
> deleted so just drop that.

Yes indeed.

           Linus
