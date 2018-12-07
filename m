Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BD3C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2288B20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WJJzIuWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2288B20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbeLGKD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:03:26 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:55128 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbeLGKDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:03:25 -0500
Received: by mail-wm1-f46.google.com with SMTP id z18so3761245wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 02:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=nHNYQeLpY0qOYTNp/VMpeg2iFoPwz6wcmLBfe+S215E=;
        b=WJJzIuWU2Y2cY+Ij+e+3SnTzm/tTY9kwfvN/eFHh7WXEYHNg6HpweP7vZfdUDZTRQm
         atQcd9o7fS/5vXOZzbVHhK+sGbHGq2Hh7KvrlkiungiWfBWFUEHg9Y2reMDnqBEXoABV
         1e3BXc9oP2OUfKfO+uFiDy+9DQbR6YT/HXAHAq2gU4CSic3yHukWvD4Y/qPYhQ8L/S9M
         W5k4kUahjRx91E5OU9pyLuhRlZkVPvOrYhMcfWUtrmCwhJsht7XcfKiyc5GTRZCsCBiB
         RliszBFhsih6jN9ywSeWoxQUSSBThfETeCUWizDh50rtNh6WPpDhei0GGYLCyllWVPwR
         nmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=nHNYQeLpY0qOYTNp/VMpeg2iFoPwz6wcmLBfe+S215E=;
        b=MKaFWY/6Ok1jDUWxu/6whDHIrlnV6ymskeeszJ89srjM3CrIgJLqvAESbDMbZC0i6j
         ZM86N1yLSmw04fdcBepjis9/fZIB6OrAM+43MS8IWD2heYo/YhAZBmcfZK8OYvQPMERs
         3F+opvDbklsSBaX0zjwd/GHJkTzVPdPS5vFjkFY7IlC/SEXVKRu1ppVzPRfWcy4ucAd3
         SxaIB6Iy3+fvLG3+3cbuYFGxWSt9MuJCmCEDNf1GBIfo2gddY/vNYisZDNiYFQR6XnNh
         Q/H1ZSp4zvy2PS9/j0nG6lyCOUbxY8ROq7bfAhbSM6QCX3b4O/B1ktZDDR7QbLDodgXK
         5MKQ==
X-Gm-Message-State: AA+aEWa8jjLOsgZVNymH8Bz2jg9h0UI371Y8BiAEPWmnh3/yL9DyEhN1
        SHxnAo+b1UNV6RffT3fobYpPrg==
X-Google-Smtp-Source: AFSGD/Um7l0nOeW+kTFY6N1jVwzaSfabArQJiAquZRu/VNSYO0lHnU/qI35EdKAq8kkS733mk1P7bQ==
X-Received: by 2002:a1c:1286:: with SMTP id 128mr1725188wms.70.1544177002332;
        Fri, 07 Dec 2018 02:03:22 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id o15sm2216037wrp.12.2018.12.07.02.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 02:03:21 -0800 (PST)
Message-ID: <63f9b6f613cab0db91c8363635aa673a11f75fba.camel@baylibre.com>
Subject: Re: [PATCH] Revert "clk: fix __clk_init_parent() for single parent
 clocks"
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 07 Dec 2018 11:03:19 +0100
In-Reply-To: <154413410087.88331.10879623310968389005@swboyd.mtv.corp.google.com>
References: <20181204163257.32085-1-jbrunet@baylibre.com>
         <154394675320.88331.12449582989130694425@swboyd.mtv.corp.google.com>
         <807f2924b67239f61c6d93de7f7b124f8a1f195a.camel@baylibre.com>
         <154399647605.88331.115722031910044874@swboyd.mtv.corp.google.com>
         <98e430d7a96fa6b4f0225e57820a4a677108a052.camel@baylibre.com>
         <154413410087.88331.10879623310968389005@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-06 at 14:08 -0800, Stephen Boyd wrote:
> Sorry this email is long.

I tried reply the best I could to your use cases

> 
> TL;DR is that I don't think we need to revert the patch as you suggest.
> Instead, we should fix the driver to indicate NULL as the parent name of
> the index it tells the framework about.

The driver, can't indicate NULL, it just provides the index of the parent.
What we are saying is not very far apart.

Drivers implementing get_parent() must have way to tell the framework "I have
no idea what I'm connected to ATM"

Since get_parent() return a u8, the only way to signal a problem like this is
to return an out of bound value, which the framework already safely understand
and maps to NULL, as you request

This is done in the other patch I sent (... and now they are related ;) ...)
by returning num_parents in the clk_mux code

