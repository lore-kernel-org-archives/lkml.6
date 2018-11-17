Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA78BC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6840520815
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6840520815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbeKRCeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 21:34:23 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46515 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeKRCeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 21:34:23 -0500
Received: by mail-ot1-f67.google.com with SMTP id w25so23363536otm.13;
        Sat, 17 Nov 2018 08:17:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Shxn5eM7ukNzLkrHjObBCBxsJzyLWF36lCe70+qx3+0=;
        b=Bd5yQ8i+MU298SlCp++TKpHQ6EqxGqEQ8n76Jjn1+VoFnUyhDtSitHnh965vVp8Jk4
         4LdV384cemjDzJIUGFqbm76PmKcjQaRJGR89h0eZovc5LIJp2PnUFoZ+08bgg1iv90VK
         nU7mgvZkYfC5N4g4V4C2yzMEpkpSaDYGk9mVp7CeFSaDBopDcaSM1P8RZYM9eZ+ajukr
         s17oPeStfXr/ZMFU6v4hehCrBc1H1kqbxRLFqJ8IsI+e3jJfc7WajObYgNlVlBQDGu6/
         k2mq5Fe5g85uLaY9B5YTFBi42Cj/kx/4tx0kFBvInhttZmpAhgxDz0tiXGx6OLDFuALp
         7uEA==
X-Gm-Message-State: AGRZ1gJBEWVQRzsCLtm1a7kfOIXmkVAWLWzkqcIpjdcwtAQYFkI1Bsh4
        qTCe2/45gWs6AFnGx8+Zkw==
X-Google-Smtp-Source: AJdET5c6fINdGa7lrPYIV8qchLnKvOneqAs51hEuUsO/0IlwIbI1eiOuXDPj8SWt3ZddhvLaPzK28Q==
X-Received: by 2002:a9d:2062:: with SMTP id n89mr8646810ota.244.1542471434002;
        Sat, 17 Nov 2018 08:17:14 -0800 (PST)
Received: from localhost ([166.137.105.180])
        by smtp.gmail.com with ESMTPSA id j33sm18884386ota.32.2018.11.17.08.17.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 08:17:13 -0800 (PST)
Date:   Sat, 17 Nov 2018 10:17:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Yasunari.Takiguchi@sony.com, devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] media: sony-cxd2880: add optional vcc regulator to
 bindings
Message-ID: <20181117161711.GA19169@bogus>
References: <1541681410-8187-1-git-send-email-narmstrong@baylibre.com>
 <1541681410-8187-3-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541681410-8187-3-git-send-email-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Nov 2018 13:50:10 +0100, Neil Armstrong wrote:
> This patchset adds an optional VCC regulator to the bindings of the Sony
> CXD2880 DVB-T2/T tuner + demodulator adapter.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/media/spi/sony-cxd2880.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
