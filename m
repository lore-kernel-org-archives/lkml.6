Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeBHNyg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 08:54:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35230 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752281AbeBHNyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 08:54:33 -0500
Date: Thu, 8 Feb 2018 14:54:30 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: John Garry <john.garry@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        ak@linux.intel.com, wcohen@redhat.com, will.deacon@arm.com,
        ganapatrao.kulkarni@cavium.com, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangshaokun@hisilicon.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/9] perf utils: add support for arch standard events
Message-ID: <20180208135430.GD10234@krava>
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

> @@ -940,6 +1090,7 @@ int main(int argc, char *argv[])
>  	const char *output_file;
>  	const char *start_dirname;
>  	struct stat stbuf;
> +	struct event_struct *es1, *es2;
>  
>  	prog = basename(argv[0]);
>  	if (argc < 4) {
> @@ -984,17 +1135,28 @@ int main(int argc, char *argv[])
>  
>  	maxfds = get_maxfds();
>  	mapfile = NULL;
> +	rc = nftw(ldirname, preprocess_arch_std_files, get_maxfds(), 0);

you could use maxfds variable in here

jirka
