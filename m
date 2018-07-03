Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB622C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F64D21925
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ISqwK3c1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F64D21925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754621AbeGCHef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:34:35 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44605 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753834AbeGCHec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:34:32 -0400
Received: by mail-wr0-f195.google.com with SMTP id p12-v6so826214wrn.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 00:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=N+YihGc9r0k8UxuN8XhBJEKLRRhDTDTb/AwWVtdk7Bg=;
        b=ISqwK3c14LoA7qpBQFRDFzxE/4e7DgJotJXwzX2faWeapR7BX0tk8Q5f0FUtDIUpAw
         4EDe8eiE6P9+jujxB1GkfEYeLsBwx9u9tGE6VFwE1GCAeqRYTTuDIpg1udTBZCNHo2ZS
         EiKxfzJByQZO4zPMNSihENGN0aMhi3QwwLTQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=N+YihGc9r0k8UxuN8XhBJEKLRRhDTDTb/AwWVtdk7Bg=;
        b=G80iRgCNHX7CN5Hcf1If7bLvq4Jo0nf7JJwgd/EknNrwP4NCQcTFQXj/nrytJSprOq
         ZPI7VHRlLcIgO3G8nLIoVhWlHoBvYCRn/M6NJDNLYkdppaTOc8wvvsZdezjV+eELQjRu
         UDEoyjScMEy3o7OfSlD7Tp7p2Y0Ba2qwkQKIOlT0trxM/jgWPrjVhrTWtCFKkB54GIke
         wyMb4J3KxDCizXHcUc4oemtF+Qt2ohFbgACc1huAV/meo7Q4iyru3hblBnUyzjYFD55J
         za3mj3irfTF8TqJpcEYyYsy+QXD3kEJSeJ2TOXp89vhCVyd3+yIgyvk7BYiogMiejvSN
         yopw==
X-Gm-Message-State: APt69E1elWSDMYCYeY5MZs/y7zNU4DWPGmob29WKYW2mhaHocWxNZ5TM
        flpEz9zGDKuJ54yrOl+kpbx/yZtwvQs=
X-Google-Smtp-Source: AAOMgpe8+4NbHjuufNFaZKBIALJzo2lWjCgQweARbg4Pegeo0IJgXIxIk/AP2E0bvFuC3KsYAsFYyw==
X-Received: by 2002:adf:c5d2:: with SMTP id v18-v6mr2381544wrg.151.1530603271185;
        Tue, 03 Jul 2018 00:34:31 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id x11-v6sm692830wrm.78.2018.07.03.00.34.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 00:34:30 -0700 (PDT)
Date:   Tue, 3 Jul 2018 08:34:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 24/27] devicetree: fix a series of wrong file
 references
Message-ID: <20180703073428.GH20176@dell>
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
 <bce1b59268ac2d659fd7cb37f89285ef2acc8316.1528990947.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bce1b59268ac2d659fd7cb37f89285ef2acc8316.1528990947.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2018, Mauro Carvalho Chehab wrote:

> As files got renamed, their references broke.
> 
> Manually fix a series of broken refs at the DT bindings.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  .../devicetree/bindings/input/rmi4/rmi_2d_sensor.txt |  2 +-
>  Documentation/devicetree/bindings/mfd/sun6i-prcm.txt |  2 +-

Acked-by: Lee Jones <lee.jones@linaro.org>

>  .../devicetree/bindings/pci/hisilicon-pcie.txt       |  2 +-
>  Documentation/devicetree/bindings/pci/kirin-pcie.txt |  2 +-
>  .../devicetree/bindings/pci/pci-keystone.txt         |  4 ++--
>  .../devicetree/bindings/sound/st,stm32-i2s.txt       |  2 +-
>  .../devicetree/bindings/sound/st,stm32-sai.txt       |  2 +-
>  MAINTAINERS                                          | 12 ++++++------
>  8 files changed, 14 insertions(+), 14 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
