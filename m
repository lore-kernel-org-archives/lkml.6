Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C08C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9542146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfBYM4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:56:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56070 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbfBYM4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:56:31 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C65593001709;
        Mon, 25 Feb 2019 12:56:31 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1C4145D71A;
        Mon, 25 Feb 2019 12:56:29 +0000 (UTC)
Date:   Mon, 25 Feb 2019 13:56:28 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 11/11] perf tools report: Implement browsing of
 individual samples
Message-ID: <20190225125628.GK19795@krava>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-12-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190224153722.27020-12-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 25 Feb 2019 12:56:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 07:37:22AM -0800, Andi Kleen wrote:

SNIP

>  static int
>  do_switch_data(struct hist_browser *browser __maybe_unused,
>  	       struct popup_action *act __maybe_unused)
> @@ -3115,6 +3150,18 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
>  		}
>  		nr_options += add_script_opt(browser, &actions[nr_options],
>  					     &options[nr_options], NULL, NULL, evsel);
> +		nr_options += add_res_sample_opt(browser, &actions[nr_options],
> +						 &options[nr_options],
> +				 hist_browser__selected_entry(browser)->res_samples,
> +				 evsel, A_NORMAL);
> +		nr_options += add_res_sample_opt(browser, &actions[nr_options],
> +						 &options[nr_options],
> +				 hist_browser__selected_entry(browser)->res_samples,
> +				 evsel, A_ASM);
> +		nr_options += add_res_sample_opt(browser, &actions[nr_options],
> +						 &options[nr_options],
> +				 hist_browser__selected_entry(browser)->res_samples,
> +				 evsel, A_SOURCE);
>  		nr_options += add_switch_opt(browser, &actions[nr_options],
>  					     &options[nr_options]);

for some reason can't see those items in menu

jirka
