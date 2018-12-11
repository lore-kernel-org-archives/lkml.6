Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E963FC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74DE2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="Pr3eRrwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74DE2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbeLKVdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:33:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43962 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeLKVdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:33:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so15602144wrs.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 13:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=rJhMXpadiMUArgMeEP8lNFad1p3yqn+hf8SZBiOZHro=;
        b=Pr3eRrwFnc+RcZa7NMGVKN26gvgrYodmt2X1lCeQTRgxKdVHQFjPFxJrQ1XUXV/6zP
         e9eSL71kCWjxRFqqWyUMUkq6tBS4cwtilMzABIJv1LQFJut3ITCyt+wIGtzW+GcVP7aW
         X42mRNO51Ed9IA+o58L7sQA0igNItQpVE0f5qprlYP2T+/iM+or0SPIMDzbTD3UWCVl7
         FEaLvR76KIuaW/E5PhORXURAc/GoZaNpXvOBxfSuPSNFPunEvq30qyxR7X+DoMQKKJoE
         VcBTX0fangqy2aaZYWDT1n0DBsl4g9ccNvCv9YA8higLdOcJBPitG9oE9zbYWPB0VmOv
         vLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=rJhMXpadiMUArgMeEP8lNFad1p3yqn+hf8SZBiOZHro=;
        b=NRn2qKseyECxeq5owYobuUiVDt2yV76yE+nKKkodeW+WOwj+h6upe8uFoF+UaFFnSR
         lXEgzWTWxQPz2kBN3yqJP994CVsOyr9dPBuADUWUAIlEKUb9/QWQb48cwf/P0deypY0P
         eaC2REOIydUe8TbW8U8S1i/UzNvqGpXU3/Pe7ZZp9qQPiEK+guWkuqk7IrrVyiD2a4OM
         iY9+pxH4tDfNzhJTqjyCuTH0NRKlpSwE9iKAov79Dfg33o6ZIaWLaNC83MScGMqtCn1x
         mOer4/sPAWPt+1bchrh2rWMgphyJII+Mnc149lFo9yXKvJGuVKYpHpDAWmFIW4ZtYbxk
         KzwQ==
X-Gm-Message-State: AA+aEWYvh1GpYh8hU3jRSUYYURRWQ/IGtRGRQ+3HaPm2jZfn6S/rV2nB
        M1gch/AWhwcGVIGh3ugaLW1aPg==
X-Google-Smtp-Source: AFSGD/XMbm6NxxjxK3PoLIZMEMsBZ1goYGU04vMyukolm5hksNDWpu00/tQifI+Uu+vIvd5MlIDOKg==
X-Received: by 2002:adf:fe8f:: with SMTP id l15mr14364846wrr.313.1544563983299;
        Tue, 11 Dec 2018 13:33:03 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id k135sm1527831wmd.42.2018.12.11.13.33.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 13:33:02 -0800 (PST)
Message-ID: <5c102d0e.1c69fb81.4653a.ac2b@mx.google.com>
Date:   Tue, 11 Dec 2018 13:33:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Kernel: v4.19.8-119-g6a09e212b52e
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
Subject: Re: [PATCH 4.19 000/118] 4.19.9-stable review
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

stable-rc/linux-4.19.y boot: 116 boots: 0 failed, 115 passed with 1 offline=
 (v4.19.8-119-g6a09e212b52e)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.8-119-g6a09e212b52e/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.8-119-g6a09e212b52e/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.8-119-g6a09e212b52e
Git Commit: 6a09e212b52e5edf398ca6296a183187d7343863
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 62 unique boards, 23 SoC families, 12 builds out of 202

Offline Platforms:

arm:

    multi_v7_defconfig:
        stih410-b2120: 1 offline lab

---
For more info write to <info@kernelci.org>
