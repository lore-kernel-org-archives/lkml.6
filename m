Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FB4C46475
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 07:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B852084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 07:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B852084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbeJ2P6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 11:58:05 -0400
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:19212 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729225AbeJ2P6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 11:58:04 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail07.adl2.internode.on.net with ESMTP; 29 Oct 2018 17:40:40 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gH1h8-0003rb-NA; Mon, 29 Oct 2018 18:10:38 +1100
Date:   Mon, 29 Oct 2018 18:10:38 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: XFS: Hang and dmesg flood on mounting invalid FS image
Message-ID: <20181029071038.GL19305@dastard>
References: <CAE5jQCc3hrq6E-Ff1oiYUOSDA08PMrqnu80XQtaD5adcUQvV8w@mail.gmail.com>
 <20181029012058.GK19305@dastard>
 <CAE5jQCeT4hONkK8cmkMoReoW-HqVLqnYN6c3YrxDjwNAf=nfEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE5jQCeT4hONkK8cmkMoReoW-HqVLqnYN6c3YrxDjwNAf=nfEA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 09:57:20AM +0300, Anatoly Trosinenko wrote:
> > How did the corruption occur?
> 
> It is a fuzzed image. Most probably, it was artificially "patched" by
> fuzzer. Or do you mean "what particular bytes were changed"?

I wondered how this specific corruption occurred in the real world.
If i was a real world problem, it would have been indicative of a
code bug if it did occur (i.e. whatever wrote the log record would
have been broken) but seeing as it's a fuzzer problem, I don't need
to look for any code bugs other than "we didn't validate the input
properly".

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
