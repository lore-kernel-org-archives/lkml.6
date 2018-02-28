Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933506AbeB1Qhk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 11:37:40 -0500
Received: from smtprelay0233.hostedemail.com ([216.40.44.233]:56174 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932162AbeB1Qhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 11:37:38 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:599:800:960:967:973:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2559:2563:2682:2685:2693:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:7901:7903:8599:9015:9025:9121:9165:10004:10400:10848:10913:11232:11233:11473:11658:11914:12043:12262:12296:12438:12555:12679:12740:12760:12783:12895:12986:13069:13072:13161:13229:13311:13357:13439:13846:14096:14097:14181:14659:14721:14777:14849:21080:21324:21365:21433:21451:21611:21627:21740:30003:30022:30054:30070:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: push17_7c58ecb029009
X-Filterd-Recvd-Size: 1812
Message-ID: <1519835851.30349.7.camel@perches.com>
Subject: Re: [PATCH] checkpatch: avoid error report caused by syzbot
From: Joe Perches <joe@perches.com>
To: Yisheng Xie <xieyisheng1@huawei.com>, apw@canonical.com,
        akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Date: Wed, 28 Feb 2018 08:37:31 -0800
In-Reply-To: <1519809018-1736-1-git-send-email-xieyisheng1@huawei.com>
References: <1519809018-1736-1-git-send-email-xieyisheng1@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-28 at 17:10 +0800, Yisheng Xie wrote:
> syzbot request to add his reported-by when fix the bug find by syzbot.
> However, it will trigger a error when use checkpatch:
> 
>   ERROR: Unrecognized email address: 'syzbot+d7a918a7a8e1c952bc36@syzkaller.appspotmail.com'
> 
> For it include '+' in email and make regular expression works abnomal. Fix
> it by adding check for syzbot.
> 
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>

Nack.

There's a proper patch already in -next

commit 14e45b3ecdb03211ab32656cd84e66fd6a28343e
Author: Joe Perches <joe@perches.com>
Date:   Thu Feb 22 09:59:45 2018 +1100

    checkpatch: improve parse_email signature checking
    
    Bare email addresses with non alphanumeric characters require escape
    quoting before being substituted in the parse_email routine.
    
    e.g. Reported-by: syzbot+bbd8e9a06452cc48059b@syzkaller.appspotmail.com
    
    Do so.
    
    Link: http://lkml.kernel.org/r/1518631805.3678.12.camel@perches.com
