Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id smVQOH5BGFtkRwAAmS7hNA
	; Wed, 06 Jun 2018 20:19:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7BA3760861; Wed,  6 Jun 2018 20:19:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C66DB60290;
	Wed,  6 Jun 2018 20:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C66DB60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752939AbeFFUTE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 16:19:04 -0400
Received: from smtprelay0197.hostedemail.com ([216.40.44.197]:35360 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752277AbeFFUTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 16:19:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id D2E00181D12E9;
        Wed,  6 Jun 2018 20:19:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sail47_31a85f2413b0c
X-Filterd-Recvd-Size: 2082
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Wed,  6 Jun 2018 20:19:01 +0000 (UTC)
Message-ID: <22cb30ea19ad4ab1b341836c5f672ba406cb2b4e.camel@perches.com>
Subject: Re: [PATCH] clang-format: Set IndentWrappedFunctionNames false
From: Joe Perches <joe@perches.com>
To: Jason Gunthorpe <jgg@mellanox.com>, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        Andy Whitcroft <apw@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 06 Jun 2018 13:18:59 -0700
In-Reply-To: <20180606201556.GA10832@ziepe.ca>
References: <20180606201556.GA10832@ziepe.ca>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-06 at 14:15 -0600, Jason Gunthorpe wrote:
> The true option causes this indenting for functions:
> 
> static struct something_very_very_long *
>     function(void *arg)
> {
> 
> While a quick survey suggests that the usual Linux fallback is the GNU
> style:
> 
> static struct something_very_very_long *
> function(void *arg)
> 
[]
> AFAIK the above describes the more common choice in the code base?
> 
> Not sure who's tree this is supposed to go through.. Andrew I guess?

I believe so yes.

I expect there will be more refinements to .clang-formata
as perhaps more people experiment with it too.

Acked-by: Joe Perches <joe@perches.com>

> diff --git a/.clang-format b/.clang-format
> index faffc0d5af4eeb..1d5da22e0ba50c 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -382,7 +382,7 @@ IncludeIsMainRegex: '(Test)?$'
>  IndentCaseLabels: false
>  #IndentPPDirectives: None # Unknown to clang-format-5.0
>  IndentWidth: 8
> -IndentWrappedFunctionNames: true
> +IndentWrappedFunctionNames: false
>  JavaScriptQuotes: Leave
>  JavaScriptWrapImports: true
>  KeepEmptyLinesAtTheStartOfBlocks: false
