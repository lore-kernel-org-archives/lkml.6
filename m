Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59F3C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 23:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E0A208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 23:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="tuxmKUel";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A+T6wSqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E0A208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756819AbeFOXtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 19:49:45 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:39126 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753761AbeFOXtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 19:49:43 -0400
Received: by mail-vk0-f67.google.com with SMTP id r83-v6so6615005vkf.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 16:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Fo4v7TggsPV/fV5ZHPQDflfQnjv16VOZD5MhSukJpGw=;
        b=tuxmKUelY5L6Ec/RBg62zop937VbfjRfbIrgufpSxQtf+3yY01TM8NVvQRzp5aWWCU
         VQdqUHhbuG4FM7CU8kp+HERmu/8yQS+0u9ssSX47lU9g88Y45BRUDB68xjcU1orNy8hb
         gMYMlXSVDwZiSULmdSjLKbZkf6Qt5kUUa4IPI+W02fNRS5qw7QrYNo2UUC5MfUR/gZZA
         zgaey2JFD0aXVFnlYB5jNL5A1C5KH6IbLjQssTmQceiOQvHCwoEwVyPFTVD1McGFyQWq
         cm9cLynu0gvTua19ghKehy8NIWXQTRgrM5rqvsNKAaCDvOz0lVmGAC/aO4U/Q4qkBp1N
         fNOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Fo4v7TggsPV/fV5ZHPQDflfQnjv16VOZD5MhSukJpGw=;
        b=A+T6wSqiRnF/l2cTg0Jg6nzjhGKNF9A5TaO1Fe+kYT8yqgRD0j3wea48qk/4u6nlNG
         lsHwTTE2DQ3BuwXnYYBWaNgJ2VGNVKGJKPx7rUrxgbED0mHSvhqWS9rsT78LcbgVK9Q2
         RJ656QD6GKrZ556LJxUU2mIiHsteky4wpnOSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Fo4v7TggsPV/fV5ZHPQDflfQnjv16VOZD5MhSukJpGw=;
        b=j/wbxM6e2NbTEXbJ0V5ZRPZJGZwtfwG5gmr1jfOs9rYRytA7xQdmP7X0tJBs3C+bnm
         qFP8Ju7Hl307zpNAuVQ4B6s+XCPcl+/vdp6/UNDd69FcTD3nRURr+/YatS0Xx/BgNcKw
         oi/2pShDz2jnOMgRTF3G3TvaFF2WhbYa5Z1ii2QnXHh3UIKDedA2RTzt13idhhEfRi+W
         pg44LBTwkAKKqa67KdHtO/9TVb/ljHIDV+IeF+WfgqhR6Sh8oRsllKu7uiz+VSkh/XYw
         z3zxXLo0Twc45xxWaDlJ7/HgBUkICNZkfhkT0Cw1bzcNOPKHG/5P1q62+IvUaXnWQGMD
         4Q2g==
X-Gm-Message-State: APt69E0Uu2OyZklcW6b5Gqwix7pqviEe1/TM7E8VRlU4AdttT54kZY6H
        mxXBiM4nlasFhLbI8GAaUeyDVjkbIecdHhqW23IA9A==
X-Google-Smtp-Source: ADUXVKK16hiixOcX+/DejRxvkGuWGtq/ciBKEQXYQXwCVB1OJB03QMpjdDouxi9LkHZfuA/BOsulhlauZT2okiDlUTY=
X-Received: by 2002:a1f:e92:: with SMTP id 140-v6mr2269355vko.90.1529106582390;
 Fri, 15 Jun 2018 16:49:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 16:49:41
 -0700 (PDT)
In-Reply-To: <20180615220131.65402-1-dmitry.torokhov@gmail.com>
References: <20180615220131.65402-1-dmitry.torokhov@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 15 Jun 2018 16:49:41 -0700
X-Google-Sender-Auth: uOQev7kajysKFuKfaEBj-0wIYhg
Message-ID: <CAD=FV=UHyc+VAc+d8ODXLQWXfB0grH140+ZFJU3hoJScYLMJ9g@mail.gmail.com>
Subject: Re: [PATCH 1/3] usb: dwc2: host: do not delay retries for CONTROL IN transfers
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
> When handling split transactions we will try to delay retry after
> getting a NAK from the device. This works well for BULK transfers that
> can be polled for essentially forever. Unfortunately, on slower systems
> at boot time, when the kernel is busy enumerating all the devices (USB
> or not), we issue a bunch of control requests (reading device
> descriptors, etc). If we get a NAK for the IN part of the control
> request and delay retry for too long (because the system is busy), we
> may confuse the device when we finally get to reissue SSPLIT/CSPLIT IN
> and the device will respond with STALL. As a result we end up with
> failure to get device descriptor and will fail to enumerate the device:
>
> [    3.428801] usb 2-1.2.1: new full-speed USB device number 9 using dwc2
> [    3.508576] usb 2-1.2.1: device descriptor read/8, error -32
> [    3.699150] usb 2-1.2.1: device descriptor read/8, error -32
> [    3.891653] usb 2-1.2.1: new full-speed USB device number 10 using dwc2
> [    3.968859] usb 2-1.2.1: device descriptor read/8, error -32
> ...
>
> Let's not delay retries of split CONTROL IN transfers, as this allows us
> to reliably enumerate devices at boot time.
>
> Fixes 38d2b5fb75c1 ("usb: dwc2: host: Don't retry NAKed transactions right away")

nit: I think there's supposed to be a ":" after "Fixes"

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/usb/dwc2/hcd_intr.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

This seems like a sane fix to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
