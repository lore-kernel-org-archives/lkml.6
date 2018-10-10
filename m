Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB343C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4AD2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEKSf6hv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4AD2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbeJJSlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 14:41:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbeJJSlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 14:41:24 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49D8F21524
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 11:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539170383;
        bh=0j+fajQexnlp2IqoN+7PRzjwmdbE8hNCtKkuzaSoYbA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bEKSf6hvZqJtMcsj0NETb8BNY3Bqw58wcRADTb0dI3vWXTPlzbOuPMPFixtW2FJ04
         RUzoBCnRV0IGkvD9/vAJuqej+yHfCdLbtqQ/iRGLFwMWrjldlS38zHCY3QD9YArND1
         l6j0uEt4T4bdYfqdAtyZVTXL2816QTEry0P8mryY=
Received: by mail-wr1-f54.google.com with SMTP id n11-v6so5177472wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 04:19:43 -0700 (PDT)
X-Gm-Message-State: ABuFfoirRzmdFCD9acSqSPF4uDL8RTnQsY1JVHaf3aFp0Z2Bjzv0A3Tz
        SAF2JnJ7MN31rXymgqu4etF1TMGOsNj0X10FEdQ/jA==
X-Google-Smtp-Source: ACcGV61Gy1OG1LZLLVfe/zcBtjGYQekd8y8v4EwQ+TT50j2kFjkMWixs6BsYelTNa+cXxWpODrf+a/uTIv6Uu5iyvbw=
X-Received: by 2002:adf:df88:: with SMTP id z8-v6mr19035312wrl.113.1539170381621;
 Wed, 10 Oct 2018 04:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNATaD=G8BW316fkBWM2A+YXgP5tabaySR2Fs49Za_0p=3Q@mail.gmail.com>
In-Reply-To: <CAK7LNATaD=G8BW316fkBWM2A+YXgP5tabaySR2Fs49Za_0p=3Q@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 10 Oct 2018 06:19:30 -0500
X-Gmail-Original-Message-ID: <CABGGisx-iLr+CQ=JjmHEe5J_Qqpf0yrgOmSOHa74GnfwE_RKsA@mail.gmail.com>
Message-ID: <CABGGisx-iLr+CQ=JjmHEe5J_Qqpf0yrgOmSOHa74GnfwE_RKsA@mail.gmail.com>
Subject: Re: [Question] directory for SoC-related DT binding
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 6:08 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi,
>
>
> I see a bunch of vendor (or SoC) names in
> Documentation/device/bindings/arm/
>
> ./Documentation/devicetree/bindings/arm/altera
> ./Documentation/devicetree/bindings/arm/amlogic

Yeah, it's kind of a mixture of board/soc bindings mostly with some
ARM architecture, ARM, Ltd. IP, and SoC system reg bindings.

Eventually, I'd like to not split board bindings by arch and maybe we
should move all the system/misc reg bindings out.

[,,,]

> I also see some vendor names in
> Documentation/device/bindings/soc/
>
> ./Documentation/devicetree/bindings/soc/bcm
> ./Documentation/devicetree/bindings/soc/dove
> ./Documentation/devicetree/bindings/soc/fsl
> ./Documentation/devicetree/bindings/soc/mediatek
> ./Documentation/devicetree/bindings/soc/qcom
> ./Documentation/devicetree/bindings/soc/rockchip
> ./Documentation/devicetree/bindings/soc/ti
> ./Documentation/devicetree/bindings/soc/xilinx
> ./Documentation/devicetree/bindings/soc/zte

This I believe is mostly SoC system reg bindings though there's
probably a few other things.

> Confusingly, I see bcm, mediatek, rockchip
> in both locations.
>
> Is there any rule to choose one than the other?

Top-level SoC/board bindings in arm/ and anything else elsewhere ideally.

Rob
