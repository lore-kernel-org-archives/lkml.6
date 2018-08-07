Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAFEC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D14D21723
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D14D21723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbeHHBTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 21:19:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726697AbeHHBTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 21:19:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9FA897721C;
        Tue,  7 Aug 2018 23:03:04 +0000 (UTC)
Received: from krava (ovpn-204-19.brq.redhat.com [10.40.204.19])
        by smtp.corp.redhat.com (Postfix) with SMTP id AA04A10CD853;
        Tue,  7 Aug 2018 23:03:02 +0000 (UTC)
Date:   Wed, 8 Aug 2018 01:03:01 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2] perf map: optimize maps__fixup_overlappings()
Message-ID: <20180807230301.GA20320@krava>
References: <153363294565.396323.4605638589903548668.stgit@buzz>
 <153365189407.435244.7234821822450484712.stgit@buzz>
 <20180807200237.GA5395@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807200237.GA5395@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 07 Aug 2018 23:03:04 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 07 Aug 2018 23:03:04 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 05:02:37PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Aug 07, 2018 at 05:24:54PM +0300, Konstantin Khlebnikov escreveu:
> > This function splits and removes overlapping areas.
> > 
> > Maps in tree are ordered by start address thus we could find
> > first overlap and stop if next map does not overlap.
> > 
> > Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> 
> Jiri, I'm applying this one with your Acked-by, ok?

yep, sry.. overlooked this

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
