Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80218C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5116820843
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="S2n37ssw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5116820843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbeKCD5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:57:23 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36276 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbeKCD5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:57:23 -0400
Received: by mail-lf1-f68.google.com with SMTP id h192so2014471lfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 11:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w4eN1S5s+JG0jM2NKicOpMGQG4S8lFNYTLTr7vTJA+8=;
        b=S2n37sswwfFojUTj43MrucQM4sNu10oZ4RmEhISHAZwKcuyVuHFHo0/a2pnc1JFVAR
         af+UyxWL9rWbLFHrgJQBefuKw2F0tBakL4prUoDk/6dzZgW0JDW94UjZlbLqXtZxITtl
         BARpwMuKcKDNYenMkzdG4FJLnxTwybPbRWd1KpDis2tBQwFG4vNoePudxzq1rgJILayk
         MOaB+4hoZ7i4KqUaal9oa6RgJ4Xo6EXG5bzbpNpSTUJX/n8Mfsm8Rjwct9DUF5wVcXQx
         yGooUso/FgRb8jluLLZ0cckb/1Y2i5fyle0sd0c54GSNh6VaAfvJmglS++wE82R4bHPl
         cilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w4eN1S5s+JG0jM2NKicOpMGQG4S8lFNYTLTr7vTJA+8=;
        b=N/KFvUvgZ+4WD91uM0WmY7q7t4W8GOTit7L1uSXIozQqZr6gkunvcnWyTRQo3lyOc/
         BldibFo2iWdITMyWeJCIWcQPytVR6vvuNSG7/ph5C4YL8mb39rIhl8aphrZe6YMvhXqi
         eR+ZSskpWE+B6aO7W9QVX17oA5RnTVAsHcHNS8q6LyuKbhoAx/v8J+mhbWT8IdvoAn1J
         6o0DUotTy47GP0FOugtVseDl7rP1Xrdu2u/SHqmQSfyIq+diYi/6V1Kz5b7EIDbbWAaL
         rNLhSsGxITDmnhGt4xqtc1HkwvaKTiIGH0jKSUvdZsxjEebH+r5zcqnx0QffyXNH8PNt
         cCYQ==
X-Gm-Message-State: AGRZ1gLhhrJAwDxwBwlxLmsuxjpL2DE4Z1QgnJuZHsFsxA+HnS1IsxFB
        wcRdKAk6zB4Bk2K3T0d0Ng3V4A==
X-Google-Smtp-Source: AJdET5eqEda0EhhDttL/AME9bZa4uQ28j2ETBTz9dRrDa8tugUzF0UwCM9zmMgGQGMF7IuniEn9mCA==
X-Received: by 2002:a19:ee08:: with SMTP id g8mr7440957lfb.72.1541184547359;
        Fri, 02 Nov 2018 11:49:07 -0700 (PDT)
Received: from localhost ([85.30.9.151])
        by smtp.gmail.com with ESMTPSA id l21-v6sm2522866ljj.48.2018.11.02.11.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 11:49:05 -0700 (PDT)
Date:   Fri, 2 Nov 2018 11:32:46 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc:     arm-soc <arm@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [GIT PULL] sprd dts for kernel v4.20-rc1
Message-ID: <20181102183246.r5xxwsic2mxwihsi@localhost>
References: <1539854253-4784-1-git-send-email-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539854253-4784-1-git-send-email-chunyan.zhang@unisoc.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 05:17:33PM +0800, Chunyan Zhang wrote:
> Hi Arnd,
> 
> For 4.20-rc1 there's one patch only for sprd devicetree, please pull from my git tree:
> 
> https://github.com/lyrazhang/linux.git m-v4.19-rc1
> 
> Please let me know if there's some problem.
> 
> Thanks,
> Chunyan
> 
> ----------------------------------------------------------------
> 
> Suzuki K Poulose (1):
>   arm64: dts: sc9836/sc9860: Update coresight bindings for hardware
>     ports
> 
>  arch/arm64/boot/dts/sprd/sc9836.dtsi |  78 +++++++------
>  arch/arm64/boot/dts/sprd/sc9860.dtsi | 215 ++++++++++++++++++-----------------
>  2 files changed, 151 insertions(+), 142 deletions(-)

Hi,

This came in right before the merge window so it wasn't included since
it's more of a cleanup. Please resend it after -rc1 is out and we'll be
happy to queue it up for 4.21.

Also, when you do, please use "git request-pull" to generate your pull request.
That contains more information about the base, etc, and is generally how we
prefer to get pull requests. When you do, also use a signed tag instead of just
a branch head for the pull request. Let us know if you need help on usage of
that.


Thanks!

-Olof
