Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D7FC46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 23:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8CB219C3
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 23:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8CB219C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbeHFCDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 22:03:35 -0400
Received: from smtprelay0061.hostedemail.com ([216.40.44.61]:55377 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726821AbeHFCDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 22:03:34 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id EFC5D180A884F;
        Sun,  5 Aug 2018 23:57:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pin28_3e97918ef4015
X-Filterd-Recvd-Size: 1892
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sun,  5 Aug 2018 23:57:10 +0000 (UTC)
Message-ID: <0a038f1680724bafcf8b0615533332a92a67b7cc.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: Check for space after "else" keyword
From:   Joe Perches <joe@perches.com>
To:     Michal Zylowski <michal.zylowski@intel.com>, apw@canonical.com
Cc:     linux-kernel@vger.kernel.org
Date:   Sun, 05 Aug 2018 16:57:08 -0700
In-Reply-To: <1533501740-451-1-git-send-email-michal.zylowski@intel.com>
References: <1533501740-451-1-git-send-email-michal.zylowski@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-08-05 at 22:42 +0200, Michal Zylowski wrote:
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
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 447857f..81617b8 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -4483,7 +4483,7 @@ sub process {
>  
>  #need space before brace following if, while, etc
>  		if (($line =~ /\(.*\)\{/ && $line !~ /\($Type\)\{/) ||
> -		    $line =~ /do\{/) {
> +		    $line =~ /\b(?:else|do)\{/) {
>  			if (ERROR("SPACING",
>  				  "space required before the open brace '{'\n" . $herecurr) &&
>  			    $fix) {

Thanks.

btw: the fix block blow also should be updated with else


