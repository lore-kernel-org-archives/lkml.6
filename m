Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vRKTN0ddGVsaKgAAmS7hNA
	; Thu, 07 Jun 2018 16:31:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B7BD56089E; Thu,  7 Jun 2018 16:31:08 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H9uRxd3T"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 129BE6074D;
	Thu,  7 Jun 2018 16:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 129BE6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933058AbeFGQbF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:31:05 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40530 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932800AbeFGQbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:31:02 -0400
Received: by mail-pf0-f194.google.com with SMTP id z24-v6so5169739pfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 09:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LmjOKOU3NiZ+kX6Fvb+JFGRhyeSq9tvKFENb6ETDSSA=;
        b=H9uRxd3TdLshlaX3uRRf3TPkmsEYAjSTy9EQFX1xrAYVmQqrVNn9pVzsIxGzfzcRGm
         ziUhH7DX2T2+Q1YSQQxLo7HeYQECyVuckfait5dblhrN4hWl+tTUwW9stAfWonypDK6D
         WOR3LhVTLgDAH2y3Dn/0uH92nmi8h/g8n/odM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LmjOKOU3NiZ+kX6Fvb+JFGRhyeSq9tvKFENb6ETDSSA=;
        b=UZr0zOhaJsFvsy1+niqHtXrjzE/vBxX91/xzBGRLLdhZ5ORE9s22T3aVWqUTGGXXqk
         Rk67C2UbwJuVonHjmMx1NUye9kwIluVD98965b+A0FJDfaE4S+rnzKlhgvEzAvBieaxB
         l7rLYaoRtdq/RsGv4yN6W3xaAMxEeAYPDrWYQnWIls35A1yEDVn1Ksr6lkHLDqxxYkUn
         t1Iydhbh9PfvBVlklwVgTxZHThHkyrPk+HlYvPE8EPVAS7wVEWkCyY/2smmIzIyptQ7e
         N/Ij9D45Ug2IRNWrno8bTa7x8XW+oMp6qnvPGic7IP3CP1EF+FJTrkDtWXfp/S07BZwi
         sPzw==
X-Gm-Message-State: APt69E1LeJu9VYJVuHjczEagqbyDgiWjpri3ERlSLg6R22WW3mgpbmce
        5dnvo4ff0pXJHJ5vtDTcOM/hvQ==
X-Google-Smtp-Source: ADUXVKKLxA8BqBviWjuF5d7t8QDiTzcQDNxeafQ36wFRFV/b9ELmw2XJ7D8mFbMxqVGEz9HjZiLadA==
X-Received: by 2002:aa7:85c9:: with SMTP id z9-v6mr2386579pfn.55.1528389061838;
        Thu, 07 Jun 2018 09:31:01 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b72-v6sm23924665pfj.56.2018.06.07.09.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 09:31:00 -0700 (PDT)
Date: Thu, 7 Jun 2018 09:33:07 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-security-module@vger.kernel.org,
        Chris Wright <chrisw@sous-sol.org>,
        David Howells <dhowells@redhat.com>,
        Alan Cox <alan@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Josh Triplett <josh@joshtriplett.org>,
        dmitry.torokhov@gmail.com, mfuzzey@parkeon.com,
        Kalle Valo <kvalo@codeaurora.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        nbroeking@me.com, Torsten Duwe <duwe@suse.de>, x86@kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] efi: Add embedded peripheral firmware support
Message-ID: <20180607163307.GO510@tuxbook-pro>
References: <20180408174014.21908-1-hdegoede@redhat.com>
 <20180408174014.21908-3-hdegoede@redhat.com>
 <20180423211143.GZ14440@wotan.suse.de>
 <71e6a45a-398d-b7a4-dab0-8b9936683226@redhat.com>
 <1524586021.3364.20.camel@linux.vnet.ibm.com>
 <20180424234219.GX14440@wotan.suse.de>
 <1524632409.3371.48.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1524632409.3371.48.camel@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24 Apr 22:00 PDT 2018, Mimi Zohar wrote:
> On Tue, 2018-04-24 at 23:42 +0000, Luis R. Rodriguez wrote:
> > On Tue, Apr 24, 2018 at 12:07:01PM -0400, Mimi Zohar wrote:
> > > On Tue, 2018-04-24 at 17:09 +0200, Hans de Goede wrote:
[..]
> > > > As such the current IMA code (from v4.17-rc2) actually does
> > > > not handle READING_FIRMWARE_PREALLOC_BUFFER at all, 
> > > 
> > > Right, it doesn't yet address READING_FIRMWARE_PREALLOC_BUFFER, but
> > > should.
> > > 
> > > Depending on whether the device requesting the firmware has access to
> > > the DMA memory, before the signature verification, 
> > 
> > It would seem from the original patch review about READING_FIRMWARE_PREALLOC_BUFFER
> > that this is not a DMA buffer.
> 
> The call sequence:
> qcom_mdt_load() -> qcom_scm_pas_init_image() -> dma_alloc_coherent()
> 

qcom_mdt_load() is passed a struct firmware object, which "data" is
passed into qcom_scm_pas_init_image(), which uses dma_alloc_coherent()
to allocate scratch memory to perform a call into secure world. So the
dma_alloc_coherent() here has nothing to do with firmware loading.

qcom_mdt_load() will then use request_firmware_into_buf() to load other
files into the passed void *mem_region, which either comes from a
memremap() or dma_alloc_coherent() call.

> If dma_alloc_coherent() isn't allocating a DMA buffer, then the
> function name is misleading/confusing.
> 

It does allocate memory.

> > 
> > The device driver should have access to the buffer pointer with write given
> > that with request_firmware_into_buf() the driver is giving full write access to
> > the memory pointer so that the firmware API can stuff the firmware it finds
> > there.
> > 
> > Firmware signature verification would be up to the device hardware to do upon
> > load *after* request_firmware_into_buf().
> 
> We're discussing the kernel's signature verification, not the device
> hardware's signature verification.  Can the device driver access the
> buffer, before IMA-appraisal has verified the firmware's signature?
> 

I would expect that it's possible to read the content of the buffer from
a secondary execution context before the request_firmware_into_buf() has
verified the content of the buffer, but I would be considered a
seriously broken driver.

Regards,
Bjorn
