Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDDCEB9284
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF89214AB
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="FYJ3S4dF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="izP9rR+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF89214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732212AbeGLSoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 14:44:44 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:46616 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbeGLSoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 14:44:44 -0400
Received: by mail-ua0-f195.google.com with SMTP id r18-v6so19039131ual.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 11:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=I8d38FV6go6AJuLrXEetH513ZwKSx1a/R8OU8PmxUac=;
        b=FYJ3S4dFDCkqcoM2VyaS437QG7UUu2eQiYxq+W+1+xu0pfIAsGg+PLGVJsUxmFp+mc
         j/lJjSxZ2zfZHX4fpCG4qbxORBhgg51GOJRiG7O9dRsJo9Kr6kTtZOQ1NfF2H9U1dTTs
         U/NyY7tK5bNMQ7sG/uTrJn1AzYwIWN2dbI2zebO15J252w0eqGy0FXyTpe5aBI2p0zLb
         8r0nfT+ecZ9guOA1oH+F6Uzbo7XcCGCOc6HByZSPQTlDgN5Hu/mKhf4urUgMr9L/6XFP
         SiYSHuyYIHmWRr0gBB20mDB6SS1CHmlYzsPOPPkoTXBVxhuIwShbqWJNsBvBx3wUimAT
         pODg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=I8d38FV6go6AJuLrXEetH513ZwKSx1a/R8OU8PmxUac=;
        b=izP9rR+lBBO0SDdPOfdWYx/ZGrLK/1Yg5gfKUSb1NpXmkp0LFC6nBC3t0JDPguaifw
         /wjJRLf+75U3bmdLaw0bUVaXzSZmuS5tTTQqpYylKJ3+oxA0kedEl8veQuPl13Kx83L7
         d9aMb7fkPillye8JC+TAl1VYfDmy6AoKytXgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=I8d38FV6go6AJuLrXEetH513ZwKSx1a/R8OU8PmxUac=;
        b=S1d5xWOZmsLAmYGP6kl86y+t1dSGMVVmXFA39+yZwMdwN9MQTqOXST06122d1rLqnA
         ULHhcS7VpNOwOUtJzhoY33rEjR+785BLtjxYFomEltl3lhVfJR1WOL+IypkA/HUvh1bB
         2HLYpzVIM1a0U4OMzID5Xr3m3LQHX2mAQ+pBKBqcEtqR+z9pcfoYGHDofCezb0GAo+oN
         skhrK5ldqvZxW9xii5vSLU94obdkOJI07uxR4bg2lTl4MwAjuCniojzOe99IzucEY11R
         VtwRyo+5uR0R5bPNjiADmdjyi4KWddePIydjN8JqZVeZpeAOlzy6kleWDr+yDbyYk+Tl
         dgXw==
X-Gm-Message-State: AOUpUlETAV+ZK/IOynr+piioBwdW6UjDb3bqeV3zyNtP4iPd8M6T0NEZ
        m5dOwYwTuT/XDH0c6R2iPZOVhFfMobS/iLD17HP7CA==
X-Google-Smtp-Source: AAOMgpfWDh2DBklxDuViTFqDYKvMINatTJEltIRsxXvUFJOF9wwBFEfD1ix69D+AeS+gF044pFpR+nSW2Zu5QYQbSr0=
X-Received: by 2002:ab0:4364:: with SMTP id k91-v6mr2240446uak.46.1531420438720;
 Thu, 12 Jul 2018 11:33:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 11:33:58
 -0700 (PDT)
In-Reply-To: <20180709212522.187257-1-mka@chromium.org>
References: <20180709212522.187257-1-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 12 Jul 2018 11:33:58 -0700
X-Google-Sender-Auth: uI8VUfJpT1zL1VA3iUeVA15Y9i8
Message-ID: <CAD=FV=U0LezyVMLAQ5oXxBnO-sx4wGFe4KcBZpc=KCZNsYwpvQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: pm8998: Add spmi-temp-alarm node
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 9, 2018 at 2:25 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> This adds the spmi-temp-alarm node to pm8998 based on the examples in the
> bindings.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v3:
> - changed node name from 'qcom,temp-alarm@2400' to 'temp-alarm@2400'
> - removed controller register length value from 'reg'
>
> Changes in v2:
> - none
> ---
>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
