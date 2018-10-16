Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B972C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EF22086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32EF22086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbeJPRWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:22:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43192 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbeJPRWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:22:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id n1-v6so24628563wrt.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 02:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XpwMWF9wn2vBMVdm3IOvbkOiC41hNBD9inkuqet9OGY=;
        b=dg9fsKFIGwxU0eZAxfi6ZgErY9cPj3ckIK7hWNtroNi7zWsFxc7K59+JxLnqFafich
         RwUhxPwOeRn2b5z57d+jKhMPX72hVHvTzx8P+AJng7406PonEaGjPjULHm0ufChcyWQb
         IyN274bNgZvHXRkpQ9Z+uw7efpboFLKy25jV0Ja3BK+v80NNiZume3UktmcwdKlettAP
         5j1ah2BV5YudBo5aJ4pP8geFrDpBe4EUOzUQOYPw3CZnlevJReeYxidBn8yJrlWsz9Jv
         uGUIWwPrLtLN3DrShIOq0kpaMg82vwfeDqYwuGHk+VVUoCyKtEcWdvM1ugZ/Zg3ay4SC
         lG7A==
X-Gm-Message-State: ABuFfohlzx4VR3tEoJN2FEtGS+JLod0y9ZV7+cPlMfhUZxYfNVovfsuB
        nkRsMmVQmClJwP0PKjYD2+OV9g==
X-Google-Smtp-Source: ACcGV61OYhne2FlGRzNK7uQFiMSAdrJY60PJVyMGd6MYK2olF3loZ5etwaHlAoSkCZCl+VqvXYjB8A==
X-Received: by 2002:a5d:4cc3:: with SMTP id c3-v6mr18569511wrt.75.1539682356689;
        Tue, 16 Oct 2018 02:32:36 -0700 (PDT)
Received: from [192.168.1.13] ([90.168.169.92])
        by smtp.gmail.com with ESMTPSA id g10-v6sm11151014wrv.49.2018.10.16.02.32.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 02:32:36 -0700 (PDT)
Subject: Re: [PATCH 1/3] driver core: add probe_err log helper
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        andy.shevchenko@gmail.com, Mark Brown <broonie@kernel.org>
References: <20181016072244.1216-1-a.hajda@samsung.com>
 <CGME20181016072249eucas1p2303b8c06a9f7c839a971fe065b0c752e@eucas1p2.samsung.com>
 <20181016072244.1216-2-a.hajda@samsung.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <a0dc2316-fb5d-31cf-7e21-442a2968f649@redhat.com>
Date:   Tue, 16 Oct 2018 11:32:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181016072244.1216-2-a.hajda@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrzej,

On 10/16/2018 09:22 AM, Andrzej Hajda wrote:
> During probe every time driver gets resource it should usually check for error
> printk some message if it is not -EPROBE_DEFER and return the error. This
> pattern is simple but requires adding few lines after any resource acquisition
> code, as a result it is often omited or implemented only partially.
> probe_err helps to replace such code seqences with simple call, so code:
> 	if (err != -EPROBE_DEFER)
> 		dev_err(dev, ...);
> 	return err;
> becomes:
> 	return probe_err(dev, err, ...);
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
