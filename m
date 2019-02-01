Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ABAC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41ECF20855
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GxrdaUgc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbfBAPI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:08:29 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38990 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbfBAPI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:08:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so7450285wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 07:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XmHbHurpXr45zmXaYN4tL8jkSFGSEVnIgxx7tXU33No=;
        b=GxrdaUgcOldp+0cYO/ynxG9pq20/SrGA/wRQ04b8NbASecPugOdH/YWNk/vLhRZd7G
         z02yiJvEgA9wxNKMaCkQRG3VC8xueCbweAT+UXzFKiTLXJuDJ+b7t/w6qA0lIoynB5He
         l5hITlsEjKE/TXZazwuAqcGcbbfBTUqv3Bw0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XmHbHurpXr45zmXaYN4tL8jkSFGSEVnIgxx7tXU33No=;
        b=mEk7IaEM2KwLsLPK0cZUiPqZL4viGJBAcXDmQu7kAjlCNTObiSoWZbM4Bg/rKxFITM
         ld97vlQ23/GQ0wcFmUJfh8DGMvvFCgs6a46GIrIRtCihqztG+Iv9SqKQPv4SEJThC1FK
         WriT/CLMdTRn1Lzfx91m6sWj22eIMAn+llHgJRuZ1IRuxiWf+6d5lb3MJQp4U+cnono0
         g6a2DY+EBx+JxUbpdpY6XNgz/dRiOcEoiE0bcQqoc/iEgFcgctpr32yllUul8QuaZH3m
         rb6VdGT8/wcWMWw0YnJi7JzohrbisWVXZSLPZC8K09sWBIC3J+Ay7kIy1+bfsCR9V85Q
         lgWQ==
X-Gm-Message-State: AJcUukcC8QPwdA3uetOIMqC7SKWDpbezpp6aQ23MIK6ZUKX+HwgzIA1O
        3cCmo/CZHbQv5GyJk7nsqhwlTGhFFFU=
X-Google-Smtp-Source: ALg8bN66EUkbsyV6RVQhbKxXR4VVTUGaCyaaDZacl8ky1/jA/ynVNB+2tpAKX+6Iug4tifgpvIr8Cg==
X-Received: by 2002:adf:fe8f:: with SMTP id l15mr37276551wrr.313.1549033707340;
        Fri, 01 Feb 2019 07:08:27 -0800 (PST)
Received: from dell ([2.27.35.198])
        by smtp.gmail.com with ESMTPSA id j124sm2617520wmb.48.2019.02.01.07.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 07:08:26 -0800 (PST)
Date:   Fri, 1 Feb 2019 15:08:17 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] mfd: intel-lpss: Move linux/pm.h to the local header
Message-ID: <20190201150817.GB4973@dell>
References: <20190124180328.76533-1-andriy.shevchenko@linux.intel.com>
 <20190201092545.GH783@dell>
 <CAHp75VdUuRCPLw4kVu5583TLm5E2otw3rPMQsiz6Bh_1o4NVig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdUuRCPLw4kVu5583TLm5E2otw3rPMQsiz6Bh_1o4NVig@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Feb 2019, Andy Shevchenko wrote:

> On Fri, Feb 1, 2019 at 11:50 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Thu, 24 Jan 2019, Andy Shevchenko wrote:
> >
> > > We now using a common macro for PM operations in Intel LPSS driver,
> > > and, since that macro relies on the definition and macro from linux/pm.h
> > > header file, it's logical to include it directly in intel-lpss.h.
> > > Otherwise it's a bit fragile and requires a proper ordering
> > > of header inclusion in C files.
> >
> > I don't agree with this.  File which use various headers should
> > explicitly include them.  Inheriting header files is non-optimal.
> >
> 
> intel-lpss.h _is_ using pm.h.
> I don't see a contradiction here.

Then it should be including in there *also*.

My point is that if drivers/mfd/intel-lpss-{acpi,pci}.c use the header
file, it should include it explicitly.

> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  drivers/mfd/intel-lpss-acpi.c | 1 -
> > >  drivers/mfd/intel-lpss-pci.c  | 1 -
> > >  drivers/mfd/intel-lpss.h      | 2 ++
> > >  3 files changed, 2 insertions(+), 2 deletions(-)
> >
> 
> 
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
