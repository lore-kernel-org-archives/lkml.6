Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926B1C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EDA24075
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53EDA24075
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753603AbeGEV5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:57:47 -0400
Received: from smtprelay0008.hostedemail.com ([216.40.44.8]:44877 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753432AbeGEV4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:56:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 97B0E182CED34;
        Thu,  5 Jul 2018 21:56:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pet57_71b4e03be854d
X-Filterd-Recvd-Size: 1637
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Thu,  5 Jul 2018 21:56:21 +0000 (UTC)
Message-ID: <6ac2e3636968832b7bc9a49d6a3f4d4998f9aa20.camel@perches.com>
Subject: Re: [PATCH] checkpatch: forbid filesystem accesses from within the
 kernel
From:   Joe Perches <joe@perches.com>
To:     Prakruthi Deepak Heragu <pheragu@codeaurora.org>, apw@canonical.com
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, bryanh@codeaurora.org
Date:   Thu, 05 Jul 2018 14:56:19 -0700
In-Reply-To: <1530827270-19947-1-git-send-email-pheragu@codeaurora.org>
References: <1530827270-19947-1-git-send-email-pheragu@codeaurora.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-05 at 14:47 -0700, Prakruthi Deepak Heragu wrote:
> As use of sys_open/close/read/write system calls from within the kernel 
> code is inappropriate, an error is triggered if used.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -5372,6 +5372,13 @@ sub process {
>  			     "Avoid line continuations in quoted strings\n" . $herecurr);
>  		}
>  
> +# sys_open/read/write/close are not allowed in the kernel
> +		if ($line =~ /\b(sys_(?:open|read|write|close))\b/) {
> +			ERROR("FILE_OPS",
> +			      "$1 is inappropriate in kernel code.\n" .
> +			      $herecurr);
> +		}
> +

Is this really useful?

As far as I can tell, this would only give
false positives on all existing kernel code.

