Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90218C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A422089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9w5bfbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A422089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeJCOra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:47:30 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37710 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeJCOr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:47:29 -0400
Received: by mail-qt1-f193.google.com with SMTP id n6-v6so4940205qtl.4;
        Wed, 03 Oct 2018 01:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xio3gIVxw6A51zvVW7thsEUgwfB6Bp8q7uvKXkoQkfQ=;
        b=S9w5bfbnxUyhbi0a69vq2o70cv5zThEGrIKWNAGp3UbRnE+9M0RluINbgcLOJodCQI
         IX2zevuWsOQUePOobzvflJrGft17HHM6yPUCIpUZ27ewHdMpxyITwFjAXJnyqJqsm/yb
         eHTqEYwjQagyI0TxLXwGLuDNq++R+hxT9P+qcWnL47c/1NDoFFSxPefY397Pk6UNhK+w
         MpZSGFauVQfheff/SGoUCAWibyo2uKSMSeg9Y88QTaCu9T/bE/44iD6yU0YHV52cTHQI
         tzTuz58gEslgiyj1CfXd2xhmcfh4TtQbgl/MN0GAZFOFekt4reoQ6CVf86Bk41vl9sfc
         gA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xio3gIVxw6A51zvVW7thsEUgwfB6Bp8q7uvKXkoQkfQ=;
        b=MDck7H0wgV1MGACMAckiVIRG8XQRMUhwas807lB1zboj7r6CZpd4rGEHVIbJHcZUFG
         C3HQfuibyWx30hFRz1PcJ/UBn8wauC6wyd5jfKZW70QbKcMw3LRI3/KerryGLgp+qa+b
         mpjz5lN/ezeiWl/eauIEKbivPBoPXBvzR6LBKb99bLfXq91sv5v3E7SNpOpYeFCXbQld
         d3hjAPC59n6LR8JbBDtMUSZ8OAdTE3Quby5x/7XD5lUG1RRVlCDJyDgjbpxTKMmpaodv
         tyYBHHvY44eYqpuMhpp0m6ZTrIiihWN5lI2zcdlemNl/v2Z7cc6Ecg4BsHfgo0OswOYT
         sqJw==
X-Gm-Message-State: ABuFfohV5W5YaAA+WOifYW5t/UEvegbqn2EC7kLfk5N4gL/lbXSklm06
        yPrDvdk9R8ijbmvZIrXs8MgtvLg1wJBQ+cSfHLzhHI2IzTA=
X-Google-Smtp-Source: ACcGV62Gh6byK8AbIy1F/DrEtdatK+l/PXN9BReIYwVMxPxc0xKjNH3vDIPWTx945+M8zKY8+cpv0XSzrMCUHfkxtXw=
X-Received: by 2002:ac8:3c3:: with SMTP id z3-v6mr222639qtg.39.1538553612056;
 Wed, 03 Oct 2018 01:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180928215339.29516-1-joe@perches.com>
In-Reply-To: <20180928215339.29516-1-joe@perches.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 3 Oct 2018 11:00:00 +0300
Message-ID: <CAHp75Ve-LfScEuYg6Luzy4Sekatm3qVbr3wsQAJVR-YUN-10Ww@mail.gmail.com>
Subject: Re: Bad MAINTAINERS pattern in section 'INTEL PMC CORE DRIVER'
To:     Joe Perches <joe@perches.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 12:54 AM Joe Perches <joe@perches.com> wrote:
>
> Please fix this defect appropriately.
>
> linux-next MAINTAINERS section:
>
>         7441    INTEL PMC CORE DRIVER
>         7442    M:      Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
>         7443    M:      Vishwanath Somayaji <vishwanath.somayaji@intel.com>
>         7444    L:      platform-driver-x86@vger.kernel.org
>         7445    S:      Maintained
> -->     7446    F:      arch/x86/include/asm/pmc_core.h
>         7447    F:      drivers/platform/x86/intel_pmc_core*
>
> Commit that introduced this:

This is strange the shuffle of the MAINTAINERS based on the script is
a culprit of the above inconsistency.

Btw, I run parse-maintainers.pl against it and there are a lot more
"unsorted" lines.
What Linus or me or both did miss?

>
> commit 7683e9e529258d01ce99216ad3be21f59eff83ec
>  Author: Linus Torvalds <torvalds@linux-foundation.org>
>  Date:   Sun Jul 23 16:06:21 2017 -0700
>
>      Properly alphabetize MAINTAINERS file
>
>      This adds a perl script to actually parse the MAINTAINERS file, clean up
>      some whitespace in it, warn about errors in it, and then properly sort
>      the end result.
>
>      My perl-fu is atrocious, so the script has basically been created by
>      randomly putting various characters in a pile, mixing them around, and
>      then looking it the end result does anything interesting when used as a
>      perl script.
>
>      Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>
>   MAINTAINERS                  | 3585 +++++++++++++++++++++---------------------
>   scripts/parse-maintainers.pl |   77 +
>   2 files changed, 1868 insertions(+), 1794 deletions(-)
>
> Last commit with arch/x86/include/asm/pmc_core.h
>
> commit 941691ef2197944a202d7870dcd7da3fb0391c65
> Author: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
> Date:   Wed Jan 31 11:50:22 2018 +0530
>
>     platform/x86: intel_pmc_core: Remove unused header file
>
>     Recently sent patch 'platform/x86: intel_pmc_core: Remove unused EXPORTED
>     API' missed to remove the header file 'arch/x86/include/asm/pmc_core.h'
>     which was solely used to declare the EXPORTED API
>     'intel_pmc_slp_s0_counter_read'. This patch provides the errata fix for the
>     same.
>
>     Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
>     Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
>  arch/x86/include/asm/pmc_core.h       | 27 ---------------------------
>  drivers/platform/x86/intel_pmc_core.c |  1 -
>  2 files changed, 28 deletions(-)



-- 
With Best Regards,
Andy Shevchenko
