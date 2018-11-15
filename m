Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E171C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3AD223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A3AD223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388516AbeKPBjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:39:54 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36607 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387922AbeKPBjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:39:54 -0500
Received: by mail-ed1-f67.google.com with SMTP id f23so7830201edb.3;
        Thu, 15 Nov 2018 07:31:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r23vuUYSkm+xrOBFBpa4pm48aNe/ztVki6Hbye5Iaws=;
        b=H39/8Jv84e0KZAMULioLz8PQY2+LPC/K27/xxkxFNdWWW0GEVSj+VH6ZPISiKexuo+
         Nv+JuwEzFxUH3Uy+OL424gMo25mwOU7RQTN5YxcB0aaveKeIsgwa1qAIEbSBC4z7yzAU
         2F18/kJHs06500pui5WkG2ZiKz8wer/99aApBhBaXjP+zfN1XWX9mIFLqH+ley10Kh9P
         Ydk1AF8GHIlDX+scZraTokPFfEnDNlMMTA5P3A89EwBAz/+QGs/55qjUQqSgFUpiyB/I
         +O11uk8SJdZHVI9NMWqjJ9bWqzs9pRqTNQ5psGAHRi08OiMtkT8kEpEqE+jv+cnaf2Ps
         YBQQ==
X-Gm-Message-State: AGRZ1gImKIglsje3COBpXDGENtqytvPdeh6GtXsHLxyOasJhtnocGuV3
        isd9j32Kc9FwHPYsAELyQLZyspVAqHU=
X-Google-Smtp-Source: AJdET5fWcFzJCrCkdUD8+mYKjeMwMz+YNdl3cyJwIVz//ACs7J2Ja25bBBBD2S5bKUiaU45O70RzVQ==
X-Received: by 2002:aa7:d597:: with SMTP id r23mr6126168edq.51.1542295894204;
        Thu, 15 Nov 2018 07:31:34 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id e53sm5635296ede.90.2018.11.15.07.31.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 07:31:33 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id z13-v6so21674322wrs.3;
        Thu, 15 Nov 2018 07:31:33 -0800 (PST)
X-Received: by 2002:adf:a599:: with SMTP id g25-v6mr6478270wrc.188.1542295893242;
 Thu, 15 Nov 2018 07:31:33 -0800 (PST)
MIME-Version: 1.0
References: <20181114082033.GA20712@arx-s1> <20181115151813.a27uov3zmgzjcerf@flea>
In-Reply-To: <20181115151813.a27uov3zmgzjcerf@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 15 Nov 2018 23:31:23 +0800
X-Gmail-Original-Message-ID: <CAGb2v65V82YFjOp5K9tZSrBW8epiPE+t0qU8o_v1CsOU1GM08Q@mail.gmail.com>
Message-ID: <CAGb2v65V82YFjOp5K9tZSrBW8epiPE+t0qU8o_v1CsOU1GM08Q@mail.gmail.com>
Subject: Re: [PATCH v0 0/2] Initial Allwinner T3 support.
To:     Hao Zhang <hao5781286@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 11:18 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> Hi!
>
> On Wed, Nov 14, 2018 at 04:20:33PM +0800, hao_zhang wrote:
> > Initial Allwinner T3 support.
> >
> > Allwinner T3 (sun8i) SoC features a Quad-Core Cortex-A7 ARM CPU, and a
> > Mali400 MP2 GPU from ARM. It is a not-pin-compatible quad core sucessor
> > of the A20). It's also known as the Allwinner R40 for In-Car
> > Entertainment usage.
>
> That series looks good, thanks!  The only thing that would need to be
> reworked is your Signed-off-by name, which (I guess?) should be
> written the same way than in your Copyright info.

And also the author name of your git commits.

Thanks
