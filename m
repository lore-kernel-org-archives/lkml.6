Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B9EC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C046B22BE8
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="zivX/Vtd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C046B22BE8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934428AbeGFVBU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:01:20 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:40184 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933982AbeGFVBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:01:18 -0400
Received: by mail-qk0-f195.google.com with SMTP id b129-v6so6998069qke.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 14:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=g+89KdBFybMmaBX5zLpQi8xdiV1/vtpHgjUiDssHV7Y=;
        b=zivX/VtdH+h6mqycw8ao4K17J5GBdDXKIq/nia1kBF/rYVlCOI77+i9LJRf3BRQLyQ
         hOJkZs8tAw6QdfODgNHclbaj5OTCo7c6XV6s77OIMIb5Ou6/twyGn5jtko9oboxMFR8k
         BGCLxJamdG4KnaHVM+3LyplfsAXG/6uzZ+EmWuCmZiggzqaMFPKXMZUbx/+GLMD30Bpr
         Dn5tvTeYa3uTUM7bYq4Xl3CNnvkzmT1IccV754a42KIiRFwDh9oc7VYCQ34dKiuJm5gS
         rNSbq/DKx6CFMxCVYE28SeeyBJi9Fnpvo3mY7ynP2gjssHBZE1Q7dReqks4slIeeOGkz
         tLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=g+89KdBFybMmaBX5zLpQi8xdiV1/vtpHgjUiDssHV7Y=;
        b=RYGnkHPfJZMRJCN/HJRo5EHm2IoW6TJ6qxCgvHsXZ5Bniyrec+pGNA0cubmdpGJTN4
         gcXRPtKrfmmFozG3Q51LLF6UHn0VNXVXfddGuzRmLrW/PWdojiW1BwJJawDVPkAEk5Mm
         RKHkV13S/HkSGOMEKo2cFxPYQ1jvI1w1GedsfGzMjWVcN7DfcVJOhW8pDQNoI66x8qg7
         fyrC0k4LV4f44CcIKN7j+iR4UE+jr4NpBypF6GODJ//OGGFndmDV8iPXFYlqLh2rLPzX
         ujlB8t7SZh3iOaNU3egyHLzigMujhdS6oLcqxWDECoFRU5soqGrqxXvYNlsdn/GZ/FwS
         JTJQ==
X-Gm-Message-State: APt69E0I5bA0d1noYwirbsRxMYm4whD787J0sw6MkNZZWlXVkhCUA/nb
        AI3LEr2s2VMNukTrvu2BgdqGDw==
X-Google-Smtp-Source: AAOMgpdLsLrWD+a2km9VMf5oM9wzLY6EFOM2kExvPZiSB9tAeSd3+SWpX4Gf1HwKt71yB9L7X7eUbw==
X-Received: by 2002:a37:6142:: with SMTP id v63-v6mr10259942qkb.418.1530910877642;
        Fri, 06 Jul 2018 14:01:17 -0700 (PDT)
Received: from cakuba.netronome.com ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id y187-v6sm5871128qkd.32.2018.07.06.14.01.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 14:01:17 -0700 (PDT)
Date:   Fri, 6 Jul 2018 14:01:14 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v2 bpf-next 1/3] bpftool: introduce cgroup tree command
Message-ID: <20180706140114.2f74ff26@cakuba.netronome.com>
In-Reply-To: <20180706183012.6475-1-guro@fb.com>
References: <20180706183012.6475-1-guro@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2018 11:30:10 -0700, Roman Gushchin wrote:
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

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
