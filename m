Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6409C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CD320833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwJ/vPPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72CD320833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbeGZAfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:35:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44381 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731420AbeGZAfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:35:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so6264215pgp.11;
        Wed, 25 Jul 2018 16:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DXiR6jobdeTgdgZHolqSeWE5AY8vuP2Jb++cjJkWkSo=;
        b=PwJ/vPPcDxXxGV/SyE6w4rQyHGP0XVXE6vIxjHQRBf1vqzFPrj9NMz+Z4sddUEjNvU
         gC1CCXfHyZLhgL07Xc8Ejcno7GI6Y6X/SlRjosyIxWbu7djZ45apiU5XEK2qNRCzZqpi
         9RYyJQhJNA4Zc14PYR/bYHclQKgri5u8gCH4TBq4oyIrIJw8yodGXuq+vwbkFAKa4/mb
         t5Eg4rz5veTRIsGAfh8nL/RU9HdIIsH3npR8jr/L+AExzdtORlzSqWNb2/+GpGhX+oCE
         gzIkslQwmlx6NHsYfx1PmLmUIY3/1YQNDeYekEgtcKkB6oTHVjoWnNZxFv6SgSrb1mJh
         ksAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DXiR6jobdeTgdgZHolqSeWE5AY8vuP2Jb++cjJkWkSo=;
        b=ayrcdF9jrx9mEWMhhBVHFziO2W2X/BnDUeZC8JpDtEbLRj8jcwaKMrM1DSMsd1Urkq
         CbA+EeZZdYLpT3ol83532yXxZWBS2BZx+nV2NFdhMbnJ6A+sMTr7XX5y6b99gu1Dm6GD
         2+l9dEpW2uuu2qK/+0brLkDJy5FbBlrJfXKInCeseEu9bySw7TItfERF1bNcEzNqQ9IW
         f/DKiCnLL3TjkkBbNZLCmbcJsOLs+11wsxhOSvUojIm7zDtVNBmU/g8mGJyCZ7lKAyiS
         q7fQrXwMVGYM4r2tkshiHmx1BIvqMFrWjhnw0Skl9g0ng+Z570rxhSJ8p+bCDutt8Olm
         c0Zw==
X-Gm-Message-State: AOUpUlHMiJwWdHiRrepHSaH59Jxbkd0lIPxvywKQAKhy+KSwq8JA50nl
        IHNtaugGKCUCvRLKANbd5AQ=
X-Google-Smtp-Source: AAOMgpeq2JNr8VTxTj6FtwC7DQC2uoWLklnGl8L5+fMFIPPf0A0wYSPVqajgaaGtaN56Zk+Aptxybw==
X-Received: by 2002:a62:4ece:: with SMTP id c197-v6mr13297389pfb.240.1532560873285;
        Wed, 25 Jul 2018 16:21:13 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id p66-v6sm41382143pfd.65.2018.07.25.16.21.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 16:21:12 -0700 (PDT)
Date:   Wed, 25 Jul 2018 16:21:10 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Peter Hutterer <peter.hutterer@who-t.net>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Nick Dyer <nick@shmanahar.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        cphealy@gmail.com, nikita.yoush@cogentembedded.com,
        l.stach@pengutronix.de, nick.dyer@itdev.co.uk
Subject: Re: [PATCH v1 09/10] Input: atmel_mxt_ts - tool type is ignored when
 slot is closed
Message-ID: <20180725232110.GA80336@dtor-ws>
References: <20180720215122.23558-1-nick@shmanahar.org>
 <20180720215122.23558-9-nick@shmanahar.org>
 <20180723223347.GJ100814@dtor-ws>
 <CAO-hwJ+BoWdXbH1sbde2+qb_sgFBMarM0156a1VrRSQdhNf3xQ@mail.gmail.com>
 <20180725052641.GA7072@jelly>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725052641.GA7072@jelly>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 03:26:41PM +1000, Peter Hutterer wrote:
> On Tue, Jul 24, 2018 at 10:23:27AM +0200, Benjamin Tissoires wrote:
> > On Tue, Jul 24, 2018 at 12:34 AM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > >
> > > On Fri, Jul 20, 2018 at 10:51:21PM +0100, Nick Dyer wrote:
> > > > From: Nick Dyer <nick.dyer@itdev.co.uk>
> > > >
> > > > input_mt_report_slot_state() ignores the tool when the slot is closed.
> > > > Remove the tool type from these function calls, which has caused a bit of
> > > > confusion.
> > >
> > > Hmm, maybe we could introduce MT_TOOL_NONE or MT_TOOL_INACTIVE and get
> > > rid of the 3rd parameter? It will require a bit of macro trickery for a
> > > release or 2...
> > 
> > I am not sure what would be the benefit of adding those new tools, if
> > the input_mt code discards them. Do you want to forward them to the
> > userspace with the release?
> > This reminds me the discussion we had recently with the touchscreens
> > releasing the slots with a MT_TOOL_PALM.
> > 
> > Anyway, better include Peter as he will be using this new MT_TOOL.
> 
> thanks for the CC, would've missed this.
> 
> From what I read this would be a helper for internal changes only, not
> exposed to userspace? If so maybe it's better/easier/more readable to break
> it into two functions
>   input_mt_open_slot(dev, MT_TOOL_FINGER)
>   input_mt_close_slot(dev)
>   
> This removes any ambiguity about the handling of the tool and should be a
> fairly trivial search/replace. Replace the 'open/close' terminology with
> whatever suits better.

Hmm, I do like the "input_mt_close_slot()", or
"input_mt_report_slot_inactive()". I think the
input_mt_report_slot_state() is fine for "opening" the slot, as, with it
now returning bool, we can do:

	if (input_mt_report_slot_state(dev, MT_TOOL_FINGER, state)) {
		...
		< report events for active slot >
	}


Thanks.

-- 
Dmitry
