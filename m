Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA94C169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1AB20881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="mqZ3RaxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbfA3D1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 22:27:13 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34197 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfA3D1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 22:27:13 -0500
Received: by mail-qk1-f194.google.com with SMTP id q8so12945021qke.1;
        Tue, 29 Jan 2019 19:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tryZkG1b0OOMU3opyrQRs9lUM6ZpHAug1gUo09Q4LbQ=;
        b=mqZ3RaxGJf0I6S7YH0+BCdWmnKDFwLMul6X9xVIEypnqwSfbwGSp9QWYk8oomNbtN2
         m4PA2GKRHGi1JlJP+R+QZFMc/WfcEZmlMxXZjL66bii4v7atS+PNbbEhB3m8j+vyrZft
         waIM029yT8Ydg5gZoWqaxUS/NTCBB81jNTxRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tryZkG1b0OOMU3opyrQRs9lUM6ZpHAug1gUo09Q4LbQ=;
        b=Gl+yqS3xlkG/hlvPzO0L1ENJ9NPET0XHEM4ZMl5qzJPEL2Y0RPLJCwBlEDencgcUAV
         VO0+MLBgUMyu/0LX9BhGZ294t4N/R5jQU5t2Gg/ZJlVaAQ1F5KE8CW3NfcWPu207X6EM
         g+m5ExF6malXOpf2vyhGxyayDAy98Pg2NJnYRuTGQAd7ImBInYI2TF3//UgoNd3FJAIB
         A8az4/CSaRpatJKYFkkgjX9GvOVft/apr/4TrzxIj+qciakWnGG8X1yzN8We4aZQm4wr
         WAhsfAv01bHaaAqy5XH86fom2Fbioji8fFlC1zZ+K55/pzAg/vRRUTx3/RxpjlmI9JCa
         vStQ==
X-Gm-Message-State: AJcUukfewC8DLM589OmiFnJGyGu73ha4yP8YfyMkxZAVtc32bnD5wMab
        ir7cmhK8AROCHiSUpU9uCY/TXsp2ESDmnapPjuI=
X-Google-Smtp-Source: ALg8bN6VVbtR7psR0gbQFYO2JTPBCIwNB7xYBro8ejws2cyBvtvwN+ijOPde+6LF7jy35U4UFbgeqiZfgZfhQG8X6hg=
X-Received: by 2002:a37:a391:: with SMTP id m139mr25487860qke.11.1548818832043;
 Tue, 29 Jan 2019 19:27:12 -0800 (PST)
MIME-Version: 1.0
References: <20190123230733.1821501-1-vijaykhemka@fb.com>
In-Reply-To: <20190123230733.1821501-1-vijaykhemka@fb.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 30 Jan 2019 14:27:00 +1100
Message-ID: <CACPK8Xc91m9TWoRSgDCT7bVJC=C=w7mse8xbdCgw5vMVgMXM=Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: aspeed: Add peci and lpc for Facebook
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019 at 10:07, Vijay Khemka <vijaykhemka@fb.com> wrote:

> index 73e58a821613..d60dbb019f82 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts

>
> +&peci0 {
> +       status = "okay";
> +};

I don't think we have an upstream tree that contains a node called
peci0. Therefore this does not build.

I have dropped this hunk from your patch. Please make sure you test
before sending patches.

Cheers,

Joel
