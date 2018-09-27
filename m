Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76727C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A00A21710
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A00A21710
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbeI1Bwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:52:31 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46358 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbeI1Bwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:52:31 -0400
Received: by mail-oi1-f195.google.com with SMTP id k64-v6so3189482oia.13;
        Thu, 27 Sep 2018 12:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tnSYaK0DUOE5vwk8CXbgIKk4JjzqMvOiW++MdLQZSJ0=;
        b=NS4cGzTBsCdIZIfUuy2SbK8dPibTJhuK9BD6bCvY5N8E2yTv87yjkSG/IC5/bB9Tp2
         vrAMCP1b/kdkj4Etmn6ZzlwnctKRpDe02nDecc4MFHTbeb4rZ9zJwz8g0NW3O5oO5xON
         ZM0hL/4I8EVyCOk9Bco8Nq+GhaYyWxh+bH8gIkJRShPIIfGWVu5tKyKHH0IIhP+7NQgV
         mlTKlqGreKCi3lB1Uog5uKQcUBMgoE5dPGHPq3SQ+AHp5s0bYC+KuBZlPHNDShbloWxD
         Vj1RgjCtcOIKKX6w4+CpzLFUtPzoA67A2JCiLi0LBSVE3rTwk1Z7EDhbmOy00GW706UE
         6ioQ==
X-Gm-Message-State: ABuFfoiz2JnlQIanfW+EDAHQ0SiYLdNuA77LUnfCsHN+bCnwL668zN/W
        wZzkq/WHxRf16dG3/0JSmGEQYJaRMxEu
X-Google-Smtp-Source: ACcGV60TmkVwBvyfbPHx9Z793dhCXq0b3Vp8Jkc/cxewLDo4IcxfS1BazWHaS0g8+C4aXg8fqpt/zg==
X-Received: by 2002:aca:dad7:: with SMTP id r206-v6mr4054236oig.271.1538076761491;
        Thu, 27 Sep 2018 12:32:41 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s25-v6sm1130411ote.35.2018.09.27.12.32.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 12:32:40 -0700 (PDT)
Date:   Thu, 27 Sep 2018 14:32:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vabhav Sharma <vabhav.sharma@nxp.com>
Cc:     sudeep.holla@arm.com, oss@buserror.net,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        sboyd@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, gregkh@linuxfoundation.org, arnd@arndb.de,
        kstewart@linuxfoundation.org, yamada.masahiro@socionext.com,
        udit.kumar@nxp.com, linux@armlinux.org.uk,
        Vabhav Sharma <vabhav.sharma@nxp.com>, V.Sethi@nxp.com
Subject: Re: [PATCH v3 1/6] dt-bindings: arm64: add compatible for LX2160A
Message-ID: <20180927193240.GA29253@bogus>
References: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com>
 <1537747741-6245-2-git-send-email-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537747741-6245-2-git-send-email-vabhav.sharma@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2018 05:38:56 +0530, Vabhav Sharma wrote:
> Add compatible for LX2160A SoC,QDS and RDB board
> 
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
