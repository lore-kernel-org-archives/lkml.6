Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3EDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD94F206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeLNPwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:52:20 -0500
Received: from smtprelay0241.hostedemail.com ([216.40.44.241]:34172 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727300AbeLNPwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:52:19 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 57ADB837F243;
        Fri, 14 Dec 2018 15:52:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: need30_6b419b791b81c
X-Filterd-Recvd-Size: 2246
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Fri, 14 Dec 2018 15:52:16 +0000 (UTC)
Message-ID: <839c1d04000164e27dff9742e3efc3bcff3025b6.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add Co-Developed-by to signature tags
From:   Joe Perches <joe@perches.com>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        apw@canonical.com, Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, niklas.cassel@linaro.org
Date:   Fri, 14 Dec 2018 07:52:15 -0800
In-Reply-To: <1544792494-15485-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1544792494-15485-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-14 at 14:01 +0100, Jorge Ramirez-Ortiz wrote:
> As per Documentation/process/submitting-patches, Co-developed-by is a
> valid signature.
> 
> This commit removes the warning.

Your commit message doesn't match your subject.

A couple variants have been documented and only
one should actually be used.

$ git grep -i co-developed-by Documentation/process/
Documentation/process/5.Posting.rst: - Co-developed-by: states that the patch was also created by another developer
Documentation/process/submitting-patches.rst:12) When to use Acked-by:, Cc:, and Co-Developed-by:
Documentation/process/submitting-patches.rst:A Co-Developed-by: states that the patch was also created by another developer

$ git log --grep="co-developed-by:" -i | \
  grep -ohiP "co-developed-by:" | sort | uniq -c | sort -rn
     80 Co-developed-by:
     40 Co-Developed-by:

So which should it be?

btw: I prefer neither as I think Signed-off-by: is sufficient.

> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -468,6 +468,7 @@ our $logFunctions = qr{(?x:
>  
>  our $signature_tags = qr{(?xi:
>  	Signed-off-by:|
> +	Co-Developed-by:|
>  	Acked-by:|
>  	Tested-by:|
>  	Reviewed-by:|

