Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07631FC6182
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 22:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38F720839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 22:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibluAzXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B38F720839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbeIND3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 23:29:50 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38544 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeIND3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 23:29:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id u11-v6so3224334plq.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 15:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IjD4kENl1aonHuw0Uu5JcyB1U0mpiuus6NVD/gphPw0=;
        b=ibluAzXJjIepzc49SV41Za7QRPPaU0O5N7d1XjjlugbmHzqShDTYen02cl8b9ZMcL9
         Nxas3Lkh5NfwR4YmytV8B0vbdRmN0kjYXGUQOCeWlpua0cNyvsL1QGzJeflJ6q64Gybu
         m751L/GHKXJx3hFLF4jDXnsImfOUNpk/bE3C+U1fq59ficNLn52Gpfrivx4OX8xFlBA2
         Suvm1Qv2qUFdRMb9cktJKiyyk67R8Ks+3GKuL3L/UcYi3tjkfJ/TZ6pB9VKvOwcI0aXu
         wq9pzEU7KRhq6iq/NeYpiLhNyUy0ziYzOFg9lyVKBKLPyiv3QwSGc9yENhzCOUfTeuB2
         5Xzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IjD4kENl1aonHuw0Uu5JcyB1U0mpiuus6NVD/gphPw0=;
        b=aAJRlfkANykgt92YXx/w3i7q9Z3e5atfm0wZ30vEEFz0xByK1l3XCfzF3GKAudEKmr
         ftQW/ymoIVJA48KKCL2lUDytdQs15WziGpMj+R7aDjlLdPfP3VEJGKAMICJwKh6j8jXn
         X/h+ba8fLLSGj3msp6tRSW/Di1HpilgcFkG5gG0DWL+uHXAnNXeUnMOCltwLAXwdDvpV
         tVNZc0Uj8QImhu/QIvuRCUsgzG3LBA+Ol0AwEh32l77f6Ww4KPZWGGLqhKHUVxHCxYy+
         CGT63IbJ1FTPzmV/dq4pLy21n/Kg7+GubB7QcrWA/f/dOjtu2fDDi84qd9Ub8JotvWQW
         6FVQ==
X-Gm-Message-State: APzg51BBy466rLwk/VQHiQxpPioutyblRqsBOBzNUGSoK7cm0f+fECaC
        UY2+yCmkgwe/z4ILtzF5PfM=
X-Google-Smtp-Source: ANB0VdaPOmVRWmibpK/Db6A2L7b+4QhC410eN9VsZ+nCOBXpB/M2rpShWNhjdOxE/Nczb92YJshFng==
X-Received: by 2002:a17:902:b902:: with SMTP id bf2-v6mr9186657plb.185.1536877103612;
        Thu, 13 Sep 2018 15:18:23 -0700 (PDT)
Received: from [10.0.2.15] ([192.19.218.250])
        by smtp.gmail.com with ESMTPSA id c78-v6sm6770591pfc.188.2018.09.13.15.18.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 15:18:22 -0700 (PDT)
Subject: Re: [GIT PULL 3/3] bcm2835-defconfig-next-2018-09-09
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Eric Anholt <eric@anholt.net>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1536817833-3900-1-git-send-email-stefan.wahren@i2se.com>
 <1536817833-3900-3-git-send-email-stefan.wahren@i2se.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <ec141825-3eb4-1cfa-7d72-f44346f0aa2a@gmail.com>
Date:   Thu, 13 Sep 2018 15:18:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536817833-3900-3-git-send-email-stefan.wahren@i2se.com>
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
>   git://github.com/anholt/linux tags/bcm2835-defconfig-next-2018-09-09
> 
> for you to fetch changes up to 99fa3b0c6082bff346f7d09f29e5edcc93d40bd3:
> 
>   ARM: bcm2835_defconfig: Enable bcm2835-audio (2018-09-02 18:49:33 +0200)
> 
> ----------------------------------------------------------------
> This pull request brings enables the RPi audio driver in the
> bcm2835_defconfig.
> 
> ----------------------------------------------------------------

Merged into defconfig/next, thanks Stefan!
-- 
Florian
