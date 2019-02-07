Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F662C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453932147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BWYF90HK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfBGOVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:21:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39512 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfBGOVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:21:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id f16so17272wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 06:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gz2dPntIwgNYepmZg5UEJH0ebbq1Vw9WirU9NneIHWE=;
        b=BWYF90HK1l3yNFv0M4SA9VIcu9Ul2U3Y/J6A3uMg1VNT/AFu60W99A4GrvuLVP6wJI
         3IGaCKBhCHnZl7IaYV2S9FAQiLinTwOwrbFIh954BNQGDI9YZcDp/zDbVLLFpPkV0lPV
         y55TDENE+cEYQq1Zfp0+fWliWLe6o2iCbDhtQs7ZavBYDyAYcAW9YzD17S4CG5ULNptb
         i3H6ZtfJBn2K3zTzFpAMaz/bZjxma9OIE+v0pHWmlh8AJLO5nCxgqLwOqHU7p5M/W/xH
         wBcJ09m4SwK79+I14pue3Tcg+UnvRINmXtmCy16Ji/r6TpannFmIxmiOvSQjbFSJVrCF
         p+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gz2dPntIwgNYepmZg5UEJH0ebbq1Vw9WirU9NneIHWE=;
        b=Nbfhe55SVuYb9SEMwop/xHUQZuZQWCtOuZjWY7b0IpJRpHQEbquOEBR3OFyhVkZc9H
         YSgaEffMLIVAkPYij5bXBK363jcxIYgu1Tn4nDzU+MtFfl9GqxM6E6C6Anumu3v+DhXE
         A1+2CiqEFlkpF/5s6I0+SZUD8Eb7I1m8+0zrwPwW8o9VWhFX/iQ/L4yr/S42UY8apDkV
         ci6K5/u0RA8s+mwc3wIedxI5oER5jrsf3Hk4TNrApznYfVUC0Dyf7kGJjSyqmhpEY7MV
         B2A3f7QxjzOxTNIW0RizxAaG57Ir4Ajuq8wy/Ls71SiAUexdkamV8RdAZwAhFleMPIf2
         HKtA==
X-Gm-Message-State: AHQUAuZofov/DadMCbnM0Eh4zWyfvauD/0US32n+L47lQB/NdVqUhpl6
        kEXl101Y5fl4+43gZSh3VhttAg==
X-Google-Smtp-Source: AHgI3IbyNn6jHLOmwmrqSWwF69QL8KRFYNT79r1quOGgvIBj4O21mSqu3Htj3rovHnqsrRqMUIrXTQ==
X-Received: by 2002:a7b:c92d:: with SMTP id h13mr7479890wml.96.1549549291195;
        Thu, 07 Feb 2019 06:21:31 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id f187sm21405314wma.4.2019.02.07.06.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 06:21:29 -0800 (PST)
Date:   Thu, 7 Feb 2019 14:21:27 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Julien Thierry <julien.thierry@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com, will.deacon@arm.com,
        mark.rutland@arm.com
Subject: Re: [PATCH v10 00/25] arm64: provide pseudo NMI with GICv3
Message-ID: <20190207142127.he2vbe4ts5fmhtmy@holly.lan>
References: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
 <20190206102706.GA92291@C02TF0J2HF1T.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206102706.GA92291@C02TF0J2HF1T.cambridge.arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 10:27:07AM +0000, Catalin Marinas wrote:
> Hi Julien,
> 
> On Thu, Jan 31, 2019 at 02:58:38PM +0000, Julien Thierry wrote:
> > This series is a continuation of the work started by Daniel [1]. The goal
> > is to use GICv3 interrupt priorities to simulate an NMI.
> > 
> > The patches depend on the core API for NMIs patches [2]. Both series can
> > be found on this branch:
> > git clone http://linux-arm.org/linux-jt.git -b v5.0-pseudo-nmi
> 
> I queued these patches in the arm64 for-next/core, on top of Marc's
> generic-nmi branch:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms irq/generic-nmi
> 
> I'll push the changes out later today, once my tests finished.
> 
> Thanks for pushing this series through.

Absolutely! Very excited to see you carry it so far.


Daniel.
