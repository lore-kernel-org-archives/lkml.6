Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB0CC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C8521872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwMEniSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfAXPDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:03:04 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44619 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbfAXPDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:03:03 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so5486122lji.11;
        Thu, 24 Jan 2019 07:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NOTnQzirldv/j6RS7y9J1g28O7uVYBzQuzIiUJdNbzI=;
        b=NwMEniSbvX7kRyW62QIKxUFn+1nZRmS0Wu6S/uUlw7ZE/oagCT2PF+QEB/4zWb3/DH
         TTZ+egnoZpv38hUqwgxqYVVUeKcaLm+7RnFIWitBhFuELKn1AUfoCydGiTQus5Hd7kKN
         shFIMJXzJZQGsRLoz0H/r6OYoyb1izm6Zp3tz10fNgs2Qap/TTbhqLsIYaFQtG97uAYP
         wDFrx07+nb1+2DtmXHT5ApQpd7e4L0MwRZQ2U0VSO3xEr/XEkWXWtG63r5n4M6efOAxE
         RyBxXilG4IBLY0SF3dQNoFz7K0xy5fiFNe0i4cpA0YsrLNsPi9VhU+CB3XBbkCKyXTJt
         DAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NOTnQzirldv/j6RS7y9J1g28O7uVYBzQuzIiUJdNbzI=;
        b=Tl1cCrebKFPil5uW31Z4ydAoHaIquCCdB45hzpIfDRm3iLacTNvJkm3fQ3auccO/nx
         Fz0xIL60LjuilwNStCbP6mScQfAtUKeUD7x+f/YFE+iqBRHDXDLU6EXssjCN18zTobZ5
         ROGu2BSVua6cFdAHBHmjUdkJ+d0BXlLLb6Ynv3M2ucS43H+ODuROmjqeRoqTv2SXyEXG
         KV/ZZPxd0ozEix5kJu67yK1zhO0Zs48U/h6oac3Q8CIVgBxtY8meR+g9F87Z5gFE5To8
         Sl0xiIrf9ENtLdJorviLmH6PbwcNSwxzVpK/z+w8l12T4JAN6kb1Wb4LvhKI+VEUvTAY
         ThXQ==
X-Gm-Message-State: AJcUukfATGaA9bndBBQfbc1PqJBQE568+SiqTLoC6IA/8EtgpLPYsEHS
        8t48rOQdP5KT/XDX7cxg1R6yutXBa7k7WRUsMFQ=
X-Google-Smtp-Source: ALg8bN78d3dSbJHQMQAVl2DXmHjYUPWHZKwj6eucmn1rrZlMsXm91eGzSN2mUb+BAm7ZbnYZJwat1wpY5SRakw8pkBs=
X-Received: by 2002:a2e:5747:: with SMTP id r7-v6mr5745010ljd.141.1548342181161;
 Thu, 24 Jan 2019 07:03:01 -0800 (PST)
MIME-Version: 1.0
References: <20190124145309.21698-1-ben.whitten@lairdtech.com>
In-Reply-To: <20190124145309.21698-1-ben.whitten@lairdtech.com>
From:   Ben Whitten <benwhitten@gmail.com>
Date:   Thu, 24 Jan 2019 15:02:49 +0000
Message-ID: <CAF3==itJFVUfPiS5prm0RdQMVb4vXoGPfQj8BHCVPT9DgmW2Aw@mail.gmail.com>
Subject: Re: [PATCH v3 lora-next 0/4] net: lora: Add documentation for SX130x
 and SX125x parts
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Whitten <ben.whitten@lairdtech.com>,
        linux-lpwan@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missed linux-lpwan

On Thu, 24 Jan 2019 at 14:53, Ben Whitten <ben.whitten@gmail.com> wrote:
>
> Hello,
>
> This series adds documentation for the SX130x and SX125x chips.
> We are using the yaml binding format and this series builds with
> 'make dt_binding_check'.
>
> This series is split such that the basic documentation can be taken
> without clock components, as there is an ongoing problem running clk
> over spi backed regmaps on certain spi controller drivers [1]
>
> Thanks,
> Ben Whitten
>
> v2 -> v3
> * Added the clock input and output names
> * Limited the radio-spi node children names to radio@
> * Fixed fallback compatible for SX1308 -> SX1301
> v1 -> v2
> * Dropped reset-gpios, radio-spi from required.
> * Dropped spi-max-frequency from binding.
> * Changed compatible to allow fallback from SX1308 to SX1301.
> * Wording changes in commit and descriptions.
> * Dual licence
> * Incorperate Robs comments on child node and spi wrapper
>
> [1] http://lists.infradead.org/pipermail/linux-lpwan/2018-December/000063.html
>
>
> Ben Whitten (4):
>   dt-bindings: lora: sx130x: add basic documentation
>   dt-bindings: lora: sx125x: add basic documentation
>   dt-bindings: lora: sx125x: add clock bindings
>   dt-bindings: lora: sx130x: add clock bindings
>
>  .../bindings/net/lora/semtech,sx125x.yaml     |  77 +++++++++
>  .../bindings/net/lora/semtech,sx130x.yaml     | 151 ++++++++++++++++++
>  2 files changed, 228 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/lora/semtech,sx125x.yaml
>  create mode 100644 Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
>
> --
> 2.17.1
>
