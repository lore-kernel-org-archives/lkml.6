Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751846AbeERSf7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 14:35:59 -0400
Received: from smtprelay0149.hostedemail.com ([216.40.44.149]:59330 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751117AbeERSf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 14:35:56 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:541:599:960:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3653:3865:3867:3868:3870:4321:5007:10004:10400:10848:11658:11914:12043:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21433:21627:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: pain29_50e6655309d40
X-Filterd-Recvd-Size: 1511
Message-ID: <072f46c8ec88511000126831b4ebea494e93fb9b.camel@perches.com>
Subject: Re: seq_putc is preferable to seq_puts
From: Joe Perches <joe@perches.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 18 May 2018 11:35:53 -0700
In-Reply-To: <33bbe7e9c0f41ee0ef73ffd5bbca1e9c84c259ec.camel@perches.com>
References: <20180518140957.GB6361@bombadil.infradead.org>
         <33bbe7e9c0f41ee0ef73ffd5bbca1e9c84c259ec.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-05-18 at 10:50 -0700, Joe Perches wrote:
> and a trivial script to convert them all treewide
> 
> $ git grep -P --name-only '\b(?:seq_puts|seq_printf)\s*\(\s*[^,]+,\s*"(?:\\.|.)"\s*\)\s*;' | \
>   xargs perl -i -e 'local $/; while (<>) { s/\b(?:seq_puts|seq_printf)\s*\(\s*([^,]+),\s*"(\\.|.)"\s*\)\s*;/seq_putc(\1, '"'\2'"')/g; print;}'

Hmm, pity this was missing a trailing semicolon in the substitution

$ git grep -P --name-only '\b(?:seq_puts|seq_printf)\s*\(\s*[^,]+,\s*"(?:\\.|.)"\s*\)\s*;' | \
  xargs perl -i -e 'local $/; while (<>) { s/\b(?:seq_puts|seq_printf)\s*\(\s*([^,]+),\s*"(\\.|.)"\s*\)\s*;/seq_putc(\1, '"'\2'"');/g; print;}'
