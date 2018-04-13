Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754064AbeDMM6H (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 08:58:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751024AbeDMM6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 08:58:06 -0400
Date: Fri, 13 Apr 2018 14:58:01 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: acme@redhat.com, mhiramat@kernel.org, kstewart@linuxfoundation.org,
        tglx@linutronix.de, pombredanne@nexb.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        uneedsihyeon@gmail.com, kjlx@templeofstupid.com
Subject: Re: [PATCH 2/3] perf/buildid-cache: Support --list option
Message-ID: <20180413125801.GG28241@krava>
References: <20180409110633.20767-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180409110633.20767-3-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409110633.20767-3-ravi.bangoria@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 04:36:32PM +0530, Ravi Bangoria wrote:

SNIP

> -		     !remove_name_list_str && !purge_name_list_str &&
> -		     !missing_filename && !update_name_list_str))
> +	opts_flag = add_name_list_str || kcore_filename ||
> +		remove_name_list_str || purge_name_list_str ||
> +		missing_filename || update_name_list_str;
> +
> +	if (argc || !(list_files || opts_flag))
>  		usage_with_options(buildid_cache_usage, buildid_cache_options);
>  
> +	/* -l is exclusive. It can not be used with other options. */
> +	if (list_files && opts_flag)
> +		usage_with_options_msg(buildid_cache_usage,
> +			buildid_cache_options, "-l is exclusive.\n");
> +
>  	if (ns_id > 0)
>  		nsi = nsinfo__new(ns_id);
>  
> @@ -366,6 +396,11 @@ int cmd_buildid_cache(int argc, const char **argv)
>  
>  	setup_pager();
>  
> +	if (list_files) {
> +		build_id_cache__show_all();
> +		goto out;

make build_id_cache__show_all return value and store it to ret before going out

jirka
