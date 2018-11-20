Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FC1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2E92080C
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="WrhL80MF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2E92080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732348AbeKTKuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:50:13 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35333 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbeKTKuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:50:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so90223pfi.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 16:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jz8w/y5AymykFyZHOdLl/ZI98IR5qxgSJZ3E6fnarpU=;
        b=WrhL80MF0Mqp9T7HnFKp24u76HqZuR6ODUcOQ2wMshim/FVmP/S+YzOfypF0Y3Ur/y
         FQNMi9jxnCj89KJm2qXMBV+MpMuyhiguL8Z6hyBC1lq/vFI5qM5ENr/OogEmfJBsXUpZ
         QF0FS1nE4Vp0F9jFNSuxxn15bmDmf9+1ZUvAcwE8oi2QRM9ihtRn2hRBsk5ub4LgzNYf
         lZjQCdE5w+eXPnebWRFvvP/kOcp8MSOY5zhQ6QYFw/IrWA9zcMEoGcjipJRKebNYsYGy
         mBdKWsU28/T5skMiXceTrhOKqUUodqQUi+IIR3ergjPrPwfH64MG0jnrQDSBuKHazW+a
         GCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jz8w/y5AymykFyZHOdLl/ZI98IR5qxgSJZ3E6fnarpU=;
        b=Iit4a9vbJze4HRI8ufIKsIAVvoJ+0BI6hnCWdBbbb+SH9K/c12AeaT6Lz33iSCwKjC
         HD4Y/r+53/6pXrum+VjIF8w+xB+teTiw7rab1faTDrtZD5Q3F4lND5MTvcQnWnmp2FoJ
         XaqvT/HH9M6CXEKk06uwQVVlRtmV0c+faLfT6kEbBG+cOrmcCvEtax1tq4RFW1PJgKff
         qR/1OFJRjbnQ+eXfJc5M8EhcNRiNzcLdtrE/n0woTiwYcCfLPqQT4gza+px5VmIa4gml
         BiPWdNd/I0a4qUReDEWSZTaKxTukNYoYXZvLK804XxJV2DEE3TWI4b5LL6JqH1nhVsdv
         IF6w==
X-Gm-Message-State: AGRZ1gI3P4YWh7jyL6aAasxi5a6ZplGquBPAaSJOEZB2ugfbEko6RA33
        FWKXs8xMyCRsFwGCLdc0qIfoyA==
X-Google-Smtp-Source: AJdET5f/pektNRoV3ICK9CTopSvToyfmfkZA4navhKR9eod6AwAY9YfbE7rPlPYAt///H+yd1OwepA==
X-Received: by 2002:a63:580a:: with SMTP id m10mr13423251pgb.332.1542673435791;
        Mon, 19 Nov 2018 16:23:55 -0800 (PST)
Received: from brauner.io ([130.195.55.139])
        by smtp.gmail.com with ESMTPSA id f22-v6sm51573587pff.29.2018.11.19.16.23.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 16:23:55 -0800 (PST)
Date:   Tue, 20 Nov 2018 01:23:49 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Todd Kjos <tkjos@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        akpm@linux-foundation.org, chouryzhou@tencent.com,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>, dave@stgolabs.net,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4] binder: ipc namespace support for android binder
Message-ID: <20181120002346.rp6i5ts2jkn54esz@brauner.io>
References: <5FBCBE569E134E4CA167B91C0A77FD610198F8FA41@EXMBX-SZMAIL022.tencent.com>
 <20181115143349.44e1942213b61a4818bcbf02@linux-foundation.org>
 <20181115225427.GA25874@kroah.com>
 <CAHRSSEw26XZMAgR=9HXVzBEDanwJABcJAYzYgA32HtaC0TR+7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHRSSEw26XZMAgR=9HXVzBEDanwJABcJAYzYgA32HtaC0TR+7A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 11:19:41AM -0800, Todd Kjos wrote:
> On Thu, Nov 15, 2018 at 2:54 PM gregkh@linuxfoundation.org
> <gregkh@linuxfoundation.org> wrote:
> ...
> >
> > A number of us have talked about this in the plumbers Android track, and
> > a different proposal for how to solve this has been made that should be
> > much more resiliant.  So I will drop this patch from my queue and wait
> > for the patches based on the discussions we had there.
> >
> > I think there's some notes/slides on the discussion online somewhere,
> > but it hasn't been published as the conference is still happening,
> > otherwise I would link to it here...
> 
> Here is a link to the session where you can look at the slides [1].
> There was consensus that "binderfs" (slide 5) was the most promising
> -- but would be behind a config option to provide backwards
> compatibility for non-container use-cases.
> 
> The etherpad notes are at [2] (look at "Dynamically Allocated Binder
> Devices" section)
> 
> Christian Brauner will be sending out more details.

Ok, sorry for the delay I got caught up in other work.

The idea is to implement binderfs which I'm starting to work on.
binderfs will be a separate pseudo-filesystem that will be mountable
per-ipc namespace.
This has the advantage that the ipc namespace is attached to the
superblock of the mount and can be easily retrieved by the binder
driver. It also implies that - in contrast to the proposed patch here -
an open() on a given binder device will not be able to change the ipc
namespace of said devices. The obvious corollary is that you can
bind-mount binder devices or the whole binderfs mount between different
ipc namespaces and given the right permissions (CAP_IPC_OWNER in the
owning userns of the ipcns) can see services on the host which is
something that people wanted to be able to do.
Additionally, each binderfs mount will come with a binder-control
device. This device is functionally similar to loop-control and will
allow for dynamic allocation (and possibly deallocation) of binder
devices. With this we can remove the restriction to hard-code the number
of binder devices at compile time.
Backwards compatibility can either be guaranteed by hiding binderfs
behind a compile flag or by special-casing the inital binderfs mount to
pre-create the standard binder devices. The jury is still out on this.

Christian

> 
> -Todd
> 
> [1] https://linuxplumbersconf.org/event/2/contributions/222/
> [2] https://etherpad.openstack.org/p/Android
> 
> >
> > thanks,
> >
> > greg k-h
