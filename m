Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EE7C6778A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 02:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F51240BD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 02:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="x71r+AHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F51240BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753813AbeGFCBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 22:01:23 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44950 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753585AbeGFCBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 22:01:21 -0400
Received: by mail-qt0-f194.google.com with SMTP id b15-v6so8803378qtp.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 19:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=1CG1MQU8JpxBq+XMJXPuG4KQKl117aBZKypL0vI3v9w=;
        b=x71r+AHp6KCWFDMUP5K4PrLUUO/pDbNBud6bkII3XUnPr8avQil5cfZcbHCvMpM2D6
         HDrlgK8FnWPaK8jWyf9e8nXyhKLzivWjypukGy7dLTdVJdF4a5av2sGF9cLpkcHnR0oL
         gziEzG4Fqk2wfo9JV3/3B5ChzYa2mB81n+W1W1JohBHmLVknn85FFFDKyS9HHqSeTvWC
         pMp3GQTZoc3I3gAbmGNIcnGVVY8OrVyAAXqtqjnhdKM7N1HWdr5z/tIcaueii7YAGyqy
         TJyWFpVkLK5H+CJY7fbgcyegbBV0yS8dalnzQ5Uz1cmsLgORmjGLZ9cPtS0jx1rW/m0J
         gx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=1CG1MQU8JpxBq+XMJXPuG4KQKl117aBZKypL0vI3v9w=;
        b=EMViiQCChInHCTsNW/7pmbeQrUAhOEAsWNVUYCa7t3htm9LuTU9gvH0FR884ITNUfH
         SlZm7ugWagrwRgOJqy6FC8pP+GP4MnmsSQyBy9ekZkWLq7hcvAWoZBnyJ/vzZh6dtQ39
         2ZAQj2LE8kCTuMezm7/DRVBVvHTmY7DRcYRNhGynNde3abEuRMxts6YrhDkFaXKQXJqF
         Ofw6nySz6yEvYpKqQULfo+wVyEO7c/ComxllFN6rAPbS5UK+PRVEXdVFHdJsZdcEZWcf
         b7tIdLj6TOh3gSRjt8xdzuKqNphKkxhr/7DglTqWHF9mGEcDKtpVJ0UG/N52Q42Wr8lW
         nkLw==
X-Gm-Message-State: APt69E0ZDGXaG9ZzD+BeP6Hjd7C42EGCuxCdtpwJN/8Sj9CWDPRQd6Oy
        rCiJ6CT3ImgcAFgJIPY99Jy63orZ
X-Google-Smtp-Source: AAOMgpejZaDkGIko8luBrNN95iqkKoWIyoTrNwLeXlD7RwdL7y1btHwBTyzNsWitIuHZom+IEBuM6A==
X-Received: by 2002:ac8:1249:: with SMTP id g9-v6mr6667703qtj.134.1530842480844;
        Thu, 05 Jul 2018 19:01:20 -0700 (PDT)
Received: from cakuba.netronome.com ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id 4-v6sm5133362qtq.24.2018.07.05.19.01.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 19:01:20 -0700 (PDT)
Date:   Thu, 5 Jul 2018 19:01:16 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpftool: introduce cgroup tree command
Message-ID: <20180705190116.7737d66d@cakuba.netronome.com>
In-Reply-To: <20180706010521.23097-1-guro@fb.com>
References: <20180706010521.23097-1-guro@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jul 2018 18:05:20 -0700, Roman Gushchin wrote:
> This commit introduces a new bpftool command: cgroup tree.
> The idea is to iterate over the whole cgroup tree and print
> all attached programs.
> 
> I was debugging a bpf/systemd issue, and found, that there is
> no simple way to listen all bpf programs attached to cgroups.
> I did master something in bash, but after some time got tired of it,
> and decided, that adding a dedicated bpftool command could be
> a better idea.
> 
> So, here it is:
>   $ sudo ./bpftool cgroup tree
>   CgroupPath
>   ID       AttachType      AttachFlags     Name
>   /sys/fs/cgroup/system.slice/systemd-machined.service
>       18       ingress
>       17       egress
>   /sys/fs/cgroup/system.slice/systemd-logind.service
>       20       ingress
>       19       egress
>   /sys/fs/cgroup/system.slice/systemd-udevd.service
>       16       ingress
>       15       egress
>   /sys/fs/cgroup/system.slice/systemd-journald.service
>       14       ingress
>       13       egress
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> Cc: Quentin Monnet <quentin.monnet@netronome.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@kernel.org>

