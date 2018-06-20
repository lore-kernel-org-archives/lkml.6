Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12DAC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91892083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MXnmSmB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91892083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933443AbeFTVgs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 17:36:48 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33923 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933225AbeFTVgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 17:36:47 -0400
Received: by mail-wr0-f195.google.com with SMTP id a12-v6so977889wro.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 14:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k8Pkgmes/3/iqbMtNDJpFKF39YTC864fd4gbEv6tRCw=;
        b=MXnmSmB2cHtRxErjKFDq9lfiRXupwNCYlKMPv78cNEMa6XOL1FJ6e/JpXBpVZAymNT
         Kd9DkZKxTjt2t9PCR3FDvg5OHYsUrPxwQnwU4WuYAvZ1dfwjgv0t+1CeqrZoZC/a3F2Z
         rakzcCahuFAhLygXUE2tE0VDzeRCrTpAz9tT3hVRdPjOD2ubvyb8bQp1mB25YPYDC3mh
         gB1l//JDfU4kKkpfIBr9Fwoqz02Lq2RU549hYfGiyZG8R6kPAvUcy1COLyj5qe59hII9
         Gr4cr2z1bI6ZoSY/hqtovmxpoTT+ZcCr1NVzNqQlAAkt/6adbyZLCUUdb4BuvuEuwYb5
         vsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k8Pkgmes/3/iqbMtNDJpFKF39YTC864fd4gbEv6tRCw=;
        b=J+2b7S3G9nVD4kLt/8GkHsSyAEJ7PdbOXNB11Am9OCFjZZAtZTpcO6bz4H3+aYGbvX
         LsRLStdoHNW5aV9pGb7j8oRA33qj/T1QmOAmvd3DbiDZbkjVT1q7OuqSLO4NiPSClu/S
         bwuKl2gyMDQWSZye8cwF71cg4j7KafUc62nw+tzZzCjEtYtSIHsxwfPrrvaeGEcP05aA
         TB2yKbDctngHvx15cFonBL2qXX9n5G12fUYYTXbv8R6VSu/F9JOHTbc/IWvGSPMkczrX
         Q89dObPnfiBWWlgYew57ssE+wP3G1e9SVrVzVE8ep6QIKR9lWvNQdjPlDAlCEW+TdmwG
         erAQ==
X-Gm-Message-State: APt69E1B0RpIIz80z/FmGkyT9d+P5IE19Rwdi9FKXKQIgkdcl5FzeodY
        COjeYABImOGjJEcRLZD4YLVpwyjGMV5q4Yy1mDB0uQ==
X-Google-Smtp-Source: ADUXVKKhi7UGNTRL2YUC2+PJRx7768Bxa/ep8kxRULkW7t8ENMtrBh4Mkzbk8bftmmokjr5WPDFX4m30cuOZJkHRTao=
X-Received: by 2002:adf:e48e:: with SMTP id i14-v6mr20713220wrm.8.1529530605690;
 Wed, 20 Jun 2018 14:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180619213352.71740-1-shakeelb@google.com> <3f61e143-e7b3-5517-fbaf-d663675f0e96@virtuozzo.com>
In-Reply-To: <3f61e143-e7b3-5517-fbaf-d663675f0e96@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 20 Jun 2018 14:36:33 -0700
Message-ID: <CALvZod5z8_6KytDdoS26qE1iLVg3yoOT+BUYtxHX2XuN1UKkCg@mail.gmail.com>
Subject: Re: [PATCH] slub: fix __kmem_cache_empty for !CONFIG_SLUB_DEBUG
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 5:08 AM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>
>
>
> On 06/20/2018 12:33 AM, Shakeel Butt wrote:
> > For !CONFIG_SLUB_DEBUG, SLUB does not maintain the number of slabs
> > allocated per node for a kmem_cache. Thus, slabs_node() in
> > __kmem_cache_empty() will always return 0. So, in such situation, it is
> > required to check per-cpu slabs to make sure if a kmem_cache is empty or
> > not.
> >
> > Please note that __kmem_cache_shutdown() and __kmem_cache_shrink() are
> > not affected by !CONFIG_SLUB_DEBUG as they call flush_all() to clear
> > per-cpu slabs.
>
> So what? Yes, they call flush_all() and then check if there are non-empty slabs left.
> And that check doesn't work in case of disabled CONFIG_SLUB_DEBUG.
> How is flush_all() or per-cpu slabs even relevant here?
>

The flush_all() will move all cpu slabs and partials to node's partial
list and thus later check of node's partial list will handle non-empty
slabs situation. However what I missed is the 'full slabs' which are
not on any list for !CONFIG_SLUB_DEBUG. So, this patch is not the
complete solution. I think David's suggestion is the complete
solution. I will post a patch based on David's suggestion.
