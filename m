Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BFAC26640
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580692085A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfATSSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 13:18:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727310AbfATSSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 13:18:17 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 99ED885362;
        Sun, 20 Jan 2019 18:18:17 +0000 (UTC)
Received: from krava (ovpn-204-22.brq.redhat.com [10.40.204.22])
        by smtp.corp.redhat.com (Postfix) with SMTP id 694E0179E9;
        Sun, 20 Jan 2019 18:18:15 +0000 (UTC)
Date:   Sun, 20 Jan 2019 19:18:14 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCHv2 1/3] perf report: Display s390 diagnostic counter sets
Message-ID: <20190120181814.GB8591@krava>
References: <20190117093003.96287-1-tmricht@linux.ibm.com>
 <20190117093003.96287-2-tmricht@linux.ibm.com>
 <20190117140053.GJ11922@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117140053.GJ11922@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Sun, 20 Jan 2019 18:18:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 11:00:53AM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> --- a/tools/perf/util/python-ext-sources
> +++ b/tools/perf/util/python-ext-sources
> @@ -25,6 +25,7 @@ util/parse-branch-options.c
>  util/rblist.c
>  util/counts.c
>  util/print_binary.c
> +util/s390-sample-raw.c
>  util/strlist.c
>  util/trace-event.c
>  ../lib/rbtree.c

hi,
this change breaks the python module:

  >>> import perf
  Traceback (most recent call last):
    File "<stdin>", line 1, in <module>
  ImportError: ./perf.so: undefined symbol: color_fprintf

changelog doesn't say anything about python related change

jirka
