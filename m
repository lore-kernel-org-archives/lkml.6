Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AEDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC05208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="UtqwmC++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC05208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeK0Kbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:31:49 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42436 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbeK0Kbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:31:49 -0500
Received: by mail-lf1-f65.google.com with SMTP id l10so14967116lfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 15:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SwEvo+tLXjGYpf9J/7xFGYgz7zo6eb7nRqCdiHpiDuE=;
        b=UtqwmC++MXrTVWFcJsr2GZuXzUyb5g67h6DhmYJBCRhlDE/BVi0CxQPey08jMpc2hx
         GQOe3p4xdhyKFPsV2ev9sGdkdC6Tu8vadQvIyWdlIEUUL77bHTVbX49uqdzWRouu7SYz
         EhvgXUPhytAJt9exq4rBMkr0QGVW4n/2kHuOYKOaBsSj4lsRD5jCZ4Pqts8yKlqMCsol
         CUABWj9P0iRt1UfyM9mIBbgvzu1GoQeXXZJnAPC7oP1KeZCmZWjdo9H4d7chPPqNcQRJ
         ZFWyHyy82VvT82fo4yP39WRW0QEotU3XSC8sTQknb/TlODG/6rS4Pt2d5rY+xHr6qqLm
         ia0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SwEvo+tLXjGYpf9J/7xFGYgz7zo6eb7nRqCdiHpiDuE=;
        b=dyPbqeH3LUQecLgQ08MWq34U7UrE4Dkj4QCjUVa7mlk4XQOA3r1jX+gHRvn+B+RJdE
         jtrO/CUMbE6dCUI0J9poejElnVRexghKr+sP2v0qu0+S9US/6saxvfAzw12QXvLC9SAJ
         DtieTUFj3Guo8G+QFCo94Y2hjBigQqJnYR/d5HEu4lwx/dNNun8OophCpYhlbCUpzQ95
         wSrUFKGlBDmos2ddJo6eqzw69md568gFMowZLIqx3dhiuzCokT+Vci9RksvEBzxC/3pY
         6ZtnT5bUXVsITR8h55pb9NdxG0v81/WfJgtHkPC60GUof9CrmtQrPQ15PfHFJWWuzrQ5
         gOig==
X-Gm-Message-State: AGRZ1gJyrqOl3NsbT2hePd4eCB2mZEx2jFifTi5aXlhASUWg8j5cvklU
        tN3FA3vTyN2OgbM7zAbvN5DfqKO12HcmiZyFEieq
X-Google-Smtp-Source: AJdET5e5/LPo/fmRv7WfT2kcXDvQSadYl+nSDy1HVJPBplPG988+I6uZokLyuzR3/fMjjU7TlXLrOfoUKaCBaPiEwfA=
X-Received: by 2002:a19:f115:: with SMTP id p21mr16625757lfh.20.1543275359450;
 Mon, 26 Nov 2018 15:35:59 -0800 (PST)
MIME-Version: 1.0
References: <20181126145107.31597-1-tiny.windzz@gmail.com>
In-Reply-To: <20181126145107.31597-1-tiny.windzz@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 26 Nov 2018 18:35:48 -0500
Message-ID: <CAHC9VhSjBTVXAXKiNsgPDJUCsxPnd3DJVA1pjSQqN0ct=RaxJg@mail.gmail.com>
Subject: Re: [PATCH] audit: remove some duplicated includes
To:     tiny.windzz@gmail.com
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 9:51 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> audit.h and skbuff.h are included twice.It's unnecessary.
> hence just remove them.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  kernel/audit.c | 3 ---
>  1 file changed, 3 deletions(-)

While there are two header files named audit.h, they are different
files as one lives in include/linux/audit.h, the other in
kernel/audit.h.  Granted, kernel/audit.h does include the
include/linux/audit.h file but it should be protected from multiple
inclusion by the _LINUX_AUDIT_H_ definition.

I currently prefer to keep both <linux/audit.h> and "audit.h" in
audit.c to help make the dependencies explicit in audit.c itself.

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 2a8058764aa6..a677715891d0 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -62,11 +62,8 @@
>  #include <linux/pid.h>
>  #include <linux/slab.h>
>
> -#include <linux/audit.h>
> -
>  #include <net/sock.h>
>  #include <net/netlink.h>
> -#include <linux/skbuff.h>
>  #ifdef CONFIG_SECURITY
>  #include <linux/security.h>
>  #endif
> --
> 2.17.0

-- 
paul moore
www.paul-moore.com
