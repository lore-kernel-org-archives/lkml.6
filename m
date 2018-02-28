Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3061494-1519787081-2-8582051645544657520
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519787081; b=hqpgEWk37ivCQDo+RSYbEKSlQntkuJpl4WOn2t7zpl5umT6
    q7wIGnPFnMpVvr7s9VExjPP9xUvsi9ar/Xm61Rg/UbLGxqlBpVdpTFUrhf81D04X
    W3HuRbkCVMFs4e5iDFkxzV9bxWTott8S2EnPAddG7iWNM7+tEYzP/P7SB6FBszkn
    fM20RdREYfKV+w9nZsLVlSzVyXbfSzU2D7TajHXYJ9kXDKmu49Zb9N56yn/TRoLn
    +orI6oahr+VL8JPe/Kg/mCGqaYRnwrHMs07o82hv6F7gYA1lGteOz0zC7w68I261
    OyEbBtRP2v6t6v1N+dFvF8ZWL8y987p8P2M5oJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519787081; bh=jZlKdvgYpNlXglXp4VNEdWuhlhmE39j7Vbyq/G
    /geX8=; b=TljP8f75QHLkoQ/Wn/KpQIhsLZJ28hInQa11WkFQi8GtkERpDonOoV
    3eVU27F1V3O5K1KKlADemsVAfp2mUY6llgQTyIXR38ZOS2A0AHEQ5jFhOEXIWmcc
    4G0l2ZKMq9tKjpQOd/rvtAAwiiITclkkYlOUJ9CClQF3PaIFbUe+r0N3J/fikctQ
    UrVkjHfFiGqkUOz/WO9ypZYI1mZTsO4dATShzOBNg9sjl4rx05q5hlCvyZDQyR0X
    Ew9FVPVgOJj4/+HUOwGjzgLP43l8NPfywHEel6pcJgr9NN6EiNB3jwHY3sfDcT+c
    5222d9d92vClrW/2ekLU9eaaHekFWJ+w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=QpIDnx8Y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mPtxO1+n;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=QpIDnx8Y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mPtxO1+n;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbeB1DE1 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 22:04:27 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43507 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751935AbeB1DEY (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 27 Feb 2018 22:04:24 -0500
X-Google-Smtp-Source: AG47ELsY/8F3DpOqYF76mUXbecdZZsFkUxwZz9RM2rmRR4z9awGC0vu9IYgyeWexO4sMO7eHBnIjZYEXV64g81hmtR4=
MIME-Version: 1.0
In-Reply-To: <1519730526-22274-1-git-send-email-rogerq@ti.com>
References: <1519730526-22274-1-git-send-email-rogerq@ti.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 28 Feb 2018 11:04:23 +0800
Message-ID: <CAMz4kuLv6mOa5ijbEX-GoXyZ+=e8T_ZdpnVS7rbE7gmQo9RkGw@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: Prevent indefinite sleep in _dwc3_set_mode
 during suspend/resume
To: Roger Quadros <rogerq@ti.com>
Cc: Felipe Balbi <balbi@kernel.org>, USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Roger,

On 27 February 2018 at 19:22, Roger Quadros <rogerq@ti.com> wrote:
> In the following test we get stuck by sleeping forever in _dwc3_set_mode()
> after which dual-role switching doesn't work.
>
> On dra7-evm's dual-role port,
> - Load g_zero gadget driver and enumerate to host
> - suspend to mem
> - disconnect USB cable to host and connect otg cable with Pen drive in it.
> - resume system
> - we sleep indefinitely in _dwc3_set_mode due to.
>   dwc3_gadget_exit()->usb_del_gadget_udc()->udc_stop()->
>         dwc3_gadget_stop()->wait_event_lock_irq()
>
> Let's clear the DWC3_EP_END_TRANSFER_PENDING flag on all endpoints
> so we don't wait in dwc3_gadget_stop().

I am curious why the DWC3_DEPEVT_EPCMDCMPLT event was not triggered
any more when you executed the DWC3_DEPCMD_ENDTRANSFER command?

>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/usb/dwc3/gadget.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 2bda4eb..0a360da 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -3273,6 +3273,20 @@ int dwc3_gadget_init(struct dwc3 *dwc)
>
>  void dwc3_gadget_exit(struct dwc3 *dwc)
>  {
> +       int epnum;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&dwc->lock, flags);
> +       for (epnum = 2; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
> +               struct dwc3_ep  *dep = dwc->eps[epnum];
> +
> +               if (!dep)
> +                       continue;
> +
> +               dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
> +       }
> +       spin_unlock_irqrestore(&dwc->lock, flags);
> +
>         usb_del_gadget_udc(&dwc->gadget);
>         dwc3_gadget_free_endpoints(dwc);
>         dma_free_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE, dwc->bounce,
> --

-- 
Baolin.wang
Best Regards
