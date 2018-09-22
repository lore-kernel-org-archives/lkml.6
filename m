Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D168ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4F62156F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="GmFfNXKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4F62156F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391673AbeIVF5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 01:57:50 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41574 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeIVF5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 01:57:50 -0400
Received: by mail-ot1-f67.google.com with SMTP id e18-v6so14653800oti.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 17:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m7FOKBEtlEGpM8dxYrDEffG368llkqCqL7eq0tuIQLI=;
        b=GmFfNXKM6Fe27jUmjn2eiln/O3CxMTZ8OWLaIBGeeQkg/qqb0ofcpKQDwa/8oq04YI
         if/5pbANZ6qvYwoVjN4cyQ3xVwyyW4O+h93DAyTRk79/4JfMzJTbE9xxfLo/8UZjebz+
         Y1M+JfRm279DkB0dGfeEgLsTOgO6ifHmVCvdT6rizgrNg2RwFCwYQvXIwzlYg47AUZmD
         exvW8iOhSz4lyzRtsI7Hi/GraeLZJk1ibpeOg3nD/Dvq3cAdqXiSFgI5xs6w2r3tfl0w
         va4e/sDK34doEeT2nj0BDCwPzkUrZsFw9UaBXjBLhaCN4kICRV2aG3TGFZpt95h5PXX6
         KZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m7FOKBEtlEGpM8dxYrDEffG368llkqCqL7eq0tuIQLI=;
        b=FhsNc2fV2c7mJeA0LIZ4Zeyb8I8zacsqK7XXZgGa5Uwq6rj/D4//oK6v8/DP2OJeS9
         w0yssNmiIRItVQEg/JjNHS9Lit5Lq+mbkmsL5GvsnPmnvUQ7BZgmLlR+qbFlLbkVcT6e
         kt6vWRpgrptvn4Jx4H8M7tYWZf8ykprQdjahFudv10XBlneyrF8TPdHtFyUXlUjFV5dj
         Lr8xmon0XtnKQg4dMkYUGKio8J0cVeLWq8FeLTukrQgkc+Mx4vix+TsJcuSUSDyOyOcp
         4tSI2pA0NdxkYjBWnuk27Vwi5adNCwHvf6bsDPHxWdviGILL4cNJQ1dgaCLxkcqGXjbj
         C1og==
X-Gm-Message-State: ABuFfoias9XB7CLR//p6fvLa0TBqh+DdXJC7H9QcKCiGQiwjueAPPSwp
        Tn1bRGd8GNYFiPt5SI9zPBrBAyvVtAYuOj8GS8oaww==
X-Google-Smtp-Source: ACcGV63J9sd7MKc15T2AVjUDQKJLq3wsJyfgvKbjs9I1S3uJgj9HyfMS3Ec28Zk4TM/Wo2kSOZqYaGkqXfabXX+rB8Q=
X-Received: by 2002:a9d:d7:: with SMTP id 23-v6mr67743otk.372.1537574795806;
 Fri, 21 Sep 2018 17:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <153702858249.1603922.12913911825267831671.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180917161245.c4bb8546d2c6069b0506c5dd@linux-foundation.org>
 <CAGXu5jLRuWOMPTfXAFFiVSb6CUKaa_TD4gncef+MT84pcazW6w@mail.gmail.com> <AT5PR8401MB1169D656C8B5E121752FC0F8AB120@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <AT5PR8401MB1169D656C8B5E121752FC0F8AB120@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 21 Sep 2018 17:06:24 -0700
Message-ID: <CAPcyv4iuRkQWsWa-YfTMDJUTUr1QouEsS6zD_LAjcpbLGXCPEQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] mm: Randomize free memory
To:     "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <MHocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Toshi Kani <toshi.kani@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 4:51 PM Elliott, Robert (Persistent Memory)
<elliott@hpe.com> wrote:
>
>
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> > owner@vger.kernel.org> On Behalf Of Kees Cook
> > Sent: Friday, September 21, 2018 2:13 PM
> > Subject: Re: [PATCH 0/3] mm: Randomize free memory
> ...
> > I'd be curious to hear more about the mentioned cache performance
> > improvements. I love it when a security feature actually _improves_
> > performance. :)
>
> It's been a problem in the HPC space:
> http://www.nersc.gov/research-and-development/knl-cache-mode-performance-coe/
>
> A kernel module called zonesort is available to try to help:
> https://software.intel.com/en-us/articles/xeon-phi-software
>
> and this abandoned patch series proposed that for the kernel:
> https://lkml.org/lkml/2017/8/23/195
>
> Dan's patch series doesn't attempt to ensure buffers won't conflict, but
> also reduces the chance that the buffers will. This will make performance
> more consistent, albeit slower than "optimal" (which is near impossible
> to attain in a general-purpose kernel).  That's better than forcing
> users to deploy remedies like:
>     "To eliminate this gradual degradation, we have added a Stream
>      measurement to the Node Health Check that follows each job;
>      nodes are rebooted whenever their measured memory bandwidth
>      falls below 300 GB/s."

Robert, thanks for that! Yes, instead of run-to-run variations
alternating between almost-never-conflict and nearly-always-conflict,
we'll get a random / average distribution of cache conflicts.
