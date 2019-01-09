Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62904C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA23206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="OfTCfQOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbfAIMOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:14:55 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38328 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730734AbfAIMOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:14:54 -0500
Received: from zn.tnic (p200300EC2BEA1000E56F05EB9FFDE1E7.dip0.t-ipconnect.de [IPv6:2003:ec:2bea:1000:e56f:5eb:9ffd:e1e7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 80E501EC072C;
        Wed,  9 Jan 2019 13:14:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547036093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NCylCB+Zci1N3EZZ2Gu5Vhpnbf+/VuasVuh9mkjJNMA=;
        b=OfTCfQOl0ssH7VNtaZ+n1zTtFTQ3Feyw9joyGYL/xyria1ecQn2FGRDa+v8FmeMNKJHldF
        Vf1+TmnOQoTnJEwlvb4bBLy3yPHMUJeKQMsJcoRkLcWKp4m/NecqNHcUva+fmkPruJxDOX
        rx/1wrIQBw7PDVFx5cb/2qlasHwNYCY=
Date:   Wed, 9 Jan 2019 13:14:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <Babu.Moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jan =?utf-8?Q?H=2E_Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        David Duncan <davdunc@amazon.com>
Subject: Re: [PATCH] x86/intel_rdt: use rdmsr_safe() to workaround AWS host
 issue
Message-ID: <20190109121445.GC15665@zn.tnic>
References: <20181220134046.7916-1-vkuznets@redhat.com>
 <20181220161722.GD31403@zn.tnic>
 <51dcb13a-4751-47f5-1e01-f6731a2c6f3c@intel.com>
 <20521afe-09af-7acf-6f32-3f6e9a971091@intel.com>
 <20190109113915.GB15665@zn.tnic>
 <87bm4qoww4.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bm4qoww4.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 01:09:31PM +0100, Vitaly Kuznetsov wrote:
> Hm, why is that? In theory, hypervisors can pass through or emulate the
> required MSRs...

...and when the theory becomes reality we'll remove the check.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
