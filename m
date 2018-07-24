Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2550BECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70CD20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vp2wjY2f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70CD20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388643AbeGXUBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 16:01:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388366AbeGXUBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 16:01:01 -0400
Received: from mail-yb0-f175.google.com (mail-yb0-f175.google.com [209.85.213.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D181920875;
        Tue, 24 Jul 2018 18:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532458392;
        bh=fdNe0Y4qTuN1RrKqOQIcxCbJFsT+f5HX4yk++TMQ2kY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=vp2wjY2f2CDa53EK6Z1DN6Nc45BZZcQO6aKTqgFA8JGxSUtOXXuFSkJBfgYXuxZJk
         x2G+G5DXAao7KMwwv9DYscBkTSFDo5qiuycNVWJ9FipMOSTqruKuzi3aifuL7riH+e
         kgd7A9fJt4xh/M9vszEht43k2chjpaUNpfeuFn3w=
Received: by mail-yb0-f175.google.com with SMTP id c3-v6so2029810ybi.13;
        Tue, 24 Jul 2018 11:53:11 -0700 (PDT)
X-Gm-Message-State: AOUpUlGB2QPdE+CPVQj2z+8P84aJlRhfG1jFSR0fjxs/uXoqIymV4T3w
        4LomjCpQ/GXYtbGip4gWQ5lGeK+z3xVgF+30zjE=
X-Google-Smtp-Source: AAOMgpdfhRa85XFtGf4PycrDuFxFq/NYeK90QVReH3SgFEU6D33H0ITU4tiTHIxxe+/lJZos28WPkznNa8wnCELmU3Y=
X-Received: by 2002:a25:f817:: with SMTP id u23-v6mr9758811ybd.62.1532458391090;
 Tue, 24 Jul 2018 11:53:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:8182:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 11:52:30
 -0700 (PDT)
In-Reply-To: <1532441858-13507-2-git-send-email-appana.durga.rao@xilinx.com>
References: <1532441858-13507-1-git-send-email-appana.durga.rao@xilinx.com> <1532441858-13507-2-git-send-email-appana.durga.rao@xilinx.com>
From:   Alan Tull <atull@kernel.org>
Date:   Tue, 24 Jul 2018 13:52:30 -0500
X-Gmail-Original-Message-ID: <CANk1AXQ7RH6gwjNMQSXJZ=wCrwTGZ+T6uVgOsb6N+YJ2Y6zR8g@mail.gmail.com>
Message-ID: <CANk1AXQ7RH6gwjNMQSXJZ=wCrwTGZ+T6uVgOsb6N+YJ2Y6zR8g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] fpga: zynq-fpga: Add support for readback
To:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Cc:     Moritz Fischer <mdf@kernel.org>, navam@xilinx.com,
        michals@xilinx.com, linux-fpga@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 9:17 AM, Appana Durga Kedareswara rao
<appana.durga.rao@xilinx.com> wrote:

Hi Appana,

Another minor thing.

> +
> +/****************************************************************************/

Let's keep the coding style consistent by not having
'***************************'

> +/**
> + *

Also, you don't need /** followed by '*', just take out the
essentially blank line here, please.

> + * Generates a Type 2 packet header that reads back the requested Configuration
> + * register.
> + *
> + * @param        OpCode is the read/write operation code.
> + * @param        Size is the size of the word to be read.
> + *
> + * @return       Type 2 packet header to read the specified register
> + *
> + * @note         None.
> + *
> + *****************************************************************************/
> +static int zynq_type2_pkt(u8 OpCode, u32 Size)
> +{

Thanks,
Alan
