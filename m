Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752523AbeBHNzi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 08:55:38 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35330 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751343AbeBHNzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 08:55:36 -0500
Date: Thu, 8 Feb 2018 14:55:33 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: John Garry <john.garry@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        ak@linux.intel.com, wcohen@redhat.com, will.deacon@arm.com,
        ganapatrao.kulkarni@cavium.com, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangshaokun@hisilicon.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/9] perf utils: add support for arch standard events
Message-ID: <20180208135533.GI10234@krava>
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

>  
> +static int is_json_file(const char *name)
> +{
> +	const char *suffix;
> +
> +	if (strlen(name) < 5)
> +		return 0;
> +
> +	suffix = name + strlen(name) - 5;
> +
> +	if (strncmp(suffix, ".json", 5) == 0)
> +		return 1;
> +	return 0;
> +}
> +
> +static int preprocess_arch_std_files(const char *fpath, const struct stat *sb,
> +				int typeflag, struct FTW *ftwbuf)
> +{
> +	int level = ftwbuf->level;
> +	int is_file = typeflag == FTW_F;
> +
> +	if (level == 1 && is_file && is_json_file(fpath))
> +		return json_events(fpath, save_arch_std_events, (void *)sb);

so any .json file will pass.. just wondering you'd want to put
some name restriction for recomended events file like this -recomended
suffix you used later.. but that can be added later in case we'll
need some other json files in here ;-)

jirka
