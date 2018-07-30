Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0EF13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121C220893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLzwUdNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121C220893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbeG3NHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 09:07:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46634 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbeG3NHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 09:07:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id h14-v6so12494603wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 04:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZFfXN/qfEFg2u5Cm17benULjMPnGAIyAtMVyGj+bs7M=;
        b=VLzwUdNfe4/8KuHEd8VARVomOYL0xcjUThe9/T7EZDL9wXNVpj255Mqv43DFKiuwbF
         YU7BRJ4XfSHJv5Gz3cbSB4P4nq3ciaZWSP8ZkaGu/dwfDPFaEZLx7qJKd6VSemtMCAX9
         AK2yLLexdYJDjoqKS6zq+8+tSxGYEFRAzcdtdU8OsR+tIvRq3fiHCeqODtCcGQMmApjc
         2ynpaE7BQkBWiaIyuYfO70lEPrNpmbeGltWWYEhjUrwqPncasD8PHEPJBqfsjb3UnE6u
         ynoRXA/ej1wuW8oDklcArUU8q8znqoTX1HNSGizC9m9JK4aO36zvsr1Umv2d+GEkBmCO
         yRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZFfXN/qfEFg2u5Cm17benULjMPnGAIyAtMVyGj+bs7M=;
        b=Nbq9hMnBu7wV6aDRpI4xjyNv9LEA0eHflKqqgV6po69vo2Z7qFipaQCCJf3kmlnsxz
         1yPasg+/xD/OhE8IndJrJhFFSwA+L3Fj0XJ9V5g9zR10+G+tw1fm5E5yjpgSMxKuYu5b
         MunidFIDD9YZD+EuSxOubbinmy38cNorrM5FDJy7HEfKsYOtHd9gE+UY3Cg1r6N9a5ql
         ERtfEQFWa2yjDPC38wvYcQuf/DEsz0d03MP3XKR6JrgwTSO0VLskLiezI1pprpC/DF1+
         QIFrdYejERCUapmJ7nuJ8ExThmA90LyWaySwHqYr3eQPbEShnN5XgB60/oxeutN2J6LW
         /eWQ==
X-Gm-Message-State: AOUpUlEcwoAsUBu6fmRHh4ftbZnSF0J3qEo0QZBYCBNHWJ8t82hwWp8V
        E2GiGoGiyI4G1LJsCab2WU0=
X-Google-Smtp-Source: AAOMgpch/J7OAKhefH/Ip+4/3m570ECFSEc/itw1YfqIf3LcGaS4tsVtOJCdW8f2epgcFL/H7EiA/A==
X-Received: by 2002:adf:8503:: with SMTP id 3-v6mr17827466wrh.100.1532950370780;
        Mon, 30 Jul 2018 04:32:50 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x7-v6sm20844269wrr.95.2018.07.30.04.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 04:32:50 -0700 (PDT)
Date:   Mon, 30 Jul 2018 13:32:47 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org, luto@kernel.org, x86@kernel.org,
        vkuznets@redhat.com, efault@gmx.de, dave.hansen@intel.com,
        will.daecon@arm.com, catalin.marinas@arm.com,
        benh@kernel.crashing.org
Subject: Re: [PATCH 0/10] x86,tlb,mm: more lazy TLB cleanups & optimizations
Message-ID: <20180730113247.GA21619@gmail.com>
References: <20180728215357.3249-1-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180728215357.3249-1-riel@surriel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Rik van Riel <riel@surriel.com> wrote:

> This patch series implements the cleanups suggested by Peter and Andy,
> removes lazy TLB mm refcounting on x86, and shows how other architectures
> could implement that same optimization.
> 
> The previous patch series already seems to have removed most of the
> cache line contention I was seeing at context switch time, so CPU use
> of the memcache and memcache-like workloads has not changed measurably
> with this patch series.
> 
> However, the memory bandwidth used by the memcache system has been
> reduced by about 1%, to serve the same number of queries per second.
> 
> This happens on two socket Haswell and Broadwell systems. Maybe on
> larger systems (4 or 8 socket) one might also see a measurable drop
> in the amount of CPU time used, with workloads where the previous
> patch series does not remove all cache line contention on the mm.
> 
> This is against the latest -tip tree, and seems to be stable (on top
> of another tree) with workloads that do over a million context switches
> a second.

Just a quick logistics request: once all the review feedback from Andy and PeterZ
is sorted out, could you please (re-)send this series with the Reviewed-by
and Acked-by tags added?

If any patch is still under discussion then please leave it out from the next
series temporarily, so that I can just apply them all immediately to tip:x86/mm
before the next merge window opens.

( If the series reaches this state later today then don't hesitate to do a resend
  with the tags added - I don't want to delay these improvements. )

Thanks!

	Ingo