Looks very useful!  Minor nits/questions below.  I think the reverse
mapping could also be interesting - similar to how -f flag shows where
program is pinned, we could add a flag which in 

# bpftool prog show/list

adds info about cgroups where the program is attached?  Obviously as a
future extension.

> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> index 16bee011e16c..125d5b6db568 100644
> --- a/tools/bpf/bpftool/cgroup.c
> +++ b/tools/bpf/bpftool/cgroup.c
> @@ -2,7 +2,12 @@
>  // Copyright (C) 2017 Facebook
>  // Author: Roman Gushchin <guro@fb.com>
>  
> +#define _XOPEN_SOURCE 500
> +#include <errno.h>
>  #include <fcntl.h>
> +#include <ftw.h>
> +#include <mntent.h>
> +#include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <sys/stat.h>
> @@ -53,7 +58,8 @@ static enum bpf_attach_type parse_attach_type(const char *str)
>  }
>  
>  static int show_bpf_prog(int id, const char *attach_type_str,
> -			 const char *attach_flags_str)
> +			 const char *attach_flags_str,
> +			 int level)
>  {
>  	struct bpf_prog_info info = {};
>  	__u32 info_len = sizeof(info);
> @@ -78,7 +84,8 @@ static int show_bpf_prog(int id, const char *attach_type_str,
>  		jsonw_string_field(json_wtr, "name", info.name);
>  		jsonw_end_object(json_wtr);
>  	} else {
> -		printf("%-8u %-15s %-15s %-15s\n", info.id,
> +		printf("%s%-8u %-15s %-15s %-15s\n", level ? "    " : "",
> +		       info.id,
>  		       attach_type_str,
>  		       attach_flags_str,
>  		       info.name);
> @@ -88,7 +95,20 @@ static int show_bpf_prog(int id, const char *attach_type_str,
>  	return 0;
>  }
>  
> -static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type)
> +static int count_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type)
> +{
> +	__u32 prog_cnt = 0;
> +	int ret;
> +
> +	ret = bpf_prog_query(cgroup_fd, type, 0, NULL, NULL, &prog_cnt);
> +	if (ret)
> +		return -1;
> +
> +	return prog_cnt;
> +}
> +
> +static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
> +				   int level)
>  {
>  	__u32 prog_ids[1024] = {0};
>  	char *attach_flags_str;
> @@ -123,7 +143,7 @@ static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type)
>  
>  	for (iter = 0; iter < prog_cnt; iter++)
>  		show_bpf_prog(prog_ids[iter], attach_type_strings[type],
> -			      attach_flags_str);
> +			      attach_flags_str, level);
>  
>  	return 0;
>  }
> @@ -161,7 +181,7 @@ static int do_show(int argc, char **argv)
>  		 * If we were able to get the show for at least one
>  		 * attach type, let's return 0.
>  		 */
> -		if (show_attached_bpf_progs(cgroup_fd, type) == 0)
> +		if (show_attached_bpf_progs(cgroup_fd, type, 0) == 0)
>  			ret = 0;
>  	}
>  
> @@ -173,6 +193,123 @@ static int do_show(int argc, char **argv)
>  	return ret;
>  }
>  
> +static int do_show_tree_fn(const char *fpath, const struct stat *sb,
> +			   int typeflag, struct FTW *ftw)
> +{
> +	enum bpf_attach_type type;
> +	bool skip = true;
> +	int cgroup_fd;
> +
> +	if (typeflag != FTW_D)
> +		return 0;
> +
> +	cgroup_fd = open(fpath, O_RDONLY);
> +	if (cgroup_fd < 0) {
> +		p_err("can't open cgroup %s: %s", fpath, strerror(errno));
> +		return -1;
> +	}
> +
> +	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
> +		int count = count_attached_bpf_progs(cgroup_fd, type);
> +
> +		if (count < 0 && errno != EINVAL) {
> +			p_err("can't query bpf programs attached to %s: %s",
> +			      fpath, strerror(errno));
> +			close(cgroup_fd);
> +			return -1;
> +		}
> +		if (count > 0) {
> +			skip = false;
> +			break;
> +		}
> +	}
> +
> +	if (skip) {
> +		close(cgroup_fd);
> +		return 0;
> +	}
> +
> +	if (json_output) {
> +		jsonw_start_object(json_wtr);
> +		jsonw_string_field(json_wtr, "cgroup", fpath);
> +		jsonw_name(json_wtr, "programs");
> +		jsonw_start_array(json_wtr);
> +	} else {
> +		printf("%s\n", fpath);
> +	}
> +
> +	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++)
> +		show_attached_bpf_progs(cgroup_fd, type, ftw->level);
> +
> +	if (json_output) {
> +		jsonw_end_array(json_wtr);
> +		jsonw_end_object(json_wtr);
> +	}
> +
> +	close(cgroup_fd);
> +
> +	return 0;
> +}
> +
> +static char *find_cgroup_root(void)
> +{
> +	struct mntent *mnt;
> +	FILE *f;
> +
> +	f = fopen("/proc/mounts", "r");
> +	if (f == NULL)
> +		return NULL;
> +
> +	while ((mnt = getmntent(f))) {
> +		if (strcmp(mnt->mnt_type, "cgroup2") == 0) {
> +			fclose(f);
> +			return strdup(mnt->mnt_dir);

FWIW you don't free this memory.

> +		}
> +	}
> +
> +	fclose(f);
> +	return NULL;
> +}
> +
> +static int do_show_tree(int argc, char **argv)
> +{
> +	char *cgroup_root;
> +	int ret;
> +
> +	if (argc > 1) {
> +		p_err("too many parameters for cgroup tree");
> +		return -1;
> +	}
> +
> +	if (argc == 1) {
> +		cgroup_root = argv[0];
> +	} else {
> +		cgroup_root = find_cgroup_root();
> +
> +		if (!cgroup_root) {
> +			p_err("cgroup v2 isn't mounted");
> +			return -1;
> +		}
> +	}
> +
> +	if (json_output)
> +		jsonw_start_array(json_wtr);
> +	else
> +		printf("%s\n"
> +		       "%-8s %-15s %-15s %-15s\n",
> +		       "CgroupPath",
> +		       "ID", "AttachType", "AttachFlags", "Name");
> +
> +	ret = nftw(cgroup_root, do_show_tree_fn, 1024, FTW_MOUNT);
> +	if (ret && errno == ENOENT)
> +		p_err("can't iterate over %s: %s", cgroup_root,
> +		      strerror(errno));

I'm worried this could lead to a duplicated error in JSON output, no?
Is it possible that do_show_tree_fn() would have already printed an
error?

> +
> +	if (json_output)
> +		jsonw_end_array(json_wtr);
> +
> +	return ret;
> +}
> +
>  static int do_attach(int argc, char **argv)
>  {
>  	enum bpf_attach_type attach_type;
> @@ -289,6 +426,7 @@ static int do_help(int argc, char **argv)
>  
>  	fprintf(stderr,
>  		"Usage: %s %s { show | list } CGROUP\n"
> +		"       %s %s tree [CGROUP_ROOT]\n"
>  		"       %s %s attach CGROUP ATTACH_TYPE PROG [ATTACH_FLAGS]\n"
>  		"       %s %s detach CGROUP ATTACH_TYPE PROG\n"
>  		"       %s %s help\n"
> @@ -298,6 +436,7 @@ static int do_help(int argc, char **argv)
>  		"       " HELP_SPEC_PROGRAM "\n"
>  		"       " HELP_SPEC_OPTIONS "\n"
>  		"",
> +		bin_name, argv[-2],
>  		bin_name, argv[-2], bin_name, argv[-2],
>  		bin_name, argv[-2], bin_name, argv[-2]);
>  
> @@ -307,6 +446,7 @@ static int do_help(int argc, char **argv)
>  static const struct cmd cmds[] = {
>  	{ "show",	do_show },
>  	{ "list",	do_show },
> +	{ "tree",       do_show_tree },
>  	{ "attach",	do_attach },
>  	{ "detach",	do_detach },
>  	{ "help",	do_help },

Could you please also add this new command to bash completions?  It
should be fairly trivial to handle.
