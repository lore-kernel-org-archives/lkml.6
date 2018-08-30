Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC2BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8022082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+GjwikR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD8022082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeH3XYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:24:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40312 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbeH3XYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:24:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id n2-v6so9058180wrw.7;
        Thu, 30 Aug 2018 12:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=41sfE2PkA8neHir2b08g6PdESvsy1q5Cn6FWnvCfjpo=;
        b=m+GjwikRQSaxja1HxZxu9o4+I4PkG05PnU1V8ETZtdfIQSSalIOKs6hnlJT+JFTWTB
         IGVrUPDx+ya29KL1tuYPgDyZuyP4iH+bDmCjwhMkwwtqLYMXl6YhzIlc0GmDJTdQuY/N
         LierivtwvOsYQpcpRacMFht0Zc9OTVx6eXY8CK1904KLF4jXwN2MJLfhKcwDdaXp8xf9
         sojZKlY6HuNMOYB5KzJh/CNJnIX5aUjK6jT6HSb2v2oXkZuKCDNyFBO5ENycJ9fjQW7z
         hLxYM5bOqdGMXuRG6xrRXDpgsi4Z1h52vpi9sSlnhFW8HbPcTR+Goclu0aaXhIKIApuR
         iHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=41sfE2PkA8neHir2b08g6PdESvsy1q5Cn6FWnvCfjpo=;
        b=N5ftXbIoAlc4D9pEbyLhoWd5JBCecl4j0Oz/u8clO5kuh2U0mTwgTIgVndZWGdVimV
         TzP+HMqyyNujZtmLirWQnmGIVs9Hu4Y43lnpNW8w3hmmr/UoCk8WCuhCEqDIyXbFAn1G
         2Ja7f5Y+ibSsHIWOYeF3ZWZKMb46gyU4WSAWNCLqKix8Xq4MqxP/EZGIKdDrK2zKGwLG
         5tGBVb3ZIwPTfimKPT8Rz61DYn2hTdHXJE295nPLLW/0dg+Hk6odUnrfkFsgQvy2z2U6
         hj2p6OhCzIXiqKG+SpcVymVazx+n4wNCUMAvsh5zkyY4xpvsbu+wMzOOUvsvDSJJtHyY
         Xbyg==
X-Gm-Message-State: APzg51AY3NB8RCzJdGQkgDdE5bh7BAVuVQp4a9Xxa3pgefu6357GFH9D
        w81P3XtetJhOH3Wf552wcMg=
X-Google-Smtp-Source: ANB0VdZBkszzttJYLwE2LAMCxAy+gIBBwWQLWL30B2QYjx1LOxxntYXGNm68YGuc3tEtvLuhiyFxrw==
X-Received: by 2002:adf:8367:: with SMTP id 94-v6mr8485271wrd.258.1535656821813;
        Thu, 30 Aug 2018 12:20:21 -0700 (PDT)
Received: from [192.168.1.18] (bfv134.neoplus.adsl.tpnet.pl. [83.28.59.134])
        by smtp.gmail.com with ESMTPSA id 66-v6sm4554485wmw.34.2018.08.30.12.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:20:20 -0700 (PDT)
Subject: Re: [PATCH] leds: add TI LMU backlight driver
To:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
References: <20180829212032.GB15786@amd> <20180830082219.GA10133@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <c72eb0ff-b54c-4670-580c-e31625b3c275@gmail.com>
Date:   Thu, 30 Aug 2018 21:20:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830082219.GA10133@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Thank you for the patch.

Looking for DT bindings I can find the following

Documentation/devicetree/bindings/mfd/ti-lmu.txt,

which for LED bindings redirects to:

"[2] ../leds/leds-lm3633.txt",

but it is not present in the mainline.

Best regards,
Jacek Anaszewski

On 08/30/2018 10:22 AM, Pavel Machek wrote:
> 
> This adds backlight support for the following TI LMU
> chips: LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.
> 
> It controls LEDs on Droid 4
> smartphone, including keyboard and screen backlights.
> 
> Signed-off-by: Milo Kim <milo.kim@ti.com>
> [add LED subsystem support for keyboard backlight and rework DT
> binding according to Rob Herrings feedback]
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> [remove backlight subsystem support for now]
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
[...]

