Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92677C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59BB52086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544623327;
	bh=TQVYun8alb6CW5IJmfINIMQPUjuLixoNq56I5hDsNwc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ov8xezS8UNQmuf2f8j4PP9bBvGGewvUkq8DOfiSGy678sotHgj37x0TOYAI1Nzjei
	 w1XZu0jahf28l69GVWNBuhub5IBdOj3mMF536qWtqETcLYouNT6J5S2bXGEhcwfBvH
	 qSKKBNWudhg/Fj+jzIguBq77CURoSsSB9eCnvGyw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59BB52086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeLLOCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:02:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:39468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbeLLOCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:02:05 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39E5D2086D;
        Wed, 12 Dec 2018 14:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544623325;
        bh=TQVYun8alb6CW5IJmfINIMQPUjuLixoNq56I5hDsNwc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MrUh2ks5lwZ1Mt4pRZce7bb8k7JgujTOIAXdhUmB1XJWtN1fE1QN6Ag+JE4KnHYiF
         PQZGYW1+r7PYe5iFe3SArjKGNEGGQ39m/DNJiDU1peP6TdTL1cUIshaghOHIiz7uIM
         e+pVM2WGJp5FHlhAtGZT715T4BRgCFEeu+Xpg+hc=
Received: by mail-qt1-f180.google.com with SMTP id i7so20506445qtj.10;
        Wed, 12 Dec 2018 06:02:05 -0800 (PST)
X-Gm-Message-State: AA+aEWZVXyTZP57pF09/xc6MKVqtoq+68Gbc0C3SLKIOU20lj7UZxEHf
        v2AYufwPtUWwt7eCuZfksbwMt0eMEILKlHGSXA==
X-Google-Smtp-Source: AFSGD/Ve9Uo7M+t2CMoosUpSXoyQuyEQZTNjYdL2J97NgoTk4sVs2SH3RWIG0Lh6f1cEp3TCYoYswwVxWIsBmzar9/o=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr19447707qtd.257.1544623324283;
 Wed, 12 Dec 2018 06:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20181212025214.29911-1-tom@aussec.com> <20181212025214.29911-2-tom@aussec.com>
 <20181212025214.29911-3-tom@aussec.com>
In-Reply-To: <20181212025214.29911-3-tom@aussec.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 12 Dec 2018 08:01:52 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+YBGqTA0ffvCE5DPwwf2bFsATgb80W-h4ehs3jzEsChA@mail.gmail.com>
Message-ID: <CAL_Jsq+YBGqTA0ffvCE5DPwwf2bFsATgb80W-h4ehs3jzEsChA@mail.gmail.com>
Subject: Re: [PATCH v12 2/3] dt-bindings: pps: pps-gpio PPS ECHO implementation
To:     Tom Burkart <tom@aussec.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, lukas@fridolin.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 8:53 PM Tom Burkart <tom@aussec.com> wrote:
>
> This patch implements the device tree changes required for the pps
> echo functionality for pps-gpio, that sysfs claims is available
> already.
>
> This patch was originally written by Lukas Senger as part of a masters
> thesis project and modified for inclusion into the linux kernel by Tom
> Burkart.
>
> Signed-off-by: Lukas Senger <lukas@fridolin.com>
> Signed-off-by: Tom Burkart <tom@aussec.com>
> ---
>  Documentation/devicetree/bindings/pps/pps-gpio.txt | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
