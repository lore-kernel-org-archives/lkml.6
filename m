Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568CCC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CCF214EE
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5CCF214EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeHOWmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 18:42:39 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:55846 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbeHOWmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 18:42:38 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fq1my-0001IM-JA; Wed, 15 Aug 2018 19:49:04 +0000
Date:   Wed, 15 Aug 2018 20:49:04 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Martin Schroeder <mkschreder.uk@googlemail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: A far fetched goal to clean up code quality
Message-ID: <20180815194904.GX6515@ZenIV.linux.org.uk>
References: <CAGmj6qs6tPvVMsxSLPgkNkmfUYSuqvTR+sqpuR+k5cEoUo9hww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGmj6qs6tPvVMsxSLPgkNkmfUYSuqvTR+sqpuR+k5cEoUo9hww@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 08:33:36PM +0200, Martin Schroeder wrote:
> I propose using following set of GCC flags to enforce code quality in
> the long run.
> 
>     -Wall -Wextra -Werror\
>     -std=gnu11\
>     -pedantic \
>     -Wchar-subscripts\
>     -Wformat\
>     -Wformat-nonliteral\
>     -Wformat-security\
>     -Wmissing-braces\
>     -Wparentheses\
>     -Wsequence-point\
>     -Wswitch\
>     -Wtrigraphs\
>     -Wno-unused-function\
>     -Wunused-label\
>     -Wno-unused-parameter\
>     -Wunused-variable\
>     -Wunused-value\
>     -Wuninitialized\
>     -Wdiv-by-zero\
>     -Wfloat-equal\
>     -Wdouble-promotion\
>     -fsingle-precision-constant\
>     -Wshadow\
>     -Wpointer-arith\
>     -Wwrite-strings\
>     -Wconversion\
>     -Wredundant-decls\
>     -Wunreachable-code\
>     -Winline\
>     -Wenum-compare \
>     -Wlong-long\
>     -Wchar-subscripts

I will probably regret it, but... do you even know C?  And have you ever
bothered to read the documentation describing all those oh-so-fine options,
or have you simply aped the list from some... place?

For example, this:
'-Wlong-long'
     Warn if 'long long' type is used.  This is enabled by either
     '-Wpedantic' or '-Wtraditional' in ISO C90 and C++98 modes.  To
     inhibit the warning messages, use '-Wno-long-long'.
and the warning it triggers is <drumrolls>
	"ISO C90 does not support ‘long long’ [-Wlong-long]".

Now, could the esteemed sir be arsed to explain the meaning of "-std=gnu11"?
Take your time and use your own words.  Then explain just how would that
warning be relevant to chosen C dialect.  For an extra credit, explain
just how the hell is one supposed to represent 64bit arithmetical data on
32bit architectures without using the dreaded long long.

Free advice: do try to understand what you are proposing when you are
setting lofty goals for everybody else to toil for.

Al "I loathe aspiring PHBs" Viro, in rather foul mood at the moment...
