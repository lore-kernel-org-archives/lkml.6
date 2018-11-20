Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9F2C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53379208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oDMnKzCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53379208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbeKUCbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:31:05 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35043 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728732AbeKUCbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:31:03 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so1094703pgs.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 08:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DvUoJOin8oF8QpyGvA1ZpCRhZ1YJ0gF1sdpviGxLSQo=;
        b=oDMnKzCBdteQQRJr05BKNPx4cA0kHIKnnj0HW+zIH3uDCAURPkFYNPIPaVauOyXxVN
         IZfurwhVPinLYVirMyXI4DOlIwLUjwQj7jU07Ei5yQt/D+IqDEjjvRKHvd/+q1q4MrAR
         ZVqvOIrZC5qcGtVKzlIAoANEYCPwsCoxJv1YTZRXrXu4MlWicfJ4F/QnOdb02TbnRiCM
         KRGtA+t7xCnb0e+SB58E94AD8kC1CMYaH5Pvhk7iEd1U3wKRSlGPfGaWZaqwNYcAxOEA
         U/AvaVFLyPkyRSSOvlpFsXsGgn0iJx8Iiz9eCd0TkyRpnku+OKr5kDFUrUsPrSNsgta0
         AtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DvUoJOin8oF8QpyGvA1ZpCRhZ1YJ0gF1sdpviGxLSQo=;
        b=aN4GsUAps4Rbxz5me1CELJNszd1n1K4WunHKCb8T0+M9unXJCP3v1Lwa791lLxX1YD
         qQQL5KHRm44dLNtS1rLIka4umoawVBa/icuunDcnDsteEaIJdHZBgJto0+QqcJlWaLhH
         2+DmmNp/uk8czUIOcAAjU6S1S9Hfn112AgUCqoDGiHdj7eGLcI+6e7NWnBWc6lNUC638
         HFiX4qur+TYLAU7cCrQoB2E36B5GX3g5mJaP21u8WfwSE0VcCMYosvflr5j/Epf8Vjm0
         +JgEdydDQQySsYto7H/QUY3aoN/CHAv70hTbBBJAwkdh/rZVCxyHAG/zSyE7hHF0Alhu
         Q/Dg==
X-Gm-Message-State: AGRZ1gJvWfUA9xb1GsBUOKFhgynO/NLrSj06DMaVMiDPR+P1qZwLpoIS
        nmLVEyWbakdl3KSaQyyD2atm8Q==
X-Google-Smtp-Source: AJdET5eMWu+Htowk8HXsXRKZlXNRSGx7cpS6cAbREtozRO+eLRT26Mcx2vS/pyyLn4PRh34ewL8uPw==
X-Received: by 2002:a62:b2c3:: with SMTP id z64mr2728281pfl.120.1542729673504;
        Tue, 20 Nov 2018 08:01:13 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id s184sm49007013pgc.38.2018.11.20.08.01.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 08:01:12 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gP8Sd-00062G-4O; Tue, 20 Nov 2018 09:01:11 -0700
Date:   Tue, 20 Nov 2018 09:01:11 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Microchip (AT91) SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 05/17] tpm: declare struct tpm_header
Message-ID: <20181120160111.GA22023@ziepe.ca>
References: <20181118124753.18613-1-jarkko.sakkinen@linux.intel.com>
 <20181118124753.18613-6-jarkko.sakkinen@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DA235BB@hasmsx108.ger.corp.intel.com>
 <20181120130805.GD8813@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120130805.GD8813@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 03:08:05PM +0200, Jarkko Sakkinen wrote:
> On Mon, Nov 19, 2018 at 09:33:31PM +0000, Winkler, Tomas wrote:
> > 
> > > 
> > > Decleare struct tpm_header that replaces struct tpm_input_header and
> > Typo 
> 
> Thanks, will fix for the next version.
> 
> > > struct tpm_output_header.
> > > 
> > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > >  drivers/char/tpm/tpm-interface.c  |  9 ++++-----
> > >  drivers/char/tpm/tpm.h            | 27 ++++++++++++---------------
> > >  drivers/char/tpm/tpm2-cmd.c       |  4 ++--
> > >  drivers/char/tpm/tpm2-space.c     |  6 +++---
> > >  drivers/char/tpm/tpm_i2c_atmel.c  |  5 ++---
> > > drivers/char/tpm/tpm_vtpm_proxy.c |  8 ++++----
> > >  drivers/char/tpm/xen-tpmfront.c   |  2 +-
> > >  7 files changed, 28 insertions(+), 33 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-
> > > interface.c
> > > index 7ac6ada8428c..cb0d44c158ae 100644
> > > +++ b/drivers/char/tpm/tpm-interface.c
> > > @@ -67,7 +67,7 @@ static int tpm_validate_command(struct tpm_chip
> > > *chip,
> > >  				 const u8 *cmd,
> > >  				 size_t len)
> > >  {
> > > -	const struct tpm_input_header *header = (const void *)cmd;
> > > +	const struct tpm_header *header = (const void *)cmd;
> > 
> > 
> > Sometimes it is casted (void *), sometimes (struct tpm_header *)
> > Better to use one convention 
> 
> I would prefer (const void *) because it is shorter form, and no
> need to duplicate the type name two times, that way also more
> readable. Anyway, agreed that we do have inconsistency with these.

It is better to pass in 'const void *cmd' than to explicitly cast like
this.

I generally discourage casts to voids to save typing, just creates
confusion what is going on. Better to try to avoid casts by
constructing the code properly.

Jason
