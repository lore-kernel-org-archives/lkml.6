Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93B5C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8B3206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="riQFRXbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8B3206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbeLCOZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:25:11 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42202 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeLCOZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:25:11 -0500
Received: by mail-qt1-f196.google.com with SMTP id d19so13850048qtq.9;
        Mon, 03 Dec 2018 06:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q9XamaOD7qsYoBrWBDwm1YBhEAO5ABondEA+n06PBJQ=;
        b=riQFRXbBjsHFk0QL4Cg8V2bg4A1aGKICAKBUT3Sf2sV6bCFhcl+uTllRUOQ9ecVCBB
         7vKrbD/QCBloCsW6nZPQkHG51yENxLQWltTHWCGN68YoJ/8QfsGf+l2IP8FA5aG5g+U2
         CpWbWaYnle8OA0eG32Jp/v9LAE7jYxS6dqGFsxpxItYWczbOByVJ/31ENt7B5XN7okf5
         yycn3yI6TBUMMYTd3nlqOLllyDf8O//qCKkU6+s0xhbKj29NNxTuL6Lh6BFICqGALb3z
         0NOJ2t3xAL+llwr7XYvEArl3szQrNVCYNc9IuAFcM+QhrtB8Z6WVUyt0bd+Cnd8KMO8G
         LWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q9XamaOD7qsYoBrWBDwm1YBhEAO5ABondEA+n06PBJQ=;
        b=WYpp5r0I8JP5Dy3t3fvn4ZNuF9KX/oxUngNNCl144C/zlTdj1LRtT7kwAODsu4Lph+
         n5YGvljqNGO7oV+ylUYUuSfOQ+x/vcUDYO7Zng7xSLCfDfStgK1UKx4MZJFbPbsNDGAx
         yXfZjT62YV69w8uRzB/1RJfYtNLVb5x8G7PcSi3CudnMRYPDT/4WVmnDE0dXmo69dmal
         BtCN+HhNVYm9UXbCa3SG7j1sCp0L4ZM687FMr+zLDuyu7OQ5V0ou1aD0sBzemCNGFLHX
         sW1I6UinahshAvOvuFMAnletI/KMPihx1DPjg232KnbYx10UiN8S7q/NoUKmitSKYVFQ
         ZifA==
X-Gm-Message-State: AA+aEWYhzSGic5sBLZ3G+69FVVbdv8Ew0dqLMtFIWMvA03HdI8xkDJ5+
        PnFt+TWfME1XouyIReHvfyELRrFgHu7oKdfewZI=
X-Google-Smtp-Source: AFSGD/XcnMHxh7u7IL3FYhpUa64SNwimz6ByL5X6pc6ST5d77SizVfDJUevrSifWg1HYBWY3UZNoCUq/UnuJURtdO1o=
X-Received: by 2002:aed:3b76:: with SMTP id q51mr15527195qte.229.1543847038072;
 Mon, 03 Dec 2018 06:23:58 -0800 (PST)
MIME-Version: 1.0
References: <20181129235742.14332-1-ayman.bagabas@gmail.com>
 <20181129235742.14332-3-ayman.bagabas@gmail.com> <s5hftvezupj.wl-tiwai@suse.de>
 <CAHp75Vf7WW8ezL_H_iw_=nSVARuvhugUY5sTkQ=usU96Wj2YSA@mail.gmail.com> <s5hlg56y9k3.wl-tiwai@suse.de>
In-Reply-To: <s5hlg56y9k3.wl-tiwai@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Dec 2018 16:23:46 +0200
Message-ID: <CAHp75Vfg7K=7U1P2+N+wsxHV4rwQ4z3rvFuaUXz+znpgiN19YA@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] x86: add support for Huawei WMI hotkeys.
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Ayman Bagabas <ayman.bagabas@gmail.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Hui Wang <hui.wang@canonical.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 4:22 PM Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 03 Dec 2018 15:18:54 +0100,
> Andy Shevchenko wrote:
> >
> > On Mon, Dec 3, 2018 at 2:00 PM Takashi Iwai <tiwai@suse.de> wrote:
> > > On Fri, 30 Nov 2018 00:57:37 +0100,
> > > Ayman Bagabas wrote:
> >
> > > > +struct huawei_wmi_priv {
> > > > +     struct input_dev *idev;
> > > > +     struct led_classdev cdev;
> > > > +     acpi_handle handle;
> > >
> > > Is this handle set in anywhere?  I couldn't see it in your patch.
> > > If it's supposed to be NULL, passing NULL explicitly makes your
> > > intention clearer.
> >
> > Isn't below an answer?
> >
> > > > +     // Skip registering LED subsystem if no ACPI method was found.
> > > > +     status = acpi_get_handle(priv->handle, "\\_SB.PCI0.LPCB.EC0", &priv->handle);
>
> Oh indeed, but why it passes priv->handle at the first argument...?

Yes, since it's an absolute, I guess NULL in this case will be OK.

-- 
With Best Regards,
Andy Shevchenko
