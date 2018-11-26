Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC76C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82ADD2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="vFJxXiI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82ADD2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbeK0KfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:35:03 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33829 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbeK0KfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:35:03 -0500
Received: by mail-lj1-f194.google.com with SMTP id u6-v6so18337846ljd.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 15:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dhu4cBZ58iv6kcQs+KVGjSvXla3LHqMBNDEGH0KNdtI=;
        b=vFJxXiI5r2a9qZoONXZYogn0JBV8qQX9kuq4Hh+u7UYr+Guy5fMmj6dOjsdvuufCCX
         EjeEYtZBx59kdkMh03VsLj8AzRtoy4tmIXGLMVPtbA0PRItt0x0+sO26V30IVVn0yVR/
         Ecv16ArMt6ql2PFFFVZK8+c31q7KqHI0rPc+DN6ttyVHAVRxultUVcwJiJZ1KQ14Vs7+
         T7/SjAvv0Knoe4tyDf4D2zoVO6TbHQOaf68/eM5v4YvJ1OD2QA6ipr38YuvDtq7fUEil
         aqfiolVhriKQg37WZbnuv67VPTIoABkyHDAAAg/XtXfbRgh7K8gzB3aZ3J/0llaLW1b+
         nl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dhu4cBZ58iv6kcQs+KVGjSvXla3LHqMBNDEGH0KNdtI=;
        b=IRW9FkmKfkClJeI1U2MHPR19ROadnFcaV46HecvzD54rsW63CMlN3F3Qqnfx7FU4gq
         37sjZjhJhh/P8J2Cr/I+Pcxsba++FRcQVsVpwb6OTv1J9yHfiNjlPc8314n1PNkwxdH2
         mCTYJfySPlALDo4feYIrqAv7zVcOmCX5hSs1McPgW99B963r0BCea8VDlkmZUMcLzv6R
         wbJ9EQp3Gg5+UO/l9Es2MxKMbcTZzTVV/+DGUHc1OjQLn7eFTM8Vhxs2OUFsQhZhsYYD
         +mh8Dvw4EtX2sjsTUHbnpV7e+nJkjkVngmv0PIQgjlcFJ85WDvG7pg071bodfDTs4TdW
         ChCA==
X-Gm-Message-State: AA+aEWYHkENdSUUU0m5mJGRqRMtSw3rO+G39kftzR9SLpN/2wEXGDvBr
        51Vqe1aueqXI+1BSZzv20+98Lwtdnug7SEiDgPMZ
X-Google-Smtp-Source: AFSGD/WuGpDuqiouLDGZ1mW+2+KgN1XjcS1wCAooBDbmojtzHDToXxFQObqgnPq9IJILc881J/FurUCd6oeNdhNb2BQ=
X-Received: by 2002:a2e:7d15:: with SMTP id y21-v6mr15956054ljc.77.1543275553092;
 Mon, 26 Nov 2018 15:39:13 -0800 (PST)
MIME-Version: 1.0
References: <20181126150523.32124-1-tiny.windzz@gmail.com>
In-Reply-To: <20181126150523.32124-1-tiny.windzz@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 26 Nov 2018 18:39:01 -0500
Message-ID: <CAHC9VhTZo6oRjYLF2f1P2Qqj5JZYYdxks4Rg1b7aA+3PPpJCzA@mail.gmail.com>
Subject: Re: [PATCH] audit/sc: remove some duplicated includes
To:     tiny.windzz@gmail.com
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 10:05 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
> audit.h and fs.h are included twice.It's unnecessary.
> hence just remove them.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  kernel/auditsc.c | 2 --
>  1 file changed, 2 deletions(-)

See my previous comments.

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index b2d1f043f17f..6b6de6e0540e 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -47,7 +47,6 @@
>  #include <linux/init.h>
>  #include <asm/types.h>
>  #include <linux/atomic.h>
> -#include <linux/fs.h>
>  #include <linux/namei.h>
>  #include <linux/mm.h>
>  #include <linux/export.h>
> @@ -55,7 +54,6 @@
>  #include <linux/mount.h>
>  #include <linux/socket.h>
>  #include <linux/mqueue.h>
> -#include <linux/audit.h>
>  #include <linux/personality.h>
>  #include <linux/time.h>
>  #include <linux/netlink.h>
> --
> 2.17.0
>


-- 
paul moore
www.paul-moore.com
