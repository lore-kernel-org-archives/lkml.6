Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA4DC468C6
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CFB2087C
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="1gGaEd8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05CFB2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbeGNWjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 18:39:18 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45068 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731182AbeGNWjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 18:39:17 -0400
Received: by mail-lj1-f194.google.com with SMTP id q5-v6so27030615ljh.12
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 15:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7VQGpuRVC6Cv+ae2cugZgpnD4u/0CxWZRvUb0olgfQY=;
        b=1gGaEd8gLJFpEtAbfq2mToCKO4QGFqxPUsRFkdj/ZhzCUG86a3CX8CuQBLD4j/c05e
         ia2pNT4P6BpCSNX/7TeqQqiwwms37uv4ccQi7lAtQY4d0UqF/a6x0MlBNGJDCBMo8GN1
         s/dTw38m5+yW594yiYhrqpBFmxOL38xOnh6p0m7KeLmKlVGTdRHmrjkFxh5sOPq4m+1l
         hNJ6zddo5zrHmR/5Ow20LH686b9X246wxfvMJUwLhn0vEhmP3/GEB3W9uadOxhU+OuTH
         8A8Te/hk0/Db5m/lbPlcPSn5gM6oVWkyiw9rRQ7MyYxHbAbBr1DoGl9iwuY5XixKT00O
         Fm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7VQGpuRVC6Cv+ae2cugZgpnD4u/0CxWZRvUb0olgfQY=;
        b=HL7SZKqAlRZ2UIg1re0QT6UsAANo2sTYjiNfi4J4IjG2JVN9rQZJI2qKhAjOEcUqth
         2yHtZ0vMe9nxRu0G94gpVqMo+RDJJzTv/XsXeTZlg22jRKcb9FipUrhCbq+fwhaKA0gV
         wFW+x8Le2qpdafqvhnJZSMaYuMSckOqIXrK9BTpnt7iNo7lWD6fyIws/QxIAYGhsAPDV
         t/k/csl+BvA9ZdqyajKeyBlgvbupiWyBzwSf9qdoxf26rsP7ATnVm/I/abr1Bsa/IGkx
         iLms2ZUAVbHDBu70W3j9N8VfavfyqnHCNdH4dMxdi7e4vL0pv6mizfzKPg/ikZUq8bQF
         BMRg==
X-Gm-Message-State: AOUpUlGFhMktXfeiPpzFTir36XzfhRMOMiPQzJjyj+vjRoCw21+P3ICM
        mxHgy4OtVepAG8MUrQzouDiLEw==
X-Google-Smtp-Source: AAOMgpcKgDO1lGL3A6QiwLJZuR7PboZjo1uCF2nVWe9SB1e/AFs1kxXO+Yf9vK56M0BmRfDuk6J3DA==
X-Received: by 2002:a2e:7113:: with SMTP id m19-v6mr6285571ljc.66.1531606725233;
        Sat, 14 Jul 2018 15:18:45 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id r22-v6sm2291547ljh.22.2018.07.14.15.18.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Jul 2018 15:18:43 -0700 (PDT)
Date:   Sat, 14 Jul 2018 14:24:12 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 2/3] arm64: dts: exynos: Pull for v4.19
Message-ID: <20180714212412.k5obqk64gscp6hyz@localhost>
References: <20180712164641.19925-1-krzk@kernel.org>
 <20180712164641.19925-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712164641.19925-4-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 06:46:41PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> Rebased on v4.18-rc2.
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:
> 
>   Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.19
> 
> for you to fetch changes up to 17aa1530f1ff89ca4e21765e5f4d9e6bcd464eb2:
> 
>   arm64: dts: exynos: Remove leading 0x from unit addresses in Exynos5433 (2018-06-25 18:38:49 +0200)


Merged, thanks!


-Olof
