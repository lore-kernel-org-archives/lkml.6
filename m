Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F16C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1011520675
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o6ozaEeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbfBLItR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:49:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41014 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbfBLItR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:49:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so1683242wrs.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 00:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4nLz88ppIbmdEHDKAFEQbZDeliL6nPlGN0FY6VrC2p0=;
        b=o6ozaEeL9qPphG9EqetDcLyu/h7j8C7vUWGjn9wtsZ7vdIXpFRdaFVtuUVv8FVc891
         Fo5n4uNVXkewA0HUsI/inYYTd5sRjNP+LKajeH2rSQG033NSzdJmhvk+eNDf6tEPgroH
         sEgbH4l/SKWeDb+d/aAwvUd+Gf09oU5hVIIKbCqy0rTNN5bUMddkHz6lqLL7PBdiKVyX
         +oeaU6e4CF8gv1CjnVuKD7nvefO3iybkHlkTtWPdzQQ7/7dTzlmLaikUkLKgcrV9TY2j
         K8h3ZYqWFyz9fokupQYgdDYmWjlzLtMYBtje3UbyHmj0oCfxnk94QC2xOImIwMPX+xu4
         Rp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4nLz88ppIbmdEHDKAFEQbZDeliL6nPlGN0FY6VrC2p0=;
        b=K0wRZGmS9c2uzd8y8ellHJzZt1lU++lN9Ho+CQ+3qy0jpuPDBcNJLgBwuQj7x0S9uh
         MDaSWMAIUeM0HW9aBr0s7Eib4by+S5OaNFz+77waiO+MKM1P8s191QDAe9J1rlOCCPKI
         xEwXZd1NenBDYYM4x0KAi2BTc132/seaI3e/kca0V/AbLPWGusMUJrS8tWOs6OaUH0SB
         8TkfZ44JawSJ22ieUUbuaTO10nQG14oF9cj06ZMk3gb61xZoSJPiI7oewTruHoWMqlus
         amXnh6lLkQ29oLZ26QyNN2Ig4zI7G+kRwzEoRJ/jKscPG7X2p01Ihhqtk84ke6blhIo4
         JU/g==
X-Gm-Message-State: AHQUAuZsr1tzbPgJHulTq7ispJ0n0LczCKNy6AiQsFr54NC04a2+hU/1
        dFH0BNlhClrAytAa9NKOqDvEfw==
X-Google-Smtp-Source: AHgI3IZ5FE2QM0ynUM/o6U72GQg0QcisnqlFssevmV+I6I3lsaLPdmffm3qVi9xOsasmdKYoe9vEbQ==
X-Received: by 2002:adf:e30f:: with SMTP id b15mr1946625wrj.0.1549961355284;
        Tue, 12 Feb 2019 00:49:15 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id y185sm1112057wmg.34.2019.02.12.00.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 00:49:13 -0800 (PST)
Date:   Tue, 12 Feb 2019 08:49:12 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] mfd: intel-lpss: Move linux/pm.h to the local header
Message-ID: <20190212084912.GX20638@dell>
References: <20190124180328.76533-1-andriy.shevchenko@linux.intel.com>
 <20190201092545.GH783@dell>
 <CAHp75VdUuRCPLw4kVu5583TLm5E2otw3rPMQsiz6Bh_1o4NVig@mail.gmail.com>
 <20190201150817.GB4973@dell>
 <20190208125958.GN9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190208125958.GN9224@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Feb 2019, Andy Shevchenko wrote:

> On Fri, Feb 01, 2019 at 03:08:17PM +0000, Lee Jones wrote:
> > On Fri, 01 Feb 2019, Andy Shevchenko wrote:
> > > On Fri, Feb 1, 2019 at 11:50 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > > On Thu, 24 Jan 2019, Andy Shevchenko wrote:
> > > >
> > > > > We now using a common macro for PM operations in Intel LPSS driver,
> > > > > and, since that macro relies on the definition and macro from linux/pm.h
> > > > > header file, it's logical to include it directly in intel-lpss.h.
> > > > > Otherwise it's a bit fragile and requires a proper ordering
> > > > > of header inclusion in C files.
> > > >
> > > > I don't agree with this.  File which use various headers should
> > > > explicitly include them.  Inheriting header files is non-optimal.
> > > >
> > > 
> > > intel-lpss.h _is_ using pm.h.
> > > I don't see a contradiction here.
> > 
> > Then it should be including in there *also*.
> 
> Why?
> 
> intel-lpss-*.c are not direct users of this header.

They're not?  That's is where the miscommunication lies then.

If a C-file isn't using the offerings of a headerfile, obviously there
is no need for the C-file to include it.

> > My point is that if drivers/mfd/intel-lpss-{acpi,pci}.c use the header
> > file, it should include it explicitly.
> 
> They are using it indirectly.

Indirectly is fine.

> As far as I know we don't, for example, include "asm/*.h" to each of our C-file
> because they are in _indirect_ use of.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
