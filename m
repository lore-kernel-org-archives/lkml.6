Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A295C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D08213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfBYM4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:56:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbfBYM4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:56:18 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 571D459448;
        Mon, 25 Feb 2019 12:56:18 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id A3DC15D9D1;
        Mon, 25 Feb 2019 12:56:16 +0000 (UTC)
Date:   Mon, 25 Feb 2019 13:56:15 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 11/11] perf tools report: Implement browsing of
 individual samples
Message-ID: <20190225125615.GI19795@krava>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-12-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190224153722.27020-12-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 25 Feb 2019 12:56:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 07:37:22AM -0800, Andi Kleen wrote:

SNIP

> +static void hists__res_sample(struct hist_entry *he, struct perf_sample *sample)
> +{
> +	struct res_sample *r;
> +	int j;
> +
> +	if (!he->res_samples) {
> +		he->res_samples = calloc(sizeof(struct res_sample),
> +					symbol_conf.res_sample);
> +		if (!he->res_samples)
> +			return;
> +	}
> +	if (he->num_res < symbol_conf.res_sample) {
> +		j = he->num_res++;
> +	} else {
> +		j = random_max(++he->num_res + 1);

will he->num_res keep raising all the time?

jirka

> +		if (he->num_res > symbol_conf.res_sample)
> +			return;
> +	}
> +	r = &he->res_samples[j];
> +	r->time = sample->time;
> +	r->cpu = sample->cpu;
> +	r->tid = sample->tid;
> +}
> +


SNIP
