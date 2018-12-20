Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6D0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EBB217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545338536;
	bh=l4Lx5OAfR1uXgRQchjp3Yx1N2dvaEX2eQ5ElJgtrdF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jb04GuZQocxenM8/8+L7BqJrTADIh/XiDRnqwAmIoE8TRm1Jf9Dd2DqBr5rhDMg4D
	 0IrAgBgKPtoejsMEgwaDDplMVgjTXjVY53tqLoWH1V1JnWvVoeo8Yu4LCZiY0hVIA4
	 txeAsdhCLEAlCWMHyZwap1xlCUIlD59H+0fo8HwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389605AbeLTUmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:42:15 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46113 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730639AbeLTUmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:42:15 -0500
Received: by mail-ot1-f65.google.com with SMTP id w25so3141074otm.13;
        Thu, 20 Dec 2018 12:42:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tVEqFMsMqbcdxOlpznRJ8KsM4XzERdDjY4L8G4ZoWnQ=;
        b=XRXL0MzrbA6Y9+J3rQ1dKJQIPm7nnIIM00O+gxqaZ8WPdqwIk0cLme3bvMrz0u0W/U
         LMs6y8KYW5O8TpjrKrYzUBFfoJ7elV39ceXdPlNmTXYvtLFtVBocWmqUh2k0WuAVO3oP
         NNoaT2ItZp5tfxyvduKHcDF4UcAImywyN7vHzlAwFAuS0AAjfyNEpw69p0jif6XPILon
         ptbHgfdWUne2CfqAdgN4wh6H23fmlKl3vK616N8ABLcf4CaPnnL+rpsWPHEBjqNii+yk
         scUfvIyo1NlJAZGLYoWZ4I18TEf5/UcIlcbKKAbIcXU68cuOJ+OGLvLbtswW+WSOg3iC
         8jUQ==
X-Gm-Message-State: AA+aEWaW48A3zMmFFhgXRfk+rEGGYKlqW2stzJf/IUkXUG1FAvlYFYQD
        whjIDuPDWH+kTPWRAuJXPQ==
X-Google-Smtp-Source: AFSGD/ULYeZ9Zpij+f7zMeZUd6hFu/dyccP+5VRMhCgGDR9NkrD6nnIrQw3TR4Uk62KMBbRoUAfaqg==
X-Received: by 2002:a9d:4ac:: with SMTP id 41mr16589212otm.344.1545338534151;
        Thu, 20 Dec 2018 12:42:14 -0800 (PST)
Received: from localhost ([2607:fb90:20d2:a5e2:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id t201sm10390488oie.37.2018.12.20.12.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 12:42:13 -0800 (PST)
Date:   Thu, 20 Dec 2018 14:42:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: udc: renesas_usb3: Add bindings for r8a774c0
Message-ID: <20181220204212.GA27548@bogus>
References: <1544732538-7049-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544732538-7049-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 20:22:18 +0000, Fabrizio Castro wrote:
> Document RZ/G2E (R8A774C0) SoC bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/usb/renesas_usb3.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
