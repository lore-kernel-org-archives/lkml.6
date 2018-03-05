Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1288896-1520245358-2-15727695072437291582
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520245357; b=q/sjBaTcVG2yBlq5cHpjD829iPwjnL378xTlpEFHRIRff+v
    Gs6hKaGQpb0lCAz83WxqeHDsrgHqfg8ynDmMGU49fzn3Y4jxLm/iw1FRabrM/Nat
    7NbTZ3UoqVI3OQ6omyDUpWYEXCvGjGIQXJHY1bb9xKw786+oeDgTblYCzBUJ73hw
    U/wzoZBxM0RNDA72O5fo1s+3NS7bL73Q21lPsxtH97Wxuqy9fEHipoPWP4aZ8juy
    9W7p7vD6S4/uEDyv4PKPEpeiW/BmFhnieV0/h/OO7FU+RJF60fLN+9jxapHBDsF3
    a9LF2Dni+r31eo9sVu3DP0lLQ4GYgVnfT+tFeCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520245357; bh=l+U8jtcusZezwOBgFnnCBiL9YhiIzi7sGxWfQ0
    EDSTY=; b=v3Az1DRqhc3eAIwjOYStrj520/N4tpbXqL1gRIEiSQZzNDzY+B1UeC
    mr3G7xU/0KBrY1OJSul3cxzKeUuMi/U+k+aiJcR5yi3LEflb71tVOZwVnMcRAISO
    IIdJg9jNnpC2J5vfhHvcMGIY7nAw6ApyVmXvmHzOi/v+d9vIaQ/UbJSK+C+owunw
    PAhqSCkv1SE89AXDKdoW99VauYddv4vj+mrNhgJqEw4EAjm2yDXG1AXYNkW6AHaF
    mp14ZNobfmkQ1AdgT4TxtxpA5bvhCtDIiM7Cu0fyl/xfU+C8KkjevsFfVnOQYfDl
    tiHbq6z4Fcwld7tQe093lflOzGdYzJ3g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=apm.com header.i=@apm.com header.b=qe8ARvvE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=apm;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=apm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CWQufLqL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=apm.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=apm.com header.i=@apm.com header.b=qe8ARvvE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=apm;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=apm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CWQufLqL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=apm.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933319AbeCEKWd (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 05:22:33 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:35979 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933294AbeCEKWb (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 5 Mar 2018 05:22:31 -0500
X-Google-Smtp-Source: AG47ELtUdF1PZmn3iytm3nOFgRzHY3qOQq8HqCgoy2MBvgIC+4PbWAmQumGhOt9l2bQ+VCg2aW7mLyc4f/wQhu0CHhU=
MIME-Version: 1.0
In-Reply-To: <1517221474-19627-1-git-send-email-tqnguyen@apm.com>
References: <1517221474-19627-1-git-send-email-tqnguyen@apm.com>
From: "Thang Q. Nguyen" <tqnguyen@apm.com>
Date: Mon, 5 Mar 2018 17:22:30 +0700
Message-ID: <CAKrQpStN6+UEp_CHdg3nSu7bAGPZ7N7VO_v0Srhc_Pe1ZLmEZg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] usb: xhci: do not create and register shared_hcd
 when USB3.0 is disabled
To: Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>,
        Loc Ho <lho@apm.com>, Tung Nguyen <tunguyen@apm.com>,
        patches <patches@apm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Jan 29, 2018 at 5:24 PM, Thang Q. Nguyen <tqnguyen@apm.com> wrote:
> From: Tung Nguyen <tunguyen@apm.com>
>
> Currently, hcd->shared_hcd always creates and registers to the usb-core.
> If, for some reasons, USB3 downstream port is disabled, no roothub port for
> USB3.0 is found. This causes kernel to display an error:
> hub 2-0:1.0: config failed, hub doesn't have any ports! (err -19)
> This patch checks and registers shared_hcd if USB3.0 downstream
> port is available.
>
> Signed-off-by: Tung Nguyen <tunguyen@apm.com>
> ---
>  drivers/usb/host/xhci-plat.c |  9 ++++++---
>  drivers/usb/host/xhci.c      | 13 +++++++++++++
>  2 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 6f03830..bdb3975 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -293,9 +293,12 @@ static int xhci_plat_probe(struct platform_device *pdev)
>         if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
>                 xhci->shared_hcd->can_do_streams = 1;
>
> -       ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
> -       if (ret)
> -               goto dealloc_usb2_hcd;
> +       /* Just add the shared_hcd when USB3.0 downstream port is available */
> +       if (xhci->num_usb3_ports > 0) {
> +               ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
> +               if (ret)
> +                       goto dealloc_usb2_hcd;
> +       }
>
>         device_enable_async_suspend(&pdev->dev);
>         pm_runtime_put_noidle(&pdev->dev);
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 1eeb339..9d3b1ab 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -611,6 +611,19 @@ int xhci_run(struct usb_hcd *hcd)
>                 if (ret)
>                         xhci_free_command(xhci, command);
>         }
> +       /*
> +        * In case that the USB3.0 downstream port is not available
> +        * No one triggers to start the xHC which should be done
> +        * before finishing xhci_run
> +        */
> +       if (xhci->num_usb3_ports == 0) {
> +               if (xhci_start(xhci)) {
> +                       xhci_halt(xhci);
> +                       return -ENODEV;
> +               }
> +               xhci->cmd_ring_state = CMD_RING_STATE_RUNNING;
> +       }
> +
>         xhci_dbg_trace(xhci, trace_xhci_dbg_init,
>                         "Finished xhci_run for USB2 roothub");
>
> --
> 1.8.3.1
>
Hi,
Do you have any comment on the patch?
