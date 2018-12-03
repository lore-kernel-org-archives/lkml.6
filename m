Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA66C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF54C2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E438b8rC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF54C2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbeLCOUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:20:18 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40463 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeLCOUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:20:18 -0500
Received: by mail-qk1-f196.google.com with SMTP id y16so7375096qki.7;
        Mon, 03 Dec 2018 06:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=11CgyjIfYcJoIJiR+OmaYW83hh+a4QBxRc+hb/vKw+o=;
        b=E438b8rCzB75P5aNz5OWES+OJtE7vYbWehSQE01qphxIcxhlbnF5lBog7jImAcPjwR
         VfFC6vqDAR03bg0kpeJcoHGW3DVYYmek3Wlm39SZupDrVI4MFzTP6sFY4Eb/66om6afs
         +AqrbMMDYKoLh1qjfYD9dqmaXeI/FWIplbYzNyNfnCS1b4NkZ74w4oF/116B0ZSjSL72
         VgVoPU8Ah7WGYpKgai0Gg9ORiz0HnUAweUR7Mozl0u51VIEnqb9BPiDZziK940TMmrZr
         D4rUD+twmMRYmPigPAOkQ4hj+OBBdBrqtuh9Z8XAdHyyiTMdBLVg0H/2ri7d79iCP1MR
         HwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=11CgyjIfYcJoIJiR+OmaYW83hh+a4QBxRc+hb/vKw+o=;
        b=ulv76qYuOwE4Tmul+1enON5k6X5//wXsYH61XiH5B+kP12E+cEXEGvtqMtoN0/NsMT
         ZrCAv8S6S7kp+i1+kt69rf1jB9d7xgCNkYPyJC6d/H/hJpMFffClCq7vDpn+EVL0ehKN
         ZyFIy3xrcZWRlIf6Rn6bpAgM/jEs496NicfmWJjxHlSsK7aD6sZLAb5lBGmMNZgdzXeI
         GhrBu71eAf5dlJPANOd2qsyGeRySOCgRt9abLNfonqLEiDmPdzsPxphRi+iq8PJeOxu2
         SZemrRgIVnhASri1Muo/V4NzMnZk1CsGKV/tTWFwmEzr+uZqWz5I/+AkRHeh3NgaFn2h
         cezw==
X-Gm-Message-State: AA+aEWZ9YuWnYQi1wn2nVHfo2NDdizlyCecn8nrpIFf4PL/7E3WcFYlC
        ld1MJIYg4wa2zaDvH55tU7esQhUMM8leBqZdD6c=
X-Google-Smtp-Source: AFSGD/Vpk974RerVHTvDgvjXCuMOY9sDNawQCgfThSulywU7NUSN1VZctLlAA4T/xrfYIPu4mIeKvFwO2Ok/bX/n5ig=
X-Received: by 2002:ae9:f50d:: with SMTP id o13mr14584025qkg.137.1543846746412;
 Mon, 03 Dec 2018 06:19:06 -0800 (PST)
MIME-Version: 1.0
References: <20181129235742.14332-1-ayman.bagabas@gmail.com>
 <20181129235742.14332-3-ayman.bagabas@gmail.com> <s5hftvezupj.wl-tiwai@suse.de>
In-Reply-To: <s5hftvezupj.wl-tiwai@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Dec 2018 16:18:54 +0200
Message-ID: <CAHp75Vf7WW8ezL_H_iw_=nSVARuvhugUY5sTkQ=usU96Wj2YSA@mail.gmail.com>
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

On Mon, Dec 3, 2018 at 2:00 PM Takashi Iwai <tiwai@suse.de> wrote:
> On Fri, 30 Nov 2018 00:57:37 +0100,
> Ayman Bagabas wrote:

> > +struct huawei_wmi_priv {
> > +     struct input_dev *idev;
> > +     struct led_classdev cdev;
> > +     acpi_handle handle;
>
> Is this handle set in anywhere?  I couldn't see it in your patch.
> If it's supposed to be NULL, passing NULL explicitly makes your
> intention clearer.

Isn't below an answer?

> > +     // Skip registering LED subsystem if no ACPI method was found.
> > +     status = acpi_get_handle(priv->handle, "\\_SB.PCI0.LPCB.EC0", &priv->handle);
> > +     if (ACPI_FAILURE(status))
> > +             return 0;


-- 
With Best Regards,
Andy Shevchenko
