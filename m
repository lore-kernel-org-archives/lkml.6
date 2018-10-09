Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EB9C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076502087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLEDwLIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 076502087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbeJISKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:10:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41118 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeJISKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:10:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id x12-v6so1288867wru.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 03:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/HoMUSwWBHiaEUkK6ht76sfho7IdpcMPKcuwChWyEGs=;
        b=RLEDwLIMZ2X14tiJPBkMKL8U/2C/Rji4A3RUwRVuX6bRL//m14Gj7U0FENSBAsWQ/m
         yRyne9GcZvyORAUvfZLgzYOQennGu76FNjOb7vdznJR1a3i5C97BRZKrndn7B8+xZ8yD
         eEnT4SG0J8h7+oMbv3q5eTGyzXN5C+xTkVyoCGjykS+e+TVvDsKJqgJaglEWuq6VMMme
         jnJ3XkTsln2bpVzgPZqS1KSijFqZzOhLibyuCU1dIvtsJI+QqIhw+6RJNi1q5kQwOTU4
         gQq0zinAr4XGdPlunD9CWDn9jM4g7daCOq/ylAmPEEEWxg6ELrahoSGNQgzqYZa0GLPj
         x0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/HoMUSwWBHiaEUkK6ht76sfho7IdpcMPKcuwChWyEGs=;
        b=mMQoVMtM9k+EPRo8cdZIYSkhOdxqkATId7u6rgSSWeP6zSGfp9Co0pFvktSM7Ok6r2
         3LP/Y2aZiI085ljAtJGTEjRfyp4VkA1J0aNtJy8pe5P3uxtf+nGwcg3jlOSio35t9qQu
         gCk5FIUPOMdhz1L6PHsNsjbHe97cOgoA+Ar7ayWU9rQ0l5P6GhJfA593JqZGFajf/vEd
         nBng1iZTzzEUHBOeWcuIMBMfMH8HLobvvYh/eXWNy2W0ZLYdf5cGs5aJyE+YD+ou0ZcG
         FkUa99l3LtaM11o26koFIO3MC91PEP9wDW8t6aX1dlTAO73MDsg/ngiF4vn0/5Jw1yui
         1a8g==
X-Gm-Message-State: ABuFfojmIjj+v5ivWdKl6l+pDlNLv9nViY4/l4/r9RA1SG3DMghKziWV
        3XY4K/7N0x93G2swZ2RwRmw=
X-Google-Smtp-Source: ACcGV61dwuQyGtSPQ9D7YkuDD3YyvCQkS/r/jy77W8txMa0skqx1p+BRK3/jsoTl3dM6u2Ce95bQBQ==
X-Received: by 2002:a05:6000:48:: with SMTP id k8mr18915437wrx.103.1539082471146;
        Tue, 09 Oct 2018 03:54:31 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id o81-v6sm9061423wmo.38.2018.10.09.03.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 03:54:30 -0700 (PDT)
Date:   Tue, 9 Oct 2018 12:54:27 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Yi Sun <yi.y.sun@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        jgross@suse.com, chao.p.peng@intel.com, chao.gao@intel.com,
        isaku.yamahata@intel.com, michael.h.kelley@microsoft.com,
        tianyu.lan@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH v4 2/2] locking/pvqspinlock, hv: Enable PV qspinlock for
 Hyper-V
Message-ID: <20181009105427.GA102322@gmail.com>
References: <1538987374-51217-1-git-send-email-yi.y.sun@linux.intel.com>
 <1538987374-51217-3-git-send-email-yi.y.sun@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538987374-51217-3-git-send-email-yi.y.sun@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Yi Sun <yi.y.sun@linux.intel.com> wrote:

> Follow PV spinlock mechanism to implement the callback functions
> to allow the CPU idling and kicking operations on Hyper-V.

> +#if defined(CONFIG_SMP)
> +	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
> +#endif

What's wrong with using the common pattern of:

	#ifdef CONFIG_SMP

?

Thanks,

	Ingo
