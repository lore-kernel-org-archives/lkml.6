Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162C8C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81F42083E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81F42083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934400AbeGDIrZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:47:25 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36253 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932439AbeGDIrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:47:21 -0400
Received: by mail-lj1-f195.google.com with SMTP id u7-v6so1046522lji.3;
        Wed, 04 Jul 2018 01:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=c/kWDpyT9bKPRvJ2jE8oXnJjcrosdXbsZQrzuJOoqXU=;
        b=p1PalngmbAO2d7xe6KZ6dTz3hk6/k5eEPYw4DpDOf9MOBBjJdx5Od8LZzwKPQ4+bs+
         vOBqYj7GiaU3vxpsOudN+Ia4ic0uz0MdIR6g8VD6mUb1vk0okOzzILIFUGt3dOeW3oo/
         n1FeRp2qVH5EOgfv5MGhhW65s55TOGtVGyxTcSnb7AyMMdKFwvc5Hb/Paz8vf11icFxf
         QG2+iR3d+/gb7jwtyZZ6Cv5LY717RftK7aAWStBkl3SO76ElV3qGNZLf0TtL1A2pEiMh
         o3WNPQJU3nDAh6jC59Vo9LPtXjZgULeWG6eLoZO6Jg/Q/ayw9uWlulgW6F+Y61aGiizD
         6JNw==
X-Gm-Message-State: APt69E1yxD0mOvNhx/Uxf9OCfYJGyL4DiNnz6/58K0yR61W9pyAvD5pu
        FcXMNsNlLFf2fg5dXqKuU3g=
X-Google-Smtp-Source: AAOMgpeUlsOi55KhsX3nGpe5mNye6r4+BrZFuipGFfU9HkX2FSjqsNDn2ExseDodwU5IFCl1FA2CCQ==
X-Received: by 2002:a2e:3c13:: with SMTP id j19-v6mr925258lja.149.1530694039934;
        Wed, 04 Jul 2018 01:47:19 -0700 (PDT)
Received: from localhost.localdomain (82-203-190-178.bb.dnainternet.fi. [82.203.190.178])
        by smtp.gmail.com with ESMTPSA id l139-v6sm684174lfl.67.2018.07.04.01.47.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 01:47:19 -0700 (PDT)
Date:   Wed, 4 Jul 2018 11:47:15 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org,
        mazziesaccount@gmail.com, arnd@arndb.de, dmitry.torokhov@gmail.com,
        sre@kernel.org, chenjh@rock-chips.com, andrew.smirnov@gmail.com,
        linus.walleij@linaro.org, kstewart@linuxfoundation.org,
        heiko@sntech.de, gregkh@linuxfoundation.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v7 0/4] mfd/regulator/clk/input: bd71837: ROHM BD71837
 PMIC driver
Message-ID: <20180704084715.GI2118@localhost.localdomain>
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <20180621103400.GB6076@localhost.localdomain>
 <20180703070200.GC20176@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180703070200.GC20176@dell>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 08:02:00AM +0100, Lee Jones wrote:
> On Thu, 21 Jun 2018, Matti Vaittinen wrote:
> 
> > On Tue, Jun 19, 2018 at 01:55:31PM +0300, Matti Vaittinen wrote:
> > > Patch series adding support for ROHM BD71837 PMIC.
> > > 
> > What is the preferred way when I send updated patches:
> > 
> > 1. always resend _all_ unapplied patches even if there is no changes to
> >    some of them. (patch-vN mail thread contains _all_ unapplied patches)
> > 2. only resend changed patches (patch-vN mail thread contains only
> >    patches that were changed from patch-vN-1)
> > 
> > I have currently used approach 1 - so that no patches would be
> > accidentally forgotten - but downside is that people need to check if
> > they have already reviewed some of the patches. I'd rather not caused
> > any extra work. What is the most convenient way for you guys?
> 
> Option 1 is preferred.
> 
> Just ensure you apply any tags you have collected so reviewers can see
> which patches are pending a review.  It's also a good idea to keep a
> succinct change log between the "--" marker and the diff stat where
> you can state "v4: No change" or the like.

Right. Thanks. Just one question - what if I get reviewed-by for a
patch which I later rework? Like this MFD patch where I got reviewed-by
from Linus Walleij for v6 - but which I reworked due to comments from
Enric and Dmitry. I have not kept the reviewed-by as the patch is not
exactly the same Linus was originally reviewing. I guess the tags should
be only kept for patches which are unchanged, right?
> 
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
