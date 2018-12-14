Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D710C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E771B20645
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jAY2/sXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E771B20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbeLNFvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 00:51:11 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:50726 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeLNFvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 00:51:10 -0500
Received: by mail-it1-f194.google.com with SMTP id z7so7404436iti.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 21:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gzzd+NoopftUP3F1LEhGKqsNdMlAbNMwrc58XPeZ3cY=;
        b=jAY2/sXnVoO81kuDmOE4YjE6uZ2cz3jXwiBn8AzhJnSPnvce3u0GQPe0oNqUadfLE0
         cHw/7vf3YXCz0vp7wyFSa59mSYxdsKHahcloPygj8yi0Twpx0vFcga214FvmhTqXZPhn
         eHA5zZuKB573wAMbb6fLRuDh1tP3yKfTdK864=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gzzd+NoopftUP3F1LEhGKqsNdMlAbNMwrc58XPeZ3cY=;
        b=Jy2DU+TR2ftHWrLSTJbh7VV6CU3UykfHBw+AT+9Jfug665YeQgfTa2u9CIQqjbnNz6
         Q4m/Gd8LbcPjxCN9DtzVlT8/9zYNYiqV6H2Igu10D58aqFqerps3Dy940U54g+ho/8Fg
         0bp760pqZVf/A0BEe5RUrmrovLZ6Ojk4PzJEsxfsrH7heAnpo6W81NWVtZDPphPyG5BG
         Z6fTfbnQdpSvtcXF5f05MQYOTDoJk+avpRorKvzeOr/00KSd1xWpk4E9BVnrnvD2/RHy
         OfVIIK2yClcfCKZw83vDKw95HPIsOx3pJgFpk/d/D+zFuhg2bemg8bE72ir1JhYrqMNt
         1DBA==
X-Gm-Message-State: AA+aEWZ97ezmNnMUdNY5aUBG+NSm4O4BSqlXd7M7L1T6m8iRfNBDiTA8
        mYq/kg2mVWIJnTmdKpB+NkRIEDTTZzXig4hs5hC4HA==
X-Google-Smtp-Source: AFSGD/VK/UqnjMhDgfDDGh2avN0vOB4I4qQxCQZChrGZnJ+vmS7H1eObkoEr35/YQBWuNAujLs+07Z+2uHXjUdYMLO0=
X-Received: by 2002:a05:660c:12c7:: with SMTP id k7mr1982555itd.148.1544766669902;
 Thu, 13 Dec 2018 21:51:09 -0800 (PST)
MIME-Version: 1.0
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
 <1544073508-13720-4-git-send-email-firoz.khan@linaro.org> <20181210195144.dvprpyxyddusyb5c@pburton-laptop>
 <CALxhOng7EzAd2zHKAOj3ipEd6y=DpS2JGo34s4V_cWVgmLjPwg@mail.gmail.com>
 <20181211185947.gnaachztyh3ils7o@pburton-laptop> <CALxhOngErLD7+CEhgSPwQUnGg7YEFTcH-v6dhR0j55SvEg1FoA@mail.gmail.com>
 <20181212222834.2zf3rb67fxfcmwuw@pburton-laptop> <CALxhOnht8H6r38bwm7xqbHuJs6dvLB03GCKyws2cif1mEE+sKA@mail.gmail.com>
 <20181213201540.ae6pxtm2xmrxnaaa@pburton-laptop>
In-Reply-To: <20181213201540.ae6pxtm2xmrxnaaa@pburton-laptop>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Fri, 14 Dec 2018 11:20:58 +0530
Message-ID: <CALxhOnhAP0TRSH=otZNHdLJgy7=Q=hWOXZSNYBvWAuAzEeBzhw@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] mips: rename macros and files from '64' to 'n64'
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Fri, 14 Dec 2018 at 01:45, Paul Burton <paul.burton@mips.com> wrote:
> I've applied v5 but undone the change from __NR_64_* to __NR_N64_*
> because it's part of the UAPI & a github code search showed that it's
> actually used.
>
> Could you take a look at this branch & check that you're OK with it
> before I push it to mips-next?
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git test-syscalls
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/log/?h=test-syscalls

This looks good to me. Please push to mips-next.

Thanks
Firoz
