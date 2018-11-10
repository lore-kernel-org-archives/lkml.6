Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0559C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B127620858
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B127620858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbeKJSl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 13:41:59 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42595 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbeKJSl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 13:41:59 -0500
Received: by mail-qk1-f193.google.com with SMTP id m5so5822326qka.9
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 00:57:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q3JcteNtm8CRrmMLALckpB7fBfj1KsjvPyLifY2NrvM=;
        b=qcsP26ZBMLA/ojU93ytseetWy7WZaSKNpOOBrV83SYphUllkD2I1ANXyJgzd70ZW+T
         KB2tWV1gPMS1WueFJOqyZ5JzZxmGgEnmdJ9euIwv9XDWtwlZ7Osl3ZMTdI2DVDHVYnHg
         9gmK8A2DjpfE9LGzdkpMrZvqwfHSvpyhyj/1pHp560mMyBB82HciFuQcsTBObGi/+uAc
         RNonXnBER9d5MH5/aBBdyOcg1OrffBmpf0wWD84C2zbMIrmy8zZSxfQw1b2jk7r/5/Rr
         cc/f22e9GQVxIDo8ltN61YaZ5co5vwA89M5ix3yQ0fPcTFEgYRTh2t+lWQPlrX1620Fv
         87iQ==
X-Gm-Message-State: AGRZ1gKTT6tYQ0qSHbXVkdVthapH3Gmrg/t50PHRvGYnKa46rscj4ib+
        BF2QxxBJg51Lyrdy3J1BAEEItWZPTsa3tIJL2r8=
X-Google-Smtp-Source: AJdET5crNcX/1uZSBGsAlD6fzgRvtX8zP21nh3d67BukXVnseqx+F1S2niABfAc+mi8M7stdLj9Q02fYov2cwoRiPR8=
X-Received: by 2002:a05:6214:1087:: with SMTP id o7mr12095377qvr.115.1541840263911;
 Sat, 10 Nov 2018 00:57:43 -0800 (PST)
MIME-Version: 1.0
References: <898e79a6-092c-d013-d2bb-f6260e761379@free.fr> <03f41ca8-68c6-f075-cb1e-c7f630a3b128@free.fr>
 <20181108093617.GB8433@e107155-lin>
In-Reply-To: <20181108093617.GB8433@e107155-lin>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 10 Nov 2018 09:57:27 +0100
Message-ID: <CAK8P3a1129B-u60sjHCvLuE8i6OCJRDSe-JFy3S-JJWFGbHCPQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] arm64: defconfig: Drop ARM_BIG_LITTLE_CPUFREQ
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     marc.w.gonzalez@free.fr, arm-soc <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 10:36 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Nov 07, 2018 at 11:39:42PM +0100, Marc Gonzalez wrote:
> > Commit a7314405d83c ("drop ARM_BIG_LITTLE_CPUFREQ support for ARM64")
> > dropped ARM_BIG_LITTLE_CPUFREQ support for ARM64.
> >
>
> Looks good,
>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>
> But I left it intentionally to avoid churn assuming it will go away when
> ARM SoC team runs savedefconfig and sync the defconfig.

I would never do that, instead I want patches like the one that Marc sent
in order to make sure we don't accidentally drop anything that is still
required, e.g. when an option got renamed or gained a dependency.

       Arnd
