Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F11EC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532BE208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532BE208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbeHQSNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 14:13:34 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39141 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeHQSNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 14:13:34 -0400
Received: by mail-it0-f68.google.com with SMTP id g141-v6so12164138ita.4;
        Fri, 17 Aug 2018 08:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fYfXIirR9HreTVWx6ct7Qjgjyz40aHXcX6ZQIVvUL9Y=;
        b=O8RPsiu3n55sVA47N0FY7iL7Gd6BJXD5VQo0CJzQlE16nhWghd5BH6D8ye4vQ8Bpto
         zTSFqDVaKoz6qxAib/dvftq+NRRRe2yGhAxLy343hAbqcedUDIj9ON7xPGUw7b4T4NEv
         XLo9MeATphzFS5oDi/BAiiwZx+AnQ9TK7L/Tw+/Oh+1TMt7khdXZHt5SqSxoiuPATEqS
         qI3Glqhb8ZMyNAlndA2M+Dxi3ns0tyeLQYOW7o9joK47YxC4hrx19Cu+kQ1zq807bZ0/
         eB9/yLHgjX6Ji/1Qa5/C4MceAG3ECTnb4N+VB5WMOdJ2ALysrhvXAALFF/Y19v7mEe/L
         KNlw==
X-Gm-Message-State: AOUpUlF8+Rd6B07DB6WtLR4iWdm/RIihJ9lTv7z2FnNYrYXWOgXagVyJ
        qwV5S1MFulIMuteXtWWCTw==
X-Google-Smtp-Source: AA+uWPzO7hCze+beZrkr5oJq/sEHild9F3k4eKSNuDZO+/WYxYI2pl0rgveHc6KItyZkMt/npNeBbA==
X-Received: by 2002:a24:24c2:: with SMTP id f185-v6mr4598098ita.18.1534518590010;
        Fri, 17 Aug 2018 08:09:50 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id t12-v6sm904620iop.40.2018.08.17.08.09.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 08:09:49 -0700 (PDT)
Date:   Fri, 17 Aug 2018 09:09:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wendy Liang <wendy.liang@xilinx.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        michal.simek@xilinx.com, robh+dt@kernel.org, mark.rutland@arm.com,
        rajan.vaja@xilinx.com, jollys@xilinx.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wendy Liang <jliang@xilinx.com>
Subject: Re: [PATCH 7/7] Documentation: devicetree: Add Xilinx R5 rproc
 binding
Message-ID: <20180817150948.GA20845@rob-hp-laptop>
References: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
 <1534403190-28523-8-git-send-email-jliang@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534403190-28523-8-git-send-email-jliang@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this email is from Rob's (experimental) review bot. I found a couple
of common problems with your patch. Please see below.

On Thu, 16 Aug 2018 00:06:30 -0700, Wendy Liang wrote:
> Add device tree binding for Xilinx Cortex-r5 remoteproc.
> 
> Signed-off-by: Wendy Liang <jliang@xilinx.com>

The preferred subject prefix is "dt-bindings: <binding dir>: ...".

> ---
>  .../remoteproc/xlnx,zynqmp-r5-remoteproc.txt       | 81 ++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5-remoteproc.txt
> 
