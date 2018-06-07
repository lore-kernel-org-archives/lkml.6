Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Z2irE/ShGVvHbwAAmS7hNA
	; Thu, 07 Jun 2018 21:41:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 98EA5606FA; Thu,  7 Jun 2018 21:41:45 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijRwxVq7"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 22348601B4;
	Thu,  7 Jun 2018 21:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 22348601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeFGVlm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 17:41:42 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40879 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751066AbeFGVll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 17:41:41 -0400
Received: by mail-lf0-f67.google.com with SMTP id q11-v6so16924030lfc.7;
        Thu, 07 Jun 2018 14:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BCi01bymTfk5hvb9/ZLF7us51r1uDygto53ywhGQvRA=;
        b=ijRwxVq7EnbbBc1PQ8VYP20xd5Uf1h8a9bEoiFwCZrtxqoMYfXYuo0dV+652xyS+aE
         250YZfw5o3FoEGwytOqcxQ2nwBPGkWWD6fTCYrFGENZAOLcLCS6O1XKMGYEQYyj7X6Q4
         067zQM2zX1UQogEE1qp/ILFdU7Z2YM5AI8J51I9F1ArIVqLN1J9sHEThXQPFe615Qzx4
         WmT7KSEWLIBdj2QP692aP33sG81Bt97/cDJev+Wx985SqrMQZCPuoTU43FHiytVEOGu5
         uVBccrGB6C+Hv5OzRX9e/ytibkKAM6p/LaaALTZu9Eu8/e0AL37h+5cf1BxZho6VaNNd
         dFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BCi01bymTfk5hvb9/ZLF7us51r1uDygto53ywhGQvRA=;
        b=F2W+epF2JfeVdA8Vg22HCCHFMLNJcjJzSYXs8bZ1uBQNpJS9CRr+Vdl2S4ehTpmcsF
         drry4tzU2bOGVFG8jJH0Kdypt/D91vCKonfCfr/oxAB+zPxEadirUnyFbrPtG9OHiH1B
         BCzWNUveVvGcCUOWC/RC5dGOP+QFm4yGFR6C8nfEq3iC7GbKKcwDrSd6FoVhJmUM4bPg
         E/E7kws7OKfO1/C1l5rYyFPeWmwXgFJIr7B83adeqyohvYzB1TjukydHbTUc+qVTdm5I
         +Da1B3mdWuoFmDhL1kLJCbK5XQwqZMb90a51OjxyA+HJ+ksDZ+nSy+WkM1jR3hTnad6L
         9ogg==
X-Gm-Message-State: APt69E3itDy+UKO+ewli1k2vjQO5VY+7ionTWT2+Q0R5lwhyLGjGp5T8
        Gqcw1IcvKrP2e/0VQFr6VmFif+3Fj++K1/strhw=
X-Google-Smtp-Source: ADUXVKLkfXSOYTkhOzOYlKppO24W3Fh/ejmAsQKSE4+1u8pURsJ/vP9fQznGXovVLsBt9oVjpBy3E0pQM41DKDNq+zc=
X-Received: by 2002:a2e:28b:: with SMTP id y11-v6mr2583735lje.27.1528407699070;
 Thu, 07 Jun 2018 14:41:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:700e:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 14:41:38 -0700 (PDT)
In-Reply-To: <lsq.1528380321.591046177@decadent.org.uk>
References: <lsq.1528380320.647747352@decadent.org.uk> <lsq.1528380321.591046177@decadent.org.uk>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu, 7 Jun 2018 14:41:38 -0700
Message-ID: <CAKdAkRRZqayW8AKbjHwBp+RWS5Q1Y6tAW0h9o7cULp+J_bTz8w@mail.gmail.com>
Subject: Re: [PATCH 3.16 191/410] Input: mms114 - fix license module information
To: Ben Hutchings <ben@decadent.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>,
        "3.8+" <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Shyti <andi.shyti@samsung.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 7:05 AM, Ben Hutchings <ben@decadent.org.uk> wrote:
> 3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

Not a hard objection, but rather a curiosity: for this to be pulled
into stable what user issue does this fix?

>
> ------------------
>
> From: Andi Shyti <andi.shyti@samsung.com>
>
> commit 498e7e7ed1fd72c275a682f0903c4a20cc538658 upstream.
>
> The driver has been released with GNU Public License v2 as stated
> in the header, but the module license information has been tagged
> as "GPL" (GNU Public License v2 or later).
>
> Fix the module license information so that it matches the one in
> the header as "GPL v2".
>
> Fixes: 07b8481d4aff ("Input: add MELFAS mms114 touchscreen driver")
> Reported-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
>  drivers/input/touchscreen/mms114.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/drivers/input/touchscreen/mms114.c
> +++ b/drivers/input/touchscreen/mms114.c
> @@ -592,4 +592,4 @@ module_i2c_driver(mms114_driver);
>  /* Module information */
>  MODULE_AUTHOR("Joonyoung Shim <jy0922.shim@samsung.com>");
>  MODULE_DESCRIPTION("MELFAS mms114 Touchscreen driver");
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");
>



-- 
Dmitry
