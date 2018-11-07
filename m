Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6F4C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DECC20892
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wbs+hn/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DECC20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeKHGRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:17:45 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34770 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbeKHGRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 01:17:44 -0500
Received: by mail-lf1-f68.google.com with SMTP id p6so5466422lfc.1;
        Wed, 07 Nov 2018 12:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kxxp7oTVnelFCu69L9l5id2ZBhf0fxKkX46WlsbSjcE=;
        b=Wbs+hn/8mfHH0pcweFiXH7mvkXLly2wcUVRRJgSWPL0V2MleuxuhaINqJ/A1Ntg/X2
         ZK+8qcikfTLfHDicEtmAqAnA8VYfRI4wNiSGq1p1ckmPDdAc9eBziMpogcLHvEuGE4mp
         yrhXWiSQoO7w7QWnvryaI52aM6AHbwhbpMa+WfjIIS3CW9CILZ4tuGCAPfTeQYw2D6Xx
         bhayW3s6w9suu0MHCp9aKGzfaK5iG3iNRT1IJqADDhgIR2dWM3Hj5TWRkd2LiG8Tzmww
         6PH6CKEhDj66g4AeQK+yGSAOV3T3vvhqVSh4hQW/Qbcqh+n/iVHne9H8oR2LhXHoc7qh
         qRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kxxp7oTVnelFCu69L9l5id2ZBhf0fxKkX46WlsbSjcE=;
        b=XjZlBiu61OzHUjZHy4m8Ik/ZRTMaKB/1eWo2VSbKn4SUdvNKR+7ns+jsBGaWhc1exq
         SxN6tuSSv7grUJ/883qBNF+lYPy3+5GITDqjRkuiezYf/O9xTMlIrjTKTqk4NhGqLn6f
         IHQGrOyC5zhYm5oN7aEOXSvUFmCGAXDu/Jom4OtLUdOwd8ESKFLWR//kpce6RS2TMIgx
         YCLXRSabDJsz597j7nVGEFPNQxD0OlJx/8TNsMJngNggp9DJrPKoRFIYt44CDMXD6+bs
         T5rZB6wQWs6ma923YJHnDDQ7usV+acrn6cn5lO1/RqKj/eYrE74s7oGSwQ6IoOF5y7aL
         tJSA==
X-Gm-Message-State: AGRZ1gJvO4YquMMClNwJWpmJhjgQDALo8hLjFTelmjW0307+9KoQ6pNQ
        jv06Qul7ijhnQdGOA72U+N/LHwOYY1+G+A==
X-Google-Smtp-Source: AJdET5cT4InIGdlApCGw92QMzmccrvbwU9dWjqcU0i16PzONzP1GZCq19vcH3jof8JU5i4Na4hj4rw==
X-Received: by 2002:ac2:4354:: with SMTP id o20mr1046925lfl.129.1541623537927;
        Wed, 07 Nov 2018 12:45:37 -0800 (PST)
Received: from [192.168.1.18] (dnl153.neoplus.adsl.tpnet.pl. [83.24.93.153])
        by smtp.gmail.com with ESMTPSA id b20sm286775lfj.61.2018.11.07.12.45.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 12:45:37 -0800 (PST)
Subject: Re: [PATCH trivial] Documentation: ABI: led-trigger-pattern: Fix
 typos
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Baolin Wang <baolin.wang@linaro.org>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181107134524.13989-1-geert+renesas@glider.be>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <58507e6b-a1a9-c1ff-e469-11611ba7e8ab@gmail.com>
Date:   Wed, 7 Nov 2018 21:45:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181107134524.13989-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 11/07/2018 02:45 PM, Geert Uytterhoeven wrote:
>   - Spelling s/brigntess/brightness/,
>   - Double "use".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/ABI/testing/sysfs-class-led-trigger-pattern | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
> index fb3d1e03b8819bb9..1e5d172e064624d9 100644
> --- a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
> +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
> @@ -37,8 +37,8 @@ Description:
>  		  0-|   /             \/             \/
>  		    +---0----1----2----3----4----5----6------------> time (s)
>  
> -		2. To make the LED go instantly from one brigntess value to another,
> -		we should use use zero-time lengths (the brightness must be same as
> +		2. To make the LED go instantly from one brightness value to another,
> +		we should use zero-time lengths (the brightness must be same as
>  		the previous tuple's). So the format should be:
>  		"brightness_1 duration_1 brightness_1 0 brightness_2 duration_2
>  		brightness_2 0 ...". For example:
> 

Thanks for the patch.

Applied to the fixes-for-4.20-rc2 branch of linux-leds.git.

-- 
Best regards,
Jacek Anaszewski
