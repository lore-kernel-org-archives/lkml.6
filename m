Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867FEC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6C120645
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="CB9SK2X9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6C120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbeLMXmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 18:42:25 -0500
Received: from mail-lf1-f54.google.com ([209.85.167.54]:44902 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbeLMXmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 18:42:24 -0500
Received: by mail-lf1-f54.google.com with SMTP id z13so2893382lfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 15:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fFwwiYBrF05Vdjf6a+0SAipQPTvZMQ8dIrHth/Gsh68=;
        b=CB9SK2X93sNhodccVZoa888beartu/q5zvd7SFfgV94B59yQipLV3EBH/eoE5t9i1d
         BIH4jV3lOAwTgRLbqtwolC6iy/aRw7xPr2AcQjwKSG8q6egAvqTdJLtabXIhErKnnA+y
         jPCs2MVEMI2zMvjnDuSe+MrN5uh3TJtgwQnvHpoCQeMNcLgSPsuWNl1TkQb7K5+ydPjl
         DP81NknAFcoyiH1V4N791UH3yghgUw3evrUSYP2h4PAbTu0e3qh16iocFacmuXtHeayu
         KGUFB1e87fOADF1dWyz0iAlfkAzVLV2rpAcjJ+5q5NBInVqppA9upn/NfqM/6zUEInH8
         /7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fFwwiYBrF05Vdjf6a+0SAipQPTvZMQ8dIrHth/Gsh68=;
        b=TSur3JRYRBGh4qCW8EKN1Rlmv7nemChq24n6g2OEaInpSn53YKLc0MNaPpByp6rk05
         DEDH4cA3FGfxFdLzpKoL99pueTABKZ5A21KIms1820gAsACP1U/AqHdYt1N0JDX3q4V/
         yOjVKZYQ5/JOoY2zuk2GhfHquEphQ8DRtiaHoe9jNlF0cyj4LqAIgh5SDetijjuDBILS
         qpmJEJ1mTApIf/YtI1/w/iIuMPbEG9DmZQIdG6ZOo5tRy9wae2R4hX0MSWMSi3wF0Wyp
         2ISL5V7tzA7XASvs0b6qlT6XbNDjbuFCJdxHTT/9FYot5tz43nNEamFv/x8H8xbAf7Os
         P6DA==
X-Gm-Message-State: AA+aEWafHf9SFUuoefteVcWrOuUQGS2pExD8ylvmaNgvxNWd7K+svS3k
        MPZ7/xbmPBtMOxeoWKbfANVNoT2V5/9I1poAgH0qjwidLA==
X-Google-Smtp-Source: AFSGD/XCkYFqMxNdoRL/ahBwWL+OYroiQOgyPFpl9xP++lq3T6xU3OCSw32k6XWcP/OZW7N7KOviElQ7iWCsI20d8Kc=
X-Received: by 2002:a19:40cc:: with SMTP id n195mr423713lfa.40.1544744542365;
 Thu, 13 Dec 2018 15:42:22 -0800 (PST)
MIME-Version: 1.0
References: <20181209062502.16308-1-yuehaibing@huawei.com>
In-Reply-To: <20181209062502.16308-1-yuehaibing@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Dec 2018 18:42:10 -0500
Message-ID: <CAHC9VhSCnZ4HfqA5ZR3xEzrofGZobLhbHr_N2OftkzW=Z6Q_YQ@mail.gmail.com>
Subject: Re: [PATCH -next] audit: remove duplicated include from audit.c
To:     yuehaibing@huawei.com
Cc:     Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 9, 2018 at 1:25 AM YueHaibing <yuehaibing@huawei.com> wrote:
> Remove duplicated include.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  kernel/audit.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/kernel/audit.c b/kernel/audit.c
> index a0a4544..632d360 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -60,7 +60,6 @@
>  #include <linux/mutex.h>
>  #include <linux/gfp.h>
>  #include <linux/pid.h>
> -#include <linux/slab.h>

As discussed previously, I don't want to remove header files whose
declarations are used in the source file.  While it may be true that
slab.h is included in one of the previously included header files, I
like leaving it as an explicit include to help document the dependency
and protect us from changes in the other header files.

--
paul moore
www.paul-moore.com
