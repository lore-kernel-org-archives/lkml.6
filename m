Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED87C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CCEC213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfBYMzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:55:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbfBYMzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:55:36 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0CC1881DE2;
        Mon, 25 Feb 2019 12:55:36 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5233919C56;
        Mon, 25 Feb 2019 12:55:34 +0000 (UTC)
Date:   Mon, 25 Feb 2019 13:55:33 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 06/11] perf tools report: Use less for scripts output
Message-ID: <20190225125533.GD19795@krava>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-7-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190224153722.27020-7-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 25 Feb 2019 12:55:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 07:37:17AM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The UI viewer for scripts output has a lot of limitations: limited size,
> no search or save function, slow, and various other issues.
> 
> Just use 'less' to display directly on the terminal instead.
> 
> This won't work in gtk mode, but gtk doesn't support these
> context menus anyways. If that is every done could use an terminal
> for the output.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/ui/browsers/scripts.c | 125 +++++--------------------------
>  1 file changed, 17 insertions(+), 108 deletions(-)

I like the stats ;-)

I assume some of the current includes can be removed as well:

#include <elf.h>
#include <inttypes.h>
#include <sys/ttydefaults.h>
#include <string.h>
#include "../../util/sort.h"
#include "../../util/util.h"
#include "../../util/hist.h"
#include "../../util/debug.h"
#include "../../util/symbol.h"
#include "../browser.h"
#include "../helpline.h"
#include "../libslang.h"

jirka
