Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD02AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907402083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erJpQDc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfBURry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:47:54 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33441 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728749AbfBURrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:47:51 -0500
Received: by mail-pl1-f195.google.com with SMTP id y10so14535264plp.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 09:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lrNbv9D/+PwQBSGB6S9a8LNJVw4/l0ifItpd67gezmA=;
        b=erJpQDc0uZ+zDImdqmk98WIANTu/X4FFtio8MkgkwkCYHKJSm2Jy7p6iopFYble1eM
         iQg5NESNI5vQrvaHlfY7oUVli0dFeDUSBbvWshZCAka8+qlsO8Nx1FKcrOgnYamxuMez
         LU8YKiaMIftCMpFqlNmG2K1EVWRznDpzvOg2J0vUxwHuqPwp+HwR3ytgNugZM/43+SRL
         STQnnarvJuexhGcdO4iUfWex+t6JmJNmO7teEbcYMzWYiV4eTi7XcXHu3hOWImPv5Fgp
         3wRsnMNnRiSSQk8wLdQaAngJA6gB63EjrdJbg24gO+K55uiLEuLW+AaQgFOfVFwGPIE+
         E3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lrNbv9D/+PwQBSGB6S9a8LNJVw4/l0ifItpd67gezmA=;
        b=lrl2ePGz4Px44hXwiA9XKRD6h195H6DU6OLElIbxOT97ldXUzVxD/cmWdjIW2pyENm
         CgmYMeMxdsFB3KAd8zUhR1oz2zB26s8rqJkwlTVaj/9kOasMGiyFUNqiXDFaFSA0oqKL
         ILZvQaH3+98UXPEQKAIDnz/FMEMz+t+CVFeAjF0uwvcUecQNCA79zxwSahF3hn1IdVWO
         LJU97KjayLjghgH0lo9VThyKmY0cZTdVr0FsgI4xg5Sy1s85ad5caXVYWRTPh01VOFa+
         rSUnYX9e5/fY6ItfpuAbeR4mbXt85CzWN3jVFLwCIgCoNqA1fnap/JDT3tTyBGSikjE6
         xTiQ==
X-Gm-Message-State: AHQUAubYwkTiDCIAPxYS7kSIqKyw/4WkT3hLoaYFeU257bvGPaN4mrBt
        ldyWRjhCL+d690rj3VUDxtNcracV
X-Google-Smtp-Source: AHgI3IbxerhVFleEHlqCUafAXvNI3Httb9syQ/xllqcQyiJpMPmIY/IhFnjQKCVQL27MjZIGziY2kQ==
X-Received: by 2002:a17:902:4827:: with SMTP id s36mr42847769pld.168.1550771270847;
        Thu, 21 Feb 2019 09:47:50 -0800 (PST)
Received: from [10.67.49.97] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id a24sm18196134pfo.160.2019.02.21.09.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 09:47:50 -0800 (PST)
Subject: Re: [PATCH] MIPS: BCM63XX: provide DMA masks for ethernet devices
To:     Jonas Gorski <jonas.gorski@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20190221095642.26962-1-jonas.gorski@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <b04924de-bf58-58a7-6f82-975014668215@gmail.com>
Date:   Thu, 21 Feb 2019 09:47:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221095642.26962-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/19 1:56 AM, Jonas Gorski wrote:
> The switch to the generic dma ops made dma masks mandatory, breaking
> devices having them not set. In case of bcm63xx, it broke ethernet with
> the following warning when trying to up the device:
> 
> [    2.633123] ------------[ cut here ]------------
> [    2.637949] WARNING: CPU: 0 PID: 325 at ./include/linux/dma-mapping.h:516 bcm_enetsw_open+0x160/0xbbc
> [    2.647423] Modules linked in: gpio_button_hotplug
> [    2.652361] CPU: 0 PID: 325 Comm: ip Not tainted 4.19.16 #0
> [    2.658080] Stack : 80520000 804cd3ec 00000000 00000000 804ccc00 87085bdc 87d3f9d4 804f9a17
> [    2.666707]         8049cf18 00000145 80a942a0 00000204 80ac0000 10008400 87085b90 eb3d5ab7
> [    2.675325]         00000000 00000000 80ac0000 000022b0 00000000 00000000 00000007 00000000
> [    2.683954]         0000007a 80500000 0013b381 00000000 80000000 00000000 804a1664 80289878
> [    2.692572]         00000009 00000204 80ac0000 00000200 00000002 00000000 00000000 80a90000
> [    2.701191]         ...
> [    2.703701] Call Trace:
> [    2.706244] [<8001f3c8>] show_stack+0x58/0x100
> [    2.710840] [<800336e4>] __warn+0xe4/0x118
> [    2.715049] [<800337d4>] warn_slowpath_null+0x48/0x64
> [    2.720237] [<80289878>] bcm_enetsw_open+0x160/0xbbc
> [    2.725347] [<802d1d4c>] __dev_open+0xf8/0x16c
> [    2.729913] [<802d20cc>] __dev_change_flags+0x100/0x1c4
> [    2.735290] [<802d21b8>] dev_change_flags+0x28/0x70
> [    2.740326] [<803539e0>] devinet_ioctl+0x310/0x7b0
> [    2.745250] [<80355fd8>] inet_ioctl+0x1f8/0x224
> [    2.749939] [<802af290>] sock_ioctl+0x30c/0x488
> [    2.754632] [<80112b34>] do_vfs_ioctl+0x740/0x7dc
> [    2.759459] [<80112c20>] ksys_ioctl+0x50/0x94
> [    2.763955] [<800240b8>] syscall_common+0x34/0x58
> [    2.768782] ---[ end trace fb1a6b14d74e28b6 ]---
> [    2.773544] bcm63xx_enetsw bcm63xx_enetsw.0: cannot allocate rx ring 512
> 
> Fix this by adding appropriate DMA masks for the platform devices.
> 
> Fixes: f8c55dc6e828 ("MIPS: use generic dma noncoherent ops for simple noncoherent platforms")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
