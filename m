Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C738FFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8143A20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nhx1sfE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8143A20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeINW2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:28:15 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:38254 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeINW2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:28:14 -0400
Received: by mail-qt0-f196.google.com with SMTP id x7-v6so9380317qtk.5;
        Fri, 14 Sep 2018 10:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R3g2k36CVr9nMcrr8XW96ahHO5waeqenQFbG9f0CjCs=;
        b=Nhx1sfE2lZdglIcdHNx7A05PybrQ6w/DCbK8LEuokQihQExagKCWvS7xiEGf7XR+qv
         qBZISpXcgnr99yxqVVtPq1kqjAuBVt7Mw58yJ7EoMx6u09HaVE1ZMKnuaJkgoolpc/hJ
         AjSii9KOc4xG0Oo7XiyzDW419uc4TR4dgZd6Xe6V1SHuEIc1D4p3SKuf2SFMU7cC+bGy
         RuAXEHJtub+MKKLM7fpQouMf6JwVbFJ9YLViQgFsFEKmUuj6sk4e1n8famkti7HoMk6F
         zW7TOvn/jLukniMuRY+GJ/ydWZp1zkHKXTa3E4Rq3jhLj/ZbRhaOZ4UQMR05uaN3SSXN
         6+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R3g2k36CVr9nMcrr8XW96ahHO5waeqenQFbG9f0CjCs=;
        b=Lp5Yk+lvu3YTtHRE+5kCgBhb233M04i3kkLnd3ZlNR3ELHg11tDKUvNf2oSW8spWM8
         2k9mvAsL2zRZZfizQdOW5up8+XkymHI8H3YTmn9Kh3Klgz7HiyISDMCy5eky45awU5+P
         +I+83zqY+hmyGD/gIeQoUNrezwsQJehUP6inbzW7hbRN1c5h1zShNjDHr6mq40UNJ+0A
         gHb4S6tts8qqZDwj2avwi30OuYArGHCaKNTYxCnVJySspvNCdBM3i3RF59lz/+jG2zcR
         nmqn1eN1SilM7QlFTLNa5ICSYeYzPezUjkty8wZUbGWnR8cCMcmUSkKk9E2/sENF86ID
         ZE9w==
X-Gm-Message-State: APzg51A45s1z+I08q9D79Jh8tSlBYSzJbS10GHY215Nu/QhLpvqlFVDR
        0H42HE7PuWlCO5NxP7LaCZl/YZ2S9/6oLU3r3Y/E2HsSqBM=
X-Google-Smtp-Source: ANB0VdbxXRyZ3F8U8gixUOhzon3AnDZ5YBLDDXYfjI1x+8rR7M39xTfy+VwKdyKaMkd/JuILCAMhYbj0PoVYevYzmzY=
X-Received: by 2002:a0c:aed9:: with SMTP id n25-v6mr9669084qvd.10.1536945170621;
 Fri, 14 Sep 2018 10:12:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7494:0:0:0:0:0 with HTTP; Fri, 14 Sep 2018 10:12:29
 -0700 (PDT)
In-Reply-To: <20180914104427.3900-1-harshitjain6751@gmail.com>
References: <20180914104427.3900-1-harshitjain6751@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 14 Sep 2018 19:12:29 +0200
Message-ID: <CANiq72=xNMKJv3tT9+-jxEOx9033ytRrbUV+TQ6kVL7QY06jDA@mail.gmail.com>
Subject: Re: [PATCH] scripts: unifdef: fix stringop-truncation warning
To:     Harshit Jain <harshitjain6751@gmail.com>
Cc:     stable@vger.kernel.org, Harshit Jain <dev-harsh1998@hotmail.com>,
        Tony Finch <dot@dotat.at>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harshit,

On Fri, Sep 14, 2018 at 12:44 PM, Harshit Jain
<harshitjain6751@gmail.com> wrote:
> From: Harshit Jain <dev-harsh1998@hotmail.com>
>
> * This commit resolves the following warning when the mainline kernel is build with the android environment.

Typo: built

>
> -> warning :-> https://gist.github.com/dev-harsh1998/757427b16a58f5498db3d87212a9651b

Try to avoid links to external pages (specially if they are only 2 lines :-).

>
> * This warning is persistant in all the currently maintained android kernel i.e 3.18, 4.4, 4.9, 4.14.

Typos: persistent, kernels, i.e.

>
> Signed-off-by: Harshit Jain <dev-harsh1998@hotmail.com>
> ---
>  scripts/unifdef.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/unifdef.c b/scripts/unifdef.c
> index 7493c0ee51cc..4ce008eda362 100644
> --- a/scripts/unifdef.c
> +++ b/scripts/unifdef.c
> @@ -395,8 +395,8 @@ usage(void)
>   * When we have processed a group that starts off with a known-false
>   * #if/#elif sequence (which has therefore been deleted) followed by a
>   * #elif that we don't understand and therefore must keep, we edit the
> - * latter into a #if to keep the nesting correct. We use strncpy() to
> - * overwrite the 4 byte token "elif" with "if  " without a '\0' byte.
> + * latter into a #if to keep the nesting correct. We use the memcpy()
> + * from the string header overwrite the 4 byte token "elif" with "if  ".
>   *
>   * When we find a true #elif in a group, the following block will
>   * always be kept and the rest of the sequence after the next #elif or
> @@ -450,7 +450,7 @@ static void Idrop (void) { Fdrop();  ignoreon(); }
>  static void Itrue (void) { Ftrue();  ignoreon(); }
>  static void Ifalse(void) { Ffalse(); ignoreon(); }
>  /* modify this line */
> -static void Mpass (void) { strncpy(keyword, "if  ", 4); Pelif(); }
> +static void Mpass (void) { memcpy(keyword, "if  ", 4); Pelif(); }

Seems like keyword shouldn't use __attribute__((nonstring)), so this
looks right.

Cheers,
Miguel

>  static void Mtrue (void) { keywordedit("else");  state(IS_TRUE_MIDDLE); }
>  static void Melif (void) { keywordedit("endif"); state(IS_FALSE_TRAILER); }
>  static void Melse (void) { keywordedit("endif"); state(IS_FALSE_ELSE); }
> --
> 2.18.0
>
