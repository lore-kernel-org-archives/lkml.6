Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CB6C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DA720847
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04DA720847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388911AbeHGO5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 10:57:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387789AbeHGO5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 10:57:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4ACE58197001;
        Tue,  7 Aug 2018 12:43:36 +0000 (UTC)
Received: from krava (unknown [10.43.17.214])
        by smtp.corp.redhat.com (Postfix) with SMTP id F1A4F2166BA0;
        Tue,  7 Aug 2018 12:43:34 +0000 (UTC)
Date:   Tue, 7 Aug 2018 14:43:34 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 1/2] perf map: synthesize maps only for thread group
 leader
Message-ID: <20180807124334.GD7716@krava>
References: <153363294102.396323.6277944760215058174.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153363294102.396323.6277944760215058174.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 07 Aug 2018 12:43:36 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 07 Aug 2018 12:43:36 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 12:09:01PM +0300, Konstantin Khlebnikov wrote:
> Threads share map_groups, all map events are merged into it.
> 
> Thus we could send mmaps only for thread group leader.
> Otherwise it took ages to attach and record something from
> processes with many vmas and threads.
> 
> Thread group leader could be already dead,
> but it seems perf cannot handle this case anyway.

nice, could mention in the changelog that we actualy
synthesize the group leader (if we found one) for the
thread even if it's not present in the thread_map,
so the process maps are always in data

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
