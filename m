Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4BCC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 23:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D5121473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 23:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qx5aitPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D5121473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbeJDGGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 02:06:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbeJDGGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 02:06:16 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9EAE21473
        for <linux-kernel@vger.kernel.org>; Wed,  3 Oct 2018 23:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538608548;
        bh=JFPTlq2PfmuN5JKVCnGAJUNm/+JcinPRgy+V/LkAlfg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qx5aitPE3DgzujEOYS1F5c/5IYi7X++KFAtGZQiVzigrvwFUBJYqmjZ8Nn3lnlq/T
         o8RktSRXp+kA52OL7rOu5tX3+kRS4mTfL4dAAZAIN7ENR60tRQiS5dYIhbbxAz1P/q
         IJPOOSIoMNbyp2t11JD9TS+zqcuSA3z/90nLLcRA=
Received: by mail-wr1-f48.google.com with SMTP id n1-v6so7878345wrt.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 16:15:47 -0700 (PDT)
X-Gm-Message-State: ABuFfoiRRus+nKE0mfiCjiqmubyi+IpPu1HG00A/fWyaO7vBNciuASi5
        yPnUzvCwhWpsE4xFxhMf9DidOHsIDO9hqg/irF8ZCA==
X-Google-Smtp-Source: ACcGV62jhtv4Lk8z2Rm51/lMcJUvoV/Sa9UwS0wn1CnZVRiKvlAfkPR/k7Zj10d2qM1dNhqUGXyIsd3TYlX29VItDVo=
X-Received: by 2002:a5d:610a:: with SMTP id v10-v6mr2822112wrt.308.1538608546135;
 Wed, 03 Oct 2018 16:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <2c0231690551989d2fafa60ed0e7b5cc8b403908.1538422295.git.luto@kernel.org>
 <tip-715bd9d12f84d8f5cc8ad21d888f9bc304a8eb0b@git.kernel.org>
In-Reply-To: <tip-715bd9d12f84d8f5cc8ad21d888f9bc304a8eb0b@git.kernel.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 3 Oct 2018 16:15:34 -0700
X-Gmail-Original-Message-ID: <CALCETrXMTifqRQjBgXFpQ6kFMYcGirJOYwac8UB1C8RpWmcCqQ@mail.gmail.com>
Message-ID: <CALCETrXMTifqRQjBgXFpQ6kFMYcGirJOYwac8UB1C8RpWmcCqQ@mail.gmail.com>
Subject: Re: [tip:x86/urgent] x86/vdso: Fix asm constraints on vDSO syscall fallbacks
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>
Cc:     linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 11:30 PM tip-bot for Andy Lutomirski
<tipbot@zytor.com> wrote:
>
> Commit-ID:  715bd9d12f84d8f5cc8ad21d888f9bc304a8eb0b
> Gitweb:     https://git.kernel.org/tip/715bd9d12f84d8f5cc8ad21d888f9bc304a8eb0b
> Author:     Andy Lutomirski <luto@kernel.org>
> AuthorDate: Mon, 1 Oct 2018 12:52:15 -0700
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Tue, 2 Oct 2018 08:28:15 +0200
>
> x86/vdso: Fix asm constraints on vDSO syscall fallbacks

Ugh, I broke the 32-bit code and failed to test it right.  Incremental
fix coming.
