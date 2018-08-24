Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A098C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BFA21564
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="p0mVjtQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BFA21564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbeHXT11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:27:27 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38186 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbeHXT11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:27:27 -0400
Received: by mail-lj1-f195.google.com with SMTP id p6-v6so7256319ljc.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 08:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U8zJc2gSGCcQcbah0NZ2VWLhNA8CLMTe2gDxOP3Jmhs=;
        b=p0mVjtQQ5Beq8IZPz5r2p4219c03IHWavCx3/4OCij116iz+Ai2S0HtqD/UydgTYsD
         +zX1pkiuzPCgLOAGwt2bk2PCmaHBJo00dbdX9WbR4C8Wd9/oNp/ZuX3zfPo78UiYrUVr
         5VDuFAMW1hzRM9g3yf8+yTnx220PtGqSfzzQjW2wnoKuFnzmcPPLAwCc7DjiWnPWoHb+
         jhI3coeKrx9sUvX7dF6oo8y+gB0KtN3WrLzk0M7oEpq5rqCgJraoOFcE9mOS8QmQBD69
         T4wxX/liW+xhKMICefJl4uP8SU/Z3Z4ySBO1NKSvyEBOnB1vWb4/f5VSsBmhCatjv8av
         BDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U8zJc2gSGCcQcbah0NZ2VWLhNA8CLMTe2gDxOP3Jmhs=;
        b=oXyG7zraJl6Fr6y8gmZbtZ9E2AyccwFcjcDAnLyV3yP+7101I7lAVtXzirqhK51Ebr
         5/B0ODuDvIH7KfAwMMJs0vjd0YKHNRWJ51rwGV7uia6almWLaI8P53gKs1RRKJVU6RiL
         lEdNUKS58P7fMr66YZOLlSO56KSC3eZ/Ldv1+b4+kZdTycTykrOKUAWq+Nu1gvIBEQRO
         mTvo5lj6uK0coii/m39Uz+vdCsM9Skfa+x9OA3QxiltKHhvLYA6zah08V13awARm+Aod
         ztLLxfJzQYGqJysr0QeY2uvTmpxF0J9z5DoCxbsdFwR2k8sQj0RP1Q/Ddk3Fa2DawgfL
         ytMQ==
X-Gm-Message-State: APzg51De0/ejuZqYXOKJMJHwxJIThEeR/0Wt+Bav4KCcOfx0Vqbv8z6C
        aABErwlooykUH0WZlgDX56IUeJylBSlmlotA
X-Google-Smtp-Source: ANB0VdYD9CyGK4rNz7Wo7/kHwiNP+8g/hbw0MZT2Io2K64UdhITmtEZcQZPZ6nLOd3qXnsaywsx4CQ==
X-Received: by 2002:a2e:2096:: with SMTP id g22-v6mr1747052lji.37.1535125932474;
        Fri, 24 Aug 2018 08:52:12 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id q15-v6sm1252281ljh.34.2018.08.24.08.52.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 08:52:10 -0700 (PDT)
Date:   Fri, 24 Aug 2018 08:50:59 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jeffy Chen <jeffy.chen@rock-chips.com>, arm@kernel.org
Subject: Re: [PATCH v2 0/4] iommu/rockchip: Runtime PM fixes
Message-ID: <20180824155059.qskwdxmc6ws3hwtv@localhost>
References: <20180824150637.15316-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824150637.15316-1-marc.zyngier@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 04:06:33PM +0100, Marc Zyngier wrote:
> This small series addresses a couple of runtime PM issues I've spotted
> while running 4.18 on a Chromebook Plus (kevin, rk3399) platform, and
> specifically doing kexec.
> 
> In order to avoid making a complete mess of the IOMMU code, Heiko has
> requested that all RK platforms would select CONFIG_PM, which
> simplifies a lot of things. I've kept 32 and 64bit patches separate,
> but feel free to squash them into on if that's more convenient.
> 
> Note that even with these patches, kexec is still fairly broken on
> rk3399, as the VOP is never turned off (see [1] for a fix).
> 
> [1] https://www.spinics.net/lists/arm-kernel/msg670229.html
> 
> * From v1:
>   - Collected RBs from Heiko
>   - Added two patches forcing CONFIG_PM on all Rockchip platforms at
>     Heiko's request, following the example set by Tegra platforms.

Thanks, applied to our next/late branch which I plan to send in tomorrow.


-Olof
