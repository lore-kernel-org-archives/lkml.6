Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA77C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 23:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF241214FF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 23:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="rPnKGZIY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UXGNHilG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF241214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbeHCBU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:20:29 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:37202 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbeHCBU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:20:26 -0400
Received: by mail-yb0-f193.google.com with SMTP id r3-v6so1995667ybo.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 16:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=dp3PYwra6B5xcGz0gyjHd/0RAfX6wl1csAz/i93M4i8=;
        b=rPnKGZIYDP75afzf3EQ46PlUSWcal0uBeu0+MtntIHJkTT3LOJkfIdycsWEoZpUPbo
         ecEdCjndYvUcPPdXTuXFc33kFOt1ndoo+YVCYquOgQgG68xft7uKfLothGxkEX9YtEaP
         324Qbql4R/a2VdjB25YSj63j/BZwNcCDuVTszaiyKFnYZ8yF6BBZR6DYF1AHcBFVIINx
         Fitv55YJb025fywn8EbdlKh4nS3WM1N7Fx/8l6pyd1pKFqbQFPm5sbfnNwNkSAedAQXE
         QFWD0Pzn6gFViVAzoONiMe5MUSCfa788ecyfwekjmut5ceDGcSFzWRi2WHMB2F2LJX/a
         zNLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=dp3PYwra6B5xcGz0gyjHd/0RAfX6wl1csAz/i93M4i8=;
        b=UXGNHilGf7OptB0QStEfhQxEoDDQhsq4mx+ij0C418PLKGW5fuNl8cZiTuCa0WBeto
         4HsAb26lWsEpSsv0hYvGYl1vV+OBNlRMY7+k/X0ozfxkPqDcKyNM7fT9lIPvWiqp7dCm
         FmRNUAtL9/Pmv1NkYaXDFbrcIg7XDhu3W1HBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=dp3PYwra6B5xcGz0gyjHd/0RAfX6wl1csAz/i93M4i8=;
        b=CK6xtVKHYALCrM0nPHh8hB1QY9xrG947nss0YXfFk4rh2GNuDaKk80JTWKBBgs5jZm
         UvYk0lFd5TcSdO0a/kTmKowCd2V1x4MQ9IzOdQT31HsKOIUWeaIo0+NkoEajyk+pQxYX
         Ub0nqOxKbodIF1Yy15S8/zKYSOBJ56u5oyoCJQQTyEcW6az9O9bin6iHY16vBRSQgZ0O
         3QfP6AoCUdW9Ex0HhD9ieGQ8jgAAlgGi3xiZKffuqHzfuWCM6nrHH3i9/4AwZWQvsVrQ
         4XA/hyoOsvvhcOdj6P6VbDoLPRtXFI/01OVbk3N8fbSAZ7kQ7o+tDNQr9SCeey9caZHc
         8BBw==
X-Gm-Message-State: AOUpUlGr075gt9QC/F8SsPtdK012/oU8dMmItZ6eIMBMjlyarVhuYU+V
        J/j5Q1HxzDFJAHKKJNAZu+blqV9HpMA3vxM5UIPBDQ==
X-Google-Smtp-Source: AAOMgpeGV5uC1fice/SE+GbIi2ERL76OCjm56SJ4ep0u5/OVx+AbgJHbosGuhjiUn1rSYefxPnxq3FZUwlRvCqmWV0s=
X-Received: by 2002:a25:a302:: with SMTP id d2-v6mr887127ybi.193.1533252422189;
 Thu, 02 Aug 2018 16:27:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Thu, 2 Aug 2018 16:27:01 -0700 (PDT)
In-Reply-To: <CAK8P3a1tph9VPJnYYhBvH_1wZ79wXDvfnJt_CEruj3T-TBG1jg@mail.gmail.com>
References: <20180716040516.GA32783@beast> <CAK8P3a1tph9VPJnYYhBvH_1wZ79wXDvfnJt_CEruj3T-TBG1jg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 2 Aug 2018 16:27:01 -0700
X-Google-Sender-Auth: r0jhsDWeqEjhhZPHidDjvkETUXk
Message-ID: <CAGXu5jKaNk8x9v+uVQ_O7gxr50s1-Q901JbQupnkBFYiUjd7UQ@mail.gmail.com>
Subject: Re: [PATCH] ppp: mppe: Remove VLA usage
To:     Paul Mackerras <paulus@samba.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-ppp@vger.kernel.org, Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 4:01 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jul 16, 2018 at 6:05 AM, Kees Cook <keescook@chromium.org> wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> removes the discouraged use of AHASH_REQUEST_ON_STACK (and associated
>> VLA) by switching to shash directly and keeping the associated descriptor
>> allocated with the regular state on the heap.
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> I had concerns at first that this approach might make it slower, but
> upon reading through implementation of the shash_ahash_ implementation,
> I concluded that it can only be better than before, improving both
> performance and stack usage.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Paul,

Is this something you can take via your tree?

Thanks,

-Kees


-- 
Kees Cook
Pixel Security
