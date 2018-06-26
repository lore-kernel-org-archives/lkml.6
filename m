Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F222C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDC526C96
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="cKSzioaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BDC526C96
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754585AbeFZRn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:43:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41246 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751969AbeFZRn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:43:28 -0400
Received: by mail-lj1-f193.google.com with SMTP id v12-v6so9449565ljj.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 10:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2opuqJ2q/HiRmd4iKG/efFesQEkDif522iFuNItK7H8=;
        b=cKSzioaTowpUdleH0Yxi4oo0mZgFMbk04/lJvAsVIFZE/ScpvykZzKfZc8QG03IWM3
         pErujDlIzpis0F8Jd0kW2VYzXiOGvsBvPBGYG0gNMAoepRP/Tptxsz83cqRDLdwsw0EY
         rrplVlCF1imUW6U/S8yvNpnGcRq+r+lEa5e1wn93HnsinVpGYpvYyjGVNbHJa5NhcJW/
         xoHKnlZx+ZgUqJEciKYomzpxfEbxa8DOq4eNuni0CgCssntMbSPgywVtuLyQbKrYFReU
         AEqo7RpKGELMwOKr/5bbfXLb45ONOW8aoAc/3Gefe5jeU/vwLVeka0lhuAN/ZxQXTYxc
         ourw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2opuqJ2q/HiRmd4iKG/efFesQEkDif522iFuNItK7H8=;
        b=rAolYOtbCofgtQMSj9hAbIcaSNeAx32Wb8xUPr70zqjmyIS5SnBfEtSv1WkpE0C/oK
         l9GYWhQqv/jE5PfYDetvkHA38QHRGi9s6r9CkaeyKyrGqwwocPDnfcx5MfBQ7PoOam6d
         7TDAPoqmrauVgGgCbfiOX7bWollwgQB1W6YNKVNE2TdJ0ccUDQ1FWvX1EYcVGBZWHndr
         BP7xmwIt7gUuo+b7jXCQCW+i1B75Ev69I1rg0+BOwAcQuAyQmT6mSKAs7escZZEnStE+
         jBAHilPqrnGvw2smhnv+cwPmWHh7uVBRbCNr99SctuNLkkkaUJ4QLAIZlZRSdJaEREeR
         QCuQ==
X-Gm-Message-State: APt69E3LAEv/XdJpuH0YiygTATXH52vd3VijEZ1rSjPb7eORvf+uBTJ2
        EJMa7SEuspAp+jKAr7JEAhvTNQ==
X-Google-Smtp-Source: AAOMgpckoL/gqe7L2EyT6Sc/amHuz7AyRm0Wx5ZJD+vv5X9VsD4pe9X7/nGGs/ihJKVdoMWss4EdoA==
X-Received: by 2002:a2e:712:: with SMTP id 18-v6mr1770833ljh.37.1530035006667;
        Tue, 26 Jun 2018 10:43:26 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id a3-v6sm340719ljb.80.2018.06.26.10.43.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 10:43:25 -0700 (PDT)
Date:   Tue, 26 Jun 2018 10:42:15 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm-soc <arm@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] ARM: uniphier: fixes for v4.18
Message-ID: <20180626174215.spnsyfqh5wk4tzep@localhost>
References: <CAK7LNARAMcUgV2K1_dDdkupaWdtLqGMz==+huurHJKyW=JVWxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARAMcUgV2K1_dDdkupaWdtLqGMz==+huurHJKyW=JVWxQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 25, 2018 at 11:13:04PM +0900, Masahiro Yamada wrote:
> Hi Arnd, Olof,
> 
> Please pull some fixes of ARM UniPhier platform.
> 
> 
> 
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
> tags/uniphier-fixes-v4.18
> 
> for you to fetch changes up to 4e62893c25bd3d5758058e15958364df3ca15fbc:
> 
>   arm64: uniphier: select RESET_CONTROLLER (2018-06-25 23:00:31 +0900)
> 
> ----------------------------------------------------------------
> UniPhier ARM SoC fixes for v4.18
> 
>  - add missing cooling device properties for CPUS
>  - fix widget name of headphone
>  - select RESET_CONTROLLER

It's unclear to me what the severity of these fixes are. and I think the
headphone widget name is the only bug that's causing problems for someone using
this kernel, is that correct?

If so, it would also be useful to get a "Fixes:" tag for it, seems like it
should be:

Fixes: fb21a0acaa2b7 ("arm64: dts: uniphier: add sound node")

Care to resubmit with just the bugfix? Or, if it's easier, I can cherry-pick
just that fix at this end and add the Fixes line. You should queue the other
patches up for 4.19 and include in those pull requests.


Thanks,

-Olof
