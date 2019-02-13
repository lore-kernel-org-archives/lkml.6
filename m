Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6E3C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303DA222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aEiNPADp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731127AbfBMJQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:16:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33501 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbfBMJQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:16:23 -0500
Received: by mail-wm1-f67.google.com with SMTP id h22so1383897wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 01:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+MSho6TGtRH71B7KMbmqjsXQobTe045SJKbrmRWSdpY=;
        b=aEiNPADpwzjXYMgz2bfqSQSxCtheZ7g91ZKCmeIqkkgysa9jg2RJ1tKCPBuKTvzU6f
         JOL8qMG0/hsJre4Hs+BiWAAXZYm1/8d39P4gmkvctZCqAsHScnDJy0iSwxi6MjWYedfc
         SjC3mRKP56DsjZE6b/PnV716XgNKOWQoUQ242kTy6zD19hSUmvVA3ObEeGdTBSxqIyR4
         1NcLU9o4ypnI9ftP4JekpIulQqIwH4FY4YA/Aink3LAaa4yhBCfyQoB5woe6NoZ8p5kR
         w6wMKQbguPLfghKdmYLiy/nAlxgzmS9gizb/nOFDxZUSqN+TjqV/04MHRvu7Cefe5AZE
         SqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+MSho6TGtRH71B7KMbmqjsXQobTe045SJKbrmRWSdpY=;
        b=LTf4v5qXKmytZs1nnyWxeYDkQms9CQjSwK+RJsCF2/6Dtc51nVpTCQmrR9PEc9ycfh
         g1fJ+BTBYIN3FeyH2Lh3lEvozunUBDlCIR3zUo71ZYkYpRoNBtCxKZUhPQCAT34PKEPE
         M/HHrTav5og8wZQ7BnDeAg9DhwIm5/jtwYESI6tV5j0C66kNqUp1OjDJZc28wcO4pMdj
         TZ3EkjTHRl5AdEE5CkSJxmMDeXkWCNTuFJR7fI2ESoVRopGLhAvAE0yjY9UbxqENk9s4
         RuOYaTCp//+9IO+BPwSVBkE+hah37iu6vmgHEU4ohLu6XrJE8whvvBeX/GnyB/8wMxuC
         4bgQ==
X-Gm-Message-State: AHQUAuYaAoZMvmwzdN/EMIg1Qw/J1tyM/6DZVY3HPDjSfwa5Kv2sNz/X
        rn1ok0Qp/QNhHg3YhLuyrYxhVrWJGM0=
X-Google-Smtp-Source: AHgI3IZP2aQVPcbiaNbFOoDOvB7A6b6X5Gl6v9obvWpU8LN0rsL53QwwFDbSBr6Zrp3Jaj6yH7L2+w==
X-Received: by 2002:a05:600c:2159:: with SMTP id v25mr338342wml.17.1550049381055;
        Wed, 13 Feb 2019 01:16:21 -0800 (PST)
