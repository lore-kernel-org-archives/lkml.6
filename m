Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ADDC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC1320656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389365AbfAOTfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:35:40 -0500
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:58160 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731673AbfAOTfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 14:35:40 -0500
Received: from g9t5010.houston.hpe.com (g9t5010.houston.hpe.com [15.241.48.74])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id E280162424;
        Tue, 15 Jan 2019 19:35:46 +0000 (UTC)
Received: from sarge.linuxathome.me (unknown [16.214.81.200])
        by g9t5010.houston.hpe.com (Postfix) with SMTP id D4F934A;
        Tue, 15 Jan 2019 19:35:35 +0000 (UTC)
Date:   Tue, 15 Jan 2019 19:35:34 +0000
From:   Hedi Berriche <hedi.berriche@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russ Anderson <rja@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>
Subject: Re: [PATCH 1/3] efi/x86: turn EFI runtime semaphore into a global
 lock
Message-ID: <20190115193534.GK12284@sarge.linuxathome.me>
Mail-Followup-To: Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russ Anderson <rja@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>
References: <20190109104541.25733-1-hedi.berriche@hpe.com>
 <20190109104541.25733-2-hedi.berriche@hpe.com>
 <alpine.DEB.2.21.1901151953370.1655@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1901151953370.1655@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 18:55 Thomas Gleixner wrote:
>On Wed, 9 Jan 2019, Hedi Berriche wrote:
>
>> Make efi_runtime_lock semaphore global so that it can be used by EFI
>> runtime callers that may be defined outside efi/runtime-wrappers.c.
>
>The changelog should mention why the lock is renamed.

OK; will add to V2 that it was renamed so that it doesn't clash with the
efi_runtime_lock spinlock defined by CONFIG_EFI_MIXED.

>I have no strong opinion, but to apply that I need an Ack from Ard.

OK; thanks for the feedback.

Cheers,
Hedi.
-- 
Be careful of reading health books, you might die of a misprint.
	-- Mark Twain
