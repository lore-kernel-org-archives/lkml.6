Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A4AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2EC26CD1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFfRsjyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2EC26CD1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751450AbeFZPGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:06:03 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:39263 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbeFZPGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:06:02 -0400
Received: by mail-qk0-f194.google.com with SMTP id f3-v6so508042qkd.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 08:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2H4pPX0B1B0+tHuGE43WOXaVtzFXsCX5w7Uhe0Hg3us=;
        b=FFfRsjyqMSkx12boSCRmeu6gdTaaHzVc1JB4NznOEI6C/JAfv2tMWVYZA0h+tcDwor
         6yTQ1+Czs6uIdAjTMXtWNrz39oHoNqpqei6qS+P76a5vi1cCC5TrrnDnBxs/TjmwH9Ds
         b3mwhN+2Y2qpRJ/QKnbjODZveiurTkS0PLDDOsGRJCjwMfWVCpcT5HZYtFG0m34JYDGt
         c6PsHWo9VDdz6GhfmizIBK0rPybXHbOnHZp3X5PdF8YQz11/MSJ6U3vO7+1P3mnlr3+h
         L+hweb7y5LCkYYVKJD/xkgg19vPXnWKvSwh2K2Xx6e499Q5Q+0ENerlAf16GBGNUN729
         doVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2H4pPX0B1B0+tHuGE43WOXaVtzFXsCX5w7Uhe0Hg3us=;
        b=azgXpP/+156At5v1fP9xlDy+7gGWaf2SsIUUMOosSlUObhhFzt57P8XpZGkjMtF2wm
         mfhLvz2iOnG4ZHaM0Mmpb6alsvDjGPlJDtHiX6KTRxfWNLtudnIqUlW+D7ps6tJ2wXIl
         y2U8IbUllfLJOTWzR7IayK3QnGERjWSfWHM9Isb+1r4zrKAy43vkLV8dqvipVPxe8a2o
         5k4IQNxBUdJqAdsSnMPOTqZ5KpV866ouzLaXmH+4tT06BrenanWI9LIQXcXJUGqudx4x
         9v8LNOFrcVYbOyLIMTwwGO/KytXnIhySYl24VPH8W21cwCmlA82S/jGZBYsIRJE6ZLS9
         az3w==
X-Gm-Message-State: APt69E32jM5ju6UjfEa3x/R2pgdxKZD363ONqookQRn7dxehBW1o7qjJ
        RFj3hNXZuCSowzRv70L3unFrNiRAfXzOQK0XpiI=
X-Google-Smtp-Source: AAOMgpevCmUtkAHsD0eYmJzOojlfpz8saMi9nHqo0rfrObSdz8ATk0sVKSPNP1AscREgvhBKBbaKaEsTO0NiF+zQoCw=
X-Received: by 2002:a37:c595:: with SMTP id k21-v6mr1616023qkl.330.1530025561286;
 Tue, 26 Jun 2018 08:06:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:4716:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 08:05:40
 -0700 (PDT)
In-Reply-To: <20180625224430.GA31554@ziepe.ca>
References: <20180625224430.GA31554@ziepe.ca>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 26 Jun 2018 17:05:40 +0200
Message-ID: <CANiq72mcwTkmEo+CnJ2P33TrTHgXaJEpjuxQjwGx5RTXjDyvhA@mail.gmail.com>
Subject: Re: [PATCH RESEND] clang-format: Set IndentWrappedFunctionNames false
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 26, 2018 at 12:44 AM, Jason Gunthorpe <jgg@mellanox.com> wrote:
> The true option causes this indenting for functions:
>
> static struct something_very_very_long *
>     function(void *arg)
> {
>
> While a quick survey suggests that the usual Linux fallback is the GNU
> style:
>
> static struct something_very_very_long *
> function(void *arg)
> {
>
> Eg as seen in:
>
> kernel/cpu.c
> kernel/fork.c
> etc
>
> Acked-by: Joe Perches <joe@perches.com>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  .clang-format | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Resending outside the merge window with no change..
>
> If there is no clear upstream path for this file (it has no
> MAINTAINERS entry?) I could take it to Linus via the rdma.git tree, eg

We can add an specific entry, yeah. Is there any policy for "general
files" (or some general/catch-all entry)?

> as a 'collectively maintained' file.

As you prefer -- I can also pick it up through auxdisplay; but I am
not sure if we should put it in any "unrelated" tree, though. (Since
the file will not probably receive many patches, I originally thought
that it would be picked up by Andrew or some other "general" tree
instead.)

>
> Would prefer Miguel's Ack to do that though. Looks like Andrew Morton
> took the original patch introducing the file?

Yep, I sent it to Andrew and he kindly picked it up. Probably he
didn't notice this one.

As for the patch:

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel

>
> Thanks,
> Jason
>
> diff --git a/.clang-format b/.clang-format
> index faffc0d5af4eeb..1d5da22e0ba50c 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -382,7 +382,7 @@ IncludeIsMainRegex: '(Test)?$'
>  IndentCaseLabels: false
>  #IndentPPDirectives: None # Unknown to clang-format-5.0
>  IndentWidth: 8
> -IndentWrappedFunctionNames: true
> +IndentWrappedFunctionNames: false
>  JavaScriptQuotes: Leave
>  JavaScriptWrapImports: true
>  KeepEmptyLinesAtTheStartOfBlocks: false
> --
> 2.17.0
>
