Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97731ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 23:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6416A2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 23:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6416A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbeJYIQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:16:29 -0400
Received: from smtprelay0165.hostedemail.com ([216.40.44.165]:43793 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726236AbeJYIQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:16:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 25B706D95;
        Wed, 24 Oct 2018 23:46:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: can63_7177fc23fc320
X-Filterd-Recvd-Size: 2768
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Wed, 24 Oct 2018 23:46:19 +0000 (UTC)
Message-ID: <49ec92564284b5beb0a151bce1d537b51340d0a8.camel@perches.com>
Subject: Re: [PATCH] Change judgment len position
From:   Joe Perches <joe@perches.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     David Miller <davem@davemloft.net>, wanghaifine@gmail.com,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Fengguang Wu <fengguang.wu@intel.com>, lkp <lkp@01.org>
Date:   Wed, 24 Oct 2018 16:46:18 -0700
In-Reply-To: <20181024204852.GA25509@1wt.eu>
References: <20181024154729.5312-1-wanghaifine@gmail.com>
         <20181024.101028.1211941922121897721.davem@davemloft.net>
         <61d94f2a5563db4d6580c8385c3b93c8eeb3669a.camel@perches.com>
         <20181024204852.GA25509@1wt.eu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(adding Fengguang Wu and lkp)

On Wed, 2018-10-24 at 22:48 +0200, Willy Tarreau wrote:
> When you read this patch from an apparent first-time contributor (no
> trace in either LKML, netdev or even google), the level of assurance
> in the commit message is pretty good, showing that he's not at all a
> beginner, which doesn't match at all the type of error seen in the
> code, which doesn't even need to be compiled to see that it will emit
> a warning and not work as advertised.

Which to me is more of an indication of beginner-ness.

> When you factor in the fact that the code opens a big but very discrete
> vulnerability, I tend to think that in fact we're not facing a newbie
> at all but someone deliberately trying to inject a subtle backdoor into
> the kernel and disguise it as a vague bug fix,

That seems unlikely as it introduces a compilation warning.

A real intentional backdoor from a nefarious source would
likely be completely correct about compilation and use the
typical commit subject style.

Anyway, who know for certain right now.

I would have suggested David reply with only his second sentence
and maybe a pointer to kernelnewbies or staging.

Just something like:

	nack: 'len' has no value before the get_user() call.

	Please try to make your first patch in drivers/staging
	to get familiar with submitting patches to the kernel.
	https://kernelnewbies.org/FirstKernelPatch

Maybe there's utility in creating a filtering and auto-reply
tool for first time patch submitters for all the vger mailing
lists using some combination of previously known submitters
and the 0-day robot to point those first time submitters of
defective patches to kernelnewbies and staging.

cheers, Joe

