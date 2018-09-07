Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B99DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D9120844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMTBDa8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D9120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbeIGVqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:46:51 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44686 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbeIGVqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:46:51 -0400
Received: by mail-ed1-f65.google.com with SMTP id s10-v6so12007448edb.11;
        Fri, 07 Sep 2018 10:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6e3/w4DeROvJS0mzH4fadHvnqwR+6uFQwbn/cCWK6Ro=;
        b=IMTBDa8/iaCdyDhuFy42rFwJRrMPEUaA8EPqIQi5cpxLDKMKbbBGQXl75VV7MtJ5Jm
         lbb9xxvyuZdXy4HhkCF6XFb8x7DjHksPZgIHqH9FZ7QpUzgZKpXv1QWUtr/ksSx8VnbA
         CoRHvjygKNmlbP8WK9/ofKaIxE/kdZaJBNpfMzzmkRlE0hUvbZf2b9Z3gPjhgC9M6nSs
         Gfc31I0N+1aOKD3qpzC0s8UD59ZjjH9kauMdCwFh+w5L22jOcfAzOi9sY5kPGndEl+QT
         Jj6i0aB5c4fgQ5RH1hOPUgZS8zG4BJ7Ed/aWnKjijTi5Xe/vBdreA4uWXw+NAp0DIwcR
         H6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6e3/w4DeROvJS0mzH4fadHvnqwR+6uFQwbn/cCWK6Ro=;
        b=YkqvEd0mmMLe1/PaOcT0HsRZqYyDoRvLFX9h/F1o9BDT92Aa/HAeNyDuY1N+ZHrowv
         HuJpbMU6U2GqJady5PMtWUiFRcytjMpLHW5D4Lc+EBlvqUFdTbW2wvMN1YF/OrZ4a6Fb
         MaxEN6m8z2vP7JK1yKtTeQozduzcXlhks6fS8gID40lbx9QimitO6ooCaOasAtAGMgWg
         g92S2Yx/74P+n/Jjz35Y2wPKvXU1qrhBlbEOIV3oppwekhIaUdqGfK0uhtzgR+YMi6YK
         UV6BtAU2qsgK54sB+8K607SPEiLrIC/jlLxU6LTCo0Ozn01sVoc+UuaDk/86k01emo6y
         XZ8Q==
X-Gm-Message-State: APzg51AU0hCF3NvKrb2mLvumV5UOEDi/jZ5DYwqsywHO3ny5uKHzTrNN
        WZsAOul+/6mQT2aD7twL06o=
X-Google-Smtp-Source: ANB0VdZSQUskW6b4n/jACODLMsZKhhLvXkGstCFhdsZ2N+0LPlA2gKo/R5N7oLMN3kmtU8YXut5WaQ==
X-Received: by 2002:a50:8386:: with SMTP id 6-v6mr10022578edi.170.1536339899460;
        Fri, 07 Sep 2018 10:04:59 -0700 (PDT)
Received: from darwi-kernel ([142.93.171.10])
        by smtp.gmail.com with ESMTPSA id f19-v6sm4124762eda.49.2018.09.07.10.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 10:04:58 -0700 (PDT)
Date:   Fri, 7 Sep 2018 17:04:51 +0000
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Zhang Yi <yi.z.zhang@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, pbonzini@redhat.com,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        yu.c.zhang@intel.com, pagupta@redhat.com, david@redhat.com,
        jack@suse.cz, hch@lst.de, linux-mm@kvack.org, rkrcmar@redhat.com,
        jglisse@redhat.com, yi.z.zhang@intel.com
Subject: Re: [PATCH V5 0/4] Fix kvm misconceives NVDIMM pages as reserved mmio
Message-ID: <20180907170451.GA5771@darwi-kernel>
References: <cover.1536342881.git.yi.z.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1536342881.git.yi.z.zhang@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sat, Sep 08, 2018 at 02:03:02AM +0800, Zhang Yi wrote:
[...]
>
> V1:
> https://lkml.org/lkml/2018/7/4/91
>
> V2:
> https://lkml.org/lkml/2018/7/10/135
>
> V3:
> https://lkml.org/lkml/2018/8/9/17
>
> V4:
> https://lkml.org/lkml/2018/8/22/17
>

Can we please avoid referencing "lkml.org"?

It's just an unreliable broken website. [1][2] Much more important
though is that its URLs _hide_ the Message-Id field; running the
threat of losing the e-mail reference forever at some point in the
future.

From Documentation/process/submitting-patches.rst:

    If the patch follows from a mailing list discussion, give a
    URL to the mailing list archive; use the https://lkml.kernel.org/
    redirector with a ``Message-Id``, to ensure that the links
    cannot become stale.

So the V1 link above should've been either:

    https://lore.kernel.org/lkml/cover.1530716899.git.yi.z.zhang@linux.intel.com

or:

    https://lkml.kernel.org/r/cover.1530716899.git.yi.z.zhang@linux.intel.com

and so on..

Thanks,

[1] https://www.theregister.co.uk/2018/01/14/linux_kernel_mailing_list_archives_will_return_soon
[2] The threading interface is also broken and in a lot of cases
    does not show all messages in a thread

--
Darwi
http://darwish.chasingpointers.com
