Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF1AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A82A20989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="dYTA0e/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A82A20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbeKUVax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 16:30:53 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55302 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbeKUVaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 16:30:52 -0500
Received: from zn.tnic (p200300EC2BD0AB00883B4D3E2A7F8FA4.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:ab00:883b:4d3e:2a7f:8fa4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 682321EC04DA;
        Wed, 21 Nov 2018 11:56:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542797816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/zraq5vVD806OO6f5dqaANQaX+g2z4si1C3IbP11r34=;
        b=dYTA0e/PaTj3XOncm5sVqGSvp+0pggT80i/cNyq+nZITTb/jXzzrHZQuhy90G88R0GDdUx
        JX2/W9QM7zlsIlJvyFbj59fxsi123AtZqDF3ZT5FllMaAKqB8LLOtPQVUIypTbW/D9l4vh
        EY04+EGnr+N7OSJG9393qfuTo/VyJm4=
Date:   Wed, 21 Nov 2018 11:56:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Victoria Anosova <v.s.anosova@gmail.com>
Cc:     sashal@kernel.org, bigeasy@linutronix.de, x86@kernel.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] x86/fpu: Disable BH while while loading FPU registers
 in __fpu__restore_sig()
Message-ID: <20181121105649.GB27797@zn.tnic>
References: <20181119160410.ne7oiq2gkwt6jiqg@linutronix.de>
 <20181120132531.6E80C206BB@mail.kernel.org>
 <20181120183443.GJ2527@zn.tnic>
 <CAMU5Q=72mNG4ikXKpLK3=SiDK3dRXtCw7wpHZ2i==awrtvRwdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMU5Q=72mNG4ikXKpLK3=SiDK3dRXtCw7wpHZ2i==awrtvRwdg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 11:11:18AM +0500, Victoria Anosova wrote:
> Glad this come to kernel. We've already applied this patch.

The current version, with the bottom half toggling or the original one
with preempt_disable/enable?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
