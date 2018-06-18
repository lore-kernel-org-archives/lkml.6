Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFBBC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E249A208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E249A208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755025AbeFRGtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 02:49:03 -0400
Received: from muru.com ([72.249.23.125]:47600 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754949AbeFRGtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 02:49:01 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 454D78081;
        Mon, 18 Jun 2018 06:51:42 +0000 (UTC)
Date:   Sun, 17 Jun 2018 23:48:58 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Paul Cercueil <paul@crapouillou.net>, sean.wang@mediatek.com
Subject: Re: [PATCH 1/5] pinctrl: core: Return selector to the pinctrl driver
Message-ID: <20180618064858.GM112168@atomide.com>
References: <20180615111141.37184-1-tony@atomide.com>
 <20180615111141.37184-2-tony@atomide.com>
 <CAHp75Vdi-9pEPYy3+hh9rw1-sMvmh7vahz_idug0XcMaCQh6=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vdi-9pEPYy3+hh9rw1-sMvmh7vahz_idug0XcMaCQh6=Q@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Shevchenko <andy.shevchenko@gmail.com> [180617 16:53]:
> On Fri, Jun 15, 2018 at 2:14 PM Tony Lindgren <tony@atomide.com> wrote:
> > @@ -641,12 +642,12 @@ int pinctrl_generic_add_group(struct pinctrl_dev *pctldev, const char *name,
> >         group->num_pins = num_pins;
> >         group->data = data;
> >
> > -       radix_tree_insert(&pctldev->pin_group_tree, pctldev->num_groups,
> > +       radix_tree_insert(&pctldev->pin_group_tree, selector,
> >                           group);
> 
> A nit: Can it be now one line?

Sure will update and post an updated series of patches. It probably
makes sense to wait a bit with these as there are still issues
remaining for deferred probe.

Regards,

Tony
