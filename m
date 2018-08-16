Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6623C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 01:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C271C214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 01:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C271C214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbeHPEas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 00:30:48 -0400
Received: from ozlabs.org ([203.11.71.1]:40133 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbeHPEas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 00:30:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41rTS752XTz9s8T;
        Thu, 16 Aug 2018 11:35:51 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, alexander.kapshuk@gmail.com
Subject: Re: [PATCH 1/2] perf tools: Make check-headers.sh check based on kernel dir
In-Reply-To: <20180815150153.GB30887@kernel.org>
References: <20180811083915.17471-1-alexander.kapshuk@gmail.com> <20180813111504.3568-1-jolsa@kernel.org> <87mutplnwk.fsf@concordia.ellerman.id.au> <20180814072726.GA13931@krava> <20180814180644.GA24338@kernel.org> <20180814231120.GB3180@krava> <87wossaqwn.fsf@concordia.ellerman.id.au> <20180815150153.GB30887@kernel.org>
Date:   Thu, 16 Aug 2018 11:35:51 +1000
Message-ID: <87tvnvaya0.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo <acme@kernel.org> writes:
> Em Wed, Aug 15, 2018 at 08:02:48PM +1000, Michael Ellerman escreveu:
>> Jiri Olsa <jolsa@redhat.com> writes:
>> > On Tue, Aug 14, 2018 at 03:06:44PM -0300, Arnaldo Carvalho de Melo wrote:
>> >> Em Tue, Aug 14, 2018 at 09:27:26AM +0200, Jiri Olsa escreveu:
>> >> > sry.. Arnaldo, would you change it for simple cd (attached below)
>> >> > or should I send the fix?
>
>> >> Nah, I'm folding this in, to keep it bisectable.
>
>> > any chance one of your docker tests could run build in sh/zsh? ;-)
>
> It does already, see below :-)
>
>> Just using an Ubuntu image, where /bin/sh == dash should work, that's
>> how I hit it.
>
> So, I do the tests only prior to pushing to Ingo, so didn't catch this,
> lemme check, put that change back on, start a ubuntu:18.04 perf build
> container, try to build, see if it would fail, yeah, I'd have detected
> this before pushing to Ingo, so probably I have to run the tests before
> pushing to my acme/perf/core branch, will try to operate like that from
> now on.

Or you can tell me to test a different branch :)

cheers
