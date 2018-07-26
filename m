Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594FDC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C96820673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C96820673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731463AbeGZUeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:34:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35637 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbeGZUeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:34:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id a3-v6so2766379wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mn/+Vyx7rJ06mFiA+mriZ9jGeRRGrqi+Rxfo2aa3eQk=;
        b=jsa3KrQ5MBC/TXar2QK/Vv8dxvOxAy6QbgzMuZ0C4zgE5wu/8S+lX8kv78MDsuQBTB
         TNOeGr5GO7meaS5R9+Y0K7fM322noOWat9PQsDEHdS7aKX9xOnZakm7nPtDdfXKYr93K
         e6fs4OZyqsWdLRfDeEWx4lZDqKmjIhySKEzJPoEx+3holHA2zUcXZoy458gLVM4sp8Nn
         EXswM+DVtchOzKejD9EMdqEbQfclttBUeKfwdwMl2c2DShjr2e5WBlIvSNYZ9gIPuItV
         gAZ8bAVPJfNa7ANFaGEa6Its5LWpANl5ERukYkBxcW8Nj6vh9fKEBlYkTk/8aMX9zMPG
         qFzA==
X-Gm-Message-State: AOUpUlEJlC1HeCeyz2Lsj0iclxsdM6IMXWNDympw371qyGcjQyVQB1hA
        ZUY5B+Yi1LwGI8YtRIFfwJs=
X-Google-Smtp-Source: AAOMgpcSuS+Xl2QgpeBkwuUOA9pts8U4TuFx1MYwnZLL3yce9aIbwkjx1YAn32Dg1mkQVVcb9Rcomg==
X-Received: by 2002:adf:b69c:: with SMTP id j28-v6mr2606232wre.200.1532632557745;
        Thu, 26 Jul 2018 12:15:57 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id f17-v6sm2601959wrs.1.2018.07.26.12.15.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 12:15:57 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 741161243DC; Thu, 26 Jul 2018 21:15:56 +0200 (CEST)
Date:   Thu, 26 Jul 2018 21:15:56 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     mhocko@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, mgorman@techsingularity.net,
        aaron.lu@intel.com, iamjoonsoo.kim@lge.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, dan.j.williams@intel.com,
        osalvador@suse.de
Subject: Re: [PATCH v3 2/5] mm: access zone->node via zone_to_nid() and
 zone_set_nid()
Message-ID: <20180726191556.GB10288@techadventures.net>
References: <20180725220144.11531-1-osalvador@techadventures.net>
 <20180725220144.11531-3-osalvador@techadventures.net>
 <20180726080500.GX28386@dhcp22.suse.cz>
 <20180726081215.GC22028@techadventures.net>
 <20180726151420.uigttpoclcka6h4h@xakep.localdomain>
 <20180726164304.GP28386@dhcp22.suse.cz>
 <CAGM2reatUAekg=e9FQM1-UVLOSBKb74-FYo7FcPqO_WaR7AmOQ@mail.gmail.com>
 <20180726175212.GQ28386@dhcp22.suse.cz>
 <CAGM2reY2HAo3UDzw=P8ue0jJmRRZou-osyJwWjXt6vtC+CF8Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGM2reY2HAo3UDzw=P8ue0jJmRRZou-osyJwWjXt6vtC+CF8Ug@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 01:55:34PM -0400, Pavel Tatashin wrote:
> On Thu, Jul 26, 2018 at 1:52 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Thu 26-07-18 13:18:46, Pavel Tatashin wrote:
> > > > > OpenGrok was used to find places where zone->node is accessed. A public one
> > > > > is available here: http://src.illumos.org/source/
> > > >
> > > > I assume that tool uses some pattern matching or similar so steps to use
> > > > the tool to get your results would be more helpful. This is basically
> > > > the same thing as coccinelle generated patches.
> > >
> > > OpenGrok is very easy to use, it is source browser, similar to cscope
> > > except obviously you can't edit the browsed code. I could have used
> > > cscope just as well here.
> >
> > OK, then I misunderstood. I thought it was some kind of c aware grep
> > that found all the usage for you. If this is cscope like then it is not
> > worth mentioning in the changelog.
> 
> That's what I thought :) Oscar, will you remove the comment about
> opengrok, or should I paste a new patch?

No worries, I will remove the comment ;-).

Thanks
-- 
Oscar Salvador
SUSE L3
