Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752779AbeCWMRD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 08:17:03 -0400
Received: from omr-a003e.mx.aol.com ([204.29.186.57]:63019 "EHLO
        omr-a003e.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752706AbeCWMRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 08:17:00 -0400
Subject: Re: [PATCH RESEND] perf annotate: Don't prepend symfs path to
 build_id_filename
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180313135618.2900-1-jpmv27@aim.com>
From: Martin Vuille <jpmv27@aim.com>
Message-ID: <3f18ff8d-ef93-a48c-2f27-c8780edc1bf7@aim.com>
Date: Fri, 23 Mar 2018 08:16:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180313135618.2900-1-jpmv27@aim.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
x-aol-global-disposition: G
x-aol-sid: 3039ac1a856d5ab4f03a4576
X-AOL-IP: 99.246.128.134
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?


On 03/13/18 09:56, Martin Vuille wrote:
> build_id_filename already contains symfs path if applicable, so
> don't prepend it a second time.
>
> - dso__build_id_filename calls build_id_cache__linkname
> - build_id_cache__linkname uses buildid_dir
> - when symfs option is specified, symbol__config_symfs sets
>    buildid_dir to include the symfs directory
>
> Signed-off-by: Martin Vuille <jpmv27@aim.com>
> ---
>   tools/perf/util/annotate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 007170efa014..0b78cc4fb155 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1381,7 +1381,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
>   
>   	build_id_filename = dso__build_id_filename(dso, NULL, 0, false);
>   	if (build_id_filename) {
> -		__symbol__join_symfs(filename, filename_size, build_id_filename);
> +		scnprintf(filename, filename_size, "%s", build_id_filename);
>   		free(build_id_filename);
>   	} else {
>   		if (dso->has_build_id)
