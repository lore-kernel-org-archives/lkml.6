Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932080AbeFFB0a (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 21:26:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35392 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752063AbeFFB03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 21:26:29 -0400
Date: Wed, 6 Jun 2018 09:26:24 +0800
From: Baoquan He <bhe@redhat.com>
To: Christopher Lameter <cl@linux.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org
Subject: Re: [PATCH] slab: Clean up the code comment in slab kmem_cache struct
Message-ID: <20180606012624.GA19425@MiWiFi-R3L-srv>
References: <20180603032402.27526-1-bhe@redhat.com>
 <01000163d0e8083c-096b06d6-7202-4ce2-b41c-0f33784afcda-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01000163d0e8083c-096b06d6-7202-4ce2-b41c-0f33784afcda-000000@email.amazonses.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/18 at 05:04pm, Christopher Lameter wrote:
> On Sun, 3 Jun 2018, Baoquan He wrote:
> 
> > diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
> > index d9228e4d0320..3485c58cfd1c 100644
> > --- a/include/linux/slab_def.h
> > +++ b/include/linux/slab_def.h
> > @@ -67,9 +67,10 @@ struct kmem_cache {
> >
> >  	/*
> >  	 * If debugging is enabled, then the allocator can add additional
> > -	 * fields and/or padding to every object. size contains the total
> > -	 * object size including these internal fields, the following two
> > -	 * variables contain the offset to the user object and its size.
> > +	 * fields and/or padding to every object. 'size' contains the total
> > +	 * object size including these internal fields, while 'obj_offset'
> > +	 * and 'object_size' contain the offset to the user object and its
> > +	 * size.
> >  	 */
> >  	int obj_offset;
> >  #endif /* CONFIG_DEBUG_SLAB */
> >
> 
> Wish we had some more consistent naming. object_size and obj_offset??? And
> the fields better be as close together as possible.

I am back porting Thomas's sl[a|u]b freelist randomization feature to
our distros, need go through slab code for better understanding. From
git log history, they were 'obj_offset' and 'obj_size'. Later on
'obj_size' was renamed to 'object_size' in commit 3b0efdfa1e("mm, sl[aou]b:
Extract common fields from struct kmem_cache") which is from your patch.
With my understanding, I guess you changed that on purpose because
object_size is size of each object, obj_offset is for the whole cache,
representing the offset the real object starts to be stored. And putting
them separately is for better desribing them in code comment and
distinction, e.g 'object_size' is in "4) cache creation/removal",
while 'obj_offset' is put alone to indicate it's for the whole.
