Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966399AbeBNBOf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 20:14:35 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36088 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966225AbeBNBOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 20:14:34 -0500
Date: Tue, 13 Feb 2018 17:14:32 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: David Rientjes <rientjes@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [patch 1/2] mm, page_alloc: extend kernelcore and movablecore
 for percent
Message-Id: <20180213171432.13c496c6603255bff66ce826@linux-foundation.org>
In-Reply-To: <alpine.DEB.2.10.1802131550210.130394@chino.kir.corp.google.com>
References: <alpine.DEB.2.10.1802121622470.179479@chino.kir.corp.google.com>
        <20180213154607.f631e2e033f42c32925e3d2d@linux-foundation.org>
        <alpine.DEB.2.10.1802131550210.130394@chino.kir.corp.google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2018 15:55:11 -0800 (PST) David Rientjes <rientjes@google.com> wrote:

> > 
> > Is this fine-grained enough?  We've had percentage-based tunables in
> > the past, and 10 years later when systems are vastly larger, 1% is too
> > much.
> > 
> 
> They still have the (current) ability to define the exact amount of bytes 
> down to page sized granularity, whereas 1% would yield 40GB on a 4TB 
> system.  I'm not sure that people will want any finer-grained control if 
> defining the proportion of the system for kernelcore.  They do have the 
> ability with the existing interface, though, if they want to be that 
> precise.
> 
> (This is a cop out for not implementing some fractional percentage parser, 
>  although that would be possible as a more complete solution.)

And the interface which you've proposed can be seamlessly extended to
accept 0.07%, so not a problem.
