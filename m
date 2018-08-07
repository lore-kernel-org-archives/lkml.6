Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E844CC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CEB2151D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5/bLWxg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1CEB2151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389916AbeHGRgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:36:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42700 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387632AbeHGRgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:36:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so8738197pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 08:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AG4d9RCNRhFUim9zT37k9NhslmM06huXwGxSG9yK4Ko=;
        b=d5/bLWxgN0JjlDv3OgUQezQOYHzi0CbmCWZV1USY3AzBusQ+IfkP5EI9YSGx1hKXxw
         HZ8eD0W35UetUdmd2RlMcD3P+FppsbPuPiuvPcPt5eN9KzdMp1wHSPalfgyKgoXj/7ck
         CDarUNFFzIkU3WmG33D+CkAMtG1DwQ+dv0X3oQnv1WDmPrxGqtj8Z8uU5jrM3ZV5cUPa
         thn6ED2ga0+d5qTNpXBGD1lcyRVlKD7kFOEnlrNLbzqOdQEUzwb2Yj+Lf2iUeor7FE3a
         n25ieGMV9ncXUh99EswGY+WHe2akOH5avR+mTuUCfvC9RgQ4w0frWEy66cw39qmpMo8+
         qVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AG4d9RCNRhFUim9zT37k9NhslmM06huXwGxSG9yK4Ko=;
        b=dPXZ+rfs2IacdJw9dcax3nilOuuk2/zdl4U5vyGnyvyayjTzVbcK7WZdwoLecHh43I
         D8YGZiNjBznYwK81uxoMp8lRLh29uO5Kheqes610cHmAUFMCrPn3C/wYeoiVfQ6cxR1M
         C8bs3urmR/dtDiHqHmGWVKGjasZfNCgS38Ulhk3mVbKtF4fsgAUkBYro1ku2/+ASg08n
         a22BfeqogpJ0iIH1xBVXKMAPKDuvydVMPzvKWGfgrnmRWSxf8NSJzHhLmVNNo8QOzLQL
         y9qfz2f6c7AK9uuRWU94n+xOQ8TKhmLnGJxSsesI1MH7RguHj6Pb+dSBvfiWAajedcPI
         fHqA==
X-Gm-Message-State: AOUpUlFmwwlpmZjxB2E6eGtx0FRXhaIn4tsESMin/rgK9s0drlC3JTa6
        8N84d6zCxOLNPKoeBsBFz5k=
X-Google-Smtp-Source: AAOMgpck38o0X1NLQpN2s28NFzByyItIaxeIhkOh/NHPmHC/7sel9mSdO4pXPqBqN8G0kIVtwnZSMQ==
X-Received: by 2002:a63:e206:: with SMTP id q6-v6mr19113896pgh.223.1533655273080;
        Tue, 07 Aug 2018 08:21:13 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:e25])
        by smtp.gmail.com with ESMTPSA id s14-v6sm5443688pfj.105.2018.08.07.08.21.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 08:21:12 -0700 (PDT)
Date:   Tue, 7 Aug 2018 08:21:09 -0700
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Christopher Lameter <cl@linux.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, kernel-team@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: add percpu populated pages count to meminfo
Message-ID: <20180807152107.GB59704@dennisz-mbp.dhcp.thefacebook.com>
References: <20180807005607.53950-1-dennisszhou@gmail.com>
 <0100016514bb069d-a6532c9a-b1ca-4eba-8644-c5b3935e3bd8-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0100016514bb069d-a6532c9a-b1ca-4eba-8644-c5b3935e3bd8-000000@email.amazonses.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christopher,

On Tue, Aug 07, 2018 at 02:12:06PM +0000, Christopher Lameter wrote:
> On Mon, 6 Aug 2018, Dennis Zhou wrote:
> >  	show_val_kb(m, "VmallocUsed:    ", 0ul);
> >  	show_val_kb(m, "VmallocChunk:   ", 0ul);
> > +	show_val_kb(m, "PercpuPopulated:", pcpu_nr_populated_pages());
> 
> Populated? Can we avoid this for simplicities sake: "Percpu"?

Yeah, I've dropped populated.

> 
> We do not count pages that are not present elsewhere either and those
> counters do not have "populated" in them.

I see, that makes sense. I think I was trying to keep an external
distinction between what we reserve and what we actually have populated
that really isn't useful outside of playing with the allocator itself.

> >  int pcpu_nr_empty_pop_pages;
> >
> > +/*
> > + * The number of populated pages in use by the allocator, protected by
> > + * pcpu_lock.  This number is kept per a unit per chunk (i.e. when a page gets
> > + * allocated/deallocated, it is allocated/deallocated in all units of a chunk
> > + * and increments/decrements this count by 1).
> > + */
> > +static int pcpu_nr_populated;
> 
> pcpu_nr_pages?
> 

I'd rather keep it as pcpu_nr_populated because internally in pcpu_chunk
we maintain nr_pages and nr_populated. That way we keep the same meaning
at the chunk and global level.

Thanks,
Dennis
