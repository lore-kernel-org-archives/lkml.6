Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC826C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968BF2084F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 968BF2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387575AbeKFF4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:56:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbeKFF4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:56:16 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 56B20308FB95;
        Mon,  5 Nov 2018 20:34:50 +0000 (UTC)
Received: from krava (ovpn-204-79.brq.redhat.com [10.40.204.79])
        by smtp.corp.redhat.com (Postfix) with SMTP id 63C315D70A;
        Mon,  5 Nov 2018 20:34:48 +0000 (UTC)
Date:   Mon, 5 Nov 2018 21:34:47 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        jolsa@kernel.org
Subject: Re: [PATCH RFC] hist lookups
Message-ID: <20181105203447.GA25674@krava>
References: <20181031.090816.2117345408719881030.davem@davemloft.net>
 <20181102.233003.1814045087128749000.davem@davemloft.net>
 <20181104201821.GA22049@krava>
 <20181104.165039.878682622135788379.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181104.165039.878682622135788379.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 05 Nov 2018 20:34:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2018 at 04:50:39PM -0800, David Miller wrote:
> From: Jiri Olsa <jolsa@redhat.com>
> Date: Sun, 4 Nov 2018 21:18:21 +0100
> 
> > do you have some code I could check on?
> 
> All I have is this patch which parallelizes the mmap readers in perf
> top.

I put something together.. still testing, but it's already
showing 0 lost events when for 'overwrite = 0' case even
for high load.. the old code shows ~1500 for same workload

I'm printing lost event counts in stdio output header:

  # perf top -d 1 --stdio
     PerfTop:    5734 irqs/sec  kernel:57.3%  exact: 100.0% lost: 0 [4000Hz cycles:ppp],  (all, 8 CPUs)

will probably add it to tui as well, seems useful

I pushed it in perf/fixes branch in:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git

it's stil work in prograss.. not too manye complete changelogs ;-)

jirka