This is an important case, whatever the number of parent. I think it makes no
sense that a clock with 2 known parents can return this error, a one with only
one known parent can't.

This why I still think the change should be reverted.

If you really insist on keeping it, there should at least be a warning when
registering a clock with 'get_parent != NULL' and 'num_parents == 1', to let
the user know that whatever is implemented there will be ignored ... instead
of silently ignoring it. I think it would be a mistake, but at least there
would be no suprise.

Earlier, you mention having a special parent that would adopt the the orphan.
Actually, it already exists, it is the framework itself. If, instead of
returning 0, it returned a special value to let us know we reached the root
and there actually no signal, we would be easy to make sure the orphan (with
no signal) are never accidently used.

> 
> Quoting Jerome Brunet (2018-12-05 09:20:09)
> > On Tue, 2018-12-04 at 23:54 -0800, Stephen Boyd wrote:
> > > Ok. Thanks for the explanation. What do you do to fix this problem in
> > > the 'ao_cts_cec' clk implementation?
> > 
> > IMO, there is nothing to fix, the implementation is correct. 
> > 
> > >  Sounds like you just rely on
> > > clk_set_rate() to fix this all up for you when the consumer changes the
> > > rate?
> > 
> > To setup the rate as the customer expect, yes.
> 
> Ok.
> 
> > > If we have something that is default parented to something we're not
> > > telling the framework about for some reason then one solution would be
> > > to have some init code reparent the clk in hardware before registering
> > > it with the framework. Basically "fix up" the clk tree in hardware to be
> > > consistent with what software can reason about. 
> > 
> > Should we really ? Something the framework does not know about is not
> > necessarily something wrong.
> > 
> > It would best if we could model the tree completly, but most of the time,
> > we
> > just approximate it the best we can.
> > 
> > The framework just knows how to setup rates, it has no idea what rate
> > needs to
> > be set or when - And I think it is best if does not make any assumption
> > about
> > that.
> > 
> > Pushing it a bit, this unknown parent might important to the boot
> > sequence.
> > How would you know when it is safe to change the setting ?
> > What would change it to ? It Seems obvious when there is only one known
> > parent, but what if there two ? which one do you pick ? Is it really the
> > role
> > of CCF to make this kind of choice ? 
> 
> Agreed. We can't mandate this requirement because of what you say. There
> are pitfalls such as not always knowing if it's safe to change the clk
> tree before clks are registered.
> 
> > > This also reminds me of some audio clks I've seen before where the
> > > default parent is some external pin and it can be reparented to an
> > > internal clk with clk_set_rate/parent. In that case, I think we forced
> > > the parent over to the internal clk before registering so that it would
> > > always get parented properly in the framework. Right now, this is going
> > > to cause problems for plans to probe defer clk_get() on orphan clks.
> > 
> > clk_get() on orphaned clock should probably return an error if it is not
> > the
> > case already ? or 0 maybe ?
> 
> I'd prefer that it return EPROBE_DEFER if the clk is an orphan, except
> that it causes problems for this case where muxes move away from
> something unknown to something known.
> 
> > > Maybe this could work better if we allowed
> > > 'assigned-clock-parents/rates' to reparent clks regardless of orphan
> > > status and/or had some flag that could be set on clks to indicate that
> > > we're OK if clk_get() is called on it when it's an orphan because this
> > > isn't a problem?
> > 
> > Not sure I understand your point here.
> 
> There is a problem with assigned-clock DT properties and orphan clks and
> making orphan clks defer driver probes.
> 
> > > Or we can make the defer on orphan code only defer if the clk has a
> > > single parent and it's an orphan and return the clk if there is at least
> > > one parent of the clk that has been registered and isn't marked as an
> > > orphan. That would need to be recursively applied, so I guess we would
> > > update our orphan marking code to indicate that clk_get() on the clk
> > > should probe defer or not instead of indicating the clk's orphan status.
> > > Doing this would also side-step the problem Rockchip was having where
> > > certain parents never appeared but the clk was parented to it in
> > > hardware, essentially blocking the clk from ever being touched by
> > > consumers.
> > 
> > ... and now you lost me completly :)
> 
> Hmm alright.
> 
> > > On the other hand, not having the clk there causes us to do a global
> > > search of the clk name space each time we look for parents by the
> > > "unknown" index, which in the Rockchip case was quite often because the
> > > clk was changing between two other parents with a third one that never
> > > got registered. So it may be better to just register an "unknown" clk as
> > > a root clk with a rate of 0 that you can then hook everything up to that
> > > is hardware reset to this unknown input. That way nothing is orphaned
> > > and everyone is happy. We could do this for the audio case I talked
> > > about earlier too so when the external pin is left unconnected we could
> > > register some 'unconnected' clk and parent the audio clk to it.
> > 
> > We have sometimes a few orphans in the amlogic clock tree, it does not
> > seems
> > to a problem.

