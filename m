Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD6EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8BA20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqqwG676"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8BA20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbeKIVMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 16:12:16 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:34406 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbeKIVMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 16:12:16 -0500
Received: by mail-wm1-f42.google.com with SMTP id f1-v6so3571036wmg.1;
        Fri, 09 Nov 2018 03:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FbKqNyIPkJTXuz0eRpsx+9KaLLnlFzlLi8t1Syeq0Ms=;
        b=OqqwG676TpPE0l6TBtia/yS33u1Sqsh6Ntqx/8Jc8kPQNGBZ3ZKQYVY5Q787rVc+np
         sjLblSLBO0GHqJdhWpnphmCMVOAgK5q8PB/QwPHl5XguUeBdFQm+Rl1uASIqJSC8IU2T
         L+7uw7AY7ysZhOwrgyf/1BzoXMqkOmBcRHUE981pMN5pBDzWj6klNHPXKPDJmmb5bZ8W
         SP8ZWuc6M9HmaJ+JNUlAOC3On3lNlqWEfg0X+hlAd0LesXQu5TOoEA+zu3ahdtlbX0l6
         u5Dqa8xEAQcUR11Dg8Z2cYpiBq55yA7DISGQ/E6/8ps2bTGQyNmFgcBVWzcwQHYgJEi5
         0R9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FbKqNyIPkJTXuz0eRpsx+9KaLLnlFzlLi8t1Syeq0Ms=;
        b=U5Xt6nlg+K0BJNDYrxLllF86u1HX2uSeOJMCW6Pmzosz1O4h5O+QUc6wKSKDJQTVHg
         sKIUcCiM2aEMhs4BG7+hw9IpTJ+V5sRxa+6daBzuwG9aLM9wisTYu6DRdK3DquPwxfb9
         CqPje7INZQ+LUpX1oMisLfxW4BIHfwlj/MTeVcVpcQgL/hMBe3IDnMPMkq0ovMfUXGvg
         d3U6jzf7wUeajvSqZzr/hIuG0OeV5/LpJZH8VIVKyJvT9i5SirwgkebwVbkIORspEwyS
         /vcaiiFEIwNJiTTetZUzMQis868JvJT+Yw/+U1vA8tiBXOrGoHqk0V0I6G6Ow8yMFRUR
         v+pQ==
X-Gm-Message-State: AGRZ1gKRuz0+AJ2SBsti2uL2Oik/WmBxIkujEV5hXiBnxWkQ+JkLEMSN
        AZduzu7nEbA9k6AVGkezSLI=
X-Google-Smtp-Source: AJdET5e5i8RYeMurc38n9KkAjW5vq52LvcTVUfuRNJ3xAII0+gJtX9PlGAxG6wboRMrv6inQh60cOA==
X-Received: by 2002:a1c:6555:: with SMTP id z82-v6mr4519714wmb.66.1541763121537;
        Fri, 09 Nov 2018 03:32:01 -0800 (PST)
Received: from gmail.com (net-2-42-72-229.cust.vodafonedsl.it. [2.42.72.229])
        by smtp.gmail.com with ESMTPSA id z8-v6sm8223745wrr.94.2018.11.09.03.32.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 03:32:00 -0800 (PST)
Date:   Fri, 9 Nov 2018 12:31:59 +0100
From:   Paolo Pisati <p.pisati@gmail.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Paolo Pisati <p.pisati@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        netdev@vger.kernel.org, stable@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [stable, netdev 4.4+] lan78xx: make sure RX_ADDRL &
 RX_ADDRH regs are always up to date
Message-ID: <20181109113159.GA22785@harukaze>
References: <1541609457-28725-1-git-send-email-p.pisati@gmail.com>
 <20181108001751.GA8097@sasha-vm>
 <20181108110127.GA8415@harukaze>
 <20181108154904.GD8097@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108154904.GD8097@sasha-vm>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 10:49:04AM -0500, Sasha Levin wrote:
> 
> Can you confirm it actually works on 4.4?

Yes, built and tested on 4.4.y:

Tested-by: Paolo Pisati <p.pisati@gmail.com>
-- 
bye,
p.
