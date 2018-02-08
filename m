Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752268AbeBHNyb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 08:54:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35210 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752026AbeBHNy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 08:54:26 -0500
Date: Thu, 8 Feb 2018 14:54:23 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: John Garry <john.garry@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        ak@linux.intel.com, wcohen@redhat.com, will.deacon@arm.com,
        ganapatrao.kulkarni@cavium.com, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangshaokun@hisilicon.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/9] perf utils: add support for arch standard events
Message-ID: <20180208135423.GC10234@krava>
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

>  static void print_events_table_suffix(FILE *outfp)
>  {
>  	fprintf(outfp, "{\n");
> @@ -407,6 +469,52 @@ static char *real_event(const char *name, char *event)
>  	return event;
>  }
>  
> +static void fixup_field(char *from, char **to)
> +{
> +	*to = malloc(strlen(from));
> +
> +	strcpy(*to, from);
> +}

could you just call '*to = strdup(from)' in here?

jirka
