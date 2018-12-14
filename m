Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED14DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD71B206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="w/0hwS+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbeLNRdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:33:22 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52516 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729915AbeLNRdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:33:21 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so6451169wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 09:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=wRp8Z+gpywnax30g9xzFidDZ81kkOw4fRUpP2YHbSJA=;
        b=w/0hwS+oHaQmwrMXF9a9ahC4vZQCbd3JHbunR9IfPMO3u2x2IpQR0wh/Jge+YWs1pB
         kUyiiSdC9yrcn+R3bvEFS/BPKlXQpRod1P8KVnH9KAwnhXrDsq0t66PcYHeNmU1eGtmt
         aeBvui51JR77XB35wOTdGiEGMd1NHNVW2MbW8aBi+awYmTIWdLZyFMN1/hJD0kisjKAP
         lb5kgL9fMA+7X6fOFUULgg/tmkbM2rBHx7MWPZmBAM02KTfHiGG13X0QWI1YECy5aUET
         pfEizKlwUaJKL27xtk6ZwuaECeQ2KcYc0xcVqPl6M2UXPG+GjghmYod00FdTjcyec2pK
         i9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=wRp8Z+gpywnax30g9xzFidDZ81kkOw4fRUpP2YHbSJA=;
        b=TsTz+GrpUHt1pNU9X1ZMY9STnC1cUU9ibT+MnVY+OyIVq/mN2maDdUb4Zii5FCB7Xz
         kwIuwZtuV1cuwLTYS3d6oGjYPLazNLU5czXj/SEgwYhekIDGN8kkg7sXj8V4R2wLHZg2
         mcBvDZC20j7My1L6W/LWk2SddziCGegbATG0KpuvI0iczy8sHVdBTIJARH/XkCMXyLgu
         C9eIFzk0w42ea7iQsKhB4h1+eyeukF/0FO5iVfrfu7erxFPoTgEwGbv/LSFgtgayXyzx
         euX91gcYIt24zSeBxd4fUU8YqEoe23kHA19DQOJf/B4hRWAVfeerzkO+T+yofWMywluX
         HE+Q==
X-Gm-Message-State: AA+aEWb15jZEFsuVXyFlzuhyvtAXuj/4sRW6uwVlV2XSOHtu77hhC9my
        rSf2WtCkszpHAosyC8Cp0si72A==
X-Google-Smtp-Source: AFSGD/XKuE/osyQ0+fGPKpZvtaZjNSF7MvUDysaBxoHhkfX41VbOlkEQ0/OULyoVZ7emhg5PUx19Zg==
X-Received: by 2002:a1c:5604:: with SMTP id k4mr3844523wmb.107.1544808799540;
        Fri, 14 Dec 2018 09:33:19 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id i192sm5284352wmg.7.2018.12.14.09.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 09:33:17 -0800 (PST)
Message-ID: <5c13e95d.1c69fb81.df503.e883@mx.google.com>
Date:   Fri, 14 Dec 2018 09:33:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.14.88-90-g159976987c2f
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.14.y
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/89] 4.14.89-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stable-rc/linux-4.14.y boot: 116 boots: 1 failed, 111 passed with 2 offline=
, 2 untried/unknown (v4.14.88-90-g159976987c2f)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.88-90-g159976987c2f/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.88-90-g159976987c2f/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.88-90-g159976987c2f
Git Commit: 159976987c2f89308c6293a31e8fa9543549b94b
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 60 unique boards, 23 SoC families, 12 builds out of 197

Boot Regressions Detected:

arm64:

    defconfig:
        rk3399-firefly:
            lab-baylibre-seattle: failing since 5 days (last pass: v4.14.86=
-56-g555f40d53cca - first fail: v4.14.87)

Boot Failure Detected:

arm64:

    defconfig
        rk3399-firefly: 1 failed lab

Offline Platforms:

arm:

    multi_v7_defconfig:
        stih410-b2120: 1 offline lab

arm64:

    defconfig:
        sun50i-a64-pine64-plus: 1 offline lab

---
For more info write to <info@kernelci.org>
