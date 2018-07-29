Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1055AFA3751
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 10:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12D520873
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 10:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQ1bkV+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12D520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbeG2LzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 07:55:24 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34796 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbeG2LzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 07:55:24 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so16383615ois.1;
        Sun, 29 Jul 2018 03:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qvukRtzl8KcvmaFDZEMrYpXoxevaggdLNkphfGjs0P0=;
        b=jQ1bkV+sczvvK8K6askkPUirrpNNTXszPKeLzJFnoL5DBv6JvByNVz01W/GIxVhaag
         KIS6+KeZ4TSvkWq54a1v4T/kk51uSB4tp339LZE6F2lUdLaw6j7q2rApRxMS0wNRlBUF
         oJyYl60V1Z6QfeyCl9rxI5qOzdDfbXK/eohIuAQ7idLVfjSD9BCKr8L4+fCmJHt18Jjm
         Ct/Q+K+VS25WmvDi5rZbhLQyqA5YuZzRcczMJTJWc8/GFbYUMwYm2aOED9t7QWZl8U31
         yVbWOSgd4DstV56/zn+oxV5aG19IwqNqSWkCMoaQ31/5af5d7/DM8SwBiWjpKqtTDIEK
         XKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=qvukRtzl8KcvmaFDZEMrYpXoxevaggdLNkphfGjs0P0=;
        b=HwWQdh4SKuXei6J5OEA9v+8/12FK1S6AGiVkKK4JEQhjiO6d+Zvbm3zdpsWXyuG36l
         b+0/gnGuwg4DHemO0O90nbuSmfMcZcu0B3Ed1mStr8tECwT8JRRTtNe7tTGeZhvRHAxH
         VSUODAU10dT8piOv4FAI8ZXPZFer5U9LjJWhdtI4RrZepX7G97X6Fio3+CaXaTWJNKXj
         aJRr17hVieRmd05PqJDO56JNIV+r4G0vN8O9oySyLHSFKRf9F7VRF+rR/efx9HOgbHB6
         gA1u20uqTAvFYrlkNbBOdQBCS3hfblQ1tDpPoROyue9lM7ON9SvWQBVr3w5orw0VZY8C
         bmaQ==
X-Gm-Message-State: AOUpUlGZBEyqmFTYfpDNWW8h1Hkl21DWHI1t+iTWycVSoPWPFG/PoG9O
        mTJSlbGyaGWiGjrkJYobSzP1xjkVyd+oOwTmh30NZQ==
X-Google-Smtp-Source: AAOMgpeFDo3owRuqpU9O9TB/kMWXkuI8hW+q2Co1sPe85gzaqWkHKyMFMZAkslEM4VSPGqr6yRoBYSJe16Hx2IQpc9M=
X-Received: by 2002:aca:6285:: with SMTP id w127-v6mr12942764oib.120.1532859926472;
 Sun, 29 Jul 2018 03:25:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Sun, 29 Jul 2018 03:25:26
 -0700 (PDT)
In-Reply-To: <20180728210519.20195-1-erik.schmauss@intel.com>
References: <20180728210519.20195-1-erik.schmauss@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 29 Jul 2018 12:25:26 +0200
X-Google-Sender-Auth: n8lSReOaRA23A9kyGZdJ1qb6lY8
Message-ID: <CAJZ5v0jQuBSFDZXtrWmmsKHexuk-0X5pHMkbQAJ3sqPJGH7EQQ@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: AML Parser: ignore control method status in
 module-level code
To:     Erik Schmauss <erik.schmauss@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        oleksandr@natalenko.name,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 11:05 PM, Erik Schmauss <erik.schmauss@intel.com> wrote:
> Previous change in the AML parser code blindly set all non-successful
> dispatcher statuses to AE_OK. This approach is incorrect because
> successful control method invocations from module-level return
> AE_CTRL_TRANSFER. Overwriting AE_OK to this status causes the AML
> parser to think that there was no return value from the control
> method invocation.
>
> fixes: 73c2a01c52b6 (ACPICA: AML Parser: ignore dispatcher error status during table load)
>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Tested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
> ---
>  drivers/acpi/acpica/psloop.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
> index ee840be150b5..44f35ab3347d 100644
> --- a/drivers/acpi/acpica/psloop.c
> +++ b/drivers/acpi/acpica/psloop.c
> @@ -709,15 +709,20 @@ acpi_status acpi_ps_parse_loop(struct acpi_walk_state *walk_state)
>                         } else
>                             if ((walk_state->
>                                  parse_flags & ACPI_PARSE_MODULE_LEVEL)
> +                               && status != AE_CTRL_TRANSFER
>                                 && ACPI_FAILURE(status)) {
>                                 /*
> -                                * ACPI_PARSE_MODULE_LEVEL means that we are loading a table by
> -                                * executing it as a control method. However, if we encounter
> -                                * an error while loading the table, we need to keep trying to
> -                                * load the table rather than aborting the table load. Set the
> -                                * status to AE_OK to proceed with the table load. If we get a
> -                                * failure at this point, it means that the dispatcher got an
> -                                * error while processing Op (most likely an AML operand error.
> +                                * ACPI_PARSE_MODULE_LEVEL flag means that we are currently
> +                                * loading a table by executing it as a control method.
> +                                * However, if we encounter an error while loading the table,
> +                                * we need to keep trying to load the table rather than
> +                                * aborting the table load (setting the status to AE_OK
> +                                * continues the table load). If we get a failure at this
> +                                * point, it means that the dispatcher got an error while
> +                                * processing Op (most likely an AML operand error) or a
> +                                * control method was called from module level and the
> +                                * dispatcher returned AE_CTRL_TRANSFER. In the latter case,
> +                                * leave the status alone, there's nothing wrong with it.
>                                  */
>                                 status = AE_OK;
>                         }
> --

Applied, thanks!
