Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606F3C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA50208E1
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWX78OY2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA50208E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754427AbeGIF3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 01:29:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752914AbeGIF3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 01:29:19 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7B75208DB;
        Mon,  9 Jul 2018 05:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531114159;
        bh=v1ZpCiLAsqABGPqnv96KsPdGHYqEg/XY5KpoJ2X43/Y=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=IWX78OY2K2mTVzq8nJmhMWa9MAuZIMIrn5PrzPaqCfJTzxlBIQtS+/phIrqQYkIG3
         OuJAa7hfBfCtasDBshjHuYGL+zUs9DWvz9ls8J8IluIAMDJH4c2YlobnVk0zvLYh0Y
         RabtE6cGRLkFd5ks8yxRsK59SFW9mkq1jc+Md4LM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jolly Shah <jolly.shah@xilinx.com>, ard.biesheuvel@linaro.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        hkallweit1@gmail.com, keescook@chromium.org,
        linux-clk@vger.kernel.org, mark.rutland@arm.com,
        matt@codeblueprint.co.uk, michal.simek@xilinx.com,
        mingo@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        sboyd@codeaurora.org, sudeep.holla@arm.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1529516435-7315-8-git-send-email-jollys@xilinx.com>
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jolly Shah <jollys@xilinx.com>
References: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
 <1529516435-7315-8-git-send-email-jollys@xilinx.com>
Message-ID: <153111415833.143105.8701882244160397855@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v9 07/10] firmware: xilinx: Add debugfs for IOCTL API
Date:   Sun, 08 Jul 2018 22:29:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jolly Shah (2018-06-20 10:40:32)
> From: Rajan Vaja <rajanv@xilinx.com>
> =

> Add debugfs file to set/get IOCTL using debugfs interface.

IOCTLs and debugfs aren't the same thing. Why are the two being mixed
together? Is some sort of userspace ABI being created here to control
clks with usermode drivers?

