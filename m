Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3A4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311F92075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="lNHADKBR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311F92075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbeGRVgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 17:36:48 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41815 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730673AbeGRVgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 17:36:48 -0400
Received: by mail-lf0-f67.google.com with SMTP id v22-v6so4442227lfe.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 13:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VRmqhu6aqKi4FkFFmPgkcWZb9O+lQ5vPbaOH5H6gflE=;
        b=lNHADKBRPR5iZ3WjYn3MuOIreuih+6Em3SL5NSH1AErjJrijKLFYgjqeXxj+XLhiga
         VydqzQFgQFgKDlHBdtwG/NoS2EJmvn6uKo7U3V752nMAL/uT9fabp3ic3shPkQNYgE8r
         LB3n0YjqQLCd323nJsqI/HFy6oSwDhLvL9/ikqUIhRPPoOOGhHvqFBoE4rG+JIcUokyj
         8TsAS6y2WaUrV5Aero+xMNnlVc/J5XmptgEHJvI6031GvhfSEh2k6GMYLj6jeM6m2l/W
         s1bA6j3vw3iJKR/XF2cNQpbnN1Eo0/QT7s/t6TCLT69A8n4pjtkbVoWiPm6ZfLX2Tfb0
         +Klw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VRmqhu6aqKi4FkFFmPgkcWZb9O+lQ5vPbaOH5H6gflE=;
        b=SpY2U+YFXzDh9QxrDn8Oju88g00FvzHfalvCWClgThKBB447ZrQ44q6Y8toKs2D8jL
         blk3R9bef0V6d0Cih1mAtfdltaw4P6g1UBvKFWgfZCet+Z2dkqErrzcf5sY35QauaqL4
         SVe6GSOSwOwYRcm13HTTaqR95QCoXQ4zJbyXFQflY5qsbpY8+qYw8hR4ufxRzOVDF9Cp
         UWB51J4Cl5n3STlW3DaX6XQFtaSmlDZIVSPsr5jyYr3gUXaWjNR7uVE8GJSYkK4F2aXb
         hRWgFzoMy3HALP8z3jCpR3axwNCxiAoeEjiy5nQgw2T6sCoh3s9trzdmRo41MWILmnql
         gBvA==
X-Gm-Message-State: AOUpUlGv8VIU3tBwV6ZDuofWArQWFKjuVF0G9q8FPOmL/XFtos71TMir
        5RLZ4Yokw2l4OyhiFh3swPTFJVcUQOdje1Ry5oMJ
X-Google-Smtp-Source: AAOMgpeA9tbD/zR11Poii2u1Z3pZcRE9Yu/EKfy0pCM3HFn7rCd3V8rD6k14NQdk3DiPhWNJgzL/F5YLLpak73uRNbs=
X-Received: by 2002:a19:dd5c:: with SMTP id u89-v6mr4765711lfg.83.1531947426918;
 Wed, 18 Jul 2018 13:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1528304203.git.rgb@redhat.com> <6118147ea27ab5831956cf9dcad15b241c791420.1528304204.git.rgb@redhat.com>
In-Reply-To: <6118147ea27ab5831956cf9dcad15b241c791420.1528304204.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 18 Jul 2018 16:56:56 -0400
Message-ID: <CAHC9VhROqEZBq6BEoWFtWuVSNyZ4AtewMM2GDmJNaKdfVbcmzw@mail.gmail.com>
Subject: Re: [RFC PATCH ghak90 (was ghak32) V3 10/10] rfkill: fix spelling
 mistake contidion to condition
To:     rgb@redhat.com
Cc:     cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-audit@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 1:02 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  net/rfkill/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I would suggest splitting this patch from the audit container ID
patchset and sending it to the netdev folks.  It really has nothing to
do with the audit container ID work, although I suspect I know why you
bumped into this spelling mistake ;)

> diff --git a/net/rfkill/core.c b/net/rfkill/core.c
> index 59d0eb9..e89a009 100644
> --- a/net/rfkill/core.c
> +++ b/net/rfkill/core.c
> @@ -494,7 +494,7 @@ void rfkill_remove_epo_lock(void)
>  /**
>   * rfkill_is_epo_lock_active - returns true EPO is active
>   *
> - * Returns 0 (false) if there is NOT an active EPO contidion,
> + * Returns 0 (false) if there is NOT an active EPO condition,
>   * and 1 (true) if there is an active EPO contition, which
>   * locks all radios in one of the BLOCKED states.
>   *
> --
> 1.8.3.1

-- 
paul moore
www.paul-moore.com
