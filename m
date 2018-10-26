Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE75ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567052064C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ks/sREue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567052064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbeJ0GSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 02:18:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40473 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbeJ0GSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 02:18:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id i17-v6so2644195wre.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 14:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+2Fr/obd7V28HzoYdZ6z+FLfu7ToUWLx849Ocj/fx4s=;
        b=Ks/sREuel8dbYSRusmjkUgfjdYSPRS7mj6qSzEB7p9dhiFqioP2lOBEm5VkbGYklWV
         Z+E4VU0y9fW525Fvx320ub/e67ZRtCMQn6WJwdEGEbUWDQXR6CTsTkkhsa2rUSjxr71m
         ClQe+Bos0s7EgvhcAJTOatbfJrQeXVG3szzowhh1A9h1yFFDNhr1REEYFW7ul91Unxob
         z5ha8ZizxwwYS+4JQ1G0+otqFLLf0649Vz8oY8Mmx6yK9dK+H6ynAPVNeFGJ/v+irX0T
         CNbJF0wc9ve4pivqZFZo795fQ/6DJKRNbqgnxrBJfGI/1Jo3AM4z07vUspwinVW6i8e7
         ZstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+2Fr/obd7V28HzoYdZ6z+FLfu7ToUWLx849Ocj/fx4s=;
        b=KLrYd60qA8KZlS/22OS9VgSwREDjQHYsRHjJhFY5WT764O1hGZyzEuvN4ken01T/bJ
         +E4S9dRReKGfvdu6Gn6NVv9BzleoIc9TBc55uDQ8F8Oo0hk0CAWyDXeRzoeFFFCKB4Pl
         J3WrPFCCQRh/68QgcEACMCHIR5K3e2sSZTO2GEilwlYcAEJ3zpaKZh3g3G6RVc+YkFnu
         dahFM+9UTh6/Y0oZCgc5bZqkl4HRlogFmiV0QgUiZ/3audX/u0r92MBLLx7dRpfWRGax
         1SO54awzEgVYgFgIeoPCTDLoy/kge0ZUWMzFSQ6h+hTdg4irxOPdD1wL+y196SGfaLdf
         xLMA==
X-Gm-Message-State: AGRZ1gINABXHDabZ4CAy0mrSZi9NIrTc/5MnI1E7hR8n2rPP78bvTPpk
        2qXGp1UkKfsxIiFiZnnKqiOdJMP8SaddDBzCjfs=
X-Google-Smtp-Source: AJdET5dSzKQ7NqSij8TiQv0jKIlZ7NU6hlSnsJY6gv/KsD1+XnoWfx6JL3jacrmeEYBGZtnRDMkT3Q/Os4HzN3eAkjQ=
X-Received: by 2002:adf:d4c6:: with SMTP id w6-v6mr6739573wrk.119.1540589975001;
 Fri, 26 Oct 2018 14:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20181026195146.9C7C1136@viggo.jf.intel.com> <0e5fd8bc-0b18-ea88-ed95-ec81a44d0783@intel.com>
In-Reply-To: <0e5fd8bc-0b18-ea88-ed95-ec81a44d0783@intel.com>
From:   Daniel Micay <danielmicay@gmail.com>
Date:   Fri, 26 Oct 2018 17:39:08 -0400
Message-ID: <CA+DvKQLpizz2LJppOts1fB6ujQNqj0fii8mo-UfosoYpQWRb5g@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/pkeys: copy pkey state at fork()
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@kernel.org>, jroedel@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I ended up working around this with a pthread_atfork handler disabling
my usage of the feature in the child process for the time being. I
don't have an easy way to detect if the bug is present within a
library so I'm going to need a kernel version check with a table of
kernel releases fixing the problem for each stable branch.

It would be helpful if there was a new cpuinfo flag to check if the
MPK state is preserved on fork in addition to the existing ospke flag.
The problem will fade away over time but in my experience there are a
lot of people using distributions with kernels not incorporating all
of the stable fixes. I expect other people will run into the problem
once hardware with MPK is more widely available and other people try
to use it for various things like moving GC or assorted security
features. Someone will end up running software adopting it on an older
kernel with the problem.

The clobbering issue I found with MAP_FIXED_NOREPLACE isn't quite
as annoying because it was easy to make a runtime test usable in a library
to see if the feature works properly.
