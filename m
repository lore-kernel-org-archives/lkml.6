Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE19C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 23:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067E3208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 23:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="f/KFVUK4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dQ0JuK6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067E3208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756843AbeFOXt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 19:49:59 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:44032 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753761AbeFOXt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 19:49:57 -0400
Received: by mail-ua0-f195.google.com with SMTP id f30-v6so7468800uab.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 16:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=SJj8VvqkVD6C8/M0qNwgsbp3KbEYsBP/fy0s1zFTWsE=;
        b=f/KFVUK4DmR6kICytvQZObNdqUJg3bOVUrkI2rzS7b7K1movUT4J8MgtQ71HwAjniE
         uHr8CBP59YU0i/YmICJHfavtaz+EvcpsbQqjLV6PaFECF5RHTtyloV3xbfbpfOQvMi94
         xYPUvfmPMuvQGy+LAwodybJvO1ufS7AaVW6E3l2gnI7cMTlnqeg/Yt37R4P0iWOUELyr
         SasuuRkWNAzWuKi4a+b3hlPnf/sIvOv4PCIw26gRWXMyS64ovJ4Oe/r/+B8AsWNMYPbs
         93FfFwxq4QmDs5MtPoGySc9a5ZVv7fsw0DyoB0i7DTrrr38I1nk3QGwbgkX1FTSDw5Rh
         BJQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=SJj8VvqkVD6C8/M0qNwgsbp3KbEYsBP/fy0s1zFTWsE=;
        b=dQ0JuK6tjzH4J7ZyHRkmXOSccdE02bVMKn+FpneJ1e4+4j/bGmkFE1154IgjH5B3k0
         xMlJdqD4lbvI0VWF2cAJYlDkSB3lM2arETQbTOFmb1Bx6wsvjeKgl6721IW4cC+dlTta
         FDzdfOsBxZcidngrWpzUD4xmH2QvtgjtRIdQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=SJj8VvqkVD6C8/M0qNwgsbp3KbEYsBP/fy0s1zFTWsE=;
        b=VvNqn+/fQa0CWt5dmeHZ7jbDyJMDdc5iBDDmcc3xpV/n1ocS7qdjp4HOW4muU3z9x+
         120g/Zn5t4edVyaOp//o3lRSOWmwv4xyk0wCGWj8M0i7HgaEnn1IuiJUmS/nIUQEmS/H
         F10IIxsdEkpcVhpAfptyPBffa9dnoJ1u9rELt0rac1HdrwI1szwakcqYoqdJ5pZiVx+L
         GwOYpBRVvx63kgagjHmn0O0/bvum8vWBAdCjDwLB4dFsQpAGlA6kz+9sgfjmhBQNVjIt
         Vub47B6CZqLGfKh0U46WQE5+Au1BaRT2M6DCFHdNnUP9CLorFj7/mNWZCo5ydkN86u6o
         W56g==
X-Gm-Message-State: APt69E2/A2iRZjeeQMH5M9fzblzRDMNQ0RF2Yc1WfsKsrjQa2uIOI/UZ
        AhamG4f1ELCL61PTezgSbWu2PGHXtmXj/ukFXrk5GQ==
X-Google-Smtp-Source: ADUXVKKLrYp32lB7SfmTwEjz+ErJI0I9QU8RiRUl+iHVhl/PPn0L43nThQz4le1OWLermnT28Moq50kYEO1vdh9w90w=
X-Received: by 2002:ab0:17d2:: with SMTP id p18-v6mr2361695uaf.121.1529106595885;
 Fri, 15 Jun 2018 16:49:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 16:49:54
 -0700 (PDT)
In-Reply-To: <20180615220131.65402-2-dmitry.torokhov@gmail.com>
References: <20180615220131.65402-1-dmitry.torokhov@gmail.com> <20180615220131.65402-2-dmitry.torokhov@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 15 Jun 2018 16:49:54 -0700
X-Google-Sender-Auth: MSdXA8wby5SWPO4Hhov__JJ0S-Y
Message-ID: <CAD=FV=X7fveskggyu_Fd44zCWdGMqU9sF-tHHcrF5mOpUD_+Dw@mail.gmail.com>
Subject: Re: [PATCH 2/3] usb: dwc2: host: do not delay retries after
 successful transfer
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 15, 2018 at 3:01 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> When handling split transactions we should not be delaying retrying
> SSPLIT/CSPLIT after we successfully communicate with the device, so
> let's reset dtd->num_naks counter when handling XFERCOMPL.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/usb/dwc2/hcd_intr.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
