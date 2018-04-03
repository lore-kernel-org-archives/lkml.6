Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753565AbeDCVVD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 17:21:03 -0400
Received: from smtprelay0219.hostedemail.com ([216.40.44.219]:40739 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752246AbeDCVVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 17:21:02 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3866:3868:3870:3874:4321:5007:6119:10004:10400:10848:11232:11658:11914:12555:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21221:21451:21627:30054:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:22,LUA_SUMMARY:none
X-HE-Tag: blade92_4300c7dc68623
X-Filterd-Recvd-Size: 1960
Message-ID: <1522790459.11653.65.camel@perches.com>
Subject: Re: [PATCH 1/1] checkpatch: allow space between colon and bracket
From: Joe Perches <joe@perches.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Date: Tue, 03 Apr 2018 14:20:59 -0700
In-Reply-To: <20180403191655.23700-1-xypron.glpk@gmx.de>
References: <20180403190214.23082-1-xypron.glpk@gmx.de>
         <20180403191655.23700-1-xypron.glpk@gmx.de>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-03 at 21:16 +0200, Heinrich Schuchardt wrote:
> Allow a space between a colon and subsequent opening bracket.
> This sequence may occur in inline assembler statements like
> 
> 	asm(
> 		"ldr %[out], [%[in]]\n\t"
> 		: [out] "=r" (ret)
> 		: [in] "r" (addr)
> 	);
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

I can't think of a valid c90 sequence that has a colon
before a bracket so

Acked-by: Joe Perches <joe@perches.com>

> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index d2464002bb40..2cbab86e6d4c 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -4083,7 +4083,7 @@ sub process {
>  			my ($where, $prefix) = ($-[1], $1);
>  			if ($prefix !~ /$Type\s+$/ &&
>  			    ($where != 0 || $prefix !~ /^.\s+$/) &&
> -			    $prefix !~ /[{,]\s+$/) {
> +			    $prefix !~ /[{,:]\s+$/) {
>  				if (ERROR("BRACKET_SPACE",
>  					  "space prohibited before open square bracket '['\n" . $herecurr) &&
>  				    $fix) {
