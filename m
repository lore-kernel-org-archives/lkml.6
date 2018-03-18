Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754599AbeCRU0E (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 16:26:04 -0400
Received: from smtprelay0035.hostedemail.com ([216.40.44.35]:47623 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754304AbeCRU0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 16:26:01 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::,RULES_HIT:41:355:379:541:599:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:5007:6119:7903:8531:10004:10400:10848:11232:11658:11914:12048:12740:12760:12895:13069:13071:13311:13357:13439:13523:13524:14180:14181:14659:14721:21080:21433:21627:30012:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: floor66_6e5abf8b65744
X-Filterd-Recvd-Size: 1864
Message-ID: <1521404757.27411.46.camel@perches.com>
Subject: Re: [PATCH 00/19] C-SKY(csky) Linux Kernel Port
From: Joe Perches <joe@perches.com>
To: Guo Ren <ren_guo@c-sky.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
Date: Sun, 18 Mar 2018 13:25:57 -0700
In-Reply-To: <cover.1521399976.git.ren_guo@c-sky.com>
References: <cover.1521399976.git.ren_guo@c-sky.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-19 at 03:51 +0800, Guo Ren wrote:
> This patchset adds architecture support to Linux for C-SKY's 32-bit embedded
> CPU cores and the patches are based on linux-4.16-rc5.
> 
> There are two ABI versions with several CPU cores in this patchset:
>   ABIv1: ck610 (16-bit instruction, 32-bit data path, VIPT Cache ...)
>   ABIv2: ck807 ck810 (16/32-bit variable length instruction, PIPT Cache ...)

[]

> It's my first patchset to linux and any feedback is welcome :)

Hello.  You might try to do a git am <series>
on a new branch and correct the various
git whitespace messages that are produced.

It's also possible to run checkpatch and correct
some of the linux-kernel code style conformance
nits it lists.

Perhaps something like:

$ git ls-files arch/csky/ | \
  while read file ; do \
    ./scripts/checkpatch.pl --strict --terse --no-summary $file ; \
  done

add --fix-inplace to the checkpatch line if desired.
