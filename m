Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F070C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1BD21871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZGAMCUfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfADGPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 01:15:40 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:37994 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfADGPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 01:15:39 -0500
Received: by mail-io1-f68.google.com with SMTP id l14so28813407ioj.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 22:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ev6wCd3WGUDYy3CAfTM8jY1OontnBJ6vvtZ5PdfwR/0=;
        b=ZGAMCUfptbhR+b8B0WZGiM12RZUcwnAXZJfirg8ykfqS/g7YD9FcqWFi/C09cFSCvK
         /DmxeJk6kVyR2bsq0lBBr1Yfjjiq1VpVrbQzUNOEi5NBSQ5cGYhIl9pVFM4kyMwNmsHF
         C9L2Nd1ZhptfzSBXz+pNlys/hh6lUNvHG5wW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ev6wCd3WGUDYy3CAfTM8jY1OontnBJ6vvtZ5PdfwR/0=;
        b=oY4XPmeXxUgC2xWzBx3GnDU0CbJMk8PtQAkmVnvLd8bQV2iBGsDe0MjehbK7FajKHD
         UnxaacNhur9Kvp5T+N+GJ/RJsyqP61zG/sNjlFWC3skCQjE00MS4DGY6smZVaKd5KqMQ
         j6AV9wY8p3FdvOCwkeYmz9xIdgWXS19ducJsyt3nhNqA/mPZl3KJCZ4r2ZNuad/aLLOJ
         aosF9hqk6LrTN8k9MreKk9MD+X/qjSmApm5m5DLsm0LrWwRyp0JQLUD0BypEcI1yfTHQ
         f24cMso1Lyb8Zy8ifsQwVdQwbUmp2E7A4IhhU2Go4L2e0vgK5wTjsKxvxNfcjdpl9Kjc
         NEGA==
X-Gm-Message-State: AJcUukdxM7Lu0XyMwbvZwIMtLtQvZ/5jfTvwEMbRcQuftJLQVCkqGIrP
        hyqYCPSdyfc0L7pb1el95qznDXOBNPZQZ96iZhC2QQ==
X-Google-Smtp-Source: ALg8bN4UHseyAHB9XxA4OANE1qq/dkl4oZNlgniVD2bWiLhPihfDZf2XsyhWhQALLFkT8ROr9gn20WHm8o5BRK6yp+M=
X-Received: by 2002:a6b:6919:: with SMTP id e25mr2097325ioc.119.1546582538878;
 Thu, 03 Jan 2019 22:15:38 -0800 (PST)
MIME-Version: 1.0
References: <1546442912-20818-1-git-send-email-firoz.khan@linaro.org>
 <1546442912-20818-3-git-send-email-firoz.khan@linaro.org> <CAMo8Bf+qK=k33boeNOeL69sLC3e-M07QK9ErhYm-byuQ2UnVnw@mail.gmail.com>
 <CALxhOnhgAEeEFhL2fgjDSCBMJo7dF5jiuGKCXjWYjMJmHefMgA@mail.gmail.com> <CAMo8BfJi-CLHHy1CWGZ_KhP2ddZxxHM+CafkjJRd=cC35aNF8g@mail.gmail.com>
In-Reply-To: <CAMo8BfJi-CLHHy1CWGZ_KhP2ddZxxHM+CafkjJRd=cC35aNF8g@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Fri, 4 Jan 2019 11:45:27 +0530
Message-ID: <CALxhOnjyHri6rmAs+toXYBb2toniFV7AYhoBR+-fOhOk1=Uh9w@mail.gmail.com>
Subject: Re: [PATCH 2/2] xtensa: generate uapi header and syscall table header files
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Chris Zankel <chris@zankel.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-xtensa@linux-xtensa.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

On Fri, 4 Jan 2019 at 11:29, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> On Thu, Jan 3, 2019 at 9:13 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> > On Fri, 4 Jan 2019 at 04:14, Max Filippov <jcmvbkbc@gmail.com> wrote:
> >
> > This build rule is unused now as I was tried to implement
> > something else. Hopefully I'll remove the the above change
> > in my v2.
>
> Then maybe there's a way to move all these macros to a common
> makefile, as they seem to be fairly generic?


Good idea! Sure, I'll look into it.

Thanks
Firoz
