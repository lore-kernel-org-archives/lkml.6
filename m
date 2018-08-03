Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42501C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05952174D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05952174D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbeHCNKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 09:10:21 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33294 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbeHCNKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 09:10:21 -0400
Received: by mail-lj1-f196.google.com with SMTP id s12-v6so4643090ljj.0;
        Fri, 03 Aug 2018 04:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IKcmQ5jhzG5BePvd9htVgvCZQQGR8S/oNlAZby8oEMc=;
        b=ibiaFc7LR4YDniD1btJq7TKXX4vzn5AVBCouQtOyTRf0bpbxEfwrWSXT0NdTodOCVA
         f+TebQ93Eb9WbE/IXGYyWVoXqR+s8H72247POHVNXqfM3KsO5ZhRISj0HeJXOYt0Ob5o
         RO46gpyRX6UoJ0Gz214Aezxb9sql8OSogGM03Zk7e1PL6mh5lDJDbN2OYNWFl+uhjUeU
         nRxJKh7XoSIapfNVB2WAbf2nSIwk+BX8Dlmy08tcynlZA28db3/7dnjJMpRX+EWfXcVb
         djU4Js+UIOQ5M4FLX1VGkdcCRIEcShnqWo/OpL7KUIzmuAZf8OVHZIX8ue2Dub3V6Iv6
         KABg==
X-Gm-Message-State: AOUpUlHqzQ8dV+NxaQCNzmVL+ODZv464dqApueFEE9Jk0FI2h1H52JTr
        d0dIGTidY+h+Nk+2uhq5dYk=
X-Google-Smtp-Source: AAOMgpc0h7EH4WyapbMnUANwwhh2qTkWkqtBHBryF3HgIO2k0ah1sW/2oWYbszou2Xq3rlejDsBa9w==
X-Received: by 2002:a2e:9c4d:: with SMTP id t13-v6mr4965022ljj.153.1533294868475;
        Fri, 03 Aug 2018 04:14:28 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id d24-v6sm682849lfl.53.2018.08.03.04.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 04:14:27 -0700 (PDT)
Date:   Fri, 3 Aug 2018 14:14:25 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        eballetbo@gmail.com, linus.walleij@linaro.org,
        mazziesaccount@gmail.com, dmitry.torokhov@gmail.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, broonie@kernel.org,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v12 2/2] mfd: bd71837: Devicetree bindings for ROHM
 BD71837 PMIC
Message-ID: <20180803111425.GD20907@localhost.localdomain>
References: <cover.1533292711.git.matti.vaittinen@fi.rohmeurope.com>
 <d053f54e5ce726ffaa95fbd9c20962a49dd1ee07.1533292711.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d053f54e5ce726ffaa95fbd9c20962a49dd1ee07.1533292711.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 02:09:12PM +0300, Matti Vaittinen wrote:
> Document devicetree bindings for ROHM BD71837 PMIC MFD.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---

I kept the Reviewed-by and Acked-by as this patch is unchanged once
again... Sorry for the spam.
