Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F10C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F2223FBF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICcR5yzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F2223FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932566AbeGFMCO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:02:14 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40728 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932318AbeGFMCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:02:12 -0400
Received: by mail-pl0-f68.google.com with SMTP id t6-v6so2802880plo.7;
        Fri, 06 Jul 2018 05:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LJRNDMhBgFMXzuLg8wwvRVOn0TcGC/R/oBS6G4PQd3E=;
        b=ICcR5yzqGXs2mmJk/KRUKHuiAne6RnLYerykCmeGuewsu4+7p8xUU8MqCF+SG8gwxi
         QQoW3lg6WRswheIFMv04lv629cnX5msRa4ZJ8SPvhYQ3G7GJda93ZGsd6v1Nj5YUJhks
         m5uELiCtrdyeyXEHr+ZGj1zrrYk99NKOQbwMBVRmFDG/cRTwilZelW/2UMMdZmN0PW8z
         rbPuVaEuOgAviRw5sKmyatunQ1SElO+SOQQKke9VbhFtH2Faoh5Nq+oTTM7avm+kigWs
         vxaSvO4/xMdKwbGjJ5p1A+k+wCqq+xi+Z2i94B6KjwAieiPCP47vhcTyNjfw3Y0BHEDV
         t/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LJRNDMhBgFMXzuLg8wwvRVOn0TcGC/R/oBS6G4PQd3E=;
        b=NcejkszkW7bi9r4oZw37YKq881DoEg3joem+2L3hQ2pcP2OwMa6aLRKi7+kl+2zN35
         ZmGR/JaqLTa++dBcYmJPMi2aWbO6o0yJp/nOqHjU8NuEnnCfINQ7mVRzrgtpt4U64ayf
         91cHE3PALSqA5YAiiol0aaimuws4ITtbW38XrLPtMqkqk6xxCWLdGfvtpI+m2S8cdlNy
         fiYPcOaNAvDGfRDBM4Yy+POcQ4sXZLonnTr6eTbYFznRgVwG5leIap8zDc65NNNwTp8L
         uPNe0/+ibYWeuijPGmmaclAcPLkfyye4B5rhkU3L1KV6eH4DBbznmNPKi8MlboM0Q3b+
         ZMvg==
X-Gm-Message-State: APt69E1i1Gm4v0VjkVb8N1KEyCqC//KZjE3tEpZjNDVcEovJKE+dswFB
        ANp6LouONxKrdf5uXiMf5Bs=
