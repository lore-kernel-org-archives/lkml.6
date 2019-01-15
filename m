Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6AEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C563B20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547543311;
	bh=AgXHlCM0lbg+fMSJ0249CdxVOK5qK8/Gq+rwNdjOXMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UP6HKqz4hSZeWSzxBaKph0DqNE25mRmrbWUmxkkrLn3sMX2Ls4svplrE7Fbn6ozT2
	 oFsH/KXuJ7TFVS5sutdIGI8dASUyh75A9XJz7x1AfKHGYEOfxcTexN/flVq59N39U1
	 NEjf3dl+HFD2ORt/qxaaPOaOhpxcEN0M0+SKDlDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfAOJI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 04:08:29 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:46986 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfAOJI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 04:08:29 -0500
Received: by mail-lj1-f179.google.com with SMTP id v15-v6so1598973ljh.13;
        Tue, 15 Jan 2019 01:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7NGEeFeMbGv5BQe5JxR3JAQyyhR6mBlZxk0SpiIYNU8=;
        b=gYmLKiStvftGZYLgwChWErSdpw83YISbC/7YpvPhLMz5H24Rd8WJq7vCraT9V1PuHj
         EHrp0KVNKhsiki4gmDjRtAquDEQnvV9ofoUhyf+32pL2/picmT4Pk5GtsaNEbjP1Hy/i
         bS8Yku+Ee+oYrlstUFON4iEqRTcUVn1bhhhvQx4dBl5sPR9Y5VVX7x8wXTJAeO/LLmJ3
         +47apHSSLL4OiDs8jDUmQSP72vwjLi8HFW+MWjJUrEzdnlZRYDSvo9v8tL7sgXf61wh2
         WdcM+UBx20emdlif5IlWz5Y2C4s1n5ygit9udq8bQ+zTbfbz8v2+gKWd+cI1qPjldHf4
         K8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7NGEeFeMbGv5BQe5JxR3JAQyyhR6mBlZxk0SpiIYNU8=;
        b=bT7tSBdYJq0aqVomAEtpHTiJYaojttAnxJvirtKwcKaTLJ52izEEGP55AuqLrumVeI
         hHeAgonMcdXT9AFz+dWB5T77GKQ0XiCGxdtPytMz+Eq5mRmP+MDn0eIoPl7NNyJqohGd
         BoHD/F2QZAyKmqPdzuOqU9Gcw8YnJgMhB9CMCKgu2BDybXWIEWVcd8lmPVgDcJmlhe87
         5HbmxZTChfDLsm++ocP41zLStL8OvUyl08axG00ge8lgRkXE2+cWggL3gVFxF9MGVaR/
         eDGSj5AJXBTHBH5VkRfu/s1Z7NEkuMHNon7mqJc/9zir/kS/Rg9omvZOE1tjq+G9+9Ob
         UOZQ==
X-Gm-Message-State: AJcUukco8EklF34xfZdATi8/ONG85/OzzfMbY4P657+TmF3PuM9H4RRG
        eXiDaNV+O9RxNUT/heaO5QM=
X-Google-Smtp-Source: ALg8bN6Q3lTk3Mgp8fX1ouRXkcj1EXwsS9fkL9oirV51mp2x2V+QMq0oqM1EnAr/TNoiUw2aQBQwTw==
X-Received: by 2002:a2e:841:: with SMTP id g1-v6mr2124557ljd.21.1547543307010;
        Tue, 15 Jan 2019 01:08:27 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id q67sm525956lfe.19.2019.01.15.01.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 01:08:26 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gjKht-0008S7-Th; Tue, 15 Jan 2019 10:08:25 +0100
Date:   Tue, 15 Jan 2019 10:08:25 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Johan Hovold <johan@kernel.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH v2 2/5] gnss: sirf: power on logic for devices without
 wakeup signal
Message-ID: <20190115090825.GM3691@localhost>
References: <20181209195150.5192-1-andreas@kemnade.info>
 <20181209195150.5192-3-andreas@kemnade.info>
 <20190110121038.GA9725@localhost>
 <20190110230223.18ecbd87@kemnade.info>
 <20190114105129.GE3691@localhost>
 <20190114225802.4dcd8cd2@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114225802.4dcd8cd2@aktux>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 10:58:02PM +0100, Andreas Kemnade wrote:
> On Mon, 14 Jan 2019 11:51:29 +0100
> Johan Hovold <johan@kernel.org> wrote:
> 
> here is a second part of a reply.

I'm not sure I received the first part if you're saying you replied to
my mail in two parts?

> [...]
> > > > In pseudo code we have:
> > > > 
> > > >   activate:
> > > >    - toggle on-off
> > > >    - wait(data-received, ACTIVATE_TIMEOUT + REPORT_CYCLE)
> > > >      - reception: success   
> > > 
> > > Note: we can also get the goodbye/shutdown message from the chip here
> > > so there are chances of a false success, but since we initially power down,
> > > we will rule out wrong state here.  
> > 
> > Good point. Unless we know the current state, we'd need to sleep for
> > HIBERNATE_TIMEOUT before waiting for data reception.
> 
> And probably this also magically (together with my
> runtime_get/put()-pair) in _probe()) worked around the
> problems fixed by the.
> gnss: sirf: fix activation retry handling

The retry-handling fix would only avoid a successful last retry attempt
incorrectly being reported as a failure, so I don't think that would
change much here.

> Well, with the last patchset and short report cycle we can detect state
> changes to off state reliably but state changes to on state
> only unreliably (which was, as said, not the intention). If the GPS chip
> behaves well enough, we will not see trouble.
> 
> Now with long report cycles: Off state detection will always return
> success. On state detection (in its current wonky form) will see the
> state change messages and will also always return success. If initial
> state is correct, this works at least in a wonky way.
> 
> I do not like these wonky things too much. So I would rather see
> well-defined behavior with well-known limitations.
> 
> State change failures are probably not only a theoretical thing,
> so it is a good idea to track that.

Good, sounds like we're on the same page then.

Thanks,
Johan
