Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58533C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23462206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JhmsGrB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfBVUE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:04:26 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39954 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfBVUEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:04:25 -0500
Received: by mail-pl1-f196.google.com with SMTP id bj4so1555785plb.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 12:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A5Zzp3PsBc3z3BPM6HhQqIQiRkTNg4Jv6/4olyOrBIk=;
        b=JhmsGrB6gc3sCymrEivdhcFd0QDU98+TOGTgk+kAzrZHjR7t6TiQNPswnLMlGI0qln
         U0fS55+sgKV20VnPtX0kWM3F6LElGgOpIYXmGfrPRN3xEduOrtyB1XLiQ0P8AszO8KEB
         FACCBlP7JKJD31dtvhBMzOB/fCZLpCNcyJmaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A5Zzp3PsBc3z3BPM6HhQqIQiRkTNg4Jv6/4olyOrBIk=;
        b=FI9Xgdd7wXzl8juXneCuXOTkYtUhth+E+n6XNSwq/tqrwVjUBi5jkKSPBR1DtwhxrO
         Vv6eVoCg7Fo+Rk7dJSMAOfJ7jg/Q+J94ubiHhUc1jDi7AHF1YLyjWrdlX6nNj0gpWE50
         uTjhvqzqypwzvJFWzX7GBJI8jBNwad4t/Li1SJZqzTB57KDe6IRxEwLc3xNYtvWiuQxo
         A2JMgL+KMJb33GgUxk8o11cwbL38R8IDMjnOumx2HfRSk+RdJzKyK5XIlzCmJQXk3JwE
         96o50Xovt3ighogCP/4wIqaY3eq4fU6QQVaRbWccTC9L6lc9QE4obzlaBr+fcRVCtgD9
         M/kQ==
X-Gm-Message-State: AHQUAuYRrSlTuQ3JERXryx2bCWJD2KEMPJij3vM/NMkrrUaI+3JqlmL/
        2OA8FATH2D65DmliJeJM//j0TA==
X-Google-Smtp-Source: AHgI3IaioMA/PqujokcGC/yCsW/lZjzS2fRRhWJfvQxbVFeUNA5V55Sj/yDL9tZwiI0wBQ+pZnNhEQ==
X-Received: by 2002:a17:902:1027:: with SMTP id b36mr5944622pla.339.1550865864862;
        Fri, 22 Feb 2019 12:04:24 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id p6sm3596621pfp.15.2019.02.22.12.04.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 12:04:24 -0800 (PST)
Subject: Re: [PATCH v5 0/8] iProc I2C slave mode and NIC mode
To:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <5c5ed177-0e9e-6271-518c-6956a7a6c554@broadcom.com>
Date:   Fri, 22 Feb 2019 12:04:21 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190214175725.60462-1-ray.jui@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

Rob has reviewed all DT binding related changes from this patch series.
Could you please help to review the I2C driver related changes when you
have time?

Thanks,

Ray

On 2/14/2019 9:57 AM, Ray Jui wrote:
> This patch series adds the following support to the iProc I2C driver:
> - Increase maximum read transfer size to 255 bytes
> - I2C slave mode
> - Polling mode
> - NIC I2C mode
> 
> This patch series is based on kernel v5.0-rc3 and available at:
> https://github.com/Broadcom/arm64-linux.git
> branch: i2c-slave-v5
> 
> Changes from v4:
>  - Add more detailed explanations in the device tree binding document
>    changes, to address Rob's review comments
> 
> Changes from v3:
>  - Various minor fixes on commit messages and commits
>  - Rebased to v5.0-rc3
> 
> Changes from v2:
>  - Address Ray's review comments.
> 
> Changes from v1:
>  - Rebased to Linux v5.0.0-rc2
> 
> Ray Jui (1):
>   dt-bindings: i2c: iproc: make 'interrupts' optional
> 
> Rayagonda Kokatanur (5):
>   i2c: iproc: add polling support
>   i2c: iproc: use wrapper for read/write access
>   dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c" compatible string
>   i2c: iproc: add NIC I2C support
>   arm64: dts: Stingray: Add NIC i2c device node
> 
> Shreesha Rajashekar (2):
>   i2c: iproc: Extend I2C read up to 255 bytes
>   i2c: iproc: Add slave mode support
> 
>  .../bindings/i2c/brcm,iproc-i2c.txt           |  17 +-
>  .../boot/dts/broadcom/stingray/stingray.dtsi  |  18 +
>  drivers/i2c/busses/Kconfig                    |   1 +
>  drivers/i2c/busses/i2c-bcm-iproc.c            | 758 +++++++++++++++---
>  4 files changed, 663 insertions(+), 131 deletions(-)
> 
