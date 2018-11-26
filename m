Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76076C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6CB20865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="o/kQaWpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6CB20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbeK0DYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:24:30 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39469 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeK0DY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:24:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so11639908wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 08:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=04N/+m3E1kvecocFwcnstJy1RmtUU0i/1Xsel8lXeec=;
        b=o/kQaWpoIsPd3+4wkB8zGe0k1a2gFEi/NeRtl1sAAK8qwBqn8UfjKhIoQTzjE2c8VD
         mDwXaqMMzjBFn9zUDwSisW6ED31vtouv6gLbSzWoNkhQC9dQTG6QbaAd6xPa3KGhS+Kg
         GUYpOkmyC6Ozn9atQVgn5S3SSDYuGkGkYAuptne4u/nadtAh//UU5AEvigdfwmY69ScH
         YY1vbmbRRCLg01w/RnJPGCaNVaHNSFKC4Nhmf/8/uK0Z0pxYD/2tfF0Bx2evNY3iTA/D
         I/FsTAJwwpQFHY09PAChSA9NszGs3a+n0zoL7KtK5kQL3m2CuS4obUuTJ0kThKJ/UO2O
         mKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=04N/+m3E1kvecocFwcnstJy1RmtUU0i/1Xsel8lXeec=;
        b=kGIQ3asVA3Nc8LVhHWey7JW9vIFRDIrPRGS8ad5003ZlSvTN5rA+i28VfGO0La3ibH
         6U3XauCBorG9hnJYOegOB18rKAAX+ED0t8NjTzi4uL9yh37R04MxFiuZEYg5Hl4kQ6/4
         L3mUgXOJXjiQegnaqv5/awNlh8r6/os+tsw/h7Oyvr5Jue5wgSBZ/pJccTJtqzlVbxVD
         rOGQja4qM+1T88BwK3shokvagSeimr3RjQX1eHRMMTnoSxN+xQ9EhEjNRhzNmCHvCOOn
         NHZeNYcSY6f3dwHsSJUFrTv0T0VDA0/Le3u+QlkVfESShmK65/GHixik3a6feZr+HTa3
         lwOg==
X-Gm-Message-State: AA+aEWYxSS0jrtx7uX58bE0g9VPHSp7w3Uihqzz8R0VV52KmVurOZCw0
        zPRG/Gt+TDB5TcaXzmc+wKz80Q==
X-Google-Smtp-Source: AFSGD/Xg6xZvxl8fzo6D2WP8d9UW+oXzyrBKdURXuGHpVIRpWWiOPlKMjMyRs83Ho4KK2uNum92Flg==
X-Received: by 2002:adf:83e7:: with SMTP id 94mr24484202wre.278.1543249792494;
        Mon, 26 Nov 2018 08:29:52 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id a1sm878255wrw.76.2018.11.26.08.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:29:52 -0800 (PST)
Message-ID: <5bfc1f80.1c69fb81.8f88e.54d1@mx.google.com>
Date:   Mon, 26 Nov 2018 08:29:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Kernel: v4.19.4-118-gba8189574643
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
Subject: Re: [PATCH 4.19 000/118] 4.19.5-stable review
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

stable-rc/linux-4.19.y boot: 99 boots: 0 failed, 96 passed with 3 offline (=
v4.19.4-118-gba8189574643)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.4-118-gba8189574643/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.4-118-gba8189574643/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.4-118-gba8189574643
Git Commit: ba81895746439d9b5d37169c618cbcf9c3e634ce
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 57 unique boards, 21 SoC families, 15 builds out of 202

Offline Platforms:

arm:

    multi_v7_defconfig:
        stih410-b2120: 1 offline lab

arm64:

    defconfig:
        meson-gxl-s905d-p230: 1 offline lab
        meson-gxl-s905x-p212: 1 offline lab

---
For more info write to <info@kernelci.org>
