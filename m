Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966334AbeBMXzQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:55:16 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:51685 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966108AbeBMXzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:55:13 -0500
X-Google-Smtp-Source: AH8x225Jvb/kWSrRMNRFXCKFskqDN/YQQ38wRb/dwWfckjK9d/1GyAO2uMotJR9DPdLOsIt7Vr6D9g==
Date: Tue, 13 Feb 2018 15:55:11 -0800 (PST)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Andrew Morton <akpm@linux-foundation.org>
cc: Jonathan Corbet <corbet@lwn.net>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [patch 1/2] mm, page_alloc: extend kernelcore and movablecore
 for percent
In-Reply-To: <20180213154607.f631e2e033f42c32925e3d2d@linux-foundation.org>
Message-ID: <alpine.DEB.2.10.1802131550210.130394@chino.kir.corp.google.com>
References: <alpine.DEB.2.10.1802121622470.179479@chino.kir.corp.google.com> <20180213154607.f631e2e033f42c32925e3d2d@linux-foundation.org>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2018, Andrew Morton wrote:

> > Both kernelcore= and movablecore= can be used to define the amount of
> > ZONE_NORMAL and ZONE_MOVABLE on a system, respectively.  This requires
> > the system memory capacity to be known when specifying the command line,
> > however.
> > 
> > This introduces the ability to define both kernelcore= and movablecore=
> > as a percentage of total system memory.  This is convenient for systems
> > software that wants to define the amount of ZONE_MOVABLE, for example, as
> > a proportion of a system's memory rather than a hardcoded byte value.
> > 
> > To define the percentage, the final character of the parameter should be
> > a '%'.
> 
> Is this fine-grained enough?  We've had percentage-based tunables in
> the past, and 10 years later when systems are vastly larger, 1% is too
> much.
> 

They still have the (current) ability to define the exact amount of bytes 
down to page sized granularity, whereas 1% would yield 40GB on a 4TB 
system.  I'm not sure that people will want any finer-grained control if 
defining the proportion of the system for kernelcore.  They do have the 
ability with the existing interface, though, if they want to be that 
precise.

(This is a cop out for not implementing some fractional percentage parser, 
 although that would be possible as a more complete solution.)
