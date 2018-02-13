Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966153AbeBMXqL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:46:11 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36584 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966064AbeBMXqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:46:09 -0500
Date: Tue, 13 Feb 2018 15:46:07 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: David Rientjes <rientjes@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [patch 1/2] mm, page_alloc: extend kernelcore and movablecore
 for percent
Message-Id: <20180213154607.f631e2e033f42c32925e3d2d@linux-foundation.org>
In-Reply-To: <alpine.DEB.2.10.1802121622470.179479@chino.kir.corp.google.com>
References: <alpine.DEB.2.10.1802121622470.179479@chino.kir.corp.google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2018 16:24:25 -0800 (PST) David Rientjes <rientjes@google.com> wrote:

> Both kernelcore= and movablecore= can be used to define the amount of
> ZONE_NORMAL and ZONE_MOVABLE on a system, respectively.  This requires
> the system memory capacity to be known when specifying the command line,
> however.
> 
> This introduces the ability to define both kernelcore= and movablecore=
> as a percentage of total system memory.  This is convenient for systems
> software that wants to define the amount of ZONE_MOVABLE, for example, as
> a proportion of a system's memory rather than a hardcoded byte value.
> 
> To define the percentage, the final character of the parameter should be
> a '%'.

Is this fine-grained enough?  We've had percentage-based tunables in
the past, and 10 years later when systems are vastly larger, 1% is too
much.
