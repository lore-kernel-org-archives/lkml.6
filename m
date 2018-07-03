Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F358C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB1F24625
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB1F24625
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753656AbeGCTbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:31:51 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:37201 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752112AbeGCTbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:31:49 -0400
Received: by mail-yb0-f195.google.com with SMTP id r3-v6so1179464ybo.4;
        Tue, 03 Jul 2018 12:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q4vXOXJUw1wTY2t37/LrC6PAqcdPogqG4ZVia0dvwFc=;
        b=ELvPlIqbbgfhVG9PDoAHVx2gtICd5l7UQV4Ic3yfqJBYOGa3ChJDBFnS7o7aPiIRTh
         2EvTgBJ/a4N/czdie+MMpErfY6vbvq8ILkRlnyfHjtvSkTksstlwSKNvCuSIBCtUlaUg
         AZp4+BlXAIRLbv6YmYNrNfZAZGeKXOv4ptdnM7drZ8zg7svjX84YX3LlD4A3Qj5kCwES
         nFXlqRakBZronXxOBNvyXN0LCwywveGT4kBf00tDD0uxfjSuYARqJ1Ls0wYEJ39ZzFzD
         7vOvPqtdjSt1ijOiXHTdVMI+Ur6rNBAJjgx39UsSIG/QjNcPy8WQCDgjj2lVshhJLUlB
         GB9g==
X-Gm-Message-State: APt69E2JqQO9Z08iWnfDUgmzBncbEep3ovUSOVEfYK2EAbSBa/dfThbw
        Q01qQHWbBSpN4m+V2Jrenw==
X-Google-Smtp-Source: ADUXVKIHiqrhOzVE+EAlLjj/j7rkF8UM9ABNP9OkF+bThiC64CbTcxjyD6e+6NpMc2vL6akpxDF0Qw==
X-Received: by 2002:a25:ac8c:: with SMTP id x12-v6mr16775420ybi.43.1530646308725;
        Tue, 03 Jul 2018 12:31:48 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id u11-v6sm649547ywc.77.2018.07.03.12.31.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 12:31:47 -0700 (PDT)
Date:   Tue, 3 Jul 2018 13:31:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@kernel.org, aisheng.dong@nxp.com,
        ping.bai@nxp.com, Linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: imx6sll: add GPIO LPCGs
Message-ID: <20180703193146.GA29496@rob-hp-laptop>
References: <1529649154-5724-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529649154-5724-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 02:32:33PM +0800, Anson Huang wrote:
> According to Reference Manual Rev.0, 06/2017,
> there are GPIO LPCGs defined in CCM CCGRs,
> add them into clock tree.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/clk/imx/clk-imx6sll.c             | 6 ++++++

>  include/dt-bindings/clock/imx6sll-clock.h | 9 ++++++++-

Acked-by: Rob Herring <robh@kernel.org>

>  2 files changed, 14 insertions(+), 1 deletion(-)
