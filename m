Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E877FC282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 02:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A9A218A6
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 02:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoXo7umv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfBBCvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 21:51:36 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33697 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfBBCvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 21:51:36 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so3827897pgu.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 18:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UjqlJWVSE/pwhAaWcGVJGk8AlmPVmObgHQXwHh11iFQ=;
        b=YoXo7umvPTrreEF2cUcsbOA5Ecfq33Llu30GlC6pLQgF9iDGuZMAI6nRigzsi5ixCP
         C9dwMwBT+M3PVPxG5+wLUuyoL53YyyVYXlMTyWf9cGgV7lh9itcshlG/BJfmdX+IDCGH
         sH7TuAcxuUMhCMraTECBDI+zv8XLkWtGSc7bg4/zZ5wkfPDdp56QW5RGb5Kl0NSj04vb
         UHlvCZEc4neE+OLEXMn3eiWGCsv5odcpBoYIB/zrNJoAskSsexTTGW8wTsBcU1hy8HLy
         b2vCzLNfSvX2n9DJtLpww3ChsHYbDzMDjE3on+iv9QpM+ftOmZXgh9IX+fW33DpcxgZX
         l9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UjqlJWVSE/pwhAaWcGVJGk8AlmPVmObgHQXwHh11iFQ=;
        b=JY9Gz8Oc2gWyAUqh1BZSuDS/LloyD4/exQyYdl985gU6mWef9ftCIe0vEq3vsDMQHc
         S5uFD4e+q8sI5y1czSENxiEwSPu7ujH9GS+qIXYAFOS2Cs24ZF5y143g+Qk+/dGkjM2L
         +XG8FYOT+lOPJiPyeEd5uTU3jpLw+gLNVJga7d3HlQGFb2B/MjXls8TxKXk9OHh4+xgU
         rhjISpRCaVy8geWQlrBH8CNIO8JYq7M5x39Jr2bwgMNW3WfAYCkavgHTNZ2jcB2SqXpK
         ch4p5gjLW1MHpDeL4yeAMgT9bIYrnhASlHICYdY0QWP5qIOFu8jRBH42M5+ncj+Xhd8B
         sFuQ==
X-Gm-Message-State: AHQUAuaYC9cmv9TJSxkjqjo3p6UszmXPlkXw9kBB0xwLy91h2WCBzsc4
        pinyGNAyMXMpVBoAFON7InP9j2SbjqOSxtCxVeQ=
X-Google-Smtp-Source: AHgI3IYOEeEFL4OiKAT5XHk0F2z4Jx1U9q+9kvODkeIEYMab1vQzSznNrXdqVUO+92dktDgrJF+JcCs4OyYXsuYBtxU=
X-Received: by 2002:a63:6b4a:: with SMTP id g71mr2229865pgc.383.1549075895030;
 Fri, 01 Feb 2019 18:51:35 -0800 (PST)
MIME-Version: 1.0
References: <1548929853-25877-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1548929853-25877-3-git-send-email-Tianyu.Lan@microsoft.com> <20190201163443.GS32526@8bytes.org>
In-Reply-To: <20190201163443.GS32526@8bytes.org>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Sat, 2 Feb 2019 10:51:23 +0800
Message-ID: <CAOLK0pw3zaanNbzJ67sqPQ=ETctM39+=kSh99euq0wmz-ehrUA@mail.gmail.com>
Subject: Re: [PATCH 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, mchehab+samsung@kernel.org,
        davem@davemloft.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        akpm@linux-foundation.org, nicolas.ferre@microchip.com,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg:
             Thanks for your review.

On Sat, Feb 2, 2019 at 12:34 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> Hi,
>
> On Thu, Jan 31, 2019 at 06:17:32PM +0800, lantianyu1986@gmail.com wrote:
> > +config HYPERV_IOMMU
> > +     bool "Hyper-V stub IOMMU support"
>
> This is not a real IOMMU driver, it only implements IRQ remapping
> capabilities. Please change the name to reflect that, e.g. to
> "Hyper-V IRQ Remapping Support" or something like that.

Yes, that makes sense. Will update.

>
> > +static int __init hyperv_prepare_irq_remapping(void)
> > +{
> > +     struct fwnode_handle *fn;
> > +     u32 apic_id;
> > +     int i;
> > +
> > +     if (x86_hyper_type !=3D X86_HYPER_MS_HYPERV ||
> > +         !x2apic_supported())
> > +             return -ENODEV;
> > +
> > +     fn =3D irq_domain_alloc_named_id_fwnode("HYPERV-IR", 0);
> > +     if (!fn)
> > +             return -EFAULT;
>
> Why does this return -EFAULT? I guess there is no fault happening in
> irq_domain_alloc_named_id_fwnode()...

Yes, =E2=80=9C-ENOMEM=E2=80=9D should be more accurate.

--=20
Best regards
Tianyu Lan
