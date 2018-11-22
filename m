Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B7CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A168D20878
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="cTjLV4jC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A168D20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404615AbeKVQ3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 11:29:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35761 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389432AbeKVQ3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 11:29:35 -0500
Received: by mail-wm1-f67.google.com with SMTP id c126so7828101wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 21:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=nLKVwC076FJDoNwl8erKPBl/eUxd1XDYPAf3W3JTumg=;
        b=cTjLV4jCDVedMgaT05RDeVtzjlWw8hVPgt0Mf2PE0T8rjLmrouOwph81sFHBwo1YYF
         LbX6zqj7GTeUZuzd2tSJ0YLKSWMVMP8uBHD63MfWxI2MmRk2Wq/jdbqlOcFhhMc1tdZt
         84wxqZIh4M7Li5mfuqYOopR0rGO8cq4uTnDjDu5XubXdNVKUzYxy5GbcUFPphu0RM3+h
         TY3FRSy83OtZlex98dGz/eFLeA/C8L0d3OqTDAiAIFGia2Oru2fhjkG+tyVH6iKm63mA
         YBR8bcP47MLKXYz+k5lxrZ+2kqCp6g795ZBycD1TV51QzjzQzCwfhGSoKjloqAf7MYtn
         AoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=nLKVwC076FJDoNwl8erKPBl/eUxd1XDYPAf3W3JTumg=;
        b=aF1AbTJxi7yjVY6D9JHCmqOd3BD0GajqS3zXaybXdj+KOArV0OoBCoEmcYPhdPEK+g
         7KuZjUXW/bPmJAJmFW9EakRavs4kFzcyxpmNpEj7AKBbsVaI9z7xkD+lPOykq/08iuTF
         ZnoHDoN9VDGOOeIkf0+2cEgYsN0i+onjt7GWGWlfdv780m83qGCR0CkR2TQOHvAQ4ckP
         J+lWMt9dkXbgZTavri+AiK/cP0sju3AcOVxwU8i+tYCw6Ln94c3UiWdcIWP1bzHZo2Vd
         SRURW7zp5/sFxhdthcfwY/7sl1guhKLgYlazatQpdQl0KVW3FMfTrVLMUffxFr0eFLq9
         jILQ==
X-Gm-Message-State: AGRZ1gLdAW0dheAUfykwyTuOBO/iAljlUdzPoH3BOWOWRqanA9lAqIvF
        i7vA6EtwpisYwcxwaVKfc1HHTg==
X-Google-Smtp-Source: AFSGD/UdW6gFOcK1gznji7i+UGp1sXeWO2yL0U/ZdkNImCyPbCNv6jE4Wydlv1iKyMROdk8f4lBk/Q==
X-Received: by 2002:a1c:dc83:: with SMTP id t125-v6mr7916199wmg.78.1542865902659;
        Wed, 21 Nov 2018 21:51:42 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id g16sm5436155wrr.62.2018.11.21.21.51.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 21:51:42 -0800 (PST)
Message-ID: <5bf643ee.1c69fb81.7e796.0a07@mx.google.com>
Date:   Wed, 21 Nov 2018 21:51:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.82-22-gaa2838d50dfb
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20181121183422.103826775@linuxfoundation.org>
References: <20181121183422.103826775@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/21] 4.14.83-stable review
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

stable-rc/linux-4.14.y boot: 92 boots: 0 failed, 89 passed with 3 offline (=
v4.14.82-22-gaa2838d50dfb)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.82-22-gaa2838d50dfb/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.82-22-gaa2838d50dfb/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.82-22-gaa2838d50dfb
Git Commit: aa2838d50dfbecf82e5ba9e1013d3057c54590b2
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 53 unique boards, 21 SoC families, 15 builds out of 197

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
