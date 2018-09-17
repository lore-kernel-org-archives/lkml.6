Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1F2ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCF9214DC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tR+qHOl/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCF9214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbeIQW4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:56:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44552 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeIQW4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:56:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so7980930pgp.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 10:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YWBRG3nppCjTLAzj6ideM4e4wBXzMHBTUjfXDPlGeTw=;
        b=tR+qHOl/8QdEMTl8v5dGnBkvMT9kOEhtibAjQ3JjL7nivPwRADfRJ/VPf/6N/d5TEs
         2xTyGuMrKq1i8mOJTUWmiZ7h67qlIwpvdLAtRoOvCCOJEze0y3k6liKixs3SSaoZyD95
         toiwzPUojAs6BZilEBzZkSR/SXxAak2jFCoGoQxEjkNYOiZflueeehubA6MOmy+GGmW2
         iTAswhMnJj1QAOXrbclIOKEzTYbjLSJbQnryVbxSK12W1gIgZubmQYElzTcw3h142+AD
         5C3/CKUuffpbnB0UaCGkNRDZPk6quRn8D1kJG4pJVDoWTFvKnbva3A/39sjMoxMD7I+e
         IYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YWBRG3nppCjTLAzj6ideM4e4wBXzMHBTUjfXDPlGeTw=;
        b=DcSixrTbkDto6E9TW0vkzjMEhOFEZYyBshyNbmWoHEZb77A+Ke0e+T3Ob+fOFgYC5V
         vdPwR8Vq4JG0iaqIeZrtc1nPooIVlUSbKQB470XSvFV/4kBKbhCBBd63DYonpXZ/8pe2
         FfgMvQEavnN9xBTZDTdXzZP5uZ8IhaWivWYcJ2SFOu2W+wo1mStqYWSVXjuBdTEBCrhI
         HhqIKXWvI+9/NII/QDA8yu5adFqORzlfaKdWrhzOskuAoA/fs5fNPDNxqaM5L1SYS53Q
         0b+UWxYulunVdG59f2+qXWdUDUOx8TOC0rqZ/zXt3NBaZKoOWbDG5dwajt+7U5DzjEfg
         keWA==
X-Gm-Message-State: APzg51ASdP9DV0vtuE0ClpwQeTqpMMeu0yP6rU5TTP84eaaQPOTDw/gI
        0iSywaMKg2K9R6mShhKwwL7vGwGJke8CrpbcRrP5WQ==
X-Google-Smtp-Source: ANB0VdbaO++H2ccT6Di1De0BPxvQMVbUP7/5j+t3tN/4m81KC2Wr42wfmbITr8bdqzz9JNiuV+4M+Gbnp5dU4Ak5jwM=
X-Received: by 2002:a63:2605:: with SMTP id m5-v6mr23331762pgm.225.1537205284145;
 Mon, 17 Sep 2018 10:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180915064337.845-1-natechancellor@gmail.com>
In-Reply-To: <20180915064337.845-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 17 Sep 2018 10:27:52 -0700
Message-ID: <CAKwvOdk7fF1u7qNW+=6pyuOKJ-9LfCA1g+30wpBDba_4RmCGZA@mail.gmail.com>
Subject: Re: [PATCH] misc: echo: Remove unnecessary parentheses and simplify
 check for zero
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 11:43 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when multiple pairs of parentheses are used for a single
> conditional statement.
>
> drivers/misc/echo/echo.c:384:27: warning: equality comparison with
> extraneous parentheses [-Wparentheses-equality]
>         if ((ec->nonupdate_dwell == 0)) {
>              ~~~~~~~~~~~~~~~~~~~~^~~~
> drivers/misc/echo/echo.c:384:27: note: remove extraneous parentheses
> around the comparison to silence this warning
>         if ((ec->nonupdate_dwell == 0)) {
>             ~                    ^   ~
> drivers/misc/echo/echo.c:384:27: note: use '=' to turn this equality
> comparison into an assignment
>         if ((ec->nonupdate_dwell == 0)) {
>                                  ^~
>                                  =
> 1 warning generated.
>
> Remove them and while we're at it, simplify the zero check as '!var' is
> used more than 'var == 0'.
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Nathan,
Thanks for this patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/misc/echo/echo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/echo/echo.c b/drivers/misc/echo/echo.c
> index 8a5adc0d2e88..3ebe5d75ad6a 100644
> --- a/drivers/misc/echo/echo.c
> +++ b/drivers/misc/echo/echo.c
> @@ -381,7 +381,7 @@ int16_t oslec_update(struct oslec_state *ec, int16_t tx, int16_t rx)
>          */
>         ec->factor = 0;
>         ec->shift = 0;
> -       if ((ec->nonupdate_dwell == 0)) {
> +       if (!ec->nonupdate_dwell) {
>                 int p, logp, shift;
>
>                 /* Determine:
> --
> 2.18.0
>


-- 
Thanks,
~Nick Desaulniers
