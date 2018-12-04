Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61456C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363112082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363112082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbeLDSG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:06:26 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45776 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeLDSGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:06:24 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gUF5I-0003UL-Pc; Tue, 04 Dec 2018 19:06:12 +0100
Date:   Tue, 4 Dec 2018 19:06:12 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pstore: Convert buf_lock to semaphore
Message-ID: <20181204180612.z4az5yplw5oqb26a@linutronix.de>
References: <20181130224736.GA38485@beast>
 <20181204154056.iyf333bcxqwk3obe@linutronix.de>
 <CAGXu5jLUMW3cCi1KVdSmOVn3O9BQ6ptYnyJbLHxojgzXd_YUxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGXu5jLUMW3cCi1KVdSmOVn3O9BQ6ptYnyJbLHxojgzXd_YUxQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-04 09:23:13 [-0800], Kees Cook wrote:
> Okay, so, if kmsg_dump() uses rcu_read_lock(), that means efi-pstore
> can _never_ sleep, and it's nothing to do with pstore internals. :( I
> guess we just hard-code it, then? And efi-pstore should probably only
> attach to pstore if it has a nonblock implementation (and warn if one
> isn't available).

I was about to suggest that. I am not aware if anything else could use
efi_pstore_write() use that but otherwise you could hardcode it.

> -Kees
> 
Sebastian
