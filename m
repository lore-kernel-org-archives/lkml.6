Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751572AbeBRRZy (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 12:25:54 -0500
Received: from smtprelay0039.hostedemail.com ([216.40.44.39]:44682 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751259AbeBRRZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 12:25:52 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:541:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3867:4321:5007:8957:10004:10400:10848:11026:11232:11473:11658:11914:12043:12555:12740:12760:12895:12986:13069:13311:13357:13439:14181:14659:14721:21080:21451:21611:21627:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: pets34_6d42a8b82842f
X-Filterd-Recvd-Size: 2045
Message-ID: <1518974749.1894.15.camel@perches.com>
Subject: Re: [RESEND PATCH v2] checkpatch: add Crypto ON_STACK to
 declaration_macros
From: Joe Perches <joe@perches.com>
To: Gilad Ben-Yossef <gilad@benyossef.com>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Ofir Drang <ofir.drang@arm.com>, linux-kernel@vger.kernel.org
Date: Sun, 18 Feb 2018 09:25:49 -0800
In-Reply-To: <1518941636-4484-1-git-send-email-gilad@benyossef.com>
References: <1518941636-4484-1-git-send-email-gilad@benyossef.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-02-18 at 08:13 +0000, Gilad Ben-Yossef wrote:
> Add the crypto API *_ON_STACK to $declaration_macros.
> 
> Resolves the following false warning:
> 
> WARNING: Missing a blank line after declarations
> +			int err;
> +			SHASH_DESC_ON_STACK(desc, ctx_p->shash_tfm);
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>

Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  scripts/checkpatch.pl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 3d40403..7d632645 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -791,7 +791,8 @@ our $FuncArg = qr{$Typecast{0,1}($LvalOrFunc|$Constant|$String)};
>  our $declaration_macros = qr{(?x:
>  	(?:$Storage\s+)?(?:[A-Z_][A-Z0-9]*_){0,2}(?:DEFINE|DECLARE)(?:_[A-Z0-9]+){1,6}\s*\(|
>  	(?:$Storage\s+)?[HLP]?LIST_HEAD\s*\(|
> -	(?:$Storage\s+)?${Type}\s+uninitialized_var\s*\(
> +	(?:$Storage\s+)?${Type}\s+uninitialized_var\s*\(|
> +	(?:SKCIPHER_REQUEST|SHASH_DESC|AHASH_REQUEST)_ON_STACK\s*\(
>  )};
>  
>  sub deparenthesize {
