Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD58C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC6C218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LrYocsTZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfAZPRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 10:17:43 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39976 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfAZPRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 10:17:42 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so5370409pgp.7
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 07:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ypfIi/wIKiarDm/2lLzjDiZupuVd99j6X/K6v4/0Olo=;
        b=LrYocsTZuJGY9M6oK1fyOYsCLzDf/+LLPs7xG62HOCk0s68dhWfGqM80Y4B559dtGc
         RfyBXVCaLimKhvAkdDfaVkV6dApGlbJSu6cz7hDX7xXypK1k3HQik87mLucag1ecZ1ml
         wLrmU22JAqFScoWc8Va4eawTgU2SGhWVhvYF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ypfIi/wIKiarDm/2lLzjDiZupuVd99j6X/K6v4/0Olo=;
        b=tzXjjM4HeWXkRB6DVfW4mtOuo/V/oBI6VOtJdCwfAQsOMmKALhiHiONWn6d2V/vKgL
         mWsCK54Iykf+RueHScYCsy0Y7PejS713QrcW0JBUgFnYjEApJFPkSkWo/ZnTyMPjONum
         vyDJRHWRP0lCLfRLnJzSH4Te/SLOlbPzdXMXrkbFqBYseLVomuXeC6mnx8XaTazcw40q
         cKP6/NO9RWhMTmzT5gCCteeOSzoza23V7R+Y7RKkY8T7eY2IXVjEGPNeOgtn0qZsq12z
         +YEI+WJsEoNb9mE+UcErNgxhhu7MtY6kUI8+NslmvKoK9ETyBjJRdTsyNcjQCif0Ddeu
         /6hg==
X-Gm-Message-State: AJcUukesog7PfNY2qfawa6W3STeCE86p9hrev+PMPnMFJmZvFcvjyMoo
        Ac6Weyw3AXgCVRw566XO5sxkF7pIog==
X-Google-Smtp-Source: ALg8bN4AKESaI7wrfY+fYwZJElTafnGMvakFKL+8wR4c+GA+0cN+GgMq65ADucZ6vs9nbfhdYV9enA==
X-Received: by 2002:a62:6143:: with SMTP id v64mr15241945pfb.142.1548515860766;
        Sat, 26 Jan 2019 07:17:40 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:807:9f85:b1bd:9891:c622:302d])
        by smtp.gmail.com with ESMTPSA id g28sm46010366pfd.100.2019.01.26.07.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Jan 2019 07:17:40 -0800 (PST)
Date:   Sat, 26 Jan 2019 20:47:33 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     robh+dt@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
        darren.tsao@bitmain.com, haitao.suo@bitmain.com
Subject: Re: [PATCH 0/5] Add initial Bitmain BM1880 SoC/Board support
Message-ID: <20190126151733.GA15434@Mani-XPS-13-9360>
References: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
 <20190126150320.GB20679@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190126150320.GB20679@lunn.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Sat, Jan 26, 2019 at 04:03:20PM +0100, Andrew Lunn wrote:
> On Sat, Jan 26, 2019 at 09:40:36AM +0530, Manivannan Sadhasivam wrote:
> > Hello,
> > 
> > This patchset adds initial support for Bitmain BM1880 SoC and Sophon
> > Edge board. BM1880 SoC consists of a Dual Core ARM Cortex A53 Application
> > processor subsystem, a single core RISC-V subsystem and a Tensor
> > Processor subsystem.
> 
> Hi Manivannan
> 
> Interesting combination of CPUs. 
> 
> > This patchset adds support for only ARM Cortex A53 Application
> > processor subsystem with UART, which enables the board to boot into
> > initramfs with 2 CPUs.
> 
> Looking forward, what sharing do you expect at the device tree level?
> 
> Looking at 
> 
> https://sophon-file.bitmain.com.cn/sophon-prod/drive/18/11/06/19/BM1880%20product%20brief%20V0.04_Chinese%20versionV0.06.pdf
> 
> it appears all the devices can be shared between the CPUs. So do you
> plan to have a shared .dtsi file somewhere? 
> 
> Is ARCH_BITMAIN going to be both ARM64 and RISC-V?
> 

We don't have any plan to add support for RISC-V subsystem. Moreover,
from the SoC product brief it look like the RISC-V core is a MCU grade
core, so I doubt whether we can run linux on it! It might be a candidate
for RTOS.

For now, ARCH_BITMAIN is going to have only ARM64 support.

Thanks,
Mani

>    Thanks
> 	Andrew
