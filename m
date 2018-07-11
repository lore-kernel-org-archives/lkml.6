Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C94DC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3EE2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3EE2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388188AbeGKThz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:37:55 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43807 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733104AbeGKThz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:37:55 -0400
Received: by mail-oi0-f68.google.com with SMTP id b15-v6so51334455oib.10;
        Wed, 11 Jul 2018 12:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zSmpsd9nRID/A5Z7fJawTwfPQ/nOudxteXpMaw9mj08=;
        b=bfLgKQIKTErai6uFrUKOBBsPm8q2PL2htpVBwd6crSF0BKnqYJjgOAcRJyalLrPMly
         Tb5i2ev1e8fMF5PZNDZrPV3Qmo408uW55xrHQZRrzUF+89ZDZxeE2OyVS+kPba35gQEQ
         0PbuSixwTTdRrUsPThJ60RwlpYyN+I+t77PSBCa3+lxkGdPTC6e+HoMBvazssFUtltaB
         qGrCf2xJ2zznQRDIwRcKPiMEWo1lUKruSjzETELMo4V/EsdEdtclduvN3/wTYRm0CgBR
         XxoW8A+tIfc+NXQI3XB/i3g89EFx5CWIf33WTjPUxlynpYLZstVzwaEJP2sNv/Q+Txr+
         061g==
X-Gm-Message-State: AOUpUlEGAVTbRd2eIU5CBapJ/ANdY8ViOyyL1KaS85HkmRdUTPej2N00
        EKOs0edDLxeu4ikpSBmLCw==
X-Google-Smtp-Source: AAOMgpf7Qe7JrgPaB9Jg+veaiQwHkWkmpMWrbjCNfuhXbA1YR3zYZj9jp5MXjtikXgOV3QB3f7ZI3A==
X-Received: by 2002:aca:e30b:: with SMTP id a11-v6mr622966oih.303.1531337527465;
        Wed, 11 Jul 2018 12:32:07 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id w8-v6sm8668773oiw.10.2018.07.11.12.32.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 12:32:06 -0700 (PDT)
Date:   Wed, 11 Jul 2018 13:32:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sujeev Dias <sdias@codeaurora.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Tony Truong <truong@codeaurora.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Subject: Re: [PATCH v2 5/7] mhi_bus: core: add support to get external modem
 time
Message-ID: <20180711193206.GB8659@rob-hp-laptop>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
 <1531166894-30984-1-git-send-email-sdias@codeaurora.org>
 <1531166894-30984-6-git-send-email-sdias@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531166894-30984-6-git-send-email-sdias@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 01:08:12PM -0700, Sujeev Dias wrote:
> For accurate synchronizations between external modem and
> host processor, mhi host will capture modem time relative
> to host time. Client may use time measurements for adjusting
> any drift between host and modem.
> 
> Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
> Reviewed-by: Tony Truong <truong@codeaurora.org>
> Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/bus/mhi.txt |   7 +

Put all the binding in one patch.
 
>  Documentation/mhi.txt                         |  41 ++++
>  drivers/bus/mhi/core/mhi_init.c               | 111 +++++++++++
>  drivers/bus/mhi/core/mhi_internal.h           |  57 +++++-
>  drivers/bus/mhi/core/mhi_main.c               | 263 +++++++++++++++++++++++++-
>  drivers/bus/mhi/core/mhi_pm.c                 |   7 +
>  include/linux/mhi.h                           |   7 +
>  7 files changed, 486 insertions(+), 7 deletions(-)
