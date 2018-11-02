Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84674C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563182082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="XWuO3FSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 563182082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730585AbeKCD5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:57:10 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43543 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbeKCD5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:57:09 -0400
Received: by mail-lj1-f193.google.com with SMTP id g26-v6so2595433lja.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 11:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wgmDEcB4bBXP9I2JTJTsuRvccXfrezR7WJsNsO3M4Rw=;
        b=XWuO3FSlEF1qKkG8VVjxPx95jD2c8KlNTTYjaULR8549alHbkalVcGrgM/KK9mo35f
         r2Ejl/tthNv1/1F7M2KCOCEeyXqUIjroYskkKagXIu6p3eor+kW+MYAzcD1MtXtU9XwW
         X4IR2MrJIZ7+MGHEdWlfp03DcLSXAo1vT5bOOSjiFwnZ5EqvPZAAUI5f7o/jpDyohlSY
         rIMlcD8EfhMWwr2tm9Nk2SX5VHKuevZxdTyz9fIjcKFt5NRkUYMqDU4woE/Hq6Jqvp9J
         TQfXQ+Inp2gqyIup1OXrgGX41JDkfGAEBNptU4PfrrEj3mJ5jfpjCBl/WWeZdx5C5c2u
         1VWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wgmDEcB4bBXP9I2JTJTsuRvccXfrezR7WJsNsO3M4Rw=;
        b=etBsYQBIXk/hBDVkzgyvtFbnJbU8eRD5Df+r2MnQlJCy0nKBLCL/ljZLYk4BiMUCwA
         VgmiWJWCiUwpVWK74J3KivFbiX5ZwNZgYBcU5D9rLfq6IPC+79K1XCG7EeXKPbwh2qjq
         tNhiZab9HzWzu0JdWpyzihOuBe+t//9EkaGd1mgyI6KV4TRHK6kWdG5MZWRC7LYQDfL/
         9W8lrSjkIQE2SyVgROO/5D2W4EArmDVLshUtNQYF06HaaHv+xOfWDabtRJlHN+AKVZx0
         Zauxb3ZruzYG4haKiwYJjkMLn76N+2fW9B7vPnkoHL6PctdzZCpKfAsF79q6zxHjXyiP
         V8sQ==
X-Gm-Message-State: AGRZ1gIVLwmlb3VsCfVjUoem9odynSlnFVnkUKPRgoYBHZqpYW9sPps6
        w3NANHeWDqZFhg14PrICHv7iUA==
X-Google-Smtp-Source: AJdET5e4HNr9FLQ9hrQIXQnPThiOpmAnUICmxOlZsMlZ144UOk9c1lTWFDXSQMj5AsDz1A6qSpa2Yw==
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr2692510ljk.80.1541184534294;
        Fri, 02 Nov 2018 11:48:54 -0700 (PDT)
Received: from localhost ([85.30.9.151])
        by smtp.gmail.com with ESMTPSA id m4-v6sm899364ljb.58.2018.11.02.11.48.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 11:48:52 -0700 (PDT)
Date:   Fri, 2 Nov 2018 11:22:31 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>, arm@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] soc: ti: QMSS: Fix usage of irq_set_affinity_hint
Message-ID: <20181102182231.jlyruwut3dtsfhp6@localhost>
References: <20181031084134.96289-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031084134.96289-1-marc.zyngier@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 08:41:34AM +0000, Marc Zyngier wrote:
> The Keystone QMSS driver is pretty damaged, in the sense that it
> does things like this:
> 
> 	irq_set_affinity_hint(irq, to_cpumask(&cpu_map));
> 
> where cpu_map is a local variable. As we leave the function, this
> will point to nowhere-land, and things will end-up badly.
> 
> Instead, let's use a proper cpumask that gets allocated, giving
> the driver a chance to actually work with things like irqbalance
> as well as have a hypothetical 64bit future.
> 
> Cc: stable@vger.kernel.org
> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> * From v1:
>   - Added Santosh's Ack
>   - Cc stable
>   - Directly sent to arm-soc for immediate pick-up
>     (https://lore.kernel.org/lkml/0a20aaf3-65ce-a7ae-8a0e-877313483969@oracle.com/)

Applied to fixes, thanks. (We could have added the cc too, but thanks for doing
it!)


-Olof