X-Google-Smtp-Source: AAOMgpfOJE49KZ7pPt5As2FBqT/ql+4ApPWME+vqyTWxCQxWkyuFLxIlZtbX6c1Ohb9tW5kxax7fdg==
X-Received: by 2002:a17:902:9a95:: with SMTP id w21-v6mr10114146plp.168.1530878531808;
        Fri, 06 Jul 2018 05:02:11 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-84.nat.spd-mgts.ru. [109.252.91.84])
        by smtp.googlemail.com with ESMTPSA id j72-v6sm7883657pge.19.2018.07.06.05.02.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 05:02:11 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Initial support of Trusted Foundations on Tegra30
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
References: <20180619110027.16935-1-digetx@gmail.com>
 <d99935be-797d-4676-c186-a045a590f01b@gmail.com> <11534185.70fb5jbPr6@dimapc>
 <5c47ef70-b90e-6e81-39dd-fbcfad2b93e5@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=digetx@gmail.com; prefer-encrypt=mutual; keydata=
 xsBNBFpX5TwBCADQhg+lBnTunWSPbP5I+rM9q6EKPm5fu2RbqyVAh/W3fRvLyghdb58Yrmjm
 KpDYUhBIZvAQoFLEL1IPAgJBtmPvemO1XUGPxfYNh/3BlcDFBAgERrI3BfA/6pk7SAFn8u84
 p+J1TW4rrPYcusfs44abJrn8CH0GZKt2AZIsGbGQ79O2HHXKHr9V95ZEPWH5AR0UtL6wxg6o
 O56UNG3rIzSL5getRDQW3yCtjcqM44mz6GPhSE2sxNgqureAbnzvr4/93ndOHtQUXPzzTrYB
 z/WqLGhPdx5Ouzn0Q0kSVCQiqeExlcQ7i7aKRRrELz/5/IXbCo2O+53twlX8xOps9iMfABEB
 AAHNIkRtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT7CwJQEEwEIAD4WIQSczHcO
 3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbAwUJA8JnAAULCQgHAgYVCgkICwIEFgIDAQIeAQIX
 gAAKCRDTNNaPsNRzvFjTCACqAh1M9/YPq73/ai5h2ExDquTgJnjegL8KL2yHL3G+XINwzN5E
 nPI7esoYm+zVWDJbv3UuRqylpookLNSRA01yyvkaMcipB/B128UnqmUiGRqezj9QE20yIauo
 uHRuwHPE2q+UkfUhRX9iuOaEyQtZDiCa0myMjmRkJ+Z8ZetclEPG8dYZu47w04phuMlu1QAt
 a0gkZOaMKvXgj21ushALS6nYnvm7HiIPQXfnEXThartatRvFdmbG4PCn0IoICkQBizwJtXrL
 HEjELIFap0M8krVJlUoZTFaZnaZkGpUDWikeFtAuie2KuIxmVBYPM4X7pM3eP3AVvIPGS7EE
 UUFuzsBNBFpX5TwBCADFNDou220thijaLLGaQsebWjzc/gPRxMixIpk856MRyRaQin+IbGD6
 YskMb5ZSD3nS88LIKNfY4MMH0LwfYztI++ICG2vdFLkbBt78E+LqEa+kZ9072l4W5KO3mWQo
 +jMfxXbpgGlc7iuEReDgl8iyZ27r51kSW665CYvvu2YJhLqgdj6QM1lN2D1UnhEhkkU+pRAj
 1rJVOxdfJaQNQS4+204p3TrURovzNGkN/brqakpNIcqGOAGQqb8F0tuwwuP7ERq/BzDNkbdr
 qJOrVC/wkHRq1jfabQczWKf8MwYOvivR3HY8d3CpSQxmUXDtdOWfg0XGm1dxYnVfqPjuJaZt
 ABEBAAHCwHwEGAEIACYWIQSczHcO3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbDAUJA8JnAAAK
 CRDTNNaPsNRzvJzuB/9d+sxcwHbO8ZDcgaLX9N+bXFqN9fIRVmBUyWa+qqTSREA4uVAtYcRT
 lfPE2OQ7aMFxaYPwo+/z5SLpu8HcEhN/FG9uIkfYwK0mdCO0vgvlfvBJm4VHe7C6vyAeEPJQ
 DKbBvdgeqFqO+PsLkk2sawF/9sontMJ5iFfjNDj4UeAo4VsdlduTBZv5hHFvIbv/p7jKH6OT
 90FsgUSVbShh7SH5OzAcgqSy4kxuS1AHizWo6P3f9vei987LZWTyhuEuhJsOfivDsjKIq7qQ
 c5eR+JJtyLEA0Jt4cQGhpzHtWB0yB3XxXzHVa4QUp00BNVWyiJ/t9JHT4S5mdyLfcKm7ddc9
Message-ID: <7c38961f-4ad6-f4b8-7ef1-b43a07353832@gmail.com>
Date:   Fri, 6 Jul 2018 15:01:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <5c47ef70-b90e-6e81-39dd-fbcfad2b93e5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kexec works for me on T30 with the following kernel config options on top of the
tegra_defconfig:

CONFIG_SMP=n
CONFIG_CPU_IDLE=n
CONFIG_TEGRA_IOMMU_SMMU=n

CPU stopping isn't working correctly with the trusted foundations and it's not
obvious what is wrong. I hope we'll fix it at some point.
