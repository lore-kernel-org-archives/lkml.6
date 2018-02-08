Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeBHNyW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 08:54:22 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33368 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752026AbeBHNyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 08:54:19 -0500
Date: Thu, 8 Feb 2018 14:54:16 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: John Garry <john.garry@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        ak@linux.intel.com, wcohen@redhat.com, will.deacon@arm.com,
        ganapatrao.kulkarni@cavium.com, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangshaokun@hisilicon.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/9] perf utils: add support for arch standard events
Message-ID: <20180208135416.GB10234@krava>
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

> @@ -366,6 +367,67 @@ static int print_events_table_entry(void *data, char *name, char *event,
>  	return 0;
>  }
>  
> +struct event_struct {
> +	char *name;
> +	char *event;
> +	char *desc;
> +	char *long_desc;
> +	char *pmu;
> +	char *filter;
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

please indent the code in macro like normal code

thanks,
jirka
