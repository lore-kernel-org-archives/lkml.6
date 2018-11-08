Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18EDC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A23A2081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A23A2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbeKHQYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 11:24:55 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35310 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeKHQYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 11:24:54 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so17014306ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 22:50:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eNUxb41xzPe5KJqUu4YafX7i28L4FBLsrGC2yNcIFP8=;
        b=Nwn5B0TlxBJY5m3eh3CPmFZhJCDkxjQz3GaJ432637AkRs9h5LJZ9+GO57Kg6+CkPP
         znf/wrnDcSyX3+SsFcrLndBX3nt7Us2TXT6PpIYWETy8SXuCokSgQlHUaERtcnV5fOfM
         DjRNPm0cAdJLh8gBML0CDuaV/hx5zWvpNQf/2uOUyYdk4AC+NmUsQ/xIaGRWRznEPZbf
         rPzotfBUOtZe+aeiTcHIZW77DZpbV1H2ia1YXHvidx15Nwm9JsxXxVI9KWwgmj1PPUww
         N3WgFSihVxYVIKgujBxv7qiN4cmKmNudP3rr4ZcLng5MLD341Pm0KkaTt8jpqhhcMw7H
         wqzA==
X-Gm-Message-State: AGRZ1gLAbxRd81F7PPoZegHmPhfjyECqF2uMzReAABtTK64FyuTTspBt
        kJH0kW58I6s15Y1qCmj+ZXX+6Si/
X-Google-Smtp-Source: AJdET5c/srY5K54a/3CRFwPn6QpTAd/oRHGfyq4zrxgiPqpSewYMFN6ILohFxmFfIvX4Qar7O949zA==
X-Received: by 2002:a2e:4408:: with SMTP id r8-v6mr2204268lja.21.1541659851663;
        Wed, 07 Nov 2018 22:50:51 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id k7-v6sm487542ljh.70.2018.11.07.22.50.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 22:50:50 -0800 (PST)
Date:   Thu, 8 Nov 2018 08:50:42 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] regulator: bd71837: add <linux/of.h> to fix build errors
Message-ID: <20181108065042.GA31573@localhost.localdomain>
References: <cf89bc2f-f7c0-0ed6-38d8-0c47a05ed706@infradead.org>
 <042F8805D2046347BB8420BEAE397A4066F1CF4C@WILL-MAIL001.REu.RohmEu.com>
 <6a52ae58-b5d6-d86b-3597-5b8a1fe30e97@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a52ae58-b5d6-d86b-3597-5b8a1fe30e97@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Randy,

On Wed, Nov 07, 2018 at 08:38:50AM -0800, Randy Dunlap wrote:
> On 10/25/18 11:02 PM, Vaittinen, Matti wrote:
> > Hello,
> > 
> > From: Randy Dunlap <rdunlap@infradead.org>
> > 
> >> Fix build error due to missing header file:
> >>
> >> drivers/regulator/bd71837-regulator.c:242:3: error: implicit declaration of function 'of_match_ptr' [-Werror=implicit-function-declaration]
> >>
> >> Fixes: ba08799e90b5 ("regulator: bd71837: BD71837 PMIC regulator driver")
> > 
> > //snip
> > 
> >> --- lnx-419.orig/drivers/regulator/bd71837-regulator.c
> >> +++ lnx-419/drivers/regulator/bd71837-regulator.c
> >> @@ -9,6 +9,7 @@
> >>  #include <linux/kernel.h>
> >>  #include <linux/mfd/rohm-bd718x7.h>
> >>  #include <linux/module.h>
> >> +#include <linux/of.h>
> >>  #include <linux/platform_device.h>
> >>  #include <linux/regulator/driver.h>
> >>  #include <linux/regulator/machine.h>
> > 
> > Not sure if this is relevant but if I am not mistaken this should already be fixed by: 
> > df43519eb706edfe951284a825642ce2e1d38d09 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=df43519eb706edfe951284a825642ce2e1d38d09
> > 
> > 
> > Br,
> >     Matti Vaittinen
> > 
> 
> Hi,
> 
> It seems that this same patch is now needed in
> drivers/regulator/bd718x7-regulator.c:

Noticed same thing. Few fixes seem to be lost when pickable ranges and bd71847
support was added. Sent this: 
https://lore.kernel.org/lkml/20181029121630.GA11183@localhost.localdomain/
to Mark few days ago. I guess this fix should end up in 4.20?

Br,
	Matti Vaittinen

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
