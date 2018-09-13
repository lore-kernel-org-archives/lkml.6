Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC28FC6182
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 22:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B7820839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 22:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRmOaouQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B7820839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeIND3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 23:29:30 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:46567 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeIND3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 23:29:30 -0400
Received: by mail-pg1-f177.google.com with SMTP id b129-v6so3374042pga.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 15:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xoA6dwtO+fWSjg6LpUmCF3LrUb1ClAnGUUhGiXsDd7c=;
        b=jRmOaouQkxcyepGE8236h+gy3MGqIZJjXivJcUUFG7TV8emAjhRi97n0Ww7+CrWHUN
         5l6N8sn6vXJXXLK4T5PP00JTxd/jmJqrSj7XYw/xVi55KWi0XaJiCeAUycsIB4s5XKSy
         oflvXodkuLlLvoIj4CJOI7Hy1HJEMTk6EH5g7kLLOKklKtz9JuSyrIRwn5bWFSxMWSTY
         eDpK6wZR2ZMpV1sqjgYIM3jxlQx8bJv9cgCWYrWA7eos9OrTFYcDc/SL78Mj59FyYD3n
         iZ3W3vHzVCJ6Febskwm4MCwgMDWs6SUEl0SP5C8EzFZWz0bwV2nHqXQR3Wa68YvWbBAv
         mGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xoA6dwtO+fWSjg6LpUmCF3LrUb1ClAnGUUhGiXsDd7c=;
        b=XAac/kmP9dGKbI+uuJcxObubCr1kjujk+qEdVJGrWxiG/ThcdxYI1IOgs7rCpBAHMW
         Wa/3I4REHEf1hh0CVM8QJcL7p5Y+GFyIvxTQeHM+9MCYd6L9xqDK9eLZIPMoQpBhS97n
         rE4Qu1ZpChcsqgAp36jTt/o1JTBmc8sxO3wyny5wmOKlzRevLKZA9YInjFOIpFcvDseP
         U+tnwS3VP1NjkujRdkhA6XT5xLvFpvkfjz4s7lf4dG8/nUOCNY7U8EPw21JTi2MyiczO
         rHKPtBn3Spv6jN1yr8FFCGg9NJzkpm7+qWKC1EnE4gm/duNgNZaWqWEKPABKNP1lwMm0
         TNQw==
X-Gm-Message-State: APzg51Baph5u82G6XMzwlc+cDkCTQM+T0IFo5hHw5IduUN2vPID82bOk
        uJxzedVyLGCjV7Zgfv0C7Oo=
X-Google-Smtp-Source: ANB0VdYoZEkpdoOcCcYIFJJrOFfnhYw3aRO2zvO4Oh597L1jR3T0Kk7KtslmFB6CLKx2DkhKkMTNKQ==
X-Received: by 2002:a63:6446:: with SMTP id y67-v6mr8992455pgb.443.1536877084261;
        Thu, 13 Sep 2018 15:18:04 -0700 (PDT)
Received: from [10.0.2.15] ([192.19.218.250])
        by smtp.gmail.com with ESMTPSA id g5-v6sm9570681pfc.77.2018.09.13.15.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 15:18:03 -0700 (PDT)
Subject: Re: [GIT PULL 2/3] bcm2835-dt-64-next-2018-09-09
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Eric Anholt <eric@anholt.net>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1536817833-3900-1-git-send-email-stefan.wahren@i2se.com>
 <1536817833-3900-2-git-send-email-stefan.wahren@i2se.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6b7d2a13-8f41-414d-0f00-58b130bc12c2@gmail.com>
Date:   Thu, 13 Sep 2018 15:18:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536817833-3900-2-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/12/18 22:50, Stefan Wahren wrote:
> Hi Florian,
> 
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/anholt/linux tags/bcm2835-dt-64-next-2018-09-09
> 
> for you to fetch changes up to a7eb26392b893bff92b1eb6483f4af3d2eb19510:
> 
>   arm64: dts: broadcom: Add reference to Compute Module IO Board V3 (2018-08-31 07:01:34 +0200)
> 
> ----------------------------------------------------------------
> This pull request brings in the arm64 reference for Raspberry Pi Compute
> Module 3.
> 
> ----------------------------------------------------------------

Merged into devicetree-arm64/next, thanks Stefan!
-- 
Florian
