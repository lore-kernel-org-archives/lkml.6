Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB30C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8772085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCh8sNsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8772085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeJJNoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 09:44:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36220 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbeJJNoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 09:44:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id a8-v6so4334763wmf.1;
        Tue, 09 Oct 2018 23:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KP56uNJMeyoIvHZLgI4B82Bl6mWc9EkiBzffR+DcUko=;
        b=UCh8sNsEjyetGqtG7pJksSlHdahcBl5iO86hLYjur5fL5H6HdMh4tH5kemKQDYQgc+
         Bh0YX0sPtempxVJx+/WD+IvYr6OUclUx5w4KI2owH3eEATY6shl6/AwqwzBXcDZNqnKx
         Cc8qj/Hfbowv1OqrycpjwtC6apx8l6JcWXeeA2Qe7xp/s/sRXfGP5LcgfELHxwieIuoa
         iMUDpbFuQBBmrJ596E+TK9mjjhCV6v5rsyUPvTsuX5XmnpYVFb0rPMA5GIZFCtNEWV2e
         Fn9bBfif+jzGz+28ru7Q2iYhcqHCxpjBeSK8J6/SBV+Q5cVt5Zcain3/Bi6lDyfAAHw5
         Iwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KP56uNJMeyoIvHZLgI4B82Bl6mWc9EkiBzffR+DcUko=;
        b=q9mc/VpTKPaA24avdpdfa9rR+nQx2cDuXLQpZ/29+FkrIyMYO2TC5JczoWQDZbED+7
         F5VerIrhVrCs9YrnkvmhQ8QmEHdUaMjvrdFGeUOcr4zqUuZVNDOSS1CtNfHIG99zO4HG
         VqeNe+VcEYWygZqML6XiPSjigHTErVD4luXaAwMXDzvmji9HMkdDmI8qeFuDaqMhulHW
         6rgFnX1BRVzQXgKnlqrnL8dcNZZbHpizx9175WMAjOjWqt9FxC6BZeXQbYaQ3kB/0mJg
         oPwZodPiLeosG5+89HBlUn6VWPm72KS3k/G0RilgFZMcvQZnFVALPShmaU+QLhsO+Qjq
         JgRw==
X-Gm-Message-State: ABuFfojtbPRq5PKHcbb5G9DzzvOgmFOqHz4nqFpWgpM11MlPNqURSAxQ
        SUuCtfPocXTITEO5ygOMNng=
X-Google-Smtp-Source: ACcGV620wzHg+a7kDFZuXrCiXTRDdmkW86TR//o249XM1V2iUXe5qQSksMDc2HCpT1vSfzeyUIiIIw==
X-Received: by 2002:a1c:e717:: with SMTP id e23-v6mr4348251wmh.145.1539152635518;
        Tue, 09 Oct 2018 23:23:55 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c24-v6sm12274183wre.44.2018.10.09.23.23.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 23:23:54 -0700 (PDT)
Date:   Wed, 10 Oct 2018 08:23:52 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-doc@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, corbet@lwn.net,
        boris.ostrovsky@oracle.com,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v5 0/3] x86: make rsdp address accessible via boot params
Message-ID: <20181010062352.GC37224@gmail.com>
References: <20181010061456.22238-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010061456.22238-1-jgross@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Juergen Gross <jgross@suse.com> wrote:

> In the non-EFI boot path the ACPI RSDP table is currently found via
> either EBDA or by searching through low memory for the RSDP magic.
> This requires the RSDP to be located in the first 1MB of physical
> memory. Xen PVH guests, however, get the RSDP address via the start of
> day information block.
> 
> In order to support an arbitrary RSDP address this patch series adds
> the physical address of the RSDP to the boot params structure filled
> by the boot loader.
> 
> Juergen Gross (3):
>   x86/xen: fix boot loader version reported for pvh guests
>   x86/boot: add acpi rsdp address to setup_header
>   x86/acpi: take rsdp address for boot params if available
> 
>  Documentation/x86/boot.txt            | 32 +++++++++++++++++++++++++++++++-
>  arch/x86/boot/header.S                |  6 +++++-
>  arch/x86/include/asm/acpi.h           |  7 +++++++
>  arch/x86/include/asm/x86_init.h       |  2 ++
>  arch/x86/include/uapi/asm/bootparam.h |  4 ++++
>  arch/x86/kernel/acpi/boot.c           |  6 ++++++
>  arch/x86/kernel/head32.c              |  1 +
>  arch/x86/kernel/head64.c              |  2 ++
>  arch/x86/kernel/setup.c               | 17 +++++++++++++++++
>  arch/x86/kernel/x86_init.c            |  3 +--
>  arch/x86/xen/enlighten_pvh.c          |  2 +-
>  11 files changed, 77 insertions(+), 5 deletions(-)

I have some vague memories of an older variant of this feature breaking stuff and resulting in 
me involuntarily participating in an overly long bisection session.

If that memory is right and I'm not confusing it with some other patchset, could you please 
provide some more context, what that old problem was, how it was resolved, whether it is 
expected to trigger on any machines, etc., to create some warm fuzzy feelings about this 
patch-set and to reduce my bisectofobia? ;-)

Thanks,

	Ingo
