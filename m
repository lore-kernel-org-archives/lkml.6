Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbeBVX4p (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 18:56:45 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751283AbeBVX4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 18:56:44 -0500
Date: Fri, 23 Feb 2018 07:56:39 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        linux-mm@kvack.org, kirill.shutemov@linux.intel.com, mhocko@suse.com,
        tglx@linutronix.de
Subject: Re: [PATCH v2 1/3] mm/sparse: Add a static variable
 nr_present_sections
Message-ID: <20180222235639.GD693@localhost.localdomain>
References: <20180222091130.32165-1-bhe@redhat.com>
 <20180222091130.32165-2-bhe@redhat.com>
 <20180222132441.51a8eae9e9656a82a2161070@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222132441.51a8eae9e9656a82a2161070@linux-foundation.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/18 at 01:24pm, Andrew Morton wrote:
> On Thu, 22 Feb 2018 17:11:28 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > It's used to record how many memory sections are marked as present
> > during system boot up, and will be used in the later patch.
> > 
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -202,6 +202,7 @@ static inline int next_present_section_nr(int section_nr)
> >  	      (section_nr <= __highest_present_section_nr));	\
> >  	     section_nr = next_present_section_nr(section_nr))
> >  
> > +static int nr_present_sections;
> 
> I think this could be __initdata.
> 
> A nice comment explaining why it exists would be nice.

Thanks, I will update as you suggested.
> 
