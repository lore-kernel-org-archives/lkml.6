Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFDBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D632075B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PRVRvOC+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393883AbfBNSaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:30:11 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45355 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfBNSaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 13:30:10 -0500
Received: by mail-pl1-f195.google.com with SMTP id r14so3563834pls.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 10:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TEzrBqMLgFPVnf/SXg6Y7hjPdLVUaonVkw86CHiCcIo=;
        b=PRVRvOC+Iy0iJozUW655DtumItSHb0BZor2PsXfOjaVKXvD4hg9qRN1z/eZGNnt8tb
         8i1sWgler8M4k7c6oxmrUemeDCVfKt/j85o6/qIeG0Igr3RJIi5wQIGqSaoJzOHtBGvO
         vfd7FD5KUMxlYXXrxZJS07juJn7RuC3nPEH+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TEzrBqMLgFPVnf/SXg6Y7hjPdLVUaonVkw86CHiCcIo=;
        b=fvW+Mhymvm9TiKCYWIGrODOSFhYr8BT6v6/KQM6EH6I1jleQWnF65hZNWzlUEBiscx
         dzNPTdO+jsaUFiFbA5IBKIzrVpUAG1SkvvM3LhNJk8AIMhPBpINleT7gePJzqfkR+hkf
         nOiejzQ+baqNs33eZuXDi7KLiytx3YIifbvKg3/aZRvCv7hs0xXq514jXqHJWdRC8qC6
         nAK5sOzuOC8035liw6ooCwScrBdo9yyXZZMiUNyJBCWZ5h/EPsbCK+pW7CoN3MlFBVS8
         QPqFIVEX92GxtG32Y+drfpcQjneGTbuWMOFmCIZyHnEfPxBok/mAsg8b1W2Y77xLTR9y
         H7ug==
X-Gm-Message-State: AHQUAub1n0dvXMKwaXb95Jm1npok0AcnLzk77aSi7JI2zQI38JA3Gw5N
        xFkXO1hnBgPBUFIBI6+lXD6nDQ==
X-Google-Smtp-Source: AHgI3IYQDJS5gosCW56bUMdc014I/R+9FE1O3bkY5+dYznU6F/C9K0zvrnhJ6wIxEzDsFfndJcI2WA==
X-Received: by 2002:a17:902:2aaa:: with SMTP id j39mr5675495plb.335.1550169010207;
        Thu, 14 Feb 2019 10:30:10 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id v11sm4837183pfa.49.2019.02.14.10.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 10:30:09 -0800 (PST)
Date:   Thu, 14 Feb 2019 10:30:09 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH 3/4] PM / devfreq: Add devfreq_governor_start/stop()
Message-ID: <20190214183009.GA117604@google.com>
References: <20190214013042.254790-1-mka@chromium.org>
 <20190214013042.254790-4-mka@chromium.org>
 <CAGTfZH0cQhBLDx91VArMQ52z+iJAsfb2Zvk5nJSCqSM=aPhK0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGTfZH0cQhBLDx91VArMQ52z+iJAsfb2Zvk5nJSCqSM=aPhK0A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 11:12:55PM +0900, Chanwoo Choi wrote:
> Hi Matthias,
> 
> Looks good to me for making the function to remove the duplicate code.
> But,  When I just tested the kernel build, following warnings occur
> about devfreq_governor_stop().
> 
> In file included from ./include/linux/devfreq.h:16:0,
>                  from drivers/devfreq/devfreq.c:23:
> drivers/devfreq/devfreq.c: In function ‘devfreq_governor_stop’:
> drivers/devfreq/devfreq.c:619:17: warning: format ‘%s’ expects
> argument of type ‘char *’, but argument 4 has type ‘int’ [-Wformat=]
>    dev_warn(dev, "%s: Governor %s not stopped: %d\n",
>                  ^
> ./include/linux/device.h:1380:22: note: in definition of macro ‘dev_fmt’
>  #define dev_fmt(fmt) fmt
>                       ^
> drivers/devfreq/devfreq.c:619:3: note: in expansion of macro ‘dev_warn’
>    dev_warn(dev, "%s: Governor %s not stopped: %d\n",
>    ^
> drivers/devfreq/devfreq.c:619:17: warning: format ‘%d’ expects a
> matching ‘int’ argument [-Wformat=]
>    dev_warn(dev, "%s: Governor %s not stopped: %d\n",
>                  ^
> ./include/linux/device.h:1380:22: note: in definition of macro ‘dev_fmt’
>  #define dev_fmt(fmt) fmt
>                       ^
> drivers/devfreq/devfreq.c:619:3: note: in expansion of macro ‘dev_warn’
>    dev_warn(dev, "%s: Governor %s not stopped: %d\n",

For some reason the warnings don't pop up in my 4.19 build and I
missed them when compile testing upstream :(

I'll fix the format string in the next version.

Thanks for the review and build test!

Matthias
