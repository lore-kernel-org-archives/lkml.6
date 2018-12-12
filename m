Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581B7C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105E920851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 105E920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbeLLT2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 14:28:22 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47870 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbeLLT2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 14:28:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78A7280D;
        Wed, 12 Dec 2018 11:28:21 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 48A193F59C;
        Wed, 12 Dec 2018 11:28:21 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id C59B91AE0BDC; Wed, 12 Dec 2018 19:28:44 +0000 (GMT)
Date:   Wed, 12 Dec 2018 19:28:44 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        linux-hardened@lists.openwall.com,
        Laura Abbott <labbott@fedoraproject.org>
Subject: Re: [PATCH v3] arm64: enable per-task stack canaries
Message-ID: <20181212192844.GA22013@edgewater-inn.cambridge.arm.com>
References: <20181212120844.19268-1-ard.biesheuvel@linaro.org>
 <CAGXu5jK50pY-bOxfE0mjBew_dqFcecKT6_1dd+rYQ5T54-fuDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jK50pY-bOxfE0mjBew_dqFcecKT6_1dd+rYQ5T54-fuDg@mail.gmail.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 09:50:37AM -0800, Kees Cook wrote:
> On Wed, Dec 12, 2018 at 4:08 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > This enables the use of per-task stack canary values if GCC has
> > support for emitting the stack canary reference relative to the
> > value of sp_el0, which holds the task struct pointer in the arm64
> > kernel.
> >
> > The $(eval) extends KBUILD_CFLAGS at the moment the make rule is
> > applied, which means asm-offsets.o (which we rely on for the offset
> > value) is built without the arguments, and everything built afterwards
> > has the options set.
> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

I've bitten the bullet and queued this for 4.21. We can always revert it
if the compiler support falls apart, but at this point the worst I can see
happening is that we have to change the name of an option.

Will
