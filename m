Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FB6C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9562145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9562145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbeLCJOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:14:12 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45638 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbeLCJOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:14:12 -0500
Received: by mail-ot1-f65.google.com with SMTP id 32so10880769ota.12;
        Mon, 03 Dec 2018 01:14:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vXK0ODY7Yojp1KuP+R51gSnMWaC6XL3sEQaD16j/oW4=;
        b=ZUi00cp8TRddhNHKNiWvGs0LRcyV1/rkoBpAnRYIgdUH+wR2vPvhocvAtRFTwMiHOg
         RubpTITidrR9tZ18f1MBi6QSURtXqzPIXs7YgNsZKPKfUxn1SWJPYKnhRhZzrhvGuWjf
         M9IJaOQ48jYNykATsjNIlS8gUQAwDo69g7YgTDOOAyk8XVAwr/8BIVUZGq82LdrMw6vi
         DbEj86uGd6X17I7AB0S+eI1pbLxDUQjgUKfWSf4WefmY3oeYk38CoALaK9TB2TcTsF7S
         Gydr3xTu1CCzF+wUD2uZvGllZZFECrI8VedW4HvT59KsS1nECax4+SZB9YM/LVAGX/3l
         b0tA==
X-Gm-Message-State: AA+aEWaQgez9OhIF9SVK77zRTVCWWqf/roJhFnJqdQVhrKk9RKfUX4gK
        GRowymUa9XtOkOoBYYXpKV6M5+t1GnNl4//zO7c=
X-Google-Smtp-Source: AFSGD/U00WyAXCcyq1Fd4PayG6KSLUrQzbM71zxWwKpKhdEYrz8OkOPTZU41PsWwBrZ+VHOmcbeAhZ4lnwKZ2cFuqtE=
X-Received: by 2002:a9d:4c84:: with SMTP id m4mr5832006otf.124.1543828441882;
 Mon, 03 Dec 2018 01:14:01 -0800 (PST)
MIME-Version: 1.0
References: <20181130142557.2623-1-tiny.windzz@gmail.com>
In-Reply-To: <20181130142557.2623-1-tiny.windzz@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 3 Dec 2018 10:13:49 +0100
Message-ID: <CAJZ5v0hPPWx6ZbTPRLRMj_0zSF91ApS3BWgYGj31GqzhX45sYw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: nforce2: Remove meaningless return
To:     tiny.windzz@gmail.com
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 3:26 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> In a function whose return type is void, returning on the last line is
> not required.So remove it.Also move the module declaration to the end.

The last piece is not reflected by the subject.

Also, why do you move the MODULE_ stuff around at all?

>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/cpufreq/cpufreq-nforce2.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
> index dbf82f36d270..ccff1f2a7c25 100644
> --- a/drivers/cpufreq/cpufreq-nforce2.c
> +++ b/drivers/cpufreq/cpufreq-nforce2.c
> @@ -47,10 +47,6 @@ static int fid;
>  static int min_fsb;
>  static int max_fsb;
>
> -MODULE_AUTHOR("Sebastian Witt <se.witt@gmx.net>");
> -MODULE_DESCRIPTION("nForce2 FSB changing cpufreq driver");
> -MODULE_LICENSE("GPL");
> -
>  module_param(fid, int, 0444);
>  module_param(min_fsb, int, 0444);
>
> @@ -123,8 +119,6 @@ static void nforce2_write_pll(int pll)
>         /* Now write the value in all 64 registers */
>         for (temp = 0; temp <= 0x3f; temp++)
>                 pci_write_config_dword(nforce2_dev, NFORCE2_PLLREG, pll);
> -
> -       return;
>  }
>
>  /**
> @@ -436,6 +430,9 @@ static void __exit nforce2_exit(void)
>         cpufreq_unregister_driver(&nforce2_driver);
>  }
>
> +MODULE_AUTHOR("Sebastian Witt <se.witt@gmx.net>");
> +MODULE_DESCRIPTION("nForce2 FSB changing cpufreq driver");
> +MODULE_LICENSE("GPL");
> +
>  module_init(nforce2_init);
>  module_exit(nforce2_exit);
> -
> --
> 2.17.0
>
