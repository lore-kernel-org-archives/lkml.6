Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C437FC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 16:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7037D208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 16:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="h/yz79Az"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7037D208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934171AbeFQQff (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 12:35:35 -0400
Received: from one.firstfloor.org ([193.170.194.197]:48290 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933875AbeFQQfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 12:35:34 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 2810D868EF; Sun, 17 Jun 2018 18:35:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1529253332;
        bh=2GjcbqoNDGb+mBj0Bw3sZ1WewKWaV1YFE88dr23lBqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h/yz79Azjp599++UEGfH5EsRkmL18/325XpKSXKmDwE0lZJ3lUPudqq7ijxiRCata
         SFKDeJRQQosuTLKhJxjikhARRG1LFNl+Jox06Sete3Gq53KgfBL7hXXdbiYmkGXv6s
         ls1SPq0t58TH+UMvKMoUTcj85m4Mbl+G2ImGV8+U=
Date:   Sun, 17 Jun 2018 09:35:31 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Kyle Huey <khuey@kylehuey.com>,
        Robert O'Callahan <robert@ocallahan.org>
Subject: Re: [RFC PATCH] x86/arch_prctl: Add ARCH_SET_XCR0 to mask XCR0
 per-thread
Message-ID: <20180617163530.rvwf7fcukmoletgo@two.firstfloor.org>
References: <1529195582-64207-1-git-send-email-keno@alumni.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529195582-64207-1-git-send-email-keno@alumni.harvard.edu>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Patch seems pointless if you can already control CPUID, which rr
supports. Just disable AVX512 in CPUID. All code using AVX should check
cpuid (or will fail anyways). 

-Andi
