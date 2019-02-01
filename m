Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C395DC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9093220B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8FeA/B5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfBAHLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:11:07 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38808 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfBAHLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 02:11:07 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so2730184pfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 23:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iayduXUHknR4KHvWqwL7b7IeV52o99DbgYYyA0WUvZo=;
        b=Y8FeA/B5vZrER2ZCLqhKOSHjTd43nXE+JvKpbhs/An+ULgexpWD6pl7Of5xw6r+Qed
         IbE4SgxHORd6ZJMcLFRk8Q7FPTHpFradUOd3IY7iJlGs7skEOBSq2EPHYJDYmrA/ReFV
         kbbfLEg4X0ovgJSf+XErURbOYne4Sr7nrhqrGsDHjf/zHsp/9let5/FCgUtrRgCtyDI7
         rsLeR15g1tBkRjYVYEwiOiQ+RcoIV/iRhufBh1d2ori9/4iia/lfu/vk1OzQdYgXDjxH
         wg/rzX51/FAEeUIEyAm1bcSVlcqQRqk8rr2FCrrXJD6LJuXEhsCHkA9nyA46ypykONeM
         cZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iayduXUHknR4KHvWqwL7b7IeV52o99DbgYYyA0WUvZo=;
        b=SuE992jqCd2vf7gKRI9OzjMg3lk0bxfqgPi60jKmq7mjyQIa9fRNAHKzpF83uCgFEu
         oT1HFLlk3d+NEEOz9jNIYKpiAx7zaJAehvlAfPv64N02ic8siogFF7bg5QhrDmnkBkkL
         lTdGDQUTMRj3sg+uRUwd7xRvX5Wa6tR7XFEu51PgHwlyg0LQ33cOg6hcmTLTQFToILgs
         6hej7opj7aqWDmL1U+vrjub6EsVmQT1Bs4vsRtlPbxc5qtDmdLm7727tBDroH/4TnFPm
         8hA99zynWxRkkO5pjQ1ROCM3nDawFrL5T2+lJtLKE+0AZTY/S67IzUg2gsAnTAJbyEol
         AxOA==
X-Gm-Message-State: AHQUAuYMsELxeEkLIeh1TCs/vgrNWpgMopOeA+Kasc5kFi5OQtK6GT1C
        8uYgvUEF4i5RWDR5rcGs8k2Zt6tQYB0niLvfKQI=
X-Google-Smtp-Source: AHgI3IbhoukHM4Mcu4/JSQR7MQ83RKuNMug1Jc7Kr3viDZj7KC9zcHnlstoeEdyWv5MvPjhN82JIyG+P4ywqZTPqoTY=
X-Received: by 2002:a63:6506:: with SMTP id z6mr1152911pgb.334.1549005066383;
 Thu, 31 Jan 2019 23:11:06 -0800 (PST)
MIME-Version: 1.0
References: <1548929853-25877-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1548929853-25877-2-git-send-email-Tianyu.Lan@microsoft.com> <20190201070655.GA14343@kadam>
In-Reply-To: <20190201070655.GA14343@kadam>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Fri, 1 Feb 2019 15:10:55 +0800
Message-ID: <CAOLK0pyET5GGqMcoK7u5781mf_U1js6LtfoYxMpntwVCfGO3Zg@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/Hyper-V: Set x2apic destination mode to physical
 when x2apic is available
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, mchehab+samsung@kernel.org,
        sashal@kernel.org, sthemmin@microsoft.com,
        Joerg Roedel <joro@8bytes.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        michael.h.kelley@microsoft.com, Ingo Molnar <mingo@redhat.com>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>, haiyangz@microsoft.com,
        Alex Williamson <alex.williamson@redhat.com>, bp@alien8.de,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.ferre@microchip.com, iommu@lists.linux-foundation.org,
        devel@linuxdriverproject.org, akpm@linux-foundation.org,
        davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 3:07 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Thu, Jan 31, 2019 at 06:17:31PM +0800, lantianyu1986@gmail.com wrote:
> >
> >
>
> This comment needs to be indented one tab or it looks like we're outside
> the funciton.
>
> > +/*
> > + * Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
> > + * set x2apic destination mode to physcial mode when x2apic is available
> > + * and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs
> > + * have 8-bit APIC id.
> > + */
> > +# if IS_ENABLED(CONFIG_HYPERV_IOMMU)
> > +     if (x2apic_supported())
> > +             x2apic_phys = 1;
> > +# endif
>
> The IS_ENABLED() macro is really magical.  You could write this like so:
>
>         if (IS_ENABLED(CONFIG_HYPERV_IOMMU) && x2apic_supported())
>                 x2apic_phys = 1;
>
> It works the same and is slightly more pleasant to look at.

Yes, that will better. Thanks for your suggestion. Dan

-- 
Best regards
Tianyu Lan
