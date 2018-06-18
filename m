Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2491AC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48AA20020
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZrbRTzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48AA20020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936056AbeFRWIt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 18:08:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755375AbeFRWIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 18:08:48 -0400
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8372B20850
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 22:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529359727;
        bh=vnInrEFoVy7ZZj69JRH45YA+uAEWngUA9e8q5rcshJY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dZrbRTzSSfqkKMHfx53xqz+o0moNIe6S0/cWKmyS4EPqBsfRSWMUHacL5nvs3sQAp
         E9JBdxCB0V6y4dPbCOzov9y340bWnLOBxLQjXjx2tHws5HVsvE+UMVT6z0sswgeMQx
         wHfjHBmcqyJwrUZqnIKJ0l+Ufz9Tz7g088bGtgSg=
Received: by mail-wm0-f53.google.com with SMTP id v16-v6so16579759wmh.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 15:08:47 -0700 (PDT)
X-Gm-Message-State: APt69E0v7SN30oF6QEjdGdGCcQFLcUHtE+P767MP25+ZLUDrsa70569E
        bRI2nk3eGPj5W0NQcIfMaOSnLpRjSclhIqiJTmnQXw==
X-Google-Smtp-Source: ADUXVKIreyMITpLqeQl/wdPd24sbvqaimJV8nZSiKrOdcyXSkg7G0gpTXn6XuK2t9orqQqbJFvagYYTqzJPCEom+zxY=
X-Received: by 2002:a1c:f30f:: with SMTP id q15-v6mr9551765wmq.36.1529359726063;
 Mon, 18 Jun 2018 15:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <1528391168-22224-1-git-send-email-chang.seok.bae@intel.com> <1528391168-22224-8-git-send-email-chang.seok.bae@intel.com>
In-Reply-To: <1528391168-22224-8-git-send-email-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 18 Jun 2018 15:08:33 -0700
X-Gmail-Original-Message-ID: <CALCETrXJ31ArFKt3QYi=p9ufyhBW8ZFBdSaDU3ueDmFEFKvY6g@mail.gmail.com>
Message-ID: <CALCETrXJ31ArFKt3QYi=p9ufyhBW8ZFBdSaDU3ueDmFEFKvY6g@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] x86/vdso: Move out the CPU number store
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 10:06 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> The CPU (and node) number will be written, as early enough,
> to the segment limit of per CPU data and TSC_AUX MSR entry.
> The information has been retrieved by vgetcpu in user space
> and will be also loaded from the paranoid entry, when
> FSGSBASE enabled.
>
> Now storing CPU number to the CPU_NUMBER segment limit is
> done during the bootstrap, while MSR TSC_AUX is written
> during each CPU initialization that is still before IST
> setup.
>
> The redundant setting of the segment in entry/vdso/vma.c
> was removed; a substantial code removal. It removes a
> hotplug notifier, makes a facility useful to both the kernel
> and userspace unconditionally available much sooner.
> (Thanks to HPA for suggesting the cleanup)

Couldn't setup_cpu_number_segment()'s contents go in setup_cpu_number()?

--Andy
