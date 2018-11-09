Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DF0C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B1F2081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJeieoQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B1F2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbeKIVzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 16:55:17 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:36756 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbeKIVzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 16:55:17 -0500
Received: by mail-vk1-f195.google.com with SMTP id u62so350469vkb.3;
        Fri, 09 Nov 2018 04:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mtv0MhXkFuh1a35otS4l3lB20Jjm1yTnaOUS0XFU9Zs=;
        b=HJeieoQ0UXQ72poa0nStNT9FY8U76yxqwsXNYfQS/2rYtQIbe7APBEZGVjfc5rg6G2
         jOhDfhqGSsTLJCB9JIo+pAH2eS4+1Ex4H5H66NtRAt+2yQ1FH377wHVV8k5bGErNahQi
         W86IltjkffW1mKG4c3RPPzHRGkga+IC2kHsOAKpkMtah1cpUbPTBsDcgSQrkq5IJCZFM
         CTZvmCg6N97/fDRXZ8+QJAcYqh3WKs+qCjxSsCI+efsLp52jzXLRzPZuVJtq0ACbJnYe
         tWst1dc8WnuqKfWgFcjwiGveXRE88UBIoQ3WRM/d+QSEVGbyWIZ0AUTRBU6y8CNf7Zbo
         87fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mtv0MhXkFuh1a35otS4l3lB20Jjm1yTnaOUS0XFU9Zs=;
        b=DxtfYiMDTXCjMHLRkWRjoAC6JsY2aFl+m0xHKuf5ns+PhCikDIHx2tkD+ZabVf+ksO
         AzF+ia+6I/qTO/htl056zYVy3j5XW25qItTrg5Qzs5aR4u8pfyBtyLEbw6J01qK3jPrx
         pHwVOYyTjTY9SPgQb2EsmmuYZre/Qu6PnkbBUQMHr3SSRXoOSkH0H6p41gcZfOr7e4jN
         /npgTkky7JzWm2kPJGJOioRFpPUo8z2HaJzbpe0f0JChEyjXygRx/mYZp/Q9gosslVU4
         jYE3TY/1H19wIwVV2d9LKDx7qpaK5SViyyWmBDFg2i9WK1mp1wR7/KEA3jPYMgsohuxM
         3qyQ==
X-Gm-Message-State: AGRZ1gIc2pTQKSyRxzIZJ57dZNeVEgmRktw/Xl/dbTqBXvYSSAiDuB83
        BiQxJmtejTlWdmNXV5Z2FJBtKR4+RaC4NvFs86g=
X-Google-Smtp-Source: AJdET5cTfEWxkieBeHdAMFpZqRuvEbgZ/c5uaaKtch2aNBppSXOhjJUEOGFyPKgKFTTpVQmruWr7b0XgGV+NTJgPrzU=
X-Received: by 2002:a1f:ac4:: with SMTP id 187mr3721600vkk.31.1541765694235;
 Fri, 09 Nov 2018 04:14:54 -0800 (PST)
MIME-Version: 1.0
References: <CAOGqxeWBmAahswHp+b_PzkyGs-9sOx3COpJnFVsbKhx14KLuUw@mail.gmail.com>
 <1541641432.32173.71.camel@mhfsdcap03> <CAOGqxeXmMWK53pAmjeUtpdXNeTa7UH7=VA6pAJyhxg_BsmU5+w@mail.gmail.com>
 <1541750924.32173.81.camel@mhfsdcap03>
In-Reply-To: <1541750924.32173.81.camel@mhfsdcap03>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Fri, 9 Nov 2018 07:14:50 -0500
Message-ID: <CAOGqxeWt=uF1YgjcMF-miGJsewyvmTcNjB8fge-HT06P5_pgcg@mail.gmail.com>
Subject: Re: [PATCH V2 2/6] usb: core: Add ability to skip phy exit on suspend
 and init on resume
To:     chunfeng yun <chunfeng.yun@mediatek.com>
Cc:     ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alban Bedel <albeu@free.fr>, Alex Elder <elder@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        DTML <devicetree@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Johan Hovold <johan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        USB list <linux-usb@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, Roger Quadros <rogerq@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 3:08 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> On Thu, 2018-11-08 at 17:50 -0500, Alan Cooper wrote:
> > On Wed, Nov 7, 2018 at 8:43 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> > >
> > > hi,
> > > On Tue, 2018-10-30 at 18:30 -0400, Alan Cooper wrote:
> > > > On 10/17/18 9:46 PM, Chunfeng Yun wrote:> hi,
> > > > >
> > > > > On Wed, 2018-10-17 at 18:29 -0400, Al Cooper wrote:
> > > > >> Add the ability to skip calling the PHY's exit routine on suspend
> > > > >> and the PHY's init routine on resume. This is to handle a USB PHY
> > > > >> that should have it's power_off function called on suspend but
> > > > cannot
> > > > >> have it's exit function called because on exit it will disable the
> > > > >> PHY to the point where register accesses to the Host Controllers
> > > > >> using the PHY will be disabled and the host drivers will crash.
> > > > >>
> > > > >> This is enabled with the HCD flag "suspend_without_phy_exit" which
> > > > >> can be set from any HCD driver.
> > > > >>
> > > > >> Signed-off-by: Al Cooper<alcooperx@gmail.com>
> > > > >> ---
> > > > >>   drivers/usb/core/hcd.c  |  8 ++++----
> > > > >>   drivers/usb/core/phy.c  | 18 ++++++++++++------
> > > > >>   drivers/usb/core/phy.h  |  9 ++++++---
> > > > >>   include/linux/usb/hcd.h |  3 +++
> > > > >>   4 files changed, 25 insertions(+), 13 deletions(-)
> > > > >>
> > >
> > >
> > > > >>       unsigned        skip_phy_initialization:1;
> > > > >>
> > > > >> +    /* Some phys don't want the phy's exit/init called on
> > > > suspend/resume */
> > > > >> +    unsigned        suspend_without_phy_exit:1;
> > > > > As suggested before, you can skip phy's exit/init during
> > > > suspend/resume
> > > > > by enabling wakeup of hcd, so needn't add a new variable for it.
> > > >
> > > > I still need to be able to enable and disable wakeup for this driver.
> > > Just use device_init_wakeup(dev, true) instead of
> > > device_wakeup_enable(dev) for your controller driver, you can try it.
> > >
> > > Sorry for the late replay
> >
> > What about the case where sysfs is used to disable wakeup?
> Oh, It's a problem in this case.
>
> BTW: Why the host driver will crash when access host controller's
> register after power-off phy? they are usually independent.

Unfortunately, they are not independent in our design. The PHY
supplies the clock needed to read/write the OHCI, EHCI and XHCI
registers.

Al

>
> >
> > Al
> > > >
> > > > >
> > > > >> +
> > > > >>       /* The next flag is a stopgap, to be removed when all the
> > > > HCDs
> > > > >>        * support the new root-hub polling mechanism. */
> > > > >>       unsigned        uses_new_polling:1;
> > > > >
> > >
> > >
>
>
