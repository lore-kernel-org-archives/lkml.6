Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D030CC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8838E20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jLN1TbgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8838E20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeLEMBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:01:07 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40591 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeLEMBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:01:06 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18-v6so18077027lji.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 04:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m2c5oGlnNZQ+q799p5nxoQFpGmfGLOYlQnWIGd6mn0Q=;
        b=jLN1TbgRDD/fVzht2/7QZEI/H+QmXGo9ASojBnpuoPuMhxAtvqT8ficnK639nVVdUz
         2HAqRrFhLp7U0nB0Hzcm94SEqLxZ4kddTGgnkO3K9oT0rX4Yxl1pSU1qx5KCr8vBlkTn
         jF5JRVXzb2x+PRoL/MgROZTJU4zRS7Qzi4x3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m2c5oGlnNZQ+q799p5nxoQFpGmfGLOYlQnWIGd6mn0Q=;
        b=p03y/rYlkhwyAbSSdxvw4HIu51FJfPrqo2xWUvn0Y9K4fIKD1V4fQCYkiadhgl4AWw
         0t3/YLYqGV+YWhKO8yQYsbIqKwBpJx9XLgaBwAgITYsCqrJOUowHUFV2/zeM6OKyjWAj
         oJ3S9vijL19GOh3JdQYRo4y99G4GcDJ1hA35pP9U+n7swv0QTO0E7PKR+L3anu3N7iP2
         cmbu4jtSEp19xzZdC2dNEwxFV9DnmQrdhAVgnK678tfDe+DohqPN0zk0j3Af/xzTphjP
         0+EoKHf4VSPJ5Ap/DyXbNAky5+Rm1xbAIYbzYkyqUtfJeI9Vcow42Ps71CHiF8tbi99w
         TVZQ==
X-Gm-Message-State: AA+aEWYJ7PKhpI2oWDwUt3a5uNcRUAoxbrJEmJ0bbza5JXhvnFpvmNK5
        nYdehtpNCqw9R/rx4/0FH98N+kda7g8mkjvNHHyzFg==
X-Google-Smtp-Source: AFSGD/UR0z7I+ZfII9VWdgf/yzMAx4UJLcvLR82qsUCHyPGzgxUw/jjTZSXN87GC7TAwT6jxOGZwA5pMrwlITm+Z/Dc=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr15422872ljj.9.1544011264387;
 Wed, 05 Dec 2018 04:01:04 -0800 (PST)
MIME-Version: 1.0
References: <20181107174844.5381-1-manivannan.sadhasivam@linaro.org>
 <20181107174844.5381-2-manivannan.sadhasivam@linaro.org> <CACRpkda25cuiPCe9ouvDDSpFwZ2z=Pm8pK=5jC-7OAcYwPSvvA@mail.gmail.com>
 <c1f63dd8-1c06-1797-025c-2cd4891d905d@gmail.com>
In-Reply-To: <c1f63dd8-1c06-1797-025c-2cd4891d905d@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 5 Dec 2018 13:00:52 +0100
Message-ID: <CACRpkdYCsh3AfmV-7ym-ffjp2k-kaNRqY1O3rd9h-WoUPYM_bw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: pinctrl: Add devicetree bindings for
 MT6797 SoC Pinctrl
To:     Matthias Brugger <matthias.bgg@gmail.com>, arm-soc <arm@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        sean.wang@kernel.org, Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 2:08 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
> On 15/11/2018 11:04, Linus Walleij wrote:
> > On Wed, Nov 7, 2018 at 6:49 PM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> >
> >> Add devicetree bindings for Mediatek MT6797 SoC Pin Controller.
> >>
> >> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >
> > Patch applied.
> >
>
> Could you provide a stable tree for me, so that I can take the dts parts?
> I just realized that my build is broken because of the missing dt-bindings
> header file.

Since I pulled other changes on top it is too late for me to put that
in an immutable branch and merge into my tree separately,
you would have to pull in the whole "devel" branch from the
pin control tree.

What we sometimes do is simply apply the *EXACT* same patch
to two git trees. Git will cope with that as long as they are
absolutely *IDENTICAL*. (The patch will appear twice in the
git log with different hashes but they will merge without
problems, a bit unelegant but it works.)

So in your situation I would extract this patch from the pinctrl
tree:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/commit/?h=devel&id=95d2f00657ad4c2c3eacd8a871a7aa022c3fe7d9
and apply it with some notice to the maintainers about
the situation.

ARM SoC folks: agreed?

Yours,
Linus Walleij
