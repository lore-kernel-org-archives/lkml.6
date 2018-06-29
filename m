Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747E7C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D02D274A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D02D274A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964916AbeF2I0N (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 04:26:13 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44529 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935189AbeF2I0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 04:26:10 -0400
Received: by mail-lf0-f68.google.com with SMTP id j26-v6so6185223lfb.11;
        Fri, 29 Jun 2018 01:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FX7fVMWAnpPj3TGPwScEFYxjH3Ya8IKDEoW1bxwGeng=;
        b=UqIegox5K/KAbkahz6fJJBVSYWrdHViwSfnj0nUkMr6fQ0X57s3WVV71x/FZdBeJkP
         hwj3Mp891Ym0r3B8JJklzlR4m9SsqjZCnNJsnTPXX4sv2ByNglecXnsX5QYIoIqqlSXB
         ceVBjaA+kQOnZsjsidCLp4Az5buUWUF++Pk7Tn43aXMHPVt4Yt9DpnOrcwBp804djm9M
         u9NsNCH2u7ALzXU+8SqX0NhP5/pfzExp6sojfKGDaKU+l3RJ2oevuIdQEd0RfQCior4t
         VTA1mh6s49ZQiJNgvP/1klyc4iuP/B148dXWdTu1SNoIcuOFyY1OgiyvgFeHdYU+gv3y
         +yag==
X-Gm-Message-State: APt69E0cFZEo+/9bYe9LfS4U6Gl1/MGPJ/s0amrom/kwwNm3dEQilLtF
        QodHq5iFQL0lmG9cgiGtZuY=
X-Google-Smtp-Source: AAOMgpeGr3ESpmQCIrVLWClrWbrZy3YqjaRgwNZ2FJfiXxaTFL8whfN5meK3mK2yhCtoVCMWy926Bg==
X-Received: by 2002:a19:5f11:: with SMTP id t17-v6mr2101684lfb.64.1530260768236;
        Fri, 29 Jun 2018 01:26:08 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id q4-v6sm1464687ljh.36.2018.06.29.01.26.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 01:26:07 -0700 (PDT)
Date:   Fri, 29 Jun 2018 11:26:05 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        mazziesaccount@gmail.com, arnd@arndb.de, dmitry.torokhov@gmail.com,
        sre@kernel.org, chenjh@rock-chips.com, andrew.smirnov@gmail.com,
        linus.walleij@linaro.org, kstewart@linuxfoundation.org,
        heiko@sntech.de, gregkh@linuxfoundation.org
Cc:     sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v8 2/2] mfd: bd71837: Devicetree bindings for ROHM
 BD71837 PMIC
Message-ID: <20180629082605.GF2118@localhost.localdomain>
References: <cover.1530259815.git.matti.vaittinen@fi.rohmeurope.com>
 <a7904544d51270f4d2230ceb1a336b57a06652c1.1530259815.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7904544d51270f4d2230ceb1a336b57a06652c1.1530259815.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 11:23:42AM +0300, Matti Vaittinen wrote:
> Document devicetree bindings for ROHM BD71837 PMIC MFD.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

I kept the Reviewed-by: tag here as there is no changes from patch v6
which was reviewed by Rob - hopefully this was not a violation of any
sort...

Best Regards
    Matti Vaittinen
