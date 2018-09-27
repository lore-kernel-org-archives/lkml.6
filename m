Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E3BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299FB216FC
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ruojRbp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299FB216FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbeI0Vy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:54:26 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:33535 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbeI0Vy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:54:26 -0400
Received: by mail-oi1-f177.google.com with SMTP id a203-v6so2569785oib.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 08:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r1yGJJ1zedUYfjZriVKRFmAShYtx9EV414lZcJCbW9U=;
        b=ruojRbp6cMXU19ISfR4ilI7TFaabnAY0P/kIvkWFbvk9kzlVZlVjM74DnJtjzuUyRX
         prQu+pl2OPqb56WUJLde5hvBqx1g35BLgEyqvtu0P4T9cTWs7s9sWmXFXFS8tbX4baW7
         XDXNvecBN5nDuQGxqT/eT2fttQjL0Ud//5B9klD6KqhZQO/Ga/ukXHt8VqTdd2JmR7eU
         ZxcgPCy64HD3k2xVZXgvZkBbcMNuj4dnohBuSfdXYuj4emOxs+rYHFt/HzJaFT56QLpp
         Acyomzpc+bfl5ivTMIcJkqsud9G2iPPcu/hMyEz2IKl73as2RkyTBBAUU9gdGCl4yVPJ
         uT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r1yGJJ1zedUYfjZriVKRFmAShYtx9EV414lZcJCbW9U=;
        b=pkK/Dli14aIUus2pSG3GAuUu/ZDLQtMuZcuYNdRiXgQSqkGWATcyry7vV+aipfaVl8
         684yfh++4KtyLR5sLTOZFcC+eIABfwSd0qWUowsn7OShLQ8IJ9FXGcqw6GBMUaLLLmeH
         NOrKWwKPypVg5OgtwJ5Tbl9Be+wsiuVMLmWYArKiEhQeW0rPmEe97H+uD5FOGoExZ/mD
         uLFHyMERJZQMIw6tatYLt9g4N3ivRuXkrn/H21TZ7QboqiT1L4uDUu8hyQBH52rcLbSR
         lsvNsLxxP5hIXiCQ2KfxYsDYYnzXS24jp34HbiVXskDQXUQI67EJr5oKVfYFzaW9K4pv
         cc8A==
X-Gm-Message-State: ABuFfogrx5NC50bsfll2PAppKhf4e61LPWzY0KYA5KIfajHmMZMf1qhB
        WKuys2doquoZTEI5V9TT4lfKTuNm4BI1cmcXVBokNA==
X-Google-Smtp-Source: ACcGV61gJdhBXnoIwTQ8WldVwpvHuXUvb8WInnu6RfHkbuAosKUPufYfh3EWNX2aKKPR4/33hfXMN8Ijh3PCMFtjbl0=
X-Received: by 2002:aca:aa4f:: with SMTP id t76-v6mr3614246oie.253.1538062537116;
 Thu, 27 Sep 2018 08:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180919070737.GB17524@uranus.lan> <20180919071056.GC17524@uranus.lan>
 <CAG48ez0d0mO3yN10ApgJuwt9DTDj6x+j_wtjz6qM35nGtxnUdw@mail.gmail.com> <20180919161301.GF17524@uranus.lan>
In-Reply-To: <20180919161301.GF17524@uranus.lan>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 27 Sep 2018 17:35:10 +0200
Message-ID: <CAG48ez0bKkv1rM-NDMNJMVO94_T92VAe_ABbGud1aOh_7UxaOg@mail.gmail.com>
Subject: Re: [linux-next] BUG triggered in ptraceme
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, avagin@virtuozzo.com,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 6:13 PM Cyrill Gorcunov <gorcunov@gmail.com> wrote:
>
> On Wed, Sep 19, 2018 at 04:16:50PM +0200, Jann Horn wrote:
> ...
> > >
> > > Heh, actually not :) It is due to commit
> > >
> > > commit 1f8266ff58840d698a1e96d2274189de1bdf7969
> > > Author: Jann Horn <jannh@google.com>
> > > Date:   Thu Sep 13 18:12:09 2018 +0200
> > >
> > > which introduced might_sleep. Seems it is bad idea to send bug report
> > > without having a cup of coffee at the morning :)
> >
> > Yeah, I fixed one sleep-in-atomic bug and figured I'd throw a
> > might_sleep() in there for good measure... sigh.
> > I guess now I have to go through all the callers of
> > begin_current_label_crit_section() to see what else looks wrong...
> >
>
> Yes, I fear so. Need to check every caller just to be sure.
>
> > apparmor_ptrace_traceme() is wrong, as reported...
> >
> > apparmor_path_link() looks icky, but I'm not sure - from what I can
> > tell, it's called with an i_rwsem held for writing, and that probably
> > makes calling back into filesystem context from there a bad idea?
> > OTOH, it's just the i_rwsem of a newly-created path, so I don't know
> > whether that's actually an issue...
> >
> > security_path_rename() is called with two i_rwsem's held, but again,
> > I'm not sure whether that's a problem.
>
> Lets wait for fs people opinions.

No reply yet - I guess I should just fix up the traceme case for now.