To the best of my knowledge, there will always be orphan in the tree. The root
clock (usually an xtal) being a special case of this. 

It seems to me that the problem is we can't differentiate between this special
orphan and the rest because none will return an error when calling get_rate()

xtal will provide something to round_rate() while other clock which are
supposed to be orphaned will defer to the framework which gives a 0 rate.

I think this is your real issue with orphan in the framework. The framework
does not distinguish between a signal with rate == 0 and an error (no signal)
> 
> I suppose drivers aren't calling clk_set_rate() on the orphaned clks and
> experiencing problems? There are problems around clk rates that could
> happen if there aren't any proper parents of a mux.
> 
> > I don't really understand the benefit of having a fake clock that would
> > adopt
> > all the orphan ? You guess there is problem I'm not aware of ...
> 
> I see three cases that can go wrong if we make orphan clks probe defer
> clk_get():
> 
>   1) NULL as the parent name for some parent index that the hardware
>      indicates is the current parent of the clk when the clk is registered.

I don't think you can have NULL has a parent_name

> 
> In this case, we need to make clk_get() succeed and not return
> -EPROBE_DEFER, so I think we need to make a special "unknown" clk in the
> framework so that clks aren't orphaned when the hardware is indicating
> the parent is something we don't (and won't) know anything about.

I think DEFER is returned when clock is unknown, not when it is orphaned.

> 
>   2) get_parent/set_parent on a clk with num_parents == 1
> 
> This seems to be how ao_cts_cec is implemented. This hides the fact that
> get_parent may return some number above the number of parents

The index returned will be either 0, to indicate the only known parent, or
num_parents (1) to indicate an invalid parent to framework. This is the topic
of the other patch I sent you

You must have way for a driver to tell you that it is not connected to
anything it knows. That's a very basic error case and this is not specific to
num_parents == 1. 

With any number of num_parent, there is still a possibility that a driver ends
up in configuration where it cannot tell what it is his parent. (invalid
combination, reserved values, crappy doc ...)

This is why is important to call get_parent() (if available) even when
num_parent == 1. The driver might tell if it is connected as expected - or not

> and then
> has that quietly make the parent of the clk NULL during registration so
> that it's orphaned. Then we rely on set_rate() or set_parent() being
> called to fix the parent chain at a later time.
> 
> That is complicated and non-obvious. I'd rather that we specify NULL as
> a parent in the parent_names array if we're going to return that index
> to the framework and then have the framework go to case #1. This makes
> it easier for the framework to assume that [0, num_parents) is the valid
> range of indices returned from the get_parent() op and a number outside
> that range is an error, clearing the way for errors to be returned from
> get_parent() if it somehow fails.

The fix I sent is quite simple.

The above would require that:
1) the framework accept NULL in the list of parent (which it forbids ATM
AFAIK)
2) Have all drivers account for this a create this fake parent

This seems to be putting more work on the drivers with no real gain for the
framework, none that I can see at least.

> 
>   3) A string as the parent name for some parent index that the hardware
>      indicates is the current parent of the clk when the clk is registered,
>      but that parent clk may never be registered with the framework.
> 
> I imagine this can happen with an external gpio clk that feeds some SoC
> internal clk. That gpio could be supplied by some clk signal that the
> board designer decides to send there, and it could also just "magically
> appear" by applying some DT overlay. Due to our use of global strings
> for parent linking, we don't have a good way to figure out that nothing
> is connected to some clock input signal, making this quite a nightmare
> to figure out a runtime!
> 
> One solution is to replace the parent name with NULL and ignore the
> runtime update case. This will work and bring us back to case #1. The
> problem is that if it is connected to something like a GPIO and it
> defaults to that pin instead of some internal clk we're stuck with an
> "orphan" clk that we can't clk_get(). I suppose the driver could read DT
> and see if this pin is not connected and then mark this input parent
> name as NULL. We can punt on solving the DT overlay problem until later,
> because we would need some way to dynamically resolve a new parent of a
> clk and update the tree when the DT node is modified to use a new GPIO.

I don't understand what is the problem here.
In Amlogic we have a lot of this cases, with optional input clocks of the axg-
audio clock controller. Many muxes have parent names of clock that don't
exists.

CCF will return a 0 rate for these inputs.
It works well as it is, but as said above, I think it would be better if we
could distinguish between a signal with 0 rate and no signal at all (error)

> 


