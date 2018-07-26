Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D965BC67790
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB9020846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HnyssPl0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gYJbWdzU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB9020846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbeGZBy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 21:54:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34170 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbeGZBy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 21:54:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 113CA60D50; Thu, 26 Jul 2018 00:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532565647;
        bh=dRmfo4JXlTJZyHOPf7dZqprOBP37lKoV+qPGyAffKsg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HnyssPl0U7xOArPZE6i3ZvSdIxRUo/kW3Mv44c3AsBHU7IcsR/WbbLhGPs7I4XpL+
         HiZEUd5rrnVlewQQ+LsDyf5X5YgXhD3YZRka68XUbKElrhfTjTYQpB+ynhPY5JTBcz
         ZRk2uSxSO8kjVHor5wszExffI3R2HjyAaLBnndNQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id F413960D37;
        Thu, 26 Jul 2018 00:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532565646;
        bh=dRmfo4JXlTJZyHOPf7dZqprOBP37lKoV+qPGyAffKsg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gYJbWdzUogsGWvtFVnB2AwG9Q2vlDdsiUvKLzLdjQM0GmzqJ3cE5/XH//luu9jzVe
         jKFo8AVL/u+3iKMTWnGTTBbNgPOucdgQqojQvgPE08R2Gk744y6Hl2ESneLIIupECS
         HAGnjqMCNVnRh6IAbDTcpA4FGsYo9ljyrXiE8KlM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 25 Jul 2018 17:40:45 -0700
From:   pheragu@codeaurora.org
To:     Joe Perches <joe@perches.com>
Cc:     Apw <apw@canonical.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Bryanh <bryanh@codeaurora.org>, Ckadabi <ckadabi@codeaurora.org>,
        Tsoni <tsoni@codeaurora.org>
Subject: Re: Reminder to review a few patches sent two weeks ago
In-Reply-To: <612de3c34f4986ac3ee6040af200a0e179acdcbd.camel@perches.com>
References: <e531d3a7a9db2e8d06da01cab2ad090d@codeaurora.org>
 <612de3c34f4986ac3ee6040af200a0e179acdcbd.camel@perches.com>
Message-ID: <2263042da44fae7cae949ac383c41964@codeaurora.org>
X-Sender: pheragu@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-24 17:33, Joe Perches wrote:
> On Tue, 2018-07-24 at 14:56 -0700, pheragu@codeaurora.org wrote:
>> A reminder to review a few patches I had sent last week. Below are the
>> links for the patches.
>> 
>> https://lkml.org/lkml/2018/7/5/798
> 
> I have no fundamental object to this one, but
> the 80 column use is unnecessary and should be
> coalesced before it can be applied.
> 
> Perhaps:
> 
> # warn about #if 1
> 		if ($line =~ /^.\s*\#\s*if\s+1\b/) {
> 			WARN("IF_1",
> 			     "Consider removing the #if 1 and its #endif\n" .  $herecurr);
>  		}
> 
>> http://lists-archives.com/linux-kernel/29168320-checkpatch-check-for-invalid-return-codes.html
> 
> This one has I think too many existing uses of
> things like "return -1;"
> 
> $ git grep -P "return\s*\-\d+\s*;" | wc -l
> 9929
> 
> How many of these are actually appropriate?
> 
I did go through a few of the files which return -1 in their functions,
I observed that most of them were inappropriate and there was a case
where actually the use of return -1 was 
incorrect(kernel/arch/ia64/mm/contig.c
in the function find_bootmap_location()). We could actually catch such 
errors
from now on if we use this patch.

> Also, no space is required between return and -1
> by c90 and this should use $Int so it should be:
> 
> 	if ($line =~ /\breturn\s*\-\$Int\s*;/) {
> 
> etc...
