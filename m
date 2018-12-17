Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF015C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D48620874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Ux+xI2SJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388610AbeLQSL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:11:58 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42186 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733062AbeLQSL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:11:57 -0500
Received: by mail-qt1-f194.google.com with SMTP id d19so15120676qtq.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 10:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CNH8ATIus5G0n9jvZwP7TFvr5uaIx9b/5ttb279alu0=;
        b=Ux+xI2SJQggLV8kCMlEkEgsF43N0kHlHg7RWmZ1/7nlarCAZ02NPHJT8gfQrKKhpCf
         d8aTbajB3IMWEr7HyqfViVnXsZ2XWcEnwFQads/f8uMzKwbtqTzaHMX2vBFNfsqAjmIh
         HLCLZaqawpMbP12IaUgYaeUw1+W9rUbhRgmvJfvC6M9ad2DQWp5UGfYasEJ2rsOM11ye
         bYXk3y61+0UQQT2TEcEg3sBSD/u4qTwyH7Qn0cL9VjDZ5w3/XB1SlpMYoHPq3YqjiOt8
         FSEKtKJRIyPqCMyyBzWikDb/T1CbMKun8Ne1hDUyzsS1rjCZhkSLWqRlh7nVoopIT/JS
         FvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CNH8ATIus5G0n9jvZwP7TFvr5uaIx9b/5ttb279alu0=;
        b=hxzzqhkWCk53S6zVsX7WpBm8sxzmci3rH4XLAC7N3/uK0nQl+9aVGQyvNVCeqPJH9K
         bPX6tfewUOKbG78bKWsFamET3RqkHiYDbZwJuVLxsELsEsbEnj6P1sL/gOY1b2SeHsrm
         /uXJgctDYUf44rK0ALU81tx6AcIyuI7fs4bvjzXR+wXao9bs7c1n99jjUrslO0a3wmhJ
         35DbuzOP6hpnxCGZT/EfRrJE1fVZ66dCG92D4gSbLUkTJ7pwrT29Fwde/vu82WolrJqO
         Y/wYNHkJT40+ngDRrf4CpcGbCp87Uge42ESzT0JoZCgrogulXosh/xuk5yGmj6paNe7Z
         dAEw==
X-Gm-Message-State: AA+aEWYqC8LwnU2hBLx/7LH3+LmXM+z2XeoVcfUx6uMnjoKuIUsvo1je
        68a6oJQU6jprzltRN8AKyYmsJg==
X-Google-Smtp-Source: AFSGD/XIDcBPqdvC5aE5va9TtCfgmhAbG/ONl61AQJuEnsn5W1KTEIzNIBHt028DqmYA4nqSHrKzFw==
X-Received: by 2002:a0c:8ae3:: with SMTP id 32mr14079695qvw.27.1545070316322;
        Mon, 17 Dec 2018 10:11:56 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z30sm8608780qtz.26.2018.12.17.10.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 10:11:55 -0800 (PST)
Message-ID: <1545070314.18411.19.camel@lca.pw>
Subject: Re: [PATCH] kbuild: error for CONFIG_ORC_UNWINDER is too much
From:   Qian Cai <cai@lca.pw>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        mingo@kernel.org, bp@alien8.de, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Date:   Mon, 17 Dec 2018 13:11:54 -0500
In-Reply-To: <20181217174936.ouhelssdkshclrr6@treble>
References: <869bc700-1d6d-b950-76c7-5d0fc589152c@lca.pw>
         <20181217161728.6875-1-cai@lca.pw> <20181217170305.chni6e5vmev7hp4r@treble>
         <1545066839.18411.17.camel@lca.pw> <20181217174936.ouhelssdkshclrr6@treble>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-17 at 11:49 -0600, Josh Poimboeuf wrote:
> On Mon, Dec 17, 2018 at 12:13:59PM -0500, Qian Cai wrote:
> > On Mon, 2018-12-17 at 11:03 -0600, Josh Poimboeuf wrote:
> > > On Mon, Dec 17, 2018 at 11:17:28AM -0500, Qian Cai wrote:
> > > > Since ifdef will be evaluated immediately in the first phrase of the
> > > > Makefile read-in, there is no guarantee that the value for
> > > > CONFIG_ORC_UNWINDER will be up-to-date until in the second phrase that
> > > > this recipe is ran.
> > > > 
> > > > include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
> > > > 	$(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
> > > > 
> > > > Hence, change error to warning as this is essentially a best guess. The
> > > > original bug can be reproduced this way,
> > > 
> > > But this still doesn't fix the root of the problem, that the check
> > > relies on a stale auto.conf.
> > > 
> > 
> > Yes, but it at least let people to be able to continue compiling kernel
> > without
> > prematurely being terminated incorrectly. The good thing is that that check
> > will
> > be triggered again to print out the right message once auto.conf has been
> > synced
> > up.
> > 
> > # make
> > Makefile:966: "Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y,
> > please
> > install libelf-dev, libelf-devel or elfutils-libelf-devel"
> >   HOSTCC  scripts/kconfig/conf.o
> >   HOSTLD  scripts/kconfig/conf
> > scripts/kconfig/conf  --syncconfig Kconfig
> > Makefile:968: "Cannot use CONFIG_STACK_VALIDATION=y, please install libelf-
> > dev,
> > libelf-devel or elfutils-libelf-devel"
> 
> Instead of giving false (or silent) warnings, why not just fix the real
> problem?

The purpose of this patch here is to fix or revert the regression introduced by
3dd40cb320f (objtool: Upgrade libelf-devel warning to error for
CONFIG_ORC_UNWINDER).

> 
> Also the error exists for a reason: if the user misses the warning then
> the ORC unwinder is broken and oops stack dumps are much less useful.
> 

This is a separate issue. I am all ears if anyone has a better ideal to fix both
issues at the same time.
