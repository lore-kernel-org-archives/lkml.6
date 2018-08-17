Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F71C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA3D21890
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA3D21890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbeHQSNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 14:13:46 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:43820 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbeHQSNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 14:13:45 -0400
Received: by mail-io0-f195.google.com with SMTP id y10-v6so7151561ioa.10;
        Fri, 17 Aug 2018 08:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RH+BQZ5gK07r6/PpWsftWdrAQzJtG2KtWru8AxE1oQE=;
        b=s+D3q0MOW1nQ+v6REz/VTQWcGSvyfOCyRYp5PtLmJYz0IQjQabKpmESySVk2S2fj7g
         wFJhDupO0PM5UeXp7U6AUnT+MSGkNrPtouC2et6IWkBSEatqawrWqxCZaImnNV3K5Ang
         uDlltr6zsym3ZGF62fj5X3gxM44NT7tCJoJFwCJCMEBPoEXlu/emLyHJZRi+1igykb/k
         JgRWve3s9vaVrG9nnGD/rWlUEIqokzAn9EUz+vfzj8hAksxXUF6sxTWZKWLLUXpe07hA
         2PEgSb/SrOBPS6WRqkUnLmJY7ugPmduuVXaMPL+MI22WG6S5QMHxJBZQ+3BenhNlQqhs
         n6Ig==
X-Gm-Message-State: AOUpUlEXsdOV1cAk5urvKtRjFZq5isWbiOIsNe3bdQ3pjcmwqCxPXObJ
        Ihw+uyE2UB4uQsD8IhbQzw==
X-Google-Smtp-Source: ANB0VdbQtGjJxNEwajqsIY6atrdT3TAko3HN2tNSUGBIdAxwadHWkm70POS+egSyifQZkbhaqDPlBg==
X-Received: by 2002:a5e:860e:: with SMTP id z14-v6mr4749009ioj.67.1534518601336;
        Fri, 17 Aug 2018 08:10:01 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id a22-v6sm944920ioc.63.2018.08.17.08.10.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 08:10:00 -0700 (PDT)
Date:   Fri, 17 Aug 2018 09:10:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roy Im <roy.im.opensource@diasemi.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Support Opensource <support.opensource@diasemi.com>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/3] Documentation: devicetree: input: new binding for
  da7280
Message-ID: <20180817151000.GF20845@rob-hp-laptop>
References: <cover.1534468025.git.Roy.Im@diasemi.com>
 <6fe6130443ab72ef8fa0e95da6a2e0d63c2ec1d7.1534468025.git.Roy.Im@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fe6130443ab72ef8fa0e95da6a2e0d63c2ec1d7.1534468025.git.Roy.Im@diasemi.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this email is from Rob's (experimental) review bot. I found a couple
of common problems with your patch. Please see below.

On Fri, 17 Aug 2018 10:07:04 +0900, Roy Im wrote:
> 
> from: Roy Im <roy.im.opensource@diasemi.com>
> 
> Add device tree binding information for DA7280 haptic driver.
> Example bindings for DA7280 are added.
> 
> Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>
> 

The preferred subject prefix is "dt-bindings: <binding dir>: ...".

> ---
> v2: No changes
> 
> 
>  .../devicetree/bindings/input/dlg,da7280.txt       |   91 ++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/dlg,da7280.txt
> 
