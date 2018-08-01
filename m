Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13E8C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3D420844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="bPdWNxSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3D420844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390389AbeHATex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:34:53 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34067 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389959AbeHATew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:34:52 -0400
Received: by mail-qt0-f195.google.com with SMTP id m13-v6so20848912qth.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d+PBr8yO/t0mYb/vcUiOOS5iptLMm0cqwwE8LlY3BE0=;
        b=bPdWNxSXI+0vCy+e3+jWmRP2+l7U45EmvX3FrwuNItgHBLyfoaaKgR/hyawLZGlhq4
         OvkKkdXVeAGTiT+wYiq86Pv4qwfKrB5T0HVNueXQP40p5S7oopeG+zT1blQCYkeylhUd
         aiMtfoKmoyRG3Q5dHTpNQcy9OYXSEhW5tIbqYR6uutvi9nFRuNhLX7RxtmJNfv8qNT81
         LuyhrvFGELK1doY9nmiEy0VNXIrLucQDpFIOXUaEI0LRj/dtW9i2akaRLu2UgQlfQsqf
         tuMQnxs4tC9c4AXC4VXOQ1c0ioGzpwvQw/ZW/MDlqDflHGm5kkaqiSheIzQYy487BX9C
         Wytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d+PBr8yO/t0mYb/vcUiOOS5iptLMm0cqwwE8LlY3BE0=;
        b=Iw8vNEGJVqjJ3tqMt7xII6ICbm+rERZObp/v7ibiJRvNZ/sHNdfwwc4M+P20Z04Yfl
         ayoDIFBOEmmzZHjS5ZDCIfKEBDiFVyPXcONnblVZqfqirDQXWy0NSGncO/NM7WLA6BQ5
         DFjcGlHDJ1aGbJpcw0kfqD+wCGEQBZP6vXMtSXsKy7O1ceFN/xH1Q9VRJD2mIrw/Gpph
         3tVrb5A8wHvDl76Fl/YlhlKjW1zbgTRi0XBsSxDDjrRogyJ0BssMqNn8GYKMRfyXDUBY
         2u6ezv2iRW6Wjp49gFEUUjMWwpO0tHdfGMPI+CBKhCzOiD/cYD8BDnit8QYNiP+WfSSi
         3Fsw==
X-Gm-Message-State: AOUpUlHgakJ3atTFeIiw6e70QTu8yI+O94HknnnUQuH2TOQYKN+tX9E5
        KxGNoCaLShB6GLhGBjj9GRahQQ==
X-Google-Smtp-Source: AAOMgpdNF8jJFmONtxfMgl7nU33AVvwHi2J+1fq2IwxiaLnomKlrBTUcWn+uzRca/LnNa7HyQpHNBw==
X-Received: by 2002:ac8:fdc:: with SMTP id f28-v6mr21158125qtk.63.1533145683495;
        Wed, 01 Aug 2018 10:48:03 -0700 (PDT)
Received: from localhost (216.49.36.201.res-cmts.bus.ptd.net. [216.49.36.201])
        by smtp.gmail.com with ESMTPSA id l5-v6sm11097189qte.20.2018.08.01.10.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 10:48:02 -0700 (PDT)
Date:   Wed, 1 Aug 2018 13:50:57 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm, oom: introduce memory.oom.group
Message-ID: <20180801175057.GD11386@cmpxchg.org>
References: <20180730180100.25079-1-guro@fb.com>
 <20180730180100.25079-4-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730180100.25079-4-guro@fb.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 11:01:00AM -0700, Roman Gushchin wrote:
> For some workloads an intervention from the OOM killer
> can be painful. Killing a random task can bring
> the workload into an inconsistent state.
> 
> Historically, there are two common solutions for this
> problem:
> 1) enabling panic_on_oom,
> 2) using a userspace daemon to monitor OOMs and kill
>    all outstanding processes.
> 
> Both approaches have their downsides:
> rebooting on each OOM is an obvious waste of capacity,
> and handling all in userspace is tricky and requires
> a userspace agent, which will monitor all cgroups
> for OOMs.
> 
> In most cases an in-kernel after-OOM cleaning-up
> mechanism can eliminate the necessity of enabling
> panic_on_oom. Also, it can simplify the cgroup
> management for userspace applications.
> 
> This commit introduces a new knob for cgroup v2 memory
> controller: memory.oom.group. The knob determines
> whether the cgroup should be treated as a single
> unit by the OOM killer. If set, the cgroup and its
> descendants are killed together or not at all.
> 
> To determine which cgroup has to be killed, we do
> traverse the cgroup hierarchy from the victim task's
> cgroup up to the OOMing cgroup (or root) and looking
> for the highest-level cgroup  with memory.oom.group set.
> 
> Tasks with the OOM protection (oom_score_adj set to -1000)
> are treated as an exception and are never killed.
> 
> This patch doesn't change the OOM victim selection algorithm.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Tejun Heo <tj@kernel.org>

The semantics make sense to me and the code is straight-forward. With
Michal's other feedback incorporated, please feel free to add:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
