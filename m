Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB15C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E088E20844
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="jUcPoSJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730747AbfA3LgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 06:36:05 -0500
Received: from mail.skyhub.de ([5.9.137.197]:58802 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727500AbfA3LgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 06:36:04 -0500
Received: from zn.tnic (p200300EC2BCAED00302FA729E39312A6.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:ed00:302f:a729:e393:12a6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 808081EC05C2;
        Wed, 30 Jan 2019 12:36:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548848163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RnbxQeaeiJXykNiMzCEPP3bGDnRDsBKzyrDwGd+xh5I=;
        b=jUcPoSJOIDzE8QRLd1ibZP31oMUE5jf9/SNbaU8qh0DA5NROUPmQ8vpSyKP//Ec/4x3wSq
        iNZ3FwiJey8MYME48/ngxpLY1TDNdj+QpkHdjWaLf36eZK9hmKz9igL+pec19cM22Y5MN6
        0x4S5Kfr4IQq3uzXA45UxrxU8luzJjI=
Date:   Wed, 30 Jan 2019 12:35:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v6] x86: load FPU registers on return to userland
Message-ID: <20190130113555.GC18383@zn.tnic>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190109114744.10936-1-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:47:22PM +0100, Sebastian Andrzej Siewior wrote:
> This is a refurbished series originally started by by Rik van Riel. The
> goal is load the FPU registers on return to userland and not on every
> context switch. By this optimisation we can:
> - avoid loading the registers if the task stays in kernel and does
>   not return to userland
> - make kernel_fpu_begin() cheaper: it only saves the registers on the
>   first invocation. The second invocation does not need save them again.

Btw, do we have any benchmark data showing the improvement this brings?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
