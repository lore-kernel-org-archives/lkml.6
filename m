Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB8FC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1224320645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1224320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbeLCLTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:19:04 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:41442 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeLCLTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:19:04 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gTmF1-00030G-Vc; Mon, 03 Dec 2018 12:18:20 +0100
Date:   Mon, 3 Dec 2018 12:18:29 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pstore: Convert buf_lock to semaphore
Message-ID: <20181203111826.ri2csbxs33j34dvo@linutronix.de>
References: <20181130224736.GA38485@beast>
 <CAK8P3a0YGyKf_0wg_sNhN2z-zVvv1N1_Yc=+2AL=8FZT+CRLxQ@mail.gmail.com>
 <CAGXu5jKXEEHbxdG2VzYhUWEPEEJYdCLEY1oF+zm8wOUfdS0v+A@mail.gmail.com>
 <CAK8P3a3xUMnWrSsW6gNwc5y0z-wR23v8Q6TGH+yNpDJq65FeMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a3xUMnWrSsW6gNwc5y0z-wR23v8Q6TGH+yNpDJq65FeMw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-01 09:42:38 [+0100], Arnd Bergmann wrote:
> You are right that you can't take (or release) a mutex from interrupt
> context. However, I don't think converting a spinlock to a semaphore
> is going to help here either.

you can acquire a semaphore with a try_lock from interrupts context but
you can't do that with a mutex. You can also a acquire a semaphore in
one context and release in another. Not that I'm a fan of those things
but those two are often the reasons why people stick with a semaphore.

I haven't looked a general picture yet, will try to do so later today or
tomorrow.

>         Arnd

Sebastian
