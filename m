Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF895C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5622418B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSpp+bvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5622418B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753342AbeGEIYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 04:24:40 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38359 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753170AbeGEIYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 04:24:39 -0400
Received: by mail-wm0-f65.google.com with SMTP id 69-v6so9320973wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 01:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6siZ3Z/ZRd4yREP9cXBtGjNsEibTGE6fCGrx7x5wzpw=;
        b=gSpp+bvw588yhdI7FuyT8AXQh3Zn4hMlNzW44BKtgGv8kad/TLtk+zJ57PaBUxnO1O
         dGCmgm1xC/dauKg6Pauzjx+wI0KyHE1FhcwSMsCs2HoEJzF6/MctB3MylHPxvEuFmpQI
         5F0pzxyyei34XOhmbXga7fa6qAAxYfu4tapZNWYBccrVUr/ljH6X0Gs+N3gDyD0/U3JR
         j5I3wAbUKMgIj/F4xTdeFPwAW+Xy7L14Q2AcltsgBEdauekZ2Orft5Phi4E9AsAI536K
         r9wHfCS1KkFNF/YJXata1snx6y+NEVUzrTxOHNHHl0vuLQHYe6JE2OSXMspHlac73oDG
         TnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6siZ3Z/ZRd4yREP9cXBtGjNsEibTGE6fCGrx7x5wzpw=;
        b=j6qHSeCHajXIByFSH4KGSYGpZpAm+X0CA6UaNYMPOT2bUwZXNV2ez2QU9qWnOLiapR
         en2T+ImfrZcfEfDsN1FAifkIwgF4IiALsz5yhkit/jCT7s6i4b/v+FLGZraEB3ivT0pe
         cjj23WNEUJkHb52Mc3xJqkRhSLRDpO23Gc42jI/Ct5Dqh+yeuUzkieFLFtVxnaG6WfaF
         PqnaKe+6FzncwKewigMOZen2mEHW8y+PB+RA4is4LNlss8W4zHqU0l/Nzb+J93nKMyJT
         0S5ZYR7Gt2lEIbkjMh7GRP/0/y0P1D+KJCmWyw2JeFyO2ETsmAz2MQYonAXb9epvROkw
         TGOw==
X-Gm-Message-State: APt69E2JmNF3sDR1U6sEfHDPLf0HpEGPiaCRSCqNdq4GyIJkdr5NmaJv
        Er94bGuKEgiS+LRJ8fU7fus=
X-Google-Smtp-Source: AAOMgpfxTQMRipAceEzwSXT/lOCyYvDxKftJYkBDVnZWYinNgvZPyXlMzOFVAa9siAJgJoQDTXMi6A==
X-Received: by 2002:a5d:45c1:: with SMTP id b1-v6mr3786385wrs.106.1530779078361;
        Thu, 05 Jul 2018 01:24:38 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id w2-v6sm10957644wme.45.2018.07.05.01.24.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 01:24:37 -0700 (PDT)
Date:   Thu, 5 Jul 2018 10:24:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     David Rientjes <rientjes@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        kbuild test robot <lkp@intel.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/numa_emulation: Fix uniform size build failure
Message-ID: <20180705082435.GA29656@gmail.com>
References: <153065162801.12250.4860144566061573514.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153065162801.12250.4860144566061573514.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dan Williams <dan.j.williams@intel.com> wrote:

> The calculation of a uniform numa-node size attempted to perform
> division with a 64-bit diviser leading to the following failure on
> 32-bit:
> 
>     arch/x86/mm/numa_emulation.o: In function `split_nodes_size_interleave_uniform':
>     arch/x86/mm/numa_emulation.c:239: undefined reference to `__udivdi3'
> 
> Convert the implementation to do the division in terms of pages and then
> shift the result back to an absolute physical address.
> 
> Fixes: 93e738834fcc ("x86/numa_emulation: Introduce uniform split capability")
> Cc: David Rientjes <rientjes@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

I'm still getting this link failure on 32-bit kernels:

 arch/x86/mm/numa_emulation.o: In function `split_nodes_size_interleave_uniform.constprop.1':
 numa_emulation.c:(.init.text+0x669): undefined reference to `__udivdi3'
 Makefile:1005: recipe for target 'vmlinux' failed

config attached.

These numa_emulation changes are a bit of a trainwreck - I'm removing both 
num_emulation commits from -tip for now, could you please resubmit a fixed/tested 
combo version?

Thanks,

	Ingo
