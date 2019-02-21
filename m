Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3235C00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BA32083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="ykXiV8cu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfBUST7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:19:59 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40445 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfBUST7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:19:59 -0500
Received: by mail-ed1-f67.google.com with SMTP id 10so23956779eds.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 10:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=RSYF5sZv8FbwX1edFcYC3Nj2WEGxg7SSNjH0MStCiUc=;
        b=ykXiV8cubU0nuQMyeB995s/4X5iFOV7cacLjo3OELZ1OtyKpqn1dW8IOi+oZsPKx1d
         xyXPhGLGlIIcAzzLL4vXG6UaUK0vg5kCQXvPmNz7jo3/5+MUCHJASjpLiCOaHRz+N74f
         +XZe1dHPOMv4HkDdBQXmuHGeeBdYZ9M3eySJrePeNtNZwDkof5LU7kg5JKlMNmNfKrZf
         zgwXWv7hzJtjdjIISsF3k0rveeorSk1n2kqOFVJlrfphBmiS/eTLgOhOSx4DU+fA6fOx
         ooWZDGVDT8bxSHU/IPdC7EKWSXvBBLyo81jto+kfGCX/eDe8ARHpDDNsxWGSaaqoNl/d
         Do/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=RSYF5sZv8FbwX1edFcYC3Nj2WEGxg7SSNjH0MStCiUc=;
        b=AYhVPNm80S8INWM5RWMLqN95atBQVuSniw/eUHhZWlGsotrBIJt0AUjW+XusegppTD
         PiCgz/sEMizjZiZo3WD7iNPL39upW4qqO26CVTysEiU3zipEz3YNwUt6Me2JH2umXfYN
         LWosTw6wX0sxg3Acy5pJz3zi3R8gmvQUeH9JqSwkOEByANe6vYclZQvvHi+2JJiefUta
         Hjmq0ZA2/DOWFVfRPJE12mwDa0v0SNZsYhylJZ26TNsgv3y2PFsbURf8ch8Td5Gyeqam
         LiVbgcH9M+rsVVRzc+UMHsp81V9SY7TiA38+wlMI2YjklZ0GF+A5rxmkU+1+ClL/jpkQ
         rMpA==
X-Gm-Message-State: AHQUAuY8wBFsyN0At9LmvXmPYGJrvKKzMNicW0etDQYGtncW0tLn537L
        2yf4I80ooFnytj/1uSJu6cG/6nLaxOZiUA==
X-Google-Smtp-Source: AHgI3IaHLpUMHTkIjWyzhaPLBIQcUEyZATsvAmVT0hUZqrE9zL5J+/YTQ6P45jVyZvFwQw9BMf+TYw==
X-Received: by 2002:a50:fa8f:: with SMTP id w15mr31311654edr.256.1550773197099;
        Thu, 21 Feb 2019 10:19:57 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id i8sm6847159edg.21.2019.02.21.10.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 10:19:55 -0800 (PST)
Message-ID: <5c6eebcb.1c69fb81.30388.c61f@mx.google.com>
Date:   Thu, 21 Feb 2019 10:19:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4.175-20-ge21af95e85ac
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.4.y
In-Reply-To: <20190221141946.772985220@linuxfoundation.org>
References: <20190221141946.772985220@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/20] 4.4.176-stable review
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

stable-rc/linux-4.4.y boot: 83 boots: 2 failed, 79 passed with 2 offline (v=
4.4.175-20-ge21af95e85ac)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.175-20-ge21af95e85ac/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.175-20-ge21af95e85ac/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.175-20-ge21af95e85ac
Git Commit: e21af95e85ac96e6074b3962a5cb962c71393729
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 39 unique boards, 20 SoC families, 12 builds out of 187

Boot Failures Detected:

arm:

    multi_v7_defconfig:
        gcc-7:
            stih410-b2120: 1 failed lab

arm64:

    defconfig:
        gcc-7:
            qcom-qdf2400: 1 failed lab

Offline Platforms:

arm:

    multi_v7_defconfig:
        gcc-7
            tegra20-iris-512: 1 offline lab

    tegra_defconfig:
        gcc-7
            tegra20-iris-512: 1 offline lab

---
For more info write to <info@kernelci.org>
