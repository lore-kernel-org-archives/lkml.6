Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3FCC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1A42087B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1A42087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeH2CXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:23:14 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55959 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH2CXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:23:14 -0400
Received: by mail-it0-f67.google.com with SMTP id d10-v6so4950794itj.5;
        Tue, 28 Aug 2018 15:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+SHayacjPEeTDEIBZW3fV5Pjo8NNq1X3v8fS5KU2EBQ=;
        b=AGhJCScQQEPqJ/xJvsLC1k0OoeTYuzUz1+skFW7gRK99U77FRO+HN8H7JWVIJ4lXno
         ZpT3tXkCO/ARdi6qUL6FWM4wJDHDuB4Snu5ZosDM9iA6xfQkyiSfSUUZqElkKWezC/kB
         JeTwzUspZRx6JruUDl+cAaVdWqkl2dGu4xeA/H3E/8Ow4hInSNyTq15muNuy5w0jcFM2
         a7iZYHrQzTf9hNa5OnFxSXhCVdeeREbCrEbLZ8Bb5ij+MF0qKZaiFoA18kcVmtVU3g3y
         3KfSOYU+XBM6gT5tpMTDhE9mxM3qeOgVTLdDrwRQUFTz9adqdC2HW3eZYuMni3h5/FW7
         rnoA==
X-Gm-Message-State: APzg51AkIM+shgB9IfQJWmtgU/sUdBdC+f+z3X6tP1tPcsy0xEjor5tL
        Aamlan/PAiLsubGFkcX0WvwmLIEJr0k=
X-Google-Smtp-Source: ANB0VdaFdO6mJ6amqnA0sJGi0I8SyTfJSccf7TpgJ53FDqMXbeJ9c0T8fconmASDPEzP3J2WuFwsbw==
X-Received: by 2002:a24:7dd5:: with SMTP id b204-v6mr3346470itc.96.1535495368842;
        Tue, 28 Aug 2018 15:29:28 -0700 (PDT)
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com. [209.85.223.172])
        by smtp.gmail.com with ESMTPSA id 14-v6sm1260108itu.20.2018.08.28.15.29.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 15:29:28 -0700 (PDT)
Received: by mail-io0-f172.google.com with SMTP id l14-v6so2832068iob.7;
        Tue, 28 Aug 2018 15:29:27 -0700 (PDT)
X-Received: by 2002:a5e:8408:: with SMTP id h8-v6mr3115440ioj.171.1535495367632;
 Tue, 28 Aug 2018 15:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-43-robh@kernel.org>
 <CADRPPNRvRKEuV=ZzH6yq6_7COvFSWy2ibAKoEt4YrzES2m9x2Q@mail.gmail.com> <a8594a1c-0d10-74c6-0e40-15d49ff876a3@linux.vnet.ibm.com>
In-Reply-To: <a8594a1c-0d10-74c6-0e40-15d49ff876a3@linux.vnet.ibm.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 28 Aug 2018 17:29:15 -0500
X-Gmail-Original-Message-ID: <CADRPPNSoP5K79wCr5QdJ-OR_W9aZrEkBiPqCXU7EWCfZsvaeuQ@mail.gmail.com>
Message-ID: <CADRPPNSoP5K79wCr5QdJ-OR_W9aZrEkBiPqCXU7EWCfZsvaeuQ@mail.gmail.com>
Subject: Re: [PATCH] soc: Convert to using %pOFn instead of device_node.name
To:     tyreld@linux.vnet.ibm.com
Cc:     Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        David Brown <david.brown@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Andy Gross <andy.gross@linaro.org>, linux-soc@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Zhao Qiang <qiang.zhao@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 5:16 PM Tyrel Datwyler
<tyreld@linux.vnet.ibm.com> wrote:
>
> On 08/28/2018 11:48 AM, Li Yang wrote:
> > On Mon, Aug 27, 2018 at 8:57 PM Rob Herring <robh@kernel.org> wrote:
> >>
> >> In preparation to remove the node name pointer from struct device_node,
> >> convert printf users to use the %pOFn format specifier.
> >
> > Please forgive my ignorance, but what is this format specifier do
> > exactly?   I cannot find anything listed in the printf specification
> > matching this.  Is this something newly introduced?
> >
> > Leo
> >
>
> From Documentation/core-api/printk-formats.rst:

I was trying to find it in the standard c format specifier.  :(
Thanks a lot for the pointer.

>
> kobjects
> --------
>
> ::
>
>         %pOF[fnpPcCF]
>
>
> For printing kobject based structs (device nodes). Default behaviour is
> equivalent to %pOFf.
>
>         - f - device node full_name
>         - n - device node name
>         - p - device node phandle
>         - P - device node path spec (name + @unit)
>         - F - device node flags
>         - c - major compatible string
>         - C - full compatible string
>
>
> -Tyrel
>
