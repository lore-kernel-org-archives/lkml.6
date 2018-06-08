Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id l8nUCmEVG1siFQAAmS7hNA
	; Fri, 08 Jun 2018 23:53:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4E384607DC; Fri,  8 Jun 2018 23:53:47 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="T2cFixwb"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 405FE600D0;
	Fri,  8 Jun 2018 23:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 405FE600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753156AbeFHXxn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 19:53:43 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45283 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752885AbeFHXxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 19:53:42 -0400
Received: by mail-pf0-f193.google.com with SMTP id a22-v6so7360041pfo.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 16:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=5WxdiRLRrbE4wlBtuKlqRziUYwznS3Zc8/13UiOmVNU=;
        b=T2cFixwbN7Xb1CPcoCsIT+HvLTkMdGOFJi5nyNT8uK/rF6s4tW1ahDQRltROIWj2hJ
         HKRtcPe5w9ultSPgt1cQPtTfuqkUyE2OMnzsR95H71f2O0eH3taumIqCuLg7gLBiO5cJ
         NnmRQhk67Wy/DIqP55aoK5uAPr+3h7R0Isi6FUeaalSsTa05zS9j8uEIkfAgJuma/vx0
         50YIkMfuNySgUqEp1skncVQF6bRJVTIr3waqNQx13OUTVM+z3s4WLWY2T8BNhxnjQNVR
         AX6Ze3NoJBHA/ThCVpEMMKm1j086oFRRyjqLvqmidsHAsfH5jegGbTK4FLim7FqfBsUS
         /Cxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5WxdiRLRrbE4wlBtuKlqRziUYwznS3Zc8/13UiOmVNU=;
        b=mydvBIlT+04ErK7AxbQYVQsrVbri90IUK2DLYAAX+iTFKOXTuDWvkg44aIuU7ELmKD
         dnkzpjbG7m8CBrRHhMePsmsZCYUYsHs2LeFanyuzVqTBYmPXgEmwCVvjALVYJy7dXcjw
         ssZjLL1RpRwwCzblW1cov4n7wnRiOUgciQigCRsTyJpnWh+20OT3Ywio0ghYHFhGXNCc
         UK69f+Yt8FUiQCS/XUeDTuMv+y84D5AFq4ae9RUg/LHDK9zXBTNZyqOA+ELHtAq+54hz
         KITVNRZ16Hv8kFNe8EQdaXUfaDNzjuAIMP/LdzJyZLVnUQT+NRcFIg1ngIzLQav7GHD4
         K1QQ==
X-Gm-Message-State: APt69E2okRbVgvGbFqkrPN5ipmFJcriVW9H2PwAHM/JeYLJ9DEKY7WBu
        ZDVNaNQCXKjetXcwuV0Dpf6DPw==
X-Google-Smtp-Source: ADUXVKJAbZiSG/Ltwx3TN96WML7JTy+5mxQQb92UVz7uQ/QAuVM/7dCmLXxwW+dN9g1kF4IPli6d8w==
X-Received: by 2002:a65:6252:: with SMTP id q18-v6mr7043000pgv.106.1528502021980;
        Fri, 08 Jun 2018 16:53:41 -0700 (PDT)
Received: from localhost ([98.237.141.101])
        by smtp.googlemail.com with ESMTPSA id a22-v6sm24228061pfi.124.2018.06.08.16.53.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 16:53:41 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM64: dts: meson-gxl-s905x-p212: Add phy-supply for usb0
Organization: BayLibre
References: <1528188743-12798-1-git-send-email-narmstrong@baylibre.com>
        <CAFBinCCF7v40PrtL3HVf9X-fEVx7P2uOVePa5wQ_y6s7uLKmnw@mail.gmail.com>
Date: Fri, 08 Jun 2018 16:53:40 -0700
In-Reply-To: <CAFBinCCF7v40PrtL3HVf9X-fEVx7P2uOVePa5wQ_y6s7uLKmnw@mail.gmail.com>
        (Martin Blumenstingl's message of "Tue, 5 Jun 2018 21:09:09 +0200")
Message-ID: <7hsh5wygvv.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> On Tue, Jun 5, 2018 at 10:52 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
>> Like LibreTech-CC, the USB0 needs the 5V regulator to be enabled to power the
>> devices on the P212 Reference Design based boards.
>>
>> Fixes: b9f07cb4f41f ("ARM64: dts: meson-gxl-s905x-p212: enable the USB controller")
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Applied to v4.18/fixes (will queue for v4.18-rc).

Kevin
