Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952ECC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB702075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccQ5BnJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB702075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeIFBYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 21:24:39 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33790 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeIFBYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 21:24:39 -0400
Received: by mail-oi0-f67.google.com with SMTP id 8-v6so16411705oip.0;
        Wed, 05 Sep 2018 13:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=goEgowbwRPN0WOmpOkCghM4dNcTtbY0ALdvHSsB8exY=;
        b=ccQ5BnJXxhrM1+pg7B4zCpUPjwBXqRtPpTk7byMwlDV8zUPyzy6bGtv3Q6uyAq5ocE
         PGfAElKD5BNwaTTwxvsf6vbapnrto8RTQ/F6Ou4m6riwUVdx7SBLF45GANoDAVLMIt0x
         +o5xFcR9tdDvPQRiKbAAbFRyigYNVAov+pII9zDZEEtrBYiYyxu0bcD64c4HH2o6pbNz
         7Mf4gN4nMVXkm0/kSTVF3ESgBKk1EK0vWBFyULLW0tGT+tACg0OUcDvxWdKxtT6zPMBi
         AtPoPjU29sQipRZ/DiJGQr1cgeMLsv3DcTd9C5mDvfXD9X+3KG6zwgLl0nqrBc3YL6rZ
         M0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=goEgowbwRPN0WOmpOkCghM4dNcTtbY0ALdvHSsB8exY=;
        b=rl/Ac4VI0RkHSKyrxGxb/uIaxTsB3eRa/s79DhCu78bDGQnRl/6VXW/b/UIiubrG5w
         +2Dv775d73FXaMAC5ybcdhm8lnN2oi9WTAvdtwQCgBkCvZ8KDNSiQx0SoL/W1+6j0lyG
         fKkyRsSHmkXeLmPasKCWrwNBXVTtUbqvJkiwaqGiUb1bgmzQP7Xr6ZD2Mw+P8fiFSxcL
         eJLPSxXI19preEihGOuDYzLUW7lWGtxQgYHBAUfaug8j/9OqoMVIjGCmVDeFTARKIjFu
         G6lr8/L7WQ5XkxyR8nUabnbajxKhPNy6nqBF3OX4urubIpHaMgbk4II7LNBxvar7kDcZ
         +zlA==
X-Gm-Message-State: APzg51C65OAt2ZNJQF0C3evhx6QNIUwyRoUnKo+it5F1ttwo5TYSTOlZ
        bt+QtCNbwZ/yFfyQtoWflczKrZbQcDhVJhVj7E0=
X-Google-Smtp-Source: ANB0Vdb3Ywcqp/XbfCVwm7IMlDggr/GOO0iSliZn2VhGJrlN325MJsR9c6OGIwGjOHv1kcZIUIpOnU/BxpQXHWxBZ/Q=
X-Received: by 2002:a54:4d9d:: with SMTP id y29-v6mr32868295oix.273.1536180764451;
 Wed, 05 Sep 2018 13:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <1532341959-3478-1-git-send-email-pengbo.mu@nxp.com>
 <1532341959-3478-3-git-send-email-pengbo.mu@nxp.com> <20180724232018.GA16709@rob-hp-laptop>
In-Reply-To: <20180724232018.GA16709@rob-hp-laptop>
From:   Yang Li <pku.leo@gmail.com>
Date:   Wed, 5 Sep 2018 15:52:33 -0500
Message-ID: <CADRPPNQQE1ESJ5WkMxySstxpaQir-w5XOdiwDe3qTTQ_cim5Xw@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] arm64: dts: dwc3: description of incr burst type
To:     Rob Herring <robh@kernel.org>
Cc:     pengbo.mu@nxp.com, Felipe Balbi <balbi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Ran Wang <ran.wang_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 6:23 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Jul 23, 2018 at 06:32:38PM +0800, Pengbo Mu wrote:
> > Add description of 'snps,incr-burst-type-adjustment' to binding
> > so that configuring devicetree.
> >
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > Signed-off-by: Pengbo Mu <pengbo.mu@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/usb/dwc3.txt | 6 ++++++
> >  1 file changed, 6 insertions(+)
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Hi Felipe,

What do you think about this patch?  The patch title prefix should be
updated from "arm64: dts: dwc3" to "dt-bindings: usb: dwc3" though.

Regards,
Leo
