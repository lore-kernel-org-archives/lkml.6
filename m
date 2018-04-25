Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeDYVEA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 17:04:00 -0400
Received: from mx3.wp.pl ([212.77.101.9]:48209 "EHLO mx3.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752069AbeDYVDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 17:03:55 -0400
Date: Wed, 25 Apr 2018 14:03:46 -0700
From: Jakub Kicinski <kubakici@wp.pl>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: Re: [PATCH 3/3] tools bpftool: Display license GPL compatible in
 prog show/list
Message-ID: <20180425140346.3e0f3ba7@cakuba.netronome.com>
In-Reply-To: <20180425174108.6586-4-jolsa@kernel.org>
References: <20180425174108.6586-1-jolsa@kernel.org>
        <20180425174108.6586-4-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-WP-MailID: 4fb8c18aa229017f40615e12af7c9dc1
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [QYME]                               
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2018 19:41:08 +0200, Jiri Olsa wrote:
> @@ -295,6 +297,7 @@ static void print_prog_plain(struct bpf_prog_info *info, int fd)
>  	printf("tag ");
>  	fprint_hex(stdout, info->tag, BPF_TAG_SIZE, "");
>  	print_dev_plain(info->ifindex, info->netns_dev, info->netns_ino);
> +	printf(" license GPL %scompatible", info->gpl_compatible ? "" : "NON ");

3 nit picks:

Other "fields" are separated by two spaces between each other:

  4: kprobe  name func_begin  tag 57cd311f2e27366b license GPL compatible
           ^^               ^^                    X
          loaded_at Apr 25/11:20  uid 0
                                ^^
          xlated 16B  not jited  memlock 4096B
                    ^^         ^^

Could you also update the example outputs in the man page:

tools/bpf/bpftool/Documentation/bpftool-prog.rst

Sorry about the bike shedding but I would also vote for:

"[not] GPL compatible"

rather than

"license GPL [NON] compatible"

for brevity..
