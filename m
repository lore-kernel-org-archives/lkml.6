Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBBFC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EC72173D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0EC72173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeHUBzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 21:55:40 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39862 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeHUBzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 21:55:40 -0400
Received: by mail-oi0-f66.google.com with SMTP id d189-v6so28761490oib.6;
        Mon, 20 Aug 2018 15:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MDJgDI4/ORkXl8t16/4IVAho75K/5/8N4bdoJexbRfk=;
        b=aiSV/hDpunzdGa97PsXo6P9onVQxihF1tG9NLBGnNPofjZb5RyoduNg0xoFIDLETcG
         gz8KggOd2W1kleDCiiPhOBQmxW9a0PESTVYPDU9iPQgwbdG3aw3q9WCToUh2n6kSGm8t
         GoSL94sntZ0ZlTNRwfZXb0AMWAs03iguRDTco6YY1mCNAVcqF3At7fuiaXMvApOufhj6
         IAHACbOg4JTO7EWWUTe4Noo+f07bMVl72DjRrsZuu/GdW2umXNfWkdg2LqMrHZiksytL
         336nJGrtaa6bjYg0z3PixWRQi2+Wuo/9pR4CvihZ3fottTeVKSR1ub5hIMtgWsTlS/U0
         N8LA==
X-Gm-Message-State: AOUpUlGIoYc+xkx5jDvrmrUigEVxWACE3dxy9TNbMCwnZ0qGzRPLQeDf
        OZZirLbnkrIGDDxLXTSxxA==
X-Google-Smtp-Source: AA+uWPzoUPIVB+WcRezijAfrVbQP24xw+hD9z76wx2xGPzJtVfMJRaJhDa/dEdnznUBbn8SqNpY7rg==
X-Received: by 2002:aca:b154:: with SMTP id a81-v6mr17044095oif.34.1534804691461;
        Mon, 20 Aug 2018 15:38:11 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m203-v6sm17301344oig.42.2018.08.20.15.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 15:38:10 -0700 (PDT)
Date:   Mon, 20 Aug 2018 17:38:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.reichel@collabora.co.uk, mark.rutland@arm.com
Subject: Re: [PATCH] dt-bindings: input: pwm-vibrator: correct pwm-names in
 example
Message-ID: <20180820223810.GA1780@bogus>
References: <20180818195855.13429-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180818195855.13429-1-masneyb@onstation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2018 at 03:58:55PM -0400, Brian Masney wrote:
> In the example for the pwm-vibrator bindings, pwm8 is the direction pin,
> and pwm9 is the enable pin. The pwm-names on the vibrator node has these
> two values swapped. This patch corrects the values for pwm-names.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> arch/arm/boot/dts/omap4-droid4-xt894.dts is actual implementation for
> the example and it is correct.
> 
>  Documentation/devicetree/bindings/input/pwm-vibrator.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/pwm-vibrator.txt b/Documentation/devicetree/bindings/input/pwm-vibrator.txt
> index 09145d18491d..2731cbb7e8d7 100644
> --- a/Documentation/devicetree/bindings/input/pwm-vibrator.txt
> +++ b/Documentation/devicetree/bindings/input/pwm-vibrator.txt
> @@ -60,7 +60,7 @@ Example from Motorola Droid 4:
>  		compatible = "pwm-vibrator";
>  		pwms = <&pwm8 0 1000000000 0>,
>  		       <&pwm9 0 1000000000 0>;
> -		pwm-names = "enable", "direction";
> +		pwm-names = "direction", "enable";

As enable is required and direction is optional, enable should come 
first. So fix the pwms property instead. (And perhaps make the binding 
more explicit as to what the order should be.

>  		direction-duty-cycle-ns = <1000000000>;
>  	};
>  };
> -- 
> 2.17.1
> 
