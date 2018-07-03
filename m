Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFC7C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B29A208EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CbWc4RWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B29A208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932328AbeGCWdg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:33:36 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42037 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752775AbeGCWdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:33:33 -0400
Received: by mail-wr0-f193.google.com with SMTP id p1-v6so3414736wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 15:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YiWIuy12HqVyVTSsfeFjev9/agn/UE+521prPJliI1s=;
        b=CbWc4RWwFn1b+btax1LCBfN4/WHSa6W5UvRsaxIxjVVyv9JgsqFwKO+knMPjgj1XyK
         IgFzhdwwe1/ZxYaFaZPAgYxC/UxpceHqwT3xEhFZKk3pGkWIX9a/9b43//UwZqHz8x4I
         qpevqbh68/3B+R9xFj8agb+cWJVuE53osl8l0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YiWIuy12HqVyVTSsfeFjev9/agn/UE+521prPJliI1s=;
        b=cM0lu/71Dczge2rvpePZJ/7lR4rhSiyVHVi++3BBldTlwSeN8kW5FZPk3ZbqPtb6j2
         /e48OaBcyQuKZNPBcQoY5pjHR8Jf6juh7dOHxgXTZ5E5t67LrtLshBQXCYzQVv2OrKKH
         K/g8NhylEr6yKAtChAidRrM8k+wcZy94cyBYTFdwwU4EzzW7kaaXNe3LHaYRajP26SV4
         CbtDrsvnYRygpB/L7hY09AIimLpmGekyNMQEO7Zw1IV96gYYUD+uNAUJ9LO/BM/1/My8
         kRTepJGNz7PSDTrdrUG34/3LCz9clrm8qsjJdQN+vLZ5fdgDlPlme3xiOtZXjhlAFveV
         BMLg==
X-Gm-Message-State: APt69E13dpAQxADogBHn41Tvfckgml221lIDgKDLEMrexCMFTWxA+ftN
        osUArTHFvT62bxaMLZUr9wVFkIxfd0uj9iro1M5VoA==
X-Google-Smtp-Source: AAOMgpf4tKFkIL04p6W4EzM9CZ9ZoaYL+aLvLreOql75cdBO7LDQg2AYzHS0o/NOfGTtIEFh7tkObdP1GY+wY4Sf27A=
X-Received: by 2002:a5d:4b50:: with SMTP id w16-v6mr3802278wrs.87.1530657212571;
 Tue, 03 Jul 2018 15:33:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c202:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 15:33:31 -0700 (PDT)
In-Reply-To: <20180702093547.39507-2-liwei213@huawei.com>
References: <20180702093547.39507-1-liwei213@huawei.com> <20180702093547.39507-2-liwei213@huawei.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 3 Jul 2018 15:33:31 -0700
Message-ID: <CALAqxLUMcsAe4mLakRxewtE_9A0mSzxgZR76nCaQQyUt4HZVVA@mail.gmail.com>
Subject: Re: [PATCH v11 1/4] scsi: ufs: add Hisilicon ufs driver code
To:     Li Wei <liwei213@huawei.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        yamada.masahiro@socionext.com,
        Riku Voipio <riku.voipio@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-scsi@vger.kernel.org, zangleigang@hisilicon.com,
        gengjianfeng@hisilicon.com,
        "Sunzhaosheng Sun(Zhaosheng)" <sunzhaosheng@hisilicon.com>,
        Ian Rickards <ian.rickards@arm.com>,
        Guodong Xu <guodong.xu@linaro.org>,
        Feng Chen <puck.chen@hisilicon.com>,
        "Fengbaopeng (kevin, Kirin Solution Dept)" 
        <fengbaopeng@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 2:35 AM, Li Wei <liwei213@huawei.com> wrote:
> add Hisilicon ufs driver code.
>
> Signed-off-by: Li Wei <liwei213@huawei.com>
> Signed-off-by: Geng Jianfeng <gengjianfeng@hisilicon.com>
> Signed-off-by: Zang Leigang <zangleigang@hisilicon.com>
> Signed-off-by: Yu Jianfeng <steven.yujianfeng@hisilicon.com>

Tested-by: John Stultz <john.stultz@linaro.org>

So this patchset has been floating around for over a year now. Can I
nudge someone to pick it up?

thanks
-john
