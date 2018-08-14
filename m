Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD74C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E986921742
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhAktqwb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E986921742
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732787AbeHNQQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 12:16:47 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:47049 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732414AbeHNQQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 12:16:47 -0400
Received: by mail-pl0-f65.google.com with SMTP id t17-v6so8303274ply.13;
        Tue, 14 Aug 2018 06:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=00r0+pZd/yZzjbEaugaIaV+X09y1JZ1xui4xyDh+HVk=;
        b=jhAktqwbLYraKQG+YEttJei0iMWXFxVt7f7IIsvxbCGelAAwdZgvCnao9c6EJR1RpN
         Q3oGB/PXL1U8jpwhQQBOb2Bubbkxt+FGL+nMElj95nCY2bdJz01CejPYRcu2NhBZc/c6
         al2HBqE4cxdma5HlJ09XwUQ1zAIKLcu8748p4chcVLpFA4eilH97EOrZZ0VXO3gZQjvc
         oYLOLU+LjlOn3ckc/wo9XGtFrej0CE4C1z/hVJikZkoCmWt97CJwmV1qqjWWNck1spQG
         E1CtbEhzX37gcVBfTl0MkMRQpjW7K3HnWvtqY3Q8m7poc0QuG3UQsEY6kVkv4DtyzpAA
         opUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=00r0+pZd/yZzjbEaugaIaV+X09y1JZ1xui4xyDh+HVk=;
        b=grDddU9oomd8BZ5otgxNMEnegbSIClISwNwgrcE2zl1IpeBiPl8ZDqxQRnzD93u1qQ
         vt0UMhoq+8UXYupaM6IcziIMizZKFxKIw8KRfB6zAiN7xdKnHVKm2SC7lKAW9X4QOAYk
         K25o29LlyRM8VdyyC/2ORtbWdkftGal50OFw5gKFAEHeb20Ox9Tdye2Keu2xdS+/An4u
         N6U6FY/Z27H/s3FFAiMxlT9F5oj0+PT+oRgIob9sY3FMFGPhItFQT23l3pAJVXwaOvEv
         RcKlgfh0OJN/DwltMdgIiLTFe38gJKG0F71+woXJDnzRcTbfMyepwP0fZDdPYLyllDCz
         4S5Q==
X-Gm-Message-State: AOUpUlHVTxi587OkuZAWwxk2r4aJM1RQNvqdKbYKffL6zN1Ry1RAgacA
        jfN3Wss0sXoVxYi42xC87yEsNjee
X-Google-Smtp-Source: AA+uWPz104VqpHtnHSxA5SQvTpEN81rTz5rnTM5f1k1pBnUn4MF3glQ5JLx4x1vbfddKQXcE1Ha+1w==
X-Received: by 2002:a17:902:3a3:: with SMTP id d32-v6mr20615159pld.294.1534253375781;
        Tue, 14 Aug 2018 06:29:35 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id x80-v6sm45837366pfe.129.2018.08.14.06.29.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 06:29:35 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: watchdog: renesas-wdt: Document r8a774a1
 support
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <1534250028-15770-1-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ed09553a-c201-10bb-fcc8-2f66674eba92@roeck-us.net>
Date:   Tue, 14 Aug 2018 06:29:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534250028-15770-1-git-send-email-fabrizio.castro@bp.renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 05:33 AM, Fabrizio Castro wrote:
> RZ/G2M (R8A774A1) watchdog implementation is compatible with R-Car
> Gen3, therefore add relevant documentation.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> index 5d47a26..9407212 100644
> --- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> @@ -7,6 +7,7 @@ Required properties:
>   	       Examples with soctypes are:
>   		 - "renesas,r8a7743-wdt" (RZ/G1M)
>   		 - "renesas,r8a7745-wdt" (RZ/G1E)
> +		 - "renesas,r8a774a1-wdt" (RZ/G2M)
>   	         - "renesas,r8a7790-wdt" (R-Car H2)
>   	         - "renesas,r8a7791-wdt" (R-Car M2-W)
>   	         - "renesas,r8a7792-wdt" (R-Car V2H)
> @@ -21,8 +22,8 @@ Required properties:
>   	         - "renesas,r7s72100-wdt" (RZ/A1)
>   		The generic compatible string must be:
>   		 - "renesas,rza-wdt" for RZ/A
> -		 - "renesas,rcar-gen2-wdt" for R-Car Gen2 and RZ/G
> -		 - "renesas,rcar-gen3-wdt" for R-Car Gen3
> +		 - "renesas,rcar-gen2-wdt" for R-Car Gen2 and RZ/G1
> +		 - "renesas,rcar-gen3-wdt" for R-Car Gen3 and RZ/G2
>   
>   - reg : Should contain WDT registers location and length
>   - clocks : the clock feeding the watchdog timer.
> 

