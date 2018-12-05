Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D93FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4CF6208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="HOJG1t2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CF6208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbeLETEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:04:00 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59272 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbeLETD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:03:59 -0500
Received: from zn.tnic (p200300EC2BC09900ED3DB18DCE3E6DEF.dip0.t-ipconnect.de [IPv6:2003:ec:2bc0:9900:ed3d:b18d:ce3e:6def])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7694F1EC0BA2;
        Wed,  5 Dec 2018 20:03:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544036638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kAPA4uSupwkzbxl3zVwAPfGw9r7IX7xp+JMX3WI/ayI=;
        b=HOJG1t2sGaH41B/rTjUXf04YrRO7xU0stPKqVSr9vLIKBImkryRJXdP6RaGkW6hfON6yjQ
        on9AHGgORCRn2s28kJ1CSCbVYBkeGTB4hxprE6dT42YFWBnASQc9l+PtiVJ/kLcc+P8hon
        W1hwsK9YdhcYpYtFbO/6HIgdRHrtjdc=
Date:   Wed, 5 Dec 2018 20:03:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>, X86 ML <x86@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] x86/mce: Streamline MCE subsystem's naming
Message-ID: <20181205190355.GP29510@zn.tnic>
References: <20181205141323.14995-1-bp@alien8.de>
 <20181205163037.GC109259@gmail.com>
 <20181205170006.GK29510@zn.tnic>
 <20181205180158.GA64770@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181205180158.GA64770@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 07:01:58PM +0100, Ingo Molnar wrote:
> Oh - I thought we'd have arch/x86/mce/ or so?
> 
> There's machine check events that are not tied to any particular CPU, 
> correct? So this would be the right conceptual level - and it would also 
> remove the somewhat redundant 'kernel' part.

Well, all the MCE events reported are some way or the other tied to the
CPU and they're reported in the CPU's MCA banks so I think we want

	arch/x86/cpu/mce/

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
