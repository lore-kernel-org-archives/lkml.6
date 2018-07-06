Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D147EC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D4522B4B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D4522B4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933535AbeGFXkv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 19:40:51 -0400
Received: from www62.your-server.de ([213.133.104.62]:60367 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932992AbeGFXku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 19:40:50 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fbaLI-00085x-BC; Sat, 07 Jul 2018 01:40:48 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fbaLI-00016u-6D; Sat, 07 Jul 2018 01:40:48 +0200
Subject: Re: [PATCH v3 bpf-next 1/3] bpftool: introduce cgroup tree command
To:     Roman Gushchin <guro@fb.com>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>
References: <20180706212816.3760-1-guro@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2cc264ac-d1c2-7d98-a0f1-72f11d70b167@iogearbox.net>
Date:   Sat, 7 Jul 2018 01:40:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180706212816.3760-1-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24729/Fri Jul  6 22:46:13 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2018 11:28 PM, Roman Gushchin wrote:
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
> Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> Cc: Quentin Monnet <quentin.monnet@netronome.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@kernel.org>

Very useful! Applied to bpf-next, thanks everyone!
