Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD7EC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 06:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB742081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 06:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i1oeZIMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB742081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbeKBQDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 12:03:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43999 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbeKBQDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 12:03:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id g59-v6so557521plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 23:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ci6bSjWDH9lfq4Iw2j30F/4+Idv6/6S5181xa79qhrk=;
        b=i1oeZIMTJT7N7NuGu9gUcmocPB+gHxPeMkdyaeFgY8udsIn3T3n+LsZoGH2tjySEKQ
         0fhNdRk74cVOcd+/aMlbh/wARVEePcjI9lIAUmzVWkhNyCygyvPbLuHTZWRNKq1f7qit
         R464qR5JLO8UtsG2gxOyaQZjJvvlR2TvH2uso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ci6bSjWDH9lfq4Iw2j30F/4+Idv6/6S5181xa79qhrk=;
        b=Hkkmy1CptmyRVhhuV+4VyAbrZxLfT87yys8hH2KbKDVjJ3BDq5OaERVEJcmnQotLxt
         aqVCZlMCKNVk8Tcr1A/x88S1O4jV6gDT7sPGnI7eIQ6/2LaWyA4mjR+gGXxLRCnb1O0+
         PhZUrMDqTDSXWhMmIc+C/Xa2xlpXBRaOYdWGE6lsQJqwgo4BHr422qB/As1hw8+cyOIF
         +GTE2R6ds72VulEqaNdiX9fjPz0nsEfn3OamZzmQ1HfoghJRAFpOo2Bw/pqtv1EAKVTF
         pJoI41NZFISJp1bWLxirRjHf3+10k5Z6ffc/LhFQVtP/mSDbSkcDe/6qwuoskLh5Btl8
         PMjw==
X-Gm-Message-State: AGRZ1gKYubAM0vq9O2AgNGd5RU/Ya+4alX12FbZz9ehwlB0KfW16mHTq
        8YoUZpEaQ/rFG6q/8VI+k9MZfokZmbDOFr1I7VvLpQ==
X-Google-Smtp-Source: AJdET5fIOxemShm6dHPGjJsngMJlvyGCdUeWu8YwKzec66/UFoKt4KX8i5fcHmeC7TdHfH6W7jM2CfAkGLG/pJo/C4g=
X-Received: by 2002:a17:902:9895:: with SMTP id s21-v6mr10588426plp.102.1541141854019;
 Thu, 01 Nov 2018 23:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <1517221474-19627-1-git-send-email-tqnguyen@apm.com>
 <CAKrQpStN6+UEp_CHdg3nSu7bAGPZ7N7VO_v0Srhc_Pe1ZLmEZg@mail.gmail.com> <CAKrQpSuET_Uv9cqt0+OGkhOz11KYnTs4B7nkcC0Hh995ynmZ+w@mail.gmail.com>
In-Reply-To: <CAKrQpSuET_Uv9cqt0+OGkhOz11KYnTs4B7nkcC0Hh995ynmZ+w@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 2 Nov 2018 14:57:23 +0800
Message-ID: <CANMq1KA0b2LRfbc6VW+Mce==yVBYcRV+HQ5RkJj-yhRtqLgvoQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] usb: xhci: do not create and register shared_hcd
 when USB3.0 is disabled
To:     tqnguyen@apm.com
Cc:     mathias.nyman@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        pvo@apm.com, lho@apm.com, tunguyen@apm.com, patches@apm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 5:53 PM Thang Q. Nguyen <tqnguyen@apm.com> wrote:
>
> On Mon, Mar 5, 2018 at 5:22 PM, Thang Q. Nguyen <tqnguyen@apm.com> wrote:
> > On Mon, Jan 29, 2018 at 5:24 PM, Thang Q. Nguyen <tqnguyen@apm.com> wrote:
> >> From: Tung Nguyen <tunguyen@apm.com>
> >>
> >> Currently, hcd->shared_hcd always creates and registers to the usb-core.
> >> If, for some reasons, USB3 downstream port is disabled, no roothub port for
> >> USB3.0 is found. This causes kernel to display an error:
> >> hub 2-0:1.0: config failed, hub doesn't have any ports! (err -19)
> >> This patch checks and registers shared_hcd if USB3.0 downstream
> >> port is available.

I'm working on a board with similar warning on boot (XHCI controller
without 3.0 support), and there is no more error on boot with your
patch.

However, I still see the USB 3.0 root hub, so I'm wondering if that's
expected or if we should find a way to remove it?
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub

Apart from that:

Tested-by: Nicolas Boichat <drinkcat@chromium.org>

> >> Signed-off-by: Tung Nguyen <tunguyen@apm.com>
> >> ---
> >>  drivers/usb/host/xhci-plat.c |  9 ++++++---
> >>  drivers/usb/host/xhci.c      | 13 +++++++++++++
> >>  2 files changed, 19 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> >> index 6f03830..bdb3975 100644
> >> --- a/drivers/usb/host/xhci-plat.c
> >> +++ b/drivers/usb/host/xhci-plat.c
> >> @@ -293,9 +293,12 @@ static int xhci_plat_probe(struct platform_device *pdev)
> >>         if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
> >>                 xhci->shared_hcd->can_do_streams = 1;
> >>
> >> -       ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
> >> -       if (ret)
> >> -               goto dealloc_usb2_hcd;
> >> +       /* Just add the shared_hcd when USB3.0 downstream port is available */
> >> +       if (xhci->num_usb3_ports > 0) {
> >> +               ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
> >> +               if (ret)
> >> +                       goto dealloc_usb2_hcd;
> >> +       }
> >>
> >>         device_enable_async_suspend(&pdev->dev);
> >>         pm_runtime_put_noidle(&pdev->dev);
> >> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> >> index 1eeb339..9d3b1ab 100644
> >> --- a/drivers/usb/host/xhci.c
> >> +++ b/drivers/usb/host/xhci.c
> >> @@ -611,6 +611,19 @@ int xhci_run(struct usb_hcd *hcd)
> >>                 if (ret)
> >>                         xhci_free_command(xhci, command);
> >>         }
> >> +       /*
> >> +        * In case that the USB3.0 downstream port is not available
> >> +        * No one triggers to start the xHC which should be done
> >> +        * before finishing xhci_run
> >> +        */
> >> +       if (xhci->num_usb3_ports == 0) {
> >> +               if (xhci_start(xhci)) {
> >> +                       xhci_halt(xhci);
> >> +                       return -ENODEV;
> >> +               }
> >> +               xhci->cmd_ring_state = CMD_RING_STATE_RUNNING;
> >> +       }
> >> +
> >>         xhci_dbg_trace(xhci, trace_xhci_dbg_init,
> >>                         "Finished xhci_run for USB2 roothub");
> >>
> >> --
> >> 1.8.3.1
> >>
> > Hi,
> > Do you have any comment on the patch?
> Hi,
> Do you have any comment on the patch?
