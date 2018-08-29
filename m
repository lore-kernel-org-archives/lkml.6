Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D92AC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C04F20897
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jt9xvvH9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C04F20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeH2LbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:31:22 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36315 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeH2LbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:31:22 -0400
Received: by mail-io0-f194.google.com with SMTP id q5-v6so3666386iop.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sUh5/n9m7nIas5VHE8Dj7jGI3lq1/PBuRKihJpGUNkI=;
        b=jt9xvvH9COAVyA40fgnD1rJVo5dIIJz54Gvq72ed3E25Td9a6uImzqM8N8rr91NTv1
         ShWhdd0RU6Tmh3xbxJJZXMIM7XGpDtLYXBnJqZxy6R5LL/DFx7Xkn2DFPoXup3ggHTaG
         MYKSQCujk67OyeNLtuLPUy+sIJZmbVx+FIFrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sUh5/n9m7nIas5VHE8Dj7jGI3lq1/PBuRKihJpGUNkI=;
        b=Z4iwXt+Ncnt9fAqwrmaB2Csa3CF1S4+H6M5mYsgkCaerCNyOJwH1Tuo1yOoyjAi/+6
         t7cnPEZKYq2yb7TBw8RLcQSNR9YsnLcxBCXUzvIihxPIILSlyar1D/QQ/cU6mX7S6LOF
         zwD40Ssrv2xW9iZtM+xol1s2UAXz9vET88ar7ITtrTz98Xl2A/sHocCMyXJe+a++gEV6
         foMMhzngUvV/ITVpspjLh5mZdYE5cGE3e3RO+yt5llpaxkF7qkCZnl8DK0SCgcU1eEEC
         LBwhj8E3kTKay9AYoC32wu0jpN+nK2CLjeiVw5uErJcdOEHWpFPR1cYz60/JOT8gt8XV
         4F6w==
X-Gm-Message-State: APzg51DswqkLzqoGTwbzfSLo6l5KHx+NBcJi+4XS7VrBRrIToRjU1BVe
        UzgKDcPLmI9Jx/6Cy2d7UpNRz7qwzDdh1X80MXq9Uw==
X-Google-Smtp-Source: ANB0VdYPm48n+v4xlpf4yu4iln1VDtdEu5/fA300/RIKs34w+VJYQ2bm1/wmSkx5vBwjtcMmTscfl0aMvB9hwfNf5tE=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr4139485iof.304.1535528150331;
 Wed, 29 Aug 2018 00:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <0180729200038.11795-1-sravanhome@gmail.com> <20180731194743.13678-1-sravanhome@gmail.com>
In-Reply-To: <20180731194743.13678-1-sravanhome@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Aug 2018 09:35:38 +0200
Message-ID: <CACRpkda=q+LZMUN5xJ777ZGWxYRBdZTvG0naNqr5BoLnVQ1=aA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Add Actions Semi S700 pinctrl support
To:     sravanhome@gmail.com
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>, pn@denx.de,
        mp-cs@actions-semi.com, Jeff Chen <jeff.chen@actions-semi.com>,
        "Thomas C. Liau" <thomas.liau@actions-semi.com>,
        linux@cubietech.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 9:48 PM Saravanan Sekar <sravanhome@gmail.com> wrote:

> This patchset adds pinctrl support for Actions Semi S700 SoC.
> Pinmux functions are only accessible for pin groups while pinconf
> parameters are available for both pin groups and individual pins.
>
> pinctrl driver is verified using the Cubieboard7.
>
> common functionalities from s900 is moved for all Actions Semi
> SoC's usage.
> Common pad control configurations are moved to SoC specific
>
> dts entry for pinctrl depends on clock driver which is still under review:
> https://patchwork.kernel.org/patch/10533959/

So what is the status of this patch set?

I am happy to apply it once you have the right buildtime dependencies
and Manivannan's ACK on the patch set! (Looks good to me.)

Maybe you want to rebase on v4.19-rc1 and resend as v5 before
I do that though?

Yours,
Linus Walleij
