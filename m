Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB05C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 13:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A37120652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 13:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v5MPDHGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A37120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbeJWVkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 17:40:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbeJWVkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 17:40:37 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1026820652;
        Tue, 23 Oct 2018 13:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540300631;
        bh=k2e18nkrn7IASgR1o+9r3PF+9TeryMaVqKPQMZdxUYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v5MPDHGwVUDLdMa8L6KiM9fuRPKo8ZZHCd17Qxwf1TM6PA62MsdS4AscIm52CIRN8
         Ki2LKKNcm3f/rW8c8iPwY7/w8V/K5C7lgZ22aeN40kdgKKNv2M9hbtZd0wc24mq83w
         rjrGS3YDdm0Zq4cizgqLFj6KIr8ilo2shCNXRfKU=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id C4C9E142C5E; Tue, 23 Oct 2018 10:17:07 -0300 (-03)
Date:   Tue, 23 Oct 2018 10:17:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] perf record: encode -k clockid frequency into Perf
 trace
Message-ID: <20181023131707.GA3657@kernel.org>
References: <23a4a1dc-b160-85a0-347d-40a2ed6d007b@linux.intel.com>
 <20181009193202.GE10775@kernel.org>
 <87149798-6031-9ca1-5725-3f6e4b428946@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87149798-6031-9ca1-5725-3f6e4b428946@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 23, 2018 at 02:43:05PM +0300, Alexey Budankov escreveu:
> Hi Arnaldo,
> 
> On 09.10.2018 22:32, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Oct 09, 2018 at 05:36:24PM +0300, Alexey Budankov escreveu:
> >>
> >> Store -k clockid frequency into Perf trace to enable timestamps 
> >> derived metrics conversion into wall clock time on reporting stage.
> >>
> >> Below is the example of perf report output:
> > 
> > Applied, building, lets see this time.
> 
> Thanks for the effort. So far I assume the outstanding issues 
> were addressed. Is the patch still planned for coming release?

yep, its in my perf/core branch:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=cf7905165fee15fe26ac4a91ee0a35b966249430

I'll process some more patches from Adrian and Andi today, both making
use of Intel Xed, that seems to be installed ok now in my test machines,
and then send a pull req to Ingo,

Thanks,

- Arnaldo
