Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D97C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F79D21916
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbfBAKvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:51:55 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57826 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729451AbfBAKvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:51:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD6B280D;
        Fri,  1 Feb 2019 02:51:54 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A82B3F71E;
        Fri,  1 Feb 2019 02:51:53 -0800 (PST)
Date:   Fri, 1 Feb 2019 10:51:44 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
Cc:     'James Morse' <james.morse@arm.com>,
        'Mark Rutland' <mark.rutland@arm.com>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Message-ID: <20190201105144.GA27140@fuggles.cambridge.arm.com>
References: <8898674D84E3B24BA3A2D289B872026A6A2C04E6@G01JPEXMBKW03>
 <cb7544e2-bd85-df4c-1f48-0afeedefc962@arm.com>
 <8898674D84E3B24BA3A2D289B872026A6A3090AC@G01JPEXMBKW03>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A6A3090AC@G01JPEXMBKW03>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 05:53:50AM +0000, Zhang, Lei wrote:
> > -----Original Message-----
> > From: linux-arm-kernel
> > [mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf Of
> > James Morse
> > Sent: Thursday, January 31, 2019 12:00 AM
> > To: Zhang, Lei/張 雷
> > Cc: 'Mark Rutland'; 'Catalin Marinas'; 'will.deacon@arm.com';
> > 'linux-kernel@vger.kernel.org';
> > 'linux-arm-kernel@lists.infradead.org'
> > Subject: Re: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX
> > erratum 010001
> > 
> > 
> > e03e61c3173c ("arm64: kaslr: Set TCR_EL1.NFD1 when
> > CONFIG_RANDOMIZE_BASE=y") ?
> > 
> > So you'd never see it if you disabled CONFIG_RANDOMIZE_BASE?
> For security, it is necessary to set CONFIG_RANDOMIZE_BASE=y.

So I guess we should boot with NFD1 clear, and then set it only when we
realise we're not on an A64FX?

Will
