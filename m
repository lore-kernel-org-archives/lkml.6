Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3C9C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B3A20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leFg6mQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B3A20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbeKAWoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:44:38 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45036 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbeKAWoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:44:38 -0400
Received: by mail-qt1-f195.google.com with SMTP id b22-v6so21032788qtr.11;
        Thu, 01 Nov 2018 06:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1PluRsU9uIKIwWVhil85fvYx5AJLfIDxYn7akjHzphg=;
        b=leFg6mQopRftZ5aVuB4VriURSfIWj4JGc/B9VF+eWLN30X0wPu59v3BjkUNbOACRcQ
         fNgIudORiu8Ysy3Ogt3zkWZK8804qQfwK7y4CmfQQKI53SDr4gX331Mh17DLoYbwLt0/
         OvbygR7VP/EMXPu7qi/Zrer7lcm4DlCMhSuV3++7mRKe/qCHMgozDd/2kyuKeSihgPfO
         fFklR2CVDIuZ2W5uT5mdjo3YwMKPRekz39ZkG6XqT6Ykdm3/ljVS6nByaNZLL8czK5+Z
         Hswjzz29rxRAPjfGvYlWSh1/Wp1SFeb7hWts0OrSzsc+HrF7OpFuNtoVG24kFsA8RT9M
         tojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1PluRsU9uIKIwWVhil85fvYx5AJLfIDxYn7akjHzphg=;
        b=OCxmG3ZS7YI8Etxglz0dWdkxtlDHxzRnQjc0YgXcPTOQs4m4ThMZtpygQPyg5YSJLz
         +tIyj3qxxoLdtuLSihUU/LQlljpX73yvEtNxon/rPdzbD5Y8Dn8eNdC9oejC1KFTm2VT
         cOJAysi6H2VKX1bJaAOPiqQQdFsvMrCdvG3MizZQtlqXX4sZ8ilv8s7fGFn061j2q3OG
         GS1z6x7QFyRqi+N8U7NsGqeyG9QWVDtB3rEC4bjMsU6HBHvUKRS0LJ8ibmOWcNvw3FtE
         heQdaB+nd0Fn8E+jxGYPtJW3SSqudbALswwTzplfJUjGE5qrVzF9Xyi7ICinJG8v9jaG
         RMbQ==
X-Gm-Message-State: AGRZ1gKLp8aHxXLc1sh/YjaJ7v0YGVAjAWzxN90KJeJepFYW36IAxn7+
        kqEfUZ0pa7LGiVzzeJC64GPks5VNpWkKfotzycA=
X-Google-Smtp-Source: AJdET5ejaKslp7Z/m5Z47VSVR4giR1QESNhXgjOrnyY6kWAlzsXOt7Ji48vH4miK0GTyAbwbcEtcl6jDDu6oYoqMGzU=
X-Received: by 2002:ac8:764e:: with SMTP id i14-v6mr6810727qtr.373.1541079697361;
 Thu, 01 Nov 2018 06:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <1541085002-42993-1-git-send-email-peng.hao2@zte.com.cn> <1541085002-42993-3-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1541085002-42993-3-git-send-email-peng.hao2@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Nov 2018 15:41:24 +0200
Message-ID: <CAHp75Vfb4iUNJoUKj2T58yP2iCcObLiS3rWxpvoupmRH-qJw2g@mail.gmail.com>
Subject: Re: [PATCH V5 3/8] misc/pvpanic: revmove unnecessary header file
To:     peng.hao2@zte.com.cn
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        hutao@cn.fujitsu.com,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 9:00 AM Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> remove unnecessary header file init.h.
>

Same comments as per patch 1, on top of this is ordering issue. This
patch should be 6/8.
Also, address Mark's comments, please.

Otherwise,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  drivers/misc/pvpanic.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
> index 059005c..66534d4 100644
> --- a/drivers/misc/pvpanic.c
> +++ b/drivers/misc/pvpanic.c
> @@ -22,7 +22,6 @@
>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/init.h>
>  #include <linux/types.h>
>  #include <linux/acpi.h>
>
> --
> 1.8.3.1
>


-- 
With Best Regards,
Andy Shevchenko