Received: from boomer.baylibre.com (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f13sm1099408wmh.41.2019.02.13.01.16.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 13 Feb 2019 01:16:20 -0800 (PST)
Message-ID: <9e86b95eb8c9e3c0454d3aeebac15e354298c815.camel@baylibre.com>
Subject: Re: [PATCH 2/9] clk: Introduce get_parent_hw clk op
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Russell King <linux@armlinux.org.uk>
Date:   Wed, 13 Feb 2019 10:16:18 +0100
In-Reply-To: <154941131193.169292.7500057932043013834@swboyd.mtv.corp.google.com>
References: <20190129061021.94775-1-sboyd@kernel.org>
         <20190129061021.94775-3-sboyd@kernel.org>
         <e303573aefeaf6a7e3a4b1d820e801354ff900b4.camel@baylibre.com>
         <154879654428.136743.10048771201181501034@swboyd.mtv.corp.google.com>
         <ff76dcdb4ceb3209619e5348ed7b575a8ae9df8d.camel@baylibre.com>
         <154888381385.169292.12776041058756822056@swboyd.mtv.corp.google.com>
         <97c2375f41fe7dabc4d71f66c9808912eb0ce611.camel@baylibre.com>
         <154941131193.169292.7500057932043013834@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-05 at 16:01 -0800, Stephen Boyd wrote:
> Quoting Jerome Brunet (2019-01-31 10:40:07)
> > On Wed, 2019-01-30 at 13:30 -0800, Stephen Boyd wrote:
> > > > With this quirk, CCF is making an assumption that might be wrong.
> > > > 
> > > > The quirk is very easy put in the get_parent() callback of the said
> > > > driver, or
> > > > even better, don't provide the callback if it should not be called.
> > > > 
> > > > I understand the need for a cautious approach. It seems I'm only one
> > > > with
> > > > that
> > > > issue right now and since I have a work around, there is no rush. But
> > > > we
> > > > must
> > > > have plan to make it right.
> > > > 
> > > > To be clear, I'm not against your new API but I don't think it should
> > > > be a
> > > > reason to keep a broken behavior the framework.
> > > > 
> > > 
> > > So do you think you can use this new clk_op and ignore the problems with
> > > the .get_parent clk op? Putting effort into fixing the .get_parent
> > > design isn't very useful from my perspective. There's more than just the
> > > problem that we don't call it when .num_parents is 1. There's the
> > > inability to return errors without doing weird things to return an index
> > > out of range and there isn't any way for us to really know if the clk is
> > > an orphan or not. If we can migrate all drivers to use the new clk op
> > > then we can fix these problems too, and deprecate and eventually remove
> > > the broken by design .get_parent clk op API.
> > 
> > Stephen, I have nothing against your new API, I'm sure it will solve many
> > issues
> > 
> > I'm also quite sure that, like round_rate() and determine_rate(),
> > migrating to
> > the new API won't happen overnight. We are likely to still see
> > get_parent()
> > for a while. I don't understand why we would keep something wrong when it
> > is
> > that easy to fix.
> > 
> > I have spent quite sometime debugging this weird behavior of CCF, I'd
> > prefer
> > if it can avoided for others.
> > 
> > Yes, fixing the case I reported does not solves all the problem you have
> > mentionned. Keeping this bug does not help either, AFAICT.
> > 
> > The fact is that get_parent() already return out of bound values on some
> > occasion, and we already have to deal with this when converting the index
> > to
> > parent clk_hw pointer. Doing it in the same way when num_parent == 1 does
> > not
> > change anything.
> > 
> > I really don't understand why you insist on keeping this special case for
> > num_parent == 1, when we know it is not coherent.
> > 
> > Considering, that I already proposed the fix, what is the effort here ?
> > If it is fixing the driver that rely this weird thing, I'd be happy to do
> > it.
> > 
> > 
> 
> Ok. I'm happy to merge your patch to always call the .get_parent clk op
> when num_parents > 0, but please fix all the drivers and analyze all the
> implementations of .get_parent to make sure that they aren't broken by
> the change in behavior. Furthermore, please add a debug/warning message
> into the code when .get_parent returns a number outside of the range of
> [0, num_parents) so that they can be converted to use .get_parent_hw
> instead.

Fair enough.

>  Ideally there wouldn't be anything returning a parent index
> outside the range of possible parents from .get_parent because this
> analysis of drivers would find those implementations and migrate them to
> .get_parent_hw instead.
> 
> In parallel, I'd like to convert all drivers to use .get_parent_hw
> instead of .get_parent and then remove the .get_parent clk op right
> away. 

Fine by me. Of course step #1 is not required if you get this is in before.
As long as things are coherent, I'm happy :)

> I'll start a sweep of the users of clk_hw_get_parent_by_index() (I
> see 50 calls in the tree right now) and see if I can convert them to
> handle errors returned from that API, probably by just continuing and
> ignoring errors. I'll start doing the same conversion for .round_rate
> and .determine_rate so that we can get rid of that duplicate clk op as
> well. Hopefully that's a mostly mechanical conversion.

This would be nice !

> 
> For now I'll move this patch to the end of this series so that it
> doesn't hold things up otherwise.

It could even be separate series ? with the migration you mentionned above ?


