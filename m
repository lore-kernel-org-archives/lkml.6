Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933CCC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E83218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="s6OgndC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbfA3Jxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:53:47 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34993 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfA3Jxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:53:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so25336085wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 01:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=oFMEq60mlvfkNYV3bHmuRYApECuP0hzDZIzSG+XqzDA=;
        b=s6OgndC4b9+kcQnu0hn+Azfe3y/COIu0+dnVMQkLw7p1ImKyyiBwL1kkLadL5lJFf0
         lEEfbYjOegF6OAigRXl7eUg1JeAbcV9biWB+O1ef/xOAY2OsEVAMVpBeRvmAnytoE8A7
         PAXhGb+Y/VmmSOc0yoV4HeeJOLUVItwnhwA8cWx1B9bR4qYCHcdDs2YJk0IuDESocJ2k
         yTuAN2igFQPavrHeqi4xmS6Z2uKFwuWjihB1p0NohH1BeZZvd9HhXjW05ZxcTyza1C/Z
         IlUJUdEkaX11WYS3qD/o9RK/H7amqrUR6JLBPdB+ANS1G9vUAAAcSx0gcMlAD1/aLbGR
         hrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=oFMEq60mlvfkNYV3bHmuRYApECuP0hzDZIzSG+XqzDA=;
        b=J2DFUgpeh0YBOdElOpvqF56Sj91VshQ4rFuGj/Lbnvb4XcCdfy6j+yrt2HP8sH8fv/
         Hz6K27P80nw4Tpa9CYq7uAajuqOOjIub/+eAf5Q4yY3ZlGRM65uTzeGKvHLQEZNofrjl
         2g6U7SuzHPjRlxEpTx4ugH4JurhTMEMVvR3v8EzdBS12SfVcWnFLk+If/xjOMTunkN/D
         auNy3f+8rjQYmIVvs2++iBR7V6zHHhI1huCguYCQUVCweM+oQThmHQtlzIDlVlEeKmG3
         NYMurv696UL81ZK2jvWeWh4XtQ4VDKh7hC/n6f26HtlxdwqcaOT2Mf2WpEgUMg51zLkt
         2L/Q==
X-Gm-Message-State: AJcUukfjhZCFE/J/MVBq7DJXqQV0DNpSXh7l5jL6HcUePXByEqMlbT9V
        /6IV3jROkGn3UKqtva9JvdbLyQ==
X-Google-Smtp-Source: ALg8bN63BSJ9wt0tXjTzrY2CCV2zaKuMlHv7/Xv1T5oh2zoHn4C6rfYLvjwVgnO1P81PfMw/pjQ3DQ==
X-Received: by 2002:a5d:67cf:: with SMTP id n15mr28531965wrw.211.1548842024146;
        Wed, 30 Jan 2019 01:53:44 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id s8sm655741wrn.44.2019.01.30.01.53.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 30 Jan 2019 01:53:43 -0800 (PST)
Message-ID: <ff76dcdb4ceb3209619e5348ed7b575a8ae9df8d.camel@baylibre.com>
Subject: Re: [PATCH 2/9] clk: Introduce get_parent_hw clk op
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Russell King <linux@armlinux.org.uk>
Date:   Wed, 30 Jan 2019 10:53:41 +0100
In-Reply-To: <154879654428.136743.10048771201181501034@swboyd.mtv.corp.google.com>
References: <20190129061021.94775-1-sboyd@kernel.org>
         <20190129061021.94775-3-sboyd@kernel.org>
         <e303573aefeaf6a7e3a4b1d820e801354ff900b4.camel@baylibre.com>
         <154879654428.136743.10048771201181501034@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-29 at 13:15 -0800, Stephen Boyd wrote:
> > I suppose this is the answer the discussion we had last year. I'm not sure
> > it
> > answer the problem. In the case I presented, we have no idea wether the
> > setting is valid or not.
> > 
> > We can't assume it is `at least something valid`, the value in the mux is
> > just
> > something we can't map.
> 
> So if you can't map the value in the mux how is that valid? I would
> think the mux knows what indexes it has strings for, and if the index
> isn't in there it's invalid. Is that not the case here?

It is the value we find in the register after the bootloader. Since we have no
idea what it is, we must assume it is invalid.

The problem was that there only one known parent for this particular clock,
and the CCF quirk (call get_parent() only if num_parent == 1) is making things
difficult for us.

We found a work around to this. We declare a non existing parent, which make
num_parent == 2 and force CCF to call get_parent(), and later on set_parent()
... It works but it sucks.

> 
> > Aslo, could you provide an example of what such callback would be, with
> > clk-
> > mux maybe ?
> 
> Sounds fair. I can convert the clk-mux API to this op. It may be that we
> need to make clk_hw_get_parent_by_index() return an error pointer
> instead of NULL if it can't find the clk so that we can move the error
> codes through this new API.

Sure, good idea.

If clk_hw_get_parent_by_index() may return an error, it because get_parent()
could provide an invalid index.

Which brings us back to the original point, if it is possible for get_parent()
to return invalid index, which means out of bounds, it shall be called even if
num_parent == 1.

To be coherent, either:
1) the return value of get_parent() *MUST* be valid, it is fine to not call it
if num_parent == 1 because we already know the only possible result.

2) the return value of get_parent *MAY* be invalid, then it should be called
regarless of num_parent.

IMO, (2) is the only valid option because any existing muxes could already be
returning invalid indexes. I know we do on Amlogic (with various muxes, even
with num_parent >= 1) and I'm sure we are not the only ones. Plus a driver
needs to have a mean to tell CCF that things are not as expected.

> 
> > I don't get how a clock driver will keep track of the clk_hw pointers it
> > is
> > connected to. Is there an API for this ? clk-mux must access to clk_core
> > to
> > explore his own parent ... which already does not scale well, expect if we
> > plan to expose clk_core at some point ?
> 
> No we don't want to expose clk_core to provider drivers. It is only for
> the use of the clk framework and it's not exposed even as an opaque
> pointer. We have that core member of clk_hw but that's just to traverse
> from clk_hw to clk_core, and not for anything else.
> 
> > > +             if (!parent_hw && update_orphan)
> > > +                     core->orphan = false;
> > > +     } else {
> > > +             if (core->num_parents > 1 && core->ops->get_parent)
> > 
> > I still get why, when num_parents == 1, it is OK to call get_parent_hw()
> > and
> > no get_parent(). It does not seems coherent.
> 
> I'd rather not change behavior of existing code in this patch, 

In this patch, I agree

> so I took
> the route of adding another callback with semantics that we can define
> now because there aren't any users. The difference between the two is
> made intentionally.

I still think that the drivers relying on this quirk (only 1 AFAIK) are broken
and should be fixed, rather that keeping the quirk for everyone else. 

With this quirk, CCF is making an assumption that might be wrong.

The quirk is very easy put in the get_parent() callback of the said driver, or
even better, don't provide the callback if it should not be called.

I understand the need for a cautious approach. It seems I'm only one with that
issue right now and since I have a work around, there is no rush. But we must
have plan to make it right.

To be clear, I'm not against your new API but I don't think it should be a
reason to keep a broken behavior the framework.


