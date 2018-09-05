Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C05C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B9C20659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B9C20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbeIFABe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:01:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36124 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbeIFABd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:01:33 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D451A18FE;
        Wed,  5 Sep 2018 19:29:56 +0000 (UTC)
Date:   Wed, 5 Sep 2018 21:29:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        stable@vger.kernel.org,
        Pavlos Parissis <pavlos.parissis@gmail.com>,
        Lei Chen <chenl.lei@gmail.com>,
        Maxime Hadjinlian <maxime.hadjinlian@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Wang Nan <wangnan0@huawei.com>, kernel-team@lge.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 4.9 52/66] Revert "perf tests: Decompress kernel module
 before objdump"
Message-ID: <20180905192954.GB13608@kroah.com>
References: <20180417155648.152933169@linuxfoundation.org>
 <eff5b3dd-5a43-a424-d32d-b9065fd6424c@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eff5b3dd-5a43-a424-d32d-b9065fd6424c@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 11:50:02AM -0700, Florian Fainelli wrote:
> On 04/17/2018 08:59 AM, Greg Kroah-Hartman wrote:
> > 4.9-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > This reverts commit 7525a238be8f46617cdda29d1be5b85ffe3b042d which is
> > commit 94df1040b1e6aacd8dec0ba3c61d7e77cd695f26 upstream.
> > 
> > It breaks the build of perf on 4.9.y, so I'm dropping it.
> 
> Sorry to hijack this thread, I was not able to find the original email
> when the offending patch was included in 4.1.52. So kernel 4.1.52 also
> has the same problem, can you push a 4.1.53 tag with that patch reverted
> as well?

4.1 is long end-of-life now, I'm not going to be going and updating a
"dead' kernel for a perf build bug.

You shouldn't be using this kernel either :)

thanks,

greg k-h
