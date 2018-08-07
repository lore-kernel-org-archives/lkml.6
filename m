Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE08C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5EE9217B9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQtwB26y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5EE9217B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389921AbeHGRhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:37:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40311 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388677AbeHGRhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:37:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id x5-v6so8004883pgp.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 08:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=omh/FBGfKcI3MCpCt8OQ+G9I+ExbAszO/V2A0FzoeCY=;
        b=kQtwB26yBVUuj1rbR2prhskg4ClKzPA03pAPvvruZAt33raeVrED+PL8QEbOOdVU0H
         TukRykzFpXA0MPzAOAZU7bSpusAaes7KCJ/RBKQmLLl8EtmVCn4ZyKbTXepNRA1Yfdy+
         1wtsGKfnm3rk+KhY68xILQwqz6mDhtgE+J+288aBW/x5pTJD69BxzKNCwlMskoOSRAtV
         Uptj3fPEWuliAChxGFB22a+x3ZIxIEq54yHR7lVkX/cv9wDno0vxIVlEdTPkv7feN6iD
         yn4JZSALOFIwUxlDZG3Y6BaT8OJKg46Wp3gUaeTKay0sZHoVVt3OGSVvw1nFeOIbslqV
         F6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=omh/FBGfKcI3MCpCt8OQ+G9I+ExbAszO/V2A0FzoeCY=;
        b=Mzo19Svco78nztR3bmoXgkX4TrY1fy7wDop5NBhaMVu7sVPPl181MsC2P7H5CqkUue
         gJbdCuYd/oQnM/fmjJrWLlBMdwVhPkXa0xn6piuORdt6bgdYpubHXqEM55f4g39f02jV
         gzUHv2jY9jKHCFcUgAer09XzHfHK+jscn8wDVyQZzd4SpE8HbMNFJk9qLWtLMLeAtyu0
         R72YULTNvSueUcBAnDi+I8UGoEY18PgKGf5GHYx64uJKnPtdhUZU70bmBt/57vngrGTC
         sD+E5GwXj7epBzPUkU+XjWZb10ge0rLNVC89pmrmJHmDQNDQwtyJ7FgMX9FVpJiXAC/b
         9EwA==
X-Gm-Message-State: AOUpUlGObfQ73J8Xhihp/bcSEsF2qSDWSCjDVfRcLoFZOxgx/KPo8hYL
        BJfdVlQgt4Rv1c2+Al5C0tU=
X-Google-Smtp-Source: AAOMgpciLX+YrN2w8XHleE0c2HohlfqeffKvgZbTy4o23GCUWagc2FnSFICYHFCX4XjHATIKDgY5kg==
X-Received: by 2002:a62:b0c:: with SMTP id t12-v6mr22310769pfi.36.1533655332294;
        Tue, 07 Aug 2018 08:22:12 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:e25])
        by smtp.gmail.com with ESMTPSA id s16-v6sm93491pfd.0.2018.08.07.08.22.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 08:22:11 -0700 (PDT)
Date:   Tue, 7 Aug 2018 08:22:08 -0700
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Christopher Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, kernel-team@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: add percpu populated pages count to meminfo
Message-ID: <20180807152207.GC59704@dennisz-mbp.dhcp.thefacebook.com>
References: <20180807005607.53950-1-dennisszhou@gmail.com>
 <0100016514bb069d-a6532c9a-b1ca-4eba-8644-c5b3935e3bd8-000000@email.amazonses.com>
 <20180807151146.GB3978217@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807151146.GB3978217@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Tue, Aug 07, 2018 at 08:11:46AM -0700, Tejun Heo wrote:
> Hello,
> 
> On Tue, Aug 07, 2018 at 02:12:06PM +0000, Christopher Lameter wrote:
> > > @@ -121,6 +122,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
> > >  		   (unsigned long)VMALLOC_TOTAL >> 10);
> > >  	show_val_kb(m, "VmallocUsed:    ", 0ul);
> > >  	show_val_kb(m, "VmallocChunk:   ", 0ul);
> > > +	show_val_kb(m, "PercpuPopulated:", pcpu_nr_populated_pages());
> > 
> > Populated? Can we avoid this for simplicities sake: "Percpu"?
> > 
> > We do not count pages that are not present elsewhere either and those
> > counters do not have "populated" in them.
> 
> Yeah, let's do "Percpu".
> 

Sounds good, I've dropped populated.

Thanks,
Dennis
