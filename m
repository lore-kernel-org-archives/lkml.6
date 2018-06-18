Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919E1C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5727220850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5727220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934595AbeFRLv3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:51:29 -0400
Received: from muru.com ([72.249.23.125]:47734 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933592AbeFRLvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:51:25 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 3BA808081;
        Mon, 18 Jun 2018 11:54:06 +0000 (UTC)
Date:   Mon, 18 Jun 2018 04:51:22 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Christ van Willegen <cvwillegen@gmail.com>
Cc:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel@pyra-handheld.com
Subject: Re: [Letux-kernel] BUG: drivers/pinctrl/core: races in
 pinctrl_groups and deferred probing
Message-ID: <20180618115122.GT26255@atomide.com>
References: <FC373DE9-6D6B-40C5-ACED-C07B1B524469@goldelico.com>
 <20180615065810.GI112168@atomide.com>
 <20180615111318.GJ112168@atomide.com>
 <029F115C-480E-485A-B547-9D5873925CEF@goldelico.com>
 <4DE2E482-B0D3-4799-9E2D-74E2180B305B@goldelico.com>
 <CAHp75Vf7-xcsoSJ--9nJYbxpwSfDv201UwnxJHoFbwtD187SPw@mail.gmail.com>
 <20180618091433.GP112168@atomide.com>
 <BB5DB278-9827-4351-99DF-54C875B1879F@goldelico.com>
 <20180618095428.GQ112168@atomide.com>
 <CA+Ot1OxNj30KgHWJHXgWbnXYkNXTNvd_t-b6+uG3u=z8+pZf2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+Ot1OxNj30KgHWJHXgWbnXYkNXTNvd_t-b6+uG3u=z8+pZf2Q@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Christ van Willegen <cvwillegen@gmail.com> [180618 10:01]:
> > --- a/drivers/pinctrl/core.c
> > +++ b/drivers/pinctrl/core.c
> > +               if (!strcmp(function, gname))
> 
> 
> This could never fail? gname guaranteed to never == NULL?

Thanks I'll add checks to make sure we always have a valid
name for new functions and groups added.

Regards,

Tony


