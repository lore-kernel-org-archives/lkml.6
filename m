Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDC1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97462151C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="c6KZfCKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97462151C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeHXXka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 19:40:30 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:44467 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbeHXXk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 19:40:29 -0400
Received: by mail-lf1-f54.google.com with SMTP id g6-v6so7546569lfb.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 13:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LlWSQBxY1v7f/X3Sm4jQMGTF0EAGOAzf/BsBZ9BFuNw=;
        b=c6KZfCKp18T6T7r2k/eq5g/qmhtYxGrtnmHapapGRVCUWW/gc5SzJijBj4jKqkkUrm
         q8ZzXfyzZcSGznf1ZWJoNszHXFNtkLGVaNVNS9vx7CfieOmNAW/L6HRI2gA33dii72Zy
         8aCQv408aYyqhSZlQj21pc4LHnPWVdVOYnE+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LlWSQBxY1v7f/X3Sm4jQMGTF0EAGOAzf/BsBZ9BFuNw=;
        b=CgzdS+/5HmSMb6EgjisOFWPIIZ7GQSrqhJVE68tFzyUFic1AlVvsmhRAnNbS+KdMMH
         MId1igJyLksay9MD/atY7gYk1XcC9fIvcsTWHYs48UQ++RdNYS6QbCbfWUXRoFzW1ajc
         qN8atZFJQwmzsbiBdb9GZIij7KV/St2cWbXdhzW04ttCuU45P21oaoqH0mxlO+9zz1Vj
         YfnAKR6+c6ti2YRacc1K3pUOjD0mG/izIeUJwgV1luoZ45HgCbsnAhnxUV0qggcjHfyP
         a+hRGIjf+6uiK1HQrLw/DkCn5dvoipoIDoAKBqdtbRyQqLuKSLAwnwkW8eHfUXdwBRdI
         zC+A==
X-Gm-Message-State: APzg51Bd5d1zZsUM/haOWT2zezZQuhCNghrOBvXBopC+N/6b2v6IsPsY
        11OFpS8LAaYRZB8Vyhp/ibFvPiypPLSWFX+4yXkbhg==
X-Google-Smtp-Source: ANB0VdbA8MZJ1wF6YHr5Rq3evP4VKS9v6HajbfRBNByWuGAFQahJuTfdue/EZ+l9PEbyV4fEzabMqoEHHy+LLIkoZmI=
X-Received: by 2002:a19:ea52:: with SMTP id i79-v6mr2147458lfh.75.1535141062663;
 Fri, 24 Aug 2018 13:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20171215092305.994559179@linuxfoundation.org> <20171215092311.347628971@linuxfoundation.org>
 <CAL1RGDVgShymmT+TJ3mAHEL7n+qoisk6mQ=Tji_T=0d_QA=VKw@mail.gmail.com>
 <1535129126.2902.36.camel@codethink.co.uk> <CAL1RGDW1Lo+F5D479Jsi-AFsmjVpdDre_qOFSCwWubG6U=bxeQ@mail.gmail.com>
 <20180824191749.GA15489@kroah.com>
In-Reply-To: <20180824191749.GA15489@kroah.com>
From:   Roland Dreier <roland@purestorage.com>
Date:   Fri, 24 Aug 2018 13:04:09 -0700
Message-ID: <CAL1RGDXUx-frpWuuYyc-VrAEoOU2+irGQPRWvoBzO2ZxEPGrww@mail.gmail.com>
Subject: Re: [PATCH 4.4 103/105] Revert "x86/mm/pat: Ensure cpa->pfn only
 contains page frame numbers"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux@roeck-us.net, Ben Hutchings <ben.hutchings@codethink.co.uk>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        matt@codeblueprint.co.uk, bp@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, luto@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, bp@alien8.de,
        brgerst@gmail.com, davej@codemonkey.org.uk, dvlasenk@redhat.com,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        sai.praneeth.prakhya@intel.com, sds@tycho.nsa.gov,
        Thomas Gleixner <tglx@linutronix.de>, toshi.kani@hp.com,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Yazen.Ghannam@amd.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, so what patch should be reverted?  I'm seeing other reports of
> problems all around this same area, but I can't figure out exactly what
> to do.

Are any of those reports public?  If so can you point me at them, I'm
curious if the symptoms match up.

I don't think we want to revert anything.  I think you should pull in
edc3b9129cec and at least the first three patches that Ben listed:

21cdb6b56843 x86/mm: Page align the '_end' symbol to avoid pfn conversion bugs
b61a76f8850d x86/efi: Map RAM into the identity page table for mixed mode
753b11ef8e92 x86/efi: Setup separate EFI page tables in kexec paths

the first patch takes a bit of massaging (mostly because some of it is
already touched by 02ff2769edbc, which keeps the changes from
edc3b9129cec, and so we can drop a good bit when applying).  The other
three apply cleanly.

I'm currently testing that and can send you the state of my tree in a bit.

 - R.
