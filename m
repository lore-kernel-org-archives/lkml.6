Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3817CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0232A20873
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0232A20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbeK0Iww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:52:52 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38771 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeK0Iww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:52:52 -0500
Received: by mail-ot1-f68.google.com with SMTP id e12so13877965otl.5;
        Mon, 26 Nov 2018 13:57:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iNvKkWRo8vR0/t/MX2sKUuIQd19EpHzWuWMgR7/DWwU=;
        b=D8kAE/6GmaTbm9syc8rh9eR0KyQjZmqHNJNiZepfIAFqd0exA2HSgQvkTNudBQ+K3g
         7VTelHLffPRmbdyR+UlKi2lwuenQbpzNyDOKzGr9QLBlwNvNClGCKXjWJhB/iy2rzYEm
         HchChLSOpxr+L6TnL7XbW6cVXu1HmsCtbXBkaIvXBe1RO/AwMV0L1EjbDtBGFJYHA+iX
         Hn5UOwKH1qwrL3xL1XIkbqIavAFgC0B4Wamt/sEoxD3Co4rAskD0aGKYbPNrM4X5R7ak
         PcOODZSS62G9uqSt3T+OS1T0Xvl2VKnU9UmsLvwLPDELQ2USWjsmBdrB2DqDOyhKIP0j
         FQrQ==
X-Gm-Message-State: AA+aEWY4X/aL0lLL74S3iF4M7OX0Ug8o1/VccgN14gzoIAWeL1Vn9Qvo
        5wXfpN053aeaqLalxRNwAQ==
X-Google-Smtp-Source: AFSGD/X5zLXdvJMvsB+SSCQiYx56pZajDZ+q4X2jztu/8bf2e5YfyuZ+8pwdusSbwobw3mxZZInmfw==
X-Received: by 2002:a9d:58c:: with SMTP id 12mr17024540otd.33.1543269439338;
        Mon, 26 Nov 2018 13:57:19 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 35sm490687ott.13.2018.11.26.13.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 13:57:18 -0800 (PST)
Date:   Mon, 26 Nov 2018 15:57:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alban Bedel <albeu@free.fr>, Alex Elder <elder@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-usb@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH V4 1/5] dt-bindings: Add Broadcom STB USB support
Message-ID: <20181126215718.GA22870@bogus>
References: <1541772120-40394-1-git-send-email-alcooperx@gmail.com>
 <1541772120-40394-2-git-send-email-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541772120-40394-2-git-send-email-alcooperx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Nov 2018 09:01:56 -0500, Al Cooper wrote:
> Add DT bindings for Broadcom STB USB EHCI and XHCI drivers.
> Add "phy-supplies-usb-clock" property description to usb-hcd.txt
> 
> NOTE: The OHCI driver is not included because it uses the generic
>       platform driver.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  .../devicetree/bindings/usb/brcm,bcm7445-ehci.txt  | 24 ++++++++++++++++++++++
>  Documentation/devicetree/bindings/usb/usb-hcd.txt  |  3 +++
>  Documentation/devicetree/bindings/usb/usb-xhci.txt |  1 +
>  3 files changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
