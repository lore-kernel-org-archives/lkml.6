Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E85C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5EA22170A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5EA22170A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389732AbeHGVCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:02:53 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:46519 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732760AbeHGVCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:02:53 -0400
Received: by mail-io0-f193.google.com with SMTP id i18-v6so14840629ioj.13;
        Tue, 07 Aug 2018 11:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xGXocIj6SJLtAvqEUGfk5C+tPt0jU6xzWWou+HpBmes=;
        b=egPj/LiJ/6Z6Ty0UtM8etYsvicTPTtFUQNWFiX//Z4fhMlBfzLsvrpkcnXO3YYTDOV
         NP1SG5HQoZ6m/VG4UzcRW9xSKZvH6Z02wIU+c50W77+VVAAuQkTHEXJj92NasQGWs7yT
         3blfmNfVQ52VKDOgC4y9kqr+dVy9TBCgq6lMM8JAGkumJz7QaCqsk39YYJ0NJ91SJeq8
         xzpeiYT1PiNO5uavr9M9XxdzB+QkfD1PSO1oDgMM/fDonPY7a/tWiLkE2hEBamL2+rKQ
         +sw4qvV1Ts2jXntEX8woCxkQwzL3pXuIB2wMYbhkluhTjKqwFREWkOEGA3hrxa3dAgaa
         d6XQ==
X-Gm-Message-State: AOUpUlElaMHKRNRdVbOfUaXYF3lN8iVhsRTOVjhTu85riSNAgZR2Aswt
        YHfSIMBcdny81ZIwS6rRlg==
X-Google-Smtp-Source: AA+uWPwmxSpKtTssszNE4kcMQen5Kg93oJv7/xL3ELFtX2v2ShYEpnzzHuGOXVwE9NON/fc1+e5EAg==
X-Received: by 2002:a6b:bd06:: with SMTP id n6-v6mr6038926iof.86.1533667631419;
        Tue, 07 Aug 2018 11:47:11 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id 137-v6sm1254599itl.39.2018.08.07.11.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 11:47:10 -0700 (PDT)
Date:   Tue, 7 Aug 2018 12:47:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br, sravanhome@gmail.com
Subject: Re: [PATCH 0/9] Add Reset Controller support for Actions Semi Owl
 SoCs
Message-ID: <20180807184710.GA26423@rob-hp-laptop>
References: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
 <c3ae668a-6bcc-a0eb-1e00-14ef9d607316@suse.de>
 <20180730151131.GA28633@mani>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180730151131.GA28633@mani>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 08:41:31PM +0530, Manivannan Sadhasivam wrote:
> Hi Andreas,
> 
> On Mon, Jul 30, 2018 at 12:26:07PM +0200, Andreas Färber wrote:
> > Hi Mani,
> > 
> > Am 27.07.2018 um 20:45 schrieb Manivannan Sadhasivam:
> > > This patchset adds Reset Controller (RMU) support for Actions Semi
> > > Owl SoCs, S900 and S700. For the Owl SoCs, RMU has been integrated into
> > > the clock subsystem in hardware. Hence, in software we integrate RMU
> > > support into common clock driver inorder to maintain compatibility.
> > 
> > Can this not be placed into drivers/reset/ by using mfd-simple with a
> > sub-node in DT?

That is exactly what I tell folks not to do. Design the DT based on h/w 
blocks, not current desired driver split for some OS.

> Actually I was not sure where to place this reset controller driver. When I
> looked into other similar ones such as sunxi, they just integrated into the
> clk subsystem. So I just chose that path. But yeah, this is hacky!
> 
> But this RMU is not MFD by any means. Since the CMU (Clock) and RMU (Reset)
> are two separate IPs inside SoC, we shouldn't describe it as a MFD driver. Since
> RMU has only 2 registers, the HW designers decided to use up the CMU memory
> map. So, maybe syscon would be best option I think. What is your opinion?

If there's nothing shared then it is not a syscon. If you can create 
separate address ranges, then 2 nodes is probably okay. If the registers 
are all mixed up, then 1 node.

Rob
