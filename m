Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752377AbeCZWuj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:50:39 -0400
Received: from smtprelay0142.hostedemail.com ([216.40.44.142]:53337 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752315AbeCZWuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:50:37 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2559:2563:2682:2685:2828:2840:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6742:7903:9025:10004:10400:10848:10967:11232:11658:11914:12043:12295:12740:12760:12895:13069:13153:13228:13311:13357:13439:14040:14096:14097:14181:14659:14721:21080:21627:30054:30070:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: chin98_5c725d2e5a53c
X-Filterd-Recvd-Size: 2058
Message-ID: <1522104633.12357.36.camel@perches.com>
Subject: Re: [PATCH] mm: Use octal not symbolic permissions
From: Joe Perches <joe@perches.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Hugh Dickins <hughd@google.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date: Mon, 26 Mar 2018 15:50:33 -0700
In-Reply-To: <20180326154149.4045ec03645d6983de6f11b3@linux-foundation.org>
References: <2e032ef111eebcd4c5952bae86763b541d373469.1522102887.git.joe@perches.com>
         <20180326154149.4045ec03645d6983de6f11b3@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-26 at 15:41 -0700, Andrew Morton wrote:
> On Mon, 26 Mar 2018 15:22:32 -0700 Joe Perches <joe@perches.com> wrote:
> 
> > mm/*.c files use symbolic and octal styles for permissions.
> > 
> > Using octal and not symbolic permissions is preferred by many as more
> > readable.
> > 
> > https://lkml.org/lkml/2016/8/2/1945
> > 
> > Prefer the direct use of octal for permissions.
> 
> Thanks.  I'll park this until after -rc1 because the
> benefit-to-potential-for-whoopsies ratio is rather low.

No worries.  Whenever.

If you don't like the whitespace changes, or the
sources change so much the patch doesn't apply
cleanly, use the command line below when convenient.

$ ./scripts/checkpatch.pl -f --fix-inplace --types=symbolic_perms mm/*.c
