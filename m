Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54CEC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318F820989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="MjaUjY0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318F820989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbeLFWwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:52:09 -0500
Received: from one.firstfloor.org ([193.170.194.197]:43250 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbeLFWwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 17:52:08 -0500
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 8B87D868D9; Thu,  6 Dec 2018 23:52:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1544136727;
        bh=paa2phaSxGTZuj9bs7xPRnHI7Eax5tLDSBYfkZcVK4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MjaUjY0eJ0tqcO/9HrNt3DAv1ZxZevM85bMuOoxVoOAYpJkfV1MFri4l4ussCIu3K
         vBQwVFOT7r4xedUDU1tSBz7/Ng7Fw9aalQ1C+WaS7ip4CMISYW92HKUauyTkgCWUpu
         uGmoScTOuv09urXEP7r9U9JaGlnNEQP5u+EShHR8=
Date:   Thu, 6 Dec 2018 14:52:07 -0800
From:   Andi Kleen <andi@firstfloor.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andi Kleen <andi@firstfloor.org>,
        Milian Wolff <milian.wolff@kdab.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf script: Fix LBR skid dump problems in brstackinsn
Message-ID: <20181206225207.eomszl6sq3omrth7@two.firstfloor.org>
References: <20181120050617.4119-1-andi@firstfloor.org>
 <20181206170140.GJ19069@kernel.org>
 <20181206205146.hsiehbf6fyee2uec@two.firstfloor.org>
 <20181206212920.GC32567@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206212920.GC32567@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 06:29:20PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Dec 06, 2018 at 12:51:48PM -0800, Andi Kleen escreveu:
> > On Thu, Dec 06, 2018 at 02:01:40PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Mon, Nov 19, 2018 at 09:06:17PM -0800, Andi Kleen escreveu:
> > > > From: Andi Kleen <ak@linux.intel.com>
> > > > 
> > > > This is a fix for another instance of the skid problem Milian
> > > > recently found [1]
> 
> I think you forgot to add the reference, i.e. what is the url or
> message-id that this [1] refers to?

Hmm, I thought I saw some patches from Milian for this earlier,
but now I can't find them. Perhaps I misremember. Milian
can point to them if they exist and are not just a figment
of my imagination :-)

These were the changes to report the stack frame RIP/RSP in the PEBS
handler and use it for unwinding in perf.

-Andi
