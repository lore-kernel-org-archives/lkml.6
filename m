Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB2AC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98DA20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="U4qKIxNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfAVLzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:55:52 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54376 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728277AbfAVLzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:55:51 -0500
Received: from zn.tnic (p200300EC2BCBD9002C2383DF7DDD45BD.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:d900:2c23:83df:7ddd:45bd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 628D31EC01B6;
        Tue, 22 Jan 2019 12:55:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548158150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BNNH0zhxi5hOlZExdhpYPx7dgckzp7LO6K4U0tPVE44=;
        b=U4qKIxNSThOBp4HxB6VmGuWkt8EzdmPVll/Ducwor2gG69xoWFlfJ3bz8JoE8D3cGGiYwu
        j3ou8y4JybUw3Xu3b2ITQdpW0AjazCack+XQjnQ4bdsVuljPeybh2PldQlbj4Ja8G/RcTq
        I5zoDp13HdOv3nsoQAynFlpaxRPGvng=
Date:   Tue, 22 Jan 2019 12:55:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Philip Li <philip.li@intel.com>
Cc:     kbuild test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, kbuild-all@01.org
Subject: Re: [kbuild-all] arch/x86/include/asm/cmpxchg.h:245:2: error: 'asm'
 operand has impossible constraints
Message-ID: <20190122115544.GC26587@zn.tnic>
References: <201901221204.ZqZgxRnA%fengguang.wu@intel.com>
 <20190122100815.GA26587@zn.tnic>
 <20190122111359.GA9888@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190122111359.GA9888@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 07:13:59PM +0800, Philip Li wrote:
> thanks for the feedback, we will blacklist this. So may i understand based on
> the thread at https://lists.01.org/pipermail/kbuild-all/2018-December/056225.html,
> this is gcc-4.9 problem?

AFAICT, this triggers only on gcc-4.9, 32-bit build. Or do you have
other configurations which trigger it?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
