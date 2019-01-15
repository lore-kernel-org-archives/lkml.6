Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDF7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2FC20859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQLLTkHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbfAODxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 22:53:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41593 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727449AbfAODxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 22:53:38 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so638611pfi.8;
        Mon, 14 Jan 2019 19:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MjCT1JTEc6z+qPMMjeY3ggVzvTZxUhkgRfCYqvqYwNk=;
        b=hQLLTkHabYCmDZo7dj9T7UW+/cCDlNHDLPreU7T/DCN2+CM50KtTakL0N3dyNdiCmg
         EhacgVxnsgHeDS9jaPsSJe/IBtiXNx8D0TAK7K96xW+342LU0hPvgZmNltV9v3+1xDQr
         yvsdcDTl6wEqkh9mbZn1jWV1/yRpK1N26C63eZn1Tw2DoiDwW4CmUh7jVb0MYbCTLrYg
         9fzFSw2OT8wYiuccrxlVTYUv5KS4V08Cx1mfqXBFIxr5xGzJY7oHCcnpuqd7/7htnJtk
         KwP6pwWUBvvQp9O9IxwiKrNWNS9f/cL31+brEPqpJB4H/K8JVJZp41HZoF/xN9Gx21hr
         Vqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MjCT1JTEc6z+qPMMjeY3ggVzvTZxUhkgRfCYqvqYwNk=;
        b=MSfNr7gP+n7xIYSsHP5ar5PppOx8oJv4GqhPdT6LMz38ZIswe+Aznh7ai8wt0ra6fT
         RZitMF42Vi9PDaiiv4qlFjNXx2ME8WRwQfhQFvHLPZmU50dqb9rrgG58rfJsbS6kcVuH
         7VjgdBpjCUKUWb4P0dDOGxBs2hNpB/Ma7wTxnHAbHxEzjcvWLhLBcOMPoXqPCAfLnatO
         v31i3FAE3eBMqKKAoRK2I832DPOSgOXD5Jk0WoLw5+UBCQ67meeMdbVAEh8nxWlW1Xwp
         Q0xkc/bJfAanrdRFuY3xa4XEpWhUTm0X2MydxJCL/hXlR8VKgkxVN0T8OqSNHkz5qnIP
         PxVA==
X-Gm-Message-State: AJcUukfSFolfBKYMEOQS4OW+iFtk3n8ufbTvDT3TU5wYD8Y3K7iuRqhe
        5BpZXJHbrj6KQLAGsBOUU1o=
X-Google-Smtp-Source: ALg8bN5TWruVUWdfmWcujGbIAsbsqo0jO+jrsdI1pHGhP/iAEZ1pSc1TsWy9Cv6B4J8BFZqvznrijg==
X-Received: by 2002:a62:ab0d:: with SMTP id p13mr1875787pff.211.1547524416918;
        Mon, 14 Jan 2019 19:53:36 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id t24sm2565771pfm.127.2019.01.14.19.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 19:53:36 -0800 (PST)
Date:   Mon, 14 Jan 2019 19:53:34 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Donghoon Han <nazgul33@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-input@vger.kernel.org, Daniel Mack <daniel@caiaq.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V2 2/2] Input: rotaty-encoder - Add DT binding document
Message-ID: <20190115035334.GB151157@dtor-ws>
References: <20190107164249.2342-1-nazgul33@gmail.com>
 <20190107164249.2342-3-nazgul33@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107164249.2342-3-nazgul33@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ resending to Rob... ]
On Tue, Jan 08, 2019 at 01:42:49AM +0900, Donghoon Han wrote:
> Add DT binding document for rotary-encoder, keycode options.
> 
> Signed-off-by: Donghoon Han <nazgul33@gmail.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Daniel Mack <daniel@caiaq.de>
> Cc: devicetree@vger.kernel.org
> To: linux-input@vger.kernel.org
> ---
>  .../devicetree/bindings/input/rotary-encoder.txt     | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> index f99fe5cdeaec..9986ec2af2d4 100644
> --- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
> +++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> @@ -12,6 +12,10 @@ Optional properties:
>  - rotary-encoder,relative-axis: register a relative axis rather than an
>    absolute one. Relative axis will only generate +1/-1 events on the input
>    device, hence no steps need to be passed.
> +- rotary-encoder,relative-keys : generate pair of key events. This setting
> +  behaves just like relative-axis, generating key events instead.
> +  (Keycodes[2] corresponds to -1/1 events.)
> +- rotary-encoder,relative-keycodes : keycodes for relative-keys

Given that keycodes are linux-specific, I think the property should be
linux,keycodes. Also, I am not sure we need separate
rotary-encoder,relative-keys property as we can infer that we want to
generate keys from presence of linux,keycodes property.

Rob, any comments?

>  - rotary-encoder,rollover: Automatic rollover when the rotary value becomes
>    greater than the specified steps or smaller than 0. For absolute axis only.
>  - rotary-encoder,steps-per-period: Number of steps (stable states) per period.
> @@ -48,3 +52,11 @@ Example:
>  			rotary-encoder,encoding = "binary";
>  			rotary-encoder,rollover;
>  		};
> +
> +		rotary@2 {
> +			compatible = "rotary-encoder";
> +			gpios = <&gpio 21 0>, <&gpio 22 0>;
> +			rotary-encoder,relative-keys;
> +			rotary-encoder,relative-keycode = <103>, <108>;
> +			rotary-encoder,steps-per-period = <2>;
> +		};
> -- 
> 2.17.1
> 

Thanks.

-- 
Dmitry
