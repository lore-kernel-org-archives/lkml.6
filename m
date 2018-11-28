Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1F4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E667208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sc2Hh870"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E667208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbeK1Ug2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:36:28 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44308 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbeK1Ug2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:36:28 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so21232778wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 01:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=M/EBTVrOB+AG7dPL21MbNZywOHLPM/2eMyhUXx4pZpk=;
        b=Sc2Hh870Nx5CSa7DmWgPShqpc4fMCKFpowj+kZIR/7zZlG0yRiaevnHHukpokPxj+0
         H+IcDGcHFrbf43CJvz3ngYCnUA6m/NYUxLUBKfzxwJNURfMV1omHuwwitfnZe/PlU7r6
         DV/iPgjmUBjJ7yKICnNDN7PpiJKvLqnqW9LiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=M/EBTVrOB+AG7dPL21MbNZywOHLPM/2eMyhUXx4pZpk=;
        b=s4lpBQYtjik7jjcLpQ4gyIcdL6yDRdEjVT7xTlILDEu5Q+A5CJNWvLNyPiaNuWQ3v/
         XwXpY+BWoyJ1ehgNXlm+4bmdOydkp38oEScPhYXhLyvSLrZrkCcqB8V+Sf2U4hskK60R
         edghGG6OwCNsKAZ+QxVQLvBpBwlc89UUHVS4qXRZLxWej9nfOU7yhWP/+hPiWLZ+lHOz
         bSQl0ae1X6/39W9PPwPYznVCZAmPFN2RcvCRdUqlInP1dXRYU3Js7yclIWX3VIdyllTH
         TLJm9FcEmCoQuwVtU0+D/k0rX6I629bUPSzqDvKDMfajP1wCp2FOaRTqm4gjey/qZArX
         ai5g==
X-Gm-Message-State: AA+aEWbHinULIc0brdVnPsIUfJs+E2azJXBo73gqaD9JfvE6LEUWZbmY
        78AXQ76sm/dPkWN9GDK7baMPSIHDbDA=
X-Google-Smtp-Source: AFSGD/XSVTgbcQeUHq3/kFVh20VI/BdmdMWmF18OIrfyCYDY+74Dwn7QSMHX/DDGgB5E7WuoekNUXQ==
X-Received: by 2002:a5d:63c3:: with SMTP id c3mr29808376wrw.215.1543397726655;
        Wed, 28 Nov 2018 01:35:26 -0800 (PST)
Received: from dell ([2.31.167.233])
        by smtp.gmail.com with ESMTPSA id r76-v6sm1904911wmb.21.2018.11.28.01.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 01:35:26 -0800 (PST)
Date:   Wed, 28 Nov 2018 09:35:24 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, David Dajun Chen <dchen@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH 02/11] mfd: da9055-core: make it explicitly non-modular
Message-ID: <20181128093524.GD4272@dell>
References: <1542861179-8941-3-git-send-email-paul.gortmaker@windriver.com>
 <201811231036.wIjm7GBh%fengguang.wu@intel.com>
 <20181123031456.GD14659@windriver.com>
 <20181123144328.GE14659@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181123144328.GE14659@windriver.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018, Paul Gortmaker wrote:

> [Re: [PATCH 02/11] mfd: da9055-core: make it explicitly non-modular] On 22/11/2018 (Thu 22:14) Paul Gortmaker wrote:
> 
> > [Re: [PATCH 02/11] mfd: da9055-core: make it explicitly non-modular] On 23/11/2018 (Fri 10:21) kbuild test robot wrote:
> > 
> 
> [...]
> 
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > >    drivers/mfd/da9055-i2c.o: In function `da9055_i2c_remove':
> > > >> drivers/mfd/da9055-i2c.c:53: undefined reference to `da9055_device_exit'
> > 
> > Thanks for the report -- I'll look into what causes it, why my testing
> > didn't see it, and get an update to Lee as soon as possible.
> 
> OK, mystery solved.  I chose this smaller subset of MFD "simple" patches
> from my pending queue of MFD patches - to create a reasonable sized
> maintainer-friendly send, based on patches with zero runtime changes.
> 
> My other pending MFD patches have a trivial runtime behavior change;
> deleting a ".remove" field/function - that will never be used for a
> non-module case, but in theory could be (pointlessly) triggered by
> forcing a driver unbind.  (see mainline 98b72b94def9 as an example)
> Patches like this were left behind for a future send batch.
> 
> Unfortunately that allowed me to overlook the fact that patch #2 link
> depended on the below ".remove" patch (not sent) to be applied 1st.
> 
> Lee, what would you like to have happen?  I can resend the queue with
> this patch, or I can resend with #2 being temporarily deferred until
> a future patch batch that has the below da9055-i2c in it, or ...
> 
> Whatever is easiest for you - let me know.

Just send them all.

I'm going to have to review them all at one time or another.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
