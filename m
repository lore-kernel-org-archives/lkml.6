Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC0BC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B46E20665
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B46E20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeJYX3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:29:00 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46419 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbeJYX3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:29:00 -0400
Received: by mail-ot1-f68.google.com with SMTP id u26so8256148otk.13;
        Thu, 25 Oct 2018 07:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ioOKISUF5Ltb3HIGA8lUFEj/p+nb14Da/Zssjeyg40I=;
        b=QZoR/bZDSEIYsf4PXYc3CQmBz+N9rPrh1m61Mcld7QTEgjC31/xzzqpAE+HypamjNw
         LKGy5mWTK1zwjP7zp1vKBQXkfKi9FTD9T2vIuF5nuTp7Eu5MZibO/oCzxZ+LrOdz6s4R
         VKtHC6Nrq1m34LFNIGSwUBtF9HSBBjVn3vKzAhQeXYN/omVRAdVKP+LgizdLZAYfP8Qv
         +Nc1rf0OK6BKxv11yQ2ZjYwSZ3YLjz9VSKFyT9o5wiN94T8c0BB2iQanCBnwHRvEwfZe
         wG8RX0LCX++f9ErxvLDXmYlJslJWZtWiaOvbsyy3Nf2s3x24gnvOo5wnYUW04wEK5u+9
         tpHg==
X-Gm-Message-State: AGRZ1gJA7/7g+w8GkHf5NBpH0EFATkhTqS1P0pa79VK9JExneLu7/Qb/
        sGTqpShIJxnSBXGTYBNafA==
X-Google-Smtp-Source: AJdET5eU9scyL7hlIlnSdDv0zwJZv/QB7QM524qtW74Lg1xD0bicwJeB/t2bpH167frbV8S0SACU7Q==
X-Received: by 2002:a9d:2da1:: with SMTP id g30mr1566018otb.12.1540479350222;
        Thu, 25 Oct 2018 07:55:50 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v74sm2320334ota.76.2018.10.25.07.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 07:55:49 -0700 (PDT)
Date:   Thu, 25 Oct 2018 09:55:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     AnilKumar Chimata <anilc@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        mark.rutland@arm.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] crypto: qce: ice: Add support for Inline Crypto
 Engine
Message-ID: <20181025145548.GA30244@bogus>
References: <1539789476-6098-1-git-send-email-anilc@codeaurora.org>
 <1539789476-6098-4-git-send-email-anilc@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539789476-6098-4-git-send-email-anilc@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 08:47:56PM +0530, AnilKumar Chimata wrote:
> This patch adds support for Inline Crypto Engine (ICE), which
> is embedded into storage device/controller such as UFS/eMMC.
> ICE is intended for high throughput cryptographic encryption
> or decryption of storage data.
> 
> Signed-off-by: AnilKumar Chimata <anilc@codeaurora.org>
> ---
>  Documentation/crypto/msm/ice.txt |  235 ++++++
>  drivers/crypto/Kconfig           |   10 +
>  drivers/crypto/qce/Makefile      |    1 +
>  drivers/crypto/qce/ice.c         | 1613 ++++++++++++++++++++++++++++++++++++++
>  drivers/crypto/qce/iceregs.h     |  159 ++++
>  include/crypto/ice.h             |   80 ++
>  6 files changed, 2098 insertions(+)
>  create mode 100644 Documentation/crypto/msm/ice.txt
>  create mode 100644 drivers/crypto/qce/ice.c
>  create mode 100644 drivers/crypto/qce/iceregs.h
>  create mode 100644 include/crypto/ice.h
> 
> diff --git a/Documentation/crypto/msm/ice.txt b/Documentation/crypto/msm/ice.txt
> new file mode 100644
> index 0000000..58f7081
> --- /dev/null
> +++ b/Documentation/crypto/msm/ice.txt
> @@ -0,0 +1,235 @@
> +Introduction:
> +=============
> +Storage encryption has been one of the most required feature from security
> +point of view. QTI based storage encryption solution uses general purpose
> +crypto engine. While this kind of solution provide a decent amount of
> +performance, it falls short as storage speed is improving significantly
> +continuously. To overcome performance degradation, newer chips are going to
> +have Inline Crypto Engine (ICE) embedded into storage device. ICE is supposed
> +to meet the line speed of storage devices.

Is ICE part of the storage device or part of the host as the binding 
suggests?

Rob
