Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6112C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F8F20657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F8F20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbeJaWRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:17:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:53924 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728894AbeJaWRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:17:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 97CF2AEB2;
        Wed, 31 Oct 2018 13:19:09 +0000 (UTC)
Date:   Wed, 31 Oct 2018 14:19:07 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
cc:     Torsten Duwe <duwe@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, kristina.martsenko@arm.com
Subject: Re: [PATCH v4 1/3] arm64: implement ftrace with regs
In-Reply-To: <20181031121002.hmag2mwvlpzwobvf@lakrids.cambridge.arm.com>
Message-ID: <nycvar.YFH.7.76.1810311417361.30233@cbobk.fhfr.pm>
References: <20181026142008.D922868C94@newverein.lst.de> <20181026142148.6353A68C94@newverein.lst.de> <20181031121002.hmag2mwvlpzwobvf@lakrids.cambridge.arm.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2018, Mark Rutland wrote:

> I guess skipping the original function prologue would simplify the
> implementation of the replacement function (and would mean that the regs
> held the function arguments per the procedure call standard), but AFAICT
> other architectures aren't relying on that, so it doesn't seem to be a
> strict requirement.
> 
> What am I missing?
> 
> How does livepatching handle the pre-mcount function preambles on
> architectures with existing support?

Other architectures do rely on that. That's exactly for example why on x86 
we use '-pg -mfentry', to make sure we hook the function *before* 
prologue.

Thanks,

-- 
Jiri Kosina
SUSE Labs

