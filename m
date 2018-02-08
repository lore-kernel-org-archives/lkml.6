Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbeBHNyP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 08:54:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55858 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752013AbeBHNyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 08:54:13 -0500
Date: Thu, 8 Feb 2018 14:54:09 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: John Garry <john.garry@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        ak@linux.intel.com, wcohen@redhat.com, will.deacon@arm.com,
        ganapatrao.kulkarni@cavium.com, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangshaokun@hisilicon.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/9] perf utils: add support for arch standard events
Message-ID: <20180208135409.GA10234@krava>
References: <1517939104-230881-1-git-send-email-john.garry@huawei.com>
 <1517939104-230881-6-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517939104-230881-6-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 01:45:00AM +0800, John Garry wrote:

SNIP

> +static void fixup_field(char *from, char **to)
> +{
> +	*to = malloc(strlen(from));
> +
> +	strcpy(*to, from);
> +}
> +
> +#define EVENT_PREFIX "event="
> +
> +#define TRY_FIXUP_FIELD(string)	do { if (es->string && !*string)\
> +			fixup_field(es->string, string);	\
> +} while (0)

please indent the code in the macro like normal code

> +
> +static int
> +try_fixup(const char *fn, char *arch_std, char **event, char **desc,
> +	  char **name, char **long_desc, char **pmu, char **filter,
> +	  char **perpkg, char **unit, char **metric_expr, char **metric_name,
> +	  char **metric_group)
> +{
> +	/* try to find matching event from arch standard values */
> +	struct event_struct *es;
> +
> +	list_for_each_entry(es, &arch_std_events, list) {
> +		if (!strcmp(arch_std, es->event+strlen(EVENT_PREFIX))) {

you could use just sizeof(EVENT_PREFIX). no need to call strlen

jirka
