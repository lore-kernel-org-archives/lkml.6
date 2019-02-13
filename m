Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFFFC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC6120838
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DV0nFiYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393034AbfBMR2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:28:14 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38989 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392905AbfBMR2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:28:14 -0500
Received: by mail-pg1-f193.google.com with SMTP id r11so1443519pgp.6;
        Wed, 13 Feb 2019 09:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1UDXXFHxy/pnXRcMgTXfxxEZhrANjMTOWFOry0nz/SM=;
        b=DV0nFiYpd1p2VrbaTDpfnKzn9Cxn4fJ075f4s8DSTZisT4LctEIXu8oSV2L8ltm9lI
         ovH1T+5BFBuqU36057uMSmVODkTDNzjByuSsfRPWHARhEhysbRh5kjJr2UEyZnTxQAWC
         P/+xtc0EnQ1LeVHqjdRGB9K6lPCfQqG97I+UtIYDHjRvdzX9DZq/trLx0AZyzDOX/wLs
         tUTgTdxduYAbrDojuDxqufAYKq6WwmlyP6Chtvu5AC/k2SVRn2Z4tDMKLiCtgccttdqb
         SAeO90YGR+3Gil2FR46EW1YesrogxkHCyxNXX0ijXsJvyxxqRJejW26WoCB3LwHQk5T8
         lewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1UDXXFHxy/pnXRcMgTXfxxEZhrANjMTOWFOry0nz/SM=;
        b=rW5REwyIqfR/AWtL0TurYrWZVATAgn6V6LPd1MnYfX+YuEwhmpklSebjF0lnqFVakV
         OGMRq+OnjjGy3PeUfW9ErO2n0afJv22XkMJgWhAK7Kw1Tbz9kBDb8QB84rszzmfAAeXP
         A7dtolAzkch8jQw/e1iZxJNX8dAuL90aO1G2T7L1Q/wfxRzPhm1z2+rRZv9A4MZZ+tmw
         yy1zODKZdnVgeESijY/F2RnOJqUXBxHYOpg1kjOyBwggVmOKXdgW8Ar1deQC5NxcTDSJ
         N/thR9Ky9lIqhHLwz689nfIKx9FFGu+nSTU4Kl2730hH0AT2uYb0CMI+ZmTqgPfd9/24
         5P3w==
X-Gm-Message-State: AHQUAubNFT56eY/XovnnTHzxWtSycBjPjcbiib5fjnjZwGUdTSFU1Ra5
        I6jUD92XgrWmOrrfiXWHNJRCR31IKtQj2KC8TfmWEtNG
X-Google-Smtp-Source: AHgI3IbTPUvc9dkJtAqwWb0Pi31/6itcb1NY8EjXxSoOG2KIlAgx8/iyy5kXku4LUTq4cSW0LUKLp6NVgKJ6cJcLt/8=
X-Received: by 2002:a65:6116:: with SMTP id z22mr1387060pgu.265.1550078892913;
 Wed, 13 Feb 2019 09:28:12 -0800 (PST)
MIME-Version: 1.0
References: <20190213150810.32750-1-rajneesh.bhardwaj@linux.intel.com>
 <CAHp75VeTwjbdjAXPZfB5B7oataarjG0epV1SzokdYnCj8xcPhA@mail.gmail.com> <63bb8cc7-4feb-f69c-33be-ba5308c441d1@linux.intel.com>
In-Reply-To: <63bb8cc7-4feb-f69c-33be-ba5308c441d1@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Feb 2019 19:28:01 +0200
Message-ID: <CAHp75VdH8G+FfvznZePEG1F5A1Eyh8XF=a-MqpNooLWnBbP+gA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] ICL support and other enhancements for PMC Core
To:     "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 5:50 PM Bhardwaj, Rajneesh
<rajneesh.bhardwaj@linux.intel.com> wrote:
> On 13-Feb-19 9:03 PM, Andy Shevchenko wrote:
> > On Wed, Feb 13, 2019 at 5:08 PM Rajneesh Bhardwaj
> > <rajneesh.bhardwaj@linux.intel.com> wrote:
> >> This patch series provides Icelake support for PMC Core driver and while
> >> doing so it introduces the Icelake Mobile to intel-family.h as per the
> >> CPUID from below Coreboot link
> >> https://github.com/coreboot/coreboot/blob/5ebcea3aaaa3cd358bc5bccaa156b13a6ef25df6/src/soc/intel/common/block/include/intelblocks/mp_init.h
> >> and provides some fixes and enhancements to the driver.
> > It's not applicable to my tree.
>
> Hi Andy,  I could apply and test in on latest upstream so i think its
> probably because you have applied 5 patches from v1 on your tree.
> https://github.com/dvhart/linux-pdx86/commits/for-next

You need to use latest tip of the subsystem tree always.

> I sent the whole series again since
> https://patchwork.kernel.org/patch/10791893 referred to a wrong commit
> for Fixes:. If you want to address that by rebasing then can you please
> just consider patches 6-10.

We don't do rebasing for published changes. Only in rear cases when
otherwise would be worse.
Darren didn't respond to my question what he thinks about this case,
but at least it's not related to the code itself which, in my opinion,
decreases a severity.

> Please let me know if there is any other issue?


-- 
With Best Regards,
Andy Shevchenko
