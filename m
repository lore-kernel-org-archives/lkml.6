Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCF6C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A82D20658
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A82D20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbeJSEkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:40:55 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44109 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeJSEky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:40:54 -0400
Received: by mail-ot1-f68.google.com with SMTP id p23so31098642otf.11;
        Thu, 18 Oct 2018 13:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mCogzujPw/hhZbA96628/M8fvrcCaSzhuryL7oNfZqQ=;
        b=YM79A82swqOVdXDQT34P4dCbDXw9TK4bscy2vLPqkfx9dF7eoxpM9uki7PcMzW91R7
         sQboVe+Sl+wEL1Nw12vpNjYsUSRSkdcv/MhG5KAVIobNgoJZ04wtHlg5FldREDZhL8jh
         0aqkhCV0fSn5TuUh2LRmY0WJdCW9kLKgeByiL9ySX7rDm8a2Xj6Qur9h76jWDC+gM98e
         sZJgDiXD5o4IlvAVftBWZqx9jEHZ5QIu/8mHjVgwGO1yzbf5z+pBbQxdnIYtUF0R/rAs
         rzGDyReLRT0uL8aPTU3XomnANb+Xdoqz6OuS79Afzkrt/IUK99x+fWxpg7/VAm1dMUlm
         WAdA==
X-Gm-Message-State: ABuFfohLhMl8pcBKMXUTQ8cbe2Cjok7FQIzuAgeb3962CerIzEWteMLY
        7fihgTNKOdkKTZ1ALRt78Q==
X-Google-Smtp-Source: ACcGV63DewAZM7F5DDtZ/5d3QEcQ8VceQO2+Rq5+0xOFrnHSRWsYJl2MvnW3hFTDdxItC0M86RaliA==
X-Received: by 2002:a9d:1ea5:: with SMTP id n34mr19779096otn.160.1539895089659;
        Thu, 18 Oct 2018 13:38:09 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h29sm3077012otg.34.2018.10.18.13.38.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 13:38:09 -0700 (PDT)
Date:   Thu, 18 Oct 2018 15:38:08 -0500
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
        Jianguo Sun <sunjianguo1@huawei.com>,
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
Subject: Re: [PATCH V2 1/6] dt-bindings: Add Broadcom STB OHCI, EHCI and XHCI
 binding document
Message-ID: <20181018203808.GA25281@bogus>
References: <1539815349-24126-1-git-send-email-alcooperx@gmail.com>
 <1539815349-24126-2-git-send-email-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539815349-24126-2-git-send-email-alcooperx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018 18:29:04 -0400, Al Cooper wrote:
> Add DT bindings document for Broadcom STB USB OHCI, EHCI and
> XHCI drivers.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  .../devicetree/bindings/usb/brcm,bcm7445-ehci.txt  | 22 +++++++++++++++++++++
>  .../devicetree/bindings/usb/brcm,bcm7445-ohci.txt  | 22 +++++++++++++++++++++
>  .../devicetree/bindings/usb/brcm,bcm7445-xhci.txt  | 23 ++++++++++++++++++++++
>  3 files changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ohci.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-xhci.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
