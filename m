Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D47C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884FA20878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="olVIXj3L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387701AbfAKSmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:42:46 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:39471 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731304AbfAKSmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:42:46 -0500
Received: by mail-yb1-f193.google.com with SMTP id p22so819070ybg.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 10:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kbeUktxOFHdiafcf1kYH3AxlaKpX1k9+eDn6iLBdJI4=;
        b=olVIXj3LnGLarwWWJzX0J2UETzwYBBA4N7BwQs/5UPjuapgg3qRITbMm8Rt8sHnp2V
         p2A678493xEQRLkXiB4SODriQHqk6rjVNIWcHUIfLm08mIoZMnQn7LrWCBwLfOgN/1Vc
         Lo3oF91XhW9lF3BsEJpRy9litJ2D4dZDGgymStHftNhMvSXXD//xGU51SEAXbu2wrdR0
         VmYbVhbuRTbSIz5f20j/F6+ocspitDmM+wzU4Z7PfVJJasFJjcqeusXETkmH4GDRQTyE
         bve+zUXoY8V7c/fq2OujUK/G9mBATZrdYRn+/aZLqGwJiWclFL1lrgV8iCaTH8tTt+HC
         /OEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kbeUktxOFHdiafcf1kYH3AxlaKpX1k9+eDn6iLBdJI4=;
        b=PxGX1uCNJNtPpUdXgY+L3e3beHIraHI+1hzVocoCZQKOUu2FriXbl9ECBlewZTDsID
         eSZ5aqez1hExg/Jn/oOXzrj1cfoeofQJAOehgqbq3h6353M9iMAXKvhAmPH6ToElkHEk
         5nGZ6P7d+h+Bv+tnorobAs6omtG3Kuc1GhIqcmzws6hI2cnshDYMmq81QRWytwgxhgX0
         QlWWT/1xlD09wlaXZ3MYtnNtBBEiKVdLAfIrS3EaH212MUKbG+afEo1o5BwqI4hO6toA
         Yjrnc4SiIAqJo33RLWEWF92geU8zFDqYKEwiaecbBSxdasbst7lq5VyCuau4aqJxcC//
         bvSA==
X-Gm-Message-State: AJcUukfQKH/AKoWDPZKzH8VjKAPFTReGwj9MITICV0WmNM6FgY+ppTPP
        qiyJJ6HNZ6HjMR3Ofc7yVY9faTK5NlGjO3sslpvr8w==
X-Google-Smtp-Source: ALg8bN5v1iK+R8eSenrkHqjc9nEWV3V7rOZP8BSRMy42I2kyg4kuSm9oDyiHe3T0vaUhL4ttL1nAyq2phj06sl1rr/s=
X-Received: by 2002:a25:4010:: with SMTP id n16mr11205752yba.227.1547232165328;
 Fri, 11 Jan 2019 10:42:45 -0800 (PST)
MIME-Version: 1.0
References: <20190110230626.4130-1-atull@kernel.org>
In-Reply-To: <20190110230626.4130-1-atull@kernel.org>
From:   Moritz Fischer <moritz.fischer@ettus.com>
Date:   Fri, 11 Jan 2019 10:42:34 -0800
Message-ID: <CAAtXAHeuGCz7msGnG-kPWN18h6h9z3VgbrBf0eXKvtKaEm7=mA@mail.gmail.com>
Subject: Re: [PATCH] fpga: altera_freeze_bridge: remove restriction to socfpga
To:     Alan Tull <atull@kernel.org>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Thu, Jan 10, 2019 at 3:06 PM Alan Tull <atull@kernel.org> wrote:
>
> The Altera Freeze Bridge should not be restricted to ARCH_SOCFPGA
> since it can be used on other platforms such as Stratix10.
>
> Signed-off-by: Alan Tull <atull@kernel.org>
> ---
>  drivers/fpga/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 0bb7b5c..0bdbd3d 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -104,7 +104,7 @@ config SOCFPGA_FPGA_BRIDGE
>
>  config ALTERA_FREEZE_BRIDGE
>         tristate "Altera FPGA Freeze Bridge"
> -       depends on ARCH_SOCFPGA && FPGA_BRIDGE
> +       depends on FPGA_BRIDGE

Doesn't that need a dependency on HAS_IOMEM at least, then?
>         help
>           Say Y to enable drivers for Altera FPGA Freeze bridges.  A
>           freeze bridge is a bridge that exists in the FPGA fabric to
> --
> 2.7.4
>

Thanks,
Moritz
