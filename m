Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B804C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 06:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85682084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 06:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pK7v24AY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85682084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbeJ2PXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 11:23:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33474 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729225AbeJ2PXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 11:23:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id y140-v6so8746977wmd.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 23:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E6Sl1tmZWWW0AWdMle+xbaUVhojDJN54bGThAU0YBH8=;
        b=pK7v24AYQyvrCrbIcjPHS9oEFA5MthKeUDdOTFwOcThB7GX8hvPm6lNeC9cTjfcvOu
         coD5LNMeTQyhd8w5B6EvwwMY/uUiUVGF48Q4/2WnhuCO3Ybcbc5kI09IQlqvAmVNyKW2
         PTmUWZmXNgQuvU+VosI0HH9RuD2eTZJKgmVDv+MigJRyJqjZgZb4835rvH8Nd0ep/Xbj
         jFISpJRW9ehhSYhhRzfk8S6wfEnZdcZGCk+mSey3RO2Yfp/i2Z9U7CwNE9n4fMHthyQf
         RHewi3BkWCf85iDY8e/amWmYXpwiJYtLnlbegQS3/lrGMoqRjFz8PqbGP9otp6Ox8YkW
         IDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=E6Sl1tmZWWW0AWdMle+xbaUVhojDJN54bGThAU0YBH8=;
        b=XaFmYKgiz4MuJ4IjlBIaedJo9rM0Bu/+WcV4yYqHdBL9gcZcHljja901CArurM1JFJ
         9yaQKzePfvf5m7s5bRbPJmiSvMHl+G5Qx3lBWIum7tcUJJB6+6JNkZJIvgt1pnkEBTp+
         m9rlAx/yH+8ZcKatLlvcYez5Ky58CVCb4YAWBXAJE2yW7C4m6wdA+M+zymxOQxJw/vB2
         pAYuOpLxaCIzU0EukitdH9YFilTpwSZcUjw32r3CMezNV/zaJwvRI0tZicU0c+SV0LR/
         JMO8t6c58jpch277NL2ZER373mYC6JTdEyOuRIOxcEdGr1VLkSg4EL1vOMlzNzsire0X
         bUiw==
X-Gm-Message-State: AGRZ1gKp3KWLAapKEXAcY8/UEe0O+eWaeH/YFrrVY5sE7qLgMUevlOaH
        +eqHhoX3UEJ3Q+4mxvm6Sy8=
X-Google-Smtp-Source: AJdET5fxhWMEDKZ27JmrGsExvY6zMcxPXxrBaAEmVEqyS2toCUpyQg9M/YyI0uhmR2bM5s8t/kkQ+A==
X-Received: by 2002:a1c:27c5:: with SMTP id n188-v6mr8451020wmn.88.1540794989119;
        Sun, 28 Oct 2018 23:36:29 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x8-v6sm50814106wrd.54.2018.10.28.23.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 23:36:28 -0700 (PDT)
Date:   Mon, 29 Oct 2018 07:36:26 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Daniel Micay <danielmicay@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@kernel.org>, jroedel@suse.de
Subject: Re: [PATCH 1/2] x86/pkeys: copy pkey state at fork()
Message-ID: <20181029063626.GD128403@gmail.com>
References: <20181026195146.9C7C1136@viggo.jf.intel.com>
 <0e5fd8bc-0b18-ea88-ed95-ec81a44d0783@intel.com>
 <CA+DvKQLpizz2LJppOts1fB6ujQNqj0fii8mo-UfosoYpQWRb5g@mail.gmail.com>
 <FA6429E0-C480-47AA-AAF0-95E615D8265B@amacapital.net>
 <CA+DvKQJYmWm6uP6k4HYdkuTdMX7=rSu34W2j-Vk8YcnWZVA-3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+DvKQJYmWm6uP6k4HYdkuTdMX7=rSu34W2j-Vk8YcnWZVA-3w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Micay <danielmicay@gmail.com> wrote:

> > I suppose we could add a new flag for pkey_get() or something.
> 
> That would work, since I can apply the workaround (disabling the
> feature in child processes) if I get EINVAL. The flag wouldn't need to
> do anything, just existing and being tied to this patch so I have a
> way to detect that I can safely use MPK after fork.

A new flag for the pkey_alloc() syscall, right?

Thanks,

	Ingo
