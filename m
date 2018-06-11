Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id m/iHG11tHlucUgAAmS7hNA
	; Mon, 11 Jun 2018 12:39:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 195CE60792; Mon, 11 Jun 2018 12:39:20 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czMbtDVM"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9233A600D0;
	Mon, 11 Jun 2018 12:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9233A600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933170AbeFKMjR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 08:39:17 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35012 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932910AbeFKMjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 08:39:15 -0400
Received: by mail-vk0-f66.google.com with SMTP id o17-v6so12162712vka.2;
        Mon, 11 Jun 2018 05:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=J+5U/CLI+ddGe5QQzpNF+yE310Cyxp/5p9xgshqYOmw=;
        b=czMbtDVM8yd2cTjTsTtT8Zn9rzMern66VVhfu9D9OIZRj4CI8r9FM30yYg+6NNBVfT
         TSp9b+BbFR8n7P3dFCltTnF+35RHHpubBHHdqcACM9ZHib1i1xR4CJncVplaXX3DKDCL
         ORCt8A2WOAMykL97X0Fwn59xB60sFBaEy9PkV1R/nkvVpiInWJmlKR75qhIO2kOlxae5
         AiTvXVuVk9AxHhVtArHk6RTmY85r1E8WRMAZWRsucJx4jf8Awf81FOUdvNoifrYvf8BJ
         fyZebOP+lSMTOniE0guLyVrFSBQxARWE21CQEskAmIu3goiXPdYF/88jAPmjY/sWb6VR
         FvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=J+5U/CLI+ddGe5QQzpNF+yE310Cyxp/5p9xgshqYOmw=;
        b=fINqGnNpdUFJL+kNLFbNtGajyk+IyqgukklJYB+BcuvBwKXnTo2/ECvBdOYzjK+hrW
         x+Rfn7ElWeLvejEm+9AZrT0NNzyjnJ6RZZu6tQ5imOk6e+ggvhKQ1ub4ixtp6NcREW5c
         NgFGi4WKNUrI24watOJVYFz9biM+QWi9Kb9n7kjvH+aWWTcaRYsd7R6TDFly80fNt6SA
         mXnR6F8sjsWRSAD1PBFH7/l+BOqZmstppXuqd8Ca9pgMOv6JGL6L7tVOb3DgdIO5NfcS
         D9o1rDlHzwYV28+svwUu/EXGADXgb5BcRVvFF88ZPojcaKon8YqcnV8zdwY1Sfw8puBb
         VNEg==
X-Gm-Message-State: APt69E1hzGoGbkxf2jsrUuh3mtqWEJQgrmfInowf3Gmzyddl4eq77qf9
        ULa1Lo0K0dmKV8XdGE5UTSD7OqfEJMGIiDGRpsKbmQ==
X-Google-Smtp-Source: ADUXVKKu4iocev1mk9v4ku5r/emxIewrIjFozypZjeD5PscR1DI4CzSJ15rZNlbr6JUTHRFikd7yUJpl24uWVR7+gSc=
X-Received: by 2002:a1f:860b:: with SMTP id i11-v6mr10107891vkd.15.1528720754612;
 Mon, 11 Jun 2018 05:39:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 05:39:13
 -0700 (PDT)
In-Reply-To: <20180611115240.32606-8-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com> <20180611115240.32606-8-ricardo.ribalda@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 11 Jun 2018 15:39:13 +0300
Message-ID: <CAHp75Vf-V7BVU_SiyBp18D0cM_nOO=EAxfgzUaa4-hngh9PeMw@mail.gmail.com>
Subject: Re: [PATCH v2 07/24] serdev: Allows dynamic creation of devices via sysfs
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 2:52 PM, Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
> Allow creating and deleting devices via sysfs. Devices created will be
> matched to serdev drivers via modalias (the string provided by the user)
> and deleted via their name. Eg:

> +       nline = strchr(buf, '\n');

...

> +       if (nline)
> +               len = nline - buf;
> +       else

> +               len = strlen(buf);
> +       len = min(SERDEV_NAME_SIZE - 1, len);

If buf is guaranteed to have '\0', the strlen() is not needed.

I'm not sure about this entire dances with first line and so on.
When it's possible to get more, than two lines on input?

Would it be just as simple as strstrip() call followed by strscpy()?

> +       strncpy(serdev->modalias, buf, len);
> +       serdev->modalias[len] = '\0';

strspcy() ?

-- 
With Best Regards,
Andy Shevchenko
