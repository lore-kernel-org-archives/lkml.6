Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750812AbeELGUk (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 02:20:40 -0400
Received: from smtprelay0009.hostedemail.com ([216.40.44.9]:33963 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750735AbeELGUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 02:20:39 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::,RULES_HIT:41:355:379:541:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3871:3872:3874:4321:5007:10004:10400:10848:11026:11232:11658:11914:12048:12296:12438:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21433:21627:30054:30070:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: shirt92_4846adce2553
X-Filterd-Recvd-Size: 1993
Message-ID: <e194731158f7f89145ed0ae28f46aac5726fc32d.camel@perches.com>
Subject: Re: [PATCH v3] mm: Change return type to vm_fault_t
From: Joe Perches <joe@perches.com>
To: Souptick Joarder <jrdr.linux@gmail.com>, akpm@linux-foundation.org,
        mhocko@suse.com, hughd@google.com, dan.j.williams@intel.com,
        rientjes@google.com, mike.kravetz@oracle.com,
        n-horiguchi@ah.jp.nec.com, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, willy@infradead.org
Date: Fri, 11 May 2018 23:20:29 -0700
In-Reply-To: <20180512061712.GA26660@jordon-HP-15-Notebook-PC>
References: <20180512061712.GA26660@jordon-HP-15-Notebook-PC>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-05-12 at 11:47 +0530, Souptick Joarder wrote:
> Use new return type vm_fault_t for fault handler
> in struct vm_operations_struct. For now, this is
> just documenting that the function returns a
> VM_FAULT value rather than an errno.  Once all
> instances are converted, vm_fault_t will become
> a distinct type.

trivia:

> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
[]
> @@ -627,7 +627,7 @@ struct vm_special_mapping {
>  	 * If non-NULL, then this is called to resolve page faults
>  	 * on the special mapping.  If used, .pages is not checked.
>  	 */
> -	int (*fault)(const struct vm_special_mapping *sm,
> +	vm_fault_t (*fault)(const struct vm_special_mapping *sm,
>  		     struct vm_area_struct *vma,
>  		     struct vm_fault *vmf);


It'd be nicer to realign the 2nd and 3rd arguments
on the subsequent lines.

	vm_fault_t (*fault)(const struct vm_special_mapping *sm,
			    struct vm_area_struct *vma,
			    struct vm_fault *vmf);
