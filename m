Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74890C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407702147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548699498;
	bh=bRduOgBOqalsBgQKBzn1a1RWVbORbIm3YHQyajgmcRQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=u8o+RruS/E1tVwt7CAST8DH9Oabj0n6fQlDxQRcZYeNsbSJ3X7ddSiC0bJBWyH0RK
	 +WF6B8VJcpOUel/tXhTqqRB+1jhrapkJhTyH7yiZT0hcavfUqz43/9F2a04dFPbMga
	 KQKzncgd1K5sRBuw7Npt4ayt2IjYKDaNZeJrd+mk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfA1SSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:18:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:56614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfA1SSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:18:15 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A82E0217F5;
        Mon, 28 Jan 2019 18:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548699494;
        bh=bRduOgBOqalsBgQKBzn1a1RWVbORbIm3YHQyajgmcRQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jdxkaTZFIU5T9Vma3uHBNK6UgYKFbk6BbgGWLFGFOfSLwynzi+rh/9j4TMeOxHDHQ
         icNKJ5iBySQStCLqziQqhqquF0Zh3KZGWrM86Nq+J8xQFmS/lS9wQoitojezO467D7
         lZJWbYGI+DPFIfnlRNDCaln0O3E8bYjjqPbwvWJQ=
Received: by mail-qt1-f177.google.com with SMTP id e5so19271401qtr.12;
        Mon, 28 Jan 2019 10:18:14 -0800 (PST)
X-Gm-Message-State: AJcUukdPeSHfVufPCTPUsTDunzaQC0iMECpX1VvB0DNXKjoUuQ0DYWUo
        2EF3r7i9qqm6CZJlZzMe9HkeyO9jkHGIT7XzKA==
X-Google-Smtp-Source: ALg8bN4Ntlk8i/wgo1VZ+1sn49dOQlITbrZzEKuGdh70nlV9+1mashNEE8Oyvv0NB5U77Jgac2AvYMNnJP49nBPwL0w=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr21786899qtd.257.1548699493852;
 Mon, 28 Jan 2019 10:18:13 -0800 (PST)
MIME-Version: 1.0
References: <20190124145309.21698-1-ben.whitten@lairdtech.com> <20190124145309.21698-2-ben.whitten@lairdtech.com>
In-Reply-To: <20190124145309.21698-2-ben.whitten@lairdtech.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 28 Jan 2019 12:18:02 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+nMtGaWJ-Gty0wMY6TL=aDqf9+ok40MXitw2ecMyoOWA@mail.gmail.com>
Message-ID: <CAL_Jsq+nMtGaWJ-Gty0wMY6TL=aDqf9+ok40MXitw2ecMyoOWA@mail.gmail.com>
Subject: Re: [PATCH v3 lora-next 1/4] dt-bindings: lora: sx130x: add basic documentation
To:     Ben Whitten <ben.whitten@gmail.com>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        David Miller <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-lpwan@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 8:53 AM Ben Whitten <ben.whitten@gmail.com> wrote:
>
> From: Ben Whitten <ben.whitten@gmail.com>
>
> Add basic documentation in YAML format for the SX130x series concentrators
> from Semtech.
> Required is; the location on the SPI bus and the compatible string.
>
> Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
> ---
> v2 -> v3:
> * Corrected fallback notation
> * Limited radio node names from anything to 'radio@'
> v1 -> v2:
> * Dropped reset-gpios, radio-spi from required.
> * Dropped spi-max-frequency from binding.
> * Changed compatible to allow fallback from SX1308 to SX1301.
> * Wording changes in commit and descriptions.
> * Dual licence
> * Incorperate Robs comments on child node and spi wrapper
> ---
>  .../bindings/net/lora/semtech,sx130x.yaml     | 101 ++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
