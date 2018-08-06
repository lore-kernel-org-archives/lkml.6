Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE84EC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DE621A51
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89DE621A51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732784AbeHFRSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:18:52 -0400
Received: from smtprelay0235.hostedemail.com ([216.40.44.235]:37503 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727541AbeHFRSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:18:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 011AB100E86C3;
        Mon,  6 Aug 2018 15:09:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shop27_1718874ac4062
X-Filterd-Recvd-Size: 2058
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Mon,  6 Aug 2018 15:09:18 +0000 (UTC)
Message-ID: <47a9f8c7819039f10c01ec238622b4a64bd5217f.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: Check for space after "else" keyword
From:   Joe Perches <joe@perches.com>
To:     Michal Zylowski <michal.zylowski@intel.com>, apw@canonical.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 06 Aug 2018 08:09:17 -0700
In-Reply-To: <1533545753-8870-1-git-send-email-michal.zylowski@intel.com>
References: <1533545753-8870-1-git-send-email-michal.zylowski@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-06 at 10:55 +0200, Michal Zylowski wrote:
> Current checkpatch implementation permits notation like:
> } else{
> in kernel code.
> It looks like oversight and inconsistency in checkpatch rules (e.g.
> instruction like 'do' is tested).
> 
> Add regex for checking space after 'else' keyword and trigger error if
> space is not present.
> 
> Signed-off-by: Michal Zylowski <michal.zylowski@intel.com>

Acked-by: Joe Perches <joe@perches.com>

> ---
>  scripts/checkpatch.pl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 447857f..f7e135a 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -4483,11 +4483,11 @@ sub process {
>  
>  #need space before brace following if, while, etc
>  		if (($line =~ /\(.*\)\{/ && $line !~ /\($Type\)\{/) ||
> -		    $line =~ /do\{/) {
> +		    $line =~ /\b(?:else|do)\{/) {
>  			if (ERROR("SPACING",
>  				  "space required before the open brace '{'\n" . $herecurr) &&
>  			    $fix) {
> -				$fixed[$fixlinenr] =~ s/^(\+.*(?:do|\)))\{/$1 {/;
> +				$fixed[$fixlinenr] =~ s/^(\+.*(?:do|else|\)))\{/$1 {/;
>  			}
>  		}
>  
