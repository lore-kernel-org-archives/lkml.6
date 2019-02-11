Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC19DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B9D2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="ii0o8wZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388102AbfBKT7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:59:05 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38795 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbfBKT7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:59:04 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so148498wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=OnoFTGcv9We6IUJxI43NjbSt3W/8YOEsJYn3q9h349I=;
        b=ii0o8wZZoEbCFIPD2aUjPOrAI0ZpkSkiEsCr6QOnn0UHbWDQiJdfxAiasjenh2xkXa
         O9HNV1qUcQLvxaShDZ2JT7S3vQD393hf3oyF6Woic8gNwLa8V7NXu0lPzd1hpJwDKs5X
         ZdTqJxnbhY0wcMrMzRudBfApCnIKyxtXTD0SOcKC0uvCTmCnLlfezj3+VWhmiO9heDk4
         JlzK4jbEZnJs0uwNRxpNne66SUvd27FCaIlCOHyZkdkcH9i5F0qXOu5C7VKEB5sBz/OA
         KQzzLDJsqlakP+EQhA4IlpSTYoroPfm7br7lfBRg6Rz3YEjCNAt/YslEDadVqaJ2bmP9
         Gc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=OnoFTGcv9We6IUJxI43NjbSt3W/8YOEsJYn3q9h349I=;
        b=LlY7JwB2aKbvcf4cQWk3IhNBAEGDpeajPj1hA016PAoNSTbcpUxTTaIsyw3ZhldyhR
         ll2ALL4Gc6BMRsWjWQGYnKQR1apH8Eyecyx31/zQNzX7sTeH8kAFKsyN9XUCG8YulfrY
         gY5/WP1dRbR/GCzI00tX4ufbOAKRNt2vYydqvfLrMsMf+eib9N4p3ma5TsGyEPc8vm2s
         b3zZTtGYdoqeELKBARG2QjUpzIjkj2p8xCsGwhVD44CBytY79sGriQ8xpwXu+lpSd+VL
         cumnH1EvClLlqQAkGOWLDApWqVNbLMBt3yjvR2qi3eDbhuqC/GTjkCUcuHXckLNprJDd
         K72g==
X-Gm-Message-State: AHQUAuZ7kVYfE91+8SHGySAljPS60F9UJfgMlNd6eDulNC9qbmv8AkQd
        TLrm7wsh69t5tfDclxQt+1w3KWbNj8B/OQ==
X-Google-Smtp-Source: AHgI3IZBJX5kkYhBMT4njrJDSFu2TWbtWv4r6J7U6bPWNc7wQcC932MbFAm/sIiYLCuCd0L0cIbSYA==
X-Received: by 2002:a5d:43c9:: with SMTP id v9mr558865wrr.202.1549915142368;
        Mon, 11 Feb 2019 11:59:02 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id b85sm541480wme.12.2019.02.11.11.59.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:59:01 -0800 (PST)
Message-ID: <5c61d405.1c69fb81.12861.3803@mx.google.com>
Date:   Mon, 11 Feb 2019 11:59:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.19.20-313-g175a7aa1da44
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
Subject: Re: [PATCH 4.19 000/313] 4.19.21-stable review
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

stable-rc/linux-4.19.y boot: 113 boots: 0 failed, 112 passed with 1 untried=
/unknown (v4.19.20-313-g175a7aa1da44)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.20-313-g175a7aa1da44/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.20-313-g175a7aa1da44/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.20-313-g175a7aa1da44
Git Commit: 175a7aa1da44876d97625a345183b3f885f0b6ea
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 62 unique boards, 23 SoC families, 12 builds out of 202

---
For more info write to <info@kernelci.org>
