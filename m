Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3704CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0475620859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFiLC/wi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfAODwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 22:52:25 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46747 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfAODwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 22:52:25 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so601656pgp.13;
        Mon, 14 Jan 2019 19:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hW3X2EuUQUHZMQO0rz72DWuUJd2W/dUQuPisu3YBPls=;
        b=VFiLC/wifBUQdfz6zeqxdDg85BqNR9XI0agkWzc52LoCqRykzqR6ABZTOid3a3QxXh
         8KpYQvy2I4Yb3cvilEp2HNWMfYw1s2Hegmr6FUdXLnrvs6MJln9ZVmHjRYlMWnybg0+z
         B4N9uRULVmy+1ADOLjl/ITsznAK9Q2s91mp/KP8ejk5GU5I7shO3CeT/BYksqI3Y7m6R
         dAmoElcXaqgPdJKYK1lmNui/3Z/rnBbZEZ/kdEj1ac3JzXdRuXdZ+CmaBKve6yWdOFOS
         UmAQfEoZy6jk0NoKh3M2VUhnIoWxYPyhGHXWBYK/QRTTO768PPkpRj6EogqqstVmsmEf
         /qiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hW3X2EuUQUHZMQO0rz72DWuUJd2W/dUQuPisu3YBPls=;
        b=JiDhJdFHhFg+hmEa/QHVB+4F8jLYBENZd9byKWvj2apB3/bc129ERKIHOMYtP2vyKM
         lJVdKzS6pO6kfBQYMlzy3jGQozQeT+acuyCRwk8olqANbonT99Q6ytAgvyz4C4oKwL8X
         yTMO1Gwd72Crs2GqgYuwDZjj3kYbK8l1dHHH2INrG+1cU7UdMCBVXXzWJfi+67uiQEoU
         XcioNB6M5kjAhC5ecY9k/6CFpNT1bEne5z/stPb0PQcRuUIG1Ugrl5KMCSRioGFrw8I6
         x2KeyEC/rCbt5oP33Kf048v8RwITil5cvdELUkYFLSUbc+/B7Z5co45RF99LEZBiCsuu
         MIPg==
X-Gm-Message-State: AJcUukd5FGZLmWQ4uQKjtkeDyt//6ieaIZxGAm9wk8R/Oem+cYRF7eMk
        0twepGSKEvDO4mMqBo/HtvOzwlHp
X-Google-Smtp-Source: ALg8bN4DFycsf6lIHleg8L8TKqJp3Bpc4Vwqr7+0V/l9YqwpN+hYmMCaqCsSKSk5QquIocRnyzhz1A==
X-Received: by 2002:a62:1542:: with SMTP id 63mr1912761pfv.230.1547524344135;
        Mon, 14 Jan 2019 19:52:24 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id g11sm2136595pfo.139.2019.01.14.19.52.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 19:52:23 -0800 (PST)
Date:   Mon, 14 Jan 2019 19:52:21 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Donghoon Han <nazgul33@gmail.com>
Cc:     linux-input@vger.kernel.org, Daniel Mack <daniel@caiaq.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V2 2/2] Input: rotaty-encoder - Add DT binding document
Message-ID: <20190115035221.GA151157@dtor-ws>
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
