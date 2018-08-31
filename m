Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814F9C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3321620845
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3321620845
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbeHaO2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 10:28:21 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38483 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbeHaO2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 10:28:21 -0400
Received: by mail-lj1-f193.google.com with SMTP id p6-v6so9674688ljc.5;
        Fri, 31 Aug 2018 03:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TYD+xqOtnjhx+b8U7hMv98xh8dj8bFLCKPFwlBspsdk=;
        b=FqzGzUvGAfXDjFqqpdGkoaY2p/iwh8WBNYVO6sBQ1S1CsYOtPOV0BsiN7AAJ0M5r9q
         h9yQI4PrX71lTZxRyM28vdLvMdsTF5gJ7+gcPq3ofRVGkaFSjYVm6gPJgKmBAbGxkgyC
         66/O/1dbPMssjGwbQlFArqU9gtIP8F9A0gg1znCghHP7ajZ1fwbhbMth5QzVfEyb/Un+
         V4IMExDl2rQlyBrECil7bRAReFQ0XubESnLSLNlY6SBPttNjhOwcEzFRr6/vaH0C7qfu
         VsMbJtseMxgpc8o0Q3JEafNtnUC/2C1YupkTSB7N1+qKulTWNN4A82mE2yw8Z1ZfPaNq
         X8AQ==
X-Gm-Message-State: APzg51BqAnwlvOsbVedR1RGzEqMoyJm8MtwU3djrxW4mTXG2rwz9XqSv
        TCzgMsR1Qq1WPvwdJ3JcRXw=
X-Google-Smtp-Source: ANB0VdZH4em3NU2cm7DnXj0eztJ5aC5TfQvZ2SKxTmOc2mtqRlrZPPWZVo8BVghzsSzF4QO5x2txug==
X-Received: by 2002:a2e:9cd0:: with SMTP id g16-v6mr4972577ljj.110.1535710892177;
        Fri, 31 Aug 2018 03:21:32 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id t14-v6sm1698004ljg.17.2018.08.31.03.21.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 03:21:31 -0700 (PDT)
Date:   Fri, 31 Aug 2018 13:21:23 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, corbet@lwn.net, mturquette@baylibre.com,
        sboyd@kernel.org, linux@armlinux.org.uk, andrew.smirnov@gmail.com,
        robh@kernel.org, sre@kernel.org, linux@roeck-us.net,
        sjhuang@iluvatar.ai, mazziesaccount@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Subject: Re: [PATCH 2/2] clk: bd718x7: Initial support for ROHM
 bd71837/bd71847 PMIC clock
Message-ID: <20180831102123.GA2472@localhost.localdomain>
References: <0e6f19f99a4321d37472635c9210f6c13ac53147.1535630942.git.matti.vaittinen@fi.rohmeurope.com>
 <201808310820.GfPfChXp%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201808310820.GfPfChXp%fengguang.wu@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

Just wanted to point out for the reviewers that this patch depends on
not yet accepted MFD/regulator patch. (struct/defines in
include/linux/mfd/rohm-bd718x7.h were changed)
https://lore.kernel.org/lkml/cover.1535545377.git.matti.vaittinen@fi.rohmeurope.com/

On Fri, Aug 31, 2018 at 09:18:19AM +0800, kbuild test robot wrote:
> Hi Matti,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on clk/clk-next]
> [also build test ERROR on v4.19-rc1 next-20180830]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

Thus this error was expected. What is the generally best way to work
when there is changes to more than one subsystem? With this approach
the patch set here won't compile until MFD part gets applied. But if
I use old definitions/structs here, then clk tree gets broken when
MFD/regulator part changes defines. I see only bad and worse options =)
Anyways, I guess sending this patch with new defines (and applying it
only after MFD) is still better than applying this with old defines and
breaking it when MFD changes. (Assuming all of the patches get applied
at some point).

Br,
	Matti Vaittinen
> 
