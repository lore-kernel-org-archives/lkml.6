Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A158C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F81214FA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuZjDmcN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F81214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeJIWcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:32:09 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39670 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeJIWcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:32:09 -0400
Received: by mail-yw1-f68.google.com with SMTP id v1-v6so789019ywv.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 08:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PvyJbRfwJLGve2GhtgWf+zkJ104jeM/geUJuABUuhaE=;
        b=DuZjDmcNSPV9rNhEiYrlzKRxK98QwYWmeBuaTOIRjxaqtIxVlIBBU+uuS4S/InqWaf
         xStOUp2/p44SmwlZom/p3biLjKyKYV2tjigv5jT8RQdoHkhaZc0SfWYSW+EXS0m1//hN
         k0hcneZT3dmT1jLX5jchf9dRF+VL+oKOzveXFZ3GrzHQXA3KtUA/WA7hYZVvuWexUxNJ
         lArdj3WLaRtw5cE1aQjKvnxNgpbt29F+hXxxP5kwgkK1fAJeBzYNPYl2WFgCUpb+znuE
         ezyE+eVt5D35GI8dVfmHRG3rg1fwFAbu7YzSp3dIDk3yTayGSfBo+dl/6rujghK1QbSK
         5Ipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PvyJbRfwJLGve2GhtgWf+zkJ104jeM/geUJuABUuhaE=;
        b=BwQMrhbYuteFgh4zte9uP3RQkFq6f/6Nwv0Sh0HzS9krMrOLboZ3EF7ksIULZXyB6O
         5blYqF+5Yy/DEapoES0clHtRloASKMJzoPMqA1C0rMv5X2dqVASHAPYGJe7yCcyx4e0m
         hM8e7yCAxR7zs7TjZ6LwvXQoiizgyD8aQPM92dTXDSiTgoBULsNmpSCiEtA+d23sD01w
         +uSw0EfZBfbRzdbvrUcRmzAF4l8xexYvivF/US1hP0TWCgOcFvEHMRmu5bj8EOzm1sWa
         RIquoTSV6WtApqHIuzEdLfsgT8IWZwU3EP7hGRwmKJNbs4JQulRmc2v2zKgEmozUq8lU
         WmZA==
X-Gm-Message-State: ABuFfoisxrhemEvj674JKxRjSnLQZIFdN/cFOr0Ll9FKo71KClc88YCY
        kp22Puolx9Wo1tgvO+7XRS/qVSM=
X-Google-Smtp-Source: ACcGV621p/KSlwJcaG4djnJMzinay/YfoGf7yQaEWGqPI8iqm4NuWoc/coQogTTyl/BB2I+WP7SWYw==
X-Received: by 2002:a0d:ef02:: with SMTP id y2-v6mr16312531ywe.24.1539098084806;
        Tue, 09 Oct 2018 08:14:44 -0700 (PDT)
Received: from gabell (c-98-229-178-29.hsd1.ma.comcast.net. [98.229.178.29])
        by smtp.gmail.com with ESMTPSA id w207-v6sm34631893yww.95.2018.10.09.08.14.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 08:14:44 -0700 (PDT)
Date:   Tue, 9 Oct 2018 11:14:35 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     linux-mm@kvack.org, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 0/3] mm: Fix for movable_node boot option
Message-ID: <20181009151433.p5aqcyrzrv7gfpyh@gabell>
References: <20181002143821.5112-1-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002143821.5112-1-msys.mizuma@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping...

On Tue, Oct 02, 2018 at 10:38:18AM -0400, Masayoshi Mizuma wrote:
> This patch series are the fix for movable_node boot option
> issue which was introduced by commit 124049decbb1 ("x86/e820:
> put !E820_TYPE_RAM regions into memblock.reserved").
> 
> The commit breaks the option because it changed the memory
> gap range to reserved memblock. So, the node is marked as
> Normal zone even if the SRAT has Hot pluggable affinity.
> 
> First and second patch fix the original issue which the commit
> tried to fix, then revert the commit.
> 
> Changelog from v2:
>  - Change the patch order. The revert patch is moved to the last.
> 
> Masayoshi Mizuma (1):
>   Revert "x86/e820: put !E820_TYPE_RAM regions into memblock.reserved"
> 
> Naoya Horiguchi (1):
>   mm: zero remaining unavailable struct pages
> 
> Pavel Tatashin (1):
>   mm: return zero_resv_unavail optimization
> 
>  arch/x86/kernel/e820.c   | 15 +++--------
>  include/linux/memblock.h | 15 -----------
>  mm/page_alloc.c          | 54 +++++++++++++++++++++++++++-------------
>  3 files changed, 40 insertions(+), 44 deletions(-)
> 
> -- 
> 2.18.0
> 
