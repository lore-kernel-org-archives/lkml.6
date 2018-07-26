Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3DAC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 21:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0B120846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 21:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0B120846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbeGZWty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 18:49:54 -0400
Received: from smtprelay0072.hostedemail.com ([216.40.44.72]:52060 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730581AbeGZWtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 18:49:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 0B7C1180A8149;
        Thu, 26 Jul 2018 21:31:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lamp71_61b555fb3c43e
X-Filterd-Recvd-Size: 2157
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Thu, 26 Jul 2018 21:31:11 +0000 (UTC)
Message-ID: <4a8c5a82369787869ec52667397e61b6f619b08f.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: check for #if 0/#if 1
From:   Joe Perches <joe@perches.com>
To:     Prakruthi Deepak Heragu <pheragu@codeaurora.org>,
        apw@canonical.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, bryanh@codeaurora.org,
        Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Date:   Thu, 26 Jul 2018 14:31:10 -0700
In-Reply-To: <1532625218-24321-1-git-send-email-pheragu@codeaurora.org>
References: <1532625218-24321-1-git-send-email-pheragu@codeaurora.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-26 at 10:13 -0700, Prakruthi Deepak Heragu wrote:
> The #if 0 or #if 1 is used to toggle features. Warn if #if 0 or #if 1
> is present and suggest that they can be removed.
> 
> Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
> Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>

Andrew, can you please move the misplaced periods below
to the appropriate positions?

Otherwise:

Acked-by: Joe Perches <joe@perches.com>

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -5383,9 +5383,14 @@ sub process {
>  
>  # warn about #if 0
>  		if ($line =~ /^.\s*\#\s*if\s+0\b/) {
> -			CHK("REDUNDANT_CODE",
> -			    "if this code is redundant consider removing it\n" .
> -				$herecurr);
> +			WARN("IF_0",
> +			     "Consider removing the code enclosed by this #if 0 and its #endif\n".  $herecurr);

This should have a space before the . and only one space after.

> +		}
> +
> +# warn about #if 1
> +		if ($line =~ /^.\s*\#\s*if\s+1\b/) {
> +			WARN("IF_1",
> +			     "Consider removing the #if 1 and its #endif\n".  $herecurr);

here too

>  		}
>  
>  # check for needless "if (<foo>) fn(<foo>)" uses
