Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF3FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 04:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3737217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 04:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QmSS478u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfBZE50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 23:57:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35557 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBZE50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 23:57:26 -0500
Received: by mail-wr1-f65.google.com with SMTP id t18so12382337wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 20:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qN9daC7ImMUbeuap8aF+T/jnLGG8L01gG+bKFd/iMgc=;
        b=QmSS478ud7QBXhfSvd9Zmd8Z/tFtMrE67tIBuL35v9M18gEriJ05/+ttvfIWUifu8m
         Kv83oaEQpWBsGJCUS3ps6qEShj5NwQvd25wUR4dYz9hWBTvPTN18wlyYMmc31SLDCCNO
         fTz/BkWYfDKzsMACQcMwAq9negxBb37XpiNYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qN9daC7ImMUbeuap8aF+T/jnLGG8L01gG+bKFd/iMgc=;
        b=iKH1s4uxUqZeWvOSL97ytehYg9KT8mdVhpqwH25Zb2F9aGGRkoJb5goZ/fPNl8k+BX
         U3/ijN8rYeTREawRtUtUoL7eK3zkyMOo4JQsvSX3iXzPRn60YsnVGet13OlDAS341Vxu
         sGBDcl0PUE+uyKf0UfTafzgSqsOtu8TR0l6kluzwi+jKRwGxUV7aXL3so63ojkgqnYnR
         MXXAlw7qCTKwSeLcGap7VtuqUPSo+3D3DVkSdHcUZ7Rfzywv/B0ApTfhrVuBDWgfBhTO
         5VXkiEJO5yO/BCj76+TOSZlzbFjUFQDzqqTemCXzEwYTcL30ytCzvc4Tx6WGfYtRMb25
         N6eg==
X-Gm-Message-State: AHQUAubn2blavSAliCw3g5W7BT32VDkU6t+Y0LfOjZpNsBij3qAgN7R1
        +mqqUtw8KKhD93vmcXCTYuxVOWfCxtQqx4nxK5RqR3bvGK0=
X-Google-Smtp-Source: AHgI3IbNJDbarRaTc5fPYGWRakiDcBqhwHqoxqvG+ZlM0LGTxTZplgxtv2lglVsheEwRY60tgFSjn7nRTJP40LEBa38=
X-Received: by 2002:adf:dd86:: with SMTP id x6mr14580360wrl.250.1551157044448;
 Mon, 25 Feb 2019 20:57:24 -0800 (PST)
MIME-Version: 1.0
References: <1549347534-11320-1-git-send-email-srinath.mannam@broadcom.com>
 <1549347534-11320-2-git-send-email-srinath.mannam@broadcom.com> <20190225213807.GA18852@bogus>
In-Reply-To: <20190225213807.GA18852@bogus>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Tue, 26 Feb 2019 10:27:13 +0530
Message-ID: <CABe79T4j7batxZ7BDhEpwRK8x5UMZLkxLJOt-FD0SCr9JOFizw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: usb-xhci: Add usb-phy-port-reset property
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
Thanks for the review, Please see my comments below in line.

Regards,
Srinath.
On Tue, Feb 26, 2019 at 3:08 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Feb 05, 2019 at 11:48:53AM +0530, Srinath Mannam wrote:
> > Add usb-phy-port-reset optional property to set quirk in xhci platform
> > driver which forces USB port PHY reset on port disconnect event.
> >
> > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> > ---
> >  Documentation/devicetree/bindings/usb/usb-xhci.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
> > index fea8b15..ecbdb15 100644
> > --- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
> > +++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
> > @@ -40,6 +40,7 @@ Optional properties:
> >    - usb3-lpm-capable: determines if platform is USB3 LPM capable
> >    - quirk-broken-port-ped: set if the controller has broken port disable mechanism
> >    - imod-interval-ns: default interrupt moderation interval is 5000ns
> > +  - usb-phy-port-reset: set this to do USB PORT PHY reset while disconnect
> >    - phys : see usb-hcd.txt in the current directory
>
> This should be implied by the HCI or phy compatible string (depending
> on who exactly needs the quirky behavior).
Stingray USB HS PHY connected to xHCI port has an issue, if full speed
devices connected to this port then
after all High Speed devices connected to this port are detected at
full speed instead of high speed.
So that we need to do PHY (which is connected to port) reset on xHCI
port disconnect event.
That is the reason we required to add quirk in xHCI.
>
> Rob
