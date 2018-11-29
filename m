Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22B6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB342147C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="kZ4sNR7B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB342147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbeK3G6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:58:33 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44323 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbeK3G6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:58:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so3105382wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 11:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=meRyi3qRaWzJCnMiF7iTXxaKN21b1LXlGuj2TvNS3uM=;
        b=kZ4sNR7Bx0iJHNzZ6xftrQ93DODDsaumaBYGLyeNHatSclKb3IfzZK39e+jOnlLCrD
         PfLq4tlv+o6cGpsb3HdF40JIZUSveP/InfDUq9vNyQrBjX/mJMbQXeUlPwiwUjXTnEpv
         2j6wz3jeC7FXVKxttAeFGy0DeGN2wOsdTmQMGTFngFDbAbN7nzeqV3MKIcKDjfsE63kG
         ntVOp8wo7ImNGl4Bdv9sCmiNl9YbFEUttIOYoCoi40ghbox/yxiSwCn9BUKb2wLzZECm
         Szv1L2xebp46XSiLtlR3+DuFcBHeMix+8ualF3EJ07o/IxRmWRmle3SYWkqDjvcF/L0K
         jz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=meRyi3qRaWzJCnMiF7iTXxaKN21b1LXlGuj2TvNS3uM=;
        b=Aq5Ar6wXu8e/6kh3ysQ602vOYbY+ho6W+/sqgukHQFWJVnq2LI8INtJpKPo4ix+wkL
         4U5xccIw8h2VHwusCTZDzW+mZeTuUC8dE++VZz1khTBKELFMUkMyKuRJf88LADVjnH0M
         L/2m79xwejZjF6b1mza7ry49/gPK0i4Oj3/0roYDzqtVUpm60tX/jH/UbT6WmtfFIK76
         AdA2abTWNu5tMwF0RZU/ZylvZysbISxSq4GzEzuP63BUbb32PNwwv0eeUg/+5v06wcSZ
         bzSSUFLFLT+O166gH9H068ZETrV1Ir/XK3Wt07qrKgH382YclJe0YsD9qNAeieaCvV6G
         dAqw==
X-Gm-Message-State: AA+aEWY2o6nBGfsgoGem+A2LISnAgO9Oy2T3++XZGM+/UmRgN+wb+vZD
        vuLo4+jR/91Dqapg5CoTbkgmYw==
X-Google-Smtp-Source: AFSGD/XE9h7yezXLgch6p/Qrgv3FTM0Qiwz/7bubE/dAvywmhu/vugGw+7PTOdVGIzGap++3rfthwQ==
X-Received: by 2002:a5d:4dc8:: with SMTP id f8mr2637259wru.45.1543521115551;
        Thu, 29 Nov 2018 11:51:55 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id j128sm71441wmb.3.2018.11.29.11.51.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 11:51:55 -0800 (PST)
Message-ID: <5c00435b.1c69fb81.a1668.0796@mx.google.com>
Date:   Thu, 29 Nov 2018 11:51:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.9.141-93-gf46aebe62697
In-Reply-To: <20181129140106.520639693@linuxfoundation.org>
References: <20181129140106.520639693@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/92] 4.9.142-stable review
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

stable-rc/linux-4.9.y boot: 113 boots: 0 failed, 111 passed with 1 offline,=
 1 untried/unknown (v4.9.141-93-gf46aebe62697)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.141-93-gf46aebe62697/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.141-93-gf46aebe62697/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.141-93-gf46aebe62697
Git Commit: f46aebe62697538df220b8708e266369ffd901c5
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 52 unique boards, 22 SoC families, 16 builds out of 193

Offline Platforms:

arm:

    multi_v7_defconfig:
        stih410-b2120: 1 offline lab

---
For more info write to <info@kernelci.org>
