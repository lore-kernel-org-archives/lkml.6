Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76640ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DD82086D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9aeHwip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33DD82086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731553AbeGRRbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:31:23 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41687 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731392AbeGRRbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:31:22 -0400
Received: by mail-oi0-f68.google.com with SMTP id k12-v6so10060976oiw.8;
        Wed, 18 Jul 2018 09:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OEgwAtfurQfYap7Fsm1jhla4UWcE1T4xJKE8L52MuHk=;
        b=N9aeHwipy6pn9/mVJxCTZ8xj/pwpOnm+cUNy1YJnbE/1QHPACbBb26cRCvu08ayoTj
         qPGhZQkNvP+IDJhwutFxMSH2Baab/a1H8P7k4NEBXCzWdUhLaFsQrMifuHF+V3nhhwIw
         hj/wfYGc/VfVkzk3c+UlnDw1mG9uatPup0iIt0xs0MqEDiJDAoZ7D/kY8xJLb3SHE+K5
         SQaYwVFSkrSY92OWxR9F8l0sGNAe5GSXe3zVGREKjw2Ep14h9nRMcUQKhaPT1nwc84DZ
         FPYn0X9wWnUl7B3QCuhC+1LXWHLknGB68m3n0NLmD9cGELA3fBCkXZct5GJUEFNmZ/Bm
         XRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OEgwAtfurQfYap7Fsm1jhla4UWcE1T4xJKE8L52MuHk=;
        b=R/ZOzwO5NS0Djl2IxeJ7mpUlmxIFk41mHyjWbKdRUIy+B07I+hh6apqTF37qPsrhEE
         eHxGH7V2DjrRHtk2s4JTha6fJ7McUBPxXgPiG6pxAcJh+5FxHPNQzrwNsIz4qbEqIG4l
         vJ9W5VToDo9OEmWQP+YAweL0iC6M0g/T+iSCg7WE9lDRF3xdWWpbzDnX8K3PIv7fKsRo
         lSap1UMMxMFAwxLkNfmCiqCR9VCrgf6J/z0/vyHzgERfVpHBluFZ7Z7TZgqnCZId4CXY
         9/DYuDYssgnf8YTi5htKq7NorfWWSZ6ZHzyRY6hqoTAPSajvJA4IVbQxBH7UKRQooHZP
         zzcQ==
X-Gm-Message-State: AOUpUlEMsRQlLFmrxokT0wX88ml4mVz71BtnGrvt9gBx9GQVagbXkgHj
        d/tY+ELCLCTy3gWM3P6aTMlxoHkw
X-Google-Smtp-Source: AAOMgpfRubK5H2UG9dIsO93ciu9hyT30RUsBwY58mZdyMD6lqGzde1NkGKVukRbaJ6peFVVsNyQIDA==
X-Received: by 2002:aca:bd8b:: with SMTP id n133-v6mr7369005oif.108.1531932755575;
        Wed, 18 Jul 2018 09:52:35 -0700 (PDT)
Received: from localhost ([12.130.117.108])
        by smtp.gmail.com with ESMTPSA id w84-v6sm3130673oie.40.2018.07.18.09.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 09:52:34 -0700 (PDT)
Date:   Wed, 18 Jul 2018 16:48:27 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     robh@kernel.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
        jeffy.chen@rock-chips.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] input: gpio_keys: add missing include to gpio_keys.h
Message-ID: <20180718164827.yq2j3e5gt3jkjuyl@penguin>
References: <20180627073458.GA27800@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627073458.GA27800@localhost.localdomain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 10:34:58AM +0300, Matti Vaittinen wrote:
> gpio_keys.h uses 'bool' - type which is defined in linux/types.h.
> Include this header.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

Applied, thank you.

> ---
>  include/linux/gpio_keys.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
> index 7160df54a6fe..3f84aeb81e48 100644
> --- a/include/linux/gpio_keys.h
> +++ b/include/linux/gpio_keys.h
> @@ -2,6 +2,8 @@
>  #ifndef _GPIO_KEYS_H
>  #define _GPIO_KEYS_H
>  
> +#include <linux/types.h>
> +
>  struct device;
>  
>  /**
> -- 
> 2.14.3
> 

-- 
Dmitry
