Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F8FC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3913420818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="imw6XcwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbfBERTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:19:15 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:47057 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfBERTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 12:19:14 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so3479930edt.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 09:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JiQLyKT0XNTyJgTTkPH+vqqz1Yeo0A+MtrDLMF+d1wc=;
        b=imw6XcwTeS4ypbo1uIC+KSkhafNKK1VeIc+654DSLCd+FhKQq91KmMgRnKc9tasU18
         ra9O9Vj4yYPA5sFzWSSuAcm6rGCdcaD06i/Gc1a92OBa9dUFT4InsK1GbEVCIlntcDiL
         oe4sU3JdvWwGOPWL4o/7MzJ6udItn/7gb78xtwI+QujfaO06HXzFRAeZmPNdBp97HVdT
         ahHItGo/y9HdyZpKmNphC68cAKB8S/n3T/oCorMT8Bb2znDr8YVYeXwB5S0QhJKXfFlI
         kn5uKH933DLOequj6hq4nNGUBhUeogaEuPz/4ahq+A/ae6qZRgeUMboWURTWqSP6QnUJ
         E0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JiQLyKT0XNTyJgTTkPH+vqqz1Yeo0A+MtrDLMF+d1wc=;
        b=aGs5sO3ZxDI4Y4couzbVPaQoSX6HtY/ONUI1D2CPl8yuMdSqVGOry7upB3DYrwg2a5
         tw5EO+Tauizdf9T1wqAUOcOJBVSVaNf3hWcyEGGMySnPo05n03/knN1OZarLGzXHjZ4B
         nCyVVuFMq4t8sauelTobcZRunFo3UDl6xcUQkEzWGC78reWwlNeCD2cRL53dXDbXbVH/
         bnDpWJm1NhwHS2dO4gRZ1ZjcaMBXPWRl9oXqM91onRQAkc9tp/YZL7ijxCrC4BX0Lt/Q
         bmvC4hCir3m5K6nT9Vp6mVA+LCS7tQFN1yRLjjvqEo9BdDf7EIDmeqtCVU+Dg9WLjl5D
         BCtw==
X-Gm-Message-State: AHQUAuaJuVBd8FLY4vz/htRxA7G7kk4mZDP0yKLxNygo5YTi2bxMzThT
        FZXWgTZcGmzjfW8xm27lThGlG4r/u032Cyj8D/6mEvbyHfdU9A==
X-Google-Smtp-Source: AHgI3IYtdwQs3YT1jGZ6mhVL/6H3rJ6oqlywiBzt3cOdC+dzoveP6U/BJ3p3I/Lq4uGQIW0SCvrGmsLkEgCJkt59LKU=
X-Received: by 2002:a50:b2e1:: with SMTP id p88mr4735288edd.254.1549387152681;
 Tue, 05 Feb 2019 09:19:12 -0800 (PST)
MIME-Version: 1.0
References: <20190104004203.116155-1-jsperbeck@google.com> <20190103214927.2bf947ca@vmware.local.home>
 <20190205121353.GC1045@kunai>
In-Reply-To: <20190205121353.GC1045@kunai>
From:   John Sperbeck <jsperbeck@google.com>
Date:   Tue, 5 Feb 2019 09:19:01 -0800
Message-ID: <CAFNjLiU_KOmcBHykHt5JTr439DJVf=j=aGKpnObZfMx6nLreRQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: core-smbus: don't trace smbus_reply data on errors
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 4:14 AM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Thu, Jan 03, 2019 at 09:49:27PM -0500, Steven Rostedt wrote:
> > On Thu,  3 Jan 2019 16:42:03 -0800
> > John Sperbeck <jsperbeck@google.com> wrote:
> >
> > > If an smbus transfer fails, there's no guarantee that the output
> > > buffer was written.  So, avoid copying from the output buffer when
> > > tracing after an error.  This was 'mostly harmless', but would trip
> > > up kasan checking if left-over cruft in byte 0 is a large length,
> > > causing us to read from unwritten memory.
> > >
> > > Signed-off-by: John Sperbeck <jsperbeck@google.com>
> > > ---
> > >  drivers/i2c/i2c-core-smbus.c |  2 +-
> > >  include/trace/events/smbus.h | 10 +++++-----
> > >  2 files changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
> > > index 9cd66cabb84f..132119112596 100644
> > > --- a/drivers/i2c/i2c-core-smbus.c
> > > +++ b/drivers/i2c/i2c-core-smbus.c
> > > @@ -585,7 +585,7 @@ s32 __i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
> > >  trace:
> > >     /* If enabled, the reply tracepoint is conditional on read_write. */
> > >     trace_smbus_reply(adapter, addr, flags, read_write,
> > > -                     command, protocol, data);
> > > +                     command, protocol, data, res);
> > >     trace_smbus_result(adapter, addr, flags, read_write,
> > >                        command, protocol, res);
> > >
> > > diff --git a/include/trace/events/smbus.h b/include/trace/events/smbus.h
> > > index d2fb6e1d3e10..b6376a7c7e74 100644
> > > --- a/include/trace/events/smbus.h
> > > +++ b/include/trace/events/smbus.h
> > > @@ -138,8 +138,8 @@ TRACE_EVENT_CONDITION(smbus_reply,
> > >     TP_PROTO(const struct i2c_adapter *adap,
> > >              u16 addr, unsigned short flags,
> > >              char read_write, u8 command, int protocol,
> > > -            const union i2c_smbus_data *data),
> > > -   TP_ARGS(adap, addr, flags, read_write, command, protocol, data),
> > > +            const union i2c_smbus_data *data, int res),
> > > +   TP_ARGS(adap, addr, flags, read_write, command, protocol, data, res),
> > >     TP_CONDITION(read_write == I2C_SMBUS_READ),
> >
> > Hmm, instead of tracing nothing, as this is already a "conditional
> > trace event", why not add to that condition:
> >
> >       TP_CONDITION(res >= 0 && read_write == I2C_SMBUS_READ),
> >
> > Unless you want to still trace some data on failure.
>
> John, any comment to this?
>

The issue we were dealing with was access to uninitialized memory on the stack.
The change '30f939feaeee i2c: fix kernel memory disclosure in dev interface'
does the initialization, so the tracing code is no longer affected.
We just didn't
have that change in the particular kernel we were testing.

Still, Steven's suggestion seems fine to me.  Would you like me to create a new
patch based on that?
