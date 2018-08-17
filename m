Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EFEC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF29B208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF29B208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbeHQSNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 14:13:42 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:46424 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbeHQSNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 14:13:42 -0400
Received: by mail-io0-f196.google.com with SMTP id x5-v6so7137684iop.13;
        Fri, 17 Aug 2018 08:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yEpLJDD5syjOMwrxeQVxWCp34IJmIhdWpCefkvoO9PE=;
        b=qerQRl4pYGYMw8ZhJLVYO0u2aKQMMVfzw48ajKSOPPTwtByaGfMo1YIKiHZzuZip1a
         4Xra+wgwo5YzhvP1HWs/4zbfWop/KZ33QbK8CITjgYD/ZpHLn4eKjfH+tqfkPCVzEGCS
         /NlM33JgQLkNb7GvdYZYlMshMuC9MyMPfjy7gcT92ym8aPu99sR6oM8CiI1BxkuQiH3p
         OXGHIBygEMpwOmBySMlRvIZhQACQEjz1+erAn8KFFKE+arG25zOZp/HAo/yzK87vKKce
         rnqkfegwa+vo01iczlXkDq2NbAPxfNqqxTEEbddRjfjhg+zc/swfAMY0S/uPGjOvx+f+
         AvKA==
X-Gm-Message-State: APzg51DTVfLpN8+Rvihj7n4DJ7ispcIGJXsYRNjv5D63IbsgcplW8iEg
        3YO1sMGyvQL3GOeTfGJt2R53r90=
X-Google-Smtp-Source: ANB0VdbmBG4UC4slo91AuNG32G+9JEI2cEGO5ku4//N0CChSnUOJDOmKyWGBEFjaCEewOTQAXXWVng==
X-Received: by 2002:a6b:6c12:: with SMTP id a18-v6mr9245927ioh.72.1534518597823;
        Fri, 17 Aug 2018 08:09:57 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id v13-v6sm1954717ita.38.2018.08.17.08.09.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 08:09:57 -0700 (PDT)
Date:   Fri, 17 Aug 2018 09:09:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 5/7] pinctrl: ingenic: Add support for the JZ4725B
Message-ID: <20180817150956.GD20845@rob-hp-laptop>
References: <20180816163544.9072-1-paul@crapouillou.net>
 <20180816163544.9072-5-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816163544.9072-5-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this email is from Rob's (experimental) review bot. I found a couple
of common problems with your patch. Please see below.

On Thu, 16 Aug 2018 18:35:42 +0200, Paul Cercueil wrote:
> Add support for the JZ4725B and compatible SoCs from Ingenic.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

The preferred subject prefix is "dt-bindings: <binding dir>: ...".

> ---
>  .../bindings/pinctrl/ingenic,pinctrl.txt           |  2 +
>  drivers/pinctrl/pinctrl-ingenic.c                  | 99 ++++++++++++++++++++++
>  2 files changed, 101 insertions(+)
> 

DT bindings (including binding headers) should be a separate patch. See
Documentation/devicetree/bindings/submitting-patches.txt.
