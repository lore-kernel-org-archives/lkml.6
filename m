Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id zOzMF1dBG1uabAAAmS7hNA
	; Sat, 09 Jun 2018 02:54:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9C6266089E; Sat,  9 Jun 2018 02:54:37 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+jK1yK4"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 158E4605A2;
	Sat,  9 Jun 2018 02:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 158E4605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753180AbeFICyd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 22:54:33 -0400
Received: from mail-pl0-f54.google.com ([209.85.160.54]:38161 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751905AbeFICyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 22:54:31 -0400
Received: by mail-pl0-f54.google.com with SMTP id b14-v6so9284720pls.5;
        Fri, 08 Jun 2018 19:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0fhOtGKan7zV36gUw8AcXJrOgq3Yy2SXEIzE6eqFigg=;
        b=I+jK1yK42pPbe8HMnb28QXln5mcbYtXXRy847/ZX7Odzv9mXzdb4coRwtIziwNRJpv
         dYgkbzmv8iXqq/9ToRiFqkJmQh2DS9FALC5RrtFKslnPB6oJ34joq05rF42+XR9/sMdq
         BETk9vmwvDNL+8MGHaoh3CWlTaYvZpNQUW4KYogyPwpl/fYkYHt8WAXlLcUXp4Ph5SZn
         pljroMpAwUY30gDyWWIOZqX/1S+6uOkNIc70gjLLpQRA5UuzlU9/YljXrOeUq0dUJwIf
         O8beZNrkPM/fXmJ0ZxuTNvsuvE6Rn4ZXxb7RnY+XMGOXImQ5Aq4X1C7lOEYgD9n95oIy
         mA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0fhOtGKan7zV36gUw8AcXJrOgq3Yy2SXEIzE6eqFigg=;
        b=JnrpMM4Ts147qumBIOBOdnvp1b6W5RmDktSXrdzv5+qslRXK+9movXJaU/r7vyXgUI
         eI7lZiyiVyKMC3J/STg2jyw4D0z8Y2mv4IfZHi9A1nMuZOTlidk8jYa9RCywtzQWZPqW
         XJW0zoFvunbtQjmNaRXZEDEbWPZ4zsIh+dswKxLhS8+R6qEUv4y5wifIxx0c88FmaYEY
         uh3dPJu4qE+Cimvo8fwP5DrdX+9yg96uYJbZOb2V3UpBnO/4rLZkNULpX2gdzn6Gh4zk
         BkJrEmSoBYOl3KkF8WW+LTFxnYD1OdZvgnjJ5MYvER726LCSUR6C4JNGljmgAEd1hGTI
         NSMw==
X-Gm-Message-State: APt69E2SUieQF+eLFVeCpLpJfQdFRwbZb8m4S/i+4r4cRUAU1JCRe4Uy
        Bc5mz6jaZkQwUg7mPgophevTtrB7+Xi6S/pCErI=
X-Google-Smtp-Source: ADUXVKJW81k55AQndRweDYB4YEshK8ZnnmBJltZLvV5XLV70ZRKSXdo5uFlUI6rnct8UnsQZAs/9N2xfRAN7UwwcJuc=
X-Received: by 2002:a17:902:1a8:: with SMTP id b37-v6mr9177091plb.326.1528512871362;
 Fri, 08 Jun 2018 19:54:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:5c81:0:0:0:0 with HTTP; Fri, 8 Jun 2018 19:54:30
 -0700 (PDT)
In-Reply-To: <6471e14e-2872-3ba4-7336-7c5840d28c12@gmail.com>
References: <15599.1528402643@turing-police.cc.vt.edu> <fe2d6bfd-17a3-8464-175d-3e8714e14827@gmail.com>
 <10902.1528416198@turing-police.cc.vt.edu> <6471e14e-2872-3ba4-7336-7c5840d28c12@gmail.com>
From: Dexuan-Linux Cui <dexuan.linux@gmail.com>
Date: Fri, 8 Jun 2018 19:54:30 -0700
Message-ID: <CAA42JLYGOR1hJnOvdvSbyK6z7wb0jG8TtXsXoNZU9xnK1cKjVA@mail.gmail.com>
Subject: Re: next-20180605 - BUG in ipv6_add_addr
To: David Ahern <dsahern@gmail.com>
Cc: valdis.kletnieks@vt.edu, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 5:51 PM, David Ahern <dsahern@gmail.com> wrote:
>
> ...
> I know you don't have a reliable reproducer, but I did find one spot
> where I was too clever and did not initialize a new cfg variable:
>
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 89019bf59f46..59c22a25e654 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -1324,6 +1324,7 @@ static int ipv6_create_tempaddr(struct
> inet6_ifaddr *ifp,
>                 }
>         }
>
> +       memset(&cfg, 0, sizeof(cfg));
>         cfg.valid_lft = min_t(__u32, ifp->valid_lft,
>                               idev->cnf.temp_valid_lft + age);
>         cfg.preferred_lft = cnf_temp_preferred_lft + age -
> idev->desync_factor;

This works for me. Great!

Thanks,
-- Dexuan
