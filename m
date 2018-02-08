Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752483AbeBHNzR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 08:55:17 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752448AbeBHNzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 08:55:15 -0500
Date: Thu, 8 Feb 2018 14:55:12 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: John Garry <john.garry@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        ak@linux.intel.com, wcohen@redhat.com, will.deacon@arm.com,
        ganapatrao.kulkarni@cavium.com, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangshaokun@hisilicon.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/9] perf utils: add support for arch standard events
Message-ID: <20180208135512.GG10234@krava>
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

> +	char *perpkg;
> +	char *unit;
> +	char *metric_expr;
> +	char *metric_name;
> +	char *metric_group;
> +	struct list_head list;
> +	char strings[];
> +};
> +
> +static LIST_HEAD(arch_std_events);
> +
> +#define ADD_EVENT_STRING(string) do { if (string) {		\
> +	es->string = strings;					\
> +	strings += snprintf(strings, len, "%s", string) + 1;	\
> +} } while (0)
> +
> +static int save_arch_std_events(void *data, char *name, char *event,
> +				char *desc, char *long_desc, char *pmu,
> +				char *unit, char *perpkg, char *metric_expr,
> +				char *metric_name, char *metric_group)
> +{
> +	struct event_struct *es;
> +	struct stat *sb = data;
> +	int len;
> +	char *strings;
> +
> +	/*
> +	 * Lazily allocate size of the json file to hold the
> +	 * strings, which would be more than large enough.
> +	 */
> +	len = sb->st_size;
> +
> +	es = malloc(sizeof(*es) + len);

hum, so for single event you allocate buffer of the size
of the entire file this event is defined in?

what do I miss? I assume there're more of those arch-defined
events defined in the single file..

jirka
