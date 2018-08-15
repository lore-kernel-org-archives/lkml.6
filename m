Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7217C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD722064C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=profitbricks-com.20150623.gappssmtp.com header.i=@profitbricks-com.20150623.gappssmtp.com header.b="dQ1QDN94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD722064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=profitbricks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbeHORy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 13:54:59 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38674 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729436AbeHORy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 13:54:59 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so1612973wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 08:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=profitbricks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EWMFnYZseMD4EOjRVwaRD4tClqy+HjFV+OLbQijm570=;
        b=dQ1QDN9447IqvLe1yyM+e+2SP//zp32krTIVCpChOb6IG4REoQeuPcVpdrnYtEt56W
         fmLpDNqEV2uF6VSXn9+1yZu8oLXv5cOQNvXLpNg9saDrgOUnCgmZ4ubyJ+WYNq2e50aS
         pztpa0M8kyMIi1w0uDtgV0412H12vmLwwR0jEJlXjRM+OlYBQsMBUAG5e0vRLer4L4CJ
         KXv530t5Cg/iX1NZlrf9DKZDE56W5me9s0F0xFYWm9OCTZDWnlcj+LlQ3n7F0MJ33tuJ
         sdehceENvx5u2P/yXglTy5+o/R0oS2zmGuNaOYL+M26lZI8QKvL3DkuVeO/FHyx43MRp
         i3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EWMFnYZseMD4EOjRVwaRD4tClqy+HjFV+OLbQijm570=;
        b=K6zHw8uyKv8Ky0d+qCKvqewCnx2vTY/uPgPLCk5BlOOvFWcnm+GrOW7LN9gG42KLWu
         8LxHokuqMwdyT5wVVh4sU1cJMmxyyaRMr3k2vNQiNZ4fNVkMAJAXrISlG2LUeCGnkMiN
         CMnNuiyfegVwZ+xwPfuDWnxUAhlqmcSRtba7X7at4Mwe2VFwaEkwrMC/EGkRdxueaJOC
         eck7LEUrs7RGgBvaD0U57L9KDu+fnkKJntVC7KQWxlWqD1keRm6i9KEAiSuHz8cFPL9r
         NhedoZBIcZEG1R+5zDpRJEw9pQWmOueZryzim7hqrkA/eFILqsr5KrXftdBMJAc9UoTN
         AFXg==
X-Gm-Message-State: AOUpUlE0xXFvCPtxDxwMegDjSJL+iEA792mot8S8s/oaxVuFN0T2XEgV
        I0HO7pKz+SdhWeUf+VjWQrYB1ATgPQrqk4U+IERMMA==
X-Google-Smtp-Source: AA+uWPz7lQDYmQRHMkdo1VaVXRvkpQB+bYUr9X18vlmUbpvbRZnxiEzhSyTsq68xoc/fQb5LPPmowvm+nKuI21SHC9Y=
X-Received: by 2002:a1c:ea17:: with SMTP id i23-v6mr14112440wmh.29.1534345348439;
 Wed, 15 Aug 2018 08:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180814171515.270692185@linuxfoundation.org> <20180815061429.GB1253@kroah.com>
 <CA+res+SSVV04eawQ6wDX6_gdd9G0FbQ=uWFy0tOgSX=+T0s2MA@mail.gmail.com>
In-Reply-To: <CA+res+SSVV04eawQ6wDX6_gdd9G0FbQ=uWFy0tOgSX=+T0s2MA@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@profitbricks.com>
Date:   Wed, 15 Aug 2018 17:02:16 +0200
Message-ID: <CAMGffEnBBFZMfN=veC9GHb_6BU6b+k_h2DfseVxgq1ivRNDyEQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/104] 4.14.63-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, shuah@kernel.org,
        patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date: 2018=E5=B9=B48=E6=9C=8815=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=
=8D=888:15
> Subject: Re: [PATCH 4.14 000/104] 4.14.63-stable review
> To: <linux-kernel@vger.kernel.org>
> Cc: <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
> <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
> <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
> <stable@vger.kernel.org>
>
>
> On Tue, Aug 14, 2018 at 07:16:14PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.63 release.
> > There are 104 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu Aug 16 17:14:49 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.63-rc1.gz
>
> -rc2 is now out:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.63-rc2.gz

Merged to our tree, tested on my test machines with basic functional
tests, all looks fine.

Thanks,
--=20
Jack Wang
Linux Kernel Developer

ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin

Tel:       +49 30 577 008  042
Fax:      +49 30 577 008 299
Email:    jinpu.wang@profitbricks.com
URL:      https://www.profitbricks.de

Sitz der Gesellschaft: Berlin
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B
Gesch=C3=A4ftsf=C3=BChrer: Achim Weiss, Matthias Steinberg, Christoph Steff=
ens
