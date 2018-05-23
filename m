Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934786AbeEWWfj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 18:35:39 -0400
Received: from smtprelay0112.hostedemail.com ([216.40.44.112]:33792 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933083AbeEWWfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 18:35:37 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:541:599:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2525:2559:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6737:7903:9025:10004:10400:10848:11232:11658:11914:12043:12048:12679:12740:12760:12895:13069:13161:13229:13311:13357:13439:14096:14097:14181:14659:14721:21080:21433:21627:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:23,LUA_SUMMARY:none
X-HE-Tag: part69_87cf87e16915a
X-Filterd-Recvd-Size: 2482
Message-ID: <56ee8810463b6c537ca0c10c9f82e6d922acd1f1.camel@perches.com>
Subject: Re: [PATCH] block drivers/block: Use octal not symbolic permissions
From: Joe Perches <joe@perches.com>
To: Jens Axboe <axboe@kernel.dk>, "Ed L. Cashin" <ed.cashin@acm.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jiri Kosina <jikos@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>,
        Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Roger Pau =?ISO-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
        nbd@other.debian.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org
Date: Wed, 23 May 2018 15:35:31 -0700
In-Reply-To: <6bf44255-145f-bf14-e254-860731ff9296@kernel.dk>
References: <5e97a292c1ba38a6b5a0caa271d85dc3de1b2aa7.1527105857.git.joe@perches.com>
         <6bf44255-145f-bf14-e254-860731ff9296@kernel.dk>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-23 at 15:27 -0600, Jens Axboe wrote:
> On 5/23/18 2:05 PM, Joe Perches wrote:
> > Convert the S_<FOO> symbolic permissions to their octal equivalents as
> > using octal and not symbolic permissions is preferred by many as more
> > readable.
> > 
> > see: https://lkml.org/lkml/2016/8/2/1945
> > 
> > Done with automated conversion via:
> > $ ./scripts/checkpatch.pl -f --types=SYMBOLIC_PERMS --fix-inplace <files...>
> > 
> > Miscellanea:
> > 
> > o Wrapped modified multi-line calls to a single line where appropriate
> > o Realign modified multi-line calls to open parenthesis
> 
> Honestly, I see this as pretty needless churn.

btw:

There is currently a mixture of symbolic and octal
permissions uses in block and drivers/block

ie: 94 octal and 146 symbolic uses.

If this is applied, all would become octal.
