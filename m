Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660CCC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 00:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132B9208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 00:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ulU5rZSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132B9208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbeHWEHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 00:07:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37186 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbeHWEHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 00:07:09 -0400
Received: by mail-lj1-f193.google.com with SMTP id v9-v6so2798099ljk.4;
        Wed, 22 Aug 2018 17:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VrVMbsZ/4z1r5pzEEhDSae4daLlDRqlkU+lMeVN/keg=;
        b=ulU5rZSV5WOL53aK85kx1BrI4zkRStOAh2v1hcPWyN0hSNmSxaRTZzza4Le6Kd6tNb
         tXJzP8mIJT08l8SpjnVAv6V7XxnWXeAoPwizx8fCZGccyFBzOWNDfh1Km5huwvMeaY2E
         ZCbNizhXswF3/bINUUEntRqFiWUqTB2zC5r/Xwa3HhY1OrMp6bdnvDhh/YeZ6c0qnHxR
         kWkKfytVWNfix5uMtTbaPa3bOHtFZ6YaegBaquSGmHygiMz8w69pctcVTdJLGGx58mOF
         i1pVUg0LG424wdHMIr0Wevzi9q7W/Kesswr13nQ9+2SJgDu85codUNhsP9fHgDTCccmh
         o5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VrVMbsZ/4z1r5pzEEhDSae4daLlDRqlkU+lMeVN/keg=;
        b=NAe4BN/eEKQX8eyXqiN4VWDibs1VJeCxIkXLwNln1a9D1+7VHSdpJLZ15gXrA3HT5m
         GM2ax9zKBFxX/ACxnO2cPgwJ8ANR/GoIPd6QSMs+wmlXY57X4KQRZjG3rPH+ErI5s8tS
         uah13eL3xFK7n2K7E1bxz9hsBTqBYhofVXTVMF9bf4od+uFsE5rvlz0K5aJON0zKuiY5
         CigcPr+/ZhRT7fHPjfNWqD+SIm9oJVcL9GPAm3qu3oTyy0qCSU3tIvNVKFVQx3tkMGFU
         y76uUnlJMkFXVSujCvs1hs4OnmgvkDe2r+78n3LtJ00QBP25FGo6sNXpJeqYH4p24xxD
         Ephw==
X-Gm-Message-State: APzg51DGel/FwqS2RUQidjeTpHorM1gtNo2psSZL2Aq77Vmkf4B7m24C
        eDEABEgMhwvlZbZrg4x21DSslH/CGTQqatstLnY=
X-Google-Smtp-Source: ANB0VdZe6eB9GMiYXX58Lo9g+vUqxM17hn1j6tOraJRmTDH/d/gkm9goofGncCBja/AQa9buhWHPC6O6ZxNGYdX5MZY=
X-Received: by 2002:a2e:1290:: with SMTP id 16-v6mr6346400ljs.94.1534984803995;
 Wed, 22 Aug 2018 17:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <490A46D5-834E-46A9-9106-A31F94344F99@goldelico.com> <d5093e14-c826-9183-cd94-ecb99a799fc8@infradead.org>
In-Reply-To: <d5093e14-c826-9183-cd94-ecb99a799fc8@infradead.org>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Wed, 22 Aug 2018 17:39:52 -0700
Message-ID: <CAKdAkRQ+BXezzT0JsuSa_-imHq+u-q2P5rMVMCL4=N18VYxSAw@mail.gmail.com>
Subject: Re: please revert commit ce8556cca6 "kbuild: verify that $DEPMOD is
 installed" introduced in v4.18.4.
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
        lucas.demarchi@profusion.mobi, lucas.de.marchi@gmail.com,
        michal.lkml@markovi.net, jeyu@kernel.org, cwhuang@linux.org.tw,
        "3.8+" <stable@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 4:35 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 08/22/2018 11:53 AM, H. Nikolaus Schaller wrote:
> > This patch requires that /sbin/depmod is installed and installable on
> > the build host.
> >
> > But not all build hosts for cross compiling Linux are Linux systems
> > and are able to provide a working port of depmod, especially at the
> > file patch /sbin/depmod.
> >
> > I use, for example, a Darwin system to cross compile Linux and I run
> > depmod -a on the embedded system once, after installing a new Linux
> > kernel there.
> >
> > I have no problem with seeing a warning, but aborting the build process
> > is IMHO a bad idea since the previous behaviour didn't harm many people
> > as far as I see. Probably 99% of people compiling Linux kernels do that
> > on Linux and 99% of those have depmod installed for optimal operation of
> > their build host. So IMHO printing the warning is good enough.
>
> Thanks for the report and sorry about the problem.
>
> I'm OK with changing the error to a warning.
> Does the patch below work for you?

Why would one want a warning on a host that never runs "make modules_install"?
Can this check be only done when we actually try to install modules?

Thanks.

-- 
Dmitry
