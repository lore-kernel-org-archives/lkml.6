Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9504AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 00:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602D72086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 00:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b0K32N0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfARAVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 19:21:51 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:47053 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfARAVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 19:21:48 -0500
Received: by mail-ua1-f68.google.com with SMTP id v24so4111187uap.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 16:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t0gqUl4mUi5tlZDzoaHQ9fvC2be2sR+pQiCoQd+FlXA=;
        b=b0K32N0LcrQbySCxkqcm6WmnouvQhncJ8aVd8LzQUACWYBUvUvdQ5GelUCEPSXO41U
         8tfUN4lcKVFtWNYu310QFw7iUkg/9XL+403rqBqm8QVsMMKsSAN+k4pyXg4qF2DceVmz
         ExeGdh0wbLLRg2EWWT/38DpwKMwEG68aqTdeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t0gqUl4mUi5tlZDzoaHQ9fvC2be2sR+pQiCoQd+FlXA=;
        b=ffCFcqeK8u5Ks8UKDkvLoCxRpvluGzG0TZrbSRxb0eDjTOaDWZSn4Hl8xq6fZV+W0F
         NcWzvG/PAAuSKfo58G13+bIvd0X+veWSp7dyp92zbAIr0l+aIQRHrWNG4f05bYjOnPvP
         Kc2qcE7opmpiLMV9/u1VrBMDL1vAanPjOgzBmmqsb7kwRqqtncku3OFp5JBvUJaHFmze
         I5VOcFhav3LExWRF3NxkUTWGpN4Rv84pps9QCIO7NyEdvB2XxERmFtQr55sQ2KRrRUWm
         sxWnLXf/1UECpDbfbjPo2wGFDO8igO0JZxzNawEScXSWKXErk6D35oWeqKp8+3Bt03cy
         xwIg==
X-Gm-Message-State: AJcUukeuWVGOUuUe/VcBUf5mxs2437QJTdqU10/BVZIcweqdfd07iY4C
        0GMH+psizHPJw6H0DKEVo2ac59gIPRw=
X-Google-Smtp-Source: ALg8bN7UQiJUnbHfHq6JSNObzkbZDPRZmZHP8QxCUdK2kwuhnOFyt3gg56fFON8JS//ckoUALsfRuA==
X-Received: by 2002:ab0:1058:: with SMTP id g24mr1163275uab.58.1547770907246;
        Thu, 17 Jan 2019 16:21:47 -0800 (PST)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id l197sm75125964vke.18.2019.01.17.16.21.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 16:21:44 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id y14so2692742vky.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 16:21:44 -0800 (PST)
X-Received: by 2002:a1f:3d10:: with SMTP id k16mr6446389vka.13.1547770903638;
 Thu, 17 Jan 2019 16:21:43 -0800 (PST)
MIME-Version: 1.0
References: <1546862462-19640-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1546862462-19640-3-git-send-email-liaoweixiong@allwinnertech.com> <CAGXu5j+4QdqSYokE-0Y_pm5RgBp6i+xMgeXjTnNGVVMKeUafYg@mail.gmail.com>
In-Reply-To: <CAGXu5j+4QdqSYokE-0Y_pm5RgBp6i+xMgeXjTnNGVVMKeUafYg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 17 Jan 2019 16:21:31 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKbqP=SaAGqUeP5yhObeLbWnDLXN1=tVQZAaOHxo+D5VQ@mail.gmail.com>
Message-ID: <CAGXu5jKbqP=SaAGqUeP5yhObeLbWnDLXN1=tVQZAaOHxo+D5VQ@mail.gmail.com>
Subject: Re: [RFC v5 2/4] pstore/blk: add sample for pstore_blk
To:     liaoweixiong <liaoweixiong@allwinnertech.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 4:15 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jan 7, 2019 at 4:01 AM liaoweixiong
> <liaoweixiong@allwinnertech.com> wrote:
> >
> > It is a sample for pstore_blk, using general ram rather than block device.
> > According to pstore_blk, the data will be saved to ram buffer if not
> > register device path and apis for panic. So, it can only used to dump
> > Oops and some things will not reboot.
>
> I'm not sure I see the purpose of this implementation? Doesn't this
> just cause all the pstore machinery to skip any actions? i.e. without
> bzinfo->part_path, won't blkz_sample_write() just return -EINVAL, etc?

Say, instead of a no-op driver, can you build something like the how
ramoops processes module parameters, so that a person can define an
arbitrary device at boot time for blkoops? This also allows for easier
runtime testing too.

This all looks good, with some minor tweaks as mentioned. And on
closer review, yeah, it doesn't look like it shares much with ramoops.
:)

Thanks for sending this series; I look forward to the next version. :)

-Kees

-- 
Kees Cook
