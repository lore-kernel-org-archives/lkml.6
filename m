Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA20ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71AA21476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71AA21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbeJSEhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:37:32 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46061 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbeJSEhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:37:32 -0400
Received: by mail-oi1-f196.google.com with SMTP id e17-v6so25113847oig.12;
        Thu, 18 Oct 2018 13:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9XW+olapYazC9h5C1BTMdI9nUHC/xXTBATbLtcvbC3o=;
        b=M0s/HU+I6/2ZPO5A8BCL0kq1ITLpNiSAcPURwIku+6/P2XZy0gbM8NOa4UdGSi4hxp
         MZsRXxLbvjHrgtzSgKRSDsfQdMn/s0ie/3tlIfX7ALffeseyzPO8W1FXCANRYInjX20a
         zHJr7Yybf2rXZJyH6PzjiALsORVBMBVZ2TizxJ7CI0cK183BtSIlUFRAd1480Q68o3yT
         vWWK7Oaj78xdcm1GE5b48uOveTQQOc3OlIY3UnOq/YDKxzkqKdGU/4xdFjt3i/9nZnNH
         4RyDid/uldp8KnuXGy7R8ZeB7O3VoNhdNQbqTKjAq4P9e8FchlicYIm0unHXMeIAvw+u
         FN/Q==
X-Gm-Message-State: ABuFfojgAGl6DDDjZj1z50HFsqWIZZI91lQ/Woid1CrKhL0+R34I0WsV
        mJLiuR/Qijd8ToyobvigQQ==
X-Google-Smtp-Source: ACcGV62xgltAriyMjU7Zaa4U2niYPkIny8pHm61xwILF1wQD4Rjn3sH2x1pEzHMUsbuMtNioLZmgCQ==
X-Received: by 2002:aca:a6c3:: with SMTP id t64-v6mr13561396oij.31.1539894888445;
        Thu, 18 Oct 2018 13:34:48 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i15sm6541012otj.53.2018.10.18.13.34.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 13:34:47 -0700 (PDT)
Date:   Thu, 18 Oct 2018 15:34:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Richard Leitner <richard.leitner@skidata.com>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH v2 1/8] dt-bindings: input: touchscreen: sx8654: add
 reset-gpio property
Message-ID: <20181018203446.GA20451@bogus>
References: <20181017125116.20077-1-richard.leitner@skidata.com>
 <20181017125116.20077-2-richard.leitner@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017125116.20077-2-richard.leitner@skidata.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018 14:51:09 +0200, Richard Leitner wrote:
> Document the reset-gpio property for the sx8654 touchscreen controller
> driver.
> 
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/sx8654.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
