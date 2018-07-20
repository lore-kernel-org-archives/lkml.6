Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9C8ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9055220652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BEGi/dXd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9055220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbeGTVWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:22:02 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51526 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbeGTVWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:22:02 -0400
Received: by mail-it0-f68.google.com with SMTP id h2-v6so16392956itj.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 13:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cL/zNQffEbfWplGlqTueC7W+niUlPrnN8FmgiBSSyKY=;
        b=BEGi/dXdVA+Eqr9BVF1mQDse9fuc/cg/SU5Mn4WjxKVEXMcBba1PCAUJaoHMAUSrMe
         +T3Qv0KMdwcdrhZRRoyzz/F+QZFfKIbXJbsJ0AF6Kz+qzstWzqtGnAcAGh80zOWBbCub
         +4NaTeW31J1iH5wwQf7TXyDVgSpFXsqU2LeA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cL/zNQffEbfWplGlqTueC7W+niUlPrnN8FmgiBSSyKY=;
        b=TQqD9sOVxeNX4NtoxiHEsC38X+O7+9mVBiqArCWrgKGkKyVwzcXY1+2mo8Zk+68FjV
         ZnLpiVBgOJPZpQ4TeIEXOZdxrsq9FpAbBsW/gz2+wtUAUQbWtHroJkygRaFEE/dbllf5
         C6nJmtpHDkuL6j6OqABX+IsqUPnU2hwAZVgS6pW4xmphoXPfo2JfhIbs0LYnIS2MM6U4
         z1+zJks2NhNVqWTKFrrRPThn1sWnyGMgFrpIgiuem7uCMvA4Pw1KbHpPGqtE0uElv29R
         TtbxghnR2EL7X09hrP6RiK6UpDJR7577WCjNi7FhiuRVg/qubYmpIDavlwBEnEAMlrqW
         HSRA==
X-Gm-Message-State: AOUpUlGjqnCaM0PEhsddgb6o1wrwsddRjpaS8SIR94+mumMXlMJT3F4Y
        4FD/IHruuOoX9iXIsot/jzxKgELH/rfRjKjLuqdFYLfv
X-Google-Smtp-Source: AAOMgpcaYddzVIg18Qi4rA2EdciszFAIIxcI+4KzHUx1pHa7L1ZyNM0qIVRsRNUPkJxKYDztphNBDfgpyl4oST0iTV8=
X-Received: by 2002:a24:5004:: with SMTP id m4-v6mr3119667itb.38.1532118728878;
 Fri, 20 Jul 2018 13:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180719114027.2722d075@canb.auug.org.au>
In-Reply-To: <20180719114027.2722d075@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 20 Jul 2018 22:31:56 +0200
Message-ID: <CACRpkdZffsC0RsX9Q72+AwWZynjBfTZ4=RE+o=HVd3H0yCdAgA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the net-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 3:40 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> After merging the net-next tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
>
> WARNING: modpost: missing MODULE_LICENSE() in drivers/net/dsa/realtek.o
> see include/linux/module.h for more information
>
> Introduced by commit
>
>   d8652956cf37 ("net: dsa: realtek-smi: Add Realtek SMI driver")

Thanks, there is already a patch for it.

I'm pretty grateful that this was the worst the integration testing
could find :) new drivers always make me nervous.

Yours,
Linus Walleij
