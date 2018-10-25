Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8773ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CBA20824
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84CBA20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbeJYJlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 05:41:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:31643 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbeJYJlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 05:41:40 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 18:11:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,422,1534834800"; 
   d="scan'208";a="94801520"
Received: from rwang-mobl4.amr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.211.80])
  by orsmga003.jf.intel.com with ESMTP; 24 Oct 2018 18:11:11 -0700
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1gFUB5-0002xg-Jg; Thu, 25 Oct 2018 09:11:11 +0800
Date:   Thu, 25 Oct 2018 09:11:11 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Willy Tarreau <w@1wt.eu>, David Miller <davem@davemloft.net>,
        wanghaifine@gmail.com, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@intel.com>,
        Philip Li <philip.li@intel.com>
Subject: Re: [PATCH] Change judgment len position
Message-ID: <20181025011111.bhbstq5wtrwk26b5@wfg-t540p.sh.intel.com>
References: <20181024154729.5312-1-wanghaifine@gmail.com>
 <20181024.101028.1211941922121897721.davem@davemloft.net>
 <61d94f2a5563db4d6580c8385c3b93c8eeb3669a.camel@perches.com>
 <20181024204852.GA25509@1wt.eu>
 <49ec92564284b5beb0a151bce1d537b51340d0a8.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <49ec92564284b5beb0a151bce1d537b51340d0a8.camel@perches.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC Philip and LKP team.

On Wed, Oct 24, 2018 at 04:46:18PM -0700, Joe Perches wrote:
>(adding Fengguang Wu and lkp)
>
>On Wed, 2018-10-24 at 22:48 +0200, Willy Tarreau wrote:
>> When you read this patch from an apparent first-time contributor (no
>> trace in either LKML, netdev or even google), the level of assurance
>> in the commit message is pretty good, showing that he's not at all a
>> beginner, which doesn't match at all the type of error seen in the
>> code, which doesn't even need to be compiled to see that it will emit
>> a warning and not work as advertised.
>
>Which to me is more of an indication of beginner-ness.
>
>> When you factor in the fact that the code opens a big but very discrete
>> vulnerability, I tend to think that in fact we're not facing a newbie
>> at all but someone deliberately trying to inject a subtle backdoor into
>> the kernel and disguise it as a vague bug fix,
>
>That seems unlikely as it introduces a compilation warning.
>
>A real intentional backdoor from a nefarious source would
>likely be completely correct about compilation and use the
>typical commit subject style.
>
>Anyway, who know for certain right now.
>
>I would have suggested David reply with only his second sentence
>and maybe a pointer to kernelnewbies or staging.
>
>Just something like:
>
>	nack: 'len' has no value before the get_user() call.
>
>	Please try to make your first patch in drivers/staging
>	to get familiar with submitting patches to the kernel.
>	https://kernelnewbies.org/FirstKernelPatch
>
>Maybe there's utility in creating a filtering and auto-reply
>tool for first time patch submitters for all the vger mailing
>lists using some combination of previously known submitters
>and the 0-day robot to point those first time submitters of
>defective patches to kernelnewbies and staging.

Yeah good idea. That feature can be broken into 2 parts:

- an email script, which could be added to Linux scripts/ dir 
- maintain records for telling whether someone is first-time patch submitters

Thanks,
Fengguang
