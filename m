Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91E2C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 17:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6392077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 17:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6392077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeJOBGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 21:06:05 -0400
Received: from smtprelay0085.hostedemail.com ([216.40.44.85]:53675 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726319AbeJOBGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 21:06:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 6FDF4182CF665;
        Sun, 14 Oct 2018 17:24:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tree24_7d0c1faec7e17
X-Filterd-Recvd-Size: 2173
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sun, 14 Oct 2018 17:24:19 +0000 (UTC)
Message-ID: <9b4c97ade076d0ea6b4c2adde7535a5b48f0c5bc.camel@perches.com>
Subject: Re: [PATCH 3.16 232/366] tracing: Deletion of an unnecessary check
 before iput()
From:   Joe Perches <joe@perches.com>
To:     Ben Hutchings <ben@decadent.org.uk>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     akpm@linux-foundation.org,
        Markus Elfring <elfring@users.sourceforge.net>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Sun, 14 Oct 2018 10:24:18 -0700
In-Reply-To: <lsq.1539530741.752314819@decadent.org.uk>
References: <lsq.1539530741.752314819@decadent.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-10-14 at 16:25 +0100, Ben Hutchings wrote:
> 3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

I believe that no stable or backport kernel needs to
apply patches like this unless it's needed for other
real patches to be applied more easily.

> ------------------
> 
> From: Markus Elfring <elfring@users.sourceforge.net>
> 
> commit 16a8ef2751801346f1f76a18685b2beb63cd170f upstream.
> 
> The iput() function tests whether its argument is NULL and then
> returns immediately. Thus the test around the call is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Link: http://lkml.kernel.org/r/5468F875.7080907@users.sourceforge.net
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
>  kernel/trace/trace_uprobe.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -552,8 +552,7 @@ error:
>  	return ret;
>  
>  fail_address_parse:
> -	if (inode)
> -		iput(inode);
> +	iput(inode);
>  
>  	pr_info("Failed to parse address or file.\n");
>  
> 

