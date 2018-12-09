Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C04DC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 04:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18F92081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 04:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCSRTjF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18F92081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbeLIE5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 23:57:40 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36299 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbeLIE5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 23:57:39 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so3463827pgm.3;
        Sat, 08 Dec 2018 20:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Y2GDco0ehD6goVqpg5LWLUV7W8+6TVXHcxQmBNgvRYI=;
        b=LCSRTjF0jDaWy7z8aR6u1ONSYb6BdboGQ1nDWK25gXkm4VH31t/he4EnyBOIrKOU47
         gSfLjlhAGTmYlV2vXjHg87w0FT1nHggGOwoecpI0EZYQ1HL7mGFnlFNkcnZ+a/AiwBn+
         WaW8QJO6lVVCdZiM0Qxr9n8+0rdDCDEj0WVXmzZatpF1AUvaGlNuSHQqmekEessX9mok
         G5nMuoevXRwgfzSLP1h9E312CRl63PLuKZPnaoA481q4g3bfgc5V4VYK/thMml51crRP
         cDzheVjIhJmoEJdEdhT4SeEs8N6XKaQifXBbEaiZ+/tnNjl3iXnQ0HRF3XqN8ilyV4oO
         MxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Y2GDco0ehD6goVqpg5LWLUV7W8+6TVXHcxQmBNgvRYI=;
        b=luEmNIdPyIFkaxh1EKh0PEmpX9ssepuanzUOjcX8/De6O4XoIfZkTNLrsFPYqlVwBt
         Wrycl3VPl5LC542xOtos+E+vn1NZGlnLX71Pxca6ZQwcDb1A+Z84yyjbNgsqIDEebfxa
         GzALYfCwr2cmwysrCf2Qdhziz2FcRJFjGvT9OB2Ji5SU6FS7Qa+r5a1HLCd8Z9+ehepl
         yoWYF5LLmv5aEhkzxFAWU/x4aFtONRSwl08fufuWmGLmKlxhd6akdcizxfikF0fUHH5X
         jdW8+L6FgsLU6pBFONmkUyzw89stK+ER6y/Ul1+SW81gNfRg3MbpQ59qamp8XrFr+N6U
         WPPA==
X-Gm-Message-State: AA+aEWar2LfKqWyAqwOs4U+DOggXOpSqqq4tIK6Q5tSsWibYCVXStIiO
        HNNxXPb4YOPkRDWqZnL9rJA=
X-Google-Smtp-Source: AFSGD/Unuo2RmnDwz1CLA72TtTvsvbfyJUaLH0JMb8CwT/2yBVLeJdMdC8vS3uVw6WDbtRRRaaZ0NA==
X-Received: by 2002:a62:f5da:: with SMTP id b87mr7987398pfm.253.1544331458221;
        Sat, 08 Dec 2018 20:57:38 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id b26sm14856715pfe.91.2018.12.08.20.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Dec 2018 20:57:37 -0800 (PST)
Date:   Sat, 8 Dec 2018 20:57:35 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        simon@lineageos.org
Subject: Re: [PATCH 6/8] Input: dt-bindings: tm2-touchkey: Document new
 keycodes property
Message-ID: <20181209045735.GG211094@dtor-ws>
References: <20181207105811.1831-1-pawel.mikolaj.chmiel@gmail.com>
 <20181207105811.1831-7-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181207105811.1831-7-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 11:58:09AM +0100, Paweł Chmiel wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>
> 
> Document new optional property for setting custom keycodes.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  .../devicetree/bindings/input/cypress,tm2-touchkey.txt        | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt b/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
> index dfb3b9f0ee40..3b54d997b8de 100644
> --- a/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
> +++ b/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
> @@ -10,6 +10,9 @@ Required properties:
>  - vcc-supply : internal regulator output. 1.8V
>  - vdd-supply : power supply for IC 3.3V
>  
> +Optional properties:
> +- keycodes: array of keycodes (max 4), default KEY_PHONE and KEY_BACK
> +
>  [0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>  
>  Example:
> @@ -23,5 +26,6 @@ Example:
>  			interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
>  			vcc-supply=<&ldo32_reg>;
>  			vdd-supply=<&ldo33_reg>;
> +			keycodes = /bits/ 8 <KEY_PHONE KEY_BACK>;

We definitely have key codes bigger than 255. Just keep them normal
ints please.

>  		};
>  	};
> -- 
> 2.17.1
> 

-- 
Dmitry
