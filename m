Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D8CC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 01:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94112178F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 01:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D94112178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732156AbeHDDhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 23:37:42 -0400
Received: from smtprelay0164.hostedemail.com ([216.40.44.164]:41133 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731986AbeHDDhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 23:37:42 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id CF81F100E86C1;
        Sat,  4 Aug 2018 01:38:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shirt55_6aefdeec8c359
X-Filterd-Recvd-Size: 1978
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Sat,  4 Aug 2018 01:38:54 +0000 (UTC)
Message-ID: <87ead21c1ab865072c693a092139d72ab5ccff52.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Check for space after "else" keyword
From:   Joe Perches <joe@perches.com>
To:     Michal Zylowski <michal.zylowski@intel.com>, apw@canonical.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 03 Aug 2018 18:38:53 -0700
In-Reply-To: <1533244821-31004-1-git-send-email-michal.zylowski@intel.com>
References: <1533244821-31004-1-git-send-email-michal.zylowski@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-02 at 23:20 +0200, Michal Zylowski wrote:
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

Acked-by: Joe Perches <joe@perches.com

though it might be better if the do and else
was written on a single line like:

	$line =~ /\b(?:else|do)\{/

> ---
>  scripts/checkpatch.pl | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index e16d671..2e3f41e 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -4479,6 +4479,7 @@ sub process {
>  
>  #need space before brace following if, while, etc
>  		if (($line =~ /\(.*\)\{/ && $line !~ /\($Type\)\{/) ||
> +		    $line =~ /else\{/ ||
>  		    $line =~ /do\{/) {
>  			if (ERROR("SPACING",
>  				  "space required before the open brace '{'\n" . $herecurr) &&
