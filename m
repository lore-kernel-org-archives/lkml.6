Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E77C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D5220878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eLEGM5xI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D5220878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeJBPdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:33:06 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58318 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbeJBPdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fSN9y8o955sD9TRd29VV8ptlopxGxFGUqtBgMwhi/20=; b=eLEGM5xISkeufDBnBoKF2ZaQ2
        LG5dfwwM7DpBWc+xuaaLdr/eBPWDO013U5bK64kIFDtZ8WGVB8IPFEzV6FzaC5d6L7BxkIrXgIiyP
        THiH3ulFln/rHlpKGCtkZmzEBK6G87n0IkTso+Cyi/qNoJbYeYBElb+etgDv1Vi5YgBAU=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:42632)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1g7GOE-0002fw-Vo; Tue, 02 Oct 2018 09:50:47 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1g7GOB-0008B7-DN; Tue, 02 Oct 2018 09:50:43 +0100
Date:   Tue, 2 Oct 2018 09:50:41 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Pinski <apinski@cavium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Jeremy Linton <Jeremy.Linton@arm.com>
Subject: Re: RESEND and REBASE arm+arm64+aarch32 vdso rewrite
Message-ID: <20181002085041.GV30658@n2100.armlinux.org.uk>
References: <20181001175845.168430-1-salyzyn@android.com>
 <CALAqxLWCbw0bmYeB9Vfi5wXJcnLRnE0TYxy1h5WkHLehHv8KFg@mail.gmail.com>
 <8c09a380-7bc8-a353-aeb7-6591e6c57f68@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c09a380-7bc8-a353-aeb7-6591e6c57f68@android.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 01:44:52PM -0700, Mark Salyzyn wrote:
> Despite the gain of 0.4% for screen-on battery life, where Android has a mix
> of 64 and 32 bit applications, thus still relevant _today_ on 64 bit
> architectures (providing vDSO32 for 32-bit applications).

I don't think the issue is what you think it is.  0.4% gain is
equivalent to almost (but not quite) 1 minute extra for a lifetime of
4 hours.  Is that really noticable, and is it worth the churn from
merging this series?

Given that the gain is so marginal, I can see why people find it
difficult to get excited about this series to spend the time reviewing
it.

What I'm saying is that the reason that people should look at this
series hasn't been "sold" particularly well.  How does it look from
the system performance point of view - is there a speed-up there
that's more significant?

In any case, I suspect that if you compare the battery life from
kernels from two years ago with modern kernels, you'll see a
degredation over that period just because of the progressive
increase in complexity, and especially things such as the Spectre
work-arounds.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
