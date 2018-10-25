Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E65C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B8820834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2aHGGMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B8820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbeJZBwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 21:52:41 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39463 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbeJZBwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 21:52:41 -0400
Received: by mail-ed1-f66.google.com with SMTP id e5-v6so9212221eds.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 10:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Aq+9ZbCS0gMvoTxw1ySnPSxot32FKp9r30wjIYrqhYI=;
        b=Z2aHGGMporiwu7F43YeagQi4RBstNzAo+Y1vf0Rn9h5zUYXnvz7qGSFVubQX/rwiLH
         OyMO0e/ywOPq478Es3ngrBm6W452zuYteUl3THEVUY1hBqtVZwXqkro6ul9PrII3ZTcX
         pmSwiGQgorwrbWNH/VNdyw13ufbra94ZznYFA1ckVzQOlpY9aoxLuvFpDK1UZFAO1SY6
         3c1D/bGP8mlu0wf9P+DltM1xQ+pV7hZ6+nhoAdue0S/CSnebe53js2oY1lJwbsM7Dg88
         cI1EsA8jnTCpLn4gxtAXr6tlquOlFavAVwc0MWurpyRo1qiWjrUQnz4gzJezup/EPVW4
         4h+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Aq+9ZbCS0gMvoTxw1ySnPSxot32FKp9r30wjIYrqhYI=;
        b=Lhf1+RGi65XtH3cE1qsL1XlHh5DKWt5PlSSJGwG6YIguh5OqrUlqUc2ekoPpFV6DRI
         DpdTBsBEjBkb4IYKx0NzRtxeXQF0iwXO+J9/Oy9Sph/4gSMekGISk8uqXc6uSg+McuKs
         vYEQZYq6JcG0JDHMRiue5k0fyhFGIh3ATy4Zd1rM6T7P9Xi6UxB/KExbUlihxT1HJOjD
         P5TqXf0PioX11QT2IKITLyvwwS2nHGX62c+ImysqfGOIzU6C9WnEWFIQzcqa1i0Q19Jb
         Pws67zZf6bJD3/QjreoY7ijWFO58YhGjwt+EbEKnwDG44pAdm8iSkQ20r7R6PBiYVZR3
         HndA==
X-Gm-Message-State: AGRZ1gJVxSc0dg6JMY9XvKikayROjUniih6XPcqblbxTM0Sf7V+K0uO9
        QvIy1NSuzhK90nFHc2UIzyU=
X-Google-Smtp-Source: AJdET5fd4qEK+ooeDgrsofC4HN6A3Raf9kz6dRZ1pAnUH5VzfpNBha/U7sobkg/tzIeGgGkTyrSBEg==
X-Received: by 2002:a50:c31b:: with SMTP id a27-v6mr87470edb.160.1540487938154;
        Thu, 25 Oct 2018 10:18:58 -0700 (PDT)
Received: from [192.168.1.3] (x4e334e22.dyn.telefonica.de. [78.51.78.34])
        by smtp.gmail.com with ESMTPSA id c18-v6sm1738972ejz.68.2018.10.25.10.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 10:18:57 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v2] staging: bcm2835-audio: interpolate audio
 delay
To:     Takashi Iwai <tiwai@suse.de>, Mike Brady <mikebrady@eircom.net>
Cc:     stefan.wahren@i2se.com, devel@driverdev.osuosl.org,
        alsa-devel@alsa-project.org, f.fainelli@gmail.com, eric@anholt.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        julia.lawall@lip6.fr, linux-rpi-kernel@lists.infradead.org,
        nishka.dasgupta_ug18@ashoka.edu.in,
        linux-arm-kernel@lists.infradead.org
References: <20181022191708.GA4659@ubuntu>
 <a703f8a2-e85a-bc5b-750a-cc43ef252ba5@gmail.com>
 <EA85FEC9-B1C7-4548-88F5-F0E7BC12158E@eircom.net>
 <046aea96-e0d3-60f4-c61a-c26bb1b5c193@gmail.com>
 <B9A84822-3780-4E01-96AD-FD3B42C44B45@eircom.net>
 <9884c4f5-2343-e3a4-8d8b-dd2db404ef27@gmail.com>
 <s5hftwuo4t0.wl-tiwai@suse.de>
From:   Kirill Marinushkin <k.marinushkin@gmail.com>
Message-ID: <5bc8295a-1e38-99b5-d54c-72e920600f83@gmail.com>
Date:   Thu, 25 Oct 2018 19:20:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <s5hftwuo4t0.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Takashi, Mike,

@Takashi

On 10/25/18 09:37, Takashi Iwai wrote:
> Well, in the API POV, it's nothing wrong to keep hwptr sticking while
> updating only delay value.  It implies that the hardware chip doesn't
> provide the hwptr update.

Thank you for the clarification. Modifying `runtime->delay` from the `pointer`
function looked wrong for me. Now I understand the motivation and the use-case.
I will be more careful when analyzing the code which doesn't fit my expectations.

@Mike

I was wrong. You can ignore my comments. Please don't take them personal: it's
all about having high-quality code in kernel.

Best Regards,
Kirill
