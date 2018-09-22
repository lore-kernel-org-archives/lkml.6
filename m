Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AE6C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 14:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367F82146E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 14:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367F82146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbeIVUKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 16:10:47 -0400
Received: from smtprelay0052.hostedemail.com ([216.40.44.52]:40660 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728638AbeIVUKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 16:10:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 38B6B181D3417;
        Sat, 22 Sep 2018 14:17:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fact64_773dac533722d
X-Filterd-Recvd-Size: 1822
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sat, 22 Sep 2018 14:16:59 +0000 (UTC)
Message-ID: <a31b639d4415d6edd4174b3d4b71528ec94ad10a.camel@perches.com>
Subject: Re: [PATCH v2] i2c: aspeed: fix invalid clock parameters for very
 large divisors
From:   Joe Perches <joe@perches.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-i2c@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sat, 22 Sep 2018 07:16:58 -0700
In-Reply-To: <CAFd5g46==5HG2stvuVfOUtsSW37SvLN6cCmOhRSxibrUpxb8aA@mail.gmail.com>
References: <20180921221025.75003-1-brendanhiggins@google.com>
         <f5943177-6f1b-9344-3821-2aac001ff45d@linux.intel.com>
         <CAFd5g46==5HG2stvuVfOUtsSW37SvLN6cCmOhRSxibrUpxb8aA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-09-21 at 15:30 -0700, Brendan Higgins wrote:
> On Fri, Sep 21, 2018 at 3:26 PM Jae Hyun Yoo
[]
> > > +             dev_err(dev,
> > > +                     "clamping clock divider: divider requested, %u, is greater than largest possible divider, %u.",
> > 
> > Please put a newline character at the end of the string.
> 
> I always forget to do that. I wonder if anyone has considered adding a
> warning for this to checkpatch?

Yes, but it's not possible to know when there
a pr_cont that follows so any checkpatch test
would be a false positive generator too.

