Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A84C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E242620851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfAQPsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:48:24 -0500
Received: from verein.lst.de ([213.95.11.211]:38166 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbfAQPsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:48:23 -0500
Received: by newverein.lst.de (Postfix, from userid 2005)
        id EAFF368CEB; Thu, 17 Jan 2019 16:48:21 +0100 (CET)
Date:   Thu, 17 Jan 2019 16:48:21 +0100
From:   Torsten Duwe <duwe@lst.de>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v6] arm64: implement ftrace with regs
Message-ID: <20190117154821.GC9094@lst.de>
References: <20190104141053.360F768D93@newverein.lst.de> <8eb70db4-92a2-95a2-075c-f26690aab3ed@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8eb70db4-92a2-95a2-075c-f26690aab3ed@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 09:57:39AM +0000, Julien Thierry wrote:
> 
> I wanted to test this patch (and try to benchmark having the "mov x9,
> x30" always present in function prelude vs having two nops), but I
> cannot get this patch to apply (despite having a version including both
> commits below).
> 
> Could you provide a git branch from which I could try to rebase the
> patch? (Or a new version of the series)

It also applies with just a single, harmless fuzz 1 onto 5.0-rc2.
Does that help?

I'm currently over v7, with Mark's requests included and the mov patching
done only once at bootup...

	Torsten

