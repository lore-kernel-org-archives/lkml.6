Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754148AbeC1Po6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 11:44:58 -0400
Received: from smtprelay0228.hostedemail.com ([216.40.44.228]:33381 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754029AbeC1Po4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 11:44:56 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2525:2561:2564:2682:2685:2731:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6742:7903:8985:9025:10004:10400:10848:11232:11658:11854:11914:12043:12663:12740:12760:12895:13069:13153:13228:13311:13357:13439:14096:14097:14181:14659:14721:21063:21080:21433:21627:30012:30030:30054:30070:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: mark44_81f5ca38af95e
X-Filterd-Recvd-Size: 2817
Message-ID: <1522251891.12357.102.camel@perches.com>
Subject: Re: [PATCH] mm: Use octal not symbolic permissions
From: Joe Perches <joe@perches.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Hugh Dickins <hughd@google.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date: Wed, 28 Mar 2018 08:44:51 -0700
In-Reply-To: <20180328130623.GB8976@dhcp22.suse.cz>
References: <2e032ef111eebcd4c5952bae86763b541d373469.1522102887.git.joe@perches.com>
         <20180328130623.GB8976@dhcp22.suse.cz>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-28 at 15:06 +0200, Michal Hocko wrote:
> On Mon 26-03-18 15:22:32, Joe Perches wrote:
> > mm/*.c files use symbolic and octal styles for permissions.
> > 
> > Using octal and not symbolic permissions is preferred by many as more
> > readable.
> > 
> > https://lkml.org/lkml/2016/8/2/1945
> > 
> > Prefer the direct use of octal for permissions.
> > 
> > Done using
> > $ scripts/checkpatch.pl -f --types=SYMBOLIC_PERMS --fix-inplace mm/*.c
> > and some typing.
> > 
> > Before:	 $ git grep -P -w "0[0-7]{3,3}" mm | wc -l
> > 44
> > After:	 $ git grep -P -w "0[0-7]{3,3}" mm | wc -l
> > 86
> 

> Ohh, I absolutely detest those symbolic names. I always have to check
> what they actually mean to be sure. Octal representation is quite
> natural to read. So for once I am really happy about such a clean up
> change.
> 
> Btw. something like this should be quite easy to automate via
> coccinelle AFAIU. 

checkpatch is currently better at this, for some
definition of better, than Coccinelle.

Julia and I had a discussion about it awhile ago.
https://lkml.org/lkml/2017/2/4/140

S_<FOO> groupings need to be combined and can
appear in arbitrary order.

Coccinelle would need the same octal addition in
some code path as checkpatch already has.

> > Miscellanea:
> > 
> > o Whitespace neatening around these conversions.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> I hope I haven't overlooked any potential mismatch...

Doubtful as the conversion is completely automated.
