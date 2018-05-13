Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeEMI4g (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 04:56:36 -0400
Received: from smtprelay0241.hostedemail.com ([216.40.44.241]:35553 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750910AbeEMI4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 04:56:35 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3871:3872:3874:4321:4605:4823:5007:6119:7514:7903:10004:10400:10848:11026:11232:11658:11914:12296:12740:12760:12895:13069:13161:13229:13311:13357:13439:14096:14097:14181:14659:14721:21080:21627:30029:30054:30060:30070:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: angle35_734a9a0c3d714
X-Filterd-Recvd-Size: 2803
Message-ID: <c681ac6df41e37c51fd87ad2b0f7e2f08f6a8f3e.camel@perches.com>
Subject: Re: [PATCH v3] mm: Change return type to vm_fault_t
From: Joe Perches <joe@perches.com>
To: Dan Williams <dan.j.williams@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Sun, 13 May 2018 01:56:30 -0700
In-Reply-To: <CAPcyv4gYp4_9h1hsQOiHeEUX3TBZCsFWZkzrdcCi+YZ2QOKhxw@mail.gmail.com>
References: <20180512061712.GA26660@jordon-HP-15-Notebook-PC>
         <e194731158f7f89145ed0ae28f46aac5726fc32d.camel@perches.com>
         <20180512142451.GB24215@bombadil.infradead.org>
         <CAFqt6zb9KzPw0ih3fOs6DNd3RCcy9GYmxZ607_w7obn0Kym7Kw@mail.gmail.com>
         <CAPcyv4gYp4_9h1hsQOiHeEUX3TBZCsFWZkzrdcCi+YZ2QOKhxw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-05-12 at 19:51 -0700, Dan Williams wrote:
> On Sat, May 12, 2018 at 12:14 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > > > It'd be nicer to realign the 2nd and 3rd arguments
> > > > on the subsequent lines.
> > > > 
> > > >       vm_fault_t (*fault)(const struct vm_special_mapping *sm,
> > > >                           struct vm_area_struct *vma,
> > > >                           struct vm_fault *vmf);
> > > > 
> > > It'd be nicer if people didn't try to line up arguments at all and
> > > just indented by an extra two tabs when they had to break a logical
> > > line due to the 80-column limit.
> > 
> > Matthew, there are two different opinions. Which one to take ?
> 
> Unfortunately this is one of those "maintainer's choice" preferences
> that drives new contributors crazy. Just go with the two tabs like
> Matthew said and be done.

The only reason I mentioned it was the old function name
was aligned that way with arguments aligned to the open
parenthesis.

Renaming the function should keep the same alignment style
and not just rename the function.

-	int (*fault)(const struct vm_special_mapping *sm,
+	vm_fault_t (*fault)(const struct vm_special_mapping *sm,
 		     struct vm_area_struct *vma,
 		     struct vm_fault *vmf);

Here the previous indent was 2 tabs, 5 spaces
