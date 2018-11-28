Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791F3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEF62081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aitKZSEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CEF62081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbeK2IvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:51:22 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47030 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeK2IvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 03:51:22 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so10802745pfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 13:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fMzQs1T2YHojEpjr1RYaT5RiK9bTBU7ADy8t1EE0gEU=;
        b=aitKZSEYkNWimjssX6UX2ckmhM8qvkTerrI+rwrntSdIvQU9XKL/o/fsTUJHtVZ6GG
         9YgU8MUERItWBCDbPeiVxMcTp62UxZDS9vKAlC50QWsZhm7zmCbiXwsbEk2QePhiChIP
         mN+cbENC4XRmJl8DqIA0+1ZPS0bVv2aBnSwNbMpPodV9BBhjKLT2VSy/qFvotCtFxyr6
         MBHk4O08Il1acRZ8RD1OtXsavw7l6UVgjycfGNq/XWIcP07TMj/RFeCmQ8gj71kz9pyj
         EyCmxngbyLDv3Y5yQC0Tq7vV9NzSy/6fPD2ywUdV1Pbtw8vhsPzxcugvgriM65X8iRAK
         Yc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fMzQs1T2YHojEpjr1RYaT5RiK9bTBU7ADy8t1EE0gEU=;
        b=qH77wnGrKjY07GNJpkfH4FpvqMnmBZt4tqkalqmb2QYSqr7HDKnHqC96WTb/S/yTal
         e0VyA/+M8AFZL1d7PGzKetDBBt6GqticiSh+qW6ZmHFCoJU98Ib2hA21FxvVhQEt01wC
         iT5rmjsiTPXCSR0D+pqPJ2a7x5niLm8pKuTa0LLu3jNe23SKEitSBWuCfG4dM6k8FRGC
         tiU2CVvTkWcigyCtrRJQQ3MTHfMy7Ni6Mdy6U5YRYhrSIo9r3kGXymNqE/u2k24cWT5u
         nComInD35DjIUA4bUy6vZmo+/9OSy9tvSZZruUP+aKpQau+Gc0rNZLx0MftD3MhB7Pu+
         iGsA==
X-Gm-Message-State: AGRZ1gLj7PsKL83Lp+jwYur5KedEPbUgofrZSZXUPhpaAMQ7TeN5ztgq
        4c7dYaLRAFKVh4IH1WfTxIA=
X-Google-Smtp-Source: AFSGD/V5TMtnr+ZxCPY0X52Eph0rj5ATwPvDYQCH2U57FGkuEyqwF6maer7PgGp3xIyGIhEiVZqPBA==
X-Received: by 2002:a63:1f1c:: with SMTP id f28mr34760995pgf.193.1543441699662;
        Wed, 28 Nov 2018 13:48:19 -0800 (PST)
Received: from [10.0.2.15] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id m20sm10852345pgv.93.2018.11.28.13.48.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 13:48:18 -0800 (PST)
Subject: Re: [GIT PULL 1/4] bcm2835-defconfig-next-2018-11-27
To:     Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20181127211301.30296-1-eric@anholt.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <da219894-4bba-21a3-94dc-da7ff7e63896@gmail.com>
Date:   Wed, 28 Nov 2018 13:48:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181127211301.30296-1-eric@anholt.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/18 1:12 PM, Eric Anholt wrote:
> Hi Florian,
> 
> Hopefully I'm not too late this time around.  Stefan's been doing a
> great job maintaining the bcm2835 branches, and was waiting for me to
> send the PRs.
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://github.com/anholt/linux tags/bcm2835-defconfig-next-2018-11-27
> 
> for you to fetch changes up to 24632d6b78a1929b14f32cab762a0859db7086f2:
> 
>   ARM: bcm2835_defconfig: Enable BCM2835 MMAL-based V4L2 camera driver (2018-11-15 19:07:36 +0100)
> 
> ----------------------------------------------------------------
> This pull request enables the V4L2 camera driver on the Pi1 defconfig.
> 
> ----------------------------------------------------------------

Merged into defconfig/next, thanks Eric.
-- 
Florian
